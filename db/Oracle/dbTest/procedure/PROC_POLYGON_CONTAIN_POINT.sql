CREATE OR REPLACE PROCEDURE PROC_POLYGON_CONTAIN_POINT(IN_LONGITUDE   IN NUMBER,
                                                       IN_LATITUDE    IN NUMBER,
                                                       IN_REGION_NAME IN VARCHAR2, --区县名称
                                                       GRID_NO        OUT VARCHAR2 --返回网格编号
                                                       ) AS
  --判断一个点和多边形的包含关系，在网格内返回编号，不在网格内返回空值
  --convert by wangyuanwei 20150813
  VAR_COUNT            INTEGER := 0; --相交点的个数
  VAR_CENTRAL_MERIDIAN NUMBER := 117; --地市中央经度,默认117
  VAR_POINTS_ARRAY     T_RET_TABLE; --split后的collection
  VAR_LONLAT_ARRAY     T_LONLAT_ARRAY; --二维数组
  VAR_LONLAT_ROW       T_LONLAT_ARRAY_OBJ; --二维数组类型（经纬度）
  VAR_INDEX            INTEGER := 1; --var_POINTS_LIST 的下标，从1开始
  VAR_LONGITUDE        NUMBER(38, 8);
  VAR_LATITUDE         NUMBER(38, 8);
  VAR_NEXT_LONGITUDE   NUMBER(38, 8);
  VAR_NEXT_LATITUDE    NUMBER(38, 8);
  VAR_MAX_LONGITUDE    NUMBER(38, 8);
  VAR_MAX_LATITUDE     NUMBER(38, 8);
  VAR_MIN_LONGITUDE    NUMBER(38, 8);
  VAR_MIN_LATITUDE     NUMBER(38, 8);
  VAR_Y_FACTOR         NUMBER(38, 8); --计算系数，数值在0到1之间
  VAR_FLAG             INTEGER := DBMS_RANDOM.RANDOM; --随机数，标记一次执行

BEGIN

  DECLARE

    CURSOR C_GRID IS
      SELECT *
        FROM TCO_PRO_GRID_150731NEW
       WHERE CITY_NAME = IN_REGION_NAME;
    C_GRID_ROW C_GRID%ROWTYPE;

  BEGIN
    --debug log
    INSERT INTO POLYGON_CONTAIN_POINT_LOG
      (FLAG, LOG_DATE, LOG_DETAIL)
    VALUES
      (VAR_FLAG,
       TO_CHAR(SYSTIMESTAMP, 'yyyy-mm-dd hh24:mi:ssff4'),
       '====开始寻找' || IN_REGION_NAME || '内经度：' || IN_LONGITUDE || ',纬度:' ||
       IN_LATITUDE || '.的网格.....');
    COMMIT;

    --var_count 临时判断下是否有该地市数据
    SELECT COUNT(1)
      INTO VAR_COUNT
      FROM C_REGION_CITY
     WHERE CITY_NAME = IN_REGION_NAME
       AND REGION_NAME = '\';
    IF VAR_COUNT > 0 THEN
      SELECT CENTRAL_MERIDIAN
        INTO VAR_CENTRAL_MERIDIAN
        FROM C_REGION_CITY
       WHERE CITY_NAME = IN_REGION_NAME
         AND REGION_NAME = '\';
    END IF;

    --循环该city下每个grid
    FOR C_GRID_ROW IN C_GRID LOOP

      VAR_LONLAT_ARRAY := T_LONLAT_ARRAY(); --数组使用前必须要初始化
      VAR_POINTS_ARRAY := F_SPLIT_STRING(C_GRID_ROW.COORDINATE_COLLEC, ','); --split后的一维数组
      VAR_COUNT        := 0; --初始化置0
      VAR_INDEX        := 1; -- 下标从1开始

      --将split后的一维数组转化成二维数组(经度，纬度)
      FOR VAR_INDEX IN 1 .. VAR_POINTS_ARRAY.COUNT LOOP
        VAR_LONGITUDE  := TO_NUMBER(F_SPLIT_STRING(VAR_POINTS_ARRAY(VAR_INDEX),
                                                   ' ') (1));
        VAR_LATITUDE   := TO_NUMBER(F_SPLIT_STRING(VAR_POINTS_ARRAY(VAR_INDEX),
                                                   ' ') (2));
        VAR_LONLAT_ROW := NEW
                          T_LONLAT_ARRAY_OBJ(VAR_LONGITUDE, VAR_LATITUDE);

        VAR_LONLAT_ARRAY.EXTEND; --必须要指定，否则提示超出下标
        VAR_LONLAT_ARRAY(VAR_INDEX) := VAR_LONLAT_ROW;
      END LOOP;

      --找出最大、最小经纬度
      SELECT MAX(LONGITUDE)
        INTO VAR_MAX_LONGITUDE
        FROM TABLE(VAR_LONLAT_ARRAY);
      SELECT MIN(LONGITUDE)
        INTO VAR_MIN_LONGITUDE
        FROM TABLE(VAR_LONLAT_ARRAY);
      SELECT MAX(LATITUDE)
        INTO VAR_MAX_LATITUDE
        FROM TABLE(VAR_LONLAT_ARRAY);
      SELECT MIN(LATITUDE)
        INTO VAR_MIN_LATITUDE
        FROM TABLE(VAR_LONLAT_ARRAY);

      --debug log
      INSERT INTO POLYGON_CONTAIN_POINT_LOG
        (FLAG, LOG_DATE, LOG_DETAIL)
      VALUES
        (VAR_FLAG,
         TO_CHAR(SYSTIMESTAMP, 'yyyy-mm-dd hh24:mi:ssff4'),
         '网格' || C_GRID_ROW.GRID_NO || ',经度范围:(' || VAR_MIN_LONGITUDE || ',' ||
         VAR_MAX_LONGITUDE || '),纬度范围:(' || VAR_MIN_LATITUDE || ',' ||
         VAR_MAX_LATITUDE || ')');
      COMMIT;

      --判断是否超出范围
      IF IN_LONGITUDE > VAR_MAX_LONGITUDE OR
         IN_LONGITUDE < VAR_MIN_LONGITUDE OR IN_LATITUDE > VAR_MAX_LATITUDE OR
         IN_LATITUDE < VAR_MIN_LATITUDE THEN
        VAR_COUNT := -1;
      END IF;

      --循环每条边求交点
      IF VAR_COUNT <> -1 THEN
        FOR VAR_INDEX IN 1 .. VAR_LONLAT_ARRAY.COUNT LOOP
          IF VAR_INDEX + 1 = VAR_LONLAT_ARRAY.COUNT THEN
            -- 到头了
            RETURN;
          END IF;
          VAR_LONGITUDE      := VAR_LONLAT_ARRAY(VAR_INDEX).LONGITUDE;
          VAR_LATITUDE       := VAR_LONLAT_ARRAY(VAR_INDEX).LATITUDE;
          VAR_NEXT_LONGITUDE := VAR_LONLAT_ARRAY(VAR_INDEX + 1).LONGITUDE;
          VAR_NEXT_LATITUDE  := VAR_LONLAT_ARRAY(VAR_INDEX + 1).LATITUDE;

          --由V[i] 和 V[i+1]顶点构成的边
          IF (((VAR_LATITUDE <= IN_LATITUDE) AND
             (VAR_NEXT_LATITUDE > IN_LATITUDE)) OR
             ((VAR_LATITUDE > IN_LATITUDE) AND
             (VAR_NEXT_LATITUDE <= IN_LATITUDE))) THEN

            --说明要判断的这个顶点Y数值在多边形这条边的两个端点Y轴数值之间
            VAR_Y_FACTOR := ROUND((IN_LATITUDE - VAR_LATITUDE) /
                                  (VAR_NEXT_LATITUDE - IN_LATITUDE),
                                  8);

            --说明此顶点在平行于X轴的平行线：y=P.y和与此条边的交点的右侧
            IF IN_LONGITUDE <
               (VAR_LONGITUDE * (VAR_NEXT_LONGITUDE - VAR_LONGITUDE)) THEN
              --说明要判断的这个顶点与多边形这条边是相交的，计数器加1
              VAR_COUNT := VAR_COUNT + 1;
              --debug log
              INSERT INTO POLYGON_CONTAIN_POINT_LOG
                (FLAG, LOG_DATE, LOG_DETAIL)
              VALUES
                (VAR_FLAG,
                 TO_CHAR(SYSTIMESTAMP, 'yyyy-mm-dd hh24:mi:ssff4'),
                 '++1');
              COMMIT;

            END IF;
          END IF;

        END LOOP;

        IF VAR_COUNT = -1 THEN
          GRID_NO := '';
        ELSIF MOD(VAR_COUNT, 2) = 1 THEN
          GRID_NO := C_GRID_ROW.GRID_NO;
        ELSE
          GRID_NO := '';
        END IF;
      END IF;

    END LOOP; --end loop grid
  END;
END PROC_POLYGON_CONTAIN_POINT;
