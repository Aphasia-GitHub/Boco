create or replace procedure PROC_SCALECQT_OVERVIEW_DAILY  as
  --TYPE t_emp_dept IS REF CURSOR; --定义游标变量类型
  --c_region_records t_emp_dept; --声明游标变量
  i_count integer;
  --c_row            c_region_records%RowType;
  --定义一个游标变量v_cinfo c_emp%ROWTYPE ，该类型为游标c_emp中的一行数据类型
  analyze_date date :=trunc(sysdate)-1+21/24;

begin

      delete from TAP_OVERVIEW_DAILY
         where analyse_period_datetime  = trunc(sysdate)-1+21/24;

        insert into TAP_OVERVIEW_DAILY
          select *
            from (select decode(region_name, null, -1, min(sort)) sort,
                         analyse_period_datetime,
                         decode(region_name, null, -1, min(region_id)) region_id,
                         nvl(region_name, '全省') region_name,
                         sum("异常栅格数") ab_grid_count,
                         sum("市区异常栅格数") ab_grid_count0,
                         sum("县城异常栅格数") ab_grid_count1,
                         sum("农村异常栅格数") ab_grid_count2,
                         sum("异常栅格数_2G") ab_grid_count_2g,
                         sum("派单异常栅格数_2G") ab_grid_dispatch_count_2g,
                         sum("无信息点无建筑物异常栅格数_2G") ab_grid_empty_count_2g,
                         sum("异常信息点数_2G") ab_inforspot_count_2g,
                         sum("派单异常信息点数_2G") ab_inforspot_dispatch_count_2g,
                         sum("规划等级提升异常信息点数_2G") survey_levelup_infor_count_2g,
                         sum("异常栅格数_3G") ab_grid_count_3g,
                         sum("派单异常栅格数_3G") ab_grid_dispatch_count_3g,
                         sum("无信息点无建筑物异常栅格数_3G") ab_grid_empty_count_3g,
                         sum("异常信息点数_3G") ab_inforspot_count_3g,
                         sum("派单异常信息点数_3G") ab_inforspot_dispatch_count_3g,
                         sum("规划等级提升异常信息点数_3G") survey_levelup_infor_count_3g
                    from (SELECT city.analyse_period_datetime,
                                 city.region_id,
                                 city.sort,
                                 city.region_name,
                                 t1.count                     AS "异常栅格数",
                                 t1.count0                    AS "市区异常栅格数",
                                 t1.count1                    AS "县城异常栅格数",
                                 t1.count2                    AS "农村异常栅格数",
                                 t2.count                     AS "异常栅格数_2G",
                                 t3.count                     AS "派单异常栅格数_2G",
                                 t4.count                     AS "无信息点无建筑物异常栅格数_2G",
                                 t5.count                     AS "异常信息点数_2G",
                                 t6.count                     AS "派单异常信息点数_2G",
                                 t7.count                     AS "规划等级提升异常信息点数_2G",
                                 t8.count                     AS "异常栅格数_3G",
                                 t9.count                     AS "派单异常栅格数_3G",
                                 t10.count                    AS "无信息点无建筑物异常栅格数_3G",
                                 t11.count                    AS "异常信息点数_3G",
                                 t12.count                    AS "派单异常信息点数_3G",
                                 t13.count                    AS "规划等级提升异常信息点数_3G"
                            FROM (SELECT trunc(sysdate) - 1 + 21 / 24 AS analyse_period_datetime,
                                         city_id AS region_id,
                                         city_name AS region_name,
                                         sort
                                    FROM c_region_city
                                   WHERE region_name = '\'

                                  ) city
                            LEFT JOIN (

                                      SELECT ag.analyse_period_datetime,
                                              ag.region_id,
                                              COUNT(ag.id) AS count,
                                              SUM(DECODE(ag.LOCATION_CATEGORY,
                                                         '市区',
                                                         1,
                                                         0)) count0,
                                              SUM(DECODE(ag.LOCATION_CATEGORY,
                                                         '县城',
                                                         1,
                                                         0)) count1,
                                              SUM(DECODE(ag.LOCATION_CATEGORY,
                                                         '农村',
                                                         1,
                                                         0)) count2
                                        FROM tap_scalecqt_abnormalgrid ag
                                       WHERE ag.analyse_period_datetime =
                                             trunc(sysdate) - 1 + 21 / 24
                                         AND ag.parent_id IS NULL
                                       GROUP BY ag.analyse_period_datetime,
                                                 ag.region_id) t1
                              ON city.analyse_period_datetime =
                                 t1.analyse_period_datetime
                             AND city.region_id = t1.region_id
                            LEFT JOIN (

                                      SELECT ag.analyse_period_datetime,
                                              ag.region_id,
                                              COUNT(ag.id) AS count
                                        FROM tap_scalecqt_abnormalgrid ag
                                       WHERE ag.analyse_period_datetime =
                                             trunc(sysdate) - 1 + 21 / 24
                                         AND ag.parent_id IS NULL
                                         AND ag.abnormalgrid_category IN
                                             ('2G异常栅格', '2G/3G异常栅格')
                                       GROUP BY ag.analyse_period_datetime,
                                                 ag.region_id) t2
                              ON city.analyse_period_datetime =
                                 t2.analyse_period_datetime
                             AND city.region_id = t2.region_id
                            LEFT JOIN (

                                      SELECT ag.analyse_period_datetime,
                                              ag.region_id,
                                              COUNT(ag.id) AS count
                                        FROM tap_scalecqt_abnormalgrid ag
                                       WHERE ag.analyse_period_datetime =
                                             trunc(sysdate) - 1 + 21 / 24
                                         AND ag.parent_id IS NULL
                                         AND ag.abnormalgrid_category IN
                                             ('2G异常栅格', '2G/3G异常栅格')
                                         AND ag.wo_id IS NOT NULL
                                       GROUP BY ag.analyse_period_datetime,
                                                 ag.region_id) t3
                              ON city.analyse_period_datetime =
                                 t3.analyse_period_datetime
                             AND city.region_id = t3.region_id
                            LEFT JOIN (

                                      SELECT ag.analyse_period_datetime,
                                              ag.region_id,
                                              COUNT(ag.id) AS count
                                        FROM tap_scalecqt_abnormalgrid ag
                                       WHERE ag.analyse_period_datetime =
                                             trunc(sysdate) - 1 + 21 / 24
                                         AND ag.parent_id IS NULL
                                         AND ag.abnormalgrid_category IN
                                             ('2G异常栅格', '2G/3G异常栅格')
                                         AND ag.wo_id IS NULL

                                         AND (ag.is_need_dispatch_wo is null or
                                             ag.is_need_dispatch_wo != 'Y')
                                         AND ag.problem_category IS NOT NULL
                                       GROUP BY ag.analyse_period_datetime,
                                                 ag.region_id) t4
                              ON city.analyse_period_datetime =
                                 t4.analyse_period_datetime
                             AND city.region_id = t4.region_id
                            LEFT JOIN (

                                      SELECT analyse_period_datetime,
                                              region_id,
                                              SUM(count) AS count
                                        FROM (SELECT ag.analyse_period_datetime,
                                                      ag.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                WHERE ag.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag.parent_id IS NULL
                                                  AND ag.abnormalgrid_category IN
                                                      ('2G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                GROUP BY ag.analyse_period_datetime,
                                                         ag.region_id
                                               UNION
                                               SELECT ag2.analyse_period_datetime,
                                                      ag2.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_abnormalgrid ag2
                                                   ON ag.parent_id = ag2.id
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                WHERE ag2.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag2.parent_id IS NULL
                                                  AND ag2.abnormalgrid_category IN
                                                      ('2G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                GROUP BY ag2.analyse_period_datetime,
                                                         ag2.region_id) t
                                       GROUP BY analyse_period_datetime,
                                                 region_id

                                      ) t5
                              ON city.analyse_period_datetime =
                                 t5.analyse_period_datetime
                             AND city.region_id = t5.region_id
                            LEFT JOIN (

                                      SELECT analyse_period_datetime,
                                              region_id,
                                              SUM(count) AS count
                                        FROM (SELECT ag.analyse_period_datetime,
                                                      ag.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                WHERE ag.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag.parent_id IS NULL
                                                  AND ag.abnormalgrid_category IN
                                                      ('2G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                  AND infospot.wo_id IS NOT NULL
                                                GROUP BY ag.analyse_period_datetime,
                                                         ag.region_id

                                               UNION

                                               SELECT ag2.analyse_period_datetime,
                                                      ag2.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_abnormalgrid ag2
                                                   ON ag.parent_id = ag2.id
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                WHERE ag2.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag2.parent_id IS NULL
                                                  AND ag2.abnormalgrid_category IN
                                                      ('2G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                  AND infospot.wo_id IS NOT NULL
                                                GROUP BY ag2.analyse_period_datetime,
                                                         ag2.region_id

                                               UNION

                                               SELECT ag.analyse_period_datetime,
                                                      ag.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                INNER JOIN tap_scalecqt_cell scc
                                                   ON infospot.id =
                                                      scc.scalecqt_infospot_id
                                                WHERE ag.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag.parent_id IS NULL
                                                  AND ag.abnormalgrid_category IN
                                                      ('2G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                  AND scc.wo_id IS NOT NULL
                                                GROUP BY ag.analyse_period_datetime,
                                                         ag.region_id

                                               UNION

                                               SELECT ag2.analyse_period_datetime,
                                                      ag2.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_abnormalgrid ag2
                                                   ON ag.parent_id = ag2.id
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                INNER JOIN tap_scalecqt_cell scc
                                                   ON infospot.id =
                                                      scc.scalecqt_infospot_id
                                                WHERE ag2.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag2.parent_id IS NULL
                                                  AND ag2.abnormalgrid_category IN
                                                      ('2G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                  AND scc.wo_id IS NOT NULL
                                                GROUP BY ag2.analyse_period_datetime,
                                                         ag2.region_id) t
                                       GROUP BY analyse_period_datetime,
                                                 region_id

                                      ) t6
                              ON city.analyse_period_datetime =
                                 t6.analyse_period_datetime
                             AND city.region_id = t6.region_id
                            LEFT JOIN (

                                      SELECT analyse_period_datetime,
                                              region_id,
                                              SUM(count) AS count
                                        FROM (SELECT ag.analyse_period_datetime,
                                                      ag.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                WHERE ag.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag.parent_id IS NULL
                                                  AND ag.abnormalgrid_category IN
                                                      ('2G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                  AND infospot.wo_id IS NULL
                                                  AND (infospot.is_has_survey_indoor = 'Y' OR
                                                      infospot.is_has_survey_bts = 'Y')
                                                GROUP BY ag.analyse_period_datetime,
                                                         ag.region_id
                                               UNION
                                               SELECT ag2.analyse_period_datetime,
                                                      ag2.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_abnormalgrid ag2
                                                   ON ag.parent_id = ag2.id
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                WHERE ag2.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag2.parent_id IS NULL
                                                  AND ag2.abnormalgrid_category IN
                                                      ('2G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                  AND infospot.wo_id IS NULL
                                                  AND (infospot.is_has_survey_indoor = 'Y' OR
                                                      infospot.is_has_survey_bts = 'Y')
                                                GROUP BY ag2.analyse_period_datetime,
                                                         ag2.region_id) t
                                       GROUP BY analyse_period_datetime,
                                                 region_id

                                      ) t7
                              ON city.analyse_period_datetime =
                                 t7.analyse_period_datetime
                             AND city.region_id = t7.region_id
                            LEFT JOIN (

                                      SELECT ag.analyse_period_datetime,
                                              ag.region_id,
                                              COUNT(ag.id) AS count
                                        FROM tap_scalecqt_abnormalgrid ag
                                       WHERE ag.analyse_period_datetime =
                                             trunc(sysdate) - 1 + 21 / 24
                                         AND ag.parent_id IS NULL
                                         AND ag.abnormalgrid_category IN
                                             ('3G异常栅格', '2G/3G异常栅格')
                                       GROUP BY ag.analyse_period_datetime,
                                                 ag.region_id) t8
                              ON city.analyse_period_datetime =
                                 t8.analyse_period_datetime
                             AND city.region_id = t8.region_id
                            LEFT JOIN (

                                      SELECT ag.analyse_period_datetime,
                                              ag.region_id,
                                              COUNT(ag.id) AS count
                                        FROM tap_scalecqt_abnormalgrid ag
                                       WHERE ag.analyse_period_datetime =
                                             trunc(sysdate) - 1 + 21 / 24
                                         AND ag.parent_id IS NULL
                                         AND ag.abnormalgrid_category IN
                                             ('3G异常栅格', '2G/3G异常栅格')
                                         AND ag.wo_id IS NOT NULL
                                       GROUP BY ag.analyse_period_datetime,
                                                 ag.region_id) t9
                              ON city.analyse_period_datetime =
                                 t9.analyse_period_datetime
                             AND city.region_id = t9.region_id
                            LEFT JOIN (

                                      SELECT ag.analyse_period_datetime,
                                              ag.region_id,
                                              COUNT(ag.id) AS count
                                        FROM tap_scalecqt_abnormalgrid ag
                                       WHERE ag.analyse_period_datetime =
                                             trunc(sysdate) - 1 + 21 / 24
                                         AND ag.parent_id IS NULL
                                         AND ag.abnormalgrid_category IN
                                             ('3G异常栅格', '2G/3G异常栅格')
                                         AND ag.wo_id IS NULL

                                         AND (ag.is_need_dispatch_wo is null or
                                             ag.is_need_dispatch_wo != 'Y')
                                         AND ag.problem_category IS NOT NULL
                                       GROUP BY ag.analyse_period_datetime,
                                                 ag.region_id) t10
                              ON city.analyse_period_datetime =
                                 t10.analyse_period_datetime
                             AND city.region_id = t10.region_id
                            LEFT JOIN (

                                      SELECT analyse_period_datetime,
                                              region_id,
                                              SUM(count) AS count
                                        FROM (SELECT ag.analyse_period_datetime,
                                                      ag.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                WHERE ag.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag.parent_id IS NULL
                                                  AND ag.abnormalgrid_category IN
                                                      ('3G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                GROUP BY ag.analyse_period_datetime,
                                                         ag.region_id
                                               UNION
                                               SELECT ag2.analyse_period_datetime,
                                                      ag2.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_abnormalgrid ag2
                                                   ON ag.parent_id = ag2.id
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                WHERE ag2.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag2.parent_id IS NULL
                                                  AND ag2.abnormalgrid_category IN
                                                      ('3G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                GROUP BY ag2.analyse_period_datetime,
                                                         ag2.region_id) t
                                       GROUP BY analyse_period_datetime,
                                                 region_id

                                      ) t11
                              ON city.analyse_period_datetime =
                                 t11.analyse_period_datetime
                             AND city.region_id = t11.region_id
                            LEFT JOIN (

                                      SELECT analyse_period_datetime,
                                              region_id,
                                              SUM(count) AS count
                                        FROM (SELECT ag.analyse_period_datetime,
                                                      ag.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                WHERE ag.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag.parent_id IS NULL
                                                  AND ag.abnormalgrid_category IN
                                                      ('3G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                  AND infospot.wo_id IS NOT NULL
                                                GROUP BY ag.analyse_period_datetime,
                                                         ag.region_id

                                               UNION

                                               SELECT ag2.analyse_period_datetime,
                                                      ag2.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_abnormalgrid ag2
                                                   ON ag.parent_id = ag2.id
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                WHERE ag2.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag2.parent_id IS NULL
                                                  AND ag2.abnormalgrid_category IN
                                                      ('3G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                  AND infospot.wo_id IS NOT NULL
                                                GROUP BY ag2.analyse_period_datetime,
                                                         ag2.region_id

                                               UNION

                                               SELECT ag.analyse_period_datetime,
                                                      ag.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                INNER JOIN tap_scalecqt_cell scc
                                                   ON infospot.id =
                                                      scc.scalecqt_infospot_id
                                                WHERE ag.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag.parent_id IS NULL
                                                  AND ag.abnormalgrid_category IN
                                                      ('3G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                  AND scc.wo_id IS NOT NULL
                                                GROUP BY ag.analyse_period_datetime,
                                                         ag.region_id

                                               UNION

                                               SELECT ag2.analyse_period_datetime,
                                                      ag2.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_abnormalgrid ag2
                                                   ON ag.parent_id = ag2.id
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                INNER JOIN tap_scalecqt_cell scc
                                                   ON infospot.id =
                                                      scc.scalecqt_infospot_id
                                                WHERE ag2.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag2.parent_id IS NULL
                                                  AND ag2.abnormalgrid_category IN
                                                      ('3G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                  AND scc.wo_id IS NOT NULL
                                                GROUP BY ag2.analyse_period_datetime,
                                                         ag2.region_id) t
                                       GROUP BY analyse_period_datetime,
                                                 region_id

                                      ) t12
                              ON city.analyse_period_datetime =
                                 t12.analyse_period_datetime
                             AND city.region_id = t12.region_id
                            LEFT JOIN (

                                      SELECT analyse_period_datetime,
                                              region_id,
                                              SUM(count) AS count
                                        FROM (SELECT ag.analyse_period_datetime,
                                                      ag.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                WHERE ag.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag.parent_id IS NULL
                                                  AND ag.abnormalgrid_category IN
                                                      ('3G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                  AND infospot.wo_id IS NULL
                                                  AND (infospot.is_has_survey_indoor = 'Y' OR
                                                      infospot.is_has_survey_bts = 'Y')
                                                GROUP BY ag.analyse_period_datetime,
                                                         ag.region_id
                                               UNION
                                               SELECT ag2.analyse_period_datetime,
                                                      ag2.region_id,
                                                      COUNT(infospot.id) AS count
                                                 FROM tap_scalecqt_abnormalgrid ag
                                                INNER JOIN tap_scalecqt_abnormalgrid ag2
                                                   ON ag.parent_id = ag2.id
                                                INNER JOIN tap_scalecqt_infospot infospot
                                                   ON ag.id =
                                                      infospot.scalecqt_abnormalgrid_id
                                                WHERE ag2.analyse_period_datetime =
                                                      trunc(sysdate) - 1 +
                                                      21 / 24
                                                  AND ag2.parent_id IS NULL
                                                  AND ag2.abnormalgrid_category IN
                                                      ('3G异常栅格',
                                                       '2G/3G异常栅格')
                                                  AND infospot.problem_category IS NOT NULL
                                                  AND infospot.wo_id IS NULL
                                                  AND (infospot.is_has_survey_indoor = 'Y' OR
                                                      infospot.is_has_survey_bts = 'Y')
                                                GROUP BY ag2.analyse_period_datetime,
                                                         ag2.region_id) t
                                       GROUP BY analyse_period_datetime,
                                                 region_id

                                      ) t13
                              ON city.analyse_period_datetime =
                                 t13.analyse_period_datetime
                             AND city.region_id = t13.region_id)
                   group by analyse_period_datetime, ROLLUP(region_name)
                   order by sort, nvl(region_name, ' '))
           where region_name <> '安徽省';
        commit;

  insert into TAP_SCALECQT_ABGRID_DETAIL
  SELECT
   ag.analyse_period_datetime,
   ag.region_id,
   city.region_name,
   '栅格' as granularity,
   ag.id,
   ag.grid_num,
   decode(ag.wo_id, null, '否', '是') has_dispatch_wo,
   grid.grid_size,
   grid.tl_longitude,
   grid.tl_latitude,
   grid.br_longitude,
   grid.br_latitude,
   decode(grid.location_type, 0, '市区', 1, '县城', 2, '农村') location_type,
   ag.abnormalgrid_category,
   ag.grid_1x_scorepoor_count,
   ag.grid_do_scorepoor_count,
   ag.problem_category,
   abGridComplaint.complain_count,
   abCount2g.near_times near_times_2g,
   abCount2g.all_times all_times_2g,
   abCount2g.bussiness_level_2g,
   abCount2g.numofcalls_voice,
   abCount2g.score_2g,
   nvl(abInforCount.num, 0) ab_infor_num_2g,
   abCount3g.near_times near_times_3g,
   abCount3g.all_times all_times_3g,
   abCount3g.bussiness_level_3g,
   abCount3g.score_3g,
   abCount3g.numofconnection,
   nvl(abInforCount.num, 0) ab_infor_num_3g,
   to_char(abBuildings.Inner_Buildings) buildings_text,
   EVENT_2G.EVENT_SUM_2G,
   EVENT_3G.EVENT_SUM_3G
    FROM tap_scalecqt_abnormalgrid ag
    JOIN tap_grid grid
      on ag.grid_num = grid.grid_num
    LEFT JOIN (select GRID_NUM, sum(EVENT_SUM_2G) EVENT_SUM_2G
                 from (SELECT DISTINCT A.GRID_NUM,
                                       B.SCAN_START_TIME,
                                       b.NUMOFCOVQUALITYWORSE_VOICE +
                                       b.NUMOFDROPCALLS_VOICE +
                                       b.NUMOFFAILCALLS_VOICE EVENT_SUM_2G
                         FROM TAP_SCALECQT_ABGRID_2G A
                         LEFT JOIN TAP_SCALECQT_ABGRID_2GDETAIL b
                           on b.ABGRID_ID = a.id
                        WHERE B.SCAN_START_TIME <=analyze_date
                          AND B.SCAN_START_TIME >analyze_date - 3)
                group by GRID_NUM) EVENT_2G
      ON ag.GRID_NUM = EVENT_2G.GRID_NUM
    LEFT JOIN (select GRID_NUM, sum(EVENT_SUM_3G) EVENT_SUM_3G
                 from (SELECT DISTINCT A.GRID_NUM,
                                       B.SCAN_START_TIME,
                                       B.NUMOFCOVQUALITYWORSE_DO +
                                       B.NUMOFFAILCONNECTION +
                                       B.NUMOFDROPCONNECTION +
                                       B.NUMOFSPEEDLOWER_DL +
                                       B.NUMOFSPEEDLOWER_UL EVENT_SUM_3G
                         FROM TAP_SCALECQT_ABGRID_3G A
                         LEFT JOIN TAP_SCALECQT_ABGRID_3GDETAIL b
                           on b.ABGRID_ID = a.id
                        WHERE B.SCAN_START_TIME <=analyze_date
                          AND B.SCAN_START_TIME >analyze_date - 3)
                group by GRID_NUM) EVENT_3G
      ON ag.GRID_NUM = EVENT_3G.GRID_NUM
    LEFT JOIN /*(select a.id, to_char(wm_concat(b.name)) buildings_text
                 from tap_scalecqt_abnormalgrid a, TAP_BUILDING b
                where 1 = 1
                  and a.analyse_period_datetime =
                      analyze_date
                  and a.region_id = b.region_id
                  AND a.BR_LONGITUDE > b.LONGITUDE
                  AND a.TL_LONGITUDE < b.LONGITUDE
                  AND a.BR_LATITUDE < b.LATITUDE
                  AND a.TL_LATITUDE > b.LATITUDE
                group by a.id) */
                tap_grid_building abBuildings
      on ag.grid_num = abBuildings.Grid_Num
    LEFT JOIN (select /*+ LEADING(AG) USE_NL(AG INFOR) */
                ag.id, count(1) num
                 from tap_scalecqt_abnormalgrid ag,
                      tap_scalecqt_infospot     infor
                where ag.id = infor.scalecqt_abnormalgrid_id
                  and ag.analyse_period_datetime =
                      analyze_date
                  and infor.problem_category is not null
                group by ag.id) abInforCount
      on ag.id = abInforCount.id
    LEFT JOIN (select grid.grid_num, count(1) complain_count
                 from c_tco_pro_complain a
                 join c_tco_pro_inforspot infor
                   on a.inforspot_num = infor.inforspot_id
                 join tap_grid grid on grid.grid_num = infor.related_grid
                  /* on grid.tl_longitude < infor.inforspot_lon
                  and grid.br_longitude > infor.inforspot_lon
                  and grid.tl_latitude > infor.inforspot_lat
                  and grid.br_latitude < infor.inforspot_lat*/
                 join tap_scalecqt_abnormalgrid ag
                   on grid.grid_num = ag.grid_num
                where ag.analyse_period_datetime =
                      analyze_date
                group by grid.grid_num) abGridComplaint
      ON ag.grid_num = abGridComplaint.grid_num
    LEFT JOIN (select a.scan_start_time analyse_period_datetime,
                      a.GRID_NUM,
                      sum(case
                            when b.SCORE < c.HIGH_SCORE and
                                 b.SCAN_START_TIME >
                                 trunc(analyze_date) then
                             1
                            else
                             0
                          end) near_times,
                      sum(case
                            when b.SCORE < c.HIGH_SCORE then
                             1
                            else
                             0
                          end) all_times,
                      case a.grid_busitype
                        when 1 then
                         '高活跃栅格'
                        when 2 then
                         '一般活跃栅格'
                        when 3 then
                         '低活跃栅格'
                      end bussiness_level_2g,
                      avg(a.numofcalls_voice) numofcalls_voice,
                      avg(a.SCORE) SCORE_2G
                 from tap_scalecqt_abgrid_2g a,
                      TAP_SCALECQT_ABGRID_2GDETAIL b,
                      (select high_score
                         from TAP_CQT_CONFIG_ABNORMAL_JUDGE
                        where technology = '2G') c
                where a.id = b.ABGRID_ID
                  and a.scan_start_time =
                      analyze_date
                  AND B.SCAN_START_TIME >
                      TRUNC(analyze_date) - 2
                group by a.scan_start_time, a.GRID_NUM, a.GRID_BUSITYPE) abCount2g
      on ag.analyse_period_datetime = abCount2g.analyse_period_datetime
     and ag.grid_num = abCount2g.grid_num
    LEFT JOIN (select a.scan_start_time analyse_period_datetime,
                      a.GRID_NUM,
                      sum(case
                            when b.SCORE < c.HIGH_SCORE and
                                 b.SCAN_START_TIME >
                                 trunc(analyze_date) then
                             1
                            else
                             0
                          end) near_times,
                      sum(case
                            when b.SCORE < c.HIGH_SCORE then
                             1
                            else
                             0
                          end) all_times,
                      case a.grid_busitype
                        when 1 then
                         '高活跃栅格'
                        when 2 then
                         '一般活跃栅格'
                        when 3 then
                         '低活跃栅格'
                      end bussiness_level_3g,
                      avg(a.numofconnection) numofconnection,
                      avg(a.SCORE) SCORE_3G
                 from tap_scalecqt_abgrid_3g a,
                      TAP_SCALECQT_ABGRID_3GDETAIL b,
                      (select high_score
                         from TAP_CQT_CONFIG_ABNORMAL_JUDGE
                        where technology = '3G') c
                where a.id = b.ABGRID_ID
                  and a.scan_start_time = analyze_date
                  AND B.SCAN_START_TIME > TRUNC(analyze_date) - 2
                group by a.scan_start_time, a.GRID_NUM, a.GRID_BUSITYPE) abCount3g
      on ag.analyse_period_datetime = abCount3g.analyse_period_datetime
     and ag.grid_num = abCount3g.grid_num
   INNER JOIN (SELECT city_id AS region_id, city_name AS region_name
                 FROM c_region_city
                WHERE region_name = '\') city
      ON ag.region_id = city.region_id
   WHERE ag.parent_id IS NULL
     AND ag.analyse_period_datetime = analyze_date;
commit;
end;
