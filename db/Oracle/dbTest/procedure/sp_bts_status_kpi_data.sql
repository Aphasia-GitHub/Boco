CREATE OR REPLACE PROCEDURE sp_bts_status_kpi_data(p_kpiid_array varchar2,
                                                   p_bts_code    number,
                                                   p_net_type    number,
                                                   p_sum_level   number,
                                                   p_cursor      out sys_refcursor) is
  ls_sql           VARCHAR2(2000);
  v_unit           varchar2(5);
  v_categoryid     number;
  v_numerator      varchar2(500);
  v_denominator    varchar2(500);
  v_tablename      varchar2(500);
  v_date_sql       varchar2(10000);
  v_date_temp      varchar2(50);
  v_engfield       varchar2(500);
  v_chfield        varchar2(500);
  v_kpi_eng_name   varchar2(500);
  v_kpi_ch_name    varchar2(500);
  v_kpi_value      number;
  v_kpi_value_temp varchar2(50);
  v_retdata        retdata3 := retdata3();
  vn               number := 1;
  v_stauts_id      number;
  v_status_name    varchar2(30);
  v_wo_num         number;
  v_sectors        number;
  v_carrier        number;
  v_alert_num      number;
  v_kpi_sql        varchar2(20000);
  v_kpi_temp       varchar2(20000) := '';
  TYPE type_str_sql_table is Table OF varchar2(20000);
  my_table      type_str_sql_table := type_str_sql_table();
  v_total_sql   varchar2(20000) := '';
  v_column_sql  varchar2(20000) := '';
  v_column_temp varchar2(20000) := '';

  cursor cur_total is
    SELECT 'KPIPARAMDATA' "DESCCODE",
           f01 as kpi_eng_name,
           f02 as kpi_ch_name,
           f03 as kpi_value
      FROM (SELECT rownum row_num, u.*
              FROM (SELECT * FROM TABLE(CAST(v_retdata AS retdata3))) u);
  --分解kpiid
  cursor cur_kpi_array is
    select regexp_substr(p_kpiid_array, '[^,]+', 1, rownum) as kpiid_array
      from dual
    connect by rownum <=
               length(p_kpiid_array) - length(replace(p_kpiid_array, ',')) + 1;

  cursor cur_kpi(p_kpiid number) is
    SELECT kpiid, englishname, chinesename, unit, kpicategoryid
      FROM gen_kpi
     WHERE kpiid = p_kpiid;

  --基站状态工单数
  cursor cur_workorder(p_status_id number) is
    SELECT *
      FROM (SELECT tmp.status_id, tmp.status_name, nvl(workOrderNum, 0) workOrderNum
              FROM (SELECT bts_code, count(id) workOrderNum, bts_status
                      FROM (SELECT t1.bts_code,
                                   t3.id,
                                   t4.create_datetime,
                                   case
                                     when (t4.create_datetime >=
                                          decode(t1.waitforconfirm_time,
                                                  null,
                                                  sysdate,
                                                  t1.waitforconfirm_time) and
                                          t4.create_datetime <
                                          decode(t1.projectsetup_time,
                                                  null,
                                                  sysdate,
                                                  t1.projectsetup_time)) then
                                      0
                                     when (t4.create_datetime >=
                                          decode(t1.projectsetup_time,
                                                  null,
                                                  sysdate,
                                                  t1.projectsetup_time) and
                                          t4.create_datetime <
                                          decode(t1.optimizeworkpass_time,
                                                  null,
                                                  sysdate,
                                                  t1.optimizeworkpass_time)) then
                                      1
                                     when (t4.create_datetime >=
                                          decode(t1.optimizeworkpass_time,
                                                  null,
                                                  sysdate,
                                                  t1.optimizeworkpass_time) and
                                          t4.create_datetime <
                                          decode(t1.primeinspectstart_time,
                                                  null,
                                                  sysdate,
                                                  t1.primeinspectstart_time)) then
                                      2
                                     when (t4.create_datetime >=
                                          decode(t1.primeinspectstart_time,
                                                  null,
                                                  sysdate,
                                                  t1.primeinspectstart_time) and
                                          t4.create_datetime < =
                                          decode(t1.primeinspectend_time,
                                                  null,
                                                  sysdate,
                                                  t1.primeinspectend_time)) then
                                      3
                                     when (t4.create_datetime >
                                          decode(t1.primeinspectend_time,
                                                  null,
                                                  sysdate,
                                                  t1.primeinspectend_time) and
                                          t4.create_datetime <=
                                          decode(t1.finalinspectend_time,
                                                  null,
                                                  sysdate,
                                                  t1.finalinspectend_time)) then
                                      4
                                     when (t4.create_datetime >
                                          decode(t1.finalinspectend_time,
                                                  null,
                                                  sysdate,
                                                  t1.finalinspectend_time) and
                                          t4.create_datetime <
                                          decode(t1.waitforremove_time,
                                                  null,
                                                  sysdate,
                                                  t1.waitforremove_time)) then
                                      5
                                     when (t4.create_datetime >=
                                          decode(t1.waitforremove_time,
                                                  null,
                                                  sysdate,
                                                  t1.waitforremove_time) and
                                          t4.create_datetime <
                                          decode(t1.removed_time,
                                                  null,
                                                  sysdate,
                                                  t1.removed_time)) then
                                      6
                                     when (t4.create_datetime >=
                                          decode(t1.removed_time,
                                                  null,
                                                  sysdate,
                                                  t1.removed_time)) then
                                      7
                                   end bts_status
                              FROM c_bts_status_info t1,
                                   c_cell            t2,
                                   tap_wo            t3,
                                   tap_wo_baseinfo   t4
                             WHERE t1.int_id = t2.related_bts
                               and t2.int_id = t3.ne_id
                               and t3.id = t4.id
                               and t1.bts_code = p_bts_code
                               and t3.ne_type = 300)
                     group by bts_code, bts_status) t
             right join c_bts_status_tmp tmp
                on t.bts_status = tmp.status_id
             order by tmp.status_id) tab
     WHERE tab.status_id = p_status_id;

  --扇区数、载扇数
  cursor cur_sectors(p_status_id number) is
    SELECT *
      FROM (SELECT tab.int_id,
                   decode(tmp.status_id, 7, null, tab.sectors) sectors,
                   decode(tmp.status_id, 7, null, tab.carrier) carrier,
                   tmp.status_id,
                   tmp.status_name
              FROM (SELECT t1.int_id,
                           count(distinct t2.int_id) sectors,
                           count(distinct t3.int_id) carrier
                      FROM c_bts_status_info t1, c_cell t2, c_carrier t3
                     WHERE t1.int_id = t2.related_bts
                       and t1.int_id = t3.related_bts
                       and t1.bts_code = p_bts_code
                     group by t1.int_id) tab,
                   c_bts_status_tmp tmp) t
     WHERE t.status_id = p_status_id;

  --告警数
  cursor cur_alert(p_status_id number) is
    SELECT *
      FROM (SELECT tmp.status_id, tmp.status_name, tab.alertnum
              FROM (SELECT bts_code,
                           bts_status,
                           (sum(critical_alarm) + sum(major_alarm) +
                           sum(minor_alarm) + sum(warning_alarm) +
                           sum(indeterminate_alarm)) alertNum
                      FROM (SELECT t1.bts_code,
                                   t2.critical_alarm,
                                   t2.major_alarm,
                                   t2.minor_alarm,
                                   t2.warning_alarm,
                                   t2.indeterminate_alarm,
                                   case
                                     when (t2.scan_start_time <
                                          t1.projectsetup_time) or
                                          (t1.bts_status = 0) then
                                      0
                                     when (t2.scan_start_time >=
                                          t1.projectsetup_time and
                                          t2.scan_start_time <
                                          t1.optimizeworkpass_time) or
                                          (t1.bts_status = 1) then
                                      1
                                     when (t2.scan_start_time >=
                                          t1.optimizeworkpass_time and
                                          t2.scan_start_time <
                                          t1.primeinspectstart_time) or
                                          (t1.bts_status = 2) then
                                      2
                                     when (t2.scan_start_time >=
                                          t1.primeinspectstart_time and
                                          t2.scan_start_time < =
                                          t1.primeinspectend_time) or
                                          (t1.bts_status = 3) then
                                      3
                                     when (t2.scan_start_time >
                                          t1.primeinspectend_time and
                                          t1.bts_status = 3) then
                                      4
                                     when (t2.scan_start_time >
                                          t1.finalinspectend_time and
                                          t2.scan_start_time < =
                                          t1.waitforremove_time) or
                                          (t1.bts_status = 4) then
                                      5
                                     when (t2.scan_start_time >
                                          t1.finalinspectend_time and
                                          t2.scan_start_time < =
                                          t1.waitforremove_time) or
                                          (t1.bts_status = 5) then
                                      6
                                     when (t2.scan_start_time >
                                          t1.waitforremove_time and
                                          t2.scan_start_time < =
                                          t1.removed_time) or
                                          (t1.bts_status = 6) then
                                      7
                                   end bts_status
                              FROM c_bts_status_info t1, c_tfa_alarm_fpage t2
                             WHERE t1.int_id = t2.int_id
                               and t2.ne_type = p_net_type
                               and t2.sum_level = p_sum_level
                               and t1.bts_code = p_bts_code) t
                     group by bts_code, bts_status) tab
             right join c_bts_status_tmp tmp
                on tab.bts_status = tmp.status_id
             order by tmp.status_id) t
     WHERE t.status_id = p_status_id;

  --规划待确认时间段
  cursor cur_1 is
    select (t.waitforconfirm_time + rownum - 1) scan_start_time
      from (SELECT decode(waitforconfirm_time,
                          null,
                          sysdate,
                          waitforconfirm_time) waitforconfirm_time,
                   decode(projectsetup_time,
                          null,
                          sysdate,
                          projectsetup_time) projectsetup_time
              FROM c_bts_status_info
             WHERE bts_code = p_bts_code) t
    connect by rownum <= (SELECT decode(projectsetup_time,
                                        null,
                                        sysdate,
                                        projectsetup_time) -
                                 decode(waitforconfirm_time,
                                        null,
                                        sysdate,
                                        waitforconfirm_time)
                            FROM c_bts_status_info
                           WHERE bts_code = p_bts_code);
  --待立项时间段
  cursor cur_2 is
    select (t.projectsetup_time + rownum - 1) scan_start_time
      from (SELECT decode(projectsetup_time,
                          null,
                          sysdate,
                          projectsetup_time) projectsetup_time,
                   decode(optimizeworkpass_time,
                          null,
                          sysdate,
                          optimizeworkpass_time) optimizeworkpass_time
              FROM c_bts_status_info
             WHERE bts_code = p_bts_code) t
    connect by rownum <= (SELECT decode(optimizeworkpass_time,
                                        null,
                                        sysdate,
                                        optimizeworkpass_time) -
                                 decode(projectsetup_time,
                                        null,
                                        sysdate,
                                        projectsetup_time)
                            FROM c_bts_status_info
                           WHERE bts_code = p_bts_code);
  --工程优化时间段
  cursor cur_3 is
    select (t.optimizeworkpass_time + rownum - 1) scan_start_time
      from (SELECT decode(optimizeworkpass_time,
                          null,
                          sysdate,
                          optimizeworkpass_time) optimizeworkpass_time,
                   decode(primeinspectstart_time,
                          null,
                          sysdate,
                          primeinspectstart_time) primeinspectstart_time
              FROM c_bts_status_info
             WHERE bts_code = p_bts_code) t
    connect by rownum <= (SELECT decode(primeinspectstart_time,
                                        null,
                                        sysdate,
                                        primeinspectstart_time) -
                                 decode(optimizeworkpass_time,
                                        null,
                                        sysdate,
                                        optimizeworkpass_time)
                            FROM c_bts_status_info
                           WHERE bts_code = p_bts_code);
  --初验时间段
  cursor cur_4 is
    select (t.primeinspectstart_time + rownum - 1) scan_start_time
      from (SELECT decode(primeinspectstart_time,
                          null,
                          sysdate,
                          primeinspectstart_time) primeinspectstart_time,
                   decode(primeinspectend_time,
                          null,
                          sysdate,
                          primeinspectend_time) primeinspectend_time
              FROM c_bts_status_info
             WHERE bts_code = p_bts_code) t
    connect by rownum <= (SELECT decode(primeinspectend_time,
                                        null,
                                        sysdate,
                                        primeinspectend_time) -
                                 decode(primeinspectstart_time,
                                        null,
                                        sysdate,
                                        primeinspectstart_time)
                            FROM c_bts_status_info
                           WHERE bts_code = p_bts_code) + 1;
  --终验时间段
  cursor cur_5 is
    select (t.primeinspectend_time + rownum) scan_start_time
      from (SELECT decode(primeinspectend_time,
                          null,
                          sysdate,
                          primeinspectend_time) primeinspectend_time,
                   decode(finalinspectend_time,
                          null,
                          sysdate,
                          finalinspectend_time) finalinspectend_time
              FROM c_bts_status_info
             WHERE bts_code = p_bts_code) t
    connect by rownum <= (SELECT decode(finalinspectend_time,
                                        null,
                                        sysdate,
                                        finalinspectend_time) -
                                 decode(primeinspectend_time,
                                        null,
                                        sysdate,
                                        primeinspectend_time)
                            FROM c_bts_status_info
                           WHERE bts_code = p_bts_code) + 1;
  --入网时间段
  cursor cur_6 is
    select (t.finalinspectend_time + rownum) scan_start_time
      from (SELECT decode(finalinspectend_time,
                          null,
                          sysdate,
                          finalinspectend_time) finalinspectend_time,
                   decode(waitforremove_time,
                          null,
                          sysdate,
                          waitforremove_time) waitforremove_time
              FROM c_bts_status_info
             WHERE bts_code = p_bts_code) t
    connect by rownum <= (SELECT decode(waitforremove_time,
                                        null,
                                        sysdate,
                                        waitforremove_time) -
                                 decode(finalinspectend_time,
                                        null,
                                        sysdate,
                                        finalinspectend_time)
                            FROM c_bts_status_info
                           WHERE bts_code = p_bts_code);
  --待拆除时间段
  cursor cur_7 is
    select (t.waitforremove_time + rownum - 1) scan_start_time
      from (SELECT decode(waitforremove_time,
                          null,
                          sysdate,
                          waitforremove_time) waitforremove_time,
                   decode(removed_time, null, sysdate, removed_time) removed_time
              FROM c_bts_status_info
             WHERE bts_code = p_bts_code) t
    connect by rownum <=
               (SELECT decode(removed_time, null, sysdate, removed_time) -
                       decode(waitforremove_time,
                              null,
                              sysdate,
                              waitforremove_time)
                  FROM c_bts_status_info
                 WHERE bts_code = p_bts_code);
  --已拆除时间段
  cursor cur_8 is
    select (t.removed_time + rownum - 1) scan_start_time
      from (SELECT decode(removed_time, null, sysdate, removed_time) removed_time,
                   sysdate
              FROM c_bts_status_info
             WHERE bts_code = p_bts_code) t
    connect by rownum <=
               (SELECT sysdate -
                       decode(removed_time, null, sysdate, removed_time)
                  FROM c_bts_status_info
                 WHERE bts_code = p_bts_code) + 1;

begin
  /*循环基站状态（从0到7）*/
  for i in 0 .. 7
  loop
    --每轮询一回初始化
    v_retdata  := retdata3();
    vn         := 1;
    v_date_sql := '(';

    --各基站状态的时间点拼接
    if i = 0
    then
      for c_1 in cur_1
      loop
        v_date_temp := to_char(c_1.scan_start_time, 'yyyy-mm-dd');
        v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                       ''',''yyyy-mm-dd'')' || ',';
      end loop;
    elsif i = 1
    then
      for c_2 in cur_2
      loop
        v_date_temp := to_char(c_2.scan_start_time, 'yyyy-mm-dd');
        v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                       ''',''yyyy-mm-dd'')' || ',';
      end loop;
    elsif i = 2
    then
      for c_3 in cur_3
      loop
        v_date_temp := to_char(c_3.scan_start_time, 'yyyy-mm-dd');
        v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                       ''',''yyyy-mm-dd'')' || ',';
      end loop;
    elsif i = 3
    then
      for c_4 in cur_4
      loop
        v_date_temp := to_char(c_4.scan_start_time, 'yyyy-mm-dd');
        v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                       ''',''yyyy-mm-dd'')' || ',';
      end loop;
    elsif i = 4
    then
      for c_5 in cur_5
      loop
        v_date_temp := to_char(c_5.scan_start_time, 'yyyy-mm-dd');
        v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                       ''',''yyyy-mm-dd'')' || ',';
      end loop;
    elsif i = 5
    then
      for c_6 in cur_6
      loop
        v_date_temp := to_char(c_6.scan_start_time, 'yyyy-mm-dd');
        v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                       ''',''yyyy-mm-dd'')' || ',';
      end loop;
    elsif i = 6
    then
      for c_7 in cur_7
      loop
        v_date_temp := to_char(c_7.scan_start_time, 'yyyy-mm-dd');
        v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                       ''',''yyyy-mm-dd'')' || ',';
      end loop;
    elsif i = 7
    then
      for c_8 in cur_8
      loop
        v_date_temp := to_char(c_8.scan_start_time, 'yyyy-mm-dd');
        v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                       ''',''yyyy-mm-dd'')' || ',';
      end loop;
    end if;
    v_date_sql := RTRIM(v_date_sql, ',') || ')'; --去除字符串最后一个逗号字符

    if v_date_sql = '()'
    then
      v_date_sql := '(sysdate)';
    end if;
    for c_array in cur_kpi_array
    loop
      for c_kpi in cur_kpi(c_array.kpiid_array)
      loop
        v_unit       := c_kpi.unit;
        v_categoryid := c_kpi.kpicategoryid;
        if v_unit = '%' and
           v_categoryid = 0
        then
          --算率的公式
          SELECT t1.numerator,
                 t1.denominator,
                 t2.englishname,
                 t2.chinesename,
                 t1.tablename
            into v_numerator,
                 v_denominator,
                 v_engfield,
                 v_chfield,
                 v_tablename
            FROM gen_kpi_function t1, gen_kpi t2
           WHERE t1.kpiid = t2.kpiid
             and t1.kpiid = c_kpi.kpiid;
          ls_sql := 'select ''' || v_engfield || '''as kpi_eng_name,
                  ''' || v_chfield || '|unit' ||
                    '''as kpi_ch_name, round(sum(' || v_numerator ||
                    ')/sum(' || v_denominator || '),4) as kpi_value from ' ||
                    ' c_bts_status_info,' || v_tablename ||
                    ' where c_bts_status_info.int_id = ' || v_tablename ||
                    '.int_id and
                  ' || v_tablename || '.ne_type =' ||
                    p_net_type || ' and ' || v_tablename || '.sum_level=' ||
                    p_sum_level || ' and c_bts_status_info.bts_code=' ||
                    p_bts_code || ' and scan_start_time in ' || v_date_sql;
        else
          --普通算法公式
          SELECT englishname, chinesename, tablename
            into v_engfield, v_chfield, v_tablename
            FROM gen_kpi
           WHERE kpiid = c_kpi.kpiid;
          ls_sql := 'select ''' || v_engfield || '''as kpi_eng_name,
                  ''' || v_chfield ||
                    '''as kpi_ch_name,round(sum(' || v_engfield ||
                    '),4) as kpi_value from ' || ' c_bts_status_info,' ||
                    v_tablename || ' where c_bts_status_info.int_id = ' ||
                    v_tablename || '.int_id and ' || v_tablename ||
                    '.ne_type =' || p_net_type || ' and ' || v_tablename ||
                    '.sum_level=' || p_sum_level ||
                    ' and c_bts_status_info.bts_code=' || p_bts_code ||
                    ' and scan_start_time in ' || v_date_sql;
        end if;
      end loop;
      execute immediate ls_sql
        into v_kpi_eng_name, v_kpi_ch_name, v_kpi_value;

      --各KPI指标保存到多维数组
      v_retdata.EXTEND;
      v_retdata(vn) := retobj3('KPIPARAMDATA',
                               v_kpi_eng_name,
                               v_kpi_ch_name,
                               v_kpi_value);
      vn := vn + 1;
      for c_workorder in cur_workorder(i)
      loop
        v_stauts_id   := c_workorder.status_id;
        v_status_name := c_workorder.status_name;
        v_wo_num      := c_workorder.workordernum;
      end loop;
      for c_sectors in cur_sectors(i)
      loop
        v_sectors := c_sectors.sectors;
        v_carrier := c_sectors.carrier;
      end loop;
      for c_alert in cur_alert(i)
      loop
        v_alert_num := c_alert.alertnum;
      end loop;
    end loop;

    --特殊处理
    if v_wo_num is null
    then
      v_wo_num := 0;
    end if;
    if v_sectors is null
    then
      v_sectors := 0;
    end if;
    if v_carrier is null
    then
      v_carrier := 0;
    end if;
    if v_alert_num is null
    then
      v_alert_num := 0;
    end if;

    --拼接sql
    v_kpi_sql     := 'select ''' || v_stauts_id || ''' as statusid,''' ||
                     v_status_name || ''' as statusname,' || '''' ||
                     v_wo_num || '''' || ' as workordernum,' || '''' ||
                     v_sectors || '''' || ' as sectors,' || '''' ||
                     v_carrier || '''' || ' as carriers,' || '''' ||
                     v_alert_num || '''' || ' as alertnum,';
    v_column_temp := '';
    for c_total in cur_total
    loop
      v_kpi_eng_name := c_total.kpi_eng_name;
      v_kpi_ch_name  := c_total.kpi_ch_name;
      v_kpi_value    := c_total.kpi_value;
      if v_kpi_value is null
      then
        v_kpi_value := 0;
      end if;

      --处理数值缺失0的情况
      if TRUNC(v_kpi_value) = 0
      then
        v_kpi_value_temp := REPLACE(TO_CHAR(v_kpi_value), '.', '0.');
      else
        v_kpi_value_temp := to_char(v_kpi_value);
      end if;

      v_kpi_temp    := v_kpi_temp || '''' || v_kpi_value_temp || '''' ||
                       ' as ' || v_kpi_eng_name || ',';
      v_column_temp := v_column_temp || '''' || v_kpi_ch_name || '''' ||
                       ' as ' || v_kpi_eng_name || ',';
    end loop;
    v_kpi_temp    := RTRIM(v_kpi_temp, ',');
    v_column_temp := RTRIM(v_column_temp, ',');
    v_kpi_sql     := v_kpi_sql || v_kpi_temp || ' from dual';
    v_kpi_temp    := '';
    my_table.extend;
    my_table(i + 1) := v_kpi_sql; --保存到数组
  end loop;
  v_column_sql := 'select ''COLUMNLIST'' "DESCCODE",''状态ID'' as statusid,''基站状态'' as statusname,''工单数'' as workordernum,
                        ''扇区数'' as sectors,''载扇数'' as carriers,
                        ''告警数'' as alertnum,' ||
                  v_column_temp || ' from dual';

  --各基站状态的SQL union all合并后输出
  for j in 1 .. my_table.count
  loop
    if j <> my_table.count
    then
      v_total_sql := v_total_sql || my_table(j) || ' union all ';
    else
      v_total_sql := v_total_sql || my_table(j);
    end if;
  end loop;
  v_total_sql := 'SELECT ''KPITOTALDATA'' "DESCCODE", tap.*FROM (' ||
                 v_total_sql || ') tap' || ' union all ' || v_column_sql;
  dbms_output.put_line(v_total_sql);
  open p_cursor for v_total_sql;
end;
