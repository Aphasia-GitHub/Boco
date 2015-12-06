CREATE OR REPLACE PROCEDURE PROC_C_TCO_PRO_BTS AS
  V_COUNTER NUMBER;
BEGIN
  DECLARE
    --从采集表中查出关联数据
    CURSOR C_JOB IS
      SELECT A.ROWID,
             RC.CITY_NAME, --地市名称
             CASE
               WHEN C_BTS.VENDOR_ID = 7 THEN
                '中兴'
               ELSE
                '阿朗'
             END AS VENDOR_NAME,
             C_BTS.VENDOR_BTSTYPE AS BTS_MODEL,
             (SELECT CELL.NID
                FROM C_CELL CELL
               WHERE CELL.RELATED_BTS = A.INT_ID
                 AND ROWNUM = 1) NID,
             (SELECT CELL.SID
                FROM C_CELL CELL
               WHERE CELL.RELATED_BTS = A.INT_ID
                 AND ROWNUM = 1) SID,
             C_BTS.MSC_NAME MSCID,
             C_BTS.BSC_NAME BSCID,
             C_BTS.CELL_CARRIER_NUM_1X,
             C_BTS.NUMCE,
             (SELECT CELL.LAC
                FROM C_CELL CELL
               WHERE CELL.RELATED_BTS = A.INT_ID
                 AND ROWNUM = 1) LAC,
             (SELECT CELL.LAC
                FROM C_CELL CELL
               WHERE CELL.RELATED_BTS = A.INT_ID
                 AND ROWNUM = 1) REG_ZONE,
             CASE
               WHEN C_BTS.VENDOR_ID = 7 THEN
                BTSDO.AN_ID
               ELSE
                CRNC.RNCID
             END RNC_ATTRIB
        FROM C_TCO_PRO_BTS A
        LEFT JOIN C_BTS C_BTS
          ON A.INT_ID = C_BTS.INT_ID
        LEFT JOIN C_REGION_CITY RC
          ON A.REGION_ID = RC.CITY_ID
        LEFT JOIN C_TZX_PAR_BTS_DO BTSDO
          ON C_BTS.INT_ID = BTSDO.INT_ID
        LEFT JOIN C_RNC CRNC
          ON C_BTS.RELATED_RNC = CRNC.INT_ID;

    --定义一个游标变量C_ROW c_emp%ROWTYPE ，该类型为游标C_JOB中的一行数据类型
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    V_COUNTER := 0;
    FOR C_ROW IN C_JOB LOOP
      UPDATE C_TCO_PRO_BTS A
         SET A.VENDOR_NAME = C_ROW.VENDOR_NAME,
             A.CITY_NAME   = C_ROW.CITY_NAME, --实际是地市名称
             A.DEVICE_TYPE = C_ROW.BTS_MODEL,
             A.NID         = C_ROW.NID,
             A.SID         = C_ROW.SID,
             A.MSC_NAME    = C_ROW.MSCID,
             A.BSC_NAME    = C_ROW.BSCID,
             A.BTS_MODEL   = C_ROW.CELL_CARRIER_NUM_1X,
             A.CHANNEL_NBR = C_ROW.NUMCE,
             A.LAC         = C_ROW.LAC,
             A.REG_ZON     = C_ROW.REG_ZONE,
             A.RELATED_RNC = C_ROW.RNC_ATTRIB
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
