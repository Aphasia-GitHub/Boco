CREATE OR REPLACE PROCEDURE PROC_C_TCO_PRO_INDOORS_1 AS
  V_COUNTER NUMBER;
BEGIN

  DECLARE
    CURSOR C_JOB IS
      SELECT A.ROWID,
             B.REGION_NAME,
             B.CITY_NAME,
             BTS.BTS_CODE,
             BTS.NAME AS BTS_NAME,
             C_CELL.CI,
             C_CELL.CELLID,
             C_CELL.PN,
             C_CELL.LAC,
             GETCELLWORKFREQ(GETCARRIERPOWER(283,
                                             TO_CHAR(C_CELL.INT_ID),
                                             C_CELL.VENDOR_ID),
                             GETCARRIERPOWER(201,
                                             TO_CHAR(C_CELL.INT_ID),
                                             C_CELL.VENDOR_ID),
                             GETCARRIERPOWER(242,
                                             TO_CHAR(C_CELL.INT_ID),
                                             C_CELL.VENDOR_ID),
                             GETCARRIERPOWER(160,
                                             TO_CHAR(C_CELL.INT_ID),
                                             C_CELL.VENDOR_ID),
                             GETCARRIERPOWER(37,
                                             TO_CHAR(C_CELL.INT_ID),
                                             C_CELL.VENDOR_ID),
                             GETCARRIERPOWER(78,
                                             TO_CHAR(C_CELL.INT_ID),
                                             C_CELL.VENDOR_ID),
                             GETCARRIERPOWER(119,
                                             TO_CHAR(C_CELL.INT_ID),
                                             C_CELL.VENDOR_ID),
                             GETCARRIERPOWER(1019,
                                             TO_CHAR(C_CELL.INT_ID),
                                             C_CELL.VENDOR_ID)) AS WORKFREQ
        FROM C_TCO_PRO_INDOORS A
       INNER JOIN C_REGION_CITY B
          ON A.CITY_ID = B.CITY_ID
        LEFT JOIN C_CELL C_CELL
          ON C_CELL.INT_ID = A.RELATED_CELL
        LEFT JOIN C_TCO_PRO_BTS BTS
          ON C_CELL.RELATED_BTS = BTS.INT_ID
       WHERE (C_CELL.LAC IS NOT NULL OR C_CELL.CI IS NOT NULL);

    C_ROW C_JOB%ROWTYPE;
  BEGIN
    V_COUNTER := 0;
    FOR C_ROW IN C_JOB LOOP

      UPDATE C_TCO_PRO_INDOORS A
         SET A.CITY_NAME   = C_ROW.REGION_NAME,
             A.COUNTY_NAME = C_ROW.CITY_NAME,
             A.BTS_CODE    = C_ROW.BTS_CODE,
             A.BTS_NAME    = C_ROW.BTS_NAME,
             A.CI          = C_ROW.CI,
             A.CELL_NO     = C_ROW.CELLID,
             A.PN          = C_ROW.PN,
             A.LAC         = C_ROW.LAC/*,
             A.WORKFREQ    = C_ROW.WORKFREQ*/
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
