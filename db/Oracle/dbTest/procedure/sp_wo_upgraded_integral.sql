CREATE OR REPLACE PROCEDURE sp_wo_upgraded_integral
/*
(
)
*/
IS

       is_upgraded varchar2(1);

       yes varchar2(1) := 'Y';
       no varchar2(1) := 'N';

       workOrderFinishStatus number := 4;

BEGIN

       SELECT is_upgraded
       INTO is_upgraded
       FROM tap_wp_contentkpi_updateflag
       WHERE id = 1;

       IF is_upgraded = no THEN
          BEGIN
             RETURN;
          END;
       END IF;

       DELETE FROM tap_wo_ne_kpi;

       INSERT INTO tap_wo_ne_kpi
       (
              id,
              wo_id,
              content_id,
              net_technology,
              kpi_id,
              kpi_name,
              reference_value,
              dispatch_datetime,
              dispatch_value,
              finish_datetime,
              finish_value
       )
       SELECT
              ck.id,
              wo.id AS wo_id,
              ck.content_id,
              ck.net_technology,
              ck.kpi_id,
              ck.kpi_name,
              ck.reference_value,
              wob.wo_dispatch_datetime AS dispatch_datetime,
              NULL AS dispatch_value,
              wob.wo_finish_datetime AS finish_datetime,
              NULL AS finish_value
       FROM tap_wo_baseinfo wob
       INNER JOIN tap_wo wo ON wob.id = wo.id
       INNER JOIN tap_dictionary d1 ON wo.wo_problem_technology_type = d1.value AND d1.type = 'WO Problem Technology Type'
       INNER JOIN tap_wp_contentkpi ck ON d1.text = ck.net_technology
       WHERE wob.wo_status = workOrderFinishStatus;

       UPDATE tap_wp_contentkpi_updateflag
       SET is_upgraded = no
       WHERE id = 1;


       COMMIT;

END;
