CREATE OR REPLACE PROCEDURE sp_construct_engineering_bts
(
       inDayLength in integer
)
IS
       dayLengthAddOne number := inDayLength + 1;
       currentDate date := TRUNC(SYSDATE);
BEGIN

       /*
       SELECT
           id,
           planning_bts_id,
           wp_id,
           bts_name,
           btsid,
           bsc_name,
           city_id,
           city_name,
           bts_status,
           warning_datetime,
           initialcheck_begin_time,
           initialcheck_delay_days,
           initialcheck_observate_days,
           initialcheck_datetime,
           initialcheck_user_id,
           terminatecheck_begin_time,
           terminatecheck_delay_days,
           terminatecheck_observate_days,
           terminatecheck_datetime,
           terminatecheck_user_id,
           demolish_datetime,
           is_reconstruct
       FROM tap_construct_bts

       UNION

       SELECT *
       FROM tap_construct_bts;
       */


       --在c_tpa_cnt_bts_zx中寻找
       INSERT INTO tap_construct_bts
       (
           id,
           warning_datetime
       )
       SELECT DISTINCT b.int_id,
              currentDate AS warning_datetime
       FROM c_tpa_cnt_bts_zx b
       WHERE b.scan_start_time >= currentDate - inDayLength AND b.scan_start_time <= currentDate - 1
       AND b.sum_level = 1
       AND b.ne_type = 201
       GROUP BY b.int_id
       HAVING COUNT(b.int_id) = inDayLength
       AND NOT EXISTS
       (
           SELECT b2.int_id
           FROM c_tpa_cnt_bts_zx b2
           WHERE b2.scan_start_time = currentDate - dayLengthAddOne
           AND b2.sum_level = 1
           AND b2.ne_type = 201
           AND b2.int_id = b.int_id
       )
       AND NOT EXISTS
       (
           SELECT cb.id
           FROM tap_construct_bts cb
           WHERE cb.id = b.int_id
           --AND cb.warning_datetime = currentDate
       );

       --在c_tpa_cnt_bts_do_zx中寻找
       INSERT INTO tap_construct_bts
       (
           id,
           warning_datetime
       )
       SELECT DISTINCT b.int_id,
              currentDate AS warning_datetime
       FROM c_tpa_cnt_bts_do_zx b
       WHERE b.scan_start_time >= currentDate - inDayLength AND b.scan_start_time <= currentDate - 1
       AND b.sum_level = 1
       AND b.ne_type = 201
       GROUP BY b.int_id
       HAVING COUNT(b.int_id) = inDayLength
       AND NOT EXISTS
       (
           SELECT b2.int_id
           FROM c_tpa_cnt_bts_do_zx b2
           WHERE b2.scan_start_time = currentDate - dayLengthAddOne
           AND b2.sum_level = 1
           AND b2.ne_type = 201
           AND b2.int_id = b.int_id
       )
       AND NOT EXISTS
       (
           SELECT cb.id
           FROM tap_construct_bts cb
           WHERE cb.id = b.int_id
           --AND cb.warning_datetime = currentDate
       );

       --在c_tpa_cnt_bts_lc中寻找
       INSERT INTO tap_construct_bts
       (
           id,
           warning_datetime
       )
       SELECT DISTINCT b.int_id,
              currentDate AS warning_datetime
       FROM c_tpa_cnt_bts_lc b
       WHERE b.scan_start_time >= currentDate - inDayLength AND b.scan_start_time <= currentDate - 1
       AND b.sum_level = 1
       AND b.ne_type = 201
       GROUP BY b.int_id
       HAVING COUNT(b.int_id) = inDayLength
       AND NOT EXISTS
       (
           SELECT b2.int_id
           FROM c_tpa_cnt_bts_lc b2
           WHERE b2.scan_start_time = currentDate - dayLengthAddOne
           AND b2.sum_level = 1
           AND b2.ne_type = 201
           AND b2.int_id = b.int_id
       )
       AND NOT EXISTS
       (
           SELECT cb.id
           FROM tap_construct_bts cb
           WHERE cb.id = b.int_id
           --AND cb.warning_datetime = currentDate
       );

       --在c_tpa_bts_do_lc中寻找
       INSERT INTO tap_construct_bts
       (
           id,
           warning_datetime
       )
       SELECT DISTINCT b.int_id,
              currentDate AS warning_datetime
       FROM c_tpa_bts_do_lc b
       WHERE b.scan_start_time >= currentDate - inDayLength AND b.scan_start_time <= currentDate - 1
       AND b.sum_level = 1
       AND b.ne_type = 201
       GROUP BY b.int_id
       HAVING COUNT(b.int_id) = inDayLength
       AND NOT EXISTS
       (
           SELECT b2.int_id
           FROM c_tpa_bts_do_lc b2
           WHERE b2.scan_start_time = currentDate - dayLengthAddOne
           AND b2.sum_level = 1
           AND b2.ne_type = 201
           AND b2.int_id = b.int_id
       )
       AND NOT EXISTS
       (
           SELECT cb.id
           FROM tap_construct_bts cb
           WHERE cb.id = b.int_id
           --AND cb.warning_datetime = currentDate
       );

       --更新planning_bts_id
       UPDATE tap_construct_bts
       SET planning_bts_id =
       (
           SELECT pb.id
           FROM tap_planning_bts pb
           INNER JOIN c_tco_pro_bts pro_b ON pb.distribute_bts_number = pro_b.project_id
           INNER JOIN tap_construct_bts cb ON pro_b.int_id = cb.id
           WHERE cb.warning_datetime = currentDate
           AND cb.id = tap_construct_bts.id
       )
       WHERE warning_datetime = currentDate
       AND planning_bts_id IS NULL;

       --更新bts_name, btsid, bsc_name, region_id, region_name, city_id, city_name
       UPDATE tap_construct_bts
       SET (bts_name, btsid, bsc_name, region_id, region_name, city_id, city_name) =
       (
           SELECT bts.name AS bts_name,
                  bts.btsid,
                  bsc.name AS bsc_name,
                  region.region_id,
                  region.region_name,
                  city.city_id,
                  city.city_name
           FROM c_bts bts
           INNER JOIN c_tco_pro_bts pro_bts ON bts.int_id = pro_bts.int_id
           INNER JOIN c_bsc bsc ON bts.related_bsc = bsc.int_id
           INNER JOIN
           (
                SELECT city_id AS region_id, city_name AS region_name
                FROM c_region_city
                WHERE region_name = '\'
           ) region ON pro_bts.city_name = region.region_name
           INNER JOIN
           (
                SELECT city_id, city_name
                FROM c_region_city
                WHERE region_name <> '\'
           ) city ON pro_bts.county_name = city.city_name
           WHERE bts.int_id = tap_construct_bts.id
       )
       WHERE warning_datetime = currentDate;


       COMMIT;

END;
