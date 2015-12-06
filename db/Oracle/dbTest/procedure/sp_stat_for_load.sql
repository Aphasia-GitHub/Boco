create or replace procedure sp_stat_for_load(stat_time in date) is
v_sql varchar2(2000);
stat_start_time varchar2(64);
stat_end_time varchar2(64);
i_count integer;
msg varchar2(1000);

region_ids varchar2(1000);

begin
--负荷分析的过滤汇总，每天执行一次；

  if (stat_time is null) then
    select to_char(sysdate - 1,'yyyy-mm-dd') into stat_start_time from dual;
    select to_char(sysdate,'yyyy-mm-dd') into stat_end_time from dual;
  else
    select to_char(stat_time - 1,'yyyy-mm-dd') into stat_start_time from dual;
    select to_char(stat_time,'yyyy-mm-dd') into stat_end_time from dual;
  end if;

  delete from tpa_cnt_load_exception where stat_time < add_months(sysdate, -2);
  commit;

  delete from tpa_cnt_load_exception where stat_time = to_date(stat_start_time,'yyyy-mm-dd');
  commit;

  for kpistandard in (select distinct field_name, standard, ne_type, exceptionfilterhours, filterfields from c_load_standard a where a.enable = 1 order by a.field_name, a.standard)
  loop
  begin
    region_ids := '';
    for city in (select distinct region_id from c_load_standard where field_name = kpistandard.field_name and standard = kpistandard.standard and enable = 1)
    loop
    begin
        region_ids := region_ids || city.region_id || ',';
    end;
    end loop;

    region_ids := substr(region_ids, 0, length(region_ids) - 1);

    v_sql := 'insert into tpa_cnt_load_exception(kpiname, isfilteredhour, int_id, scan_start_time,
    ne_type, region_id, sum_level, kpivalue1, kpivalue2)
    select/*+ full(a)*/
    '''||kpistandard.field_name||''' as kpiname,
    1 as isfilteredhour,
    a.int_id,
    a.scan_start_time,
    a.ne_type,
    a.region_id,
    a.sum_level,'
    ||kpistandard.filterfields||
    '
    from tpa_cnt_fpage a
    where a.scan_start_time >= to_date('''||stat_start_time||''',''yyyy-mm-dd'')
    and a.scan_start_time < to_date('''||stat_end_time||''',''yyyy-mm-dd'')
    and ((instr('''||kpistandard.exceptionfilterhours||''',''-1'') != 0 and a.system_busy_mark_1X = 1)
    or (instr('''||kpistandard.exceptionfilterhours||''',to_char(a.scan_start_time, ''hh24'')) != 0))
    and a.ne_type = '||kpistandard.ne_type||'
    and a.region_id in ('||region_ids||')
    and a.sum_level = 0
    and ('||kpistandard.standard||')';

    execute immediate v_sql;
  end;
  end loop;

  commit;

exception
  when others
  then
     msg := substr(sqlerrm||dbms_utility.format_error_backtrace,1,1000);
  rollback;
  select count(*) into i_count from user_tables where table_name = 'JOB_LOG';
  if i_count > 0 then
   execute immediate 'insert into job_log values(sysdate,''sp_stat_for_load'','''||msg||''')';
   commit;
  end if;
  raise;
end sp_stat_for_load;
