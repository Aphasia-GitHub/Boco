CREATE OR REPLACE PROCEDURE sp_scalecqt_infospot_resolve
(
       inAnalysePeriodDatetime in date
)
IS
       --runBeginTime date := SYSDATE;

       abnormalgridCategory2g varchar2(128) := '2G�쳣դ��';
       abnormalgridCategory3g varchar2(128) := '3G�쳣դ��';
       abnormalgridCategory2g3g varchar2(128) := '2G/3G�쳣դ��';
       netTechnology2g varchar2(2) := '2G';
       netTechnology3g varchar2(2) := '3G';

       --����Ϣ��Ϊ�쳣դ���������Ϣ��
       --infospotSourceFlagOfRelated number := 1;
       --�쳣դ���ܱ�һ��դ���������Ϣ��
       --infospotSourceFlagOfLayerGrid number := 2;
       --�쳣դ�����ľ�γ�ȸ�������Ϣ��
       --infospotSourceFlagOfNearby number := 3;

       --�쳣դ������Ϣ�㣬����һ��դ����Ϣ����к����жϣ�tap_scalecqt_infospot.infospot_source_flag = 2��tap_scalecqt_infospot.infospot_source_flag = 3������ʼ���裩
       --infospotFlag0 number := 0;
       --�쳣դ������Ϣ�㣬������һ��դ��Ҳ����Ϣ�㣬ֱ�Ӱ�դ���ɵ�������ʼ���裬����infospot_flag = 0��
       --infospotFlag1 number := 1;
       --�쳣դ������Ϣ�㣬�����������жϣ�tap_scalecqt_infospot.infospot_source_flag = 1������ʼ���裩
       --infospotFlag2 number := 2;
       --�쳣դ������Ϣ�㣬����������Ϣ�㣬����һ��դ����Ϣ����к����жϣ�tap_scalecqt_infospot.infospot_source_flag = 2��tap_scalecqt_infospot.infospot_source_flag = 3�����ڶ�Ȧ������infospot_flag = 2��
       --infospotFlag3 number := 3;
       --�쳣դ������Ϣ�㣬����������Ϣ�㣬����һ��դ��Ҳ����Ϣ�㣻���ڶ�Ȧ������infospot_flag = 2��
       --infospotFlag4 number := 4;

       --�쳣դ�����ľ�γ�Ⱦ��������TOP N��TODO���������ж�ȡ��
       --topNOfNearby number := 10;
       problemCategory0 varchar2(128) := '��Ϣ���쳣���ҷ�ֱ��վ�쳣';
       problemCategory1 varchar2(128) := '��Ϣ���쳣����ԴС���쳣';
       problemCategory2 varchar2(128) := '��Ϣ���쳣����ʷ���Բ����������';
       problemCategory3 varchar2(128) := '��Ϣ���쳣�����������ҷֹ滮�ȼ�';
       problemCategory4 varchar2(128) := '��Ϣ���쳣���������к�վ�滮�ȼ�';
       problemCategory5 varchar2(128) := '��Ϣ���쳣��������������⣬�޹滮';
       problemCategory6 varchar2(128) := '��Ϣ���쳣���ܱ߻�վ�쳣';
       --problemCategory7 varchar2(128) := '����Ϣ�㣬դ���쳣';

       problemCategory8 varchar2(128) := '��Ϣ���쳣���滮�����������ֵ����������';

       --2G�쳣С������
       abnormalCellCategory2g varchar2(200);
       --3G�쳣С������
       abnormalCellCategory3g varchar2(200);

       --��ԴС�������
       signalSourceCellResult1 varchar2(128) := '����Ϣ���ҷ���ԴС�������쳣����ͨ���쳣С���ɵ�����ģCQT�����ظ��ɵ�';
       signalSourceCellResult2 varchar2(128) := '����Ϣ���ҷ���ԴС�������쳣���쳣С��δ�ɵ�����ģCQT��С���ɵ�';
       --�ܱ߻�վС�������
       nearbyCellResult1 varchar2(128) := '����Ϣ���ܱ߻�վС�������쳣����ͨ���쳣С���ɵ�����ģCQT�����ظ��ɵ�';
       nearbyCellResult2 varchar2(128) := '����Ϣ���ܱ߻�վС�������쳣���쳣С��δ�ɵ�����ģCQT��С���ɵ�';
       --�쳣С���Ĺ���Դ
       woSourceOfAbnormalCell number := 2;
       --�����Ľᵥ״̬
       woStatusOfFinish number := 4;
       --�ɵ�����
       dispatchObjectOfCell varchar2(20) := 'Cell';
       dispatchObjectOfInfoSpot varchar2(20) := 'InfoSpot';

       --���Խ��-��
       testResultOfPoor varchar2(20) := '��';

       --�ҷֹ滮�� M �� N �Σ�TODO���������ж�ȡ��
       surveyIndoorDays number := 90;
       surveyIndoorTimes number := 0;

       --��վ�滮�� M �� N �Σ�TODO���������ж�ȡ��
       surveyBtsDays number := 90;
       surveyBtsTimes number := 0;

       --�ܱ߻�վ�ĸ�����Ĭ����4
       btsNumberOfNearby number := 4;

       yes varchar2(1) := 'Y';
       no varchar2(1) := 'N';

BEGIN


       --4.1 ��Ϣ�����ҷ�
       UPDATE tap_scalecqt_infospot
       SET(indoor_id, indoor_code, is_has_indoor, ss_cell_id, ss_cell_name,repeater_code) =
       (
             SELECT indoor.int_id,
                    indoor.indds_code,
                    yes,
                    indoor.related_cell,
                    cell.name,
                    indoor.reserve_field_1
             FROM c_tco_pro_indoors indoor
             INNER JOIN c_tco_pro_cell cell ON indoor.related_cell = cell.int_id
             WHERE tap_scalecqt_infospot.related_indoor_code = indoor.indds_code
       )
       WHERE id IN
       (
             SELECT id
             FROM tap_scalecqt_infospot_cache
             WHERE analyse_period_datetime = inAnalysePeriodDatetime
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 101, sysdate);
 commit; --add by maojun ����

       --4.2 �����쳣դ��Ĵ��ʱ�䣬��ʼ����ԴС����ʱ���
       INSERT INTO tap_scalecqt_cell_cache
       (
              analyse_period_datetime,
              net_technology,
              scalecqt_abnormalgrid_id,
              scalecqt_infospot_id,
              scalecqt_cell_id,
              cell_id,
              analyse_datetime
       )
       SELECT g.analyse_period_datetime,
              gd.net_technology,
              g.id AS scalecqt_abnormalgrid_id,
              infospot.id AS scalecqt_infospot_id,
              NULL AS scalecqt_cell_id,
              infospot.ss_cell_id,
              gd.analyse_datetime
       FROM tap_scalecqt_abnormalgrid g
       INNER JOIN tap_scalecqt_infospot infospot ON g.id = infospot.scalecqt_abnormalgrid_id
       INNER JOIN tap_scalecqt_infospot_cache scic ON infospot.id = scic.id
       AND scic.analyse_period_datetime = inAnalysePeriodDatetime
       INNER JOIN tap_scalecqt_grid_detail gd ON g.id = gd.scalecqt_abnormalgrid_id
       WHERE g.analyse_period_datetime = inAnalysePeriodDatetime
       AND infospot.is_has_indoor = yes
       AND infospot.ss_cell_id IS NOT NULL

       UNION

       SELECT g2.analyse_period_datetime,
              gd.net_technology,
              g.id AS scalecqt_abnormalgrid_id,
              infospot.id AS scalecqt_infospot_id,
              NULL AS scalecqt_cell_id,
              infospot.ss_cell_id,
              gd.analyse_datetime
       FROM tap_scalecqt_abnormalgrid g
       INNER JOIN tap_scalecqt_abnormalgrid g2 ON g.parent_id = g2.id
       INNER JOIN tap_scalecqt_infospot infospot ON g.id = infospot.scalecqt_abnormalgrid_id
       INNER JOIN tap_scalecqt_infospot_cache scic ON infospot.id = scic.id
       AND scic.analyse_period_datetime = inAnalysePeriodDatetime
       INNER JOIN tap_scalecqt_grid_detail gd ON g2.id = gd.scalecqt_abnormalgrid_id
       WHERE g2.analyse_period_datetime = inAnalysePeriodDatetime
       AND infospot.is_has_indoor = yes
       AND infospot.ss_cell_id IS NOT NULL;

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 102, sysdate);
 commit; --add by maojun ����

       --4.3 ��ʼ��2G�쳣С����ʱ���
       --2G�쳣С������
       SELECT config_content
       INTO abnormalCellCategory2g
       FROM tap_cqt_config_performance
       WHERE config_type = 'AbPlotType_2G';

       INSERT INTO tap_scalecqt_abcell_cache
       (
              analyse_period_datetime,
              net_technology,
              scalecqt_abnormalgrid_id,
              scalecqt_infospot_id,
              scalecqt_cell_id,
              cell_id,
              analyse_datetime,
              rule_id,
              abnormalcell_category,
              abnormalcell_level,
              repeat_num,
              abnormalcell_threshold
       )
       SELECT cc.analyse_period_datetime,
              cc.net_technology,
              cc.scalecqt_abnormalgrid_id,
              cc.scalecqt_infospot_id,
              cc.scalecqt_cell_id,
              ac.int_id AS cell_id,
              ac.scan_start_time AS analyse_datetime,
              ac.rule_id,
              ac.result_name AS abnormalcell_category,
              ac.alarm_grade AS abnormalcell_level,
              ac.re_num AS repeat_num,
              ac.scenes AS abnormalcell_threshold
       FROM tap_scalecqt_cell_cache cc
       INNER JOIN tap_scalecqt_abcell ac ON cc.analyse_datetime = ac.scan_start_time AND cc.cell_id = ac.int_id
       WHERE cc.analyse_period_datetime = inAnalysePeriodDatetime
       AND cc.net_technology = netTechnology2g
       AND ac.result_name IN
       (
           SELECT column_value
           FROM TABLE(f_wf_split(abnormalCellCategory2g, ','))
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 103, sysdate);
       commit; --add by maojun ����

       --4.4 ��ʼ��3G�쳣С����ʱ���
       --3G�쳣С������
       SELECT config_content
       INTO abnormalCellCategory3g
       FROM tap_cqt_config_performance
       WHERE config_type = 'AbPlotType_3G';

       INSERT INTO tap_scalecqt_abcell_cache
       (
              analyse_period_datetime,
              net_technology,
              scalecqt_abnormalgrid_id,
              scalecqt_infospot_id,
              scalecqt_cell_id,
              cell_id,
              analyse_datetime,
              rule_id,
              abnormalcell_category,
              abnormalcell_level,
              repeat_num,
              abnormalcell_threshold
       )
       SELECT cc.analyse_period_datetime,
              cc.net_technology,
              cc.scalecqt_abnormalgrid_id,
              cc.scalecqt_infospot_id,
              cc.scalecqt_cell_id,
              ac.int_id AS cell_id,
              ac.scan_start_time AS analyse_datetime,
              ac.rule_id,
              ac.result_name AS abnormalcell_category,
              ac.alarm_grade AS abnormalcell_level,
              ac.re_num AS repeat_num,
              ac.scenes AS abnormalcell_threshold
       FROM tap_scalecqt_cell_cache cc
       INNER JOIN tap_scalecqt_abcell ac ON cc.analyse_datetime = ac.scan_start_time AND cc.cell_id = ac.int_id
       WHERE cc.analyse_period_datetime = inAnalysePeriodDatetime
       AND cc.net_technology = netTechnology3g
       AND ac.result_name IN
       (
           SELECT column_value
           FROM TABLE(f_wf_split(abnormalCellCategory3g, ','))
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 104, sysdate);
 commit; --add by maojun ����

       --4.5 ��ʼ����ԴС�����쳣����
       INSERT INTO tap_scalecqt_cellthreshold
       (
              id,
              scalecqt_infospot_id,
              scalecqt_cell_id,
              analyse_datetime,
              rule_id,
              abnormalcell_category,
              abnormalcell_level,
              repeat_num,
              abnormalcell_threshold
       )
       SELECT SYS_GUID() AS id,
              t3.scalecqt_infospot_id,
              abc.scalecqt_cell_id,
              abc.analyse_datetime,
              abc.rule_id,
              abc.abnormalcell_category,
              abc.abnormalcell_level,
              abc.repeat_num,
              abc.abnormalcell_threshold
       FROM tap_scalecqt_abcell_cache abc
       INNER JOIN
       (
            SELECT t1.analyse_period_datetime, t1.net_technology, t1.scalecqt_abnormalgrid_id, t1.scalecqt_infospot_id, t1.scalecqt_cell_id, t1.cell_id
            FROM
            (
                 SELECT cc.analyse_period_datetime, cc.net_technology, cc.scalecqt_abnormalgrid_id, cc.scalecqt_infospot_id, cc.scalecqt_cell_id, cc.cell_id, count(analyse_datetime) count
                 FROM tap_scalecqt_cell_cache cc
                 WHERE cc.analyse_period_datetime = inAnalysePeriodDatetime
                 GROUP BY cc.analyse_period_datetime, cc.net_technology, cc.scalecqt_abnormalgrid_id, cc.scalecqt_infospot_id, cc.scalecqt_cell_id, cc.cell_id
            ) t1
            INNER JOIN
            (
                  SELECT acc.analyse_period_datetime, acc.net_technology, acc.scalecqt_abnormalgrid_id, acc.scalecqt_infospot_id, acc.scalecqt_cell_id, acc.cell_id, count(analyse_datetime) count
                  FROM tap_scalecqt_abcell_cache acc
                  WHERE acc.analyse_period_datetime = inAnalysePeriodDatetime
                  GROUP BY acc.analyse_period_datetime, acc.net_technology, acc.scalecqt_abnormalgrid_id, acc.scalecqt_infospot_id, acc.scalecqt_cell_id, acc.cell_id
            ) t2 ON t1.analyse_period_datetime = t2.analyse_period_datetime
            AND t1.net_technology = t2.net_technology
            AND t1.scalecqt_abnormalgrid_id = t2.scalecqt_abnormalgrid_id
            AND t1.scalecqt_infospot_id = t2.scalecqt_infospot_id
            AND t1.scalecqt_cell_id = t2.scalecqt_cell_id
            AND t1.cell_id = t2.cell_id
            AND t1.count = t2.count
       ) t3 ON abc.analyse_period_datetime = t3.analyse_period_datetime
       AND abc.net_technology = t3.net_technology
       AND abc.scalecqt_abnormalgrid_id = t3.scalecqt_abnormalgrid_id
       AND abc.scalecqt_infospot_id = t3.scalecqt_infospot_id
       AND abc.scalecqt_cell_id = t3.scalecqt_cell_id
       AND abc.cell_id = t3.cell_id;

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 105, sysdate);
 commit; --add by maojun ����

       DELETE FROM tap_scalecqt_cell_cache
       WHERE analyse_period_datetime = inAnalysePeriodDatetime;

       DELETE FROM tap_scalecqt_abcell_cache
       WHERE analyse_period_datetime = inAnalysePeriodDatetime;


       --4.6 �����Ϣ�����ԴС���Ƿ�������is_over_abnormalcell_threshold = 'Y'Ϊ������
       UPDATE tap_scalecqt_infospot
       SET is_over_abnormalcell_threshold = yes
       WHERE id IN
       (
             SELECT id
             FROM tap_scalecqt_infospot_cache
             WHERE analyse_period_datetime = inAnalysePeriodDatetime
       )
       --AND is_has_indoor = yes��������
       AND is_has_indoor = yes
       AND EXISTS
       (
             SELECT 1
             FROM tap_scalecqt_cellthreshold
             WHERE tap_scalecqt_infospot.id = scalecqt_infospot_id
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 106, sysdate);
        commit; --add by maojun ����

      --add by moajun ����ֱ��վ�ж�
      UPDATE tap_scalecqt_infospot k
      SET result='�ҷ�ֱ��վ�쳣',
          problem_category = problemCategory0,
          is_need_dispatch_wo = yes
      WHERE id IN
       (
             SELECT id
             FROM tap_scalecqt_infospot_cache
             WHERE analyse_period_datetime = inAnalysePeriodDatetime
       )
       AND k.repeater_code  is not NULL
      AND EXISTS
      (
          select 1 from TY_ALARMHISTORY A
            JOIN  TY_NE_ZFZ B ON A.NE_ID = B.NE_ID
            where A.objclass = 'ZFZ'
            AND  B.ZFZ_ID = K.repeater_code
            AND  STARTTIME > trunc(inAnalysePeriodDatetime - 3)
            AND  STARTTIME <= inAnalysePeriodDatetime
            AND to_number(TO_CHAR(STARTTIME,'hh24')) >=9
            AND to_number(TO_CHAR(STARTTIME,'hh24')) <22
      );

       --4.7 ����Ϣ����쳣��ԴС���ɵ��D�D���ظ��ɵ�
       UPDATE tap_scalecqt_infospot
       SET result = signalSourceCellResult1,
           problem_category = problemCategory1
       WHERE id IN
       (
             SELECT id
             FROM tap_scalecqt_infospot_cache
             WHERE analyse_period_datetime = inAnalysePeriodDatetime
       )
       AND is_over_abnormalcell_threshold = yes
       AND EXISTS
       (
             SELECT 1
             FROM tap_wo wo
             INNER JOIN tap_wo_baseinfo wob ON wo.id = wob.id
             WHERE tap_scalecqt_infospot.ss_cell_id = wo.ne_id
             AND wo.wo_source = woSourceOfAbnormalCell
             AND wob.wo_status <> woStatusOfFinish
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 107, sysdate);
        commit; --add by maojun ����

       --4.8 ����Ϣ����쳣��ԴС���ɵ�
       UPDATE tap_scalecqt_infospot
       SET result = signalSourceCellResult2,
           problem_category = problemCategory1,
           is_need_dispatch_wo = yes,
           dispatch_object = dispatchObjectOfCell
       WHERE id IN
       (
             SELECT id
             FROM tap_scalecqt_infospot_cache
             WHERE analyse_period_datetime = inAnalysePeriodDatetime
       )
       AND is_over_abnormalcell_threshold = yes
       AND NOT EXISTS
       (
             SELECT 1
             FROM tap_wo wo
             INNER JOIN tap_wo_baseinfo wob ON wo.id = wob.id
             WHERE tap_scalecqt_infospot.ss_cell_id = wo.ne_id
             AND wo.wo_source = woSourceOfAbnormalCell
             AND wob.wo_status <> woStatusOfFinish
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 108, sysdate);
 commit; --add by maojun ����

       --5 ��Ϣ����ʷ���Խ���ж�
       --5.1 ��ʼ�����ҷֺ���ԴС����������Ϣ��
       INSERT INTO tap_scalecqt_tt_infospot_cache
       (
              analyse_period_datetime,
              id,
              net_technology,
              test_result
       )
       --2G
       SELECT g.analyse_period_datetime, sci.id, netTechnology2g,
              CASE WHEN sci.signal2g = testResultOfPoor THEN testResultOfPoor END AS test_result
       FROM tap_scalecqt_abnormalgrid g
       INNER JOIN tap_scalecqt_infospot sci ON g.id = sci.scalecqt_abnormalgrid_id
       INNER JOIN tap_scalecqt_infospot_cache scic ON sci.id = scic.id AND scic.analyse_period_datetime = inAnalysePeriodDatetime
       WHERE g.analyse_period_datetime = inAnalysePeriodDatetime
       AND (sci.is_has_indoor IS NULL OR (sci.is_has_indoor = yes AND sci.is_over_abnormalcell_threshold IS NULL))
       AND g.abnormalgrid_category IN(abnormalgridCategory2g, abnormalgridCategory2g3g)

       UNION

       --2G
       SELECT g2.analyse_period_datetime, sci.id, netTechnology2g,
              CASE WHEN sci.signal2g = testResultOfPoor THEN testResultOfPoor END AS test_result
       FROM tap_scalecqt_abnormalgrid g
       INNER JOIN tap_scalecqt_abnormalgrid g2 ON g.parent_id = g2.id
       INNER JOIN tap_scalecqt_infospot sci ON g.id = sci.scalecqt_abnormalgrid_id
       INNER JOIN tap_scalecqt_infospot_cache scic ON sci.id = scic.id AND scic.analyse_period_datetime = inAnalysePeriodDatetime
       WHERE g2.analyse_period_datetime = inAnalysePeriodDatetime
       AND (sci.is_has_indoor IS NULL OR (sci.is_has_indoor = yes AND sci.is_over_abnormalcell_threshold IS NULL))
       AND g2.abnormalgrid_category IN(abnormalgridCategory2g, abnormalgridCategory2g3g)

       UNION

       --3G
       SELECT g.analyse_period_datetime, sci.id, netTechnology3g,
              CASE WHEN sci.signal3g = testResultOfPoor THEN testResultOfPoor END AS test_result
       FROM tap_scalecqt_abnormalgrid g
       INNER JOIN tap_scalecqt_infospot sci ON g.id = sci.scalecqt_abnormalgrid_id
       INNER JOIN tap_scalecqt_infospot_cache scic ON sci.id = scic.id AND scic.analyse_period_datetime = inAnalysePeriodDatetime
       WHERE g.analyse_period_datetime = inAnalysePeriodDatetime
       AND (sci.is_has_indoor IS NULL OR (sci.is_has_indoor = yes AND sci.is_over_abnormalcell_threshold IS NULL))
       AND g.abnormalgrid_category IN(abnormalgridCategory3g, abnormalgridCategory2g3g)

       UNION

       --3G
       SELECT g2.analyse_period_datetime, sci.id, netTechnology3g,
              CASE WHEN sci.signal3g = testResultOfPoor THEN testResultOfPoor END AS test_result
       FROM tap_scalecqt_abnormalgrid g
       INNER JOIN tap_scalecqt_abnormalgrid g2 ON g.parent_id = g2.id
       INNER JOIN tap_scalecqt_infospot sci ON g.id = sci.scalecqt_abnormalgrid_id
       INNER JOIN tap_scalecqt_infospot_cache scic ON sci.id = scic.id AND scic.analyse_period_datetime = inAnalysePeriodDatetime
       WHERE g2.analyse_period_datetime = inAnalysePeriodDatetime
       AND (sci.is_has_indoor IS NULL OR (sci.is_has_indoor = yes AND sci.is_over_abnormalcell_threshold IS NULL))
       AND g2.abnormalgrid_category IN(abnormalgridCategory3g, abnormalgridCategory2g3g);

 insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 109, sysdate);
 commit; --add by maojun ����

       --5.2 test_result = '��'���ж���Ϣ���Ƿ������������
       UPDATE tap_scalecqt_infospot
       SET(is_in_wqp_lib, wqp_lib_id, c_solved_date) =
       (
           SELECT CASE WHEN wqp_lib.related_inforspot IS NULL THEN '��' ELSE '��' END AS is_in_wqp_lib,
                  wqp_lib.mark_id AS wqp_lib_id,
                  wqp_lib.c_solved_date
           FROM tap_scalecqt_tt_infospot_cache scic
           LEFT JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
           LEFT JOIN c_tco_pro_cover_benchmark wqp_lib ON sci.infospot_id = wqp_lib.related_inforspot
           WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
           AND scic.test_result = testResultOfPoor
           AND tap_scalecqt_infospot.id = sci.id
       )
       WHERE id IN
       (
             SELECT id
             FROM tap_scalecqt_tt_infospot_cache
             WHERE analyse_period_datetime = inAnalysePeriodDatetime
             AND test_result = testResultOfPoor
       );

 insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 110, sysdate);
 commit; --add by maojun ����

       --5.3 �������������İ���Ϣ���ɵ�
       UPDATE tap_scalecqt_infospot
       --SET problem_category = problemCategory3, modify by maojun 20141107
       SET problem_category = problemCategory2,
           is_need_dispatch_wo = yes,
           dispatch_object = dispatchObjectOfInfoSpot
       WHERE id IN
       (
             SELECT scic.id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
       );

 insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 111, sysdate);
        commit; --add by maojun ����

       --5.4 ����������⣬����������δ��������ҷֹ滮
       UPDATE tap_scalecqt_infospot
       SET(indoor_adjustscheme_category, indoor_adjustscheme_code,
           survey_indoor_id, survey_indoor_code, survey_indoor_name, is_has_survey_indoor, indoor_level_before_adjust) =
       (
           SELECT wqp_lib.indoor_adjust_type AS indoor_adjustscheme_category,
                  wqp_lib.room_adjust_scheme AS indoor_adjustscheme_code,
                  survey_indoor.mark_id AS survey_indoor_id,
                  survey_indoor.probtsid AS survey_indoor_code,
                  survey_indoor.indoor_num AS survey_indoor_name,
                  CASE WHEN survey_indoor.mark_id IS NOT NULL THEN 'Y' ELSE 'N' END AS is_has_survey_indoor,
                  survey_indoor.indoor_level AS indoor_level_before_adjust
           FROM tap_scalecqt_tt_infospot_cache scic
           INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
           LEFT JOIN c_tco_pro_cover_benchmark wqp_lib ON sci.infospot_id = wqp_lib.related_inforspot
           AND wqp_lib.indoor_adjust_type = '�ѹ滮'
           LEFT JOIN c_tco_pro_survey_indoor survey_indoor ON wqp_lib.room_adjust_scheme = survey_indoor.probtsid
           WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
           AND scic.test_result = testResultOfPoor
           AND sci.is_in_wqp_lib = '��'
           AND sci.c_solved_date IS NULL
           AND tap_scalecqt_infospot.id = sci.id
       )
       WHERE id IN
       (
             SELECT sci.id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
             AND sci.c_solved_date IS NULL
       );

 insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 112, sysdate);
        commit; --add by maojun ����

       --5.5 ����������⣬����������δ��������ҷֹ滮�������滮����
       --TODO����ͬ�Ĵ����2
       UPDATE c_tco_pro_survey_indoor
       SET indoor_level = 'C'
       WHERE mark_id IN
       (

             SELECT sci.survey_indoor_id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
             AND sci.c_solved_date IS NULL
             AND sci.is_has_survey_indoor = yes
       )
       AND EXISTS
       (
             SELECT 1
             FROM tap_scalecqt_infospot sci2
             INNER JOIN tap_scalecqt_abnormalgrid ag ON sci2.scalecqt_abnormalgrid_id = ag.id
             WHERE c_tco_pro_survey_indoor.mark_id = sci2.survey_indoor_id
             AND ag.analyse_period_datetime >= SYSDATE - surveyIndoorDays AND ag.analyse_period_datetime <= SYSDATE
             GROUP BY sci2.id
             HAVING COUNT(sci2.id) >= surveyIndoorTimes
       )
       AND indoor_level = 'B';

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 113, sysdate);
 commit; --add by maojun ����

       --TODO����ͬ�Ĵ����2
       UPDATE c_tco_pro_survey_indoor
       SET indoor_level = 'B'
       WHERE mark_id IN
       (

             SELECT sci.survey_indoor_id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
             AND sci.c_solved_date IS NULL
             AND sci.is_has_survey_indoor = yes
       )
       AND EXISTS
       (
             SELECT 1
             FROM tap_scalecqt_infospot sci2
             INNER JOIN tap_scalecqt_abnormalgrid ag ON sci2.scalecqt_abnormalgrid_id = ag.id
             WHERE c_tco_pro_survey_indoor.mark_id = sci2.survey_indoor_id
             AND ag.analyse_period_datetime >= SYSDATE - surveyIndoorDays AND ag.analyse_period_datetime <= SYSDATE
             GROUP BY sci2.id
             HAVING COUNT(sci2.id) >= surveyIndoorTimes
       )
       AND indoor_level = 'A';

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 114, sysdate);
 commit; --add by maojun ����

       --5.6 �޸�problem_category����Ϣ���쳣�������滮����
       UPDATE tap_scalecqt_infospot
       --SET problem_category = problemCategory5, modify by maojun 20141107
       SET problem_category = problemCategory3,
           indoor_level = CASE
                            WHEN indoor_level_before_adjust = 'A' THEN 'B'
                            WHEN indoor_level_before_adjust = 'B' THEN 'C'
                          END
       WHERE id IN
       (
             SELECT sci.id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
             AND sci.c_solved_date IS NULL
             AND sci.is_has_survey_indoor = yes
       )
       AND EXISTS
       (
             SELECT 1
             FROM tap_scalecqt_infospot sci2
             INNER JOIN tap_scalecqt_abnormalgrid ag ON sci2.scalecqt_abnormalgrid_id = ag.id
             INNER JOIN c_tco_pro_survey_indoor survey_indoor ON sci2.survey_indoor_id = survey_indoor.mark_id
             WHERE tap_scalecqt_infospot.scalecqt_abnormalgrid_id = ag.id
             AND ag.analyse_period_datetime >= SYSDATE - surveyIndoorDays AND ag.analyse_period_datetime <= SYSDATE
             GROUP BY sci2.id
             HAVING COUNT(sci2.id) >= surveyIndoorTimes
       )
       AND indoor_level_before_adjust IN('A', 'B');

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 115, sysdate);
        commit; --add by maojun ����

       --5.7 �޸�problem_category����Ϣ���쳣���滮�����������ֵ����������
       UPDATE tap_scalecqt_infospot
       SET problem_category = problemCategory8
       WHERE id IN
       (
             SELECT sci.id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
             AND sci.c_solved_date IS NULL
             AND sci.is_has_survey_indoor = yes
       )
       AND indoor_level_before_adjust = 'C';

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 116, sysdate);
commit; --add by maojun ����

       --5.8 �޸�problem_category����Ϣ���쳣���������滮����
       UPDATE tap_scalecqt_infospot
       SET problem_category = problemCategory3
       WHERE id IN
       (
             SELECT sci.id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
             AND sci.c_solved_date IS NULL
             AND sci.is_has_survey_indoor = yes
       )
       AND NOT EXISTS
       (
             SELECT 1
             FROM tap_scalecqt_infospot sci2
             INNER JOIN tap_scalecqt_abnormalgrid ag ON sci2.scalecqt_abnormalgrid_id = ag.id
             INNER JOIN c_tco_pro_survey_indoor survey_indoor ON sci2.survey_indoor_id = survey_indoor.mark_id
             WHERE tap_scalecqt_infospot.scalecqt_abnormalgrid_id = ag.id
             AND ag.analyse_period_datetime >= SYSDATE - surveyIndoorDays AND ag.analyse_period_datetime <= SYSDATE
             GROUP BY sci2.id
             HAVING COUNT(sci2.id) >= surveyIndoorTimes
       )
       AND indoor_level_before_adjust IN('A', 'B');

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 117, sysdate);
commit; --add by maojun ����

       --5.9 ����������⣬����������δ��������ҷֹ滮
       UPDATE tap_scalecqt_infospot
       SET(bts_adjustscheme_category, bts_adjustscheme_code,
           survey_bts_id, survey_bts_code, survey_bts_name, is_has_survey_bts, bts_priority_before_adjust) =
       (
           SELECT wqp_lib.adjust_scheme AS bts_adjustscheme_category,
                  wqp_lib.adjust_scheme_id AS bts_adjustscheme_code,
                  survey_bts.mark_id AS survey_bts_id,
                  survey_bts.probtsid AS survey_bts_code,
                  survey_bts.bts_name AS survey_bts_name,
                  CASE WHEN survey_bts.mark_id IS NOT NULL THEN 'Y' ELSE 'N' END AS is_has_survey_bts,
                  survey_bts.priority AS bts_priority_before_adjust
           FROM tap_scalecqt_tt_infospot_cache scic
           INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
           LEFT JOIN c_tco_pro_cover_benchmark wqp_lib ON sci.infospot_id = wqp_lib.related_inforspot
           AND wqp_lib.adjust_scheme = '�ѹ滮'
           LEFT JOIN c_tco_pro_survey_bts survey_bts ON wqp_lib.adjust_scheme_id = survey_bts.probtsid
           WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
           AND scic.test_result = testResultOfPoor
           AND sci.is_in_wqp_lib = '��'
           AND sci.c_solved_date IS NULL
           AND sci.is_has_survey_indoor = no
           AND tap_scalecqt_infospot.id = sci.id
       )
       WHERE id IN
       (
             SELECT sci.id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
             AND sci.c_solved_date IS NULL
             AND sci.is_has_survey_indoor = no
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 118, sysdate);
commit; --add by maojun ����

       --5.10 ����������⣬����������δ��������ҷֹ滮���к�վ�滮�������滮����
       --TODO����ͬ�Ĵ����3
       UPDATE c_tco_pro_survey_bts
       SET priority = 3
       WHERE mark_id IN
       (
             SELECT sci.survey_bts_id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
             AND sci.c_solved_date IS NULL
             AND sci.is_has_survey_indoor = no
             AND sci.is_has_survey_bts = yes
       )
       AND EXISTS
       (
             SELECT 1
             FROM tap_scalecqt_infospot sci2
             INNER JOIN tap_scalecqt_abnormalgrid ag ON sci2.scalecqt_abnormalgrid_id = ag.id
             WHERE c_tco_pro_survey_bts.mark_id = sci2.survey_bts_id
             AND ag.analyse_period_datetime >= SYSDATE - surveyBtsDays AND ag.analyse_period_datetime <= SYSDATE
             GROUP BY sci2.id
             HAVING COUNT(sci2.id) >= surveyBtsTimes
       )
       AND priority = 2;

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 119, sysdate);
commit; --add by maojun ����

       --TODO����ͬ�Ĵ����3
       UPDATE c_tco_pro_survey_bts
       SET priority = 2
       WHERE mark_id IN
       (
             SELECT sci.survey_bts_id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
             AND sci.c_solved_date IS NULL
             AND sci.is_has_survey_indoor = no
             AND sci.is_has_survey_bts = yes
       )
       AND EXISTS
       (
             SELECT 1
             FROM tap_scalecqt_infospot sci2
             INNER JOIN tap_scalecqt_abnormalgrid ag ON sci2.scalecqt_abnormalgrid_id = ag.id
             WHERE c_tco_pro_survey_bts.mark_id = sci2.survey_bts_id
             AND ag.analyse_period_datetime >= SYSDATE - surveyBtsDays AND ag.analyse_period_datetime <= SYSDATE
             GROUP BY sci2.id
             HAVING COUNT(sci2.id) >= surveyBtsTimes
       )
       AND priority = 1;

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 120, sysdate);
commit; --add by maojun ����


       --5.11 �޸�problem_category����Ϣ���쳣�������滮����
       UPDATE tap_scalecqt_infospot
       SET problem_category = problemCategory4,
       --SET problem_category = '��Ϣ���쳣���������к�վ�滮�ȼ�',
           bts_priority = CASE
                            WHEN bts_priority_before_adjust = 1 THEN 2
                            WHEN bts_priority_before_adjust = 2 THEN 3
                          END
       WHERE id IN
       (
             SELECT sci.id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
             AND sci.c_solved_date IS NULL
             AND sci.is_has_survey_indoor = no
             AND sci.is_has_survey_bts = yes
       )
       AND EXISTS
       (
             SELECT 1
             FROM tap_scalecqt_infospot sci2
             INNER JOIN tap_scalecqt_abnormalgrid ag ON sci2.scalecqt_abnormalgrid_id = ag.id
             INNER JOIN c_tco_pro_survey_bts survey_bts ON sci2.survey_bts_id = survey_bts.mark_id
             WHERE tap_scalecqt_infospot.scalecqt_abnormalgrid_id = ag.id
             AND ag.analyse_period_datetime >= SYSDATE - surveyBtsDays AND ag.analyse_period_datetime <= SYSDATE
             GROUP BY sci2.id
             HAVING COUNT(sci2.id) >= surveyBtsTimes
       )
       AND bts_priority_before_adjust IN(1, 2);

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 121, sysdate);
       commit; --add by maojun ����


       --5.12 �޸�problem_category����Ϣ���쳣���滮�����������ֵ����������
       UPDATE tap_scalecqt_infospot
       SET problem_category = problemCategory4 --modify by maojun ��ȷ�� 2014-11-07
       --SET problem_category = '��Ϣ���쳣���������к�վ�滮�ȼ�'
       WHERE id IN
       (
             SELECT sci.id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
             AND sci.c_solved_date IS NULL
             AND sci.is_has_survey_indoor = no
             AND sci.is_has_survey_bts = yes
       )
       AND bts_priority_before_adjust = 3;

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 122, sysdate);
       commit; --add by maojun ����

       --5.13 �޸�problem_category����Ϣ���쳣���������滮����
       UPDATE tap_scalecqt_infospot
       SET problem_category = problemCategory4 --modify by maojun ��ȷ�� 2014-11-07
        --SET problem_category = '��Ϣ���쳣���������к�վ�滮�ȼ�'
       WHERE id IN
       (
             SELECT sci.id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
             AND sci.c_solved_date IS NULL
             AND sci.is_has_survey_indoor = no
             AND sci.is_has_survey_bts = yes
       )
       AND NOT EXISTS
       (
             SELECT 1
             FROM tap_scalecqt_infospot sci2
             INNER JOIN tap_scalecqt_abnormalgrid ag ON sci2.scalecqt_abnormalgrid_id = ag.id
             INNER JOIN c_tco_pro_survey_bts survey_bts ON sci2.survey_bts_id = survey_bts.mark_id
             WHERE tap_scalecqt_infospot.scalecqt_abnormalgrid_id = ag.id
             AND ag.analyse_period_datetime >= SYSDATE - surveyBtsDays AND ag.analyse_period_datetime <= SYSDATE
             GROUP BY sci2.id
             HAVING COUNT(sci2.id) >= surveyBtsTimes
       )
       AND bts_priority_before_adjust IN(1, 2);

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 123, sysdate);
commit; --add by maojun ����

       --5.14 �޸�problem_category����Ϣ���쳣�����Ż�������Ϣ���ɵ�
       UPDATE tap_scalecqt_infospot
       SET problem_category = problemCategory5,  --modify by maojun  2014-11-07
       --SET problem_category = '��Ϣ���쳣��������������⣬�޹滮',
           is_need_dispatch_wo = yes,
           dispatch_object = dispatchObjectOfInfoSpot
       WHERE id IN
       (
             SELECT scic.id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result = testResultOfPoor
             AND sci.is_in_wqp_lib = '��'
             AND sci.c_solved_date IS NULL
             AND sci.is_has_survey_indoor = no
             AND sci.is_has_survey_bts = no
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 124, sysdate);
commit; --add by maojun ����


       --6 �ܱ��ĸ���վ�����Ƿ�����
       --6.1 Ѱ��test_result IS NULL��Ϣ����ܱ߻�վ
       INSERT INTO tap_scalecqt_bts_cache
       (
              analyse_period_datetime,
              net_technology,
              scalecqt_abnormalgrid_id,
              scalecqt_infospot_id,
              bts_int_id,
              bts_name
       )
       SELECT
             analyse_period_datetime,
             net_technology,
             scalecqt_abnormalgrid_id,
             scalecqt_infospot_id,
             bts_int_id,
             bts_name
       FROM
       (
           SELECT scic.analyse_period_datetime,
                  scic.net_technology,
                  sci.scalecqt_abnormalgrid_id,
                  scic.id AS scalecqt_infospot_id,
                  bts.int_id AS bts_int_id,
                  bts.name AS bts_name,
                  SQRT(POWER(sci.x - bts.x, 2) + POWER(sci.y - bts.y, 2)) AS distance,
                  ROW_NUMBER() OVER(PARTITION BY sci.id ORDER BY SQRT(POWER(sci.x - bts.x, 2) + POWER(sci.y - bts.y, 2)) ASC) AS row_index
           FROM tap_scalecqt_tt_infospot_cache scic
           INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
           INNER JOIN c_tco_pro_bts bts ON 1 = 1
           WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
           AND scic.test_result IS NULL
       ) t
       WHERE t.row_index <= btsNumberOfNearby;

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 125, sysdate);
commit; --add by maojun ����

       --6.2 Ѱ����Ϣ����ܱ߻�վС��
       INSERT INTO tap_scalecqt_cell
       (
              id,
              scalecqt_infospot_id,
              cell_id,
              cell_name,
              is_over_abnormalcell_threshold,
              result,
              is_need_dispatch_wo,
              wo_id
       )
       SELECT SYS_GUID() AS id,
              --bc.analyse_period_datetime,
              --bc.net_technology,
              --bc.scalecqt_abnormalgrid_id,
              bc.scalecqt_infospot_id,
              c.int_id AS cell_id,
              c.name AS cell_name,
              NULL AS is_over_abnormalcell_threshold,
              NULL AS result,
              NULL AS is_need_dispatch_wo,
              NULL AS wo_id
       FROM tap_scalecqt_bts_cache bc
       INNER JOIN c_tco_pro_cell c ON bc.bts_int_id = c.related_btsid
       WHERE bc.analyse_period_datetime = inAnalysePeriodDatetime;

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 126, sysdate);
commit; --add by maojun ����

       --6.3 Ѱ����Ϣ����ܱ߻�վС�����������쳣դ��Ĵ��ʱ�䣬��ʼ����վС����ʱ���
       INSERT INTO tap_scalecqt_cell_cache
       (
              analyse_period_datetime,
              net_technology,
              scalecqt_abnormalgrid_id,
              scalecqt_infospot_id,
              scalecqt_cell_id,
              cell_id,
              analyse_datetime
       )
       SELECT bc.analyse_period_datetime,
              bc.net_technology,
              bc.scalecqt_abnormalgrid_id,
              bc.scalecqt_infospot_id,
              scc.id AS scalecqt_cell_id,
              c.int_id AS cell_id,
              gd.analyse_datetime
       FROM tap_scalecqt_bts_cache bc
       INNER JOIN c_tco_pro_cell c ON bc.bts_int_id = c.related_btsid
       INNER JOIN tap_scalecqt_grid_detail gd ON bc.scalecqt_abnormalgrid_id = gd.scalecqt_abnormalgrid_id
       INNER JOIN tap_scalecqt_cell scc ON bc.scalecqt_infospot_id = scc.scalecqt_infospot_id AND c.int_id = scc.cell_id
       WHERE bc.analyse_period_datetime = inAnalysePeriodDatetime;

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 127, sysdate);
commit; --add by maojun ����


       ----------------------------TODO�����²��ֿ��Է�װ�����ķ���----------------------------
       --4.3 ��ʼ��2G�쳣С����ʱ���
       --2G�쳣С������
       --SELECT config_content
       --INTO abnormalCellCategory2g
       --FROM tap_cqt_config_performance
       --WHERE config_type = 'AbPlotType_2G';

       INSERT INTO tap_scalecqt_abcell_cache
       (
              analyse_period_datetime,
              net_technology,
              scalecqt_abnormalgrid_id,
              scalecqt_infospot_id,
              scalecqt_cell_id,
              cell_id,
              analyse_datetime,
              rule_id,
              abnormalcell_category,
              abnormalcell_level,
              repeat_num,
              abnormalcell_threshold
       )
       SELECT cc.analyse_period_datetime,
              cc.net_technology,
              cc.scalecqt_abnormalgrid_id,
              cc.scalecqt_infospot_id,
              cc.scalecqt_cell_id,
              ac.int_id AS cell_id,
              ac.scan_start_time AS analyse_datetime,
              ac.rule_id,
              ac.result_name AS abnormalcell_category,
              ac.alarm_grade AS abnormalcell_level,
              ac.re_num AS repeat_num,
              ac.scenes AS abnormalcell_threshold
       FROM tap_scalecqt_cell_cache cc
       INNER JOIN tap_scalecqt_abcell ac ON cc.analyse_datetime = ac.scan_start_time AND cc.cell_id = ac.int_id
       WHERE cc.analyse_period_datetime = inAnalysePeriodDatetime
       AND cc.net_technology = netTechnology2g
       AND ac.result_name IN
       (
           SELECT column_value
           FROM TABLE(f_wf_split(abnormalCellCategory2g, ','))
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 128, sysdate);
commit; --add by maojun ����

       --4.4 ��ʼ��3G�쳣С����ʱ���
       --3G�쳣С������
       --SELECT config_content
       --INTO abnormalCellCategory3g
       --FROM tap_cqt_config_performance
       --WHERE config_type = 'AbPlotType_3G';

       INSERT INTO tap_scalecqt_abcell_cache
       (
              analyse_period_datetime,
              net_technology,
              scalecqt_abnormalgrid_id,
              scalecqt_infospot_id,
              scalecqt_cell_id,
              cell_id,
              analyse_datetime,
              rule_id,
              abnormalcell_category,
              abnormalcell_level,
              repeat_num,
              abnormalcell_threshold
       )
       SELECT cc.analyse_period_datetime,
              cc.net_technology,
              cc.scalecqt_abnormalgrid_id,
              cc.scalecqt_infospot_id,
              cc.scalecqt_cell_id,
              ac.int_id AS cell_id,
              ac.scan_start_time AS analyse_datetime,
              ac.rule_id,
              ac.result_name AS abnormalcell_category,
              ac.alarm_grade AS abnormalcell_level,
              ac.re_num AS repeat_num,
              ac.scenes AS abnormalcell_threshold
       FROM tap_scalecqt_cell_cache cc
       INNER JOIN tap_scalecqt_abcell ac ON cc.analyse_datetime = ac.scan_start_time AND cc.cell_id = ac.int_id
       WHERE cc.analyse_period_datetime = inAnalysePeriodDatetime
       AND cc.net_technology = netTechnology3g
       AND ac.result_name IN
       (
           SELECT column_value
           FROM TABLE(f_wf_split(abnormalCellCategory3g, ','))
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 129, sysdate);
commit; --add by maojun ����

       --4.5 ��ʼ����ԴС�����쳣����
       INSERT INTO tap_scalecqt_cellthreshold
       (
              id,
              scalecqt_infospot_id,
              scalecqt_cell_id,
              analyse_datetime,
              rule_id,
              abnormalcell_category,
              abnormalcell_level,
              repeat_num,
              abnormalcell_threshold
       )
       SELECT SYS_GUID() AS id,
              t3.scalecqt_infospot_id,
              abc.scalecqt_cell_id,
              abc.analyse_datetime,
              abc.rule_id,
              abc.abnormalcell_category,
              abc.abnormalcell_level,
              abc.repeat_num,
              abc.abnormalcell_threshold
       FROM tap_scalecqt_abcell_cache abc
       INNER JOIN
       (
            SELECT t1.analyse_period_datetime, t1.net_technology, t1.scalecqt_abnormalgrid_id, t1.scalecqt_infospot_id, t1.scalecqt_cell_id, t1.cell_id
            FROM
            (
                 SELECT cc.analyse_period_datetime, cc.net_technology, cc.scalecqt_abnormalgrid_id, cc.scalecqt_infospot_id, cc.scalecqt_cell_id, cc.cell_id, count(analyse_datetime) count
                 FROM tap_scalecqt_cell_cache cc
                 WHERE cc.analyse_period_datetime = inAnalysePeriodDatetime
                 GROUP BY cc.analyse_period_datetime, cc.net_technology, cc.scalecqt_abnormalgrid_id, cc.scalecqt_infospot_id, cc.scalecqt_cell_id, cc.cell_id
            ) t1
            INNER JOIN
            (
                  SELECT acc.analyse_period_datetime, acc.net_technology, acc.scalecqt_abnormalgrid_id, acc.scalecqt_infospot_id, acc.scalecqt_cell_id, acc.cell_id, count(analyse_datetime) count
                  FROM tap_scalecqt_abcell_cache acc
                  WHERE acc.analyse_period_datetime = inAnalysePeriodDatetime
                  GROUP BY acc.analyse_period_datetime, acc.net_technology, acc.scalecqt_abnormalgrid_id, acc.scalecqt_infospot_id, acc.scalecqt_cell_id, acc.cell_id
            ) t2 ON t1.analyse_period_datetime = t2.analyse_period_datetime
            AND t1.net_technology = t2.net_technology
            AND t1.scalecqt_abnormalgrid_id = t2.scalecqt_abnormalgrid_id
            AND t1.scalecqt_infospot_id = t2.scalecqt_infospot_id
            AND t1.scalecqt_cell_id = t2.scalecqt_cell_id
            AND t1.cell_id = t2.cell_id
            AND t1.count = t2.count
       ) t3 ON abc.analyse_period_datetime = t3.analyse_period_datetime
       AND abc.net_technology = t3.net_technology
       AND abc.scalecqt_abnormalgrid_id = t3.scalecqt_abnormalgrid_id
       AND abc.scalecqt_infospot_id = t3.scalecqt_infospot_id
       AND abc.scalecqt_cell_id = t3.scalecqt_cell_id
       AND abc.cell_id = t3.cell_id;

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 130, sysdate);
commit; --add by maojun ����

       ----------------------------TODO�����ϲ��ֿ��Է�װ�����ķ���----------------------------


       --6.5 ��ǻ�վ�ܱ�С���Ƿ�������is_over_abnormalcell_threshold = 'Y'Ϊ������
       UPDATE tap_scalecqt_cell
       SET is_over_abnormalcell_threshold = yes
       WHERE id IN
       (
             SELECT scc.id
             FROM tap_scalecqt_cell scc
             INNER JOIN tap_scalecqt_cell_cache cc ON scc.id = cc.scalecqt_cell_id
             WHERE cc.analyse_period_datetime = inAnalysePeriodDatetime
       )
       AND EXISTS
       (
             SELECT 1
             FROM tap_scalecqt_cellthreshold
             WHERE tap_scalecqt_cell.id = scalecqt_cell_id
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 131, sysdate);
commit; --add by maojun ����

       --6.6 �Ի�վ�ܱ�С���ɵ��D�D���ظ��ɵ�
       UPDATE tap_scalecqt_cell
       SET result = nearbyCellResult1--,
           --problem_category = problemCategory2
       WHERE id IN
       (
             SELECT scc.id
             FROM tap_scalecqt_cell scc
             INNER JOIN tap_scalecqt_cell_cache cc ON scc.id = cc.scalecqt_cell_id
             WHERE cc.analyse_period_datetime = inAnalysePeriodDatetime
       )
       AND is_over_abnormalcell_threshold = yes
       AND EXISTS
       (
             SELECT 1
             FROM tap_wo wo
             INNER JOIN tap_wo_baseinfo wob ON wo.id = wob.id
             WHERE tap_scalecqt_cell.cell_id = wo.ne_id
             AND wo.wo_source = woSourceOfAbnormalCell
             AND wob.wo_status <> woStatusOfFinish
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 132, sysdate);
       commit; --add by maojun ����

       --6.7 �Ի�վ�ܱ�С���ɵ�
       UPDATE tap_scalecqt_cell
       SET result = nearbyCellResult2,
           --problem_category = problemCategory2,
           is_need_dispatch_wo = yes
       WHERE id IN
       (
             SELECT scc.id
             FROM tap_scalecqt_cell scc
             INNER JOIN tap_scalecqt_cell_cache cc ON scc.id = cc.scalecqt_cell_id
             WHERE cc.analyse_period_datetime = inAnalysePeriodDatetime
       )
       AND is_over_abnormalcell_threshold = yes
       AND NOT EXISTS
       (
             SELECT 1
             FROM tap_wo wo
             INNER JOIN tap_wo_baseinfo wob ON wo.id = wob.id
             WHERE tap_scalecqt_cell.cell_id = wo.ne_id
             AND wo.wo_source = woSourceOfAbnormalCell
             AND wob.wo_status <> woStatusOfFinish
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 133, sysdate);
commit; --add by maojun ����

       --6.8 ����problem_category
       UPDATE tap_scalecqt_infospot
       SET problem_category = problemCategory6  --modify by maojun  2014-11-07
       --SET problem_category = '��Ϣ���쳣���ܱ߻�վ�쳣'

       WHERE id IN
       (
             SELECT sci.id
             FROM tap_scalecqt_tt_infospot_cache scic
             INNER JOIN tap_scalecqt_infospot sci ON scic.id = sci.id
             WHERE scic.analyse_period_datetime = inAnalysePeriodDatetime
             AND scic.test_result IS NULL
       )
       AND EXISTS
       (
             SELECT 1
             FROM tap_scalecqt_cell scc
             WHERE tap_scalecqt_infospot.id = scc.scalecqt_infospot_id
             AND scc.is_over_abnormalcell_threshold = yes
       );

insert into AbInfospotAnalyse_log(period_time, step, finish_time) values(inAnalysePeriodDatetime, 134, sysdate);
commit; --add by maojun ����


       DELETE FROM tap_scalecqt_cell_cache
       WHERE analyse_period_datetime = inAnalysePeriodDatetime;

       DELETE FROM tap_scalecqt_abcell_cache
       WHERE analyse_period_datetime = inAnalysePeriodDatetime;

       DELETE FROM tap_scalecqt_bts_cache
       WHERE analyse_period_datetime = inAnalysePeriodDatetime;

       DELETE FROM tap_scalecqt_tt_infospot_cache
       WHERE analyse_period_datetime = inAnalysePeriodDatetime;

       DELETE FROM tap_scalecqt_infospot_cache
       WHERE analyse_period_datetime = inAnalysePeriodDatetime;




       --COMMIT;

END;
