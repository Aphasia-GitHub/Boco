/********************************************************
* ProcName   : PROC_UPDATE_GROUP_CELL
* Auther     : maojun1@boco.com.cn   2015-6-8
* Remarks    : 新增刷区县网元组功能 by zhengfei 2015-12-19 
* Copyright (c) 2015 BOCO Group All Rights Reserved
********************************************************/
CREATE OR REPLACE PROCEDURE PROC_UPDATE_GROUP_CELL IS
  TYPE t_group IS REF CURSOR; --定义游标变量类型
  v_cursorvar         t_group; --声明游标变量
  v_group_id          c_tco_group_cell.group_id%TYPE;
  v_related_view      c_tco_group_cell.related_view%TYPE;
  v_tableExist        number;
  v_isExistDataSql    varchar2(200);
  v_isExistDataInView number;
BEGIN

--------------根据试图更新网元组小区 begin----------------------------------

  OPEN v_cursorvar FOR
    SELECT group_id, related_view
      FROM c_tco_group_cell
     where related_view is not null;

  LOOP
    FETCH v_cursorvar
      INTO v_group_id, v_related_view;

    EXIT WHEN v_cursorvar%NOTFOUND;

    select count(1)
      into v_tableExist
      from user_views
     where VIEW_NAME = upper(v_related_view);

    IF v_tableExist > 0 THEN

      v_isExistDataSql := 'select count(1) from ' || v_related_view;
      execute immediate v_isExistDataSql
        INTO v_isExistDataInView;

      IF v_isExistDataInView > 0 THEN

        delete from c_tco_group_detail where group_id = v_group_id;

        execute immediate 'insert into c_tco_group_detail select ' ||
                          v_group_id || 'as group_id ,a.* from ' ||
                          v_related_view || ' a';
        commit;
      END IF;
    END IF;
  END LOOP;
---------------根据试图更新网元组小区 end-----------------------------------------

---------------根据更新网格网元组小区 begin-----------------------------------------
---删除不存扇区关联的网元组
execute immediate 'DELETE FROM C_TCO_GROUP_CELL g1 WHERE g1.SOURCE_TYPE = 1'||
'AND NOT EXISTS (SELECT 1 FROM C_TCO_PRO_CELL CELL WHERE g1.SOURCE_ID = GRID_ID)';
commit;

---补充未添加过的网元组
execute immediate 'INSERT INTO C_TCO_GROUP_CELL
SELECT ROWNUM + A.MAXNUM GROUP_ID ,
GROUP_NAME,GROUP_TYPE,DESCRIPTION,NEVISIBILITY,CREATE_USER,REGION_NAME,RELATED_VIEW,SOURCE_TYPE,SOURCE_ID
 FROM (
SELECT DISTINCT MAXNUM.MAXNUM , PROVINCE.PROVINCE_NAME ||''_''||GRID.CITY_NAME ||''_''|| GRID.DEP_NAME GROUP_NAME,
GRID.CITY_NAME  ||''_化小市场网格'' GROUP_TYPE,
 NULL DESCRIPTION,
 ''UserAuthed'' NEVISIBILITY,
 ''Admin'' CREATE_USER,
 GRID.CITY_NAME REGION_NAME,
 NULL RELATED_VIEW,
 1 SOURCE_TYPE,
 GRID.GRID_NO SOURCE_ID
 FROM TCO_PRO_GRID  GRID
JOIN C_TCO_PRO_CELL  CELL ON GRID.GRID_NO = CELL.GRID_ID
CROSS JOIN (SELECT MAX(GROUP_ID) MAXNUM FROM C_TCO_GROUP_CELL  ) MAXNUM
CROSS JOIN (SELECT MIN(PROVINCE_NAME) PROVINCE_NAME FROM C_REGION_CITY) PROVINCE
WHERE NOT EXISTS  (SELECT 1 FROM C_TCO_GROUP_CELL g1 WHERE g1.SOURCE_ID = GRID.GRID_NO)) A';

COMMIT;

--------更新扇区数据-------------

execute immediate 'DELETE
 FROM C_TCO_GROUP_DETAIL DETAIL
WHERE EXISTS ( SELECT 1 FROM C_TCO_GROUP_CELL G WHERE DETAIL.GROUP_ID = G.GROUP_ID AND G.SOURCE_TYPE =1)';

COMMIT;

execute immediate 'INSERT INTO C_TCO_GROUP_DETAIL(GROUP_ID,INT_ID,CELL_NAME)
SELECT G.GROUP_ID,C.INT_ID,C.NAME FROM C_TCO_GROUP_CELL G
JOIN TCO_PRO_GRID G ON G.SOURCE_ID = G.GRID_NO
JOIN C_TCO_PRO_CELL C ON G.GRID_NO = C.GRID_ID
WHERE G.SOURCE_TYPE = 1';
COMMIT;

---------------根据更新网格网元组小区 END-----------------------------------------


---------------更新室分信源小区-----------------------------------------
execute immediate 'DELETE
 FROM C_TCO_GROUP_DETAIL DETAIL
WHERE EXISTS ( SELECT 1 FROM C_TCO_GROUP_CELL G WHERE DETAIL.GROUP_ID = G.GROUP_ID AND G.SOURCE_TYPE =2)';

execute immediate 'INSERT INTO C_TCO_GROUP_DETAIL(GROUP_ID,INT_ID,CELL_NAME)
SELECT DISTINCT G.GROUP_ID, C.INT_ID, C.NAME
  FROM C_TCO_GROUP_CELL G
  JOIN C_TCO_PRO_INDOORS INDOOR ON TO_CHAR(G.SOURCE_ID) = INDOOR.REGION_ID
  JOIN C_TCO_PRO_CELL C
    ON INDOOR.RELATED_CELL = C.INT_ID
 WHERE G.SOURCE_TYPE = 2';

COMMIT;

---------------更新直放站信源小区-----------------------------------------
execute immediate 'DELETE
 FROM C_TCO_GROUP_DETAIL DETAIL
WHERE EXISTS ( SELECT 1 FROM C_TCO_GROUP_CELL G WHERE DETAIL.GROUP_ID = G.GROUP_ID AND G.SOURCE_TYPE =3)';

execute immediate 'INSERT INTO C_TCO_GROUP_DETAIL(GROUP_ID,INT_ID,CELL_NAME)
 SELECT DISTINCT G.GROUP_ID, C.INT_ID, C.NAME
  FROM C_TCO_GROUP_CELL G
  JOIN C_TCO_PRO_REPEATER REPEATER ON TO_CHAR(G.SOURCE_ID) = REPEATER.REGION_ID
  JOIN C_TCO_PRO_CELL C
    ON REPEATER.RELATED_CELL = C.INT_ID
 WHERE G.SOURCE_TYPE = 3';

COMMIT;


---------------更新区县粒度网元组小区-------------------------------------
DBMS_OUTPUT.PUT_LINE('===更新区县粒度网元组小区开始===');
execute immediate 'DELETE FROM C_TCO_GROUP_DETAIL DETAIL
WHERE EXISTS ( SELECT 1 FROM C_TCO_GROUP_CELL G WHERE DETAIL.GROUP_ID = G.GROUP_ID AND G.SOURCE_TYPE =4)';
execute immediate 'DELETE FROM C_TCO_GROUP_CELL G WHERE G.SOURCE_TYPE =4';

-- 插入 C_TCO_GROUP_CELL
INSERT INTO C_TCO_GROUP_CELL
 (GROUP_ID,GROUP_NAME,GROUP_TYPE,NEVISIBILITY,CREATE_USER,REGION_NAME,SOURCE_TYPE)
SELECT RC.CITY_ID,
      (RC.REGION_NAME || '_' || RC.CITY_NAME || '_网格') AS GROUP_NAME,
      '区县_网格' AS GROUP_TYPE,
      'UserAuthed' AS NEVISIBILITY,
      'Admin' AS CREATE_USER,
      RC.REGION_NAME AS REGION_NAME,
      4 AS SOURCE_TYPE
 FROM C_REGION_CITY RC
WHERE CITY_ID IN (SELECT DISTINCT CITY_ID FROM C_TCO_PRO_CELL);

-- 插入 C_TCO_GROUP_DETAIL
execute immediate 'INSERT INTO C_TCO_GROUP_DETAIL(GROUP_ID,INT_ID,CELL_NAME)
 SELECT DISTINCT G.GROUP_ID, C.INT_ID, C.NAME
  FROM C_TCO_GROUP_CELL G
  JOIN C_TCO_PRO_CELL C
    ON G.GROUP_ID = C.City_Id
 WHERE G.SOURCE_TYPE = 4';
 
COMMIT;

DBMS_OUTPUT.PUT_LINE('===更新区县粒度网元组小区结束===');

END;
