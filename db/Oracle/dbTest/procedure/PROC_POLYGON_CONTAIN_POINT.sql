CREATE OR REPLACE PROCEDURE PROC_POLYGON_CONTAIN_POINT(IN_LONGITUDE   IN NUMBER,
                                                       IN_LATITUDE    IN NUMBER,
                                                       IN_REGION_NAME IN VARCHAR2, --��������
                                                       GRID_NO        OUT VARCHAR2 --����������
                                                       ) AS
  --�ж�һ����Ͷ���εİ�����ϵ���������ڷ��ر�ţ����������ڷ��ؿ�ֵ
  --convert by wangyuanwei 20150813
  VAR_COUNT            INTEGER := 0; --�ཻ��ĸ���
  VAR_CENTRAL_MERIDIAN NUMBER := 117; --�������뾭��,Ĭ��117
  VAR_POINTS_ARRAY     T_RET_TABLE; --split���collection
  VAR_LONLAT_ARRAY     T_LONLAT_ARRAY; --��ά����
  VAR_LONLAT_ROW       T_LONLAT_ARRAY_OBJ; --��ά�������ͣ���γ�ȣ�
  VAR_INDEX            INTEGER := 1; --var_POINTS_LIST ���±꣬��1��ʼ
  VAR_LONGITUDE        NUMBER(38, 8);
  VAR_LATITUDE         NUMBER(38, 8);
  VAR_NEXT_LONGITUDE   NUMBER(38, 8);
  VAR_NEXT_LATITUDE    NUMBER(38, 8);
  VAR_MAX_LONGITUDE    NUMBER(38, 8);
  VAR_MAX_LATITUDE     NUMBER(38, 8);
  VAR_MIN_LONGITUDE    NUMBER(38, 8);
  VAR_MIN_LATITUDE     NUMBER(38, 8);
  VAR_Y_FACTOR         NUMBER(38, 8); --����ϵ������ֵ��0��1֮��
  VAR_FLAG             INTEGER := DBMS_RANDOM.RANDOM; --����������һ��ִ��

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
       '====��ʼѰ��' || IN_REGION_NAME || '�ھ��ȣ�' || IN_LONGITUDE || ',γ��:' ||
       IN_LATITUDE || '.������.....');
    COMMIT;

    --var_count ��ʱ�ж����Ƿ��иõ�������
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

    --ѭ����city��ÿ��grid
    FOR C_GRID_ROW IN C_GRID LOOP

      VAR_LONLAT_ARRAY := T_LONLAT_ARRAY(); --����ʹ��ǰ����Ҫ��ʼ��
      VAR_POINTS_ARRAY := F_SPLIT_STRING(C_GRID_ROW.COORDINATE_COLLEC, ','); --split���һά����
      VAR_COUNT        := 0; --��ʼ����0
      VAR_INDEX        := 1; -- �±��1��ʼ

      --��split���һά����ת���ɶ�ά����(���ȣ�γ��)
      FOR VAR_INDEX IN 1 .. VAR_POINTS_ARRAY.COUNT LOOP
        VAR_LONGITUDE  := TO_NUMBER(F_SPLIT_STRING(VAR_POINTS_ARRAY(VAR_INDEX),
                                                   ' ') (1));
        VAR_LATITUDE   := TO_NUMBER(F_SPLIT_STRING(VAR_POINTS_ARRAY(VAR_INDEX),
                                                   ' ') (2));
        VAR_LONLAT_ROW := NEW
                          T_LONLAT_ARRAY_OBJ(VAR_LONGITUDE, VAR_LATITUDE);

        VAR_LONLAT_ARRAY.EXTEND; --����Ҫָ����������ʾ�����±�
        VAR_LONLAT_ARRAY(VAR_INDEX) := VAR_LONLAT_ROW;
      END LOOP;

      --�ҳ������С��γ��
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
         '����' || C_GRID_ROW.GRID_NO || ',���ȷ�Χ:(' || VAR_MIN_LONGITUDE || ',' ||
         VAR_MAX_LONGITUDE || '),γ�ȷ�Χ:(' || VAR_MIN_LATITUDE || ',' ||
         VAR_MAX_LATITUDE || ')');
      COMMIT;

      --�ж��Ƿ񳬳���Χ
      IF IN_LONGITUDE > VAR_MAX_LONGITUDE OR
         IN_LONGITUDE < VAR_MIN_LONGITUDE OR IN_LATITUDE > VAR_MAX_LATITUDE OR
         IN_LATITUDE < VAR_MIN_LATITUDE THEN
        VAR_COUNT := -1;
      END IF;

      --ѭ��ÿ�����󽻵�
      IF VAR_COUNT <> -1 THEN
        FOR VAR_INDEX IN 1 .. VAR_LONLAT_ARRAY.COUNT LOOP
          IF VAR_INDEX + 1 = VAR_LONLAT_ARRAY.COUNT THEN
            -- ��ͷ��
            RETURN;
          END IF;
          VAR_LONGITUDE      := VAR_LONLAT_ARRAY(VAR_INDEX).LONGITUDE;
          VAR_LATITUDE       := VAR_LONLAT_ARRAY(VAR_INDEX).LATITUDE;
          VAR_NEXT_LONGITUDE := VAR_LONLAT_ARRAY(VAR_INDEX + 1).LONGITUDE;
          VAR_NEXT_LATITUDE  := VAR_LONLAT_ARRAY(VAR_INDEX + 1).LATITUDE;

          --��V[i] �� V[i+1]���㹹�ɵı�
          IF (((VAR_LATITUDE <= IN_LATITUDE) AND
             (VAR_NEXT_LATITUDE > IN_LATITUDE)) OR
             ((VAR_LATITUDE > IN_LATITUDE) AND
             (VAR_NEXT_LATITUDE <= IN_LATITUDE))) THEN

            --˵��Ҫ�жϵ��������Y��ֵ�ڶ���������ߵ������˵�Y����ֵ֮��
            VAR_Y_FACTOR := ROUND((IN_LATITUDE - VAR_LATITUDE) /
                                  (VAR_NEXT_LATITUDE - IN_LATITUDE),
                                  8);

            --˵���˶�����ƽ����X���ƽ���ߣ�y=P.y��������ߵĽ�����Ҳ�
            IF IN_LONGITUDE <
               (VAR_LONGITUDE * (VAR_NEXT_LONGITUDE - VAR_LONGITUDE)) THEN
              --˵��Ҫ�жϵ�����������������������ཻ�ģ���������1
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
