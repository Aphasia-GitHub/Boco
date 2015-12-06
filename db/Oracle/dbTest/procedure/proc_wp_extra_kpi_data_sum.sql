create or replace procedure proc_wp_extra_kpi_data_sum(p_date date)
as
v_date date;
s_error varchar2(4000);

begin
--if null then v_date = sysdate-3 (3hours before) else v_date = p_date
select trunc(decode(p_date,null,trunc(sysdate - 1,'dd'),p_date),'dd') into v_date from dual;

---------------------------region
merge into wp_extra_kpi_data wp
using(
with temp1 as
(select
 int_id,
ne_type,
a.scan_start_time,
a_port_traffic
from wp_extra_kpi_data a
where a.scan_start_time between v_date and v_date+23/24 and a.sum_level=0 and a.ne_type=10003),
temp2 as
(select
temp1.int_id int_id,
temp1.ne_type ne_type,
max(a_port_traffic) a_port_traffic
from temp1
group by temp1.int_id,temp1.ne_type),
temp3 as
(select temp1.int_id int_id,temp1.ne_type ne_type,
max(scan_start_time) busy_time
from temp1,temp2
where temp2.int_id=temp1.int_id and temp2.ne_type=temp1.ne_type and temp2.a_port_traffic=temp1.a_port_traffic
group by temp1.int_id,temp1.ne_type),
temp4 as
(select r.region_id int_id,a.scan_start_time scan_start_time,a.ne_type ne_type,a.sum_level sum_level,
case when TCHLoadRate>0.7   then 1 else 0 end TCHLoadRate_busy_num ,
case when TCHLoadRate<0.1 then 1 else 0 end TCHLoadRate_nb_num ,
case when LoseCallingNum>=3 then 1 else 0 end LoseCallingNum_num ,
case when cs_CallPageSuccRate<0.8 then 1 else 0 end cs_CallPageSuccRate_num,
case when LoseCallingRate>0.05 then 1 else 0 end LoseCallingRate_num,
case when CallBlockFailNum>3 then 1 else 0 end CallBlockFailNum_num,
case when CallBlockFailRate>0.05 then 1 else 0 end CallBlockFailRate_num,
case when cs_HandoffSuccRate<0.9 then 1 else 0 end cs_HandoffSuccRate_num,
case when FwdChMaxUseRate>0.7 then 1 else 0 end FwdChMaxUseRate_num,
case when FwdChRxRate>0.05 then 1 else 0 end FwdChRxRate_num,
case when RevChRxRate>0.05 then 1 else 0 end RevChRxRate_num
from c_perf_1X_sum_cell a  ,c_cell c,c_region_city r
where a.int_id=r.region_id and c.city_id=r.city_id and a.scan_start_time between v_date and v_date+23/24 and a.sum_level=0 and a.ne_type=10003)
select  temp4.int_id int_id,temp4.scan_start_time busy_time,
sum(TCHLoadRate_busy_num) TCHLoadRate_busy_num,
sum(TCHLoadRate_nb_num) TCHLoadRate_nb_num,
sum(LoseCallingNum_num) LoseCallingNum_num,
sum(cs_CallPageSuccRate_num) cs_CallPageSuccRate_num,
sum(LoseCallingRate_num) LoseCallingRate_num,
sum(CallBlockFailNum_num) CallBlockFailNum_num,
sum(CallBlockFailRate_num) CallBlockFailRate_num,
sum(cs_HandoffSuccRate_num) cs_HandoffSuccRate_num,
sum(FwdChMaxUseRate_num) FwdChMaxUseRate_num,
sum(FwdChRxRate_num) FwdChRxRate_num,
sum(RevChRxRate_num) RevChRxRate_num
from temp3,temp4
where temp4.int_id=temp3.int_id and temp4.scan_start_time=temp3.busy_time and temp4.sum_level=0 and temp4.ne_type=10003
group by temp4.int_id,temp4.scan_start_time) t
on(wp.int_id = t.int_id and wp.scan_start_time = v_date and wp.ne_type=10003 and wp.sum_level=1)
when matched then update set
busy_time      =t.busy_time,
TCHLoadRate_busy_num    =t.TCHLoadRate_busy_num,
TCHLoadRate_nb_num         =t.TCHLoadRate_nb_num ,
LoseCallingNum_num              =t.LoseCallingNum_num ,
cs_CallPageSuccRate_num         =t.cs_CallPageSuccRate_num ,
LoseCallingRate_num             =t.LoseCallingRate_num  ,
CallBlockFailNum_num           =t.CallBlockFailNum_num ,
CallBlockFailRate_num           =t.CallBlockFailRate_num  ,
cs_HandoffSuccRate_num          =t.cs_HandoffSuccRate_num ,
FwdChMaxUseRate_num             =t.FwdChMaxUseRate_num ,
FwdChRxRate_num                 =t.FwdChRxRate_num ,
RevChRxRate_num                 =t.RevChRxRate_num
when not matched then insert (
wp.int_id,
wp.scan_start_time,
wp.ne_type,
wp.sum_level,
wp.busy_time,
wp.TCHLoadRate_busy_num,
wp.TCHLoadRate_nb_num ,
wp.LoseCallingNum_num  ,
wp.cs_CallPageSuccRate_num ,
wp.LoseCallingRate_num  ,
wp.CallBlockFailNum_num  ,
wp.CallBlockFailRate_num ,
wp.cs_HandoffSuccRate_num ,
wp.FwdChMaxUseRate_num,
wp.FwdChRxRate_num  ,
wp.RevChRxRate_num)
values(
t.int_id,
v_date,
10003,
1,
t.busy_time,
t.TCHLoadRate_busy_num,
t.TCHLoadRate_nb_num ,
t.LoseCallingNum_num ,
t.cs_CallPageSuccRate_num ,
t.LoseCallingRate_num  ,
t.CallBlockFailNum_num ,
t.CallBlockFailRate_num  ,
t.cs_HandoffSuccRate_num ,
t.FwdChMaxUseRate_num ,
t.FwdChRxRate_num ,
t.RevChRxRate_num
);
commit;

merge into wp_extra_kpi_data wp
using(
with temp1 as
(select
 int_id,
ne_type,
a.scan_start_time,
a_port_traffic
from wp_extra_kpi_data a
where  a.scan_start_time between v_date and v_date+23/24 and a.sum_level=0 and a.ne_type=10003),
temp2 as
(select
temp1.int_id int_id,
temp1.ne_type ne_type,
max(a_port_traffic) a_port_traffic
from temp1
group by temp1.int_id,temp1.ne_type),
temp3 as
(select temp1.int_id int_id,temp1.ne_type ne_type,
max(scan_start_time) busy_time
from temp1,temp2
where temp2.int_id=temp1.int_id and temp2.ne_type=temp1.ne_type and temp2.a_port_traffic=temp1.a_port_traffic
group by temp1.int_id,temp1.ne_type),
temp4 as
(select r.region_id int_id,a.scan_start_time scan_start_time,a.ne_type ne_type,a.sum_level sum_level,
case when WireConnectSuccRate<0.8   then 1 else 0 end WireConnectSuccRate_num ,
case when WireRadioFRate>0.05 then 1 else 0 end WireRadioFRate_num ,
case when FwdRLPRxRate>0.05 then 1 else 0 end FwdRLPRxRate_num ,
case when RevRLPRxRate>0.05 then 1 else 0 end RevRLPRxRate_num
from c_perf_DO_sum_cell a  ,c_cell c,c_region_city r
where a.int_id=r.region_id and c.city_id=r.city_id and a.scan_start_time between v_date and v_date+23/24 and a.sum_level=0 and a.ne_type=10003)
select  temp4.int_id int_id,temp4.scan_start_time busy_time,
sum(WireConnectSuccRate_num) WireConnectSuccRate_num,
sum(WireRadioFRate_num) WireRadioFRate_num,
sum(FwdRLPRxRate_num) FwdRLPRxRate_num,
sum(RevRLPRxRate_num) RevRLPRxRate_num
from temp3,temp4
where temp4.int_id=temp3.int_id and temp4.scan_start_time=temp3.busy_time and temp4.sum_level=0 and temp4.ne_type=10003
group by temp4.int_id,temp4.scan_start_time) t
on(wp.int_id = t.int_id and wp.scan_start_time = v_date and wp.ne_type=10003 and wp.sum_level=1)
when matched then update set
busy_time      =t.busy_time,
WireConnectSuccRate_num    =t.WireConnectSuccRate_num,
WireRadioFRate_num         =t.WireRadioFRate_num ,
FwdRLPRxRate_num              =t.FwdRLPRxRate_num ,
RevRLPRxRate_num         =t.RevRLPRxRate_num
when not matched then insert (
int_id,
scan_start_time,
ne_type,
sum_level,
busy_time,
WireConnectSuccRate_num,
WireRadioFRate_num ,
FwdRLPRxRate_num ,
RevRLPRxRate_num )
values(
t.int_id,
v_date,
10003,
1,
t.busy_time,
t.WireConnectSuccRate_num,
t.WireRadioFRate_num ,
t.FwdRLPRxRate_num ,
t.RevRLPRxRate_num
);
commit;


merge into wp_extra_kpi_data wp
using(
with temp1 as
(select
 int_id,
ne_type,
a.scan_start_time,
a_port_traffic
from wp_extra_kpi_data a
where  a.scan_start_time between v_date and v_date+23/24 and a.sum_level=0 and a.ne_type=10003),
temp2 as
(select
temp1.int_id int_id,
temp1.ne_type ne_type,
max(a_port_traffic) a_port_traffic
from temp1
group by temp1.int_id,temp1.ne_type),
temp3 as
(select temp1.int_id int_id,temp1.ne_type ne_type,
max(scan_start_time) busy_time
from temp1,temp2
where temp2.int_id=temp1.int_id and temp2.ne_type=temp1.ne_type and temp2.a_port_traffic=temp1.a_port_traffic
group by temp1.int_id,temp1.ne_type),
temp4 as
(select r.region_id int_id,a.scan_start_time scan_start_time,a.ne_type ne_type,a.sum_level sum_level,
case when trafficExcludeHoCs=0   then 1 else 0 end tch_traffic_nho_num
from c_tpa_sts_cell a  ,c_cell c,c_region_city r
where a.int_id=r.region_id and c.city_id=r.city_id and a.scan_start_time between v_date and v_date+23/24 and a.sum_level=0 and a.ne_type=10003)
select  temp4.int_id int_id,temp4.scan_start_time busy_time,
sum(tch_traffic_nho_num) tch_traffic_nho_num
from temp3,temp4
where temp4.int_id=temp3.int_id and temp4.scan_start_time=temp3.busy_time and temp4.sum_level=0 and temp4.ne_type=10003
group by temp4.int_id,temp4.scan_start_time) t
on(wp.int_id = t.int_id and wp.scan_start_time = v_date and wp.ne_type=10003 and wp.sum_level=1)
when matched then update set
tch_traffic_nho_num    =t.tch_traffic_nho_num
when not matched then insert (
int_id,
scan_start_time,
ne_type,
sum_level,
tch_traffic_nho_num)
values(
t.int_id,
v_date,
10003,
1,
t.tch_traffic_nho_num
);
commit;

exception when others then
s_error := sqlerrm;
rollback;
insert into job_log values(sysdate,'wp_extra_kpi_data',s_error);
commit;

end;
