CREATE OR REPLACE PROCEDURE proc_inforspot_testresult(workOrderCode  varchar2,
                                                        submitDateTime date,
                                                        inforspotCode    varchar2,
                                                        testTypeId     number,
                                                        testResult     varchar2,
                                                        testDateTime   date) IS
  workOrderID  number := 0; --工单ID
  inforspotID  number := 0; --信息点ID
  testCategory varchar2(50); --测试类型 2G 或者 3G

BEGIN
  SELECT id
    INTO workOrderID
    FROM TAP_WO_BASEINFO
   WHERE CODE = workOrderCode;

  IF workOrderID != 0 THEN
    BEGIN

      IF inforspotCode is  null  THEN
        inforspotID := -1;
      ELSE
        SELECT int_id
          INTO inforspotID
          FROM C_TCO_PRO_INFORSPOT
         WHERE inforspot_id = inforspotCode;
      END IF;

      INSERT INTO TAP_WO_TESTRESULT
        (wo_id,
         submit_datetime,
         inforspot_id,
         test_type_id,
         result,
         test_datetime)
      values
        (workOrderID,
         submitDateTime,
         inforspotID,
         testTypeId,
         testResult,
         testDateTime);

        SELECT CATEGORY
          INTO testCategory
          FROM TAP_TEST_TYPE
         WHERE TEST_TYPE_ID = testTypeId;

      IF testCategory = '2G' THEN
        UPDATE C_TCO_PRO_INFORSPOT
           SET signal2g = testResult,recenttime2g = testDateTime
         WHERE (recenttime2g IS NULL OR recenttime2g < testDateTime)
           AND int_id = inforspotID;
      ELSIF testCategory = '3G' THEN
        UPDATE C_TCO_PRO_INFORSPOT
           SET signal3g = testResult,recenttime3g = testDateTime
         WHERE (recenttime3g IS NULL OR recenttime3g < testDateTime)
           AND int_id = inforspotID;
        --k.signal2g,k.recenttime2g,k.signal3g,k.recenttime3g
      END IF;
      --RETURN;
    END;
  END IF;
  COMMIT;
END;
