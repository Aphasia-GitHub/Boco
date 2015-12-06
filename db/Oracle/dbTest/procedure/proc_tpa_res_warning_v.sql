create or replace procedure proc_tpa_res_warning_v(p_date date)
as
v_date date;
s_error varchar2(4000);
v_sql varchar2(4000);

begin
select trunc(decode(p_date,null,trunc(sysdate-3/24,'hh24'),p_date),'hh24') into v_date from dual;


delete from tpa_res_warning where scan_start_time=v_date;

v_sql:=' create global temporary table tpa_res_warning_temp (
          int_id  integer,
         ne_type  integer,
         scan_start_time  Date,
         sum_level  integer,
         city_id  integer,
         city_name  varchar(128),
         WalshPeakUtilization float,
         CePeakUtilization float,
         AccessPeakUtilization float,
         PagingPeakUtilization float,
         FwdMaxUseRate_MacIndex float,
         RevCEMaxUseRate float,
         RevACHPhySlotUseRate float,
         FwdCCHPhyTimeSlotUseRate float,
         FwdTCHPhyTimeSlotUseRate float,
         CallPageSuccRate  float,
         LoseCallingRate  float,
         CallBlockFailRate  float,
         cs_TrafficIncludeHo  float,
         ps_CallTrafficIncludeHo  float,
         WireConnectSuccRate  float,
         NetWorkRadioFRate  float,
         Call_Traffic  float) on commit delete rows;';
execute immediate v_sql;

v_sql:='insert into tpa_res_warning_temp
(
int_id,
ne_type,
scan_start_time,
sum_level,
CallPageSuccRate,
LoseCallingRate,
CallBlockFailRate,
cs_TrafficIncludeHo,
ps_CallTrafficIncludeHo,
WireConnectSuccRate,
NetWorkRadioFRate,
Call_Traffic
)
select
a.int_id,
a.ne_type,
a.scan_start_time,
a.sum_level,
a.CallPageSuccRate,
a.LoseCallingRate,
a.CallBlockFailRate,
a.cs_TrafficIncludeHo,
a.ps_CallTrafficIncludeHo,
b.WireConnectSuccRate,
b.NetWorkRadioFRate,
b.Call_Traffic
from c_perf_1X_sum_cell a,c_perf_DO_sum_cell b
where a.int_id=b.int_id and a.scan_start_time=b.scan_start_time and a.ne_type=b.ne_type and b.ne_type=400  and  b.scan_start_time='||v_date||'
and a.sum_level=b.sum_level and b.sum_level=0;';

execute immediate v_sql;


v_sql:='insert into tpa_res_warning_temp
(
int_id,
ne_type,
scan_start_time,
sum_level,
CallPageSuccRate,
LoseCallingRate,
CallBlockFailRate,
cs_TrafficIncludeHo,
ps_CallTrafficIncludeHo,
WireConnectSuccRate,
NetWorkRadioFRate,
Call_Traffic
)
select
a.int_id,
a.ne_type,
a.scan_start_time,
a.sum_level,
a.CallPageSuccRate,
a.LoseCallingRate,
a.CallBlockFailRate,
a.cs_TrafficIncludeHo,
a.ps_CallTrafficIncludeHo,
b.WireConnectSuccRate,
b.NetWorkRadioFRate,
b.Call_Traffic
from c_perf_1X_sum_cell a,c_perf_DO_sum_cell b
where a.int_id=b.int_id and a.scan_start_time=b.scan_start_time and a.ne_type=b.ne_type and b.ne_type=201  and  b.scan_start_time='||v_date||'
and a.sum_level=b.sum_level and b.sum_level=0;';

execute immediate v_sql;


--lc
--WalshPeakUtilization

v_sql:='insert into  tpa_res_warning_temp
(
int_id,
Ne_type,
Sum_level,
WalshPeakUtilization
)
( with temp as(
select
r.int_id int_id,
case when a.pref_rc=3 then c.C054/64
     when a.pref_rc=4 then c.C054/128 end kpivalue
from c_tpd_cnt_carr_lc c,C_tlc_par_cell a ,c_carrier r
where c.int_id=r.int_id and r.int_id=a.int_id and c.scan_start_time='||v_date||' )
select
int_id,
400,
0,
temp.kpivalue
from temp
where kpivalue>=0.85);';

execute immediate v_sql;



--CePeakUtilization
v_sql:='insert into tpa_res_warning_temp
(
int_id,
Ne_type,
Sum_level,
CePeakUtilization
)
(with temp as(
select
a.int_id,
a.ne_type ne_type,
TCEUsgPeak/decode(TCEA,null,1,0,1,TCEA)*100 kpivalue
from tpa_smt_bts_lc a,tpa_res_warning b
where a.int_id=b.int_id and a.scan_start_time=b.scan_start_time and a.sum_level=0 )
select
int_id,
201,
0,
kpivalue
from temp
where kpivalue>=85);';

execute immediate v_sql;

--PeakACOP
--PeakPCOP
v_sql:='insert into tpa_res_warning_temp
(
int_id,
Ne_type,
Sum_level,
AccessPeakUtilization,
PagingPeakUtilization
)
(select
int_id,
ne_type,
0,
case when a.PeakACOP>=60 then a.PeakACOP else null end PeakACOP,
case when a.PeakPCOP>=70 then a.PeakPCOP else null end PeakPCOP
from tpa_smt_carr_lc a ,tpa_res_warning_temp tpa
where tpa.int_id=a.int_id and tpa.scan_start_time=a.scan_start_time);';

execute immediate v_sql;


--zx
--WalshPeakUtilization
v_sql:='insert into tpa_res_warning_temp
(
int_id,
Ne_type,
Sum_level,
WalshPeakUtilization
)
( with temp as(
select
r.int_id int_id,
sum(a.PEAKNUMWALSHRANK64)/sum(case when c.WALSH_LEN=64 then 64 end) kpivalue1,
sum(a.PEAKNUMWALSHRANK128)/sum(case when c.WALSH_LEN=128 then 128 end) kpivalue2
from c_tzx_par_chan c,c_tpa_1X_serv_sum a ,c_carrier r
where c.related_carrier=r.int_id and r.int_id=a.int_id and a.scan_start_time='||v_date||')
group by r.int_id )
select
v_date,
int_id,
400,
0,
case when  kpivalue1 is null then (case when kpivalue2>=0.85 then kpivalue2 else null end)  else  (case when kpivalue1>=0.85 then kpivalue1 else null end) end
from temp ';

execute immediate v_sql;



--CePeakUtilization
v_sql:='insert into tpa_res_warning_temp
(
int_id,
Ne_type,
Sum_level,
CePeakUtilization
)
(with temp as (
select
a.int_id,
MaxBusyRCENum/decode(ReliableRCENum,null,1,0,1,ReliableRCENum)*100 kpivalue
from C_tpa_cnt_bts_zx  a,tpa_res_warning_temp tpa
where a.int_id=tpa.int_id and a.scan_start_time=tpa.scan_start_time and a.sum_level=0)
select
int_id,
201,
0,
temp.kpivalue
from temp
where kpivalue>=85);';

execute immediate v_sql;

--AccessPeakUtilization
--PagingPeakUtilization
v_sql:='insert into tpa_res_warning_temp
(
int_id,
Ne_type,
Sum_level,
AccessPeakUtilization,
PagingPeakUtilization
)
=(select
int_id,
400,
0,
case when a.AccessPeakUtilization>=60 then a.AccessPeakUtilization else null end AccessPeakUtilization,
case when a.PagingPeakUtilization>=70 then a.PagingPeakUtilization else null end PagingPeakUtilization
from c_tpa_1X_call_sum a ,tpa_res_warning_temp tpa
where a.int_id=tpa.int_id and a.scan_start_time=tpa.scan_start_time and ne_type=400);';

execute immediate v_sql;


-- FwdMaxUseRate_MacIndex        90%
---- RevCEMaxUseRate              70%
-- RevACHPhySlotUseRate         40%
-- FwdCCHPhyTimeSlotUseRate     15%
-- FwdTCHPhyTimeSlotUseRate     90%

v_sql:='insert into tpa_res_warning_temp
(
int_id,
Ne_type,
Sum_level,
FwdMaxUseRate_MacIndex  ,
--RevCEMaxUseRate         ,
RevACHPhySlotUseRate    ,
FwdCCHPhyTimeSlotUseRate,
FwdTCHPhyTimeSlotUseRate
)
=(select
int_id,
400,
0,
case when a.FwdMaxUseRate_MacIndex>=90 then a.FwdMaxUseRate_MacIndex else null end FwdMaxUseRate_MacIndex,
--case when a.RevCEMaxUseRate>=70 then a.RevCEMaxUseRate else null end RevCEMaxUseRate,
case when a.RevACHPhySlotUseRate>=40 then a.RevACHPhySlotUseRate else null end RevACHPhySlotUseRate,
case when a.FwdCCHPhyTimeSlotUseRate>=15 then a.FwdCCHPhyTimeSlotUseRate else null end FwdCCHPhyTimeSlotUseRate,
case when a.FwdTCHPhyTimeSlotUseRate>=90 then a.FwdTCHPhyTimeSlotUseRate else null end FwdTCHPhyTimeSlotUseRate
from c_perf_DO_sum_cell a ,tpa_res_warning_temp tpa
where a.int_id=tpa.int_id and a.scan_start_time=tpa.scan_start_time and a.ne_type=400);';

execute immediate v_sql;

v_sql:='insert into tpa_res_warning_temp
(
int_id,
Ne_type,
Sum_level,
RevCEMaxUseRate
)
=(select
int_id,
201,
0,
case when a.RevCEMaxUseRate>=70 then a.RevCEMaxUseRate else null end RevCEMaxUseRate
from c_perf_DO_sum_cell a ,tpa_res_warning_temp tpa
where a.int_id=tpa.int_id and a.scan_start_time=tpa.scan_start_time and a.ne_type=201);';

v_sql:='insert into tpa_res_warning_temp
(
int_id,
city_id,
city_name
)
(select
tpa.int_id,
c.city_id,
r.city_name
from  c_carrier c,c_region_city r,tpa_res_warning tpa
where tpa.int_id=c.int_id  and c.city_id=r.city_id) ;';

execute immediate v_sql;

v_sql:='insert into tpa_res_warning_temp
(
int_id,
city_id,
city_name
)
=(select
tpa.int_id,
c.city_id,
r.city_name
from  c_carrier c,c_region_city r,tpa_res_warning tpa
where tpa.int_id=c.related_bts  and c.city_id=r.city_id ) ;';

execute immediate v_sql;

v_sql:='insert into tpa_res_warning
         (
         int_id  ,
         ne_type  ,
         scan_start_time ,
         sum_level  ,
         city_id  ,
         city_name  ,
         WalshPeakUtilization ,
         CePeakUtilization ,
         AccessPeakUtilization ,
         PagingPeakUtilization ,
         FwdMaxUseRate_MacIndex ,
         RevCEMaxUseRate ,
         RevACHPhySlotUseRate ,
         FwdCCHPhyTimeSlotUseRate ,
         FwdTCHPhyTimeSlotUseRate ,
         CallPageSuccRate  ,
         LoseCallingRate  ,
         CallBlockFailRate  ,
         cs_TrafficIncludeHo  ,
         ps_CallTrafficIncludeHo  ,
         WireConnectSuccRate  ,
         NetWorkRadioFRate  ,
         Call_Traffic
        )
        select
        int_id  ,
        ne_type  ,
        scan_start_time ,
        sum_level  ,
        max(city_id)  ,
        max(city_name)  ,
        max(WalshPeakUtilization) ,
        max(CePeakUtilization) ,
        max(AccessPeakUtilization) ,
        max(PagingPeakUtilization) ,
        max(FwdMaxUseRate_MacIndex) ,
        max(RevCEMaxUseRate) ,
        max(RevACHPhySlotUseRate) ,
        max(FwdCCHPhyTimeSlotUseRate) ,
        max(FwdTCHPhyTimeSlotUseRate) ,
        max(CallPageSuccRate)  ,
        max(LoseCallingRate)  ,
        max(CallBlockFailRate)  ,
        max(cs_TrafficIncludeHo)  ,
        max(ps_CallTrafficIncludeHo)  ,
        max(WireConnectSuccRate)  ,
        max(NetWorkRadioFRate)  ,
        max(Call_Traffic)
        from tpa_res_warning_temp
        group by int_id,ne_type,scan_start_time ,sum_level;';

execute immediate v_sql;
commit;

v_sql:='drop table tpa_res_warning_temp';
execute immediate v_sql;
commit;
----------------------------
exception when others then
s_error := sqlerrm;
rollback;
insert into job_log values(sysdate,'proc_tpa_res_warning_v',s_error);
commit;

end;
