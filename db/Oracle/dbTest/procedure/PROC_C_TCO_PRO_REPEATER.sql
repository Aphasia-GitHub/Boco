CREATE OR REPLACE PROCEDURE PROC_C_TCO_PRO_REPEATER AS
  V_COUNTER NUMBER;
BEGIN

  DECLARE
    CURSOR C_JOB IS
      SELECT A.ROWID,
             BTS.BTS_CODE,
             CELL.CI,
             CELL.CELLID,
             CELL.PN,
             CELL.LAC,
             B.REGION_NAME,
             CELL.ZH_NAME
        FROM C_TCO_PRO_REPEATER A
       INNER JOIN C_REGION_CITY B
          ON A.CITY_ID = B.CITY_ID
        LEFT JOIN C_CELL CELL
          ON A.RELATED_CELL = CELL.INT_ID
        LEFT JOIN C_TCO_PRO_BTS BTS
          ON CELL.RELATED_BTS = BTS.INT_ID
       WHERE (CELL.LAC IS NOT NULL OR CELL.CI IS NOT NULL);
    --定义一个游标变量v_cinfo c_emp%ROWTYPE ，该类型为游标c_emp中的一行数据类型
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    V_COUNTER := 0;
    FOR C_ROW IN C_JOB LOOP

      UPDATE C_TCO_PRO_REPEATER A
         SET A.BTS_CODE  = C_ROW.BTS_CODE,
             A.CI        = C_ROW.CI,
             A.CELL_NO   = C_ROW.CELLID,
             A.PN        = C_ROW.PN,
             A.LAC       = C_ROW.LAC,
             A.CITY_NAME = C_ROW.REGION_NAME,
             A.CELL_NAME = C_ROW.ZH_NAME
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
