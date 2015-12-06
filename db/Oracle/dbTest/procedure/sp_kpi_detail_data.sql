CREATE OR REPLACE PROCEDURE sp_kpi_detail_data(p_kpiid      number,
                                               p_bts_status number,
                                               p_bts_code   number,
                                               p_cursor     out sys_refcursor) is
  v_date_sql        varchar2(5000);
  v_date_temp       varchar2(50);
  v_unit            varchar2(5);
  v_categoryid      number;
  v_numerator       varchar2(500);
  v_eng_numerator   varchar2(500);
  v_ch_numerator    varchar2(500);
  v_denominator     varchar2(500);
  v_eng_denominator varchar2(500);
  v_ch_denominator  varchar2(500);
  v_englishname     varchar2(500);
  v_chinesename     varchar2(500);
  v_tablename       varchar2(500);
  ls_sql            varchar2(10000);
  ls_sql_column     varchar2(5000);
  ls_total_sql      varchar2(20000);
  var_out           t_ret_table;

  --kpi算法表
  cursor cur_kpi(p_kpiid number) is
    SELECT kpiid, englishname, chinesename, unit, kpicategoryid
      FROM gen_kpi
     WHERE kpiid = p_kpiid;

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
  v_date_sql := '(';

  --各基站状态的时间点拼接
  if p_bts_status = 0
  then
    for c_1 in cur_1
    loop
      v_date_temp := to_char(c_1.scan_start_time, 'yyyy-mm-dd');
      v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                     ''',''yyyy-mm-dd'')' || ',';
    end loop;
  elsif p_bts_status = 1
  then
    for c_2 in cur_2
    loop
      v_date_temp := to_char(c_2.scan_start_time, 'yyyy-mm-dd');
      v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                     ''',''yyyy-mm-dd'')' || ',';
    end loop;
  elsif p_bts_status = 2
  then
    for c_3 in cur_3
    loop
      v_date_temp := to_char(c_3.scan_start_time, 'yyyy-mm-dd');
      v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                     ''',''yyyy-mm-dd'')' || ',';
    end loop;
  elsif p_bts_status = 3
  then
    for c_4 in cur_4
    loop
      v_date_temp := to_char(c_4.scan_start_time, 'yyyy-mm-dd');
      v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                     ''',''yyyy-mm-dd'')' || ',';
    end loop;
  elsif p_bts_status = 4
  then
    for c_5 in cur_5
    loop
      v_date_temp := to_char(c_5.scan_start_time, 'yyyy-mm-dd');
      v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                     ''',''yyyy-mm-dd'')' || ',';
    end loop;
  elsif p_bts_status = 5
  then
    for c_6 in cur_6
    loop
      v_date_temp := to_char(c_6.scan_start_time, 'yyyy-mm-dd');
      v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                     ''',''yyyy-mm-dd'')' || ',';
    end loop;
  elsif p_bts_status = 6
  then
    for c_7 in cur_7
    loop
      v_date_temp := to_char(c_7.scan_start_time, 'yyyy-mm-dd');
      v_date_sql  := v_date_sql || 'to_date(''' || v_date_temp ||
                     ''',''yyyy-mm-dd'')' || ',';
    end loop;
  elsif p_bts_status = 7
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

  for c_kpi in cur_kpi(p_kpiid)
  loop
    v_unit       := c_kpi.unit;
    v_categoryid := c_kpi.kpicategoryid;
    if v_unit = '%' and
       v_categoryid = 0
    then
      SELECT numerator, denominator, tablename
        into v_numerator, v_denominator, v_tablename
        FROM gen_kpi_function
       WHERE kpiid = c_kpi.kpiid;

      if instr(v_numerator, '+') > 0
      then
        v_ch_numerator    := c_kpi.chinesename || '分子';
        v_eng_numerator   := c_kpi.englishname || 'numerator';
        v_ch_denominator  := c_kpi.chinesename || '分母';
        v_eng_denominator := c_kpi.englishname || 'denominator';
      else
        var_out           := f_split_string(v_numerator, '.');
        v_eng_numerator   := var_out(2);
        var_out           := f_split_string(v_denominator, '.');
        v_eng_denominator := var_out(2);
        --dbms_output.put_line(v_ch_numerator||'&'||v_ch_denominator);
        SELECT chinesename
          into v_ch_numerator
          FROM gen_kpi
         WHERE upper(englishname) = upper(v_eng_numerator)
           and upper(tablename) = upper(v_tablename);

        SELECT chinesename
          into v_ch_denominator
          FROM gen_kpi
         WHERE upper(englishname) = upper(v_eng_denominator)
           and upper(tablename) = upper(v_tablename);
      end if;

      ls_sql_column := 'select ''' || c_kpi.kpiid ||
                       '-column'' as "DESCCODE",''网元名称'' as name,''' ||
                       v_ch_numerator || ''' as ' || v_eng_numerator ||
                       ',''' || v_ch_denominator || ''' as ' ||
                       v_eng_denominator || ',''' || c_kpi.chinesename ||
                       '|unit' || ''' as ' || c_kpi.englishname ||
                       ',''日期'' as scan_start_time from dual';

      ls_sql := 'SELECT * FROM (SELECT ''' || c_kpi.kpiid ||
                '-data'' as "DESCCODE",c_bts_status_info.name,to_char(' ||
                v_numerator || ') as ' || v_eng_numerator || ',to_char(' ||
                v_denominator || ') as ' || v_eng_denominator ||
                ',to_char(round(sfb_divfloat_1(' || v_numerator || ',' ||
                v_denominator || '), 4)) as ' || c_kpi.englishname ||
                ',to_char(' || v_tablename ||
                '.scan_start_time,''yyyy-mm-dd'') as scan_start_time
               FROM c_bts_status_info,' || v_tablename || '
               WHERE c_bts_status_info.int_id =' ||
                v_tablename || '.int_id
                and ' || v_tablename || '.ne_type = 201
                and ' || v_tablename ||
                '.sum_level = 1
                and c_bts_status_info.bts_code =' ||
                p_bts_code || '
                and ' || v_tablename ||
                '.scan_start_time in ' || v_date_sql || ' order by ' ||
                v_tablename || '.scan_start_time)';
    else
      SELECT englishname, tablename
        into v_englishname, v_tablename
        FROM gen_kpi
       WHERE kpiid = c_kpi.kpiid;

      ls_sql_column := 'select ''' || c_kpi.kpiid ||
                       '-column'' as "DESCCODE",''网元名称'' as name,''' ||
                       c_kpi.chinesename || ''' as ' || c_kpi.englishname ||
                       ',''日期'' as scan_start_time from dual';

      ls_sql := 'SELECT * FROM (SELECT ''' || c_kpi.kpiid ||
                '-data'' as "DESCCODE", c_bts_status_info.name,to_char(' ||
                v_tablename || '.' || v_englishname || '),to_char(' ||
                v_tablename || '.Scan_Start_Time,''yyyy-mm-dd'')
                  FROM c_bts_status_info,' || v_tablename || '
                  WHERE c_bts_status_info.int_id =' ||
                v_tablename || '.Int_Id
                  and ' || v_tablename ||
                '.Ne_Type = 201
                  and ' || v_tablename ||
                '.Sum_Level = 1
                  and ' || 'c_bts_status_info.bts_code =' ||
                p_bts_code || ' and ' || v_tablename ||
                '.Scan_Start_Time in ' || v_date_sql || ' order by ' ||
                v_tablename || '.scan_start_time)';
    end if;
    ls_total_sql := ls_sql_column || ' union all ' || ls_sql;
    dbms_output.put_line(ls_total_sql);
    open p_cursor for ls_total_sql;
  end loop;
end;
