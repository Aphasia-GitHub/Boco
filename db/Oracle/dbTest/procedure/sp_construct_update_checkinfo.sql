CREATE OR REPLACE PROCEDURE sp_construct_update_checkinfo
(
       inID in integer,
       inCheckBeginTime in date,
       inCheckCategory varchar2
)
IS
       workPlanID number := 0;

       initialCheck varchar2(20) := 'initial';
       terminateCheck varchar2(20) := 'terminate';

       workPlanExecutingStatus number := 5;

       initialCheckWorkPlanCode varchar2(20) := '062';
       terminateCheckWorkPlanCode varchar2(20) := '063';

       initialCheckDelayDays number := 0;
       initialCheckObservateDays number := 0;

       terminateCheckDelayDays number := 0;
       terminateCheckObservateDays number := 0;

       oneRecord number := 1;
       recordCount number := 0;
BEGIN
       SELECT engineering_wp_id
       INTO workPlanID
       FROM tap_construct_bts
       WHERE id = inID;

       --更新初验信息
       IF inCheckCategory = initialCheck THEN
         BEGIN
           SELECT COUNT(wpcc.id)
           INTO recordCount
           FROM tap_wp wp
           INNER JOIN tap_wp_stage wps ON wp.id = wps.wp_id
           INNER JOIN tap_wp_content wpc ON wps.id = wpc.wp_stage_id
           INNER JOIN tap_wp_c_content wpcc ON wpc.id = wpcc.id
           WHERE wp.id = workPlanID
           AND wp.wp_status = workPlanExecutingStatus
           AND wpc.code = initialCheckWorkPlanCode
           AND rownum = oneRecord;

           IF recordCount = oneRecord THEN
             BEGIN
               SELECT NVL(wpcc.delay_days, 0), NVL(wpcc.observate_days, 0)
               INTO initialCheckDelayDays, initialCheckObservateDays
               FROM tap_wp wp
               INNER JOIN tap_wp_stage wps ON wp.id = wps.wp_id
               INNER JOIN tap_wp_content wpc ON wps.id = wpc.wp_stage_id
               INNER JOIN tap_wp_c_content wpcc ON wpc.id = wpcc.id
               WHERE wp.id = workPlanID
               AND wp.wp_status = workPlanExecutingStatus
               AND wpc.code = initialCheckWorkPlanCode
               AND rownum = oneRecord;

               UPDATE tap_construct_bts
               SET initialcheck_begin_time = NVL(inCheckBeginTime, SYSDATE),
                   initialcheck_delay_days = initialCheckDelayDays,
                   initialcheck_observate_days = initialCheckObservateDays
               WHERE id = inID;

             END;
           END IF;

         END;
       END IF;

       --更新终验信息
       IF inCheckCategory = terminateCheck THEN
         BEGIN
           SELECT COUNT(wpcc.id)
           INTO recordCount
           FROM tap_wp wp
           INNER JOIN tap_wp_stage wps ON wp.id = wps.wp_id
           INNER JOIN tap_wp_content wpc ON wps.id = wpc.wp_stage_id
           INNER JOIN tap_wp_c_content wpcc ON wpc.id = wpcc.id
           WHERE wp.id = workPlanID
           AND wp.wp_status = workPlanExecutingStatus
           AND wpc.code = terminateCheckWorkPlanCode
           AND rownum = oneRecord;

           IF recordCount = oneRecord THEN
             BEGIN
               SELECT NVL(wpcc.delay_days, 0), NVL(wpcc.observate_days, 0)
               INTO terminateCheckDelayDays, terminateCheckObservateDays
               FROM tap_wp wp
               INNER JOIN tap_wp_stage wps ON wp.id = wps.wp_id
               INNER JOIN tap_wp_content wpc ON wps.id = wpc.wp_stage_id
               INNER JOIN tap_wp_c_content wpcc ON wpc.id = wpcc.id
               WHERE wp.id = workPlanID
               AND wp.wp_status = workPlanExecutingStatus
               AND wpc.code = terminateCheckWorkPlanCode
               AND rownum = oneRecord;

               UPDATE tap_construct_bts
               SET terminatecheck_begin_time = NVL(inCheckBeginTime, SYSDATE),
               terminatecheck_delay_days = terminateCheckDelayDays,
               terminatecheck_observate_days = terminateCheckObservateDays
               WHERE id = inID;

             END;
           END IF;


         END;
       END IF;


       COMMIT;

END;
