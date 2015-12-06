CREATE OR REPLACE PROCEDURE PROC_GET_OPTIMIZEWORK_CODE_LN --用于生成作业计划、工单的CODE
(region_id    in number,
 code_type    in number, --1 作业计划，2 工单,3 为在线问题类型
 returnString out varchar2) IS
  v_serialNum   number := 0; --序号
  v_strPart     varchar2(20) := '';
  v_province_id number := 0;
  v_region_id   number := 0;
  --v_lock     number :=0;
BEGIN
  /*  IF region_id = 20000 THEN
  returnString := 'W20150609LN';
  END IF;*/

  v_region_id := region_id;
  select min(province_id) INTO v_province_id from c_region_city;

  IF region_id = v_province_id THEN
    v_region_id := -1;
  END IF;

  --select * from TAP_WORKPLAN_CODESERIAL for update; --modify by maojun;锁住表

  select nvl(max(SERIALNUM), 0)
    into v_serialNum
    from TAP_WORKPLAN_CODESERIAL
   where regionid = v_region_id
     and codeType = code_type
     and codedate = trunc(sysdate);

  select to_char(SYSDATE, 'yyyyMMdd') || lpad(b.num, 3, 0) || pac
    into v_strPart
    from dual a,
         (select nvl(max(SerialNum), 0) + 1 num
            from TAP_WORKPLAN_CODESERIAL
           where regionid = v_region_id
             and codeType = code_type
             and codedate = trunc(sysdate)) b,
         (select max(region_pac) pac
            from c_region_city
           where REGION_ID = v_region_id) c;

  if v_serialNum = 0 then
    BEGIN
      insert into TAP_WORKPLAN_CODESerial
      values
        (trunc(sysdate), v_region_id, 1, code_type);
      commit;
    END;
  ELSE
    BEGIN
      update TAP_WORKPLAN_CODESerial
         set SERIALNUM = SERIALNUM + 1
       where regionID = v_region_id
         and CODEDate = trunc(sysdate)
         and Codetype = code_type;
      commit;
    END;
  END if;

  commit;

  IF code_type = 1 THEN
    returnString := 'P' || v_strPart; --作业计划
  ELSIF code_type = 2 THEN
    returnString := 'W' || v_strPart; --工单
  ELSIF code_type = 3 THEN
    returnString := 'I' || v_strPart; --在线问题
  END IF;
END;
