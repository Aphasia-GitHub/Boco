create or replace procedure Alarm_auto is

v_sql varchar2(6000);
v_sql1 varchar2(6000);
v_sql2 varchar2(6000);
v_sql3 varchar2(32000);
stat_start_time varchar2(64);
s_error varchar2(4000);
--i_count integer;

begin
--扇区退服告警的统计，用于数据的补汇,不是自动执行；
  execute immediate 'delete from SectorRetire_Alarm_tmp';
  commit;
  select to_char(sysdate-1,'yyyy-mm-dd') into stat_start_time from dual;

 execute immediate 'delete from SectorRetire_Alarm where event_day=to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')';
  commit;
v_sql := 'insert into SectorRetire_Alarm_tmp(vendor ,
city_name ,
bsc_name ,
btsid ,
name ,
alarm_title ,
event_day ,
event_time ,
cancel_time ,
times )
select case
         when c.vendor_id = 7 then
         ''中兴''
         else
         ''朗讯''
       end as vendor,
       b.city_name as city_name,
       a.bsc_name as bsc_name,
       a.btsid as btsid,
       a.name as name,
       c.alarm_title as alarm_title,
       to_char(c.event_time, ''yyyy-mm-dd'') as event_day,
       to_char(c.event_time, ''hh24:mi:ss'') as event_time,
       case
         when c.cancel_time is null then
          ''23:59:59''
         else
          to_char(c.cancel_time, ''hh24:mi:ss'')
       end as cancel_time,
       case
         when c.cancel_time is null then
          round((to_date(to_char(to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'') +
                                 23.9996 / 24,
                                 ''yyyy-mm-dd hh24:mi:ss''),
                         ''yyyy-mm-dd hh24:mi:ss'') - c.event_time) * 24 * 60,
                2)
         else
          round((c.cancel_time - c.event_time) * 24 * 60, 2)
       end as times
  from c_cell a, c_region_city b, c_tfa_alarm_act c
 where a.city_id = b.city_id
   and a.int_id = c.int_id
   and c.object_class = 300
   and (c.org_type = 105 or
       c.omc_alarm_id in
       (132792, 132795, 132799, 132800, 132842, 133032, 133034, 133038,
        133039, 133105, 133160, 133183, 133190, 133199, 137770, 137911,
        137926, 202071, 202079, 202088, 202089))
   and c.event_time >= to_char(to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'') + 6 / 24,
                               ''yyyy-mm-dd hh24:mi:ss'')
   and c.event_time <
       to_char(to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'') + 1,
               ''yyyy-mm-dd hh24:mi:ss'')
               ';



execute immediate v_sql;

commit;

  execute immediate 'insert into SectorRetire_Alarm select * from SectorRetire_Alarm_tmp';
  commit;


--基站中断告警的统计，用于数据的补汇,不是自动执行；
  execute immediate 'delete from BtsOOS_Alarm_tmp';
  commit;
execute immediate 'delete from BtsOOS_Alarm where event_day=to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')';
  commit;
v_sql1 := 'insert into BtsOOS_Alarm_tmp(
vendor,
city_name,
bsc_name,
btsid,
alarm_title,
event_day,
event_time,
cancel_time,
times )
  select case when c.vendor_id=7 then ''中兴''
else ''朗讯''
end as vendor,
b.city_name as city_name,
a.bsc_name as bsc_name,
a.btsid as btsid,
c.alarm_title as alarm_title,
to_char(c.event_time,''yyyy-mm-dd'') as event_day,
to_char(c.event_time,''hh24:mi:ss'') as event_time,
case when
c.cancel_time is null
then ''23:59:59''
else to_char(c.cancel_time,''hh24:mi:ss'')
end  as cancel_time,
case
when c.cancel_time is null
then round((to_date(to_char(to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')+23.9996/24,''yyyy-mm-dd hh24:mi:ss''),''yyyy-mm-dd hh24:mi:ss'')-c.event_time)*24*60,2)
else round((c.cancel_time-c.event_time)*24*60,2)
end as times
 from c_bts a,c_region_city b,c_tfa_alarm_act c
where a.city_id=b.city_id
and a.int_id=c.int_id
and c.object_class=201
and (c.org_type = 103 or c.omc_alarm_id in (132776, 201792, 133157))
and c.event_time>=to_char(to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')+6/24,''yyyy-mm-dd hh24:mi:ss'')
 and c.event_time< to_char(to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')+1,''yyyy-mm-dd hh24:mi:ss'')
               ';



execute immediate v_sql1;

commit;

  execute immediate 'insert into BtsOOS_Alarm select * from BtsOOS_Alarm_tmp';
  commit;

--传输告警的统计，用于数据的补汇,不是自动执行；
  execute immediate 'delete from Trans_Alarm_tmp';
  commit;
execute immediate 'delete from Trans_Alarm where event_day=to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')';
  commit;


v_sql2 := 'insert into Trans_Alarm_tmp(
vendor,
city_name,
bsc_name,
btsid,
name,
alarm_title,
event_day,
event_time,
cancel_time,
times)
  select vendor as vendor,
city_name as city_name,
bsc_name as bsc_name,
btsid as btsid,
bts_name as bts_name,
alarm_title as alarm_title,
event_day as event_day,
event_time as event_time,
cancel_time as cancel_time,
times as times
from
(select case when c.vendor_id=7 then ''中兴''
else ''朗讯''
end as vendor,
b.city_name as city_name,
a.bsc_name as bsc_name,
a.btsid as btsid,
a.name as bts_name ,
c.alarm_title as alarm_title,
to_char(c.event_time,''yyyy-mm-dd'') as event_day,
to_char(c.event_time,''hh24:mi:ss'') as event_time,
case when
c.cancel_time is null
then ''23:59:59''
else to_char(c.cancel_time,''hh24:mi:ss'')
end  as cancel_time,
case
when c.cancel_time is null
then round((to_date(to_char(to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')+23.9996/24,''yyyy-mm-dd hh24:mi:ss''),''yyyy-mm-dd hh24:mi:ss'')-c.event_time)*24*60,2)
else round((c.cancel_time-c.event_time)*24*60,2)
end as times
from c_bts a,c_region_city b,c_tfa_alarm_act c
where a.city_id=b.city_id
and a.int_id=c.int_id
and c.object_class=201
and (c.org_type = 111 or
                                  c.omc_alarm_id in
                                  (513, 514, 516, 132778, 133062, 133063, 133064,
                                   133065, 133066, 133067, 133068, 133069, 133070,
                                   133071, 133072, 133073, 133074, 133075, 133076,
                                   133077, 139002, 201103)
)
 and c.event_time>=to_char(to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')+6/24,''yyyy-mm-dd hh24:mi:ss'')
 and c.event_time< to_char(to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')+1,''yyyy-mm-dd hh24:mi:ss''))
               ';



execute immediate v_sql2;

commit;

 execute immediate 'insert into Trans_Alarm select * from Trans_Alarm_tmp';
 commit;


 --基站断站告警日报的统计，用于数据的补汇,不是自动执行；
  execute immediate 'delete from alarm_all_tmp';
  commit;
execute immediate 'delete from alarm_all where time1=to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')';
  commit;


v_sql3 := 'insert into alarm_all_tmp(
time1,
name,
bts2m_count,
Trans_Alarm_sum,
Trans_Alarm_bts_count,
rate_Trans_Alarm,
rate_Trans_Alarm_bts,
bts_sum,
BtsOOS_Alarm_sum,
BtsOOS_Alarm_bts_count,
rate_BtsOOS_Alarm,
rate_BtsOOS_Alarm_bts,
cell_sum,
SectorRetire_Alarm_sum,
SectorRetire_Alarm_count,
rate_Sec_Alarm,
rate_Sec_Alarm_cell)
select case
   when b.time is null then substr('''||stat_start_time||''',1,10)
   else b.time
   end as time,
   a.city_name as name,
   nvl(b.bts2m_count,0) as bts2m_count,
   nvl(b.Trans_Alarm_sum,0) as Trans_Alarm_sum,
   nvl(b.Trans_Alarm_bts_count,0) as Trans_Alarm_bts_count,
   nvl(b.rate_Trans_Alarm,0) as rate_Trans_Alarm,
   nvl(b.rate_Trans_Alarm_bts,0) as rate_Trans_Alarm_bts,
   nvl(b.bts_sum,0) as bts_sum,
   nvl(b.BtsOOS_Alarm_sum,0) as BtsOOS_Alarm_sum,
   nvl(b.BtsOOS_Alarm_bts_count,0) as BtsOOS_Alarm_bts_count,
   nvl(b.rate_BtsOOS_Alarm,0) as rate_BtsOOS_Alarm,
   nvl(b.rate_BtsOOS_Alarm_bts,0) as rate_BtsOOS_Alarm_bts,
   nvl(b.cell_sum,0) as cell_sum,
   nvl(b.SectorRetire_Alarm_sum,0) as SectorRetire_Alarm_sum,
   nvl(b.SectorRetire_Alarm_count,0) as SectorRetire_Alarm_count,
   nvl(b.rate_Sec_Alarm,0) as rate_Sec_Alarm,
   nvl(b.rate_Sec_Alarm_cell,0) as rate_Sec_Alarm_cell
   from (select * from c_region_city  where  region_name=''\''
          and region_id!=-1) a
   left join
(select alarm.time as time,
       name,
       c_tco_pro_bts.bts2m_count bts2m_count,
       Trans_Alarm_sum,
       Trans_Alarm_bts_count,
       decode(bts2m_count,
              0,
              1,
              null,
              1,
              trunc(Trans_Alarm_sum / bts2m_count, 6)) * 100 rate_Trans_Alarm,
       decode(bts2m_count,
              0,
              1,
              null,
              1,
              trunc(Trans_Alarm_bts_count / bts2m_count, 6)) * 100 rate_Trans_Alarm_bts,
       c_tco_pro_bts.bts_sum as bts_sum,
       BtsOOS_Alarm_sum,
       BtsOOS_Alarm_bts_count,
       decode(bts_sum,
              0,
              1,
              null,
              1,
              trunc(BtsOOS_Alarm_sum / bts_sum, 6)) * 100 rate_BtsOOS_Alarm,
       decode(bts_sum,
              0,
              1,
              null,
              1,
              trunc(BtsOOS_Alarm_bts_count / bts_sum, 6)) * 100 rate_BtsOOS_Alarm_bts,
       c_tco_pro_cell.cell_sum as cell_sum,
       SectorRetire_Alarm_sum,
       SectorRetire_Alarm_count,
       decode(cell_sum,
              0,
              1,
              null,
              1,
              trunc(SectorRetire_Alarm_sum / cell_sum, 6)) * 100 rate_Sec_Alarm,
       decode(cell_sum,
              0,
              1,
              null,
              1,
              trunc(SectorRetire_Alarm_count / cell_sum, 6)) * 100 rate_Sec_Alarm_cell
  from (select bts.time as time,
  case
                 when bts.city_name is null then
                  cell.city_name
                 else
                  bts.city_name
               end as name,
               sum(case
                     when bts.Trans_Alarm > 0 then
                      1
                     else
                      0
                   end) as Trans_Alarm_bts_count,
               sum(bts.Trans_Alarm) as Trans_Alarm_sum,
               sum(case
                     when bts.BtsOOS_Alarm > 0 then
                      1
                     else
                      0
                   end) as BtsOOS_Alarm_bts_count,
               sum(bts.BtsOOS_Alarm) as BtsOOS_Alarm_sum,
               sum(case
                     when cell.SectorRetire_Alarm > 0 then
                      1
                     else
                      0
                   end) as SectorRetire_Alarm_count,
               sum(cell.SectorRetire_Alarm) as SectorRetire_Alarm_sum
          from (select to_char(a.event_time,''yyyy-mm-dd'') as time,
                        b.int_id,
                       c.city_name,
                       sum(case
                             when (org_type = 111 or
                                  omc_alarm_id in
                                  (513, 514, 516, 132778, 133062, 133063, 133064,
                                   133065, 133066, 133067, 133068, 133069, 133070,
                                   133071, 133072, 133073, 133074, 133075, 133076,
                                   133077, 139002, 201103)) then
                              1
                             else
                              0
                           end) Trans_Alarm,
                       sum(case
                             when (org_type = 103 or
                                  omc_alarm_id in (132776, 201792, 133157)) then
                              1
                             else
                              0
                           end) BtsOOS_Alarm
                  from c_tfa_alarm_act a, c_bts b, c_region_city c
                 where a.int_id = b.int_id
                   and b.city_id = c.city_id
                   and a.event_time >= to_char(to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')+6/24,''yyyy-mm-dd hh24:mi:ss'')
           and a.event_time < to_char(to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')+1,''yyyy-mm-dd hh24:mi:ss'')
                 group by b.int_id, c.city_name,to_char(a.event_time,''yyyy-mm-dd'')
                 order by c.city_name, b.int_id,to_char(a.event_time,''yyyy-mm-dd'')) bts
          full join (select to_char(a.event_time,''yyyy-mm-dd'') as time,
                             b.int_id,
                           c.city_name,
                           sum(case
                                 when (org_type = 105 or
                                      omc_alarm_id in
                                      (132792, 132795, 132799, 132800, 132842,
                                       133032, 133034, 133038, 133039, 133105,
                                       133160, 133183, 133190, 133199, 137770,
                                       137911, 137926, 202071, 202079, 202088,
                                       202089)) then
                                  1
                                 else
                                  0
                               end) SectorRetire_Alarm
                      from c_tfa_alarm_act a, c_cell b, c_region_city c
                     where a.int_id = b.int_id
                       and b.city_id = c.city_id
                   and    a.event_time >= to_char(to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')+6/24,''yyyy-mm-dd hh24:mi:ss'')
           and a.event_time < to_char(to_date('''||stat_start_time||''',''yyyy-mm-dd hh24:mi:ss'')+1,''yyyy-mm-dd hh24:mi:ss'')
              group by c.city_name, b.int_id,to_char(a.event_time,''yyyy-mm-dd'')
                     order by c.city_name, b.int_id,to_char(a.event_time,''yyyy-mm-dd'')) cell on bts.city_name =
                                                             cell.city_name
         group by case
                    when bts.city_name is null then
                     cell.city_name
                    else
                     bts.city_name
                  end,bts.time) alarm
  left join (select city_name, count(1) bts_sum, sum(nbr_2m) bts2m_count
               from c_tco_pro_bts
              group by city_name) c_tco_pro_bts on c_tco_pro_bts.city_name =
                                                   alarm.name
  left join (select city_name, count(1) cell_sum
               from c_tco_pro_cell
              group by city_name) c_tco_pro_cell on c_tco_pro_cell.city_name =alarm.name)
              b on a.city_name=b.name
               ';



execute immediate v_sql3;

commit;

 execute immediate 'insert into alarm_all select * from alarm_all_tmp';
  commit;


exception when others then
s_error := sqlerrm;
rollback;
insert into job_log values(sysdate,'Alarm_auto',s_error);
commit;

end Alarm_auto;
