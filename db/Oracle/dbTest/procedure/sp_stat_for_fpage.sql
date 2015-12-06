create or replace procedure sp_stat_for_fpage(stat_time in date) is

v_sql varchar2(2000);
stat_start_time varchar2(64);
stat_end_time varchar2(64);
i_count integer;
msg varchar2(1000);

region_ids varchar2(1000);

begin
--首页异常小区的过滤汇总，每周执行一次；
  select count(*) into i_count from user_tables where table_name = 'JOB_LOG';
  if i_count > 0 then
   execute immediate 'insert into job_log values(sysdate,''tpa_cnt_fpage_exception'',''sp_stat_for_fpage start!'')';
   commit;
  end if;

  execute immediate 'delete from tpa_cnt_fpage_exception_tmp';
  commit;

  if (stat_time is null) then
    select to_char(trunc(sysdate - 1,'day') + 1 - 7,'yyyy-mm-dd') into stat_start_time from dual;
    select to_char(trunc(sysdate - 1,'day') + 1,'yyyy-mm-dd') into stat_end_time from dual;
  else
    select to_char(trunc(stat_time - 1,'day') + 1 - 7,'yyyy-mm-dd') into stat_start_time from dual;
    select to_char(trunc(stat_time - 1,'day') + 1,'yyyy-mm-dd') into stat_end_time from dual;
  end if;

  for kpiconfig in (select distinct b.kpiname,
         b.standardname,
         b.vendorid,
         b.ne_type,
         a.standard,
         b.extfilterkpi,
         b.extfiltervalue,
         b.exceptionfiltertype,
         b.exceptionfilterhours
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
      v_sql := 'insert into tpa_cnt_fpage_exception_tmp
      select/*+ full(a)*/
      to_date('''||stat_start_time||''',''yyyy-mm-dd'') as stat_time,
      '''||kpiconfig.kpiname||''' as kpiname,
      0 as num,
      0 as total,
      0 as ext_tag,
      a.*
      from tpa_cnt_fpage a
      where a.scan_start_time >= to_date('''||stat_start_time||''',''yyyy-mm-dd'')
      and a.scan_start_time < to_date('''||stat_end_time||''',''yyyy-mm-dd'')
      and to_char(a.scan_start_time, ''hh24'') in ('||kpiconfig.exceptionfilterhours||')
      and a.ne_type = '||kpiconfig.ne_type||'
      and a.region_id in ('||region_ids||')
      and a.sum_level = 0
      and ('||kpiconfig.standard||')';

    elsif (kpiconfig.exceptionfiltertype = '2') then
      v_sql := 'insert into tpa_cnt_fpage_exception_tmp
      select * from
      (
      select/*+ full(a)*/
      to_date('''||stat_start_time||''',''yyyy-mm-dd'') as stat_time,
      '''||kpiconfig.kpiname||''' as kpiname,
      sum(case when ('||kpiconfig.standard||') then 1 else 0 end) over(partition by a.int_id) as num,
      count(*) over(partition by a.int_id) as total,
      0 as ext_tag,
      a.*
      from tpa_cnt_fpage a
      where a.scan_start_time >= to_date('''||stat_start_time||''',''yyyy-mm-dd'') + 4
      and a.scan_start_time < to_date('''||stat_end_time||''',''yyyy-mm-dd'')
      and a.ne_type = '||kpiconfig.ne_type||'
      and a.region_id in ('||region_ids||')
      and a.sum_level = 0
      )where num = total';

    elsif (kpiconfig.exceptionfiltertype = '3') then
      v_sql := 'insert into tpa_cnt_fpage_exception_tmp
      select/*+ full(a)*/
      to_date('''||stat_start_time||''',''yyyy-mm-dd'') as stat_time,
      '''||kpiconfig.kpiname||''' as kpiname,
      0 as num,
      0 as total,
      0 as ext_tag,
      a.*
      from tpa_cnt_fpage a
      where a.scan_start_time >= to_date('''||stat_start_time||''',''yyyy-mm-dd'')
      and a.scan_start_time < to_date('''||stat_end_time||''',''yyyy-mm-dd'')
      and to_char(a.scan_start_time, ''hh24'') in ('||kpiconfig.exceptionfilterhours||')
      and a.ne_type = '||kpiconfig.ne_type||'
      and a.region_id in ('||region_ids||')
      and a.sum_level = 0
      and ('||kpiconfig.standard||')

      union all

      select tmp.*
      from
      (
      select/*+ full(a)*/
      to_date('''||stat_start_time||''',''yyyy-mm-dd'') as stat_time,
      '''||kpiconfig.kpiname||''' as kpiname,
      '||kpiconfig.extfilterkpi||' num,
      sum('||kpiconfig.extfilterkpi||') over(partition by scan_start_time) total,
      1 as ext_tag,
      a.*
      from tpa_cnt_fpage a
      where a.scan_start_time >= to_date('''||stat_start_time||''',''yyyy-mm-dd'')
      and a.scan_start_time < to_date('''||stat_end_time||''',''yyyy-mm-dd'')
      and a.ne_type = '||kpiconfig.ne_type||'
      and a.region_id in ('||region_ids||')
      and a.sum_level = 1
      )tmp where num >= (total * '||kpiconfig.extfiltervalue||')';

    elsif (kpiconfig.exceptionfiltertype = '4') then
      v_sql := 'insert into tpa_cnt_fpage_exception_tmp
      select/*+ full(a)*/
      to_date('''||stat_start_time||''',''yyyy-mm-dd'') as stat_time,
      '''||kpiconfig.kpiname||''' as kpiname,
      0 as num,
      0 as total,
      0 as ext_tag,
      a.*
      from tpa_cnt_fpage a
      where a.scan_start_time >= to_date('''||stat_start_time||''',''yyyy-mm-dd'')
      and a.scan_start_time < to_date('''||stat_end_time||''',''yyyy-mm-dd'')
      and a.ne_type = '||kpiconfig.ne_type||'
      and a.region_id in ('||region_ids||')
      and a.sum_level = 1
      and ('||kpiconfig.standard||')';

    elsif (kpiconfig.exceptionfiltertype = '5') then
      v_sql := 'insert into tpa_cnt_fpage_exception_tmp
      select/*+ full(a)*/
      to_date('''||stat_start_time||''',''yyyy-mm-dd'') as stat_time,
      '''||kpiconfig.kpiname||''' as kpiname,
      0 as num,
      0 as total,
      0 as ext_tag,
      a.*
      from tpa_cnt_fpage a
      where a.scan_start_time >= to_date('''||stat_start_time||''',''yyyy-mm-dd'')
      and a.scan_start_time < to_date('''||stat_end_time||''',''yyyy-mm-dd'')
      and a.int_id in(select int_id from c_tco_pro_cell where cover_earatype in (''市区'',''县城'',''密集市区''))
      and to_char(a.scan_start_time, ''hh24'') in ('||kpiconfig.exceptionfilterhours||')
      and a.ne_type = '||kpiconfig.ne_type||'
      and a.region_id in ('||region_ids||')
      and a.sum_level = 0
      and ('||kpiconfig.standard||')';
    end if;

    execute immediate v_sql;
  end;
  end loop;
  commit;

  --从临时表更新数据到tpa_cnt_fpage_exception，并删除临时表
  select count(*) into i_count from user_tables where table_name = 'TPA_CNT_FPAGE_EXCEPTION_HIS';
  if i_count > 0 then
    execute immediate 'delete from tpa_cnt_fpage_exception_his where stat_time < trunc(sysdate - 1,''day'') + 1 - 7*13';
    execute immediate 'delete from tpa_cnt_fpage_exception_his where stat_time = (select lateststattime from c_fpage_standard_ex where rownum = 1)';
    execute immediate 'insert into tpa_cnt_fpage_exception_his select * from tpa_cnt_fpage_exception';
    commit;
  end if;

  execute immediate 'delete from tpa_cnt_fpage_exception';
  execute immediate 'insert into tpa_cnt_fpage_exception select * from tpa_cnt_fpage_exception_tmp';
  commit;

  execute immediate 'delete from tpa_cnt_fpage_exception_tmp';
  commit;

  update c_fpage_standard_ex a set a.lateststattime = to_date(stat_start_time, 'yyyy-mm-dd');
  commit;

  select count(*) into i_count from user_tables where table_name = 'JOB_LOG';
  if i_count > 0 then
   execute immediate 'insert into job_log values(sysdate,''tpa_cnt_fpage_exception'',''sp_stat_for_fpage successfully completed!'')';
   commit;
  end if;
exception
  when others
  then
     msg := substr(sqlerrm||dbms_utility.format_error_backtrace,1,1000);
  rollback;
  select count(*) into i_count from user_tables where table_name = 'JOB_LOG';
  if i_count > 0 then
   execute immediate 'insert into job_log values(sysdate,''tpa_cnt_fpage_exception'','''||msg||''')';
   commit;
  end if;
  raise;
end sp_stat_for_fpage;
