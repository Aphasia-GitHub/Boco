CREATE OR REPLACE PROCEDURE PROC_C_TCO_PRO_CELL AS
  V_COUNTER      NUMBER;
  V_PROVINCE     NUMBER;
  V_NENGMENG_PRO NUMBER := 366691449;
BEGIN
  SELECT PROVINCE_ID INTO V_PROVINCE FROM C_REGION_CITY WHERE ROWNUM = 1;
  DECLARE
    --从采集表中查出关联数据
    CURSOR C_JOB IS
    --主扇区
      SELECT A.ROWID,
             B.REGION_NAME,
             B.CITY_NAME,
             C_CELL.MSC_NAME,
             C_CELL.BSC_NAME,
             C_CELL.CI,
             C_CELL.CELLID,
             CASE
               WHEN C_BTS.VENDOR_ID = 7 THEN
                C_CELL.NAME
               ELSE
                NVL(A.NAME, ' ')
             END NAME,
             CASE
               WHEN C_BTS.VENDOR_ID = 7 THEN
                TZX.BASE_LONG_B
               ELSE
                A.LONGITUDE
             END LONGITUDE,
             CASE
               WHEN C_BTS.VENDOR_ID = 7 THEN
                TZX.BASE_LAT_B
               ELSE
                A.LATITUDE
             END LATITUDE,
             CASE C_BTS.VENDOR_ID
               WHEN 7 THEN
                TO_CHAR(C_CELL.CI)
               ELSE
                TO_CHAR(C_BTS.BSSID) || '-' || TO_CHAR(C_BTS.BTSID) || '-' ||
                TO_CHAR(C_CELL.CELLID)
             END AS CELL_INDEX,
             C_CELL.PN,
             C_CELL.LAC,
             CASE
               WHEN C_CELL.VENDOR_ID = 7 THEN
                '中兴'
               ELSE
                '阿朗'
             END VENDOR_NAME,
             C_CELL.RRU_CELL,
             CASE
               WHEN C_BTS.VENDOR_ID = 10 THEN
                A.RRU_PN_CELL
               ELSE
                CASE
                  WHEN TZX.ISSAMEPNSECTOR IS NOT NULL THEN
                   CASE
                     WHEN TZX.ISSAMEPNSECTOR = 1 THEN
                      CASE
                        WHEN TZX.REFCELLID = C_CELL.CELLID THEN
                         '主'
                        ELSE
                         TO_CHAR(C_CELL.CI)
                      END
                     ELSE
                      '否'
                   END
                  ELSE
                   CASE
                     WHEN TZXDO.ISSAMEPNSECTOR = 1 THEN
                      CASE
                        WHEN TZXDO.REFCELLID = C_CELL.CELLID THEN
                         '主'
                        ELSE
                         TO_CHAR(C_CELL.CI)
                      END
                     ELSE
                      '否'
                   END
                END
             END MRRU_CELL,
             C_CELL.NUMFA AS CARRIER_1X,
             CASE C_CELL.DO_CELL
               WHEN 0 THEN
                '否'
               ELSE
                '是'
             END AS SECTOR_DO,
             C_CELL.NUMFA_DO AS CARRIER_DO,

             (SELECT COUNT(*)
                FROM C_TCO_PRO_REPEATER B
               WHERE B.RELATED_CELL = A.INT_ID) AS REPEATER_NUM,
             CASE
               WHEN V_PROVINCE != V_NENGMENG_PRO THEN --非内蒙，算法计算
                CASE
                  WHEN PRO_BTS.BTS_TYPE = '专用室分源' THEN
                   0.1
                  WHEN A.COVER_EARATYPE = '市区' THEN
                   0.2
                  WHEN A.COVER_EARATYPE = '县城' THEN
                   0.3
                  WHEN A.COVER_EARATYPE = '郊区' THEN
                   0.3
                  ELSE
                   0.5
                END
               ELSE --内蒙，直接取值
                A.CELL_RADIUS
             END AS CELL_RADIUS,
             CASE
               WHEN V_PROVINCE != V_NENGMENG_PRO THEN --非内蒙，算法计算
                CASE
                  WHEN A.COVER_EARATYPE = '市区' AND C_BTS.VENDOR_ID = 7 AND
                       C_BTS.VENDOR_BTSTYPE = 'CBTS I2' THEN
                   0.7
                  WHEN A.COVER_EARATYPE = '市区' THEN
                   0.8
                  WHEN (A.COVER_EARATYPE = '县城' OR A.COVER_EARATYPE = '郊区') AND
                       C_BTS.VENDOR_ID = 7 THEN
                   0.8
                  WHEN (A.COVER_EARATYPE = '县城' OR A.COVER_EARATYPE = '郊区') AND
                       C_BTS.VENDOR_ID = 10 THEN
                   1
                  WHEN A.COVER_EARATYPE = '平原农村' THEN
                   1.1
                  WHEN A.COVER_EARATYPE = '丘陵农村' THEN
                   0.7
                  WHEN A.COVER_EARATYPE = '水域农村' THEN
                   0.7344
                  WHEN A.COVER_EARATYPE = '山区农村' THEN
                   0.7839
                END
               ELSE --内蒙，直接取值
                A.BORDER_DALAY_TYPE
             END AS BORDER_DALAY_TYPE,
             CASE
               WHEN V_PROVINCE != V_NENGMENG_PRO THEN --非内蒙，算法计算
                CASE A.COVER_EARATYPE
                  WHEN '市区' THEN
                   700
                  WHEN '县城' THEN
                   1000
                  WHEN '郊区' THEN
                   2000
                  ELSE
                   3500
                END
               ELSE --内蒙，直接取值
                A.POSITION_M
             END AS POSITION_M,
             CASE A.COVER_EARATYPE
               WHEN '市区' THEN
                700
               WHEN '县城' THEN
                1000
               WHEN '郊区' THEN
                2000
               ELSE
                3500
             END AS POSITION_M_DO,
             C_BTS.BTSID,
             NVL(A.CELL_TYPE, PRO_BTS.BTS_TYPE) CELL_TYPE,
             NVL(A.DOWNTILT_ELECTR_PREPARE, 0) + NVL(A.DOWNTILT_ELECTR1, 0) AS DOWNTILT_ELECTR,
             NVL(A.DOWNTILT_ELECTR_PREPARE, 0) + NVL(A.DOWNTILT_ELECTR1, 0) +
             NVL(A.DOWNTILT_MECH, 0) AS DOWNTILT
        FROM C_TCO_PRO_CELL A
        LEFT JOIN C_TCO_PRO_BTS PRO_BTS
          ON A.RELATED_BTSID = PRO_BTS.INT_ID
       INNER JOIN C_REGION_CITY B
          ON A.CITY_ID = B.CITY_ID
        LEFT JOIN C_BTS C_BTS
          ON PRO_BTS.INT_ID = C_BTS.INT_ID
       INNER JOIN C_CELL C_CELL
          ON A.INT_ID = C_CELL.INT_ID
        LEFT JOIN C_TZX_PAR_CELL TZX
          ON (A.INT_ID = TZX.INT_ID)
        LEFT JOIN C_TZX_PAR_CELL_DO TZXDO
          ON (A.INT_ID = TZXDO.INT_ID)
      UNION ALL
      --功分扇区
      SELECT A.ROWID,
             B.REGION_NAME,
             B.CITY_NAME,
             C_CELL.MSC_NAME,
             C_CELL.BSC_NAME,
             C_CELL.CI,
             C_CELL.CELLID,
             CASE
               WHEN C_BTS.VENDOR_ID = 7 THEN
                C_CELL.NAME
               ELSE
                NVL(A.NAME, ' ')
             END NAME,
             CASE
               WHEN C_BTS.VENDOR_ID = 7 THEN
                TZX.BASE_LONG_B
               ELSE
                A.LONGITUDE
             END LONGITUDE,
             CASE
               WHEN C_BTS.VENDOR_ID = 7 THEN
                TZX.BASE_LAT_B
               ELSE
                A.LATITUDE
             END LATITUDE,
             CASE C_BTS.VENDOR_ID
               WHEN 7 THEN
                TO_CHAR(C_CELL.CI)
               ELSE
                TO_CHAR(C_BTS.BSSID) || '-' || TO_CHAR(C_BTS.BTSID) || '-' ||
                TO_CHAR(C_CELL.CELLID)
             END AS CELL_INDEX,
             C_CELL.PN,
             C_CELL.LAC,
             CASE
               WHEN C_CELL.VENDOR_ID = 7 THEN
                '中兴'
               ELSE
                '阿朗'
             END VENDOR_NAME,
             C_CELL.RRU_CELL,
             CASE
               WHEN C_BTS.VENDOR_ID = 10 THEN
                A.RRU_PN_CELL
               ELSE
                CASE
                  WHEN TZX.ISSAMEPNSECTOR IS NOT NULL THEN
                   CASE
                     WHEN TZX.ISSAMEPNSECTOR = 1 THEN
                      CASE
                        WHEN TZX.REFCELLID = C_CELL.CELLID THEN
                         '主'
                        ELSE
                         TO_CHAR(C_CELL.CI)
                      END
                     ELSE
                      '否'
                   END
                  ELSE
                   CASE
                     WHEN TZXDO.ISSAMEPNSECTOR = 1 THEN
                      CASE
                        WHEN TZXDO.REFCELLID = C_CELL.CELLID THEN
                         '主'
                        ELSE
                         TO_CHAR(C_CELL.CI)
                      END
                     ELSE
                      '否'
                   END
                END
             END MRRU_CELL,
             C_CELL.NUMFA AS CARRIER_1X,
             CASE C_CELL.DO_CELL
               WHEN 0 THEN
                '否'
               ELSE
                '是'
             END AS SECTOR_DO,
             C_CELL.NUMFA_DO AS CARRIER_DO,

             (SELECT COUNT(*)
                FROM C_TCO_PRO_REPEATER B
               WHERE B.RELATED_CELL = A.INT_ID) AS REPEATER_NUM,

             CASE
               WHEN V_PROVINCE != V_NENGMENG_PRO THEN --非内蒙，算法计算
                CASE
                  WHEN PRO_BTS.BTS_TYPE = '专用室分源' THEN
                   0.1
                  WHEN A.COVER_EARATYPE = '市区' THEN
                   0.2
                  WHEN A.COVER_EARATYPE = '县城' THEN
                   0.3
                  WHEN A.COVER_EARATYPE = '郊区' THEN
                   0.3
                  ELSE
                   0.5
                END
               ELSE --内蒙，直接取值
                A.CELL_RADIUS
             END AS CELL_RADIUS,
             CASE
               WHEN V_PROVINCE != V_NENGMENG_PRO THEN --非内蒙，算法计算
                CASE
                  WHEN A.COVER_EARATYPE = '市区' AND C_BTS.VENDOR_ID = 7 AND
                       C_BTS.VENDOR_BTSTYPE = 'CBTS I2' THEN
                   0.7
                  WHEN A.COVER_EARATYPE = '市区' THEN
                   0.8
                  WHEN (A.COVER_EARATYPE = '县城' OR A.COVER_EARATYPE = '郊区') AND
                       C_BTS.VENDOR_ID = 7 THEN
                   0.8
                  WHEN (A.COVER_EARATYPE = '县城' OR A.COVER_EARATYPE = '郊区') AND
                       C_BTS.VENDOR_ID = 10 THEN
                   1
                  WHEN A.COVER_EARATYPE = '平原农村' THEN
                   1.1
                  WHEN A.COVER_EARATYPE = '丘陵农村' THEN
                   0.7
                  WHEN A.COVER_EARATYPE = '水域农村' THEN
                   0.7344
                  WHEN A.COVER_EARATYPE = '山区农村' THEN
                   0.7839
                END
               ELSE --内蒙，直接取值
                A.BORDER_DALAY_TYPE
             END AS BORDER_DALAY_TYPE,
             CASE
               WHEN V_PROVINCE != V_NENGMENG_PRO THEN --非内蒙，算法计算
                CASE A.COVER_EARATYPE
                  WHEN '市区' THEN
                   700
                  WHEN '县城' THEN
                   1000
                  WHEN '郊区' THEN
                   2000
                  ELSE
                   3500
                END
               ELSE --内蒙，直接取值
                A.POSITION_M
             END AS POSITION_M,
             CASE A.COVER_EARATYPE
               WHEN '市区' THEN
                700
               WHEN '县城' THEN
                1000
               WHEN '郊区' THEN
                2000
               ELSE
                3500
             END AS POSITION_M_DO,
             C_BTS.BTSID,
             NVL(A.CELL_TYPE, PRO_BTS.BTS_TYPE) CELL_TYPE,
             NVL(A.DOWNTILT_ELECTR_PREPARE, 0) + NVL(A.DOWNTILT_ELECTR1, 0) AS DOWNTILT_ELECTR,
             NVL(A.DOWNTILT_ELECTR_PREPARE, 0) + NVL(A.DOWNTILT_ELECTR1, 0) +
             NVL(A.DOWNTILT_MECH, 0) AS DOWNTILT
        FROM C_TCO_PRO_CELL A
        LEFT JOIN C_TCO_PRO_BTS PRO_BTS
          ON A.RELATED_BTSID = PRO_BTS.INT_ID
       INNER JOIN C_REGION_CITY B
          ON A.CITY_ID = B.CITY_ID
        LEFT JOIN C_BTS C_BTS
          ON PRO_BTS.INT_ID = C_BTS.INT_ID
       INNER JOIN C_CELL C_CELL
          ON A.RELATED_CELLID = C_CELL.INT_ID
        LEFT JOIN C_TZX_PAR_CELL TZX
          ON (A.INT_ID = TZX.INT_ID)
        LEFT JOIN C_TZX_PAR_CELL_DO TZXDO
          ON (A.INT_ID = TZXDO.INT_ID);

    --定义一个游标变量C_ROW c_emp%ROWTYPE ，该类型为游标C_JOB中的一行数据类型
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    V_COUNTER := 0;
    FOR C_ROW IN C_JOB LOOP
      UPDATE C_TCO_PRO_CELL A
         SET A.COUNTY_NAME       = C_ROW.CITY_NAME,
             A.CITY_NAME         = C_ROW.REGION_NAME,
             A.MSC_NAME          = C_ROW.MSC_NAME,
             A.BSC_NAME          = C_ROW.BSC_NAME,
             A.CI                = C_ROW.CI,
             A.CELL_NO           = C_ROW.CELLID,
             A.NAME              = NVL(C_ROW.NAME, ' '),
             A.LONGITUDE         = C_ROW.LONGITUDE,
             A.LATITUDE          = C_ROW.LATITUDE,
             A.INDEX_VALUE       = C_ROW.CELL_INDEX,
             A.PN                = C_ROW.PN,
             A.LAC               = C_ROW.LAC,
             A.VENDOR_NAME       = C_ROW.VENDOR_NAME,
             A.RRU_CELL          = C_ROW.RRU_CELL,
             A.RRU_PN_CELL       = C_ROW.MRRU_CELL,
             A.CARRIER_NBR       = C_ROW.CARRIER_1X,
             A.SECTOR_DO         = C_ROW.SECTOR_DO,
             A.DO_CELL           = C_ROW.SECTOR_DO,
             A.DO_CARRIER_NBR    = C_ROW.CARRIER_DO,
             A.REPEATER_NBR      = C_ROW.REPEATER_NUM,
             A.CELL_RADIUS       = C_ROW.CELL_RADIUS,
             A.BORDER_DALAY_TYPE = C_ROW.BORDER_DALAY_TYPE,
             A.POSITION_M        = C_ROW.POSITION_M,
             A.POSITION_M_DO     = C_ROW.POSITION_M_DO,
             A.BTS_CODE          = C_ROW.BTSID,
             A.CELL_TYPE         = C_ROW.CELL_TYPE,
             A.DOWNTILT_ELECTR   = C_ROW.DOWNTILT_ELECTR,
             A.DOWNTILT          = C_ROW.DOWNTILT
       WHERE ROWID = C_ROW.ROWID;
      V_COUNTER := V_COUNTER + 1;
      IF (V_COUNTER > 1000) THEN
        COMMIT;
        V_COUNTER := 0;
      END IF;
    END LOOP;
    COMMIT;
  END;
END;
