CREATE OR REPLACE PROCEDURE sp_scalecqt_init_infospot
(
       inAnalysePeriodDatetime in date
)
IS
       runBeginTime date := SYSDATE;

       abnormalgridCategory2g varchar2(128) := '2G异常栅格';
       abnormalgridCategory3g varchar2(128) := '3G异常栅格';
       abnormalgridCategory2g3g varchar2(128) := '2G/3G异常栅格';
       netTechnology2g varchar2(2) := '2G';
       netTechnology3g varchar2(2) := '3G';

       --该信息点为异常栅格关联的信息点
       infospotSourceFlagOfRelated number := 1;
       --异常栅格周边一层栅格关联的信息点
       infospotSourceFlagOfLayerGrid number := 2;
       --异常栅格中心经纬度附近的信息点
       --infospotSourceFlagOfNearby number := 3;

       --异常栅格无信息点，辅助一层栅格信息点进行后续判断，tap_scalecqt_infospot.infospot_source_flag = 2，tap_scalecqt_infospot.infospot_source_flag = 3；（初始步骤）
       infospotFlag0 number := 0;
       --异常栅格无信息点，辅助的一层栅格也无信息点，直接按栅格派单；（初始步骤，条件infospot_flag = 0）
       infospotFlag1 number := 1;
       --异常栅格有信息点，后续做正常判断，tap_scalecqt_infospot.infospot_source_flag = 1；（初始步骤）
       infospotFlag2 number := 2;
       --异常栅格有信息点，但无问题信息点，辅助一层栅格信息点进行后续判断，tap_scalecqt_infospot.infospot_source_flag = 2，tap_scalecqt_infospot.infospot_source_flag = 3；（第二圈，条件infospot_flag = 2）
       --infospotFlag3 number := 3;
       --异常栅格有信息点，但无问题信息点，辅助一层栅格也无信息点；（第二圈，条件infospot_flag = 2）
       --infospotFlag4 number := 4;

       --异常栅格中心经纬度距离最近的TOP N（TODO：从配置中读取）
       --topNOfNearby number := 10;

       --problemCategory1 varchar2(128) := '信息点异常，信源小区异常';
       --problemCategory2 varchar2(128) := '信息点异常，周边基站异常';
       --problemCategory3 varchar2(128) := '信息点异常，需优化';
       --problemCategory4 varchar2(128) := '信息点异常，待提升规划级别';
       --problemCategory5 varchar2(128) := '信息点异常，提升规划级别';
       --problemCategory8 varchar2(128) := '信息点异常，规划级别已是最大值，无需提升';
       --problemCategory6 varchar2(128) := '信息点正常，栅格异常';
       --problemCategory7 varchar2(128) := '无信息点，栅格异常';
       problemCategory7 varchar2(128) := '异常栅格，栅格内有建筑物无信息点';

       --problemCategory9 varchar2(128) := '栅格异常，栅格内无建筑物，不派单';
       problemCategory9 varchar2(128) := '异常栅格，栅格内无建筑物无信息点';

       --2G异常小区类型
       --abnormalCellCategory2g varchar2(200);
       --3G异常小区类型
       --abnormalCellCategory3g varchar2(200);

       --信源小区的输出
       --signalSourceCellResult1 varchar2(128) := '该信息点室分信源小区性能异常，已通过异常小区派单，规模CQT不再重复派单';
       --signalSourceCellResult2 varchar2(128) := '该信息点室分信源小区性能异常，异常小区未派单，规模CQT按小区派单';
       --周边基站小区的输出
       --nearbyCellResult1 varchar2(128) := '该信息点周边基站小区性能异常，已通过异常小区派单，规模CQT不再重复派单';
       --nearbyCellResult2 varchar2(128) := '该信息点周边基站小区性能异常，异常小区未派单，规模CQT按小区派单';
       --异常小区的工单源
       --woSourceOfAbnormalCell number := 2;
       --工单的结单状态
       --woStatusOfFinish number := 4;
       --派单对象
       --dispatchObjectOfCell varchar2(20) := 'Cell';
       --dispatchObjectOfInfoSpot varchar2(20) := 'InfoSpot';

       --测试结果-差
       --testResultOfPoor varchar2(20) := '差';

       --室分规划的 M 天 N 次（TODO：从配置中读取）
       --surveyIndoorDays number := 90;
       --surveyIndoorTimes number := 0;

       --宏站规划的 M 天 N 次（TODO：从配置中读取）
       --surveyBtsDays number := 90;
       --surveyBtsTimes number := 0;

       --周边基站的个数，默认是4
       --btsNumberOfNearby number := 4;


       yes varchar2(1) := 'Y';
       --no varchar2(1) := 'N';

       yesOfNumber number := 1;
       --noOfNumber number := 0;

BEGIN

       INSERT INTO tap_scalecqt_analyseperiod
       (
              analyse_period_day,
              analyse_period_datetime
       )
       SELECT TRUNC(inAnalysePeriodDatetime),
              inAnalysePeriodDatetime
       FROM dual;


       --1 初始化异常栅格
       --1.1 初始化2G异常栅格
       INSERT INTO tap_scalecqt_abnormalgrid
       (
              id,
              parent_id,
              analyse_period_datetime,
              grid_num,
              region_id,
              tl_longitude,
              tl_latitude,
              br_longitude,
              br_latitude,
              c_x,
              c_y,
              abnormalgrid_category,
              location_category,
              infospot_flag,
              problem_category,
              is_need_dispatch_wo,
              wo_id,
              run_begin_time,
              run_end_time
       )
       SELECT
              SYS_GUID() AS id,
              NULL AS parent_id,
              g.scan_start_time AS analyse_period_datetime,
              g.grid_num,
              g.region_id,
              NULL AS tl_longitude,
              NULL AS tl_latitude,
              NULL AS br_longitude,
              NULL AS br_latitude,
              NULL AS c_x,
              NULL AS c_y,
              abnormalgridCategory2g AS abnormalgrid_category,
              NULL AS location_category,
              NULL AS infospot_flag,
              NULL AS problem_category,
              NULL AS is_need_dispatch_wo,
              NULL AS wo_id,
              runBeginTime AS run_begin_time,
              NULL AS run_end_time
       FROM tap_scalecqt_abgrid_2g g
       WHERE g.scan_start_time = inAnalysePeriodDatetime;

       INSERT INTO tap_scalecqt_grid_detail
       (
              id,
              scalecqt_abnormalgrid_id,
              analyse_datetime,
              net_technology
       )
       SELECT
              SYS_GUID() AS id,
              ag.id AS scalecqt_abnormalgrid_id,
              gd.scan_start_time AS analyse_datetime,
              netTechnology2g AS net_technology
       FROM tap_scalecqt_abnormalgrid ag
       INNER JOIN tap_scalecqt_abgrid_2g g ON ag.analyse_period_datetime = g.scan_start_time
       AND ag.grid_num = g.grid_num
       AND ag.region_id = g.region_id
       INNER JOIN tap_scalecqt_abgrid_2gdetail gd ON g.id = gd.abgrid_id
       WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
       AND gd.is_pass = yesOfNumber;

       --1.2 初始化2G/3G异常栅格
       UPDATE tap_scalecqt_abnormalgrid
       SET abnormalgrid_category = abnormalgridCategory2g3g
       WHERE id IN
       (
             SELECT ag.id
             FROM tap_scalecqt_abnormalgrid ag
             INNER JOIN tap_scalecqt_abgrid_3g g ON ag.analyse_period_datetime = g.scan_start_time
             AND ag.grid_num = g.grid_num
             AND ag.region_id = g.region_id
             WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
       );

       INSERT INTO tap_scalecqt_grid_detail
       (
              id,
              scalecqt_abnormalgrid_id,
              analyse_datetime,
              net_technology
       )
       SELECT
              SYS_GUID() AS id,
              ag.id AS scalecqt_abnormalgrid_id,
              gd.scan_start_time AS analyse_datetime,
              netTechnology3g AS net_technology
       FROM tap_scalecqt_abnormalgrid ag
       INNER JOIN tap_scalecqt_abgrid_3g g ON ag.analyse_period_datetime = g.scan_start_time
       AND ag.grid_num = g.grid_num
       AND ag.region_id = g.region_id
       INNER JOIN tap_scalecqt_abgrid_3gdetail gd ON g.id = gd.abgrid_id
       WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
       AND gd.is_pass = yesOfNumber;

       --1.3 初始化3G异常栅格
       INSERT INTO tap_scalecqt_abnormalgrid
       (
              id,
              parent_id,
              analyse_period_datetime,
              grid_num,
              region_id,
              tl_longitude,
              tl_latitude,
              br_longitude,
              br_latitude,
              c_x,
              c_y,
              abnormalgrid_category,
              location_category,
              infospot_flag,
              problem_category,
              is_need_dispatch_wo,
              wo_id,
              run_begin_time,
              run_end_time
       )
       SELECT
              SYS_GUID() AS id,
              NULL AS parent_id,
              g.scan_start_time AS analyse_period_datetime,
              g.grid_num,
              g.region_id,
              NULL AS tl_longitude,
              NULL AS tl_latitude,
              NULL AS br_longitude,
              NULL AS br_latitude,
              NULL AS c_x,
              NULL AS c_y,
              abnormalgridCategory3g AS abnormalgrid_category,
              NULL AS location_category,
              NULL AS infospot_flag,
              NULL AS problem_category,
              NULL AS is_need_dispatch_wo,
              NULL AS wo_id,
              runBeginTime AS run_begin_time,
              NULL AS run_end_time
       FROM tap_scalecqt_abgrid_3g g
       WHERE g.scan_start_time = inAnalysePeriodDatetime
       AND NOT EXISTS
       (
           SELECT 1
           FROM tap_scalecqt_abnormalgrid ag
           WHERE g.scan_start_time = ag.analyse_period_datetime
           AND g.grid_num = ag.grid_num
           AND g.region_id = ag.region_id
       );

       INSERT INTO tap_scalecqt_grid_detail
       (
              id,
              scalecqt_abnormalgrid_id,
              analyse_datetime,
              net_technology
       )
       SELECT
              SYS_GUID() AS id,
              ag.id AS scalecqt_abnormalgrid_id,
              gd.scan_start_time AS analyse_datetime,
              netTechnology3g AS net_technology
       FROM tap_scalecqt_abnormalgrid ag
       INNER JOIN tap_scalecqt_abgrid_3g g ON ag.analyse_period_datetime = g.scan_start_time
       AND ag.grid_num = g.grid_num
       AND ag.region_id = g.region_id
       INNER JOIN tap_scalecqt_abgrid_3gdetail gd ON g.id = gd.abgrid_id
       WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
       AND gd.is_pass = yesOfNumber
       AND NOT EXISTS
       (
           SELECT 1
           FROM tap_scalecqt_abnormalgrid ag2
           INNER JOIN tap_scalecqt_grid_detail gd2 ON ag2.id = gd2.scalecqt_abnormalgrid_id
           WHERE gd.scan_start_time = gd2.analyse_datetime
           AND g.grid_num = ag2.grid_num
           AND g.region_id = ag2.region_id
           AND ag2.analyse_period_datetime = inAnalysePeriodDatetime
           AND gd2.net_technology = netTechnology3g
       );

       --1.4 更新栅格数据（TODO：此步骤耗费时间太长）
       --清理数据质量问题造成的异常栅格的异常数据（TODO：数据正确后，该DELETE可以省略）
       --数据已经同步，可以省略
      /* DELETE FROM tap_scalecqt_grid_detail gd
       WHERE gd.scalecqt_abnormalgrid_id IN
       (
           SELECT ag.id
           FROM tap_scalecqt_abnormalgrid ag
           WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
           AND NOT EXISTS
           (
               SELECT 1
               FROM tap_grid
               WHERE grid_num = ag.grid_num
           )
       );
       DELETE FROM tap_scalecqt_abnormalgrid g
       WHERE g.id IN
       (
           SELECT ag.id
           FROM tap_scalecqt_abnormalgrid ag
           WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
           AND NOT EXISTS
           (
               SELECT 1
               FROM tap_grid
               WHERE grid_num = ag.grid_num
           )
       );*/


       UPDATE tap_scalecqt_abnormalgrid
       SET grid_1x_scorepoor_count =
       (
           SELECT COUNT(gd.id)
           FROM tap_scalecqt_abnormalgrid ag
           INNER JOIN tap_scalecqt_grid_detail gd ON ag.id = gd.scalecqt_abnormalgrid_id AND gd.net_technology = netTechnology2g
           WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
           AND ag.parent_id IS NULL
           AND ag.abnormalgrid_category IN(abnormalgridCategory2g, abnormalgridCategory2g3g)
           AND tap_scalecqt_abnormalgrid.id = ag.id
           GROUP BY ag.id
       )
       WHERE analyse_period_datetime = inAnalysePeriodDatetime
       AND parent_id IS NULL
       AND abnormalgrid_category IN(abnormalgridCategory2g, abnormalgridCategory2g3g);


       UPDATE tap_scalecqt_abnormalgrid
       SET grid_do_scorepoor_count =
       (
           SELECT COUNT(gd.id)
           FROM tap_scalecqt_abnormalgrid ag
           INNER JOIN tap_scalecqt_grid_detail gd ON ag.id = gd.scalecqt_abnormalgrid_id AND gd.net_technology = netTechnology3g
           WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
           AND ag.parent_id IS NULL
           AND ag.abnormalgrid_category IN(abnormalgridCategory3g, abnormalgridCategory2g3g)
           AND tap_scalecqt_abnormalgrid.id = ag.id
           GROUP BY ag.id
       )
       WHERE analyse_period_datetime = inAnalysePeriodDatetime
       AND parent_id IS NULL
       AND abnormalgrid_category IN(abnormalgridCategory3g, abnormalgridCategory2g3g);


       UPDATE tap_scalecqt_abnormalgrid
       SET(tl_longitude, tl_latitude, br_longitude, br_latitude, c_x, c_y, location_category) =
       (
             SELECT
                     tl_longitude,
                     tl_latitude,
                     br_longitude,
                     br_latitude,
                     c_x,
                     c_y,
                     CASE location_type
                       WHEN 0 THEN '市区'
                       WHEN 1 THEN '县城'
                       WHEN 2 THEN '农村'
                     END AS location_category
             FROM tap_grid
             WHERE grid_num =  tap_scalecqt_abnormalgrid.grid_num
       )
       WHERE analyse_period_datetime = inAnalysePeriodDatetime;


       --2 判断异常栅格有无关联信息点
       --2.1 初始化异常栅格的信息点
       INSERT INTO tap_scalecqt_infospot

       (
              id,
              scalecqt_abnormalgrid_id,
              infospot_source_flag,
              infospot_id,
              infospot_code,
              infospot_name,
              related_indoor_code,
             --repeater_code,
              indoor_id,
              indoor_code,
              is_has_indoor,
              ss_cell_id,
              ss_cell_name,
              is_over_abnormalcell_threshold,
              result,
              signal2g,
              signal3g,
              x,
              y,
              is_in_wqp_lib,
              wqp_lib_id,
              c_solved_date,
              indoor_adjustscheme_category,
              indoor_adjustscheme_code,
              survey_indoor_id,
              survey_indoor_code,
              survey_indoor_name,
              is_has_survey_indoor,
              indoor_level_before_adjust,
              indoor_level,
              bts_adjustscheme_category,
              bts_adjustscheme_code,
              survey_bts_id,
              survey_bts_code,
              survey_bts_name,
              is_has_survey_bts,
              bts_priority_before_adjust,
              bts_priority,
              problem_category,
              is_need_dispatch_wo,
              wo_id,
              dispatch_object
       )
       SELECT
              SYS_GUID() AS id,
              g.id AS scalecqt_abnormalgrid_id,
              infospotSourceFlagOfRelated AS infospot_source_flag,
              infospot.int_id AS infospot_id,
              infospot.inforspot_id AS infospot_code,
              infospot.inforspot_name AS infospot_name,
              infospot.indoors_no AS related_indoor_code,
              --indoor.reserve_field_1 repeater_code,
              NULL AS indoor_id,
              NULL AS indoor_code,
              NULL AS is_has_indoor,
              NULL AS ss_cell_id,
              NULL AS ss_cell_name,
              NULL AS is_over_abnormalcell_threshold,
              NULL AS result,
              infospot.signal2g,
              infospot.signal3g,
              infospot.inforspot_x AS x,
              infospot.inforspot_y AS y,
              NULL AS is_in_wqp_lib,
              NULL AS wqp_lib_id,
              NULL AS c_solved_date,
              NULL AS indoor_adjustscheme_category,
              NULL AS indoor_adjustscheme_code,
              NULL AS survey_indoor_id,
              NULL AS survey_indoor_code,
              NULL AS survey_indoor_name,
              NULL AS is_has_survey_indoor,
              NULL AS indoor_level_before_adjust,
              NULL AS indoor_level,
              NULL AS bts_adjustscheme_category,
              NULL AS bts_adjustscheme_code,
              NULL AS survey_bts_id,
              NULL AS survey_bts_code,
              NULL AS survey_bts_name,
              NULL AS is_has_survey_bts,
              NULL AS bts_priority_before_adjust,
              NULL AS bts_priority,
              NULL AS problem_category,
              NULL AS is_need_dispatch_wo,
              NULL AS wo_id,
              NULL AS dispatch_object
       FROM tap_scalecqt_abnormalgrid g
       INNER JOIN c_tco_pro_inforspot infospot ON g.grid_num = infospot.related_grid
       --LEFT JOIN c_tco_pro_indoors indoor on infospot.indoors_no = indoor.indds_code
       WHERE g.analyse_period_datetime = inAnalysePeriodDatetime;
       --AND g.run_end_time IS NULL;

       --2.2 更新tap_scalecqt_abnormalgrid.infospot_flag
       UPDATE tap_scalecqt_abnormalgrid
       SET infospot_flag = infospotFlag2
       WHERE analyse_period_datetime = inAnalysePeriodDatetime
       AND parent_id IS NULL
       AND infospot_flag IS NULL
       AND id IN
       (
           SELECT infospot.scalecqt_abnormalgrid_id
           FROM tap_scalecqt_abnormalgrid g
           INNER JOIN tap_scalecqt_infospot infospot ON g.id = infospot.scalecqt_abnormalgrid_id
           WHERE g.analyse_period_datetime = inAnalysePeriodDatetime
           AND infospot.infospot_source_flag = infospotSourceFlagOfRelated
       );

       --2.2 当异常栅格无关联信息点时，寻找一层栅格
       INSERT INTO tap_scalecqt_abnormalgrid
       (
              id,
              parent_id,
              analyse_period_datetime,
              grid_num,
              region_id,
              tl_longitude,
              tl_latitude,
              br_longitude,
              br_latitude,
              c_x,
              c_y,
              abnormalgrid_category,
              location_category,
              infospot_flag,
              problem_category,
              is_need_dispatch_wo,
              wo_id,
              run_begin_time,
              run_end_time
       )
       SELECT
             SYS_GUID() AS id,
             ag.id AS parent_id,
             --inAnalysePeriodDatetime AS analyse_period_datetime,
             NULL AS analyse_period_datetime,
             gr.adj_grid_num AS grid_num,
             --ag.region_id,
             NULL AS region_id,
             NULL AS tl_longitude,
             NULL AS tl_latitude,
             NULL AS br_longitude,
             NULL AS br_latitude,
             NULL AS c_x,
             NULL AS c_y,
             --ag.abnormalgrid_category,
             NULL AS abnormalgrid_category,
             NULL AS location_category,
             NULL AS infospot_flag,
             NULL AS problem_category,
             NULL AS is_need_dispatch_wo,
             NULL AS wo_id,
             --runBeginTime AS run_begin_time,
             NULL AS run_begin_time,
             NULL AS run_end_time
       FROM tap_scalecqt_abnormalgrid ag
       INNER JOIN tap_grid_adj_relation gr ON ag.grid_num = gr.grid_num
       WHERE ag.infospot_flag IS NULL
       AND ag.analyse_period_datetime = inAnalysePeriodDatetime;

       --2.3 初始化一层栅格的信息点
       INSERT INTO tap_scalecqt_infospot
       (
              id,
              scalecqt_abnormalgrid_id,
              infospot_source_flag,
              infospot_id,
              infospot_code,
              infospot_name,
              related_indoor_code,
              --repeater_code,
              indoor_id,
              indoor_code,
              is_has_indoor,
              ss_cell_id,
              ss_cell_name,
              is_over_abnormalcell_threshold,
              result,
              signal2g,
              signal3g,
              x,
              y,
              is_in_wqp_lib,
              wqp_lib_id,
              c_solved_date,
              indoor_adjustscheme_category,
              indoor_adjustscheme_code,
              survey_indoor_id,
              survey_indoor_code,
              survey_indoor_name,
              is_has_survey_indoor,
              indoor_level_before_adjust,
              indoor_level,
              bts_adjustscheme_category,
              bts_adjustscheme_code,
              survey_bts_id,
              survey_bts_code,
              survey_bts_name,
              is_has_survey_bts,
              bts_priority_before_adjust,
              bts_priority,
              problem_category,
              is_need_dispatch_wo,
              wo_id,
              dispatch_object
       )
       SELECT
              SYS_GUID() AS id,
              g.id AS scalecqt_abnormalgrid_id,
              infospotSourceFlagOfLayerGrid AS infospot_source_flag,
              infospot.int_id AS infospot_id,
              infospot.inforspot_id AS infospot_code,
              infospot.inforspot_name AS infospot_name,
              infospot.indoors_no AS related_indoor_code,
              --indoor.reserve_field_1 repeater_code,
              NULL AS indoor_id,
              NULL AS indoor_code,
              NULL AS is_has_indoor,
              NULL AS ss_cell_id,
              NULL AS ss_cell_name,
              NULL AS is_over_abnormalcell_threshold,
              NULL AS result,
              infospot.signal2g,
              infospot.signal3g,
              infospot.inforspot_x AS x,
              infospot.inforspot_y AS y,
              NULL AS is_in_wqp_lib,
              NULL AS wqp_lib_id,
              NULL AS c_solved_date,
              NULL AS indoor_adjustscheme_category,
              NULL AS indoor_adjustscheme_code,
              NULL AS survey_indoor_id,
              NULL AS survey_indoor_code,
              NULL AS survey_indoor_name,
              NULL AS is_has_survey_indoor,
              NULL AS indoor_level_before_adjust,
              NULL AS indoor_level,
              NULL AS bts_adjustscheme_category,
              NULL AS bts_adjustscheme_code,
              NULL AS survey_bts_id,
              NULL AS survey_bts_code,
              NULL AS survey_bts_name,
              NULL AS is_has_survey_bts,
              NULL AS bts_priority_before_adjust,
              NULL AS bts_priority,
              NULL AS problem_category,
              NULL AS is_need_dispatch_wo,
              NULL AS wo_id,
              NULL AS dispatch_object
       FROM tap_scalecqt_abnormalgrid g
       INNER JOIN tap_scalecqt_abnormalgrid g2 ON g.parent_id = g2.id
       INNER JOIN c_tco_pro_inforspot infospot ON g.grid_num = infospot.related_grid
       --LEFT JOIN c_tco_pro_indoors indoor on infospot.indoors_no = indoor.indds_code
       WHERE g2.analyse_period_datetime = inAnalysePeriodDatetime
       --AND g2.run_end_time IS NULL
       --AND g.run_end_time IS NULL
       --AND g.parent_id IS NOT NULL
       AND NOT EXISTS
       (
           SELECT 1
           FROM tap_scalecqt_infospot infospot2
           INNER JOIN tap_scalecqt_abnormalgrid g3 ON infospot2.scalecqt_abnormalgrid_id = g3.id
           WHERE infospot.int_id = infospot2.infospot_id
           AND g3.parent_id IS NULL
           AND g3.analyse_period_datetime = inAnalysePeriodDatetime
       );

       --2.4 更新tap_scalecqt_abnormalgrid.infospot_flag
       UPDATE tap_scalecqt_abnormalgrid
       SET infospot_flag = infospotFlag0
       WHERE analyse_period_datetime = inAnalysePeriodDatetime
       AND parent_id IS NULL
       AND infospot_flag IS NULL
       AND id IN
       (
           SELECT g2.id
           FROM tap_scalecqt_abnormalgrid g
           INNER JOIN tap_scalecqt_abnormalgrid g2 ON g.parent_id = g2.id
           INNER JOIN tap_scalecqt_infospot infospot ON g.id = infospot.scalecqt_abnormalgrid_id
           WHERE g2.analyse_period_datetime = inAnalysePeriodDatetime
           AND infospot.infospot_source_flag = infospotSourceFlagOfLayerGrid
       );

       --2.5 异常栅格无信息点，辅助的一层栅格也无信息点，更新tap_scalecqt_abnormalgrid.infospot_flag
       UPDATE tap_scalecqt_abnormalgrid
       SET infospot_flag = infospotFlag1
       WHERE analyse_period_datetime = inAnalysePeriodDatetime
       AND parent_id IS NULL
       AND infospot_flag IS NULL;

       /*
       --2.6 异常栅格无信息点，辅助的一层栅格也无信息点，直接按栅格派单（infospot_flag = 1）
       UPDATE tap_scalecqt_abnormalgrid
       SET
              problem_category = problemCategory7,
              is_need_dispatch_wo = yes--,
              --run_end_time = SYSDATE
       WHERE analyse_period_datetime = inAnalysePeriodDatetime
       AND parent_id IS NULL
       AND infospot_flag = infospotFlag1;
       */

       --2.6 判断无信息点的异常栅格是否有建筑物
       INSERT INTO tap_scalecqt_grid_building
       (
              id,
              scalecqt_abnormalgrid_id,
              building_id,
              building_name,
              building_longitude,
              building_latitude
       )
       SELECT SYS_GUID() AS id,
              g.id AS scalecqt_abnormalgrid_id,
              b.int_id AS building_id,
              b.name AS building_name,
              b.longitude AS building_longitude,
              b.latitude AS building_latitude
       FROM tap_building b
       INNER JOIN tap_scalecqt_abnormalgrid g ON b.longitude >= g.tl_longitude AND b.longitude <= g.br_longitude
       AND b.latitude <= g.tl_latitude AND b.latitude >= g.br_latitude
       WHERE g.analyse_period_datetime = inAnalysePeriodDatetime
       AND g.parent_id IS NULL
       AND g.infospot_flag = infospotFlag1;

       --2.7 异常栅格无信息点，辅助的一层栅格也无信息点，有建筑物时直接按栅格派单（infospot_flag = 1）
       UPDATE tap_scalecqt_abnormalgrid
       SET
              problem_category = problemCategory7,
              is_need_dispatch_wo = yes--,
              --run_end_time = SYSDATE
       WHERE analyse_period_datetime = inAnalysePeriodDatetime
       AND parent_id IS NULL
       AND infospot_flag = infospotFlag1
       AND id IN
       (
           SELECT ag.id
           FROM tap_scalecqt_abnormalgrid ag
           INNER JOIN tap_scalecqt_grid_building gb ON ag.id = gb.scalecqt_abnormalgrid_id
           WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
           AND ag.parent_id IS NULL
           AND ag.infospot_flag = infospotFlag1
       );

       --2.8 异常栅格无信息点，辅助的一层栅格也无信息点，无建筑物时不派单（infospot_flag = 1）
       UPDATE tap_scalecqt_abnormalgrid
       SET
              problem_category = problemCategory9--,
              --is_need_dispatch_wo = yes--,
              --run_end_time = SYSDATE
       WHERE analyse_period_datetime = inAnalysePeriodDatetime
       AND parent_id IS NULL
       AND infospot_flag = infospotFlag1
       AND id NOT IN
       (
           SELECT ag.id
           FROM tap_scalecqt_abnormalgrid ag
           INNER JOIN tap_scalecqt_grid_building gb ON ag.id = gb.scalecqt_abnormalgrid_id
           WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
           AND ag.parent_id IS NULL
           AND ag.infospot_flag = infospotFlag1
       );

       /*

       --2.9 初始化异常栅格中心经纬度距离最近的TOPN信息点（TODO：此步骤耗费时间太长）
       INSERT INTO tap_scalecqt_infospot
       (
              id,
              scalecqt_abnormalgrid_id,
              infospot_source_flag,
              infospot_id,
              infospot_code,
              infospot_name,
              related_indoor_code,
              indoor_id,
              indoor_code,
              is_has_indoor,
              ss_cell_id,
              ss_cell_name,
              is_over_abnormalcell_threshold,
              result,
              signal2g,
              signal3g,
              x,
              y,
              is_in_wqp_lib,
              wqp_lib_id,
              c_solved_date,
              indoor_adjustscheme_category,
              indoor_adjustscheme_code,
              survey_indoor_id,
              survey_indoor_code,
              survey_indoor_name,
              is_has_survey_indoor,
              indoor_level_before_adjust,
              indoor_level,
              bts_adjustscheme_category,
              bts_adjustscheme_code,
              survey_bts_id,
              survey_bts_code,
              survey_bts_name,
              is_has_survey_bts,
              bts_priority_before_adjust,
              bts_priority,
              problem_category,
              is_need_dispatch_wo,
              wo_id,
              dispatch_object
       )
       SELECT id,
              scalecqt_abnormalgrid_id,
              infospot_source_flag,
              infospot_id,
              infospot_code,
              infospot_name,
              related_indoor_code,
              indoor_id,
              indoor_code,
              is_has_indoor,
              ss_cell_id,
              ss_cell_name,
              is_over_abnormalcell_threshold,
              result,
              signal2g,
              signal3g,
              x,
              y,
              is_in_wqp_lib,
              wqp_lib_id,
              c_solved_date,
              indoor_adjustscheme_category,
              indoor_adjustscheme_code,
              survey_indoor_id,
              survey_indoor_code,
              survey_indoor_name,
              is_has_survey_indoor,
              indoor_level_before_adjust,
              indoor_level,
              bts_adjustscheme_category,
              bts_adjustscheme_code,
              survey_bts_id,
              survey_bts_code,
              survey_bts_name,
              is_has_survey_bts,
              bts_priority_before_adjust,
              bts_priority,
              problem_category,
              is_need_dispatch_wo,
              wo_id,
              dispatch_object
       FROM
       (
           SELECT
                  SYS_GUID() AS id,
                  g.id AS scalecqt_abnormalgrid_id,
                  infospotSourceFlagOfNearby AS infospot_source_flag,
                  infospot.int_id AS infospot_id,
                  infospot.inforspot_id AS infospot_code,
                  infospot.inforspot_name AS infospot_name,
                  infospot.indoors_no AS related_indoor_code,
                  NULL AS indoor_id,
                  NULL AS indoor_code,
                  NULL AS is_has_indoor,
                  NULL AS ss_cell_id,
                  NULL AS ss_cell_name,
                  NULL AS is_over_abnormalcell_threshold,
                  NULL AS result,
                  infospot.signal2g,
                  infospot.signal3g,
                  infospot.inforspot_x AS x,
                  infospot.inforspot_y AS y,
                  NULL AS is_in_wqp_lib,
                  NULL AS wqp_lib_id,
                  NULL AS c_solved_date,
                  NULL AS indoor_adjustscheme_category,
                  NULL AS indoor_adjustscheme_code,
                  NULL AS survey_indoor_id,
                  NULL AS survey_indoor_code,
                  NULL AS survey_indoor_name,
                  NULL AS is_has_survey_indoor,
                  NULL AS indoor_level_before_adjust,
                  NULL AS indoor_level,
                  NULL AS bts_adjustscheme_category,
                  NULL AS bts_adjustscheme_code,
                  NULL AS survey_bts_id,
                  NULL AS survey_bts_code,
                  NULL AS survey_bts_name,
                  NULL AS is_has_survey_bts,
                  NULL AS bts_priority_before_adjust,
                  NULL AS bts_priority,
                  NULL AS problem_category,
                  NULL AS is_need_dispatch_wo,
                  NULL AS wo_id,
                  NULL AS dispatch_object,
                  SQRT(POWER(g.c_x - infospot.inforspot_x, 2) + POWER(g.c_y - infospot.inforspot_y, 2)) AS distance,
                  ROW_NUMBER() OVER(PARTITION BY g.grid_num ORDER BY SQRT(POWER(g.c_x - infospot.inforspot_x, 2) + POWER(g.c_y - infospot.inforspot_y, 2)) ASC) AS row_index
           FROM tap_scalecqt_abnormalgrid g
           INNER JOIN c_tco_pro_inforspot infospot ON g.grid_num <> infospot.related_grid
           WHERE g.analyse_period_datetime = inAnalysePeriodDatetime
           --AND g.run_end_time IS NULL
           AND g.parent_id IS NULL
           AND g.infospot_flag = infospotFlag0
           AND NOT EXISTS
           (
               SELECT 1
               FROM tap_scalecqt_infospot infospot2
               INNER JOIN tap_scalecqt_abnormalgrid g3 ON infospot2.scalecqt_abnormalgrid_id = g3.id
               WHERE infospot.int_id = infospot2.infospot_id
               AND g3.analyse_period_datetime = inAnalysePeriodDatetime
           )
       ) t
       WHERE t.row_index <= topNOfNearby;

       */


       COMMIT;

END;
