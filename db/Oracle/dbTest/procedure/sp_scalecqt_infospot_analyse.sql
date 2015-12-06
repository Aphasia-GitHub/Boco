CREATE OR REPLACE PROCEDURE sp_scalecqt_infospot_analyse
(
       inAnalysePeriodDatetime in date
)
IS
       --runBeginTime date := SYSDATE;

       --abnormalgridCategory2g varchar2(128) := '2G�쳣դ��';
       --abnormalgridCategory3g varchar2(128) := '3G�쳣դ��';
       --abnormalgridCategory2g3g varchar2(128) := '2G/3G�쳣դ��';
       --netTechnology2g varchar2(2) := '2G';
       --netTechnology3g varchar2(2) := '3G';

       --����Ϣ��Ϊ�쳣դ���������Ϣ��
       --infospotSourceFlagOfRelated number := 1;
       --�쳣դ���ܱ�һ��դ���������Ϣ��
       infospotSourceFlagOfLayerGrid number := 2;
       --�쳣դ�����ľ�γ�ȸ�������Ϣ��
       infospotSourceFlagOfNearby number := 3;

       --�쳣դ������Ϣ�㣬����һ��դ����Ϣ����к����жϣ�tap_scalecqt_infospot.infospot_source_flag = 2��tap_scalecqt_infospot.infospot_source_flag = 3������ʼ���裩
       --infospotFlag0 number := 0;
       --�쳣դ������Ϣ�㣬������һ��դ��Ҳ����Ϣ�㣬ֱ�Ӱ�դ���ɵ�������ʼ���裬����infospot_flag = 0��
       --infospotFlag1 number := 1;
       --�쳣դ������Ϣ�㣬�����������жϣ�tap_scalecqt_infospot.infospot_source_flag = 1������ʼ���裩
       infospotFlag2 number := 2;
       --�쳣դ������Ϣ�㣬����������Ϣ�㣬����һ��դ����Ϣ����к����жϣ�tap_scalecqt_infospot.infospot_source_flag = 2��tap_scalecqt_infospot.infospot_source_flag = 3�����ڶ�Ȧ������infospot_flag = 2��
       infospotFlag3 number := 3;
       --�쳣դ������Ϣ�㣬����������Ϣ�㣬����һ��դ��Ҳ����Ϣ�㣻���ڶ�Ȧ������infospot_flag = 2��
       infospotFlag4 number := 4;

       --�쳣դ�����ľ�γ�Ⱦ��������TOP N��TODO���������ж�ȡ��
       --topNOfNearby number := 10;

       --problemCategory1 varchar2(128) := '��Ϣ���쳣����ԴС���쳣';
       --problemCategory2 varchar2(128) := '��Ϣ���쳣���ܱ߻�վ�쳣';
       --problemCategory3 varchar2(128) := '��Ϣ���쳣�����Ż�';
       --problemCategory4 varchar2(128) := '��Ϣ���쳣���������滮����';
       --problemCategory5 varchar2(128) := '��Ϣ���쳣�������滮����';
       --problemCategory8 varchar2(128) := '��Ϣ���쳣���滮�����������ֵ����������';
       --problemCategory6 varchar2(128) := '��Ϣ��������դ���쳣';
       problemCategory6 varchar2(128) := '�쳣դ����֪��Ϣ������';
       --problemCategory7 varchar2(128) := '����Ϣ�㣬դ���쳣';
       --problemCategory7 varchar2(128) := '�쳣դ��դ�����н���������Ϣ��';
       --problemCategory9 varchar2(128) := 'դ���쳣��դ�����޽�������ɵ�';
       --problemCategory9 varchar2(128) := '�쳣դ��դ�����޽���������Ϣ��';

       --2G�쳣С������
       --abnormalCellCategory2g varchar2(200);
       --3G�쳣С������
       --abnormalCellCategory3g varchar2(200);

       --��ԴС�������
       --signalSourceCellResult1 varchar2(128) := '����Ϣ���ҷ���ԴС�������쳣����ͨ���쳣С���ɵ�����ģCQT�����ظ��ɵ�';
       --signalSourceCellResult2 varchar2(128) := '����Ϣ���ҷ���ԴС�������쳣���쳣С��δ�ɵ�����ģCQT��С���ɵ�';
       --�ܱ߻�վС�������
       --nearbyCellResult1 varchar2(128) := '����Ϣ���ܱ߻�վС�������쳣����ͨ���쳣С���ɵ�����ģCQT�����ظ��ɵ�';
       --nearbyCellResult2 varchar2(128) := '����Ϣ���ܱ߻�վС�������쳣���쳣С��δ�ɵ�����ģCQT��С���ɵ�';
       --�쳣С���Ĺ���Դ
       --woSourceOfAbnormalCell number := 2;
       --�����Ľᵥ״̬
       --woStatusOfFinish number := 4;
       --�ɵ�����
       --dispatchObjectOfCell varchar2(20) := 'Cell';
       --dispatchObjectOfInfoSpot varchar2(20) := 'InfoSpot';

       --���Խ��-��
       --testResultOfPoor varchar2(20) := '��';

       --�ҷֹ滮�� M �� N �Σ�TODO���������ж�ȡ��
       --surveyIndoorDays number := 90;
       --surveyIndoorTimes number := 0;

       --��վ�滮�� M �� N �Σ�TODO���������ж�ȡ��
       --surveyBtsDays number := 90;
       --surveyBtsTimes number := 0;

       --�ܱ߻�վ�ĸ�����Ĭ����4
       --btsNumberOfNearby number := 4;


       yes varchar2(1) := 'Y';
       --no varchar2(1) := 'N';

       --yesOfNumber number := 1;
       --noOfNumber number := 0;

BEGIN
      delete from AbInfospotAnalyse_log where period_time = inAnalysePeriodDatetime;
      insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 0, sysdate);
      commit;

      --��ʼ����Ϣ��
      sp_scalecqt_init_infospot(inAnalysePeriodDatetime);
      insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 1, sysdate);

      --Ѱ�����������Ϣ�㼯��
      INSERT INTO tap_scalecqt_infospot_cache
      (
            analyse_period_datetime,
            id
      )
      SELECT g.analyse_period_datetime,
             sci.id
      FROM tap_scalecqt_abnormalgrid g
      INNER JOIN tap_scalecqt_infospot sci ON g.id = sci.scalecqt_abnormalgrid_id
      WHERE g.analyse_period_datetime = inAnalysePeriodDatetime
      AND g.parent_id IS NULL

      UNION

      SELECT g2.analyse_period_datetime,
             sci.id
      FROM tap_scalecqt_abnormalgrid g
      INNER JOIN tap_scalecqt_abnormalgrid g2 ON g.parent_id = g2.id
      INNER JOIN tap_scalecqt_infospot sci ON g.id = sci.scalecqt_abnormalgrid_id
      WHERE g2.analyse_period_datetime = inAnalysePeriodDatetime;

      insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 2, sysdate);
commit;
      --������Ϣ������㷨������
      sp_scalecqt_infospot_resolve(inAnalysePeriodDatetime);

      insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 3, sysdate);


       --7 �ж�դ���������Ϣ�����Ƿ����0������0ʱ��ͨ���ܱ�һ��դ������ж�
       --7.1 �ҳ�һ��դ����Ϣ���������դ�񣬲�����problem_category
       UPDATE tap_scalecqt_abnormalgrid
       SET
              problem_category = problemCategory6,
              is_need_dispatch_wo = yes--,
              --run_end_time = SYSDATE
       WHERE id IN
       (
             SELECT DISTINCT ag2.id
             FROM tap_scalecqt_abnormalgrid ag
             INNER JOIN tap_scalecqt_abnormalgrid ag2 ON ag.parent_id = ag2.id
             INNER JOIN tap_scalecqt_infospot infospot ON ag.id = infospot.scalecqt_abnormalgrid_id
             WHERE ag2.analyse_period_datetime = inAnalysePeriodDatetime
             AND ag2.parent_id IS NULL
             AND infospot.problem_category IS NULL
             AND ag2.id NOT IN
             (
                 SELECT DISTINCT ag2.id
                 FROM tap_scalecqt_abnormalgrid ag
                 INNER JOIN tap_scalecqt_abnormalgrid ag2 ON ag.parent_id = ag2.id
                 INNER JOIN tap_scalecqt_infospot infospot ON ag.id = infospot.scalecqt_abnormalgrid_id
                 WHERE ag2.analyse_period_datetime = inAnalysePeriodDatetime
                 AND ag2.parent_id IS NULL
                 AND infospot.problem_category IS NOT NULL
             )
       );

       insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 4, sysdate);

       --7.2 Ѱ��������Ϣ�����Ϊ����쳣դ��
       INSERT INTO tap_scalecqt_grid_cache
       (
              analyse_period_datetime,
              id,
              grid_num
       )
       SELECT ag.analyse_period_datetime,
              ag.id,
              ag.grid_num
       FROM tap_scalecqt_abnormalgrid ag
       WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
       AND ag.parent_id IS NULL
       AND ag.id NOT IN
       (
             --���쳣��դ��դ���쳣��
             SELECT ag.id
             FROM tap_scalecqt_abnormalgrid ag
             WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
             AND ag.parent_id IS NULL
             AND ag.problem_category IS NOT NULL

             UNION

             --���쳣��դ���쳣դ�����Ϣ���쳣�������쳣դ�����ľ�γ�ȸ�������Ϣ���쳣��
             SELECT DISTINCT ag.id
             FROM tap_scalecqt_abnormalgrid ag
             INNER JOIN tap_scalecqt_infospot infospot ON ag.id = infospot.scalecqt_abnormalgrid_id
             WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
             AND ag.parent_id IS NULL
             AND infospot.problem_category IS NOT NULL

             UNION

             --���쳣��դ��һ��դ���Ӧ����Ϣ���쳣��
             SELECT DISTINCT ag2.id
             FROM tap_scalecqt_abnormalgrid ag
             INNER JOIN tap_scalecqt_abnormalgrid ag2 ON ag.parent_id = ag2.id
             INNER JOIN tap_scalecqt_infospot infospot ON ag.id = infospot.scalecqt_abnormalgrid_id
             WHERE ag2.analyse_period_datetime = inAnalysePeriodDatetime
             AND ag2.parent_id IS NULL
             AND infospot.problem_category IS NOT NULL
       );

       insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 5, sysdate);

       --7.2 Ѱ��������Ϣ�����Ϊ����쳣դ�񣬶�Ӧ��һ��դ��
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
             agc.id AS parent_id,
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
       FROM tap_scalecqt_grid_cache agc
       INNER JOIN tap_grid_adj_relation gr ON agc.grid_num = gr.grid_num
       WHERE agc.analyse_period_datetime = inAnalysePeriodDatetime;

       insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 6, sysdate);

       --7.3 ��ʼ��һ��դ�����Ϣ��
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
       SELECT
              SYS_GUID() AS id,
              g.id AS scalecqt_abnormalgrid_id,
              infospotSourceFlagOfLayerGrid AS infospot_source_flag,
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
              NULL AS dispatch_object
       FROM tap_scalecqt_abnormalgrid g
       INNER JOIN tap_scalecqt_abnormalgrid g2 ON g.parent_id = g2.id
       INNER JOIN tap_scalecqt_grid_cache agc ON g2.id = agc.id
       INNER JOIN c_tco_pro_inforspot infospot ON g.grid_num = infospot.related_grid
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

       insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 7, sysdate);

       --7.4 ����tap_scalecqt_abnormalgrid.infospot_flag
       UPDATE tap_scalecqt_abnormalgrid
       SET infospot_flag = infospotFlag3
       WHERE analyse_period_datetime = inAnalysePeriodDatetime
       AND parent_id IS NULL
       --AND infospot_flag IS NULL
       AND infospot_flag = infospotFlag2
       AND id IN
       (
           SELECT g2.id
           FROM tap_scalecqt_abnormalgrid g
           INNER JOIN tap_scalecqt_abnormalgrid g2 ON g.parent_id = g2.id
           INNER JOIN tap_scalecqt_grid_cache agc ON g2.id = agc.id
           INNER JOIN tap_scalecqt_infospot infospot ON g.id = infospot.scalecqt_abnormalgrid_id
           WHERE g2.analyse_period_datetime = inAnalysePeriodDatetime
           AND infospot.infospot_source_flag = infospotSourceFlagOfLayerGrid
       );

       insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 8, sysdate);

       --7.5 �쳣դ����������Ϣ�㣬������һ��դ��Ҳ����Ϣ�㣬����tap_scalecqt_abnormalgrid.infospot_flag
       UPDATE tap_scalecqt_abnormalgrid
       SET infospot_flag = infospotFlag4
       WHERE analyse_period_datetime = inAnalysePeriodDatetime
       AND parent_id IS NULL
       --AND infospot_flag IS NULL
       AND infospot_flag = infospotFlag2
       AND id IN
       (
           SELECT id
           FROM tap_scalecqt_grid_cache
       )
       AND id NOT IN
       (
           SELECT ag.id
           FROM tap_scalecqt_abnormalgrid ag
           WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
           AND ag.infospot_flag = infospotFlag3
       );

       insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 9, sysdate);

       --7.6 �쳣դ����������Ϣ�㣬������һ��դ��Ҳ����Ϣ�㣬ֱ�Ӱ�դ���ɵ���infospot_flag = 4��
       UPDATE tap_scalecqt_abnormalgrid
       SET
              problem_category = problemCategory6,
              is_need_dispatch_wo = yes--,
              --run_end_time = SYSDATE
       WHERE analyse_period_datetime = inAnalysePeriodDatetime
       AND parent_id IS NULL
       AND infospot_flag = infospotFlag4;

       --7.7 ˢ��դ�񻺴�
       DELETE FROM tap_scalecqt_grid_cache
       WHERE id IN
       (
             SELECT ag.id
             FROM tap_scalecqt_abnormalgrid ag
             WHERE ag.analyse_period_datetime = inAnalysePeriodDatetime
             AND ag.infospot_flag = infospotFlag4
       );

       insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 10, sysdate);

       --7.8 ��ʼ���쳣դ�����ľ�γ�Ⱦ��������TOPN��Ϣ�㣨TODO���˲���ķ�ʱ��̫����
       /*INSERT INTO tap_scalecqt_infospot
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
           INNER JOIN tap_scalecqt_grid_cache agc ON g.id = agc.id
           INNER JOIN c_tco_pro_inforspot infospot ON g.grid_num <> infospot.related_grid
           WHERE g.analyse_period_datetime = inAnalysePeriodDatetime
           --AND g.run_end_time IS NULL
           AND g.parent_id IS NULL
           AND g.infospot_flag = infospotFlag3
           AND NOT EXISTS
           (
               SELECT 1
               FROM tap_scalecqt_infospot infospot2
               INNER JOIN tap_scalecqt_abnormalgrid g3 ON infospot2.scalecqt_abnormalgrid_id = g3.id
               WHERE infospot.int_id = infospot2.infospot_id
               AND g3.analyse_period_datetime = inAnalysePeriodDatetime
           )
       ) t
       WHERE t.row_index <= topNOfNearby;*/


       --7.9 Ѱ������η�������Ϣ�㼯��
       INSERT INTO tap_scalecqt_infospot_cache
       (
              analyse_period_datetime,
              id
       )
       SELECT agc.analyse_period_datetime,
              sci.id
       FROM tap_scalecqt_abnormalgrid ag
       INNER JOIN tap_scalecqt_grid_cache agc ON ag.parent_id = agc.id
       INNER JOIN tap_scalecqt_infospot sci ON ag.id = sci.scalecqt_abnormalgrid_id
       WHERE agc.analyse_period_datetime = inAnalysePeriodDatetime
       AND sci.infospot_source_flag = infospotSourceFlagOfLayerGrid

       UNION

       SELECT agc.analyse_period_datetime,
              sci.id
       FROM tap_scalecqt_grid_cache agc
       INNER JOIN tap_scalecqt_infospot sci ON agc.id = sci.scalecqt_abnormalgrid_id
       WHERE agc.analyse_period_datetime = inAnalysePeriodDatetime
       AND sci.infospot_source_flag = infospotSourceFlagOfNearby;

       insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 11, sysdate);

       --7.10 ������Ϣ������㷨������
       sp_scalecqt_infospot_resolve(inAnalysePeriodDatetime);

       insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 12, sysdate);


       --7.11 �жϣ��ڶ��η����ģ�դ���������Ϣ�����Ƿ����0������0����դ���ɵ�������Ϣ��������դ���쳣��
       UPDATE tap_scalecqt_abnormalgrid
       SET
              problem_category = problemCategory6,
              is_need_dispatch_wo = yes--,
              --run_end_time = SYSDATE
       WHERE id IN
       (
             SELECT DISTINCT agc.id
             FROM tap_scalecqt_abnormalgrid ag
             INNER JOIN tap_scalecqt_grid_cache agc ON ag.parent_id = agc.id
             INNER JOIN tap_scalecqt_infospot sci ON ag.id = sci.scalecqt_abnormalgrid_id
             WHERE agc.analyse_period_datetime = inAnalysePeriodDatetime
             AND sci.infospot_source_flag = infospotSourceFlagOfLayerGrid
             AND sci.problem_category IS NULL

             UNION

             SELECT agc.id
             FROM tap_scalecqt_grid_cache agc
             INNER JOIN tap_scalecqt_infospot sci ON agc.id = sci.scalecqt_abnormalgrid_id
             WHERE agc.analyse_period_datetime = inAnalysePeriodDatetime
             AND sci.infospot_source_flag = infospotSourceFlagOfNearby
             AND sci.problem_category IS NULL
       )
       AND problem_category IS NULL
       AND infospot_flag = infospotFlag3;


       DELETE FROM tap_scalecqt_grid_cache
       WHERE analyse_period_datetime = inAnalysePeriodDatetime;


       insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 13, sysdate);

       COMMIT;

END;
