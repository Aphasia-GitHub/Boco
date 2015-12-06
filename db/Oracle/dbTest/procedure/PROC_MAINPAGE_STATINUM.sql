CREATE OR REPLACE PROCEDURE PROC_MAINPAGE_STATINUM AS
BEGIN

  DELETE FROM C_MAINPAGE_NUM
   WHERE STATITIME = TO_CHAR(SYSDATE, 'yyyy-MM-dd');
  --统计新站入网数据Start
  DECLARE
    CURSOR C_JOB IS
      SELECT BTS.INT_ID AS INT_ID, BTS.REGION_ID AS REGION_ID
        FROM C_TCO_PRO_BTS BTS
       WHERE BTS.INT_ID IN (SELECT DISTINCT RELATED_ID
                              FROM TAP_AUDIT
                             WHERE OPERATIONTYPE = '新增'
                               AND DBTABLE = 'c_tco_pro_bts'
                               AND AUDITSTATUS = '通过'
                               AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                               AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID)
        VALUES
          ('BtsNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID);
        COMMIT;
      END;
    END LOOP;
  END;
  --统计新站入网数据End

  --统计新站入网关联规划库数据Start
  DECLARE
    CURSOR C_JOB IS
      SELECT SURBTS.MARK_ID   AS INT_ID,
             SURBTS.REGION_ID AS REGION_ID,
             BTS.INT_ID       AS RELATED_ID
        FROM C_TCO_PRO_SURVEY_BTS SURBTS
        LEFT JOIN C_TCO_PRO_BTS BTS
          ON BTS.PROJECT_ID = SURBTS.UNSTATION_NO
       WHERE SURBTS.UNSTATION_NO IN
             (SELECT BTS.PROJECT_ID
                FROM C_TCO_PRO_BTS BTS
               WHERE BTS.INT_ID IN
                     (SELECT DISTINCT RELATED_ID
                        FROM TAP_AUDIT
                       WHERE OPERATIONTYPE = '新增'
                         AND DBTABLE = 'c_tco_pro_bts'
                         AND AUDITSTATUS = '通过'
                         AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                         AND AUDITTIME <= SYSDATE))
         AND SURBTS.MARK_ID NOT IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE (OPERATIONTYPE = '新增' OR OPERATIONTYPE = '修改')
                 AND DBTABLE = 'c_tco_pro_survey_bts'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID, RELATED_ID)
        VALUES
          ('BtsSurNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID,
           C_ROW.RELATED_ID);
        COMMIT;
      END;
    END LOOP;
  END;
  --统计新站入网关联规划库数据End

  --统计新站入网关联质量问题数据Start
  DECLARE
    CURSOR C_JOB IS
      SELECT COVER.MARK_ID   AS INT_ID,
             COVER.REGION_ID AS REGION_ID,
             BTS.INT_ID      AS RELATED_ID
        FROM C_TCO_PRO_COVER_BENCHMARK COVER
        LEFT JOIN C_TCO_PRO_BTS BTS
          ON BTS.PROJECT_ID = COVER.ADJUST_SCHEME_ID
       WHERE COVER.ADJUST_SCHEME_ID IN
             (SELECT DISTINCT BTS.PROJECT_ID
                FROM C_TCO_PRO_BTS BTS
               WHERE BTS.INT_ID IN
                     (SELECT DISTINCT RELATED_ID
                        FROM TAP_AUDIT
                       WHERE OPERATIONTYPE = '新增'
                         AND DBTABLE = 'c_tco_pro_bts'
                         AND AUDITSTATUS = '通过'
                         AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                         AND AUDITTIME <= SYSDATE))
         AND COVER.ADJUST_SCHEME_ID != '划转'
         AND COVER.MARK_ID NOT IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE (OPERATIONTYPE = '新增' OR OPERATIONTYPE = '修改')
                 AND DBTABLE = 'c_tco_pro_cover_benchmark'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID, RELATED_ID)
        VALUES
          ('BtsCoverNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID,
           C_ROW.RELATED_ID);
        COMMIT;
      END;
    END LOOP;
  END;
  --统计新站入网关联质量问题数据End

  --统计新站入网关联投诉数据Start
  --三期中无用
  /*DECLARE
    CURSOR C_JOB IS
      SELECT COMPLAIN.INT_ID AS INT_ID,
             INFOR.REGION_ID AS REGION_ID,
             RECO.RELATED_ID
        FROM C_TCO_PRO_COMPLAIN COMPLAIN
        LEFT JOIN C_TCO_PRO_INFORSPOT INFOR
          ON INFOR.INFORSPOT_ID = COMPLAIN.INFORSPOT_NUM
       INNER JOIN (SELECT DISTINCT COVER.INFORSPOT_NUM,

                                   BTS.INT_ID AS RELATED_ID
                     FROM C_TCO_PRO_COVER_BENCHMARK COVER
                     LEFT JOIN C_TCO_PRO_BTS BTS
                       ON BTS.PROJECT_ID = COVER.ADJUST_SCHEME_ID
                    WHERE COVER.ADJUST_SCHEME_ID IN
                          (SELECT DISTINCT BTS.PROJECT_ID
                             FROM C_TCO_PRO_BTS BTS
                            WHERE BTS.INT_ID IN
                                  (SELECT DISTINCT RELATED_ID
                                     FROM TAP_AUDIT
                                    WHERE OPERATIONTYPE = '新增'
                                      AND DBTABLE = 'c_tco_pro_bts'
                                      AND AUDITSTATUS = '通过'
                                      AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                                      AND AUDITTIME <= SYSDATE))
                      AND COVER.ADJUST_SCHEME_ID != '划转') RECO
          ON COMPLAIN.INFORSPOT_NUM = RECO.INFORSPOT_NUM
         AND COMPLAIN.INT_ID NOT IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE (OPERATIONTYPE = '新增' OR OPERATIONTYPE = '修改')
                 AND DBTABLE = 'c_tco_pro_complain'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID, RELATED_ID)
        VALUES
          ('BtsComplainNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID,
           C_ROW.RELATED_ID);
        COMMIT;
      END;
    END LOOP;
  END;*/
  --统计新站入网关联投诉数据End

  --统计室分入网数据Start
  DECLARE
    CURSOR C_JOB IS
      SELECT INDOORS.INT_ID AS INT_ID, INDOORS.REGION_ID AS REGION_ID
        FROM C_TCO_PRO_INDOORS INDOORS
       WHERE INDOORS.INT_ID IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE OPERATIONTYPE = '新增'
                 AND DBTABLE = 'c_tco_pro_indoors'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID)
        VALUES
          ('IndoorsNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID);
        COMMIT;
      END;
    END LOOP;
  END;
  --统计室分入网数据End

  --统计室分入网关联规划数据Start
  DECLARE
    CURSOR C_JOB IS
      SELECT SURINDOORS.MARK_ID   AS INT_ID,
             SURINDOORS.REGION_ID AS REGION_ID,
             INDOORS.INT_ID       AS RELATED_ID
        FROM C_TCO_PRO_SURVEY_INDOOR SURINDOORS
        LEFT JOIN C_TCO_PRO_INDOORS INDOORS
          ON INDOORS.INDDS_CODE = SURINDOORS.PROBTSID
       WHERE SURINDOORS.PROBTSID IN
             (SELECT INDOORS.INDDS_CODE
                FROM C_TCO_PRO_INDOORS INDOORS
               WHERE INDOORS.INT_ID IN
                     (SELECT DISTINCT RELATED_ID
                        FROM TAP_AUDIT
                       WHERE OPERATIONTYPE = '新增'
                         AND DBTABLE = 'c_tco_pro_indoors'
                         AND AUDITSTATUS = '通过'
                         AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                         AND AUDITTIME <= SYSDATE))
         AND SURINDOORS.MARK_ID NOT IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE (OPERATIONTYPE = '新增' OR OPERATIONTYPE = '修改')
                 AND DBTABLE = 'c_tco_pro_survey_indoor'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID, RELATED_ID)
        VALUES
          ('IndoorsSurNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID,
           C_ROW.RELATED_ID);
        COMMIT;
      END;
    END LOOP;
  END;
  --统计室分入网关联规划数据End

  --统计室分入网关联质量问题数据Start
  DECLARE
    CURSOR C_JOB IS
      SELECT COVER.MARK_ID   AS INT_ID,
             COVER.REGION_ID AS REGION_ID,
             INDOORS.INT_ID  AS RELATED_ID
        FROM C_TCO_PRO_COVER_BENCHMARK COVER
        LEFT JOIN C_TCO_PRO_INDOORS INDOORS
          ON INDOORS.INDDS_CODE = COVER.ROOM_ADJUST_SCHEME
       WHERE COVER.ROOM_ADJUST_SCHEME IN
             (SELECT DISTINCT INDOORS.INDDS_CODE
                FROM C_TCO_PRO_INDOORS INDOORS
               WHERE INDOORS.INT_ID IN
                     (SELECT DISTINCT RELATED_ID
                        FROM TAP_AUDIT
                       WHERE OPERATIONTYPE = '新增'
                         AND DBTABLE = 'c_tco_pro_indoors'
                         AND AUDITSTATUS = '通过'
                         AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                         AND AUDITTIME <= SYSDATE))
         AND COVER.ROOM_ADJUST_SCHEME != '划转'
         AND COVER.ROOM_ADJUST_SCHEME != '无'
         AND COVER.MARK_ID NOT IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE (OPERATIONTYPE = '新增' OR OPERATIONTYPE = '修改')
                 AND DBTABLE = 'c_tco_pro_cover_benchmark'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID, RELATED_ID)
        VALUES
          ('IndoorsCoverNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID,
           C_ROW.RELATED_ID);
        COMMIT;
      END;
    END LOOP;
  END;
  --统计室分入网关联质量问题数据End

  --统计室分入网关联投诉数据Start
  /*DECLARE
    CURSOR C_JOB IS
      SELECT COMPLAIN.INT_ID AS INT_ID,
             INFOR.REGION_ID AS REGION_ID,
             RECO.RELATED_ID
        FROM C_TCO_PRO_COMPLAIN COMPLAIN
        LEFT JOIN C_TCO_PRO_INFORSPOT INFOR
          ON INFOR.INFORSPOT_ID = COMPLAIN.INFORSPOT_NUM
       INNER JOIN (SELECT COVER.INFORSPOT_NUM, INDOORS.INT_ID AS RELATED_ID
                     FROM C_TCO_PRO_COVER_BENCHMARK COVER
                     LEFT JOIN C_TCO_PRO_INDOORS INDOORS
                       ON INDOORS.INDDS_CODE = COVER.ROOM_ADJUST_SCHEME
                    WHERE COVER.ROOM_ADJUST_SCHEME IN
                          (SELECT DISTINCT INDOORS.INDDS_CODE
                             FROM C_TCO_PRO_INDOORS INDOORS
                            WHERE INDOORS.INT_ID IN
                                  (SELECT DISTINCT RELATED_ID
                                     FROM TAP_AUDIT
                                    WHERE OPERATIONTYPE = '新增'
                                      AND DBTABLE = 'c_tco_pro_indoors'
                                      AND AUDITSTATUS = '通过'
                                      AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                                      AND AUDITTIME <= SYSDATE))
                      AND COVER.ROOM_ADJUST_SCHEME != '划转'
                      AND COVER.ROOM_ADJUST_SCHEME != '无') RECO
          ON COMPLAIN.INFORSPOT_NUM = RECO.INFORSPOT_NUM
       WHERE COMPLAIN.INT_ID NOT IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE (OPERATIONTYPE = '新增' OR OPERATIONTYPE = '修改')
                 AND DBTABLE = 'c_tco_pro_complain'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID, RELATED_ID)
        VALUES
          ('IndoorsComplainNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID,
           C_ROW.RELATED_ID);
        COMMIT;
      END;
    END LOOP;
  END;*/
  --统计室分入网关联投诉数据End

  --统计直放站入网数据Start
  DECLARE
    CURSOR C_JOB IS
      SELECT REPEATER.INT_ID INT_ID, REPEATER.REGION_ID AS REGION_ID
        FROM C_TCO_PRO_REPEATER REPEATER
       WHERE REPEATER.INT_ID IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE OPERATIONTYPE = '新增'
                 AND DBTABLE = 'c_tco_pro_repeater'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID)
        VALUES
          ('RepeaterNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID);
        COMMIT;
      END;
    END LOOP;
  END;
  --统计直放站入网数据End

  --统计直放站入网关联规划数据Start
  DECLARE
    CURSOR C_JOB IS
      SELECT SURBTS.MARK_ID   AS INT_ID,
             SURBTS.REGION_ID AS REGION_ID,
             REPEATER.INT_ID  AS RELATED_ID
        FROM C_TCO_PRO_SURVEY_BTS SURBTS
        LEFT JOIN C_TCO_PRO_REPEATER REPEATER
          ON REPEATER.REPEATER_NO = SURBTS.UNSTATION_NO
       WHERE SURBTS.UNSTATION_NO IN
             (SELECT REPEATER.REPEATER_NO
                FROM C_TCO_PRO_REPEATER REPEATER
               WHERE REPEATER.INT_ID IN
                     (SELECT DISTINCT RELATED_ID
                        FROM TAP_AUDIT
                       WHERE OPERATIONTYPE = '新增'
                         AND DBTABLE = 'c_tco_pro_repeater'
                         AND AUDITSTATUS = '通过'
                         AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                         AND AUDITTIME <= SYSDATE))
         AND SURBTS.MARK_ID NOT IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE (OPERATIONTYPE = '新增' OR OPERATIONTYPE = '修改')
                 AND DBTABLE = 'c_tco_pro_survey_bts'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID, RELATED_ID)
        VALUES
          ('RepeaterSurNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID,
           C_ROW.RELATED_ID);
        COMMIT;
      END;
    END LOOP;
  END;
  --统计直放站入网关联规划数据End

  --统计直放站入网关联质量问题数据Start
  DECLARE
    CURSOR C_JOB IS
      SELECT COVER.MARK_ID   AS INT_ID,
             COVER.REGION_ID AS REGION_ID,
             REPEATER.INT_ID AS RELATED_ID
        FROM C_TCO_PRO_COVER_BENCHMARK COVER
        LEFT JOIN C_TCO_PRO_REPEATER REPEATER
          ON REPEATER.REPEATER_NO = COVER.ADJUST_SCHEME_ID
       WHERE COVER.ADJUST_SCHEME_ID IN
             (SELECT DISTINCT REPEATER.REPEATER_NO
                FROM C_TCO_PRO_REPEATER REPEATER
               WHERE REPEATER.INT_ID IN
                     (SELECT DISTINCT RELATED_ID
                        FROM TAP_AUDIT
                       WHERE OPERATIONTYPE = '新增'
                         AND DBTABLE = 'c_tco_pro_repeater'
                         AND AUDITSTATUS = '通过'
                         AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                         AND AUDITTIME <= SYSDATE))
         AND COVER.ADJUST_SCHEME_ID != '划转'
         AND COVER.MARK_ID NOT IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE (OPERATIONTYPE = '新增' OR OPERATIONTYPE = '修改')
                 AND DBTABLE = 'c_tco_pro_cover_benchmark'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID, RELATED_ID)
        VALUES
          ('RepeaterCoverNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID,
           C_ROW.RELATED_ID);
        COMMIT;
      END;
    END LOOP;
  END;
  --统计直放站入网关联质量问题数据End

  --统计直放站入网关联投诉数据Start
  /*DECLARE
    CURSOR C_JOB IS
      SELECT COMPLAIN.INT_ID AS INT_ID,
             INFOR.REGION_ID AS REGION_ID,
             RECO.RELATED_ID
        FROM C_TCO_PRO_COMPLAIN COMPLAIN
        LEFT JOIN C_TCO_PRO_INFORSPOT INFOR
          ON INFOR.INFORSPOT_ID = COMPLAIN.INFORSPOT_NUM
       INNER JOIN (SELECT DISTINCT COVER.INFORSPOT_NUM,
                                   REPEATER.INT_ID AS RELATED_ID
                     FROM C_TCO_PRO_COVER_BENCHMARK COVER
                     LEFT JOIN C_TCO_PRO_REPEATER REPEATER
                       ON REPEATER.REPEATER_NO = COVER.ADJUST_SCHEME_ID
                    WHERE COVER.ADJUST_SCHEME_ID IN
                          (SELECT DISTINCT REPEATER.REPEATER_NO
                             FROM C_TCO_PRO_REPEATER REPEATER
                            WHERE REPEATER.INT_ID IN
                                  (SELECT DISTINCT RELATED_ID
                                     FROM TAP_AUDIT
                                    WHERE OPERATIONTYPE = '新增'
                                      AND DBTABLE = 'c_tco_pro_repeater'
                                      AND AUDITSTATUS = '通过'
                                      AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                                      AND AUDITTIME <= SYSDATE))
                      AND COVER.ADJUST_SCHEME_ID != '划转') RECO
          ON COMPLAIN.INFORSPOT_NUM = RECO.INFORSPOT_NUM
       WHERE COMPLAIN.INT_ID NOT IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE (OPERATIONTYPE = '新增' OR OPERATIONTYPE = '修改')
                 AND DBTABLE = 'c_tco_pro_complain'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID, RELATED_ID)
        VALUES
          ('RepeaterComplainNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID,
           C_ROW.RELATED_ID);
        COMMIT;
      END;
    END LOOP;
  END;*/
  --统计直放站入网关联投诉数据End

  --统计投诉处理完毕数据Start
  /*DECLARE
    CURSOR C_JOB IS
      SELECT COMPLAIN.INT_ID AS INT_ID, INFOR.REGION_ID AS REGION_ID
        FROM C_TCO_PRO_COMPLAIN COMPLAIN
        LEFT JOIN C_TCO_PRO_INFORSPOT INFOR
          ON INFOR.INFORSPOT_ID = COMPLAIN.INFORSPOT_NUM
       WHERE COMPLAIN.INT_ID IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE (OPERATIONTYPE = '新增' OR OPERATIONTYPE = '修改')
                 AND DBTABLE = 'c_tco_pro_complain'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE)
         AND COMPLAIN.COMPLAIN_RESULT LIKE '%已解决_%';
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID)
        VALUES
          ('ComplainNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID);
        COMMIT;
      END;
    END LOOP;
  END;*/
  --统计投诉处理完毕数据End

  --统计投诉处理完毕关联质量问题数据Start
  /*DECLARE
    CURSOR C_JOB IS
      SELECT COVER.MARK_ID   AS INT_ID,
             COVER.REGION_ID AS REGION_ID,
             RECO.INT_ID     AS RELATED_ID
        FROM C_TCO_PRO_COVER_BENCHMARK COVER
       INNER JOIN (SELECT DISTINCT COMPLAIN.INFORSPOT_NUM, COMPLAIN.INT_ID
                     FROM C_TCO_PRO_COMPLAIN COMPLAIN
                    WHERE COMPLAIN.INT_ID IN
                          (SELECT DISTINCT RELATED_ID
                             FROM TAP_AUDIT
                            WHERE (OPERATIONTYPE = '新增' OR
                                  OPERATIONTYPE = '修改')
                              AND DBTABLE = 'c_tco_pro_complain'
                              AND AUDITSTATUS = '通过'
                              AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                              AND AUDITTIME <= SYSDATE)
                      AND COMPLAIN.COMPLAIN_RESULT LIKE '%已解决_%') RECO
          ON RECO.INFORSPOT_NUM = COVER.INFORSPOT_NUM
       WHERE COVER.MARK_ID NOT IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE (OPERATIONTYPE = '新增' OR OPERATIONTYPE = '修改')
                 AND DBTABLE = 'c_tco_pro_cover_benchmark'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID, RELATED_ID)
        VALUES
          ('ComplainCoverNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID,
           C_ROW.RELATED_ID);
        COMMIT;
      END;
    END LOOP;
  END;*/
  --统计投诉处理完毕关联质量问题数据End

  --统计投质量问题处理完毕数据Start
  DECLARE
    CURSOR C_JOB IS
      SELECT COVER.MARK_ID AS INT_ID, COVER.REGION_ID AS REGION_ID
        FROM C_TCO_PRO_COVER_BENCHMARK COVER
       WHERE COVER.MARK_ID IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE (OPERATIONTYPE = '新增' OR OPERATIONTYPE = '修改')
                 AND DBTABLE = 'c_tco_pro_cover_benchmark'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE)
         AND (COVER.C_SOLVED_DATE IS NOT NULL OR
             COVER.WIFI_SOLVED_DATE IS NOT NULL);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID)
        VALUES
          ('CoverNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID);
        COMMIT;
      END;
    END LOOP;
  END;
  --统计投质量问题处理完毕数据End

  --统计投质量问题处理完毕关联投诉数据Start
  /*DECLARE
    CURSOR C_JOB IS
      SELECT COMPLAIN.INT_ID AS INT_ID,
             INFOR.REGION_ID AS REGION_ID,
             RECO.MARK_ID    AS RELATED_ID
        FROM C_TCO_PRO_COMPLAIN COMPLAIN
        LEFT JOIN C_TCO_PRO_INFORSPOT INFOR
          ON INFOR.INFORSPOT_ID = COMPLAIN.INFORSPOT_NUM
       INNER JOIN (SELECT DISTINCT COVER.INFORSPOT_NUM, COVER.MARK_ID
                     FROM C_TCO_PRO_COVER_BENCHMARK COVER
                    WHERE COVER.MARK_ID IN
                          (SELECT DISTINCT RELATED_ID
                             FROM TAP_AUDIT
                            WHERE (OPERATIONTYPE = '新增' OR
                                  OPERATIONTYPE = '修改')
                              AND DBTABLE = 'c_tco_pro_cover_benchmark'
                              AND AUDITSTATUS = '通过'
                              AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                              AND AUDITTIME <= SYSDATE)
                      AND (COVER.C_SOLVED_DATE IS NOT NULL OR
                          COVER.WIFI_SOLVED_DATE IS NOT NULL)) RECO
          ON RECO.INFORSPOT_NUM = COMPLAIN.INFORSPOT_NUM
         AND COMPLAIN.INT_ID NOT IN
             (SELECT DISTINCT RELATED_ID
                FROM TAP_AUDIT
               WHERE (OPERATIONTYPE = '新增' OR OPERATIONTYPE = '修改')
                 AND DBTABLE = 'c_tco_pro_complain'
                 AND AUDITSTATUS = '通过'
                 AND AUDITTIME >= ADD_MONTHS(SYSDATE, -1)
                 AND AUDITTIME <= SYSDATE);
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO C_MAINPAGE_NUM
          (RESOURCETYPE, STATITIME, INTIDSTR, REGION_ID, RELATED_ID)
        VALUES
          ('CoverComplainNum',
           TO_CHAR(SYSDATE, 'yyyy-MM-dd'),
           C_ROW.INT_ID,
           C_ROW.REGION_ID,
           C_ROW.RELATED_ID);
        COMMIT;
      END;
    END LOOP;
  END;*/
  --统计投质量问题处理完毕关联投诉数据End

END PROC_MAINPAGE_STATINUM;
