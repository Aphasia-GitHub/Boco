create or replace procedure sp_stat_for_fpage_daily(stat_time in date) is

v_sql varchar2(2000);
stat_start_time date;
stat_end_time date;
i_count integer;
msg varchar2(1000);

i_week integer;

region_ids varchar2(1000);

begin
--首页异常小区的过滤汇总，每天执行一次；
  if (stat_time is null) then
    select trunc(sysdate) - 1 into stat_start_time from dual;
    select trunc(sysdate) into stat_end_time from dual;
  else
    select trunc(stat_time) into stat_start_time from dual;
    select trunc(stat_time) + 1 into stat_end_time from dual;
  end if;

  select count(*) into i_count from user_tables where table_name = 'JOB_LOG';
  if i_count > 0 then
   execute immediate 'insert into job_log values(sysdate,''sp_stat_for_fpage_daily'',''sp_stat_for_fpage_daily for '||to_char(stat_start_time, 'yyyy-mm-dd')||' start!'')';
   commit;
  end if;

  delete from tpa_cnt_fpage_exception_daily where scan_start_time < add_months(sysdate, -3);
  commit;

  select decode(trunc(stat_start_time,'day'), stat_start_time, 1, 0) into i_week from dual;

  delete from tpa_cnt_fpage_exception_daily where scan_start_time >= stat_start_time and scan_start_time < stat_end_time;

  for kpiconfig in (select distinct b.kpiname,
         b.standardname,
         b.vendorid,
         b.ne_type,
         a.standard,
         b.extfilterkpi,
         b.extfiltervalue,
         b.exceptionfiltertype,
         b.exceptionfilterhours,
         b.filterfields
    from c_fpage_standard a, c_fpage_standard_ex b, c_region_city c
   where a.field_name = b.standardname
     and a.region_id = c.city_id
     and (b.vendorid = 0 or c.vendor = b.vendorid)
   order by b.kpiname
  )
  loop
  begin
    region_ids := '';
    for city in (select distinct a.region_id from c_fpage_standard a, c_region_city c where a.region_id = c.city_id and
        a.field_name = kpiconfig.standardname and (kpiconfig.vendorid = 0 or c.vendor = kpiconfig.vendorid))
    loop
    begin
        region_ids := region_ids || city.region_id || ',';
    end;
    end loop;

    region_ids := substr(region_ids, 0, length(region_ids) - 1);

    if (kpiconfig.exceptionfiltertype = '1') then
      v_sql := 'insert into tpa_cnt_fpage_exception_daily
      select
      a.scan_start_time,
      '''||kpiconfig.kpiname||''' as kpiname,
      a.int_id,
      a.ne_type,
      a.region_id,
      a.sum_level,
      0 as weekfilter_tag,
      0 as ext_tag,'
      ||kpiconfig.filterfields||
      '
      from tpa_cnt_fpage a
      where a.scan_start_time >= :1
      and a.scan_start_time < :2
      and to_char(a.scan_start_time, ''hh24'') in ('||kpiconfig.exceptionfilterhours||')
      and a.ne_type = '||kpiconfig.ne_type||'
      and a.region_id in ('||region_ids||')
      and a.sum_level = 0
      and ('||kpiconfig.standard||')';

    elsif (kpiconfig.exceptionfiltertype = '2') then
      v_sql := 'insert into tpa_cnt_fpage_exception_daily
      select
       a.scan_start_time,
      '''||kpiconfig.kpiname||''' as kpiname,
      a.int_id,
      a.ne_type,
      a.region_id,
      a.sum_level,
      0 as weekfilter_tag,
      0 as ext_tag,'
      ||kpiconfig.filterfields||
      '
      from
      (
      select
      sum(case when ('||kpiconfig.standard||') then 1 else 0 end) over(partition by a.int_id) as num,
      count(*) over(partition by a.int_id) as total,
      a.*
      from tpa_cnt_fpage a
      where a.scan_start_time >= :1
      and a.scan_start_time < :2
      and a.ne_type = '||kpiconfig.ne_type||'
      and a.region_id in ('||region_ids||')
      and a.sum_level = 0
      ) a
      where num = total';

    elsif (kpiconfig.exceptionfiltertype = '4') then
      v_sql := 'insert into tpa_cnt_fpage_exception_daily
      select
      a.scan_start_time,
      '''||kpiconfig.kpiname||''' as kpiname,
      a.int_id,
      a.ne_type,
      a.region_id,
      a.sum_level,
      0 as weekfilter_tag,
      0 as ext_tag,'
      ||kpiconfig.filterfields||
      '
      from tpa_cnt_fpage a
      where a.scan_start_time >= :1
      and a.scan_start_time < :2
      and a.ne_type = '||kpiconfig.ne_type||'
      and a.region_id in ('||region_ids||')
      and a.sum_level = 1
      and ('||kpiconfig.standard||')';

    elsif (kpiconfig.exceptionfiltertype = '5') then
      v_sql := 'insert into tpa_cnt_fpage_exception_daily
      select
      a.scan_start_time,
      '''||kpiconfig.kpiname||''' as kpiname,
      a.int_id,
      a.ne_type,
      a.region_id,
      a.sum_level,
      0 as weekfilter_tag,
      0 as ext_tag,'
      ||kpiconfig.filterfields||
      '
      from tpa_cnt_fpage a
      where a.scan_start_time >= :1
      and a.scan_start_time < :2
      and a.int_id in(select int_id from c_tco_pro_cell where cover_earatype in (''市区'',''县城'',''密集市区''))
      and to_char(a.scan_start_time, ''hh24'') in ('||kpiconfig.exceptionfilterhours||')
      and a.ne_type = '||kpiconfig.ne_type||'
      and a.region_id in ('||region_ids||')
      and a.sum_level = 0
      and ('||kpiconfig.standard||')';

    elsif (kpiconfig.exceptionfiltertype = '6') then
      v_sql := 'insert into tpa_cnt_fpage_exception_daily
      select
      a.scan_start_time,
      '''||kpiconfig.kpiname||''' as kpiname,
      a.int_id,
      a.ne_type,
      a.region_id,
      a.sum_level,
      0 as weekfilter_tag,
      0 as ext_tag,'
      ||kpiconfig.filterfields||
      '
      from
      (select a.*, row_number() over(partition by int_id, trunc(a.scan_start_time) order by '
      ||kpiconfig.extfilterkpi||
      ' desc) as kpi_order from tpa_cnt_fpage a
      where a.scan_start_time >= :1
      and a.scan_start_time < :2
      and to_char(a.scan_start_time, ''hh24'') in ('||kpiconfig.exceptionfilterhours||')
      and a.ne_type = '||kpiconfig.ne_type||'
      and a.region_id in ('||region_ids||')
      and a.sum_level = 0
      and ('||kpiconfig.standard||')) a where kpi_order = 1';

    elsif (kpiconfig.exceptionfiltertype = '7') then
      v_sql := 'insert into tpa_cnt_fpage_exception_daily
      select
      a.scan_start_time,
      '''||kpiconfig.kpiname||''' as kpiname,
      a.int_id,
      a.ne_type,
      a.region_id,
      a.sum_level,
      0 as weekfilter_tag,
      0 as ext_tag,'
      ||kpiconfig.filterfields||
      '
      from
      (select a.*, row_number() over(partition by int_id, trunc(a.scan_start_time) order by 1) as kpi_order
      from tpa_cnt_fpage a
      where a.scan_start_time >= :1
      and a.scan_start_time < :2
      and a.int_id in(select int_id from c_tco_pro_cell where instr(border_cell,''B'') = 0)
      and to_char(a.scan_start_time, ''hh24'') in ('||kpiconfig.exceptionfilterhours||')
      and a.ne_type = '||kpiconfig.ne_type||'
      and a.region_id in ('||region_ids||')
      and a.sum_level = 0
      and ('||kpiconfig.standard||')) a where kpi_order = 1';

    end if;

    execute immediate v_sql using stat_start_time, stat_end_time;
  end;
  end loop;
  commit;

  if (i_week = 1) then
     update tpa_cnt_fpage_exception_daily a set a.weekfilter_tag = 0
     where a.scan_start_time >= stat_end_time - 7 and a.scan_start_time < stat_end_time and a.weekfilter_tag = 1;

     for kpiconfig in (select distinct b.kpiname, b.exceptionfiltertype from c_fpage_standard_ex b order by b.kpiname)
     loop
     begin
         if (kpiconfig.exceptionfiltertype = '2') then
             update tpa_cnt_fpage_exception_daily a
              set a.weekfilter_tag = 1
             where a.kpiname = kpiconfig.kpiname
             and exists
             (select 1
              from (select a.scan_start_time,
                           a.kpiname,
                           a.int_id,
                           count(distinct trunc(a.scan_start_time)) over(partition by a.kpiname,a.int_id) num
                      from tpa_cnt_fpage_exception_daily a
                     where a.scan_start_time >= stat_end_time - 3
                       and a.scan_start_time < stat_end_time
                      ) t
             where a.scan_start_time = t.scan_start_time
               and a.kpiname = t.kpiname
               and t.int_id = a.int_id
               and t.num = 3);
         else
             update tpa_cnt_fpage_exception_daily a
              set a.weekfilter_tag = 1
             where a.kpiname = kpiconfig.kpiname
             and exists
             (select 1
              from (select a.scan_start_time,
                           a.kpiname,
                           a.int_id,
                           count(*) over(partition by a.kpiname, a.int_id) num,
                           b.rankedthrescount
                      from tpa_cnt_fpage_exception_daily a,
                           c_fpage_standard_ex         b,
                           c_region_city  c
                     where a.kpiname = b.kpiname
                       and a.region_id = c.city_id
                       and (b.vendorid = 0 or b.vendorid = c.vendor)
                       and a.scan_start_time >= stat_end_time - 7
                       and a.scan_start_time < stat_end_time
                      ) t
             where a.scan_start_time = t.scan_start_time
               and a.kpiname = t.kpiname
               and t.num >= t.rankedthrescount
               and t.int_id = a.int_id);
         end if;
     end;
     end loop;

     update tpa_cnt_fpage_exception_daily a set a.ext_tag = 0
     where a.scan_start_time >= stat_end_time - 7 and a.scan_start_time < stat_end_time and a.ext_tag = 2;

    --连续周异常事件进行标记
    update tpa_cnt_fpage_exception_daily a
     set a.ext_tag = 2
    where exists
    (select 1
    from (select a.kpiname,
                 a.int_id
            from tpa_cnt_fpage_exception_daily a
           where a.scan_start_time > stat_end_time - 14
             and a.scan_start_time < stat_end_time - 7
             and a.weekfilter_tag = 1) t
    where a.scan_start_time >= stat_end_time - 7
     and a.scan_start_time < stat_end_time
     and t.kpiname = a.kpiname
     and t.int_id = a.int_id);

    commit;
  end if;

  select count(*) into i_count from user_tables where table_name = 'JOB_LOG';
  if i_count > 0 then
   execute immediate 'insert into job_log values(sysdate,''sp_stat_for_fpage_daily'',''sp_stat_for_fpage_daily successfully completed!'')';
   commit;
  end if;
exception
  when others
  then
     msg := substr(sqlerrm||dbms_utility.format_error_backtrace,1,1000);
  rollback;
  select count(*) into i_count from user_tables where table_name = 'JOB_LOG';
  if i_count > 0 then
   execute immediate 'insert into job_log values(sysdate,''sp_stat_for_fpage_daily'','''||msg||''')';
   commit;
  end if;
  raise;
end sp_stat_for_fpage_daily;
