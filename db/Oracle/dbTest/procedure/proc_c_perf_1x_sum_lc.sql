create or replace procedure proc_c_perf_1x_sum_lc(p_date date)
as
v_date date;
s_error varchar2(4000);
v_sql long;
-- C_tpd_cnt_carr_lc a,C_tpd_cnt_carr_pd_lc b,C_tpd_cnt_bts_lc c,C_tpd_cnt_carr_rc_lc d
-- ne_type = 101 msc

begin
--if null then v_date = sysdate-3 (3hours before) else v_date = p_date
select trunc(decode(p_date,null,trunc(sysdate-4/24,'hh24'),p_date),'hh24') into v_date from dual;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

v_sql:='truncate table  C_PERF_1X_SUM_LC_TEMP';
dbms_output.put_line(v_sql);
execute immediate v_sql;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

v_sql:='truncate table C_TPD_1X_SUM_LC_TEMP';
dbms_output.put_line(v_sql);
execute immediate v_sql;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

---------------------------------------------------------------------------------------------------start--C_TPD_1X_SUM_LC_TEMP

insert /*+append*/into C_TPD_1X_SUM_LC_TEMP
(
INT_ID,
OBJECT_RDN,
RECORD_ID,
NAME,
PERIOD,
OMC_ID,
BTSID,
SECTORID,
CARRIERID,
VENDOR_ID,
SCAN_START_TIME,
SCAN_STOP_TIME,
INSERT_TIME,
SERVICE_OPTION,
UNIQUE_RDN,
c006,
c008,
c011,
c012,
c013,
c014,
c062,
c063,
c085,
c086,
c152,
c153,
c276,
c277,
c278,
c279,
esc01,
esc02,
esc03,
esc04,
esc05,
esc06,
esc07,
esc08,
esc09,
esc12,
esc13,
esc14,
esc15,
esc16,
esc17,
esc18,
esc19,
esc20,
esc21,
esc22,
esc23,
sc015,
sc016,
sc017,
sc018,
sc019,
sc020,
sc032,
sc033,
sc038,
sc039,
sc040,
sc041,
sc104,
sc105,
sc106,
sc107,
sc108,
sc109,
sc110,
sc111,
sc112,
sc113,
sc114,
sc115,
sc116,
sc117,
sc160,
sc162,
sc164,
sc166,
vo13,
vo16,
vo20,
vo30,
vo31,
vo32,
vo33,
vo34,
vo35,
vo36,
vo37,
vo38,
vo39,
vo40,
c029,
c031,
c033,
c034,
c035,
c036,
ec01,
ec02,
esc24,
esc25,
esc26,
esc27,
c264,
ec22,
ec23,
esc28,
esc29,
esc30,
esc32,
esc34,
esc35,
esc43,
esc44,
esc45,
esc46,
L037,
L038,
L039,
L040,
L041,
L042,
L043,
L044,
L045,
L046,
L076,
L077,
L078,
L079,
L097,
L098,
L099,
sc021,
sc022,
sc023,
sc024,
sc036,
sc037,
sc042,
sc043,
sc044,
sc045,
sc046,
sc047,
sc048,
sc050,
sc051,
sc053,
sc054,
sc056,
sc057,
sc059,
sc068,
sc069,
sc070,
sc071,
sc118,
sc119,
sc159,
sc161,
sc163,
sc165,
sc167,
sc168,
sc195,
sc197,
sc194,
sc196
)
select /*+full(C_tpd_cnt_carr_lc)*/
INT_ID,
OBJECT_RDN,
RECORD_ID,
NAME,
PERIOD,
OMC_ID,
BTSID,
SECTORID,
CARRIERID,
VENDOR_ID,
SCAN_START_TIME,
SCAN_STOP_TIME,
INSERT_TIME,
SERVICE_OPTION,
UNIQUE_RDN,
c006,
c008,
c011,
c012,
c013,
c014,
c062,
c063,
c085,
c086,
c152,
c153,
c276,
c277,
c278,
c279,
esc01,
esc02,
esc03,
esc04,
esc05,
esc06,
esc07,
esc08,
esc09,
esc12,
esc13,
esc14,
esc15,
esc16,
esc17,
esc18,
esc19,
esc20,
esc21,
esc22,
esc23,
sc015,
sc016,
sc017,
sc018,
sc019,
sc020,
sc032,
sc033,
sc038,
sc039,
sc040,
sc041,
sc104,
sc105,
sc106,
sc107,
sc108,
sc109,
sc110,
sc111,
sc112,
sc113,
sc114,
sc115,
sc116,
sc117,
sc160,
sc162,
sc164,
sc166,
vo13,
vo16,
vo20,
vo30,
vo31,
vo32,
vo33,
vo34,
vo35,
vo36,
vo37,
vo38,
vo39,
vo40,
c029,
c031,
c033,
c034,
c035,
c036,
ec01,
ec02,
esc24,
esc25,
esc26,
esc27,
c264,
ec22,
ec23,
esc28,
esc29,
esc30,
esc32,
esc34,
esc35,
esc43,
esc44,
esc45,
esc46,
L037,
L038,
L039,
L040,
L041,
L042,
L043,
L044,
L045,
L046,
L076,
L077,
L078,
L079,
L097,
L098,
L099,
sc021,
sc022,
sc023,
sc024,
sc036,
sc037,
sc042,
sc043,
sc044,
sc045,
sc046,
sc047,
sc048,
sc050,
sc051,
sc053,
sc054,
sc056,
sc057,
sc059,
sc068,
sc069,
sc070,
sc071,
sc118,
sc119,
sc159,
sc161,
sc163,
sc165,
sc167,
sc168,
sc195,
sc197,
sc194,
sc196
from C_tpd_cnt_carr_lc
where scan_start_time=v_date;
commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');


insert /*+append*/ into C_TPD_1X_SUM_LC_TEMP
(
INT_ID,
OBJECT_RDN,
RECORD_ID,
PERIOD,
OMC_ID,
VENDOR_ID,
SCAN_START_TIME,
SCAN_STOP_TIME,
INSERT_TIME,
ECPID,
BTSID,
l1,
cs004,
l2,
cs007,
cs008,
a70)
select/*+full(C_tpd_cnt_bts_lc)*/
INT_ID,
OBJECT_RDN,
RECORD_ID,
PERIOD,
OMC_ID,
VENDOR_ID,
SCAN_START_TIME,
SCAN_STOP_TIME,
INSERT_TIME,
ECPID,
BTSID,
l1,
cs004,
l2,
cs007,
cs008,
a70
from C_tpd_cnt_bts_lc
where scan_start_time=v_date;
commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

insert /*+append*/ into C_TPD_1X_SUM_LC_TEMP
(
int_id,
OBJECT_RDN,
RECORD_ID,
NAME,
RELATED_BSC,
BSC_NAME,
PERIOD,
OMC_ID,
VENDOR_ID,
SCAN_START_TIME,
SCAN_STOP_TIME,
INSERT_TIME,
nbrAvailCe
)
select /*+full(c_tpd_sts_bts)*/
int_id,
OBJECT_RDN,
RECORD_ID,
NAME,
RELATED_BSC,
BSC_NAME,
PERIOD,
OMC_ID,
VENDOR_ID,
SCAN_START_TIME,
SCAN_STOP_TIME,
INSERT_TIME,
nbrAvailCe
from c_tpd_sts_bts where scan_start_time=v_date;
commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

insert /*+append*/ into C_TPD_1X_SUM_LC_TEMP
(
INT_ID,
OBJECT_RDN,
RECORD_ID,
PERIOD,
OMC_ID,
VENDOR_ID,
SCAN_START_TIME,
SCAN_STOP_TIME,
ECPID,
BTSID,
SECTORID,
CARRIERID,
UNIQUE_RDN,
escpd01,
escpd02,
escpd03,
escpd04,
escpd05,
escpd06,
escpd07,
escpd08,
escpd09,
escpd12,
escpd13,
escpd14,
escpd15,
escpd16,
escpd17,
escpd18,
escpd19,
escpd20,
escpd21,
escpd22,
escpd23,
scpd015,
scpd016,
scpd017,
scpd018,
scpd019,
scpd020,
scpd032,
scpd033,
scpd038,
scpd039,
scpd040,
scpd041,
scpd104,
scpd105,
scpd106,
scpd107,
scpd108,
scpd109,
scpd110,
scpd111,
scpd112,
scpd113,
scpd114,
scpd115,
scpd116,
scpd117,
scpd160,
scpd162,
scpd164,
scpd166,
escpd29,
escpd32,
escpd35,
escpd44,
escpd46,
scpd036,
scpd037,
scpd042,
scpd043,
scpd044,
scpd045,
scpd046,
scpd047,
scpd054,
scpd056,
scpd057,
scpd059,
scpd119,
scpd161,
scpd165,
scpd168,
scpd195,
scpd197
)
select /*+full(C_tpd_cnt_carr_pd_lc)*/
INT_ID,
OBJECT_RDN,
RECORD_ID,
PERIOD,
OMC_ID,
VENDOR_ID,
SCAN_START_TIME,
SCAN_STOP_TIME,
ECPID,
BTSID,
SECTORID,
CARRIERID,
UNIQUE_RDN,
escpd01,
escpd02,
escpd03,
escpd04,
escpd05,
escpd06,
escpd07,
escpd08,
escpd09,
escpd12,
escpd13,
escpd14,
escpd15,
escpd16,
escpd17,
escpd18,
escpd19,
escpd20,
escpd21,
escpd22,
escpd23,
scpd015,
scpd016,
scpd017,
scpd018,
scpd019,
scpd020,
scpd032,
scpd033,
scpd038,
scpd039,
scpd040,
scpd041,
scpd104,
scpd105,
scpd106,
scpd107,
scpd108,
scpd109,
scpd110,
scpd111,
scpd112,
scpd113,
scpd114,
scpd115,
scpd116,
scpd117,
scpd160,
scpd162,
scpd164,
scpd166,
escpd29,
escpd32,
escpd35,
escpd44,
escpd46,
scpd036,
scpd037,
scpd042,
scpd043,
scpd044,
scpd045,
scpd046,
scpd047,
scpd054,
scpd056,
scpd057,
scpd059,
scpd119,
scpd161,
scpd165,
scpd168,
scpd195,
scpd197

from C_tpd_cnt_carr_pd_lc where scan_start_time=v_date;

commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');


insert /*+append*/ into C_TPD_1X_SUM_LC_TEMP
(
INT_ID,
OBJECT_RDN,
RECORD_ID,
NAME,
PERIOD,
OMC_ID,
ECPID,
BTSID,
SECTORID,
CARRIERID,
RCID,
VENDOR_ID,
SCAN_START_TIME,
SCAN_STOP_TIME,
INSERT_TIME,
UNIQUE_RDN,
c02,
c05,
c04
)
select/*+full(C_TPD_CNT_CARR_RC_LC)*/
INT_ID,
OBJECT_RDN,
RECORD_ID,
NAME,
PERIOD,
OMC_ID,
ECPID,
BTSID,
SECTORID,
CARRIERID,
RCID,
VENDOR_ID,
SCAN_START_TIME,
SCAN_STOP_TIME,
INSERT_TIME,
UNIQUE_RDN,
c02,
c05,
c04
from  C_TPD_CNT_CARR_RC_LC where scan_start_time=v_date;
 commit;
 dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

-------------------------------------------------------------------------------end C_TPD_1X_SUM_LC_TEMP
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
cs_SSHOTraffic,
cs_TrafficIncludeHo         ,
ps_CallTrafficIncludeHo     ,
ps_CallTrafficExcludeHo     ,
LoseCallingNum              ,
cs_LoseCallingNum           ,
cs_TchReqNumIncludeHo       ,
cs_TchSuccNumIncludeHo      ,
cs_TchSuccIncludeHoRate     ,
cs_HardhoReqNum             ,
cs_HardhoSuccNum            ,
cs_HardhoSuccRate           ,
cs_SofthoReqNum             ,
cs_SofthoSuccNum            ,
cs_SofthoSuccRate           ,
cs_SSofthoReqNum            ,
cs_SSofthoSuccNum           ,
cs_SSofthoSuccRate          ,
TchReqNumCallerExcludeHoSms ,
TchSuccNumCallerExcludeHoSms,
TchReqNumCalleeExcludeHoSms ,
TchSuccNumCalleeExcludeHoSms,
TchReqNumExcludeHoSms       ,
TchSuccNumExcludeHoSms      ,
TchReqNumIncludeHoSms       ,
TchSuccNumIncludeHoSms      ,
BtsSysHardHoReqNum          ,
BtsSysHardHoSuccNum         ,
SysSHoReqNum                ,
SysSHoSuccNum               ,
TCHRadioFNum                ,
CallPageReqTotalNum         ,
HardhoReqNum_intra          ,
HardhoSuccNum_intra         ,
HardhoSuccRate_intra        ,
ShoReqNum_intra             ,
ShoSuccNum_intra            ,
ShoSuccRate_intra           ,
HardhoReqNum_Extra          ,
HardhoSuccNum_Extra         ,
HardhoSuccRate_Extra        ,
ShoReqNum_Extra             ,
ShoSuccNum_Extra            ,
ShoSuccRate_Extra           ,
FdwTxTotalFrameExcludeRx    ,
RLPFwdChSizeExcludeRx       ,
RLPFwdChRxSize              ,
FwdChRxRate                 ,
RevTxTotalFrameExcludeRx    ,
RLPRevChSize                ,
RevChRxRate                 ,
BtsSysHardHoSuccRate        ,
SysSHoSuccRate              ,
TchRadioFRate               ,
CallInterruptRate           ,
SShoReqNum_intra            ,
SShoSuccNum_intra           ,
SShoSuccRate_intra          ,
ps_CallPageReqNum,
cs_LoseCallingratio,
carriernum_1x,
cs_SHOTraffic,
cs_TchReqNumHardho,
cs_TchSuccNumHardho,
cs_TchReqNumsoftho,
cs_TchSuccNumsoftho,
cs_CallPageSuccNum,
cs_CallPageReqNum,
TCHLoadTrafficIncludeHo,
TrafficExcludeHo,
cs_TrafficExcludeHo,
TCHLoadTrafficExcludeHo,
ps_TchReqNumHardho ,
ps_TchSuccNumHardho,
ps_TchReqNumsoftho ,
ps_TchSuccNumsoftho,
ps_LoseCallingNum,
ps_HandoffReqNum,
ps_HandoffSuccNum,
ps_HandoffSuccRate,
ps_HardhoReqNum,
ps_HardhoSuccNum,
ps_HardhoSuccRate,
ps_SofthoReqNum,
ps_SofthoSuccNum,
ps_SofthoSuccRate,
ps_SSofthoReqNum,
ps_SSofthoSuccNum,
ps_SSofthoSuccRate,
ps_CallPageSuccNum,
cs_trafficByWalsh,
ps_trafficByWalsh,
LoadTrafficByWalsh,
cs_SHORate,
ps_SHORate,
cs_TchReqNumExcludeHo,
cs_TchSuccNumExcludeHo,
cs_TchFNumExcludeHo,
cs_TchSuccExcludeHoRate,
cs_HandoffReqNum,
cs_HandoffSuccNum,
cs_HandoffSuccRate,
HandoffReqNum_Extra,
HandoffSuccNum_Extra,
HandoffSuccRate_Extra,
ps_SSHOTraffic,
ps_LoseCallingRate,
ps_TchReqNumIncludeHo,
ps_TchSuccNumIncludeHo,
ps_TchFNumIncludeHo,
ps_CallBlockFailNum,
ps_TchSuccIncludeHoRate,
ps_TchReqNumExcludeHo,
ps_TchSuccNumExcludeHo,
ps_TchFNumExcludeHo,
ps_TchSuccExcludeHoRate,
ps_LoseCallingratio,
TchReqNumIncludeHo,
TchReqNumExcludeHo,
TchSuccNumIncludeHo,
TchFNumIncludeHo,
TchSuccIncludeHoRate,
TchSuccNumExcludeHo,
TchFNumExcludeHo,
TchSuccExcludeHoRate,
HandoffReqNum,
HandoffSuccNum,
HandoffSuccRate,
HandoffReqNum_intra,
HandoffSuccNum_intra,
HandoffSuccRate_intra,
cs_CallBlockFailRate,
ChannelNum,
ChannelAvailNum,
ChannelMaxUseNum
)
with a as(
select
c.related_msc related_msc,
sum(nvl(a.c02,0))  c02,
sum(nvl(a.c05,0))  c05,
sum(nvl(a.escpd29,0)) escpd29,
sum(nvl(a.escpd32,0)) escpd32,
sum(nvl(a.escpd35,0)) escpd35,
sum(nvl(a.escpd44,0)) escpd44,
sum(nvl(a.escpd46,0)) escpd46,
sum(nvl(a.scpd017,0)) scpd017,
sum(nvl(a.scpd018,0)) scpd018,
sum(nvl(a.scpd036,0)) scpd036,
sum(nvl(a.scpd037,0)) scpd037,
sum(nvl(a.scpd040,0)) scpd040,
sum(nvl(a.scpd041,0)) scpd041,
sum(nvl(a.scpd042,0)) scpd042,
sum(nvl(a.scpd043,0)) scpd043,
sum(nvl(a.scpd044,0)) scpd044,
sum(nvl(a.scpd045,0)) scpd045,
sum(nvl(a.scpd046,0)) scpd046,
sum(nvl(a.scpd047,0)) scpd047,
sum(nvl(a.scpd054,0)) scpd054,
sum(nvl(a.scpd056,0)) scpd056,
sum(nvl(a.scpd057,0)) scpd057,
sum(nvl(a.scpd059,0)) scpd059,
sum(nvl(a.scpd104,0)) scpd104,
sum(nvl(a.scpd115,0)) scpd115,
sum(nvl(a.scpd119,0)) scpd119,
sum(nvl(a.scpd161,0)) scpd161,
sum(nvl(a.scpd162,0)) scpd162,
sum(nvl(a.scpd165,0)) scpd165,
sum(nvl(a.scpd166,0)) scpd166,
sum(nvl(a.scpd168,0)) scpd168,
sum(nvl(a.scpd195,0)) scpd195,
sum(nvl(a.scpd197,0)) scpd197,
sum(nvl(a.c006,0)) c006 ,
sum(nvl(a.c008,0)) c008 ,
sum(nvl(a.c011,0)) c011 ,
sum(nvl(a.c012,0)) c012 ,
sum(nvl(a.c062,0)) c062 ,
sum(nvl(a.c063,0)) c063 ,
sum(nvl(a.c085,0)) c085 ,
sum(nvl(a.c086,0)) c086 ,
sum(nvl(a.c152,0)) c152 ,
sum(nvl(a.c153,0)) c153 ,
sum(nvl(a.c264,0)) c264 ,
sum(nvl(a.c276,0)) c276,
sum(nvl(a.c277,0)) c277,
sum(nvl(a.c278,0)) c278,
sum(nvl(a.ec22,0)) ec22 ,
sum(nvl(a.ec23,0)) ec23 ,
sum(nvl(a.esc01,0)) esc01,
sum(nvl(a.esc02,0)) esc02,
sum(nvl(a.esc03,0)) esc03,
sum(nvl(a.esc04,0)) esc04,
sum(nvl(a.esc05,0)) esc05,
sum(nvl(a.esc06,0)) esc06,
sum(nvl(a.esc07,0)) esc07,
sum(nvl(a.esc08,0)) esc08,
sum(nvl(a.esc09,0)) esc09,
sum(nvl(a.esc12,0)) esc12,
sum(nvl(a.esc13,0)) esc13,
sum(nvl(a.esc14,0)) esc14,
sum(nvl(a.esc15,0)) esc15,
sum(nvl(a.esc16,0)) esc16,
sum(nvl(a.esc17,0)) esc17,
sum(nvl(a.esc18,0)) esc18,
sum(nvl(a.esc19,0)) esc19,
sum(nvl(a.esc20,0)) esc20,
sum(nvl(a.esc21,0)) esc21,
sum(nvl(a.esc22,0)) esc22,
sum(nvl(a.esc23,0)) esc23,
sum(nvl(a.esc28,0)) esc28,
sum(nvl(a.esc29,0)) esc29,
sum(nvl(a.esc30,0)) esc30,
sum(nvl(a.esc32,0)) esc32,
sum(nvl(a.esc34,0)) esc34,
sum(nvl(a.esc35,0)) esc35,
sum(nvl(a.esc43,0)) esc43,
sum(nvl(a.esc44,0)) esc44,
sum(nvl(a.esc45,0)) esc45,
sum(nvl(a.esc46,0)) esc46,
sum(nvl(a.L037,0)) L037 ,
sum(nvl(a.L038,0)) L038 ,
sum(nvl(a.L039,0)) L039 ,
sum(nvl(a.L040,0)) L040 ,
sum(nvl(a.L041,0)) L041 ,
sum(nvl(a.L042,0)) L042 ,
sum(nvl(a.L043,0)) L043 ,
sum(nvl(a.L044,0)) L044 ,
sum(nvl(a.L045,0)) L045 ,
sum(nvl(a.L046,0)) L046 ,
sum(nvl(a.L076,0)) L076 ,
sum(nvl(a.L077,0)) L077 ,
sum(nvl(a.L078,0)) L078 ,
sum(nvl(a.L079,0)) L079 ,
sum(nvl(a.L097,0)) L097 ,
sum(nvl(a.L098,0)) L098 ,
sum(nvl(a.L099,0)) L099 ,
sum(nvl(a.sc015,0)) sc015,
sum(nvl(a.sc016,0)) sc016,
sum(nvl(a.sc017,0)) sc017,
sum(nvl(a.sc018,0)) sc018,
sum(nvl(a.sc019,0)) sc019,
sum(nvl(a.sc020,0)) sc020,
sum(nvl(a.sc021,0)) sc021,
sum(nvl(a.sc022,0)) sc022,
sum(nvl(a.sc023,0)) sc023,
sum(nvl(a.sc024,0)) sc024,
sum(nvl(a.sc032,0)) sc032,
sum(nvl(a.sc033,0)) sc033,
sum(nvl(a.sc036,0)) sc036,
sum(nvl(a.sc037,0)) sc037,
sum(nvl(a.sc038,0)) sc038,
sum(nvl(a.sc039,0)) sc039,
sum(nvl(a.sc040,0)) sc040,
sum(nvl(a.sc041,0)) sc041,
sum(nvl(a.sc042,0)) sc042,
sum(nvl(a.sc043,0)) sc043,
sum(nvl(a.sc044,0)) sc044,
sum(nvl(a.sc045,0)) sc045,
sum(nvl(a.sc046,0)) sc046,
sum(nvl(a.sc047,0)) sc047,
sum(nvl(a.sc048,0)) sc048,
sum(nvl(a.sc050,0)) sc050,
sum(nvl(a.sc051,0)) sc051,
sum(nvl(a.sc053,0)) sc053,
sum(nvl(a.sc054,0)) sc054,
sum(nvl(a.sc056,0)) sc056,
sum(nvl(a.sc057,0)) sc057,
sum(nvl(a.sc059,0)) sc059,
sum(nvl(a.sc068,0)) sc068,
sum(nvl(a.sc069,0)) sc069,
sum(nvl(a.sc070,0)) sc070,
sum(nvl(a.sc071,0)) sc071,
sum(nvl(a.sc104,0)) sc104,
sum(nvl(a.sc105,0)) sc105,
sum(nvl(a.sc106,0)) sc106,
sum(nvl(a.sc107,0)) sc107,
sum(nvl(a.sc108,0)) sc108,
sum(nvl(a.sc109,0)) sc109,
sum(nvl(a.sc110,0)) sc110,
sum(nvl(a.sc111,0)) sc111,
sum(nvl(a.sc112,0)) sc112,
sum(nvl(a.sc113,0)) sc113,
sum(nvl(a.sc114,0)) sc114,
sum(nvl(a.sc115,0)) sc115,
sum(nvl(a.sc116,0)) sc116,
sum(nvl(a.sc117,0)) sc117,
sum(nvl(a.sc118,0)) sc118,
sum(nvl(a.sc119,0)) sc119,
sum(nvl(a.sc159,0)) sc159,
sum(nvl(a.sc160,0)) sc160,
sum(nvl(a.sc161,0)) sc161,
sum(nvl(a.sc162,0)) sc162,
sum(nvl(a.sc163,0)) sc163,
sum(nvl(a.sc164,0)) sc164,
sum(nvl(a.sc165,0)) sc165,
sum(nvl(a.sc166,0)) sc166,
sum(nvl(a.sc167,0)) sc167,
sum(nvl(a.sc168,0)) sc168,
sum(nvl(a.sc195,0)) sc195,
sum(nvl(a.sc197,0)) sc197,
sum(nvl(a.vo13,0)) vo13 ,
sum(nvl(a.vo16,0)) vo16 ,
sum(nvl(a.vo20,0)) vo20 ,
sum(nvl(a.vo30,0)) vo30 ,
sum(nvl(a.vo31,0)) vo31 ,
sum(nvl(a.vo32,0)) vo32 ,
sum(nvl(a.vo33,0)) vo33 ,
sum(nvl(a.vo34,0)) vo34 ,
sum(nvl(a.vo35,0)) vo35 ,
sum(nvl(a.vo36,0)) vo36 ,
sum(nvl(a.vo37,0)) vo37 ,
sum(nvl(a.vo38,0)) vo38 ,
sum(nvl(a.vo39,0)) vo39 ,
sum(nvl(a.vo40,0)) vo40,
sum(nvl(a.c02,0)+nvl(a.c05,0))/360  cs_trafficByWalsh,
sum(a.c04)*10/3600    ps_trafficByWalsh,
sum(nvl(a.c02,0)+nvl(a.c05,0))/360  LoadTrafficByWalsh,
sum(nvl(c04,0)) v1
from C_TPD_1X_SUM_LC_TEMP a,c_cell c
where  a.unique_rdn = c.unique_rdn and a.scan_start_time = v_date and a.vendor_id=10
group by c.related_msc),
b as(
select
c.related_msc  related_msc,
sum(nvl(a.c006,0))  c006,
sum(nvl(a.c276,0))  c276,
sum(nvl(a.c278,0))  c278,
count(distinct c.int_id) CARRIERNUM_1X,
sum(nvl(c008,0)+nvl(c277,0)+nvl(c279,0))/360 cs_SHOTraffic,
sum(nvl(vo34,0)+nvl(vo36,0)+nvl(vo33,0)+nvl(vo35,0)+nvl(sc110,0)+nvl(sc108,0)+nvl(sc107,0)+nvl(sc109,0)) cs_TchReqNumHardho,
sum(nvl(vo16,0)+nvl(vo20,0)+nvl(vo13,0)+nvl(vo37,0)+nvl(sc112,0)+nvl(sc114,0) +nvl(sc111,0)+nvl(sc113,0)) cs_TchSuccNumHardho,
sum(nvl(vo30,0)+nvl(vo31,0)+nvl(vo32,0)+nvl(sc104,0)+nvl(sc105,0)+nvl(sc106,0)) cs_TchReqNumsoftho,
sum(nvl(vo31,0)-nvl(vo39,0) +nvl(vo32,0)-nvl(vo40,0) + nvl(sc105,0)-nvl(sc116,0)+nvl(sc106,0)-nvl(sc117,0)) cs_TchSuccNumsoftho,
-----------------
sum(
(case when
(nvl(sc019,0)-nvl(esc03,0)-nvl(esc01,0)-nvl(esc05,0)+nvl(esc13,0)-nvl(sc015,0)-nvl(sc160,0))>0 then
(nvl(sc019,0)-nvl(esc03,0)-nvl(esc01,0)-nvl(esc05,0)+nvl(esc13,0)-nvl(sc015,0)-nvl(sc160,0)) else 0 end)
+
(case when
(nvl(sc020,0)-nvl(esc04,0)-nvl(esc02,0)-nvl(esc06,0)-nvl(esc12,0)-nvl(sc016,0)-nvl(esc07,0)-nvl(esc08,0)-nvl(esc09,0)-nvl(sc164,0))>0 then
(nvl(sc020,0)-nvl(esc04,0)-nvl(esc02,0)-nvl(esc06,0)-nvl(esc12,0)-nvl(sc016,0)-nvl(esc07,0)-nvl(esc08,0)-nvl(esc09,0)-nvl(sc164,0)) else 0 end)
+
(case when
(nvl(sc032,0)-nvl(esc14,0)-nvl(esc16,0)-nvl(esc18,0)-nvl(sc038,0)-nvl(sc162,0))>0 then
(nvl(sc032,0)-nvl(esc14,0)-nvl(esc16,0)-nvl(esc18,0)-nvl(sc038,0)-nvl(sc162,0))  else 0 end)
+
(case when
(nvl(sc033,0)-nvl(esc15,0)-nvl(esc17,0)-nvl(esc19,0)-nvl(esc20,0)-nvl(sc039,0)-nvl(esc21,0)-nvl(esc22,0)-nvl(esc23,0)-nvl(sc166,0))>0 then
(nvl(sc033,0)-nvl(esc15,0)-nvl(esc17,0)-nvl(esc19,0)-nvl(esc20,0)-nvl(sc039,0)-nvl(esc21,0)-nvl(esc22,0)-nvl(esc23,0)-nvl(sc166,0)) else 0 end )
) cs_CallPageSuccNum,
sum(
(case when
(nvl(sc023 ,0)-nvl(sc048 ,0)+nvl(sc050 ,0)+ nvl(sc042,0) +nvl(sc044 ,0)+nvl(sc046 ,0)-nvl(esc28 ,0)-nvl(sc118 ,0)-nvl(esc34 ,0)-nvl(esc43 ,0)-nvl(sc159 ,0)-nvl(sc160 ,0)-nvl(sc194 ,0)-nvl(sc196 ,0))>0 then
(nvl(sc023 ,0)-nvl(sc048 ,0)+nvl(sc050 ,0)+ nvl(sc042,0) +nvl(sc044 ,0)+nvl(sc046 ,0)-nvl(esc28 ,0)-nvl(sc118 ,0)-nvl(esc34 ,0)-nvl(esc43 ,0)-nvl(sc159 ,0)-nvl(sc160 ,0)-nvl(sc194 ,0)-nvl(sc196 ,0)) else 0 end)
+
(case when
(nvl(sc024 ,0)-nvl(sc051,0)+ nvl(sc053 ,0)+ nvl(sc043 ,0)+ nvl(sc045 ,0)+ nvl(sc047 ,0)- nvl(esc45 ,0)- nvl(sc163 ,0)- nvl(sc164 ,0)-nvl(sc167 ,0)-nvl(esc30 ,0))>0 then
(nvl(sc024 ,0)-nvl(sc051,0)+ nvl(sc053 ,0)+ nvl(sc043 ,0)+ nvl(sc045 ,0)+ nvl(sc047 ,0)- nvl(esc45 ,0)- nvl(sc163 ,0)- nvl(sc164 ,0)-nvl(sc167 ,0)-nvl(esc30 ,0)) else 0 end)
+
(case when
(nvl(sc037,0)-nvl(sc057,0)+nvl(sc059,0)-nvl(sc043,0)-nvl(sc045,0)-nvl(sc047,0)-nvl(esc46,0)-nvl(sc165,0)-nvl(sc166,0)-nvl(sc168,0)-nvl(esc32,0))>0 then
(nvl(sc037,0)-nvl(sc057,0)+nvl(sc059,0)-nvl(sc043,0)-nvl(sc045,0)-nvl(sc047,0)-nvl(esc46,0)-nvl(sc165,0)-nvl(sc166,0)-nvl(sc168,0)-nvl(esc32,0)) else 0 end)
+
(case when
(nvl(sc036,0)-nvl(sc054,0)+nvl(sc056,0)-nvl(sc042,0)- nvl(sc044,0)-nvl(sc046,0)-nvl(esc29,0)-nvl(sc119,0)-nvl(esc35,0)-nvl(esc44,0)-nvl(sc161,0)-nvl(sc162,0)-nvl(sc195,0)-nvl(sc197,0))>0 then
(nvl(sc036,0)-nvl(sc054,0)+nvl(sc056,0)-nvl(sc042,0)- nvl(sc044,0)-nvl(sc046,0)-nvl(esc29,0)-nvl(sc119,0)-nvl(esc35,0)-nvl(esc44,0)-nvl(sc161,0)-nvl(sc162,0)-nvl(sc195,0)-nvl(sc197,0)) else 0 end)
)  cs_CallPageReqNum,
round(sum(nvl(a.c006,0) + nvl(a.c011,0)+nvl(a.c012,0)+nvl(a.c276,0) + nvl(a.c278,0))/360,4) TCHLoadTrafficIncludeHo,
sum(nvl(a.c006,0)-nvl(a.c008,0)+nvl(a.c011,0)-nvl(a.c013,0)+nvl(a.c012,0)-nvl(a.c014,0) +nvl(a.c276,0)-nvl(a.c277,0)
+nvl(a.c278,0)-nvl(a.c279,0)+nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360 TrafficExcludeHo ,
sum(nvl(a.c006,0)-nvl(a.c008,0) +nvl(a.c011,0)-nvl(a.c013,0) +nvl(a.c012,0)
-nvl(a.c014,0) +nvl(a.c276,0)-nvl(a.c277,0) +nvl(a.c278,0)-nvl(a.c279,0))/360  cs_TrafficExcludeHo,
sum(nvl(a.c006,0)-nvl(a.c008,0)+nvl(a.c011,0)- nvl(a.c013,0) + nvl(a.c012,0)-nvl(a.c014,0)+nvl(a.c276,0)-nvl(a.c277,0)+nvl(a.c278,0)-nvl(a.c279,0))/360 TCHLoadTrafficExcludeHo,
sum(nvl(scpd107,0)+nvl(scpd108,0)+nvl(scpd109,0)+nvl(scpd110,0)) ps_TchReqNumHardho,
sum(nvl(scpd111,0)+nvl(scpd112,0)+nvl(scpd113,0)+nvl(scpd114,0)) ps_TchSuccNumHardho,
sum(nvl(scpd104,0)+nvl(scpd105,0)+nvl(scpd106,0)) ps_TchReqNumsoftho,
sum(nvl(scpd104,0)-nvl(scpd115,0)+nvl(scpd105,0)-nvl(scpd116,0)+nvl(scpd106,0)-nvl(scpd117,0)) ps_TchSuccNumsoftho,
sum(nvl(a.scpd017,0) + nvl(a.scpd018,0) + nvl(a.scpd040,0) + nvl(a.scpd041,0)) ps_LoseCallingNum ,
sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0) + nvl(a.scpd105,0) + nvl(a.scpd106,0) + nvl(a.scpd104,0)) ps_HandoffReqNum  ,
sum(nvl(a.scpd105,0) - nvl(a.scpd116,0) + nvl(a.scpd106,0) - nvl(a.scpd117,0) + nvl(a.scpd104,0) - nvl(a.scpd115,0) + nvl(a.scpd111,0) + nvl(a.scpd112,0) + nvl(a.scpd113,0) + nvl(a.scpd114,0)) ps_HandoffSuccNum ,
round(sum(nvl(a.scpd105,0) - nvl(a.scpd116,0) + nvl(a.scpd106,0) - nvl(a.scpd117,0) + nvl(a.scpd104,0) - nvl(a.scpd115,0) + nvl(a.scpd111,0) + nvl(a.scpd112,0) + nvl(a.scpd113,0) + nvl(a.scpd114,0))/
decode(sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0) + nvl(a.scpd105,0) + nvl(a.scpd106,0) + nvl(a.scpd104,0)),0,1,null,1,sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0) + nvl(a.scpd105,0) + nvl(a.scpd106,0) + nvl(a.scpd104,0)))*100,4) ps_HandoffSuccRate,
sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0)) ps_HardhoReqNum   ,
sum(nvl(a.scpd111,0) + nvl(a.scpd112,0) + nvl(a.scpd113,0) + nvl(a.scpd114,0)) ps_HardhoSuccNum  ,
round(sum(nvl(a.scpd111,0) + nvl(a.scpd112,0) + nvl(a.scpd113,0) + nvl(a.scpd114,0))/decode(sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0)),0,1,null,1,sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0)))*100,4) ps_HardhoSuccRate ,
sum(nvl(a.scpd105,0) + nvl(a.scpd106,0)) ps_SofthoReqNum   ,
sum(nvl(a.scpd105,0) - nvl(a.scpd116,0) + nvl(a.scpd106,0) - nvl(a.scpd117,0)) ps_SofthoSuccNum  ,
round(sum(nvl(a.scpd105,0) - nvl(a.scpd116,0) + nvl(a.scpd106,0) - nvl(a.scpd117,0))/decode(sum(nvl(a.scpd105,0) + nvl(a.scpd106,0)),0,1,null,1,sum(nvl(a.scpd105,0) + nvl(a.scpd106,0)))*100,4) ps_SofthoSuccRate ,
sum(nvl(a.scpd104,0)) ps_SSofthoReqNum  ,
sum(nvl(a.scpd104,0)- nvl(a.scpd115,0)) ps_SSofthoSuccNum ,
round(sum(nvl(a.scpd104,0)- nvl(a.scpd115,0))/decode(sum(a.scpd104),0,1,null,1,sum(a.scpd104))*100,4)   ps_SSofthoSuccRate,
sum(
case when(nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)) > 0
then nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0) else 0 end)
+
sum(
case when(nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) > 0
then nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0) else 0 end) ps_CallPageSuccNum,
sum(nvl(a.c008,0)
+nvl(a.c277,0)
+nvl(a.c279,0)) cs_SHORate_up,
sum(nvl(a.c006,0)
-nvl(a.c008,0)
+nvl(a.c011,0)
-nvl(a.c013,0)
+nvl(a.c012,0)
-nvl(a.c014,0)
+nvl(a.c276,0)
-nvl(a.c277,0)
+nvl(a.c278,0)
-nvl(a.c279,0)
+nvl(a.c008,0)
+nvl(a.c277,0)
+nvl(a.c279,0)) cs_SHORate_down,
sum(nvl(a.c085,0)-nvl(a.c276,0) - nvl(a.c085,0)+nvl(a.c086,0) + nvl(a.c276,0)-nvl(a.c277,0)) ps_SHORate_up,
sum(nvl(a.c085,0)-nvl(a.c276,0)) ps_SHORate_down,
sum(nvl(a.sc017,0)+nvl(a.sc018,0)
+nvl(a.sc040,0)+nvl(a.sc041,0)) cs_LoseCallingRate_up,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) cs_LoseCallingRate_down,
60*sum(nvl(a.c006,0)
-nvl(a.c008,0)
+nvl(a.c011,0)
-nvl(a.c013,0)
+nvl(a.c012,0)
-nvl(a.c014,0)
+nvl(a.c276,0)
-nvl(a.c277,0)
+nvl(a.c278,0)
-nvl(a.c279,0))/360 cs_LoseCallingratio_up,
sum(nvl(a.sc017,0)
+nvl(a.sc018,0)
+nvl(a.sc040,0)
+nvl(a.sc041,0)) cs_LoseCallingratio_down,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) cs_TchReqNumExcludeHo,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) cs_TchSuccNumExcludeHo,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) cs_TchFNumExcludeHo_a1,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) cs_TchFNumExcludeHo_a2,
sum(nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)
+nvl(a.vo30 ,0)
+nvl(a.sc104,0)) cs_HandoffReqNum,
sum(nvl(a.vo16,0)
+nvl(a.vo20 ,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)
+nvl(a.vo30 ,0)
-nvl(a.vo38 ,0)
+nvl(a.sc104,0)
-nvl(a.sc115,0)) cs_HandoffSuccNum,
sum(nvl(a.vo34,0)
+nvl(a.vo36 ,0)
+nvl(a.sc108,0)
+nvl(a.sc110,0)
+nvl(a.vo32 ,0)
+nvl(a.sc106,0)) HandoffReqNum_Extra,
sum(nvl(a.vo16,0)
+nvl(a.vo20 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)) HandoffSuccNum_Extra,
sum(nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360 v2,
sum(nvl(a.scpd017,0)
+nvl(a.scpd018,0)
+nvl(a.scpd040,0)
+nvl(a.scpd041,0)) ps_LoseCallingRate_up,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) ps_LoseCallingRate_down,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) ps_TchReqNumIncludeHo,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) ps_TchSuccNumIncludeHo,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) ps_TchFNumIncludeHo_b1,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) ps_TchFNumIncludeHo_b2,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)) ps_TchReqNumExcludeHo,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) ps_TchSuccNumExcludeHo,
60*sum(nvl(a.c006,0)
-nvl(a.c008,0)
+nvl(a.c011,0)
-nvl(a.c013,0)
+nvl(a.c012,0)
-nvl(a.c014,0)
+nvl(a.c276,0)
-nvl(a.c277,0)
+nvl(a.c278,0)
-nvl(a.c279,0)
+nvl(a.c085,0)
-nvl(a.c086,0)
-nvl(a.c276,0)
+nvl(a.c277,0))/360 LoseCallingratio_up,
sum(nvl(a.sc017,0)
+nvl(a.sc018,0)
+nvl(a.sc040,0)
+nvl(a.sc041,0)) LoseCallingratio_down_a,
60*sum(nvl(a.c085,0)
-nvl(a.c086,0)
-nvl(a.c276,0)
+nvl(a.c277,0))/360 ps_LoseCallingratio_up,
sum(nvl(a.sc019,0)
+nvl(a.sc020,0)
+nvl(a.sc032,0)
+nvl(a.sc033,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)
+nvl(a.c062 ,0)
+nvl(a.c063 ,0)
+nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)) TchReqNumIncludeHo_a,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) TchReqNumExcludeHo_a,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)
+nvl(a.c152 ,0)
+nvl(a.c153 ,0)
+nvl(a.vo16 ,0)
+nvl(a.vo20 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)) TchSuccNumIncludeHo_a,
sum(nvl(a.sc019,0)
+nvl(a.sc020,0)
+nvl(a.sc032,0)
+nvl(a.sc033,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)
+nvl(a.c062 ,0)
+nvl(a.c063 ,0)
+nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)) TchFNumIncludeHo_a1,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)
+nvl(a.c152 ,0)
+nvl(a.c153 ,0)
+nvl(a.vo16 ,0)
+nvl(a.vo20 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)) TchFNumIncludeHo_a2,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)
+nvl(a.c152 ,0)
+nvl(a.c153 ,0)
+nvl(a.vo16 ,0)
+nvl(a.vo20 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)) TchSuccIncludeHoRate_up_a,
sum(nvl(a.sc019,0)
+nvl(a.sc020,0)
+nvl(a.sc032,0)
+nvl(a.sc033,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)
+nvl(a.c062 ,0)
+nvl(a.c063 ,0)
+nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)) TchSuccIncludeHoRate_down_a,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) TchSuccNumExcludeHo_a,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) TchFNumExcludeHo_a1,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) TchFNumExcludeHo_a2,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) TchSuccExcludeHoRate_up_a,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) TchSuccExcludeHoRate_down_a,
sum(nvl(a.vo34,0)
+nvl(a.vo36 ,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)
+nvl(a.vo30 ,0)
+nvl(a.sc104,0)) HandoffReqNum_a,
sum(nvl(a.vo16 ,0)
+nvl(a.vo20 ,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)
+nvl(a.vo30 ,0)
-nvl(a.vo38 ,0)
+nvl(a.sc104,0)
-nvl(a.sc115,0)) HandoffSuccNum_a,
sum(nvl(a.vo33,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.sc105,0)
+nvl(a.vo30 ,0)
+nvl(a.sc104,0))  HandoffReqNum_intra_a,
sum(nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.vo30 ,0)
+nvl(a.sc104,0)) HandoffSuccNum_intra_a,
sum(nvl(a.scpd017,0)
+nvl(a.scpd018,0)
+nvl(a.scpd040,0)
+nvl(a.scpd041,0)) LoseCallingratio_down_b,
sum(nvl(a.scpd017,0)
+nvl(a.scpd018,0)
+nvl(a.scpd040,0)
+nvl(a.scpd041,0)) ps_LoseCallingratio_down,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) TchReqNumIncludeHo_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)) TchReqNumExcludeHo_b,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) TchSuccNumIncludeHo_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) TchFNumIncludeHo_b1,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) TchFNumIncludeHo_b2,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) TchSuccIncludeHoRate_up_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) TchSuccIncludeHoRate_down_b,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) TchSuccNumExcludeHo_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)) TchFNumExcludeHo_b1,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) TchFNumExcludeHo_b2,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) TchSuccExcludeHoRate_up_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)) TchSuccExcludeHoRate_down_b,
sum(nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)
+nvl(a.scpd104,0)) HandoffReqNum_b,
sum(nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)) HandoffSuccNum_b,
sum(nvl(a.scpd104,0)) HandoffReqNum_intra_b,
sum(nvl(a.scpd104,0)) HandoffSuccNum_intra_b,
sum(nvl(a.esc24,0)
+nvl(a.esc25,0)
+nvl(a.esc26,0)
+nvl(a.esc27,0)
+nvl(a.ec01 ,0)
+nvl(a.ec02 ,0)
+nvl(a.c029 ,0)
+nvl(a.c031 ,0)
+nvl(a.c033 ,0)
+nvl(a.c034 ,0)
+nvl(a.c035 ,0)
+nvl(a.c036 ,0))  cs_CallBlockFailRate_up_a,
sum(nvl(a.sc019,0)
+nvl(a.sc020,0)
+nvl(a.sc032,0)
+nvl(a.sc033,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)
+nvl(a.c062 ,0)
+nvl(a.c063 ,0)
+nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)) cs_CallBlockFailRate_down
from C_TPD_1X_SUM_LC_TEMP a,c_carrier c
where  a.int_id = c.int_id
and a.scan_start_time = v_date and a.vendor_id=10
group by c.related_msc
),
c as(
select
c_bts.related_msc,
sum(nvl(a.cs007,0)
+nvl(a.cs008,0)
+nvl(a.a70  ,0)) cs_CallBlockFailRate_up_b,
round(sum(l1)) ChannelNum,
round(sum(l1)/360) ChannelAvailNum,
sum(cs004) ChannelMaxUseNum
from C_TPD_1X_SUM_LC_TEMP a,c_bts
where a.int_id = c_bts.int_id and a.scan_start_time = v_date
group by c_bts.related_msc
)
select
a.related_msc,
v_date,
0,
101,
10,
(nvl(a.c02,0)+nvl(a.c05,0))/360-(nvl(b.c006,0)+nvl(b.c276,0)+nvl(b.c278,0))/360  cs_SSHOTraffic,
round((nvl(a.c006,0) +nvl(a.c011,0)+nvl(a.c012,0)+ nvl(a.c276,0) + nvl(a.c278,0))/360,4) cs_TrafficIncludeHo,
round((nvl(a.c085,0)-nvl(a.c276,0))/360,4) ps_CallTrafficIncludeHo,
round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4)  ps_CallTrafficExcludeHo,
round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4)+round(nvl(a.scpd017,0)+nvl(a.scpd018,0)+nvl(a.scpd040,0)+nvl(a.scpd041,0),4) LoseCallingNum,
round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4) cs_LoseCallingNum,
round(nvl(a.sc019,0)+nvl(a.sc020,0)+nvl(a.sc032,0)+nvl(a.sc033,0)-nvl(a.sc160,0)-nvl(a.sc162,0)-nvl(a.sc164,0)-nvl(a.sc166,0)+nvl(a.c062,0)+nvl(a.c063,0)+nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc105,0)+nvl(a.sc106,0),4) cs_TchReqNumIncludeHo,
round(nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0)+nvl(a.c152,0)+nvl(a.c153,0)+nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0)+nvl(a.vo31,0)-nvl(a.vo39,0)+nvl(a.vo32,0)-nvl(a.vo40,0)+nvl(a.sc105,0)-nvl(a.sc116,0)+nvl(a.sc106,0)-nvl(a.sc117,0),4) cs_TchSuccNumIncludeHo,
round(100*(nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0)+nvl(a.c152,0)+nvl(a.c153,0)+nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0)+nvl(a.vo31,0)-nvl(a.vo39,0)+nvl(a.vo32,0)-nvl(a.vo40,0)+nvl(a.sc105,0)-nvl(a.sc116,0)+nvl(a.sc106,0)-nvl(a.sc117,0))/
decode(nvl(a.sc019,0)+nvl(a.sc020,0)+nvl(a.sc032,0)+nvl(a.sc033,0)-nvl(a.sc160,0)-nvl(a.sc162,0)-nvl(a.sc164,0)-nvl(a.sc166,0)+nvl(a.c062,0)+nvl(a.c063,0)+nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc105,0)+nvl(a.sc106,0),0,1,null,1,nvl(a.sc019,0)+nvl(a.sc020,0)+nvl(a.sc032,0)+nvl(a.sc033,0)-nvl(a.sc160,0)-nvl(a.sc162,0)-nvl(a.sc164,0)-nvl(a.sc166,0)+nvl(a.c062,0)+nvl(a.c063,0)+nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc105,0)+nvl(a.sc106,0)),4)      cs_TchSuccIncludeHoRate,
round(nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.sc107,0)+nvl(a.sc109,0),4) cs_HardhoReqNum,
round(nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.sc111,0)+nvl(a.sc113,0),4) cs_HardhoSuccNum,
case when  nvl(a.vo34,0) + nvl(a.vo36,0) +nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc110,0) + nvl(a.sc108,0) + nvl(a.sc107,0) + nvl(a.sc109,0) is  null then 100
     when  nvl(a.vo34,0) + nvl(a.vo36,0) +nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc110,0) + nvl(a.sc108,0) + nvl(a.sc107,0) + nvl(a.sc109,0) =  0     then  100
else round(100*(nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.sc111,0)+nvl(a.sc113,0))/decode(
  nvl(a.vo34,0) + nvl(a.vo36,0) +nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc110,0) + nvl(a.sc108,0) + nvl(a.sc107,0) + nvl(a.sc109,0),0,1,nvl(a.vo34,0) + nvl(a.vo36,0) +nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc110,0) + nvl(a.sc108,0) + nvl(a.sc107,0) + nvl(a.sc109,0)),4)
end cs_HardhoSuccRate,
round(nvl(a.vo31,0) + nvl(a.vo32,0) + nvl(a.sc105,0) + nvl(a.sc106,0),4)  cs_SofthoReqNum ,
round(nvl(a.vo31,0) - nvl(a.vo39,0) + nvl(a.vo32 ,0) - nvl(a.vo40 ,0)+ nvl(a.sc105,0)- nvl(a.sc116,0) + nvl(a.sc106,0) - nvl(a.sc117,0),4)  cs_SofthoSuccNum ,
round(100*(nvl(a.vo31,0) - nvl(a.vo39,0) + nvl(a.vo32 ,0) - nvl(a.vo40 ,0)+ nvl(a.sc105,0)- nvl(a.sc116,0) + nvl(a.sc106,0) - nvl(a.sc117,0))/
decode(nvl(a.vo31,0) + nvl(a.vo32,0) + nvl(a.sc105,0) + nvl(a.sc106,0),0,1,null,1,nvl(a.vo31,0) + nvl(a.vo32,0) + nvl(a.sc105,0) + nvl(a.sc106,0)),4) cs_SofthoSuccRate,
round(nvl(a.vo30,0) + nvl(a.sc104,0),4) cs_SSofthoReqNum,
round(nvl(a.vo30,0) - nvl(a.vo38,0) + nvl(a.sc104,0) - nvl(a.sc115,0),4) cs_SSofthoSuccNum,
round(100*(nvl(a.vo30,0) - nvl(a.vo38,0) + nvl(a.sc104,0) - nvl(a.sc115,0))/decode(nvl(a.vo30,0) + nvl(a.sc104,0),0,1,null,1,nvl(a.vo30,0) + nvl(a.sc104,0)),4) cs_SSofthoSuccRate,
round(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0),4) TchReqNumCallerExcludeHoSms  ,
round(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0),4) TchSuccNumCallerExcludeHoSms ,
round(nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0),4) TchReqNumCalleeExcludeHoSms  ,
round(nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0),4) TchSuccNumCalleeExcludeHoSms ,
round(nvl(a.sc019,0) + nvl(a.sc020,0) +nvl(a.sc032,0)+ nvl(a.sc033,0) + nvl(a.c062,0) + nvl(a.c063,0) - nvl(a.sc160,0) - nvl(a.sc162,0) - nvl(a.sc164,0)- nvl(a.sc166,0),4) TchReqNumExcludeHoSms,
round(nvl(a.sc019,0) - nvl(a.esc03,0) -nvl(a.esc01,0)- nvl(a.esc05,0) + nvl(a.esc13,0) - nvl(a.sc015,0) - nvl(a.sc160,0) + nvl(a.sc032,0) - nvl(a.esc14,0) - nvl(a.esc16,0)- nvl(a.esc18,0) - nvl(a.sc038,0) - nvl(a.sc162,0) + nvl(a.sc020,0) - nvl(a.esc04,0) - nvl(a.esc02,0) - nvl(a.esc06,0) - nvl(a.esc12,0) - nvl(a.sc016,0) - nvl(a.esc07,0) - nvl(a.esc08,0) - nvl(a.esc09,0) - nvl(a.sc164,0) + nvl(a.sc033,0) - nvl(a.esc15,0) - nvl(a.esc17,0) - nvl(a.esc19,0) - nvl(a.esc20,0) - nvl(a.sc039,0) - nvl(a.esc21,0) - nvl(a.esc22,0) - nvl(a.esc23,0) - nvl(a.sc166,0) + nvl(a.c152,0) + nvl(a.c153,0),4) TchSuccNumExcludeHoSms       ,
round(nvl(a.sc019,0)+nvl(a.sc020,0)+nvl(a.sc032,0)+nvl(a.sc033,0)-nvl(a.sc160,0)-nvl(a.sc162,0)-nvl(a.sc164,0)-nvl(a.sc166,0)+nvl(a.c062,0)+nvl(a.c063,0)+nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc105,0)+nvl(a.sc106,0),4) TchReqNumIncludeHoSms        ,
round(nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0)+nvl(a.c152,0)+nvl(a.c153,0)+nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0)+nvl(a.vo31,0)-nvl(a.vo39,0)+nvl(a.vo32,0)-nvl(a.vo40,0)+nvl(a.sc105,0)-nvl(a.sc116,0)+nvl(a.sc106,0)-nvl(a.sc117,0),4) TchSuccNumIncludeHoSms,
round(nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0),4) BtsSysHardHoReqNum           ,
round(nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0),4) BtsSysHardHoSuccNum          ,
round(nvl(a.vo30,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc104,0)+nvl(a.sc105,0)+nvl(a.sc106,0),4) SysSHoReqNum                 ,
round(nvl(a.vo30,0)-nvl(a.vo38,0)+nvl(a.vo31,0)-nvl(a.vo39,0)+nvl(a.vo32,0)-nvl(a.vo40,0)+nvl(a.sc104,0)-nvl(a.sc115,0)+nvl(a.sc105,0)-nvl(a.sc116,0)+nvl(a.sc106,0)-nvl(a.sc117,0),4) SysSHoSuccNum,
round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4) TCHRadioFNum                 ,
round((nvl(a.sc023,0)- nvl(a.sc048,0) + nvl(a.sc050,0) - nvl(a.esc28,0) - nvl(a.sc118,0) - nvl(a.esc34,0) - nvl(a.esc43,0) - nvl(a.sc159,0) - nvl(a.sc160,0)) + nvl(a.sc024,0)- nvl(a.sc051,0) + nvl(a.sc053,0) - nvl(a.esc45,0) - nvl(a.sc163,0) - nvl(a.sc164,0) - nvl(a.sc167,0) - nvl(a.esc30,0) + nvl(a.sc036,0) - nvl(a.sc054,0) + nvl(a.sc056,0) -nvl(a.esc29,0) - nvl(a.sc119,0) - nvl(a.esc35,0) - nvl(a.esc44,0) - nvl(a.sc161,0) - nvl(a.sc162,0)- nvl(a.sc195,0) - nvl(a.sc197,0) + nvl(a.sc037,0) - nvl(a.sc057,0) +nvl(a.sc059,0) -nvl(a.esc46,0)-nvl(a.sc165,0)-nvl(a.sc166,0)-nvl(a.sc168,0)-nvl(a.esc32,0)+nvl(a.c062,0)+nvl(a.c063,0),4) CallPageReqTotalNum          ,
round(nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc107,0) + nvl(a.sc109,0),4) HardhoReqNum_intra           ,
round(nvl(a.vo13,0) + nvl(a.vo37,0) + nvl(a.sc111,0) + nvl(a.sc113,0),4) HardhoSuccNum_intra          ,
round(100*(nvl(a.vo13,0) + nvl(a.vo37,0) + nvl(a.sc111,0) + nvl(a.sc113,0))/
decode(nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc107,0) + nvl(a.sc109,0),0,1,null,1,nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc107,0) + nvl(a.sc109,0)),4) HardhoSuccRate_intra,
round(nvl(a.vo31,0) + nvl(a.sc105,0),4) ShoReqNum_intra,
round(nvl(a.vo31,0) - nvl(a.vo39,0) + nvl(a.sc105,0) - nvl(a.sc116,0),4) ShoSuccNum_intra,
round(100*(nvl(a.vo31,0) - nvl(a.vo39,0) + nvl(a.sc105,0) - nvl(a.sc116,0))/
decode(nvl(a.vo31,0) + nvl(a.sc105,0),0,1,null,1,nvl(a.vo31,0) + nvl(a.sc105,0)),4) ShoSuccRate_intra,
round(nvl(a.vo34,0) + nvl(a.vo36,0) + nvl(a.sc108,0) + nvl(a.sc110,0),4) HardhoReqNum_Extra,
round(nvl(a.vo16,0) + nvl(a.vo20,0) + nvl(a.sc112,0) + nvl(a.sc114,0),4) HardhoSuccNum_Extra,
round(100*(nvl(a.vo16,0) + nvl(a.vo20,0) + nvl(a.sc112,0) + nvl(a.sc114,0))/
decode(nvl(a.vo34,0) + nvl(a.vo36,0) + nvl(a.sc108,0) + nvl(a.sc110,0),0,1,null,1,nvl(a.vo34,0) + nvl(a.vo36,0) + nvl(a.sc108,0) + nvl(a.sc110,0)),4) HardhoSuccRate_Extra,
round(nvl(a.vo32,0) + nvl(a.sc106,0),4) ShoReqNum_Extra,
round(nvl(a.vo32,0) - nvl(a.vo40,0) + nvl(a.sc106,0) - nvl(a.sc117,0),4) ShoSuccNum_Extra,
round(100*(nvl(a.vo32,0) - nvl(a.vo40,0) + nvl(a.sc106,0) - nvl(a.sc117,0))/
decode(nvl(a.vo32,0) + nvl(a.sc106,0),0,1,null,1,nvl(a.vo32,0) + nvl(a.sc106,0)),4) ShoSuccRate_Extra,
round(nvl(a.L037,0)+nvl(a.L038,0) + nvl(a.L039,0) + nvl(a.L040,0)+ nvl(a.L041,0),4) FdwTxTotalFrameExcludeRx,
round(a.L097/1024,4) RLPFwdChSizeExcludeRx,
round(a.L099,4) RLPFwdChRxSize,
round(100*nvl(a.L099,0)/decode(nvl(a.L097,0),0,1,null,1,nvl(a.L097,0)),4) FwdChRxRate,
round(nvl(a.L042,0)+ nvl(a.L043,0) + nvl(a.L044,0) + nvl(a.L045,0) +nvl(a.L046,0),4) RevTxTotalFrameExcludeRx,
round(a.L098/1024,4) RLPRevChSize,
round(100*nvl(a.L098,0)/1024/decode(nvl(a.L042,0)+ nvl(a.L043,0) + nvl(a.L044,0) + nvl(a.L045,0) +nvl(a.L046,0),0,1,null,1,nvl(a.L042,0)+ nvl(a.L043,0) + nvl(a.L044,0) + nvl(a.L045,0) +nvl(a.L046,0)),4) RevChRxRate,
round(100*(nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0))/decode(nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0),0,1,null,1,nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)),4) BtsSysHardHoSuccRate,
round(100*(nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0))/decode(nvl(a.vo30,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc104,0)+nvl(a.sc105,0)+nvl(a.sc106,0),0,1,null,1,nvl(a.vo30,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc104,0)+nvl(a.sc105,0)+nvl(a.sc106,0)),4) SysSHoSuccRate,
round(100*(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0))/
decode(nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)
-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)
-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)
-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)
-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)
-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0),0,1,null,1,
nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)
-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)
-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)
-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)
-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)
-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0)),4) TchRadioFRate,
round(100*(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0))/
decode((case when(a.sc019 - a.esc03 - a.esc01 - a.esc05 + a.esc13 - a.sc015 - a.sc160) > 0
then (a.sc019 - a.esc03 - a.esc01 - a.esc05 + a.esc13 - a.sc015 - a.sc160) else 0 end)
+
(case when(a.sc020-a.esc04-a.esc02-a.esc06-a.esc12-a.sc016-a.esc07-a.esc08-a.esc09 - a.sc164) > 0
then (a.sc020-a.esc04-a.esc02-a.esc06-a.esc12-a.sc016-a.esc07-a.esc08-a.esc09 - a.sc164) else 0 end)
+
(case when(a.sc032 - a.esc14 - a.esc16- a.esc18 - a.sc038 - a.sc162) > 0
then (a.sc032 - a.esc14 - a.esc16- a.esc18 - a.sc038 - a.sc162) else 0 end)
+
(case when(a.sc033-a.esc15-a.esc17-a.esc19-a.esc20-a.sc039-a.esc21-a.esc22-a.esc23 - a.sc166) > 0
then (a.sc033-a.esc15-a.esc17-a.esc19-a.esc20-a.sc039-a.esc21-a.esc22-a.esc23 - a.sc166) else 0 end
),0,1,null,1,(case when(a.sc019 - a.esc03 - a.esc01 - a.esc05 + a.esc13 - a.sc015 - a.sc160) > 0
then (a.sc019 - a.esc03 - a.esc01 - a.esc05 + a.esc13 - a.sc015 - a.sc160) else 0 end)
+
(case when(a.sc020-a.esc04-a.esc02-a.esc06-a.esc12-a.sc016-a.esc07-a.esc08-a.esc09 - a.sc164) > 0
then (a.sc020-a.esc04-a.esc02-a.esc06-a.esc12-a.sc016-a.esc07-a.esc08-a.esc09 - a.sc164) else 0 end)
+
(case when(a.sc032 - a.esc14 - a.esc16- a.esc18 - a.sc038 - a.sc162) > 0
then (a.sc032 - a.esc14 - a.esc16- a.esc18 - a.sc038 - a.sc162) else 0 end)
+
(case when(a.sc033-a.esc15-a.esc17-a.esc19-a.esc20-a.sc039-a.esc21-a.esc22-a.esc23 - a.sc166) > 0
then (a.sc033-a.esc15-a.esc17-a.esc19-a.esc20-a.sc039-a.esc21-a.esc22-a.esc23 - a.sc166) else 0 end)
),4) CallInterruptRate,
round(nvl(a.vo30,0) + nvl(a.sc104,0),4)+round(nvl(a.scpd104,0),4) SShoReqNum_intra,
round(nvl(a.vo30,0) + nvl(a.sc104,0)-nvl(a.vo38,0)-nvl(a.sc115,0),4)+round(nvl(a.scpd104,0)-nvl(a.scpd115,0),4) SShoSuccNum_intra,
round(100*(a.vo30 -a.vo38+ a.sc104-a.sc115+a.scpd104-a.scpd115)/
decode(a.vo30 + a.sc104 + a.scpd104,0,1,null,1,a.vo30 + a.sc104 + a.scpd104),4) SShoSuccRate_intra,
round(
(case when(nvl(a.scpd036,0)
-nvl(a.scpd054,0)
+nvl(a.scpd056,0)
-nvl(a.scpd042,0)
-nvl(a.scpd044,0)
-nvl(a.scpd046,0)
-nvl(a.escpd29,0)
-nvl(a.escpd35,0)
-nvl(a.escpd44,0)
-nvl(a.scpd161,0)
-nvl(a.scpd162,0)
-nvl(a.scpd119,0)
-nvl(a.scpd195,0)
-nvl(a.scpd197,0)
-nvl(a.c264,0)
-nvl(a.ec22,0)) > 0
then( nvl(a.scpd036,0)
-nvl(a.scpd054,0)
+nvl(a.scpd056,0)
-nvl(a.scpd042,0)
-nvl(a.scpd044,0)
-nvl(a.scpd046,0)
-nvl(a.escpd29,0)
-nvl(a.escpd35,0)
-nvl(a.escpd44,0)
-nvl(a.scpd161,0)
-nvl(a.scpd162,0)
-nvl(a.scpd119,0)
-nvl(a.scpd195,0)
-nvl(a.scpd197,0)
-nvl(a.c264,0)
-nvl(a.ec22,0)) else 0 end)
+
(case when(nvl(a.scpd037,0)
-nvl(a.scpd043,0)
-nvl(a.scpd045,0)
-nvl(a.scpd047,0)
-nvl(a.scpd057,0)
+nvl(a.scpd059,0)
-nvl(a.escpd46,0)
-nvl(a.scpd165,0)
-nvl(a.scpd166,0)
-nvl(a.scpd168,0)
-nvl(a.escpd32,0)
-nvl(a.ec23,0)) > 0
then( nvl(a.scpd037,0)
-nvl(a.scpd043,0)
-nvl(a.scpd045,0)
-nvl(a.scpd047,0)
-nvl(a.scpd057,0)
+nvl(a.scpd059,0)
-nvl(a.escpd46,0)
-nvl(a.scpd165,0)
-nvl(a.scpd166,0)
-nvl(a.scpd168,0)
-nvl(a.escpd32,0)
-nvl(a.ec23,0)) else 0 end),4)  ps_CallPageReqNum,
case when (round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4)) is null then 1000
     when (round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4))=0 then 1000 else round(cs_TrafficExcludeHo*60/decode((round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4)),0,1,(round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4))),4) end cs_LoseCallingratio,

b.carriernum_1x,
b.cs_SHOTraffic,
b.cs_TchReqNumHardho,
b.cs_TchSuccNumHardho,
b.cs_TchReqNumsoftho,
b.cs_TchSuccNumsoftho,
b.cs_CallPageSuccNum,
b.cs_CallPageReqNum,
b.TCHLoadTrafficIncludeHo,
b.TrafficExcludeHo,
b.cs_TrafficExcludeHo,
b.TCHLoadTrafficExcludeHo,
b.ps_TchReqNumHardho ,
b.ps_TchSuccNumHardho,
b.ps_TchReqNumsoftho ,
b.ps_TchSuccNumsoftho,
b.ps_LoseCallingNum,
b.ps_HandoffReqNum,
b.ps_HandoffSuccNum,
b.ps_HandoffSuccRate,
b.ps_HardhoReqNum,
b.ps_HardhoSuccNum,
b.ps_HardhoSuccRate,
b.ps_SofthoReqNum,
b.ps_SofthoSuccNum,
b.ps_SofthoSuccRate,
b.ps_SSofthoReqNum,
b.ps_SSofthoSuccNum,
b.ps_SSofthoSuccRate,
b.ps_CallPageSuccNum,
a.cs_trafficByWalsh,
a.ps_trafficByWalsh,
a.LoadTrafficByWalsh,
--count(case when BadCellNum_1 > 2.5 and BadCellNum_2 >= 3 and BadCellNum_3 > 0.025 then a.int_i end) BadCellNum,
--b.BadCellNum,
round(100*b.cs_SHORate_up/decode(b.cs_SHORate_down,0,1,null,1,b.cs_SHORate_down),4) cs_SHORate,
round(100*b.ps_SHORate_up/decode(b.ps_SHORate_down,0,1,null,1,b.ps_SHORate_down),4) ps_SHORate,
--round(100*(nvl(round((nvl(a.c085,0)-nvl(a.c276,0))/360,4),0)-nvl(round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0))/decode(nvl(round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0)+nvl(round((nvl(a.c085,0)-nvl(a.c276,0))/360,4)-round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0),0,1,nvl(round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0)+nvl(round((nvl(a.c085,0)-nvl(a.c276,0))/360,4)-round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0)),4) ps_SHORate,
b.cs_TchReqNumExcludeHo cs_TchReqNumExcludeHo,
b.cs_TchSuccNumExcludeHo cs_TchSuccNumExcludeHo,
b.cs_TchFNumExcludeHo_a1- b.cs_TchFNumExcludeHo_a2 cs_TchFNumExcludeHo,
round(100*b.cs_TchFNumExcludeHo_a2/decode(b.cs_TchFNumExcludeHo_a1,0,1,null,1,b.cs_TchFNumExcludeHo_a1),4) cs_TchSuccExcludeHoRate,
b.cs_HandoffReqNum cs_HandoffReqNum,
b.cs_HandoffSuccNum cs_HandoffSuccNum,
round(100*b.cs_HandoffSuccNum/decode(cs_HandoffReqNum,0,1,null,1,b.cs_HandoffReqNum),4) cs_HandoffSuccRate,
b.HandoffReqNum_Extra HandoffReqNum_Extra,
b.HandoffSuccNum_Extra HandoffSuccNum_Extra,
--update-2011-9-14
round(100*b.HandoffSuccNum_Extra/decode(b.HandoffReqNum_Extra,0,1,null,1,b.HandoffReqNum_Extra),4) HandoffSuccRate_Extra,
v1-v2 ps_SSHOTraffic,
round(100*b.ps_LoseCallingRate_up/decode(b.ps_LoseCallingRate_down,0,1,null,1,b.ps_LoseCallingRate_down),4) ps_LoseCallingRate,
b.ps_TchReqNumIncludeHo ps_TchReqNumIncludeHo,
b.ps_TchSuccNumIncludeHo ps_TchSuccNumIncludeHo,
(b.ps_TchFNumIncludeHo_b1 - b.ps_TchFNumIncludeHo_b2) ps_TchFNumIncludeHo,
(b.ps_TchFNumIncludeHo_b1 - b.ps_TchFNumIncludeHo_b2) ps_CallBlockFailNum,
round(100*b.ps_TchFNumIncludeHo_b2/decode(b.ps_TchFNumIncludeHo_b1,0,1,null,1,b.ps_TchFNumIncludeHo_b1),4) ps_TchSuccIncludeHoRate,
b.ps_TchReqNumExcludeHo ps_TchReqNumExcludeHo,
b.ps_TchSuccNumExcludeHo ps_TchSuccNumExcludeHo,
b.ps_TchReqNumExcludeHo - b.ps_TchSuccNumExcludeHo  ps_TchFNumExcludeHo,
round(100*b.ps_TchSuccNumExcludeHo /decode(b.ps_TchReqNumExcludeHo,0,1,null,1,b.ps_TchReqNumExcludeHo),4)  ps_TchSuccExcludeHoRate,
round(ps_LoseCallingratio_up/decode(ps_LoseCallingratio_down,0,1,null,1,ps_LoseCallingratio_down),4) ps_LoseCallingratio,
(TchReqNumIncludeHo_a+TchReqNumIncludeHo_b) TchReqNumIncludeHo,
(TchReqNumExcludeHo_a+TchReqNumExcludeHo_b) TchReqNumExcludeHo,
(TchSuccNumIncludeHo_a+TchSuccNumIncludeHo_b) TchSuccNumIncludeHo,
(TchFNumIncludeHo_a1-TchFNumIncludeHo_a2+TchFNumIncludeHo_b1-TchFNumIncludeHo_b2) TchFNumIncludeHo,
round(100*(TchSuccIncludeHoRate_up_a+TchSuccIncludeHoRate_up_b)/decode(TchSuccIncludeHoRate_down_a+TchSuccIncludeHoRate_down_b,0,1,null,1,TchSuccIncludeHoRate_down_a+TchSuccIncludeHoRate_down_b),4) TchSuccIncludeHoRate,
(TchSuccNumExcludeHo_a+TchSuccNumExcludeHo_b) TchSuccNumExcludeHo,
(TchFNumExcludeHo_a1-TchFNumExcludeHo_a2+TchFNumExcludeHo_b1-TchFNumExcludeHo_b2) TchFNumExcludeHo,
round(100*(TchSuccExcludeHoRate_up_a+TchSuccExcludeHoRate_up_b)/decode(TchSuccExcludeHoRate_down_a+TchSuccExcludeHoRate_down_b,0,1,null,1,TchSuccExcludeHoRate_down_a+TchSuccExcludeHoRate_down_b),4) TchSuccExcludeHoRate,
(HandoffReqNum_a+HandoffReqNum_b) HandoffReqNum,
(HandoffSuccNum_a+HandoffSuccNum_b) HandoffSuccNum,
round(100*(HandoffSuccNum_a+HandoffSuccNum_b)/decode(HandoffReqNum_a+HandoffReqNum_b,0,1,null,1, HandoffReqNum_a+HandoffReqNum_b),4) HandoffSuccRate,
(HandoffReqNum_intra_a+HandoffReqNum_intra_b) HandoffReqNum_intra,
(HandoffSuccNum_intra_a+HandoffSuccNum_intra_b) HandoffSuccNum_intra,
round(100*(HandoffSuccNum_intra_a+HandoffSuccNum_intra_b)/decode(HandoffReqNum_intra_a+HandoffReqNum_intra_b,0,1,null,1,HandoffReqNum_intra_a+HandoffReqNum_intra_b),4) HandoffSuccRate_intra,
round(100*(cs_CallBlockFailRate_up_a+cs_CallBlockFailRate_up_b)/decode(cs_CallBlockFailRate_down,0,1,null,1,cs_CallBlockFailRate_down),4) cs_CallBlockFailRate,
ChannelNum,
ChannelAvailNum,
ChannelMaxUseNum
from a,b,c
where a.related_msc = b.related_msc and  b.related_msc=c.related_msc;


commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
OnecarrierBtsNum,
Carrier1BtsNum
)
select
a.related_msc,
v_date,
0,
101,
10,nvl(a.OnecarrierBtsNum,0),nvl(b.Carrier1BtsNum,0)
from
(
select related_msc,count(distinct related_bts) OnecarrierBtsNum
from
(select related_msc,related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=10
group by related_msc,related_bts having count(distinct cdma_freq)=1 )
group by related_msc) a,
(
select a.related_msc,
-- sum((case when cdma_freq=283 then 1 else 0 end))/count(distinct (case when cdma_freq=283 then int_id end ))*count(distinct (case when cdma_freq=283 then related_bts end ))  Carrier1BtsNum
count(distinct a.related_bts)  Carrier1BtsNum
 from c_carrier a
  where   a.vendor_id=10  and  cdma_freq=283
 group by a.related_msc) b where a.related_msc=b.related_msc(+);
commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TwocarrierbtsNum,
Carrier2BtsNum
)
select a.related_msc,
v_date,
0,
101,
10,nvl(a.TwocarrierbtsNum,0),nvl(b.Carrier2BtsNum,0)
from
(
select related_msc,count(distinct related_bts) TwocarrierBtsNum
from
(select related_msc,related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=10
group by related_msc,related_bts having count(distinct cdma_freq)=2 )
group by related_msc) a,
(
select a.related_msc,
-- sum((case when cdma_freq=201 then 1 else 0 end))/count(distinct (case when cdma_freq=201 then int_id end ))*count(distinct (case when cdma_freq=201 then related_bts end ))  Carrier2BtsNum
count(distinct a.related_bts)  Carrier2BtsNum
 from c_carrier a
  where   a.vendor_id=10 and  cdma_freq=201
 group by a.related_msc) b where a.related_msc=b.related_msc(+);
commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
threecarrierbtsNum,
Carrier3BtsNum
)
select
a.related_msc,
v_date,
0,
101,
10,nvl(a.threecarrierbtsNum,0),nvl(b.Carrier3BtsNum,0)
from
(
select related_msc,count(distinct related_bts) threecarrierbtsNum
from
(select related_msc,related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=10
group by related_msc,related_bts having count(distinct cdma_freq)=3 )
group by related_msc) a,
(
select a.related_msc,
-- sum((case when cdma_freq=242 then 1 else 0 end))/count(distinct (case when cdma_freq=242 then int_id end ))*count(distinct (case when cdma_freq=242 then related_bts end ))  Carrier3BtsNum
count(distinct a.related_bts) Carrier3BtsNum
 from c_carrier a
  where   a.vendor_id=10  and  cdma_freq=242
 group by a.related_msc) b where a.related_msc=b.related_msc(+);

commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
FourcarrierbtsNum,
Carrier4BtsNum
)
select a.related_msc,
v_date,
0,
101,
10,nvl(a.FourcarrierbtsNum,0),nvl(b.Carrier4BtsNum,0)
from
(
select related_msc,count(distinct related_bts) FourcarrierbtsNum
from
(select related_msc,related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=10
group by related_msc,related_bts having count(distinct cdma_freq)=4)
group by related_msc) a,
(
select a.related_msc,
 --sum((case when cdma_freq=160 then 1 else 0 end))/count(distinct (case when cdma_freq=160 then int_id end ))*count(distinct (case when cdma_freq=160 then related_bts end ))  Carrier4BtsNum
count(distinct a.related_bts) Carrier4BtsNum
 from c_carrier a
  where   a.vendor_id=10 and  cdma_freq=160
 group by a.related_msc) b where a.related_msc=b.related_msc(+);
commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CellNum,
BusyerCellNum,
BusyCellNum  ,
FreeCellNum,
btsNum
)
select a.related_msc,
v_date,
0,
101,
10,a.CellNum,nvl(b.BusyerCellNum,0),nvl(c.BusyCellNum,0),nvl(d.FreeCellNum,0),nvl(a.btsNum,0)
from
(
select b.related_msc ,count(distinct a.related_cell) CellNum,count(distinct a.related_bts) btsNum
from c_carrier a,c_cell b
where a.related_cell=b.int_id and  a.cdma_freq in (283,242,201,160,119)
and a.vendor_id=10
group by b.related_msc ) a,
(
select a.related_msc,count(distinct b.int_id) BusyerCellNum
from
(
select b.related_msc ,b.related_bts int_id,sum(nvl(a.c006,0)+ nvl(a.c011,0)+nvl(a.c012,0) + nvl(a.c276,0) + nvl(a.c278,0)) temp
from c_tpd_cnt_carr_lc a,c_carrier b
where a.int_id=b.int_id and a.scan_start_time=v_date and b.vendor_id=10
group by b.related_msc ,b.related_bts) a,c_cell b,c_tpd_sts_bts c,c_erl d
where a.int_id=c.int_id and b.related_bts=a.int_id
and  c.scan_start_time=v_date and b.vendor_id=10 and d.tchnum=c.nbrAvailCe
and 100*a.temp/(decode(erl02,null,1,0,1,erl02)*360)>75
group by a.related_msc
) b,
(
select a.related_msc,count(distinct b.int_id) BusyCellNum
from
(
select b.related_msc ,b.related_bts int_id,sum(nvl(a.c006,0)+ nvl(a.c011,0)+nvl(a.c012,0) + nvl(a.c276,0) + nvl(a.c278,0)) temp
from c_tpd_cnt_carr_lc a,c_carrier b
where a.int_id=b.int_id and a.scan_start_time=v_date and b.vendor_id=10
group by b.related_msc ,b.related_bts) a,c_cell b,c_tpd_sts_bts c,c_erl d
where a.int_id=c.int_id and b.related_bts=a.int_id
and  c.scan_start_time=v_date and b.vendor_id=10 and d.tchnum=c.nbrAvailCe
and 100*a.temp/(decode(erl02,null,1,0,1,erl02)*360)<75
and 100*a.temp/(decode(erl02,null,1,0,1,erl02)*360)>60
group by a.related_msc
) c,
(
select a.related_msc,count(distinct b.int_id) FreeCellNum
from
(
select b.related_msc ,b.related_bts int_id,
sum(nvl(a.c006,0)+ nvl(a.c011,0)+nvl(a.c012,0) + nvl(a.c276,0) + nvl(a.c278,0)) temp
from c_tpd_cnt_carr_lc a,c_carrier b
where a.int_id=b.int_id and a.scan_start_time=v_date and b.vendor_id=10
group by b.related_msc ,b.related_bts) a,c_cell b,c_tpd_sts_bts c,c_erl d
where a.int_id=c.int_id and b.related_bts=a.int_id
and  c.scan_start_time=v_date and b.vendor_id=10 and d.tchnum=c.nbrAvailCe
and 100*a.temp/(decode(erl02,null,1,0,1,erl02)*360)<10
group by a.related_msc
)d
where a.related_msc=b.related_msc(+) and a.related_msc=c.related_msc(+) and a.related_msc=d.related_msc(+);
commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
OnecarrierCellNum,
TwocarrierCellNum,
threecarrierCellNum,
FourcarrierCellNum
)
select a.related_msc,
v_date,
0,
101,
10,count(distinct a.OnecarrierCellNum),
count(distinct a.TwocarrierCellNum) TwocarrierCellNum,
count(distinct a.threecarrierCellNum),
count(distinct a.FourcarrierCellNum)
from
(select related_msc ,
case when count(distinct cdma_freq)=1 then max(distinct related_cell) end  OnecarrierCellNum,
case when count(distinct cdma_freq)=2 then max(distinct related_cell) end  TwocarrierCellNum,
case when count(distinct cdma_freq)=3 then max(distinct related_cell) end  threecarrierCellNum,
case when count(distinct cdma_freq)=4 then max(distinct related_cell) end  FourcarrierCellNum
from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=10
group by related_msc,related_cell  ) a
group by a.related_msc;

commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CENum,
TCHNum,
Wirecapacity
)
with temp1 as (
select
c.int_id,
round(c.Channel_nbr) CENum,
round(a.l2/360) TCHNum
from C_tpd_cnt_bts_lc a, c_bts c
where a.int_id = c.int_id and a.scan_start_time = v_date
and c.vendor_id=10)
select
c_bts.related_msc,
v_date,
0,
101,
10,
sum(temp1.cenum) cenum,
sum(temp1.tchnum) tchnum,
sum(c_erl.erl02) Wirecapacity
from temp1,c_erl,c_bts
where temp1.TCHNum=c_erl.TCHNum and temp1.int_id=c_bts.int_id and c_bts.related_msc is not null
group by c_bts.related_msc;
commit;
 dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TrafficCarrier1,
TrafficCarrier2,
TrafficCarrier3,
TrafficCarrier4)
select
related_msc,
v_date,
0,
101,
10,
round(nvl(sum(case when cdma_freq=283 then
          round(nvl(a.c006,0)+ nvl(a.c085,0))/360 + (2*nvl(a.L038,0)
          +4*nvl(a.L039,0) + 8*nvl(a.L040,0) + 16*nvl(a.L041,0) +nvl(a.L076,0)
          +2*nvl(a.L077,0) + 4*nvl(a.L078,0) +8*nvl(a.L079,0))/500/360 + (nvl(a.L043,0)
          + 2*nvl(a.L044,0) + 4*nvl(a.L045,0) + 8*nvl(a.L046,0))/500/360  end),0),4) TrafficCarrier1,
round(nvl(sum(case when cdma_freq=201 then
          round( nvl(a.c006,0)+ nvl(a.c085,0))/360 + (2*nvl(a.L038,0) +4*nvl(a.L039,0) + 8*nvl(a.L040,0)
          + 16*nvl(a.L041,0) +nvl(a.L076,0) +2*nvl(a.L077,0) + 4*nvl(a.L078,0) +8*nvl(a.L079,0))/500/360 +
        (nvl(a.L043,0) + 2*nvl(a.L044,0) + 4*nvl(a.L045,0) + 8*nvl(a.L046,0))/500/360   end),0),4) TrafficCarrier2,
round(nvl(sum(case when cdma_freq=242 then
        (nvl(a.c006,0)+ nvl(a.c085,0))/360 + (2*nvl(a.L038,0) +4*nvl(a.L039,0) + 8*nvl(a.L040,0) + 16*nvl(a.L041,0) +nvl(a.L076,0) +2*nvl(a.L077,0)
         + 4*nvl(a.L078,0) +8*nvl(a.L079,0))/500/360 +(nvl(a.L043,0) + 2*nvl(a.L044,0) + 4*nvl(a.L045,0) + 8*nvl(a.L046,0))/500/360 end ),0),4)TrafficCarrier3,
         round(nvl(sum(case when  cdma_freq=160  then
      round((nvl(a.c006,0)+ nvl(a.c085,0))/360 + (2*nvl(a.L038,0) +4*nvl(a.L039,0) + 8*nvl(a.L040,0) +
      16*nvl(a.L041,0) +nvl(a.L076,0) +2*nvl(a.L077,0) + 4*nvl(a.L078,0) +8*nvl(a.L079,0))/500/360 +
    (nvl(a.L043,0) + 2*nvl(a.L044,0) + 4*nvl(a.L045,0) + 8*nvl(a.L046,0))/500/360,4) end),0),4)  TrafficCarrier4

from C_tpd_cnt_carr_lc a,c_carrier c
where a.int_id=c.int_id and c.vendor_id=10
and a.scan_start_time= v_date
group by related_msc;


commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
cs_CallBlockFailNum,
TCHBlockFailRate,
AvgRadioFPeriod,
CEAvailNum,
TCHBlockFailNumIncludeHo,
SeriOverflowBtsNum,
OverflowBtsNum
)
select
r.related_msc,
v_date,
0,
101,
10,
sum(t.cs007+t.cs008+ t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 +t.c031 + t.c033 + t.c034 + t.c035 + t.c036) cs_CallBlockFailNum,
round(sum(t.cs007+t.cs008+ t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 +t.c031 + t.c033 + t.c034 + t.c035 + t.c036)/decode(sum(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106)*100,0,1,sum(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106)*100),4)  TCHBlockFailRate,
sum(t.l1)/360*60/decode(sum(t.sc017+t.sc018+t.sc040+t.sc041),0,1,null,1,sum(t.sc017+t.sc018+t.sc040+t.sc041)) AvgRadioFPeriod,
sum(t.l1/360) CEAvailNum,
--update-8-25
sum(t.cs007+t.cs008+ t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 + t.c031 + t.c033 + t.c034 + t.c035 + t.c036) TCHBlockFailNumIncludeHo,
case when sum(t.cs007+t.cs008+t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 + t.c031 + t.c033 + t.c034 + t.c035 + t.c036)/decode(sum(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106)*100,0,1,sum(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106)*100) >=3 then 1 else 0 end  SeriOverflowBtsNum,
sum(case when (t.cs007+t.cs008+t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 + t.c031 + t.c033 + t.c034 + t.c035 + t.c036)/decode((t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106),0,1,(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106))*100 >=1 and (t.cs007+t.cs008+t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 + t.c031 + t.c033 + t.c034 + t.c035 + t.c036)/decode((t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106),0,1,(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106))*100 <3  then 1 else 0 end) OverflowBtsNum
from
(select
t1.int_id int_id,
t1.l1     l1,
t1.cs007  cs007,
t1.cs008  cs008,
t1.a70    a70,
t2.esc24  esc24,
t2.esc25  esc25,
t2.esc26  esc26,
t2.esc27  esc27,
t2.esc28  esc28,
t2.esc29  esc29,
t2.esc30  esc30,
t2.esc32  esc32,
t2.esc34  esc34,
t2.esc35  esc35,
t2.esc43  esc43,
t2.esc44  esc44,
t2.esc45  esc45,
t2.esc46  esc46,
t2.ec01   ec01 ,
t2.ec02   ec02 ,
t2.c006   c006 ,
t2.c008   c008 ,
t2.c011   c011 ,
t2.c012   c012 ,
t2.c029   c029 ,
t2.c031   c031 ,
t2.c033   c033 ,
t2.c034   c034 ,
t2.c035   c035 ,
t2.c036   c036 ,
t2.c085   c085 ,
t2.c086   c086 ,
t2.c276 c276,
t2.c278 c278,
t2.sc017  sc017,
t2.sc018  sc018,
t2.sc019  sc019,
t2.sc020  sc020,
t2.sc022  sc022,
t2.sc023  sc023,
t2.sc024  sc024,
t2.sc032  sc032,
t2.sc033  sc033,
t2.sc036  sc036,
t2.sc037  sc037,
t2.sc040  sc040,
t2.sc041  sc041,
t2.sc048  sc048,
t2.sc050  sc050,
t2.sc051  sc051,
t2.sc053  sc053,
t2.sc054  sc054,
t2.sc056  sc056,
t2.sc057  sc057,
t2.sc059  sc059,
t2.sc104  sc104,
t2.sc105  sc105,
t2.sc106  sc106,
t2.sc110  sc110,
t2.sc108  sc108,
t2.sc107  sc107,
t2.sc109  sc109,
t2.sc115  sc115,
t2.sc116  sc116,
t2.sc117  sc117,
t2.sc118  sc118,
t2.sc119  sc119,
t2.sc159  sc159,
t2.sc160  sc160,
t2.sc161  sc161,
t2.sc162  sc162,
t2.sc163  sc163,
t2.sc164  sc164,
t2.sc165  sc165,
t2.sc166  sc166,
t2.sc167  sc167,
t2.sc168  sc168,
t2.c062   c062,
t2.c063   c063,
t2.vo30   vo30,
t2.vo31   vo31,
t2.vo32   vo32,
t2.vo33   vo33,
t2.vo34   vo34,
t2.vo35   vo35,
t2.vo36   vo36,
t2.vo38   vo38,
t2.vo39   vo39,
t2.vo40   vo40,
t1.cnt1+t2.cnt2 cnt
from
(select
t.int_id int_id,
c.l1 l1,
c.cs007 cs007,
c.cs008 cs008,
c.a70 a70,
case when round(c.l1/360) > 2.5
then 1 else 0 end cnt1
from C_tpd_cnt_bts_lc c,c_bts t
where c.int_id = t.int_id
and c.scan_start_time = v_date ) t1,
(select
c.int_id int_id,
c.related_bts related_bts,
sum(a.esc24) esc24,
sum(a.esc25) esc25,
sum(a.esc26) esc26,
sum(a.esc27) esc27,
sum(a.esc28) esc28,
sum(a.esc29) esc29,
sum(a.esc30) esc30,
sum(a.esc32) esc32,
sum(a.esc34) esc34,
sum(a.esc35) esc35,
sum(a.esc43) esc43,
sum(a.esc44) esc44,
sum(a.esc45) esc45,
sum(a.esc46) esc46,
sum(a.ec01)  ec01,
sum(a.ec02)  ec02,
sum(a.c006)  c006,
sum(a.c008)  c008,
sum(a.c011)  c011,
sum(a.c012)  c012,
sum(a.c029)  c029,
sum(a.c031)  c031,
sum(a.c033)  c033,
sum(a.c034)  c034,
sum(a.c035)  c035,
sum(a.c036)  c036,
sum(a.c085)  c085,
sum(a.c086)  c086,
sum(a.c276) c276,
sum(a.c278) c278,
sum(a.sc017) sc017,
sum(a.sc018) sc018,
sum(a.sc019) sc019,
sum(a.sc020) sc020,
sum(a.sc022) sc022,
sum(a.sc023) sc023,
sum(a.sc024) sc024,
sum(a.sc032) sc032,
sum(a.sc033) sc033,
sum(a.sc036) sc036,
sum(a.sc037) sc037,
sum(a.sc040) sc040,
sum(a.sc041) sc041,
sum(a.sc048) sc048,
sum(a.sc050) sc050,
sum(a.sc051) sc051,
sum(a.sc053) sc053,
sum(a.sc054) sc054,
sum(a.sc056) sc056,
sum(a.sc057) sc057,
sum(a.sc059) sc059,
sum(a.sc104) sc104,
sum(a.sc105) sc105,
sum(a.sc106) sc106,
sum(a.sc110) sc110,
sum(a.sc108) sc108,
sum(a.sc107) sc107,
sum(a.sc109) sc109,
sum(a.sc115) sc115,
sum(a.sc116) sc116,
sum(a.sc117) sc117,
sum(a.sc118) sc118,
sum(a.sc119) sc119,
sum(a.sc159) sc159,
sum(a.sc160) sc160,
sum(a.sc161) sc161,
sum(a.sc162) sc162,
sum(a.sc163) sc163,
sum(a.sc164) sc164,
sum(a.sc165) sc165,
sum(a.sc166) sc166,
sum(a.sc167) sc167,
sum(a.sc168) sc168,
sum(a.c062) c062,
sum(a.c063) c063,
sum(a.vo30) vo30,
sum(a.vo31) vo31,
sum(a.vo32) vo32,
sum(a.vo33) vo33,
sum(a.vo34) vo34,
sum(a.vo35) vo35,
sum(a.vo36) vo36,
sum(a.vo38) vo38,
sum(a.vo39) vo39,
sum(a.vo40) vo40,
sum(case when a.sc017+a.sc018+a.sc040+a.sc041 >= 3
then 1 else 0 end
+
case when a.sc017+a.sc018
+a.sc040+a.sc041/
decode((a.vo30-a.vo38
+a.vo31-a.vo39
+a.vo32-a.vo40
+a.sc104-a.sc115
+a.sc105-a.sc116
+a.sc106-a.sc117
+a.sc023-a.sc048
+a.sc050-a.esc28
-a.sc118-a.esc34
-a.esc43-a.sc159
-a.sc160-a.sc194
-a.sc196+a.sc024
-a.sc051+a.sc053
-a.esc45-a.sc163
-a.sc164-a.sc167
-a.esc30+a.sc036
-a.sc054+a.sc056
-a.esc29-a.sc119
-a.esc35-a.esc44
-a.sc161-a.sc162
-a.sc195-a.sc197
+a.sc037-a.sc057
+a.sc059-a.esc46
-a.sc165-a.sc166
-a.sc168-a.esc32
+a.c062+a.c063),0,1,null,1,(a.vo30-a.vo38
+a.vo31-a.vo39
+a.vo32-a.vo40
+a.sc104-a.sc115
+a.sc105-a.sc116
+a.sc106-a.sc117
+a.sc023-a.sc048
+a.sc050-a.esc28
-a.sc118-a.esc34
-a.esc43-a.sc159
-a.sc160-a.sc194
-a.sc196+a.sc024
-a.sc051+a.sc053
-a.esc45-a.sc163
-a.sc164-a.sc167
-a.esc30+a.sc036
-a.sc054+a.sc056
-a.esc29-a.sc119
-a.esc35-a.esc44
-a.sc161-a.sc162
-a.sc195-a.sc197
+a.sc037-a.sc057
+a.sc059-a.esc46
-a.sc165-a.sc166
-a.sc168-a.esc32
+a.c062+a.c063))*100 > 2.5
then 1 else 0 end) cnt2
from C_tpd_cnt_carr_lc a,c_carrier c
where a.int_id = c.int_id
and a.scan_start_time = v_date
group by c.int_id,c.related_bts) t2,
(select count(*) cnt_cell from c_cell where do_cell=0) cc
where t1.int_id = t2.related_bts(+)) t,c_bts r
where t.int_id=r.int_id
group by r.related_msc;



commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');







insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CallPageReqNum,
CallPageSuccNum,
Numfailofcall,
cs_Numfailofcall,
CallPageSuccRate,
LoseCallingRate,
ps_CallPageSuccRate,
cs_CallPageSuccRate,
BadCellRatio,
cs_LoseCallingRate,
SHoFactor,
ps_SHOTraffic,
cs_TchFNumIncludeHo,
ChannelMaxUseRate,
FwdChMaxUseRate,
RevChMaxUseRate,
TrafficIncludeHo,
TCHLoadRate,
CEAvailRate,
BusyerCellratio,
BusyCellratio,
FreeCellratio,
SeriOverflowBtsratio,
OverflowBtsratio,
CallBlockFailNum,
CallBlockFailRate,
ps_CallBlockFailRate,
ps_CallBlockFailRateHardho,
ps_CallBlockFailRatesoftho,
LoseCallingratio,
cs_CallBlockFailRateHardho,
cs_CallBlockFailRatesoftho
)
select
int_id,
v_date,
0,
101,
10,
sum(nvl(cs_CallPageReqNum,0)+nvl(ps_CallPageReqNum,0)) CallPageReqNum,
sum(nvl(cs_CallPageSuccNum,0)+nvl(ps_CallPageSuccNum,0)) CallPageSuccNum,
sum(nvl(cs_CallPageReqNum,0)+nvl(ps_CallPageReqNum,0)-nvl(cs_CallPageSuccNum,0)-nvl(ps_CallPageSuccNum,0))   Numfailofcall,
sum(nvl(cs_CallPageReqNum,0)-nvl(cs_CallPageSuccNum,0))   cs_Numfailofcall,

round(100*sum(nvl(cs_CallPageSuccNum,0)+nvl(ps_CallPageSuccNum,0))/decode(sum(nvl(cs_CallPageReqNum,0)+nvl(ps_CallPageReqNum,0)),0,1,null,1,sum(nvl(cs_CallPageReqNum,0)+nvl(ps_CallPageReqNum,0))),4) CallPageSuccRate,
round(100*sum(nvl(cs_LoseCallingNum,0)+nvl(ps_LoseCallingNum,0))/decode(sum(nvl(cs_TchSuccNumExcludeHo,0)+nvl(ps_TchSuccNumExcludeHo,0)),0,1,null,1,sum(nvl(cs_TchSuccNumExcludeHo,0)+nvl(ps_TchSuccNumExcludeHo,0))),4) LoseCallingRate,
round(100*sum(nvl(ps_CallPageSuccNum,0))/decode(sum(ps_CallPageReqNum),0,1,null,1,sum(ps_CallPageReqNum)),4) ps_CallPageSuccRate,
round(100*sum(nvl(cs_CallPageSuccNum,0))/decode(sum(cs_CallPageReqNum),0,1,null,1,sum(cs_CallPageReqNum)),4)  cs_CallPageSuccRate,
round(100*sum(nvl(BadCellNum,0))/decode(sum(CellNum),0,1,null,1,sum(CellNum)),4) BadCellRatio,
round(100*sum(nvl(cs_LoseCallingNum,0))/decode(sum(cs_TchSuccNumExcludeHo),0,1,null,1,sum(cs_TchSuccNumExcludeHo)),4) cs_LoseCallingRate,
round(100*sum(TCHLoadTrafficIncludeHo - TCHLoadTrafficExcludeHo)/decode(sum(TCHLoadTrafficExcludeHo),0,1,null,1,sum(TCHLoadTrafficExcludeHo)),4) SHoFactor,
sum((nvl(ps_CallTrafficIncludeHo,0)-nvl(ps_CallTrafficExcludeHo,0)))  ps_SHOTraffic,
sum(nvl(cs_TchReqNumIncludeHo,0)-nvl(cs_TchSuccNumIncludeHo,0)) cs_TchFNumIncludeHo,
round(100*sum(nvl(ChannelMaxUseNum,0))/decode(sum(ChannelAvailNum),null,1,0,1,sum(ChannelAvailNum)),4) ChannelMaxUseRate,
sum(round(nvl(FwdChMaxUseRate,0),4))  FwdChMaxUseRate ,
sum(round(nvl(RevChMaxUseRate,0),4))       RevChMaxUseRate ,
sum((nvl(cs_TrafficIncludeHo,0)+nvl(ps_CallTrafficIncludeHo,0))) TrafficIncludeHo,
--sum(round(100*(nvl(ps_CallTrafficIncludeHo,0)-nvl(ps_CallTrafficExcludeHo,0))/decode(nvl(ps_CallTrafficExcludeHo,0)+nvl(ps_CallTrafficIncludeHo-ps_CallTrafficExcludeHo,0),0,1,nvl(ps_CallTrafficExcludeHo,0)+nvl(ps_CallTrafficIncludeHo-ps_CallTrafficExcludeHo,0)),4))  ps_SHORate,
round(100*sum(nvl(TCHLoadTrafficIncludeHo,0))/decode(sum(Wirecapacity),null,1,0,1,sum(Wirecapacity)),4)  TCHLoadRate,
round(100*sum(nvl(CEAvailNum,0))/decode(sum(nvl(CENum,0)),null,1,0,1,sum(nvl(CENum,0))),4) CEAvailRate,
round(100*sum(nvl(BusyerCellNum,0))/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4) BusyerCellratio,
round(100*sum(nvl(BusyCellNum,0))/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4)  BusyCellratio,
round(100*sum(nvl(FreeCellNum,0))/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4) FreeCellratio,
round(100*sum(nvl(SeriOverflowBtsNum,0))/decode(sum(BtsNum),null,1,0,1,sum(BtsNum)),4)    SeriOverflowBtsratio,
round(100*sum(nvl(OverflowBtsNum,0))/decode(sum(BtsNum),null,1,0,1,sum(BtsNum)),4)  OverflowBtsratio,
sum(nvl(cs_CallBlockFailNum,0)+nvl(ps_CallBlockFailNum,0)) CallBlockFailNum,
round(100*sum(nvl(cs_CallBlockFailNum,0)+nvl(ps_CallBlockFailNum,0))/decode(sum(TchReqNumIncludeHo),null,1,0,1,sum(TchReqNumIncludeHo)),4) CallBlockFailRate,
round(100*sum(nvl(ps_CallBlockFailNum,0))/decode(sum(ps_TchReqNumIncludeHo),null,1,0,1,sum(ps_TchReqNumIncludeHo)),4)  ps_CallBlockFailRate,
round(100*sum(nvl(ps_TchReqNumHardho,0)-nvl(ps_TchSuccNumHardho,0))/decode(sum(ps_TchReqNumHardho),null,1,0,1,sum(ps_TchReqNumHardho)),4) ps_CallBlockFailRateHardho,
round(100*sum(nvl(ps_TchReqNumsoftho,0)-nvl(ps_TchSuccNumsoftho,0))/decode(sum(ps_TchReqNumsoftho),null,1,0,1,sum(ps_TchReqNumsoftho)),4) ps_CallBlockFailRatesoftho,
round(sum(nvl(TrafficExcludeHo,0))*60/decode(sum(LoseCallingNum),null,1,0,1,sum(LoseCallingNum)),4) LoseCallingratio,
round(100*sum(nvl(cs_TchReqNumHardho,0)-nvl(cs_TchSuccNumHardho,0))/decode(sum(cs_TchReqNumHardho),null,1,0,1,sum(cs_TchReqNumHardho)),4) cs_CallBlockFailRateHardho,
round(100*sum(nvl(cs_TchReqNumsoftho,0)-nvl(cs_TchSuccNumsoftho,0))/decode(sum(cs_TchReqNumsoftho),null,1,0,1,sum(cs_TchReqNumsoftho)),4) cs_CallBlockFailRatesoftho
from C_PERF_1X_SUM_LC_TEMP
group by int_id;






commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');
insert  /*+append*/ into c_perf_1x_sum
(
int_id                        ,
scan_start_time             ,
sum_level                   ,
ne_type                     ,
vendor_id                   ,
callpagereqnum              ,
callpagesuccnum             ,
callpagesuccrate            ,
cs_callpagereqnum           ,
cs_callpagesuccnum          ,
cs_callpagesuccrate         ,
ps_callpagereqnum           ,
ps_callpagesuccnum          ,
ps_callpagesuccrate         ,
trafficincludeho            ,
trafficexcludeho            ,
cs_trafficincludeho         ,
cs_trafficexcludeho         ,
cs_trafficbywalsh           ,
cs_shotraffic               ,
cs_sshotraffic              ,
cs_shorate                  ,
ps_calltrafficincludeho     ,
ps_calltrafficexcludeho     ,
ps_trafficbywalsh           ,
ps_shotraffic               ,
ps_sshotraffic              ,
ps_shorate                  ,
losecallingnum              ,
losecallingrate             ,
losecallingratio            ,
cs_losecallingnum           ,
cs_losecallingrate          ,
cs_losecallingratio         ,
ps_losecallingnum           ,
ps_losecallingrate          ,
ps_losecallingratio         ,
tchreqnumincludeho          ,
tchsuccnumincludeho         ,
tchfnumincludeho            ,
tchsuccincludehorate        ,
tchreqnumexcludeho          ,
tchsuccnumexcludeho         ,
tchfnumexcludeho            ,
tchsuccexcludehorate        ,
callblockfailnum            ,
callblockfailrate           ,
cs_tchreqnumincludeho       ,
cs_tchsuccnumincludeho      ,
cs_tchfnumincludeho         ,
cs_tchsuccincludehorate     ,
cs_tchreqnumexcludeho       ,
cs_tchsuccnumexcludeho      ,
cs_tchfnumexcludeho         ,
cs_tchsuccexcludehorate     ,
cs_callblockfailnum         ,
cs_callblockfailrate        ,
cs_tchreqnumhardho          ,
cs_tchsuccnumhardho         ,
cs_callblockfailratehardho  ,
cs_tchreqnumsoftho          ,
cs_tchsuccnumsoftho         ,
cs_callblockfailratesoftho  ,
ps_tchreqnumincludeho       ,
ps_tchsuccnumincludeho      ,
ps_tchfnumincludeho         ,
ps_tchsuccincludehorate     ,
ps_tchreqnumexcludeho       ,
ps_tchsuccnumexcludeho      ,
ps_tchfnumexcludeho         ,
ps_tchsuccexcludehorate     ,
ps_callblockfailnum         ,
ps_callblockfailrate        ,
ps_tchreqnumhardho          ,
ps_tchsuccnumhardho         ,
ps_callblockfailratehardho  ,
ps_tchreqnumsoftho          ,
ps_tchsuccnumsoftho         ,
ps_callblockfailratesoftho  ,
handoffreqnum               ,
handoffsuccnum              ,
handoffsuccrate             ,
cs_handoffreqnum            ,
cs_handoffsuccnum           ,
cs_handoffsuccrate          ,
cs_hardhoreqnum             ,
cs_hardhosuccnum            ,
cs_hardhosuccrate           ,
cs_softhoreqnum             ,
cs_softhosuccnum            ,
cs_softhosuccrate           ,
cs_ssofthoreqnum            ,
cs_ssofthosuccnum           ,
cs_ssofthosuccrate          ,
ps_handoffreqnum            ,
ps_handoffsuccnum           ,
ps_handoffsuccrate          ,
ps_hardhoreqnum             ,
ps_hardhosuccnum            ,
ps_hardhosuccrate           ,
ps_softhoreqnum             ,
ps_softhosuccnum            ,
ps_softhosuccrate           ,
ps_ssofthoreqnum            ,
ps_ssofthosuccnum           ,
ps_ssofthosuccrate          ,
handoffreqnum_intra         ,
handoffsuccnum_intra        ,
handoffsuccrate_intra       ,
handoffreqnum_extra         ,
handoffsuccnum_extra        ,
handoffsuccrate_extra       ,
hardhoreqnum_intra          ,
hardhosuccnum_intra         ,
hardhosuccrate_intra        ,
shoreqnum_intra             ,
shosuccnum_intra            ,
shosuccrate_intra           ,
sshoreqnum_intra            ,
sshosuccnum_intra           ,
sshosuccrate_intra          ,
hardhoreqnum_extra          ,
hardhosuccnum_extra         ,
hardhosuccrate_extra        ,
shoreqnum_extra             ,
shosuccnum_extra            ,
shosuccrate_extra           ,
carrier1btsnum              ,
carrier2btsnum              ,
carrier3btsnum              ,
carrier4btsnum              ,
carriernum_1x               ,
channelnum                  ,
channelavailnum             ,
channelmaxusenum            ,
channelmaxuserate           ,
fwdchnum                    ,
fwdchavailnum               ,
fwdchmaxusenum              ,
fwdchmaxuserate             ,
revchnum                    ,
revchavailnum               ,
revchmaxusenum              ,
revchmaxuserate             ,
fwdrxtotalframe             ,
fdwtxtotalframeexcluderx    ,
rlpfwdchsizeexcluderx       ,
rlpfwdchrxsize              ,
rlpfwdlosesize              ,
fwdchrxrate                 ,
revrxtotalframe             ,
revtxtotalframeexcluderx    ,
rlprevchsize                ,
revchrxrate                 ,
btsnum                      ,
onecarrierbtsnum            ,
twocarrierbtsnum            ,
threecarrierbtsnum          ,
fourcarrierbtsnum           ,
cellnum                     ,
onecarriercellnum           ,
twocarriercellnum           ,
threecarriercellnum         ,
fourcarriercellnum          ,
cenum                       ,
wirecapacity                ,
tchnum                      ,
tchloadrate                 ,
shofactor                   ,
ceavailrate                 ,
tchblockfailrate            ,
busyercellratio             ,
busycellratio               ,
freecellratio               ,
serioverflowbtsratio        ,
overflowbtsratio            ,
btssyshardhosuccrate        ,
sysshosuccrate              ,
tchradiofrate               ,
callinterruptrate           ,
avgradiofperiod             ,
badcellratio                ,
ceavailnum                  ,
tchblockfailnumincludeho    ,
tchloadtrafficincludeho     ,
tchloadtrafficexcludeho     ,
loadtrafficbywalsh          ,
trafficcarrier1             ,
trafficcarrier2             ,
trafficcarrier3             ,
trafficcarrier4             ,
busyercellnum               ,
busycellnum                 ,
freecellnum                 ,
badcellnum                  ,
serioverflowbtsnum          ,
overflowbtsnum              ,
tchreqnumcallerexcludehosms ,
tchsuccnumcallerexcludehosms,
tchreqnumcalleeexcludehosms ,
tchsuccnumcalleeexcludehosms,
tchreqnumexcludehosms       ,
tchsuccnumexcludehosms      ,
tchreqnumincludehosms       ,
tchsuccnumincludehosms      ,
btssyshardhoreqnum          ,
btssyshardhosuccnum         ,
sysshoreqnum                ,
sysshosuccnum               ,
tchradiofnum                ,
callpagereqtotalnum         ,
numfailofcall               ,
ps_numfailofcall            ,
cs_numfailofcall
)
select
int_id                        ,
scan_start_time             ,
sum_level                   ,
ne_type                     ,
vendor_id                   ,
sum(callpagereqnum              ),
sum(callpagesuccnum             ),
sum(callpagesuccrate            ),
sum(cs_callpagereqnum           ),
sum(cs_callpagesuccnum          ),
sum(cs_callpagesuccrate         ),
sum(ps_callpagereqnum           ),
sum(ps_callpagesuccnum          ),
sum(ps_callpagesuccrate         ),
sum(trafficincludeho            ),
sum(trafficexcludeho            ),
sum(cs_trafficincludeho         ),
sum(cs_trafficexcludeho         ),
sum(cs_trafficbywalsh           ),
sum(cs_shotraffic               ),
sum(cs_sshotraffic              ),
sum(cs_shorate                  ),
sum(ps_calltrafficincludeho     ),
sum(ps_calltrafficexcludeho     ),
sum(ps_trafficbywalsh           ),
sum(ps_shotraffic               ),
sum(ps_sshotraffic              ),
sum(ps_shorate                  ),
sum(losecallingnum              ),
sum(losecallingrate             ),
sum(losecallingratio            ),
sum(cs_losecallingnum           ),
sum(cs_losecallingrate          ),
sum(cs_losecallingratio         ),
sum(ps_losecallingnum           ),
sum(ps_losecallingrate          ),
sum(ps_losecallingratio         ),
sum(tchreqnumincludeho          ),
sum(tchsuccnumincludeho         ),
sum(tchfnumincludeho            ),
sum(tchsuccincludehorate        ),
sum(tchreqnumexcludeho          ),
sum(tchsuccnumexcludeho         ),
sum(tchfnumexcludeho            ),
sum(tchsuccexcludehorate        ),
sum(callblockfailnum            ),
sum(callblockfailrate           ),
sum(cs_tchreqnumincludeho       ),
sum(cs_tchsuccnumincludeho      ),
sum(cs_tchfnumincludeho         ),
sum(cs_tchsuccincludehorate     ),
sum(cs_tchreqnumexcludeho       ),
sum(cs_tchsuccnumexcludeho      ),
sum(cs_tchfnumexcludeho         ),
sum(cs_tchsuccexcludehorate     ),
sum(cs_callblockfailnum         ),
sum(cs_callblockfailrate        ),
sum(cs_tchreqnumhardho          ),
sum(cs_tchsuccnumhardho         ),
sum(cs_callblockfailratehardho  ),
sum(cs_tchreqnumsoftho          ),
sum(cs_tchsuccnumsoftho         ),
sum(cs_callblockfailratesoftho  ),
sum(ps_tchreqnumincludeho       ),
sum(ps_tchsuccnumincludeho      ),
sum(ps_tchfnumincludeho         ),
sum(ps_tchsuccincludehorate     ),
sum(ps_tchreqnumexcludeho       ),
sum(ps_tchsuccnumexcludeho      ),
sum(ps_tchfnumexcludeho         ),
sum(ps_tchsuccexcludehorate     ),

sum(ps_CallBlockFailNum         ),

sum(ps_callblockfailrate        ),
sum(ps_tchreqnumhardho          ),
sum(ps_tchsuccnumhardho         ),
sum(ps_callblockfailratehardho  ),
sum(ps_tchreqnumsoftho          ),
sum(ps_tchsuccnumsoftho         ),
sum(ps_callblockfailratesoftho  ),
sum(handoffreqnum               ),
sum(handoffsuccnum              ),
sum(handoffsuccrate             ),
sum(cs_handoffreqnum            ),
sum(cs_handoffsuccnum           ),
sum(cs_handoffsuccrate          ),
sum(cs_hardhoreqnum             ),
sum(cs_hardhosuccnum            ),
sum(cs_hardhosuccrate           ),
sum(cs_softhoreqnum             ),
sum(cs_softhosuccnum            ),
sum(cs_softhosuccrate           ),
sum(cs_ssofthoreqnum            ),
sum(cs_ssofthosuccnum           ),
sum(cs_ssofthosuccrate          ),
sum(ps_handoffreqnum            ),
sum(ps_handoffsuccnum           ),
sum(ps_handoffsuccrate          ),
sum(ps_hardhoreqnum             ),
sum(ps_hardhosuccnum            ),
sum(ps_hardhosuccrate           ),
sum(ps_softhoreqnum             ),
sum(ps_softhosuccnum            ),
sum(ps_softhosuccrate           ),
sum(ps_ssofthoreqnum            ),
sum(ps_ssofthosuccnum           ),
sum(ps_ssofthosuccrate          ),
sum(handoffreqnum_intra         ),
sum(handoffsuccnum_intra        ),
sum(handoffsuccrate_intra       ),
sum(handoffreqnum_extra         ),
sum(handoffsuccnum_extra        ),
sum(handoffsuccrate_extra       ),
sum(hardhoreqnum_intra          ),
sum(hardhosuccnum_intra         ),
sum(hardhosuccrate_intra        ),
sum(shoreqnum_intra             ),
sum(shosuccnum_intra            ),
sum(shosuccrate_intra           ),
sum(sshoreqnum_intra            ),
sum(sshosuccnum_intra           ),
sum(sshosuccrate_intra          ),
sum(hardhoreqnum_extra          ),
sum(hardhosuccnum_extra         ),
sum(hardhosuccrate_extra        ),
sum(shoreqnum_extra             ),
sum(shosuccnum_extra            ),
sum(shosuccrate_extra           ),
sum(carrier1btsnum              ),
sum(carrier2btsnum              ),
sum(carrier3btsnum              ),
sum(nvl(carrier4btsnum,0)              ),
sum(carriernum_1x               ),
sum(channelnum                  ),
sum(channelavailnum             ),
sum(channelmaxusenum            ),
sum(channelmaxuserate           ),
sum(nvl(fwdchnum,0)             ),
sum(nvl(fwdchavailnum,0)        ),
sum(nvl(fwdchmaxusenum,0)       ),
sum(nvl(fwdchmaxuserate,0)      ),
sum(nvl(revchnum,0)             ),
sum(nvl(revchavailnum,0)        ),
sum(nvl(revchmaxusenum,0)       ),
sum(revchmaxuserate             ),
sum(nvl(fwdrxtotalframe,0)      ),
sum(fdwtxtotalframeexcluderx    ),
sum(rlpfwdchsizeexcluderx       ),
sum(rlpfwdchrxsize              ),
sum(nvl(rlpfwdlosesize,0)       ),
sum(fwdchrxrate                 ),
sum(revrxtotalframe             ),
sum(revtxtotalframeexcluderx    ),
sum(rlprevchsize                ),
sum(revchrxrate                 ),
sum(btsnum                      ),
sum(nvl(onecarrierbtsnum,0)            ),
sum(nvl(twocarrierbtsnum,0)            ),
sum(nvl(threecarrierbtsnum,0)          ),
sum(nvl(fourcarrierbtsnum,0)           ),
sum(cellnum                     ),
sum(onecarriercellnum           ),
sum(twocarriercellnum           ),
sum(threecarriercellnum         ),
sum(fourcarriercellnum          ),
sum(cenum                       ),
sum(wirecapacity                ),
sum(tchnum                      ),
sum(tchloadrate                 ),
sum(shofactor                   ),
sum(case when ceavailrate>=100 then 100 else  ceavailrate end ),
sum(tchblockfailrate            ),
sum(busyercellratio             ),
sum(busycellratio               ),
sum(freecellratio               ),
sum(serioverflowbtsratio        ),
sum(overflowbtsratio            ),
sum(btssyshardhosuccrate        ),
round(100*sum(nvl(SysSHoSuccNum,0))/decode(sum(nvl(SysSHoReqNum,0)),0,1,sum(nvl(SysSHoReqNum,0))),4),
sum(tchradiofrate               ),
sum(callinterruptrate           ),
--sum(avgradiofperiod             ),
round(100*sum(tCHLoadTrafficExcludeHo)/decode(sum(TCHRadioFNum),0,1,sum(TCHRadioFNum)),4),
sum(badcellratio                ),
round(sum(ceavailnum                  )),
sum(tchblockfailnumincludeho    ),
sum(tchloadtrafficincludeho     ),
sum(tchloadtrafficexcludeho     ),
sum(loadtrafficbywalsh          ),
sum(trafficcarrier1             ),
sum(trafficcarrier2             ),
sum(trafficcarrier3             ),
sum(trafficcarrier4             ),
sum(busyercellnum               ),
sum(busycellnum                 ),
sum(freecellnum                 ),
sum(nvl(badcellnum,0)           ),
sum(serioverflowbtsnum          ),
sum(overflowbtsnum              ),
sum(tchreqnumcallerexcludehosms ),
sum(tchsuccnumcallerexcludehosms),
sum(tchreqnumcalleeexcludehosms ),
sum(tchsuccnumcalleeexcludehosms),
sum(tchreqnumexcludehosms       ),
sum(tchsuccnumexcludehosms      ),
sum(tchreqnumincludehosms       ),
sum(tchsuccnumincludehosms      ),
sum(btssyshardhoreqnum          ),
sum(btssyshardhosuccnum         ),
sum(sysshoreqnum                ),
sum(sysshosuccnum               ),
sum(tchradiofnum                ),
sum(callpagereqtotalnum         ),
sum(numfailofcall               ),
round(sum(nvl(ps_CallPageReqNum,0) - nvl(ps_CallPageSuccNum,0))),
sum(cs_numfailofcall            )
from C_PERF_1X_SUM_LC_TEMP
group by int_id,scan_start_time,sum_level,ne_type,vendor_id;

commit;

v_sql:='truncate table  C_PERF_1X_SUM_LC_TEMP';
dbms_output.put_line(v_sql);
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');
execute immediate v_sql;
commit;

---------------------------------------------------------------------------------------------10004-begion
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
OnecarrierBtsNum,
Carrier1BtsNum
)
select
a.city_id,
v_date,
0,
10004,
10,nvl(a.OnecarrierBtsNum,0),nvl(b.Carrier1BtsNum,0)
from
(
select city_id,count(distinct related_bts) OnecarrierBtsNum
from
(select city_id,related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=10
group by city_id,related_bts having count(distinct cdma_freq)=1 )
where city_id is not null
group by city_id) a,
(
select a.city_id,
-- sum((case when cdma_freq=283 then 1 else 0 end))/count(distinct (case when cdma_freq=283 then int_id end ))*count(distinct (case when cdma_freq=283 then related_bts end ))  Carrier1BtsNum
count(distinct a.related_bts)  Carrier1BtsNum
 from c_carrier a
  where   a.vendor_id=10  and  cdma_freq=283
 group by a.city_id) b where a.city_id=b.city_id(+);

commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TwocarrierbtsNum,
Carrier2BtsNum
)
select a.city_id,
v_date,
0,
10004,
10,nvl(a.TwocarrierbtsNum,0),nvl(b.Carrier2BtsNum,0)
from
(
select city_id,count(distinct related_bts) TwocarrierBtsNum
from
(select city_id,related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=10
group by city_id,related_bts having count(distinct cdma_freq)=2 )
where city_id is not null
group by city_id) a,
(
select a.city_id,
-- sum((case when cdma_freq=201 then 1 else 0 end))/count(distinct (case when cdma_freq=201 then int_id end ))*count(distinct (case when cdma_freq=201 then related_bts end ))  Carrier2BtsNum
count(distinct a.related_bts)  Carrier2BtsNum
 from c_carrier a
  where   a.vendor_id=10 and  cdma_freq=201
 group by a.city_id) b where a.city_id=b.city_id(+);
commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');



insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
threecarrierbtsNum,
Carrier3BtsNum
)
select
a.city_id,
v_date,
0,
10004,
10,nvl(a.threecarrierbtsNum,0),nvl(b.Carrier3BtsNum,0)
from
(
select city_id,count(distinct related_bts) threecarrierbtsNum
from
(select city_id,related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=10
group by city_id,related_bts having count(distinct cdma_freq)=3 )
where city_id is not null
group by city_id) a,
(
select a.city_id,
-- sum((case when cdma_freq=242 then 1 else 0 end))/count(distinct (case when cdma_freq=242 then int_id end ))*count(distinct (case when cdma_freq=242 then related_bts end ))  Carrier3BtsNum
count(distinct a.related_bts) Carrier3BtsNum
 from c_carrier a
  where   a.vendor_id=10  and  cdma_freq=242
 group by a.city_id) b where a.city_id=b.city_id(+);


 commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
FourcarrierbtsNum,
Carrier4BtsNum
)
select a.city_id,
v_date,
0,
10004,
10,nvl(a.FourcarrierbtsNum,0),nvl(b.Carrier4BtsNum,0)
from
(
select city_id,count(distinct related_bts) FourcarrierbtsNum
from
(select city_id,related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=10
group by city_id,related_bts having count(distinct cdma_freq)=4)
where city_id is not null
group by city_id) a,
(
select a.city_id,
 --sum((case when cdma_freq=160 then 1 else 0 end))/count(distinct (case when cdma_freq=160 then int_id end ))*count(distinct (case when cdma_freq=160 then related_bts end ))  Carrier4BtsNum
count(distinct a.related_bts) Carrier4BtsNum
 from c_carrier a
  where   a.vendor_id=10 and  cdma_freq=160
 group by a.city_id) b where a.city_id=b.city_id(+);
commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CellNum,
BusyerCellNum,
BusyCellNum  ,
FreeCellNum,
btsNum
)
select a.city_id,
v_date,
0,
10004,
10,a.CellNum,nvl(b.BusyerCellNum,0),nvl(c.BusyCellNum,0),nvl(d.FreeCellNum,0),nvl(a.btsNum,0)
from
(
select b.city_id ,count(distinct a.related_cell) CellNum,count(distinct a.related_bts) btsNum
from c_carrier a,c_cell b
where a.related_cell=b.int_id and  a.cdma_freq in (283,242,201,160,119)
and a.vendor_id=10 and b.city_id is not null
group by b.city_id ) a,
(
select a.city_id,count(distinct b.int_id) BusyerCellNum
from
(
select b.city_id ,b.related_bts int_id,sum(nvl(a.c006,0)+ nvl(a.c011,0)+nvl(a.c012,0) + nvl(a.c276,0) + nvl(a.c278,0)) temp
from c_tpd_cnt_carr_lc a,c_carrier b
where a.int_id=b.int_id and a.scan_start_time=v_date and b.vendor_id=10
group by b.city_id ,b.related_bts) a,c_cell b,c_tpd_sts_bts c,c_erl d
where a.int_id=c.int_id and b.related_bts=a.int_id
and  c.scan_start_time=v_date and b.vendor_id=10 and d.tchnum=c.nbrAvailCe
and 100*a.temp/(decode(erl02,null,1,0,1,erl02)*360)>75
group by a.city_id
) b,
(
select a.city_id,count(distinct b.int_id) BusyCellNum
from
(
select b.city_id ,b.related_bts int_id,sum(nvl(a.c006,0)+ nvl(a.c011,0)+nvl(a.c012,0) + nvl(a.c276,0) + nvl(a.c278,0)) temp
from c_tpd_cnt_carr_lc a,c_carrier b
where a.int_id=b.int_id and a.scan_start_time=v_date and b.vendor_id=10
group by b.city_id ,b.related_bts) a,c_cell b,c_tpd_sts_bts c,c_erl d
where a.int_id=c.int_id and b.related_bts=a.int_id
and  c.scan_start_time=v_date and b.vendor_id=10 and d.tchnum=c.nbrAvailCe
and 100*a.temp/(decode(erl02,null,1,0,1,erl02)*360)<75
and 100*a.temp/(decode(erl02,null,1,0,1,erl02)*360)>60
group by a.city_id
) c,
(
select a.city_id,count(distinct b.int_id) FreeCellNum
from
(
select b.city_id ,b.related_bts int_id,
sum(nvl(a.c006,0)+ nvl(a.c011,0)+nvl(a.c012,0) + nvl(a.c276,0) + nvl(a.c278,0)) temp
from c_tpd_cnt_carr_lc a,c_carrier b
where a.int_id=b.int_id and a.scan_start_time=v_date and b.vendor_id=10
group by b.city_id ,b.related_bts) a,c_cell b,c_tpd_sts_bts c,c_erl d
where a.int_id=c.int_id and b.related_bts=a.int_id
and  c.scan_start_time=v_date and b.vendor_id=10 and d.tchnum=c.nbrAvailCe
and 100*a.temp/(decode(erl02,null,1,0,1,erl02)*360)<10
group by a.city_id
)d
where a.city_id=b.city_id(+) and a.city_id=c.city_id(+) and a.city_id=d.city_id(+);
commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');



 insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
OnecarrierCellNum,
TwocarrierCellNum,
threecarrierCellNum,
FourcarrierCellNum
)
select a.city_id,
v_date,
0,
10004,
10,count(distinct a.OnecarrierCellNum),
count(distinct a.TwocarrierCellNum) TwocarrierCellNum,
count(distinct a.threecarrierCellNum),
count(distinct a.FourcarrierCellNum)
from
(select city_id ,
case when count(distinct cdma_freq)=1 then max(distinct related_cell) end  OnecarrierCellNum,
case when count(distinct cdma_freq)=2 then max(distinct related_cell) end  TwocarrierCellNum,
case when count(distinct cdma_freq)=3 then max(distinct related_cell) end  threecarrierCellNum,
case when count(distinct cdma_freq)=4 then max(distinct related_cell) end  FourcarrierCellNum
from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=10
group by city_id,related_cell  ) a
where city_id is not null
group by a.city_id;

commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');


insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CENum,
TCHNum,
Wirecapacity
)
with temp1 as (
select
c.int_id,
round(c.Channel_nbr) CENum,
round(a.l2/360) TCHNum
from C_tpd_cnt_bts_lc a, c_bts c
where a.int_id = c.int_id and a.scan_start_time = v_date
and c.vendor_id=10)
select
c_bts.city_id,
v_date,
0,
10004,
10,
sum(temp1.cenum) cenum,
sum(temp1.tchnum) tchnum,
sum(c_erl.erl02) Wirecapacity
from temp1,c_erl,c_bts
where temp1.TCHNum=c_erl.TCHNum and temp1.int_id=c_bts.int_id and c_bts.city_id is not null
group by c_bts.city_id;
commit;
 dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TrafficCarrier1,
TrafficCarrier2,
TrafficCarrier3,
TrafficCarrier4)
select
city_id,
v_date,
0,
10004,
10,
round(nvl(sum(case when cdma_freq=283 then
          round(nvl(a.c006,0)+ nvl(a.c085,0))/360 + (2*nvl(a.L038,0)
          +4*nvl(a.L039,0) + 8*nvl(a.L040,0) + 16*nvl(a.L041,0) +nvl(a.L076,0)
          +2*nvl(a.L077,0) + 4*nvl(a.L078,0) +8*nvl(a.L079,0))/500/360 + (nvl(a.L043,0)
          + 2*nvl(a.L044,0) + 4*nvl(a.L045,0) + 8*nvl(a.L046,0))/500/360  end),0),4) TrafficCarrier1,
round(nvl(sum(case when cdma_freq=201 then
          round( nvl(a.c006,0)+ nvl(a.c085,0))/360 + (2*nvl(a.L038,0) +4*nvl(a.L039,0) + 8*nvl(a.L040,0)
          + 16*nvl(a.L041,0) +nvl(a.L076,0) +2*nvl(a.L077,0) + 4*nvl(a.L078,0) +8*nvl(a.L079,0))/500/360 +
        (nvl(a.L043,0) + 2*nvl(a.L044,0) + 4*nvl(a.L045,0) + 8*nvl(a.L046,0))/500/360   end),0),4) TrafficCarrier2,
round(nvl(sum(case when cdma_freq=242 then
        (nvl(a.c006,0)+ nvl(a.c085,0))/360 + (2*nvl(a.L038,0) +4*nvl(a.L039,0) + 8*nvl(a.L040,0) + 16*nvl(a.L041,0) +nvl(a.L076,0) +2*nvl(a.L077,0)
         + 4*nvl(a.L078,0) +8*nvl(a.L079,0))/500/360 +(nvl(a.L043,0) + 2*nvl(a.L044,0) + 4*nvl(a.L045,0) + 8*nvl(a.L046,0))/500/360 end ),0),4)TrafficCarrier3,
         round(nvl(sum(case when  cdma_freq=160  then
      round((nvl(a.c006,0)+ nvl(a.c085,0))/360 + (2*nvl(a.L038,0) +4*nvl(a.L039,0) + 8*nvl(a.L040,0) +
      16*nvl(a.L041,0) +nvl(a.L076,0) +2*nvl(a.L077,0) + 4*nvl(a.L078,0) +8*nvl(a.L079,0))/500/360 +
    (nvl(a.L043,0) + 2*nvl(a.L044,0) + 4*nvl(a.L045,0) + 8*nvl(a.L046,0))/500/360,4) end),0),4)  TrafficCarrier4

from C_tpd_cnt_carr_lc a,c_carrier c
where a.int_id=c.int_id and c.vendor_id=10 and city_id is not null
and a.scan_start_time= v_date
group by city_id;


commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');


insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
cs_CallBlockFailNum,
TCHBlockFailRate,
AvgRadioFPeriod,
CEAvailNum,
TCHBlockFailNumIncludeHo,
SeriOverflowBtsNum,
OverflowBtsNum
)
select
r.city_id,
v_date,
0,
10004,
10,
sum(t.cs007+t.cs008+ t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 +t.c031 + t.c033 + t.c034 + t.c035 + t.c036) cs_CallBlockFailNum,
round(sum(t.cs007+t.cs008+ t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 +t.c031 + t.c033 + t.c034 + t.c035 + t.c036)/decode(sum(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106),0,1,null,1,
sum(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106))*100,4)  TCHBlockFailRate,
sum(t.l1)/360*60/decode(sum(t.sc017+t.sc018+t.sc040+t.sc041),0,1,null,1,sum(t.sc017+t.sc018+t.sc040+t.sc041)) AvgRadioFPeriod,
sum(t.l1/360) CEAvailNum,
--update-8-25
sum(t.cs007+t.cs008+ t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 + t.c031 + t.c033 + t.c034 + t.c035 + t.c036) TCHBlockFailNumIncludeHo,
sum(case when (t.cs007+t.cs008+t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029
+ t.c031 + t.c033 + t.c034 + t.c035 + t.c036)/
decode((t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110
+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106),0,1,null,1,(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110
+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106))*100 >=3 then 1 else 0 end)  SeriOverflowBtsNum,
sum(case when (t.cs007+t.cs008+t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 + t.c031 + t.c033
+ t.c034 + t.c035 + t.c036)/
decode((t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108
+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106),0,1,null,1,(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108
+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106))*100 >=1
and (t.cs007+t.cs008+t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 + t.c031 + t.c033 + t.c034
 + t.c035 + t.c036)/
decode((t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108
 +t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106),0,1,null,1,(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108
 +t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106))*100 <3 then 1 else 0 end) OverflowBtsNum
from
(select
t1.related_msc related_msc,
t1.city_id city_id,
t1.l1     l1,
t1.cs007  cs007,
t1.cs008  cs008,
t1.a70    a70,
t2.esc24  esc24,
t2.esc25  esc25,
t2.esc26  esc26,
t2.esc27  esc27,
t2.esc28  esc28,
t2.esc29  esc29,
t2.esc30  esc30,
t2.esc32  esc32,
t2.esc34  esc34,
t2.esc35  esc35,
t2.esc43  esc43,
t2.esc44  esc44,
t2.esc45  esc45,
t2.esc46  esc46,
t2.ec01   ec01 ,
t2.ec02   ec02 ,
t2.c006   c006 ,
t2.c008   c008 ,
t2.c011   c011 ,
t2.c012   c012 ,
t2.c029   c029 ,
t2.c031   c031 ,
t2.c033   c033 ,
t2.c034   c034 ,
t2.c035   c035 ,
t2.c036   c036 ,
t2.c085   c085 ,
t2.c086   c086 ,
t2.c276 c276,
t2.c278 c278,
t2.sc017  sc017,
t2.sc018  sc018,
t2.sc019  sc019,
t2.sc020  sc020,
t2.sc022  sc022,
t2.sc023  sc023,
t2.sc024  sc024,
t2.sc032  sc032,
t2.sc033  sc033,
t2.sc036  sc036,
t2.sc037  sc037,
t2.sc040  sc040,
t2.sc041  sc041,
t2.sc048  sc048,
t2.sc050  sc050,
t2.sc051  sc051,
t2.sc053  sc053,
t2.sc054  sc054,
t2.sc056  sc056,
t2.sc057  sc057,
t2.sc059  sc059,
t2.sc104  sc104,
t2.sc105  sc105,
t2.sc106  sc106,
t2.sc110  sc110,
t2.sc108  sc108,
t2.sc107  sc107,
t2.sc109  sc109,
t2.sc115  sc115,
t2.sc116  sc116,
t2.sc117  sc117,
t2.sc118  sc118,
t2.sc119  sc119,
t2.sc159  sc159,
t2.sc160  sc160,
t2.sc161  sc161,
t2.sc162  sc162,
t2.sc163  sc163,
t2.sc164  sc164,
t2.sc165  sc165,
t2.sc166  sc166,
t2.sc167  sc167,
t2.sc168  sc168,
t2.c062   c062,
t2.c063   c063,
t2.vo30   vo30,
t2.vo31   vo31,
t2.vo32   vo32,
t2.vo33   vo33,
t2.vo34   vo34,
t2.vo35   vo35,
t2.vo36   vo36,
t2.vo38   vo38,
t2.vo39   vo39,
t2.vo40   vo40,
t1.cnt1+t2.cnt2 cnt
from
(select
t.related_msc related_msc,
t.city_id city_id,
sum(c.l1) l1,
sum(c.cs007) cs007,
sum(c.cs008) cs008,
sum(c.a70) a70,
sum(case when round(c.l1/360) > 2.5
then 1 else 0 end) cnt1
from C_tpd_cnt_bts_lc c,c_bts t
where c.int_id = t.int_id
and c.scan_start_time = v_date
group by t.related_msc,t.city_id) t1,
(select
c.related_msc related_msc,
c.city_id city_id,
sum(a.esc24) esc24,
sum(a.esc25) esc25,
sum(a.esc26) esc26,
sum(a.esc27) esc27,
sum(a.esc28) esc28,
sum(a.esc29) esc29,
sum(a.esc30) esc30,
sum(a.esc32) esc32,
sum(a.esc34) esc34,
sum(a.esc35) esc35,
sum(a.esc43) esc43,
sum(a.esc44) esc44,
sum(a.esc45) esc45,
sum(a.esc46) esc46,
sum(a.ec01)  ec01,
sum(a.ec02)  ec02,
sum(a.c006)  c006,
sum(a.c008)  c008,
sum(a.c011)  c011,
sum(a.c012)  c012,
sum(a.c029)  c029,
sum(a.c031)  c031,
sum(a.c033)  c033,
sum(a.c034)  c034,
sum(a.c035)  c035,
sum(a.c036)  c036,
sum(a.c085)  c085,
sum(a.c086)  c086,
sum(a.c276) c276,
sum(a.c278) c278,
sum(a.sc017) sc017,
sum(a.sc018) sc018,
sum(a.sc019) sc019,
sum(a.sc020) sc020,
sum(a.sc022) sc022,
sum(a.sc023) sc023,
sum(a.sc024) sc024,
sum(a.sc032) sc032,
sum(a.sc033) sc033,
sum(a.sc036) sc036,
sum(a.sc037) sc037,
sum(a.sc040) sc040,
sum(a.sc041) sc041,
sum(a.sc048) sc048,
sum(a.sc050) sc050,
sum(a.sc051) sc051,
sum(a.sc053) sc053,
sum(a.sc054) sc054,
sum(a.sc056) sc056,
sum(a.sc057) sc057,
sum(a.sc059) sc059,
sum(a.sc104) sc104,
sum(a.sc105) sc105,
sum(a.sc106) sc106,
sum(a.sc110) sc110,
sum(a.sc108) sc108,
sum(a.sc107) sc107,
sum(a.sc109) sc109,
sum(a.sc115) sc115,
sum(a.sc116) sc116,
sum(a.sc117) sc117,
sum(a.sc118) sc118,
sum(a.sc119) sc119,
sum(a.sc159) sc159,
sum(a.sc160) sc160,
sum(a.sc161) sc161,
sum(a.sc162) sc162,
sum(a.sc163) sc163,
sum(a.sc164) sc164,
sum(a.sc165) sc165,
sum(a.sc166) sc166,
sum(a.sc167) sc167,
sum(a.sc168) sc168,
sum(a.c062) c062,
sum(a.c063) c063,
sum(a.vo30) vo30,
sum(a.vo31) vo31,
sum(a.vo32) vo32,
sum(a.vo33) vo33,
sum(a.vo34) vo34,
sum(a.vo35) vo35,
sum(a.vo36) vo36,
sum(a.vo38) vo38,
sum(a.vo39) vo39,
sum(a.vo40) vo40,
sum(case when a.sc017+a.sc018+a.sc040+a.sc041 >= 3
then 1 else 0 end
+
case when a.sc017+a.sc018
+a.sc040+a.sc041/
decode((a.vo30-a.vo38
+a.vo31-a.vo39
+a.vo32-a.vo40
+a.sc104-a.sc115
+a.sc105-a.sc116
+a.sc106-a.sc117
+a.sc023-a.sc048
+a.sc050-a.esc28
-a.sc118-a.esc34
-a.esc43-a.sc159
-a.sc160-a.sc194
-a.sc196+a.sc024
-a.sc051+a.sc053
-a.esc45-a.sc163
-a.sc164-a.sc167
-a.esc30+a.sc036
-a.sc054+a.sc056
-a.esc29-a.sc119
-a.esc35-a.esc44
-a.sc161-a.sc162
-a.sc195-a.sc197
+a.sc037-a.sc057
+a.sc059-a.esc46
-a.sc165-a.sc166
-a.sc168-a.esc32
+a.c062+a.c063),0,1,null,1,(a.vo30-a.vo38
+a.vo31-a.vo39
+a.vo32-a.vo40
+a.sc104-a.sc115
+a.sc105-a.sc116
+a.sc106-a.sc117
+a.sc023-a.sc048
+a.sc050-a.esc28
-a.sc118-a.esc34
-a.esc43-a.sc159
-a.sc160-a.sc194
-a.sc196+a.sc024
-a.sc051+a.sc053
-a.esc45-a.sc163
-a.sc164-a.sc167
-a.esc30+a.sc036
-a.sc054+a.sc056
-a.esc29-a.sc119
-a.esc35-a.esc44
-a.sc161-a.sc162
-a.sc195-a.sc197
+a.sc037-a.sc057
+a.sc059-a.esc46
-a.sc165-a.sc166
-a.sc168-a.esc32
+a.c062+a.c063))*100 > 2.5
then 1 else 0 end) cnt2
from C_tpd_cnt_carr_lc a,c_carrier c
where a.int_id = c.int_id
and a.scan_start_time = v_date
group by c.related_msc,c.city_id  ) t2,
(select count(*) cnt_cell from c_cell where do_cell=0) cc
where t1.related_msc = t2.related_msc and t1.city_id is not null) t,c_region_city r
where t.city_id=r.city_id
group by r.city_id;

commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');



-------------------------------------------------------------------------------------------------------10004--end
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
cs_SSHOTraffic,
cs_TrafficIncludeHo         ,
ps_CallTrafficIncludeHo     ,
ps_CallTrafficExcludeHo     ,
LoseCallingNum              ,
cs_LoseCallingNum           ,
cs_TchReqNumIncludeHo       ,
cs_TchSuccNumIncludeHo      ,
cs_TchSuccIncludeHoRate     ,
cs_HardhoReqNum             ,
cs_HardhoSuccNum            ,
cs_HardhoSuccRate           ,
cs_SofthoReqNum             ,
cs_SofthoSuccNum            ,
cs_SofthoSuccRate           ,
cs_SSofthoReqNum            ,
cs_SSofthoSuccNum           ,
cs_SSofthoSuccRate          ,
TchReqNumCallerExcludeHoSms ,
TchSuccNumCallerExcludeHoSms,
TchReqNumCalleeExcludeHoSms ,
TchSuccNumCalleeExcludeHoSms,
TchReqNumExcludeHoSms       ,
TchSuccNumExcludeHoSms      ,
TchReqNumIncludeHoSms       ,
TchSuccNumIncludeHoSms      ,
BtsSysHardHoReqNum          ,
BtsSysHardHoSuccNum         ,
SysSHoReqNum                ,
SysSHoSuccNum               ,
TCHRadioFNum                ,
CallPageReqTotalNum         ,
HardhoReqNum_intra          ,
HardhoSuccNum_intra         ,
HardhoSuccRate_intra        ,
ShoReqNum_intra             ,
ShoSuccNum_intra            ,
ShoSuccRate_intra           ,
HardhoReqNum_Extra          ,
HardhoSuccNum_Extra         ,
HardhoSuccRate_Extra        ,
ShoReqNum_Extra             ,
ShoSuccNum_Extra            ,
ShoSuccRate_Extra           ,
FdwTxTotalFrameExcludeRx    ,
RLPFwdChSizeExcludeRx       ,
RLPFwdChRxSize              ,
FwdChRxRate                 ,
RevTxTotalFrameExcludeRx    ,
RLPRevChSize                ,
RevChRxRate                 ,
BtsSysHardHoSuccRate        ,
SysSHoSuccRate              ,
TchRadioFRate               ,
CallInterruptRate           ,
SShoReqNum_intra            ,
SShoSuccNum_intra           ,
SShoSuccRate_intra          ,
ps_CallPageReqNum,
cs_LoseCallingratio,
carriernum_1x,
cs_SHOTraffic,
cs_TchReqNumHardho,
cs_TchSuccNumHardho,
cs_TchReqNumsoftho,
cs_TchSuccNumsoftho,
cs_CallPageSuccNum,
cs_CallPageReqNum,
TCHLoadTrafficIncludeHo,
TrafficExcludeHo,
cs_TrafficExcludeHo,
TCHLoadTrafficExcludeHo,
ps_TchReqNumHardho ,
ps_TchSuccNumHardho,
ps_TchReqNumsoftho ,
ps_TchSuccNumsoftho,
ps_LoseCallingNum,
ps_HandoffReqNum,
ps_HandoffSuccNum,
ps_HandoffSuccRate,
ps_HardhoReqNum,
ps_HardhoSuccNum,
ps_HardhoSuccRate,
ps_SofthoReqNum,
ps_SofthoSuccNum,
ps_SofthoSuccRate,
ps_SSofthoReqNum,
ps_SSofthoSuccNum,
ps_SSofthoSuccRate,
ps_CallPageSuccNum,
cs_trafficByWalsh,
ps_trafficByWalsh,
LoadTrafficByWalsh,
cs_SHORate,
ps_SHORate,
cs_TchReqNumExcludeHo,
cs_TchSuccNumExcludeHo,
cs_TchFNumExcludeHo,
cs_TchSuccExcludeHoRate,
cs_HandoffReqNum,
cs_HandoffSuccNum,
cs_HandoffSuccRate,
HandoffReqNum_Extra,
HandoffSuccNum_Extra,
HandoffSuccRate_Extra,
ps_SSHOTraffic,
ps_LoseCallingRate,
ps_TchReqNumIncludeHo,
ps_TchSuccNumIncludeHo,
ps_TchFNumIncludeHo,
ps_CallBlockFailNum,
ps_TchSuccIncludeHoRate,
ps_TchReqNumExcludeHo,
ps_TchSuccNumExcludeHo,
ps_TchFNumExcludeHo,
ps_TchSuccExcludeHoRate,
ps_LoseCallingratio,
TchReqNumIncludeHo,
TchReqNumExcludeHo,
TchSuccNumIncludeHo,
TchFNumIncludeHo,
TchSuccIncludeHoRate,
TchSuccNumExcludeHo,
TchFNumExcludeHo,
TchSuccExcludeHoRate,
HandoffReqNum,
HandoffSuccNum,
HandoffSuccRate,
HandoffReqNum_intra,
HandoffSuccNum_intra,
HandoffSuccRate_intra,
cs_CallBlockFailRate,
ChannelNum,
ChannelAvailNum,
ChannelMaxUseNum
)
with a as(
select
c.city_id city_id,
sum(nvl(a.c02,0))  c02,
sum(nvl(a.c05,0))  c05,
sum(nvl(a.escpd29,0)) escpd29,
sum(nvl(a.escpd32,0)) escpd32,
sum(nvl(a.escpd35,0)) escpd35,
sum(nvl(a.escpd44,0)) escpd44,
sum(nvl(a.escpd46,0)) escpd46,
sum(nvl(a.scpd017,0)) scpd017,
sum(nvl(a.scpd018,0)) scpd018,
sum(nvl(a.scpd036,0)) scpd036,
sum(nvl(a.scpd037,0)) scpd037,
sum(nvl(a.scpd040,0)) scpd040,
sum(nvl(a.scpd041,0)) scpd041,
sum(nvl(a.scpd042,0)) scpd042,
sum(nvl(a.scpd043,0)) scpd043,
sum(nvl(a.scpd044,0)) scpd044,
sum(nvl(a.scpd045,0)) scpd045,
sum(nvl(a.scpd046,0)) scpd046,
sum(nvl(a.scpd047,0)) scpd047,
sum(nvl(a.scpd054,0)) scpd054,
sum(nvl(a.scpd056,0)) scpd056,
sum(nvl(a.scpd057,0)) scpd057,
sum(nvl(a.scpd059,0)) scpd059,
sum(nvl(a.scpd104,0)) scpd104,
sum(nvl(a.scpd115,0)) scpd115,
sum(nvl(a.scpd119,0)) scpd119,
sum(nvl(a.scpd161,0)) scpd161,
sum(nvl(a.scpd162,0)) scpd162,
sum(nvl(a.scpd165,0)) scpd165,
sum(nvl(a.scpd166,0)) scpd166,
sum(nvl(a.scpd168,0)) scpd168,
sum(nvl(a.scpd195,0)) scpd195,
sum(nvl(a.scpd197,0)) scpd197,
sum(nvl(a.c006,0)) c006 ,
sum(nvl(a.c008,0)) c008 ,
sum(nvl(a.c011,0)) c011 ,
sum(nvl(a.c012,0)) c012 ,
sum(nvl(a.c062,0)) c062 ,
sum(nvl(a.c063,0)) c063 ,
sum(nvl(a.c085,0)) c085 ,
sum(nvl(a.c086,0)) c086 ,
sum(nvl(a.c152,0)) c152 ,
sum(nvl(a.c153,0)) c153 ,
sum(nvl(a.c264,0)) c264 ,
sum(nvl(a.c276,0)) c276,
sum(nvl(a.c277,0)) c277,
sum(nvl(a.c278,0)) c278,
sum(nvl(a.ec22,0)) ec22 ,
sum(nvl(a.ec23,0)) ec23 ,
sum(nvl(a.esc01,0)) esc01,
sum(nvl(a.esc02,0)) esc02,
sum(nvl(a.esc03,0)) esc03,
sum(nvl(a.esc04,0)) esc04,
sum(nvl(a.esc05,0)) esc05,
sum(nvl(a.esc06,0)) esc06,
sum(nvl(a.esc07,0)) esc07,
sum(nvl(a.esc08,0)) esc08,
sum(nvl(a.esc09,0)) esc09,
sum(nvl(a.esc12,0)) esc12,
sum(nvl(a.esc13,0)) esc13,
sum(nvl(a.esc14,0)) esc14,
sum(nvl(a.esc15,0)) esc15,
sum(nvl(a.esc16,0)) esc16,
sum(nvl(a.esc17,0)) esc17,
sum(nvl(a.esc18,0)) esc18,
sum(nvl(a.esc19,0)) esc19,
sum(nvl(a.esc20,0)) esc20,
sum(nvl(a.esc21,0)) esc21,
sum(nvl(a.esc22,0)) esc22,
sum(nvl(a.esc23,0)) esc23,
sum(nvl(a.esc28,0)) esc28,
sum(nvl(a.esc29,0)) esc29,
sum(nvl(a.esc30,0)) esc30,
sum(nvl(a.esc32,0)) esc32,
sum(nvl(a.esc34,0)) esc34,
sum(nvl(a.esc35,0)) esc35,
sum(nvl(a.esc43,0)) esc43,
sum(nvl(a.esc44,0)) esc44,
sum(nvl(a.esc45,0)) esc45,
sum(nvl(a.esc46,0)) esc46,
sum(nvl(a.L037,0)) L037 ,
sum(nvl(a.L038,0)) L038 ,
sum(nvl(a.L039,0)) L039 ,
sum(nvl(a.L040,0)) L040 ,
sum(nvl(a.L041,0)) L041 ,
sum(nvl(a.L042,0)) L042 ,
sum(nvl(a.L043,0)) L043 ,
sum(nvl(a.L044,0)) L044 ,
sum(nvl(a.L045,0)) L045 ,
sum(nvl(a.L046,0)) L046 ,
sum(nvl(a.L076,0)) L076 ,
sum(nvl(a.L077,0)) L077 ,
sum(nvl(a.L078,0)) L078 ,
sum(nvl(a.L079,0)) L079 ,
sum(nvl(a.L097,0)) L097 ,
sum(nvl(a.L098,0)) L098 ,
sum(nvl(a.L099,0)) L099 ,
sum(nvl(a.sc015,0)) sc015,
sum(nvl(a.sc016,0)) sc016,
sum(nvl(a.sc017,0)) sc017,
sum(nvl(a.sc018,0)) sc018,
sum(nvl(a.sc019,0)) sc019,
sum(nvl(a.sc020,0)) sc020,
sum(nvl(a.sc021,0)) sc021,
sum(nvl(a.sc022,0)) sc022,
sum(nvl(a.sc023,0)) sc023,
sum(nvl(a.sc024,0)) sc024,
sum(nvl(a.sc032,0)) sc032,
sum(nvl(a.sc033,0)) sc033,
sum(nvl(a.sc036,0)) sc036,
sum(nvl(a.sc037,0)) sc037,
sum(nvl(a.sc038,0)) sc038,
sum(nvl(a.sc039,0)) sc039,
sum(nvl(a.sc040,0)) sc040,
sum(nvl(a.sc041,0)) sc041,
sum(nvl(a.sc042,0)) sc042,
sum(nvl(a.sc043,0)) sc043,
sum(nvl(a.sc044,0)) sc044,
sum(nvl(a.sc045,0)) sc045,
sum(nvl(a.sc046,0)) sc046,
sum(nvl(a.sc047,0)) sc047,
sum(nvl(a.sc048,0)) sc048,
sum(nvl(a.sc050,0)) sc050,
sum(nvl(a.sc051,0)) sc051,
sum(nvl(a.sc053,0)) sc053,
sum(nvl(a.sc054,0)) sc054,
sum(nvl(a.sc056,0)) sc056,
sum(nvl(a.sc057,0)) sc057,
sum(nvl(a.sc059,0)) sc059,
sum(nvl(a.sc068,0)) sc068,
sum(nvl(a.sc069,0)) sc069,
sum(nvl(a.sc070,0)) sc070,
sum(nvl(a.sc071,0)) sc071,
sum(nvl(a.sc104,0)) sc104,
sum(nvl(a.sc105,0)) sc105,
sum(nvl(a.sc106,0)) sc106,
sum(nvl(a.sc107,0)) sc107,
sum(nvl(a.sc108,0)) sc108,
sum(nvl(a.sc109,0)) sc109,
sum(nvl(a.sc110,0)) sc110,
sum(nvl(a.sc111,0)) sc111,
sum(nvl(a.sc112,0)) sc112,
sum(nvl(a.sc113,0)) sc113,
sum(nvl(a.sc114,0)) sc114,
sum(nvl(a.sc115,0)) sc115,
sum(nvl(a.sc116,0)) sc116,
sum(nvl(a.sc117,0)) sc117,
sum(nvl(a.sc118,0)) sc118,
sum(nvl(a.sc119,0)) sc119,
sum(nvl(a.sc159,0)) sc159,
sum(nvl(a.sc160,0)) sc160,
sum(nvl(a.sc161,0)) sc161,
sum(nvl(a.sc162,0)) sc162,
sum(nvl(a.sc163,0)) sc163,
sum(nvl(a.sc164,0)) sc164,
sum(nvl(a.sc165,0)) sc165,
sum(nvl(a.sc166,0)) sc166,
sum(nvl(a.sc167,0)) sc167,
sum(nvl(a.sc168,0)) sc168,
sum(nvl(a.sc195,0)) sc195,
sum(nvl(a.sc197,0)) sc197,
sum(nvl(a.vo13,0)) vo13 ,
sum(nvl(a.vo16,0)) vo16 ,
sum(nvl(a.vo20,0)) vo20 ,
sum(nvl(a.vo30,0)) vo30 ,
sum(nvl(a.vo31,0)) vo31 ,
sum(nvl(a.vo32,0)) vo32 ,
sum(nvl(a.vo33,0)) vo33 ,
sum(nvl(a.vo34,0)) vo34 ,
sum(nvl(a.vo35,0)) vo35 ,
sum(nvl(a.vo36,0)) vo36 ,
sum(nvl(a.vo37,0)) vo37 ,
sum(nvl(a.vo38,0)) vo38 ,
sum(nvl(a.vo39,0)) vo39 ,
sum(nvl(a.vo40,0)) vo40,
sum(nvl(a.c02,0)+nvl(a.c05,0))/360  cs_trafficByWalsh,
sum(a.c04)*10/3600    ps_trafficByWalsh,
sum(nvl(a.c02,0)+nvl(a.c05,0))/360  LoadTrafficByWalsh,
sum(nvl(c04,0)) v1
from C_TPD_1X_SUM_LC_TEMP a,c_cell c
where  a.unique_rdn = c.unique_rdn and a.scan_start_time = v_date and a.vendor_id=10 and c.city_id is not null
group by c.city_id),
b as(
select
c.city_id  city_id,
sum(nvl(a.c006,0))  c006,
sum(nvl(a.c276,0))  c276,
sum(nvl(a.c278,0))  c278,
count(distinct c.int_id) CARRIERNUM_1X,
sum(nvl(c008,0)+nvl(c277,0)+nvl(c279,0))/360 cs_SHOTraffic,
sum(nvl(vo34,0)+nvl(vo36,0)+nvl(vo33,0)+nvl(vo35,0)+nvl(sc110,0)+nvl(sc108,0)+nvl(sc107,0)+nvl(sc109,0)) cs_TchReqNumHardho,
sum(nvl(vo16,0)+nvl(vo20,0)+nvl(vo13,0)+nvl(vo37,0)+nvl(sc112,0)+nvl(sc114,0) +nvl(sc111,0)+nvl(sc113,0)) cs_TchSuccNumHardho,
sum(nvl(vo30,0)+nvl(vo31,0)+nvl(vo32,0)+nvl(sc104,0)+nvl(sc105,0)+nvl(sc106,0)) cs_TchReqNumsoftho,
sum(nvl(vo31,0)-nvl(vo39,0) +nvl(vo32,0)-nvl(vo40,0) + nvl(sc105,0)-nvl(sc116,0)+nvl(sc106,0)-nvl(sc117,0)) cs_TchSuccNumsoftho,
-----------------
sum(
(case when
(nvl(sc019,0)-nvl(esc03,0)-nvl(esc01,0)-nvl(esc05,0)+nvl(esc13,0)-nvl(sc015,0)-nvl(sc160,0))>0 then
(nvl(sc019,0)-nvl(esc03,0)-nvl(esc01,0)-nvl(esc05,0)+nvl(esc13,0)-nvl(sc015,0)-nvl(sc160,0)) else 0 end)
+
(case when
(nvl(sc020,0)-nvl(esc04,0)-nvl(esc02,0)-nvl(esc06,0)-nvl(esc12,0)-nvl(sc016,0)-nvl(esc07,0)-nvl(esc08,0)-nvl(esc09,0)-nvl(sc164,0))>0 then
(nvl(sc020,0)-nvl(esc04,0)-nvl(esc02,0)-nvl(esc06,0)-nvl(esc12,0)-nvl(sc016,0)-nvl(esc07,0)-nvl(esc08,0)-nvl(esc09,0)-nvl(sc164,0)) else 0 end)
+
(case when
(nvl(sc032,0)-nvl(esc14,0)-nvl(esc16,0)-nvl(esc18,0)-nvl(sc038,0)-nvl(sc162,0))>0 then
(nvl(sc032,0)-nvl(esc14,0)-nvl(esc16,0)-nvl(esc18,0)-nvl(sc038,0)-nvl(sc162,0))  else 0 end)
+
(case when
(nvl(sc033,0)-nvl(esc15,0)-nvl(esc17,0)-nvl(esc19,0)-nvl(esc20,0)-nvl(sc039,0)-nvl(esc21,0)-nvl(esc22,0)-nvl(esc23,0)-nvl(sc166,0))>0 then
(nvl(sc033,0)-nvl(esc15,0)-nvl(esc17,0)-nvl(esc19,0)-nvl(esc20,0)-nvl(sc039,0)-nvl(esc21,0)-nvl(esc22,0)-nvl(esc23,0)-nvl(sc166,0)) else 0 end )
) cs_CallPageSuccNum,
sum(
(case when
(nvl(sc023 ,0)-nvl(sc048 ,0)+nvl(sc050 ,0)+ nvl(sc042,0) +nvl(sc044 ,0)+nvl(sc046 ,0)-nvl(esc28 ,0)-nvl(sc118 ,0)-nvl(esc34 ,0)-nvl(esc43 ,0)-nvl(sc159 ,0)-nvl(sc160 ,0)-nvl(sc194 ,0)-nvl(sc196 ,0))>0 then
(nvl(sc023 ,0)-nvl(sc048 ,0)+nvl(sc050 ,0)+ nvl(sc042,0) +nvl(sc044 ,0)+nvl(sc046 ,0)-nvl(esc28 ,0)-nvl(sc118 ,0)-nvl(esc34 ,0)-nvl(esc43 ,0)-nvl(sc159 ,0)-nvl(sc160 ,0)-nvl(sc194 ,0)-nvl(sc196 ,0)) else 0 end)
+
(case when
(nvl(sc024 ,0)-nvl(sc051,0)+ nvl(sc053 ,0)+ nvl(sc043 ,0)+ nvl(sc045 ,0)+ nvl(sc047 ,0)- nvl(esc45 ,0)- nvl(sc163 ,0)- nvl(sc164 ,0)-nvl(sc167 ,0)-nvl(esc30 ,0))>0 then
(nvl(sc024 ,0)-nvl(sc051,0)+ nvl(sc053 ,0)+ nvl(sc043 ,0)+ nvl(sc045 ,0)+ nvl(sc047 ,0)- nvl(esc45 ,0)- nvl(sc163 ,0)- nvl(sc164 ,0)-nvl(sc167 ,0)-nvl(esc30 ,0)) else 0 end)
+
(case when
(nvl(sc037,0)-nvl(sc057,0)+nvl(sc059,0)-nvl(sc043,0)-nvl(sc045,0)-nvl(sc047,0)-nvl(esc46,0)-nvl(sc165,0)-nvl(sc166,0)-nvl(sc168,0)-nvl(esc32,0))>0 then
(nvl(sc037,0)-nvl(sc057,0)+nvl(sc059,0)-nvl(sc043,0)-nvl(sc045,0)-nvl(sc047,0)-nvl(esc46,0)-nvl(sc165,0)-nvl(sc166,0)-nvl(sc168,0)-nvl(esc32,0)) else 0 end)
+
(case when
(nvl(sc036,0)-nvl(sc054,0)+nvl(sc056,0)-nvl(sc042,0)- nvl(sc044,0)-nvl(sc046,0)-nvl(esc29,0)-nvl(sc119,0)-nvl(esc35,0)-nvl(esc44,0)-nvl(sc161,0)-nvl(sc162,0)-nvl(sc195,0)-nvl(sc197,0))>0 then
(nvl(sc036,0)-nvl(sc054,0)+nvl(sc056,0)-nvl(sc042,0)- nvl(sc044,0)-nvl(sc046,0)-nvl(esc29,0)-nvl(sc119,0)-nvl(esc35,0)-nvl(esc44,0)-nvl(sc161,0)-nvl(sc162,0)-nvl(sc195,0)-nvl(sc197,0)) else 0 end)
)  cs_CallPageReqNum,
round(sum(nvl(a.c006,0) + nvl(a.c011,0)+nvl(a.c012,0)+nvl(a.c276,0) + nvl(a.c278,0))/360,4) TCHLoadTrafficIncludeHo,
sum(nvl(a.c006,0)-nvl(a.c008,0)+nvl(a.c011,0)-nvl(a.c013,0)+nvl(a.c012,0)-nvl(a.c014,0) +nvl(a.c276,0)-nvl(a.c277,0)
+nvl(a.c278,0)-nvl(a.c279,0)+nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360 TrafficExcludeHo ,
sum(nvl(a.c006,0)-nvl(a.c008,0) +nvl(a.c011,0)-nvl(a.c013,0) +nvl(a.c012,0)
-nvl(a.c014,0) +nvl(a.c276,0)-nvl(a.c277,0) +nvl(a.c278,0)-nvl(a.c279,0))/360  cs_TrafficExcludeHo,
sum(nvl(a.c006,0)-nvl(a.c008,0)+nvl(a.c011,0)- nvl(a.c013,0) + nvl(a.c012,0)-nvl(a.c014,0)+nvl(a.c276,0)-nvl(a.c277,0)+nvl(a.c278,0)-nvl(a.c279,0))/360 TCHLoadTrafficExcludeHo,
sum(nvl(scpd107,0)+nvl(scpd108,0)+nvl(scpd109,0)+nvl(scpd110,0)) ps_TchReqNumHardho,
sum(nvl(scpd111,0)+nvl(scpd112,0)+nvl(scpd113,0)+nvl(scpd114,0)) ps_TchSuccNumHardho,
sum(nvl(scpd104,0)+nvl(scpd105,0)+nvl(scpd106,0)) ps_TchReqNumsoftho,
sum(nvl(scpd104,0)-nvl(scpd115,0)+nvl(scpd105,0)-nvl(scpd116,0)+nvl(scpd106,0)-nvl(scpd117,0)) ps_TchSuccNumsoftho,
sum(nvl(a.scpd017,0) + nvl(a.scpd018,0) + nvl(a.scpd040,0) + nvl(a.scpd041,0)) ps_LoseCallingNum ,
sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0) + nvl(a.scpd105,0) + nvl(a.scpd106,0) + nvl(a.scpd104,0)) ps_HandoffReqNum  ,
sum(nvl(a.scpd105,0) - nvl(a.scpd116,0) + nvl(a.scpd106,0) - nvl(a.scpd117,0) + nvl(a.scpd104,0) - nvl(a.scpd115,0) + nvl(a.scpd111,0) + nvl(a.scpd112,0) + nvl(a.scpd113,0) + nvl(a.scpd114,0)) ps_HandoffSuccNum ,
round(sum(nvl(a.scpd105,0) - nvl(a.scpd116,0) + nvl(a.scpd106,0) - nvl(a.scpd117,0) + nvl(a.scpd104,0) - nvl(a.scpd115,0) + nvl(a.scpd111,0) + nvl(a.scpd112,0) + nvl(a.scpd113,0) + nvl(a.scpd114,0))/
decode(sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0) + nvl(a.scpd105,0) + nvl(a.scpd106,0) + nvl(a.scpd104,0)),0,1,null,1,sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0) + nvl(a.scpd105,0) + nvl(a.scpd106,0) + nvl(a.scpd104,0)))*100,4) ps_HandoffSuccRate,
sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0)) ps_HardhoReqNum   ,
sum(nvl(a.scpd111,0) + nvl(a.scpd112,0) + nvl(a.scpd113,0) + nvl(a.scpd114,0)) ps_HardhoSuccNum  ,
round(sum(nvl(a.scpd111,0) + nvl(a.scpd112,0) + nvl(a.scpd113,0) + nvl(a.scpd114,0))/decode(sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0)),0,1,null,1,sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0)))*100,4) ps_HardhoSuccRate ,
sum(nvl(a.scpd105,0) + nvl(a.scpd106,0)) ps_SofthoReqNum   ,
sum(nvl(a.scpd105,0) - nvl(a.scpd116,0) + nvl(a.scpd106,0) - nvl(a.scpd117,0)) ps_SofthoSuccNum  ,
round(sum(nvl(a.scpd105,0) - nvl(a.scpd116,0) + nvl(a.scpd106,0) - nvl(a.scpd117,0))/decode(sum(nvl(a.scpd105,0) + nvl(a.scpd106,0)),0,1,null,1,sum(nvl(a.scpd105,0) + nvl(a.scpd106,0)))*100,4) ps_SofthoSuccRate ,
sum(nvl(a.scpd104,0)) ps_SSofthoReqNum  ,
sum(nvl(a.scpd104,0)- nvl(a.scpd115,0)) ps_SSofthoSuccNum ,
round(sum(nvl(a.scpd104,0)- nvl(a.scpd115,0))/decode(sum(a.scpd104),0,1,null,1,sum(a.scpd104))*100,4)   ps_SSofthoSuccRate,
sum(
case when(nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)) > 0
then nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0) else 0 end)
+
sum(
case when(nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) > 0
then nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0) else 0 end) ps_CallPageSuccNum,
sum(nvl(a.c008,0)
+nvl(a.c277,0)
+nvl(a.c279,0)) cs_SHORate_up,
sum(nvl(a.c006,0)
-nvl(a.c008,0)
+nvl(a.c011,0)
-nvl(a.c013,0)
+nvl(a.c012,0)
-nvl(a.c014,0)
+nvl(a.c276,0)
-nvl(a.c277,0)
+nvl(a.c278,0)
-nvl(a.c279,0)
+nvl(a.c008,0)
+nvl(a.c277,0)
+nvl(a.c279,0)) cs_SHORate_down,
sum(nvl(a.c085,0)-nvl(a.c276,0) - nvl(a.c085,0)+nvl(a.c086,0) + nvl(a.c276,0)-nvl(a.c277,0)) ps_SHORate_up,
sum(nvl(a.c085,0)-nvl(a.c276,0)) ps_SHORate_down,
sum(nvl(a.sc017,0)+nvl(a.sc018,0)
+nvl(a.sc040,0)+nvl(a.sc041,0)) cs_LoseCallingRate_up,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) cs_LoseCallingRate_down,
60*sum(nvl(a.c006,0)
-nvl(a.c008,0)
+nvl(a.c011,0)
-nvl(a.c013,0)
+nvl(a.c012,0)
-nvl(a.c014,0)
+nvl(a.c276,0)
-nvl(a.c277,0)
+nvl(a.c278,0)
-nvl(a.c279,0))/360 cs_LoseCallingratio_up,
sum(nvl(a.sc017,0)
+nvl(a.sc018,0)
+nvl(a.sc040,0)
+nvl(a.sc041,0)) cs_LoseCallingratio_down,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) cs_TchReqNumExcludeHo,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) cs_TchSuccNumExcludeHo,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) cs_TchFNumExcludeHo_a1,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) cs_TchFNumExcludeHo_a2,
sum(nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)
+nvl(a.vo30 ,0)
+nvl(a.sc104,0)) cs_HandoffReqNum,
sum(nvl(a.vo16,0)
+nvl(a.vo20 ,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)
+nvl(a.vo30 ,0)
-nvl(a.vo38 ,0)
+nvl(a.sc104,0)
-nvl(a.sc115,0)) cs_HandoffSuccNum,
sum(nvl(a.vo34,0)
+nvl(a.vo36 ,0)
+nvl(a.sc108,0)
+nvl(a.sc110,0)
+nvl(a.vo32 ,0)
+nvl(a.sc106,0)) HandoffReqNum_Extra,
sum(nvl(a.vo16,0)
+nvl(a.vo20 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)) HandoffSuccNum_Extra,
sum(nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360 v2,
sum(nvl(a.scpd017,0)
+nvl(a.scpd018,0)
+nvl(a.scpd040,0)
+nvl(a.scpd041,0)) ps_LoseCallingRate_up,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) ps_LoseCallingRate_down,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) ps_TchReqNumIncludeHo,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) ps_TchSuccNumIncludeHo,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) ps_TchFNumIncludeHo_b1,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) ps_TchFNumIncludeHo_b2,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)) ps_TchReqNumExcludeHo,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) ps_TchSuccNumExcludeHo,
60*sum(nvl(a.c006,0)
-nvl(a.c008,0)
+nvl(a.c011,0)
-nvl(a.c013,0)
+nvl(a.c012,0)
-nvl(a.c014,0)
+nvl(a.c276,0)
-nvl(a.c277,0)
+nvl(a.c278,0)
-nvl(a.c279,0)
+nvl(a.c085,0)
-nvl(a.c086,0)
-nvl(a.c276,0)
+nvl(a.c277,0))/360 LoseCallingratio_up,
sum(nvl(a.sc017,0)
+nvl(a.sc018,0)
+nvl(a.sc040,0)
+nvl(a.sc041,0)) LoseCallingratio_down_a,
60*sum(nvl(a.c085,0)
-nvl(a.c086,0)
-nvl(a.c276,0)
+nvl(a.c277,0))/360 ps_LoseCallingratio_up,
sum(nvl(a.sc019,0)
+nvl(a.sc020,0)
+nvl(a.sc032,0)
+nvl(a.sc033,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)
+nvl(a.c062 ,0)
+nvl(a.c063 ,0)
+nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)) TchReqNumIncludeHo_a,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) TchReqNumExcludeHo_a,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)
+nvl(a.c152 ,0)
+nvl(a.c153 ,0)
+nvl(a.vo16 ,0)
+nvl(a.vo20 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)) TchSuccNumIncludeHo_a,
sum(nvl(a.sc019,0)
+nvl(a.sc020,0)
+nvl(a.sc032,0)
+nvl(a.sc033,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)
+nvl(a.c062 ,0)
+nvl(a.c063 ,0)
+nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)) TchFNumIncludeHo_a1,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)
+nvl(a.c152 ,0)
+nvl(a.c153 ,0)
+nvl(a.vo16 ,0)
+nvl(a.vo20 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)) TchFNumIncludeHo_a2,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)
+nvl(a.c152 ,0)
+nvl(a.c153 ,0)
+nvl(a.vo16 ,0)
+nvl(a.vo20 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)) TchSuccIncludeHoRate_up_a,
sum(nvl(a.sc019,0)
+nvl(a.sc020,0)
+nvl(a.sc032,0)
+nvl(a.sc033,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)
+nvl(a.c062 ,0)
+nvl(a.c063 ,0)
+nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)) TchSuccIncludeHoRate_down_a,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) TchSuccNumExcludeHo_a,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) TchFNumExcludeHo_a1,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) TchFNumExcludeHo_a2,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) TchSuccExcludeHoRate_up_a,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) TchSuccExcludeHoRate_down_a,
sum(nvl(a.vo34,0)
+nvl(a.vo36 ,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)
+nvl(a.vo30 ,0)
+nvl(a.sc104,0)) HandoffReqNum_a,
sum(nvl(a.vo16 ,0)
+nvl(a.vo20 ,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)
+nvl(a.vo30 ,0)
-nvl(a.vo38 ,0)
+nvl(a.sc104,0)
-nvl(a.sc115,0)) HandoffSuccNum_a,
sum(nvl(a.vo33,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.sc105,0)
+nvl(a.vo30 ,0)
+nvl(a.sc104,0))  HandoffReqNum_intra_a,
sum(nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.vo30 ,0)
+nvl(a.sc104,0)) HandoffSuccNum_intra_a,
sum(nvl(a.scpd017,0)
+nvl(a.scpd018,0)
+nvl(a.scpd040,0)
+nvl(a.scpd041,0)) LoseCallingratio_down_b,
sum(nvl(a.scpd017,0)
+nvl(a.scpd018,0)
+nvl(a.scpd040,0)
+nvl(a.scpd041,0)) ps_LoseCallingratio_down,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) TchReqNumIncludeHo_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)) TchReqNumExcludeHo_b,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) TchSuccNumIncludeHo_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) TchFNumIncludeHo_b1,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) TchFNumIncludeHo_b2,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) TchSuccIncludeHoRate_up_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) TchSuccIncludeHoRate_down_b,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) TchSuccNumExcludeHo_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)) TchFNumExcludeHo_b1,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) TchFNumExcludeHo_b2,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) TchSuccExcludeHoRate_up_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)) TchSuccExcludeHoRate_down_b,
sum(nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)
+nvl(a.scpd104,0)) HandoffReqNum_b,
sum(nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)) HandoffSuccNum_b,
sum(nvl(a.scpd104,0)) HandoffReqNum_intra_b,
sum(nvl(a.scpd104,0)) HandoffSuccNum_intra_b,
sum(nvl(a.esc24,0)
+nvl(a.esc25,0)
+nvl(a.esc26,0)
+nvl(a.esc27,0)
+nvl(a.ec01 ,0)
+nvl(a.ec02 ,0)
+nvl(a.c029 ,0)
+nvl(a.c031 ,0)
+nvl(a.c033 ,0)
+nvl(a.c034 ,0)
+nvl(a.c035 ,0)
+nvl(a.c036 ,0))  cs_CallBlockFailRate_up_a,
sum(nvl(a.sc019,0)
+nvl(a.sc020,0)
+nvl(a.sc032,0)
+nvl(a.sc033,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)
+nvl(a.c062 ,0)
+nvl(a.c063 ,0)
+nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)) cs_CallBlockFailRate_down
from C_TPD_1X_SUM_LC_TEMP a,c_carrier c
where  a.int_id = c.int_id
and a.scan_start_time = v_date and a.vendor_id=10 and c.city_id is not null
group by c.city_id
),
c as(
select
c_bts.city_id,
sum(nvl(a.cs007,0)
+nvl(a.cs008,0)
+nvl(a.a70  ,0)) cs_CallBlockFailRate_up_b,
round(sum(l1)) ChannelNum,
round(sum(l1)/360) ChannelAvailNum,
sum(cs004) ChannelMaxUseNum
from C_TPD_1X_SUM_LC_TEMP a,c_bts
where a.int_id = c_bts.int_id and a.scan_start_time = v_date and c_bts.city_id is not null
group by c_bts.city_id
)
select
a.city_id,
v_date,
0,
10004,
10,
(nvl(a.c02,0)+nvl(a.c05,0))/360-(nvl(b.c006,0)+nvl(b.c276,0)+nvl(b.c278,0))/360  cs_SSHOTraffic,
round((nvl(a.c006,0) +nvl(a.c011,0)+nvl(a.c012,0)+ nvl(a.c276,0) + nvl(a.c278,0))/360,4) cs_TrafficIncludeHo,
round((nvl(a.c085,0)-nvl(a.c276,0))/360,4) ps_CallTrafficIncludeHo,
round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4)  ps_CallTrafficExcludeHo,
round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4)+round(nvl(a.scpd017,0)+nvl(a.scpd018,0)+nvl(a.scpd040,0)+nvl(a.scpd041,0),4) LoseCallingNum,
round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4) cs_LoseCallingNum,
round(nvl(a.sc019,0)+nvl(a.sc020,0)+nvl(a.sc032,0)+nvl(a.sc033,0)-nvl(a.sc160,0)-nvl(a.sc162,0)-nvl(a.sc164,0)-nvl(a.sc166,0)+nvl(a.c062,0)+nvl(a.c063,0)+nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc105,0)+nvl(a.sc106,0),4) cs_TchReqNumIncludeHo,
round(nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0)+nvl(a.c152,0)+nvl(a.c153,0)+nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0)+nvl(a.vo31,0)-nvl(a.vo39,0)+nvl(a.vo32,0)-nvl(a.vo40,0)+nvl(a.sc105,0)-nvl(a.sc116,0)+nvl(a.sc106,0)-nvl(a.sc117,0),4) cs_TchSuccNumIncludeHo,
round(100*(nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0)+nvl(a.c152,0)+nvl(a.c153,0)+nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0)+nvl(a.vo31,0)-nvl(a.vo39,0)+nvl(a.vo32,0)-nvl(a.vo40,0)+nvl(a.sc105,0)-nvl(a.sc116,0)+nvl(a.sc106,0)-nvl(a.sc117,0))/
decode(nvl(a.sc019,0)+nvl(a.sc020,0)+nvl(a.sc032,0)+nvl(a.sc033,0)-nvl(a.sc160,0)-nvl(a.sc162,0)-nvl(a.sc164,0)-nvl(a.sc166,0)+nvl(a.c062,0)+nvl(a.c063,0)+nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc105,0)+nvl(a.sc106,0),0,1,null,1,nvl(a.sc019,0)+nvl(a.sc020,0)+nvl(a.sc032,0)+nvl(a.sc033,0)-nvl(a.sc160,0)-nvl(a.sc162,0)-nvl(a.sc164,0)-nvl(a.sc166,0)+nvl(a.c062,0)+nvl(a.c063,0)+nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc105,0)+nvl(a.sc106,0)),4)      cs_TchSuccIncludeHoRate,
round(nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.sc107,0)+nvl(a.sc109,0),4) cs_HardhoReqNum,
round(nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.sc111,0)+nvl(a.sc113,0),4) cs_HardhoSuccNum,
case when  nvl(a.vo34,0) + nvl(a.vo36,0) +nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc110,0) + nvl(a.sc108,0) + nvl(a.sc107,0) + nvl(a.sc109,0) is  null then 100
     when  nvl(a.vo34,0) + nvl(a.vo36,0) +nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc110,0) + nvl(a.sc108,0) + nvl(a.sc107,0) + nvl(a.sc109,0) =  0     then  100
else round(100*(nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.sc111,0)+nvl(a.sc113,0))/decode(
  nvl(a.vo34,0) + nvl(a.vo36,0) +nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc110,0) + nvl(a.sc108,0) + nvl(a.sc107,0) + nvl(a.sc109,0),0,1,nvl(a.vo34,0) + nvl(a.vo36,0) +nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc110,0) + nvl(a.sc108,0) + nvl(a.sc107,0) + nvl(a.sc109,0)),4)
end cs_HardhoSuccRate,
round(nvl(a.vo31,0) + nvl(a.vo32,0) + nvl(a.sc105,0) + nvl(a.sc106,0),4)  cs_SofthoReqNum ,
round(nvl(a.vo31,0) - nvl(a.vo39,0) + nvl(a.vo32 ,0) - nvl(a.vo40 ,0)+ nvl(a.sc105,0)- nvl(a.sc116,0) + nvl(a.sc106,0) - nvl(a.sc117,0),4)  cs_SofthoSuccNum ,
round(100*(nvl(a.vo31,0) - nvl(a.vo39,0) + nvl(a.vo32 ,0) - nvl(a.vo40 ,0)+ nvl(a.sc105,0)- nvl(a.sc116,0) + nvl(a.sc106,0) - nvl(a.sc117,0))/
decode(nvl(a.vo31,0) + nvl(a.vo32,0) + nvl(a.sc105,0) + nvl(a.sc106,0),0,1,null,1,nvl(a.vo31,0) + nvl(a.vo32,0) + nvl(a.sc105,0) + nvl(a.sc106,0)),4) cs_SofthoSuccRate,
round(nvl(a.vo30,0) + nvl(a.sc104,0),4) cs_SSofthoReqNum,
round(nvl(a.vo30,0) - nvl(a.vo38,0) + nvl(a.sc104,0) - nvl(a.sc115,0),4) cs_SSofthoSuccNum,
round(100*(nvl(a.vo30,0) - nvl(a.vo38,0) + nvl(a.sc104,0) - nvl(a.sc115,0))/decode(nvl(a.vo30,0) + nvl(a.sc104,0),0,1,null,1,nvl(a.vo30,0) + nvl(a.sc104,0)),4) cs_SSofthoSuccRate,
round(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0),4) TchReqNumCallerExcludeHoSms  ,
round(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0),4) TchSuccNumCallerExcludeHoSms ,
round(nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0),4) TchReqNumCalleeExcludeHoSms  ,
round(nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0),4) TchSuccNumCalleeExcludeHoSms ,
round(nvl(a.sc019,0) + nvl(a.sc020,0) +nvl(a.sc032,0)+ nvl(a.sc033,0) + nvl(a.c062,0) + nvl(a.c063,0) - nvl(a.sc160,0) - nvl(a.sc162,0) - nvl(a.sc164,0)- nvl(a.sc166,0),4) TchReqNumExcludeHoSms,
round(nvl(a.sc019,0) - nvl(a.esc03,0) -nvl(a.esc01,0)- nvl(a.esc05,0) + nvl(a.esc13,0) - nvl(a.sc015,0) - nvl(a.sc160,0) + nvl(a.sc032,0) - nvl(a.esc14,0) - nvl(a.esc16,0)- nvl(a.esc18,0) - nvl(a.sc038,0) - nvl(a.sc162,0) + nvl(a.sc020,0) - nvl(a.esc04,0) - nvl(a.esc02,0) - nvl(a.esc06,0) - nvl(a.esc12,0) - nvl(a.sc016,0) - nvl(a.esc07,0) - nvl(a.esc08,0) - nvl(a.esc09,0) - nvl(a.sc164,0) + nvl(a.sc033,0) - nvl(a.esc15,0) - nvl(a.esc17,0) - nvl(a.esc19,0) - nvl(a.esc20,0) - nvl(a.sc039,0) - nvl(a.esc21,0) - nvl(a.esc22,0) - nvl(a.esc23,0) - nvl(a.sc166,0) + nvl(a.c152,0) + nvl(a.c153,0),4) TchSuccNumExcludeHoSms       ,
round(nvl(a.sc019,0)+nvl(a.sc020,0)+nvl(a.sc032,0)+nvl(a.sc033,0)-nvl(a.sc160,0)-nvl(a.sc162,0)-nvl(a.sc164,0)-nvl(a.sc166,0)+nvl(a.c062,0)+nvl(a.c063,0)+nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc105,0)+nvl(a.sc106,0),4) TchReqNumIncludeHoSms        ,
round(nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0)+nvl(a.c152,0)+nvl(a.c153,0)+nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0)+nvl(a.vo31,0)-nvl(a.vo39,0)+nvl(a.vo32,0)-nvl(a.vo40,0)+nvl(a.sc105,0)-nvl(a.sc116,0)+nvl(a.sc106,0)-nvl(a.sc117,0),4) TchSuccNumIncludeHoSms,
round(nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0),4) BtsSysHardHoReqNum           ,
round(nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0),4) BtsSysHardHoSuccNum          ,
round(nvl(a.vo30,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc104,0)+nvl(a.sc105,0)+nvl(a.sc106,0),4) SysSHoReqNum                 ,
round(nvl(a.vo30,0)-nvl(a.vo38,0)+nvl(a.vo31,0)-nvl(a.vo39,0)+nvl(a.vo32,0)-nvl(a.vo40,0)+nvl(a.sc104,0)-nvl(a.sc115,0)+nvl(a.sc105,0)-nvl(a.sc116,0)+nvl(a.sc106,0)-nvl(a.sc117,0),4) SysSHoSuccNum,
round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4) TCHRadioFNum                 ,
round((nvl(a.sc023,0)- nvl(a.sc048,0) + nvl(a.sc050,0) - nvl(a.esc28,0) - nvl(a.sc118,0) - nvl(a.esc34,0) - nvl(a.esc43,0) - nvl(a.sc159,0) - nvl(a.sc160,0)) + nvl(a.sc024,0)- nvl(a.sc051,0) + nvl(a.sc053,0) - nvl(a.esc45,0) - nvl(a.sc163,0) - nvl(a.sc164,0) - nvl(a.sc167,0) - nvl(a.esc30,0) + nvl(a.sc036,0) - nvl(a.sc054,0) + nvl(a.sc056,0) -nvl(a.esc29,0) - nvl(a.sc119,0) - nvl(a.esc35,0) - nvl(a.esc44,0) - nvl(a.sc161,0) - nvl(a.sc162,0)- nvl(a.sc195,0) - nvl(a.sc197,0) + nvl(a.sc037,0) - nvl(a.sc057,0) +nvl(a.sc059,0) -nvl(a.esc46,0)-nvl(a.sc165,0)-nvl(a.sc166,0)-nvl(a.sc168,0)-nvl(a.esc32,0)+nvl(a.c062,0)+nvl(a.c063,0),4) CallPageReqTotalNum          ,
round(nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc107,0) + nvl(a.sc109,0),4) HardhoReqNum_intra           ,
round(nvl(a.vo13,0) + nvl(a.vo37,0) + nvl(a.sc111,0) + nvl(a.sc113,0),4) HardhoSuccNum_intra          ,
round(100*(nvl(a.vo13,0) + nvl(a.vo37,0) + nvl(a.sc111,0) + nvl(a.sc113,0))/
decode(nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc107,0) + nvl(a.sc109,0),0,1,null,1,nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc107,0) + nvl(a.sc109,0)),4) HardhoSuccRate_intra,
round(nvl(a.vo31,0) + nvl(a.sc105,0),4) ShoReqNum_intra,
round(nvl(a.vo31,0) - nvl(a.vo39,0) + nvl(a.sc105,0) - nvl(a.sc116,0),4) ShoSuccNum_intra,
round(100*(nvl(a.vo31,0) - nvl(a.vo39,0) + nvl(a.sc105,0) - nvl(a.sc116,0))/
decode(nvl(a.vo31,0) + nvl(a.sc105,0),0,1,null,1,nvl(a.vo31,0) + nvl(a.sc105,0)),4) ShoSuccRate_intra,
round(nvl(a.vo34,0) + nvl(a.vo36,0) + nvl(a.sc108,0) + nvl(a.sc110,0),4) HardhoReqNum_Extra,
round(nvl(a.vo16,0) + nvl(a.vo20,0) + nvl(a.sc112,0) + nvl(a.sc114,0),4) HardhoSuccNum_Extra,
round(100*(nvl(a.vo16,0) + nvl(a.vo20,0) + nvl(a.sc112,0) + nvl(a.sc114,0))/
decode(nvl(a.vo34,0) + nvl(a.vo36,0) + nvl(a.sc108,0) + nvl(a.sc110,0),0,1,null,1,nvl(a.vo34,0) + nvl(a.vo36,0) + nvl(a.sc108,0) + nvl(a.sc110,0)),4) HardhoSuccRate_Extra,
round(nvl(a.vo32,0) + nvl(a.sc106,0),4) ShoReqNum_Extra,
round(nvl(a.vo32,0) - nvl(a.vo40,0) + nvl(a.sc106,0) - nvl(a.sc117,0),4) ShoSuccNum_Extra,
round(100*(nvl(a.vo32,0) - nvl(a.vo40,0) + nvl(a.sc106,0) - nvl(a.sc117,0))/
decode(nvl(a.vo32,0) + nvl(a.sc106,0),0,1,null,1,nvl(a.vo32,0) + nvl(a.sc106,0)),4) ShoSuccRate_Extra,
round(nvl(a.L037,0)+nvl(a.L038,0) + nvl(a.L039,0) + nvl(a.L040,0)+ nvl(a.L041,0),4) FdwTxTotalFrameExcludeRx,
round(a.L097/1024,4) RLPFwdChSizeExcludeRx,
round(a.L099,4) RLPFwdChRxSize,
round(100*nvl(a.L099,0)/decode(nvl(a.L097,0),0,1,null,1,nvl(a.L097,0)),4) FwdChRxRate,
round(nvl(a.L042,0)+ nvl(a.L043,0) + nvl(a.L044,0) + nvl(a.L045,0) +nvl(a.L046,0),4) RevTxTotalFrameExcludeRx,
round(a.L098/1024,4) RLPRevChSize,
round(100*nvl(a.L098,0)/1024/decode(nvl(a.L042,0)+ nvl(a.L043,0) + nvl(a.L044,0) + nvl(a.L045,0) +nvl(a.L046,0),0,1,null,1,nvl(a.L042,0)+ nvl(a.L043,0) + nvl(a.L044,0) + nvl(a.L045,0) +nvl(a.L046,0)),4) RevChRxRate,
round(100*(nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0))/decode(nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0),0,1,null,1,nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)),4) BtsSysHardHoSuccRate,
round(100*(nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0))/decode(nvl(a.vo30,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc104,0)+nvl(a.sc105,0)+nvl(a.sc106,0),0,1,null,1,nvl(a.vo30,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc104,0)+nvl(a.sc105,0)+nvl(a.sc106,0)),4) SysSHoSuccRate,
round(100*(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0))/
decode(nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)
-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)
-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)
-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)
-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)
-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0),0,1,null,1,
nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)
-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)
-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)
-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)
-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)
-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0)),4) TchRadioFRate,
round(100*(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0))/
decode((case when(a.sc019 - a.esc03 - a.esc01 - a.esc05 + a.esc13 - a.sc015 - a.sc160) > 0
then (a.sc019 - a.esc03 - a.esc01 - a.esc05 + a.esc13 - a.sc015 - a.sc160) else 0 end)
+
(case when(a.sc020-a.esc04-a.esc02-a.esc06-a.esc12-a.sc016-a.esc07-a.esc08-a.esc09 - a.sc164) > 0
then (a.sc020-a.esc04-a.esc02-a.esc06-a.esc12-a.sc016-a.esc07-a.esc08-a.esc09 - a.sc164) else 0 end)
+
(case when(a.sc032 - a.esc14 - a.esc16- a.esc18 - a.sc038 - a.sc162) > 0
then (a.sc032 - a.esc14 - a.esc16- a.esc18 - a.sc038 - a.sc162) else 0 end)
+
(case when(a.sc033-a.esc15-a.esc17-a.esc19-a.esc20-a.sc039-a.esc21-a.esc22-a.esc23 - a.sc166) > 0
then (a.sc033-a.esc15-a.esc17-a.esc19-a.esc20-a.sc039-a.esc21-a.esc22-a.esc23 - a.sc166) else 0 end
),0,1,null,1,(case when(a.sc019 - a.esc03 - a.esc01 - a.esc05 + a.esc13 - a.sc015 - a.sc160) > 0
then (a.sc019 - a.esc03 - a.esc01 - a.esc05 + a.esc13 - a.sc015 - a.sc160) else 0 end)
+
(case when(a.sc020-a.esc04-a.esc02-a.esc06-a.esc12-a.sc016-a.esc07-a.esc08-a.esc09 - a.sc164) > 0
then (a.sc020-a.esc04-a.esc02-a.esc06-a.esc12-a.sc016-a.esc07-a.esc08-a.esc09 - a.sc164) else 0 end)
+
(case when(a.sc032 - a.esc14 - a.esc16- a.esc18 - a.sc038 - a.sc162) > 0
then (a.sc032 - a.esc14 - a.esc16- a.esc18 - a.sc038 - a.sc162) else 0 end)
+
(case when(a.sc033-a.esc15-a.esc17-a.esc19-a.esc20-a.sc039-a.esc21-a.esc22-a.esc23 - a.sc166) > 0
then (a.sc033-a.esc15-a.esc17-a.esc19-a.esc20-a.sc039-a.esc21-a.esc22-a.esc23 - a.sc166) else 0 end)
),4) CallInterruptRate,
round(nvl(a.vo30,0) + nvl(a.sc104,0),4)+round(nvl(a.scpd104,0),4) SShoReqNum_intra,
round(nvl(a.vo30,0) + nvl(a.sc104,0)-nvl(a.vo38,0)-nvl(a.sc115,0),4)+round(nvl(a.scpd104,0)-nvl(a.scpd115,0),4) SShoSuccNum_intra,
round(100*(a.vo30 -a.vo38+ a.sc104-a.sc115+a.scpd104-a.scpd115)/
decode(a.vo30 + a.sc104 + a.scpd104,0,1,null,1,a.vo30 + a.sc104 + a.scpd104),4) SShoSuccRate_intra,
round(
(case when(nvl(a.scpd036,0)
-nvl(a.scpd054,0)
+nvl(a.scpd056,0)
-nvl(a.scpd042,0)
-nvl(a.scpd044,0)
-nvl(a.scpd046,0)
-nvl(a.escpd29,0)
-nvl(a.escpd35,0)
-nvl(a.escpd44,0)
-nvl(a.scpd161,0)
-nvl(a.scpd162,0)
-nvl(a.scpd119,0)
-nvl(a.scpd195,0)
-nvl(a.scpd197,0)
-nvl(a.c264,0)
-nvl(a.ec22,0)) > 0
then( nvl(a.scpd036,0)
-nvl(a.scpd054,0)
+nvl(a.scpd056,0)
-nvl(a.scpd042,0)
-nvl(a.scpd044,0)
-nvl(a.scpd046,0)
-nvl(a.escpd29,0)
-nvl(a.escpd35,0)
-nvl(a.escpd44,0)
-nvl(a.scpd161,0)
-nvl(a.scpd162,0)
-nvl(a.scpd119,0)
-nvl(a.scpd195,0)
-nvl(a.scpd197,0)
-nvl(a.c264,0)
-nvl(a.ec22,0)) else 0 end)
+
(case when(nvl(a.scpd037,0)
-nvl(a.scpd043,0)
-nvl(a.scpd045,0)
-nvl(a.scpd047,0)
-nvl(a.scpd057,0)
+nvl(a.scpd059,0)
-nvl(a.escpd46,0)
-nvl(a.scpd165,0)
-nvl(a.scpd166,0)
-nvl(a.scpd168,0)
-nvl(a.escpd32,0)
-nvl(a.ec23,0)) > 0
then( nvl(a.scpd037,0)
-nvl(a.scpd043,0)
-nvl(a.scpd045,0)
-nvl(a.scpd047,0)
-nvl(a.scpd057,0)
+nvl(a.scpd059,0)
-nvl(a.escpd46,0)
-nvl(a.scpd165,0)
-nvl(a.scpd166,0)
-nvl(a.scpd168,0)
-nvl(a.escpd32,0)
-nvl(a.ec23,0)) else 0 end),4)  ps_CallPageReqNum,
case when (round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4)) is null then 1000
     when (round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4))=0 then 1000 else round(cs_TrafficExcludeHo*60/decode((round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4)),0,1,(round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4))),4) end cs_LoseCallingratio,

b.carriernum_1x,
b.cs_SHOTraffic,
b.cs_TchReqNumHardho,
b.cs_TchSuccNumHardho,
b.cs_TchReqNumsoftho,
b.cs_TchSuccNumsoftho,
b.cs_CallPageSuccNum,
b.cs_CallPageReqNum,
b.TCHLoadTrafficIncludeHo,
b.TrafficExcludeHo,
b.cs_TrafficExcludeHo,
b.TCHLoadTrafficExcludeHo,
b.ps_TchReqNumHardho ,
b.ps_TchSuccNumHardho,
b.ps_TchReqNumsoftho ,
b.ps_TchSuccNumsoftho,
b.ps_LoseCallingNum,
b.ps_HandoffReqNum,
b.ps_HandoffSuccNum,
b.ps_HandoffSuccRate,
b.ps_HardhoReqNum,
b.ps_HardhoSuccNum,
b.ps_HardhoSuccRate,
b.ps_SofthoReqNum,
b.ps_SofthoSuccNum,
b.ps_SofthoSuccRate,
b.ps_SSofthoReqNum,
b.ps_SSofthoSuccNum,
b.ps_SSofthoSuccRate,
b.ps_CallPageSuccNum,
a.cs_trafficByWalsh,
a.ps_trafficByWalsh,
a.LoadTrafficByWalsh,
--count(case when BadCellNum_1 > 2.5 and BadCellNum_2 >= 3 and BadCellNum_3 > 0.025 then a.int_i end) BadCellNum,
--b.BadCellNum,
round(100*b.cs_SHORate_up/decode(b.cs_SHORate_down,0,1,null,1,b.cs_SHORate_down),4) cs_SHORate,
round(100*b.ps_SHORate_up/decode(b.ps_SHORate_down,0,1,null,1,b.ps_SHORate_down),4) ps_SHORate,
--round(100*(nvl(round((nvl(a.c085,0)-nvl(a.c276,0))/360,4),0)-nvl(round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0))/decode(nvl(round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0)+nvl(round((nvl(a.c085,0)-nvl(a.c276,0))/360,4)-round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0),0,1,nvl(round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0)+nvl(round((nvl(a.c085,0)-nvl(a.c276,0))/360,4)-round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0)),4) ps_SHORate,
b.cs_TchReqNumExcludeHo cs_TchReqNumExcludeHo,
b.cs_TchSuccNumExcludeHo cs_TchSuccNumExcludeHo,
b.cs_TchFNumExcludeHo_a1- b.cs_TchFNumExcludeHo_a2 cs_TchFNumExcludeHo,
round(100*b.cs_TchFNumExcludeHo_a2/decode(b.cs_TchFNumExcludeHo_a1,0,1,null,1,b.cs_TchFNumExcludeHo_a1),4) cs_TchSuccExcludeHoRate,
b.cs_HandoffReqNum cs_HandoffReqNum,
b.cs_HandoffSuccNum cs_HandoffSuccNum,
round(100*b.cs_HandoffSuccNum/decode(cs_HandoffReqNum,0,1,null,1,b.cs_HandoffReqNum),4) cs_HandoffSuccRate,
b.HandoffReqNum_Extra HandoffReqNum_Extra,
b.HandoffSuccNum_Extra HandoffSuccNum_Extra,
--update-2011-9-14
round(100*b.HandoffSuccNum_Extra/decode(b.HandoffReqNum_Extra,0,1,null,1,b.HandoffReqNum_Extra),4) HandoffSuccRate_Extra,
v1-v2 ps_SSHOTraffic,
round(100*b.ps_LoseCallingRate_up/decode(b.ps_LoseCallingRate_down,0,1,null,1,b.ps_LoseCallingRate_down),4) ps_LoseCallingRate,
b.ps_TchReqNumIncludeHo ps_TchReqNumIncludeHo,
b.ps_TchSuccNumIncludeHo ps_TchSuccNumIncludeHo,
(b.ps_TchFNumIncludeHo_b1 - b.ps_TchFNumIncludeHo_b2) ps_TchFNumIncludeHo,
(b.ps_TchFNumIncludeHo_b1 - b.ps_TchFNumIncludeHo_b2) ps_CallBlockFailNum,
round(100*b.ps_TchFNumIncludeHo_b2/decode(b.ps_TchFNumIncludeHo_b1,0,1,null,1,b.ps_TchFNumIncludeHo_b1),4) ps_TchSuccIncludeHoRate,
b.ps_TchReqNumExcludeHo ps_TchReqNumExcludeHo,
b.ps_TchSuccNumExcludeHo ps_TchSuccNumExcludeHo,
b.ps_TchReqNumExcludeHo - b.ps_TchSuccNumExcludeHo  ps_TchFNumExcludeHo,
round(100*b.ps_TchSuccNumExcludeHo /decode(b.ps_TchReqNumExcludeHo,0,1,null,1,b.ps_TchReqNumExcludeHo),4)  ps_TchSuccExcludeHoRate,
round(ps_LoseCallingratio_up/decode(ps_LoseCallingratio_down,0,1,null,1,ps_LoseCallingratio_down),4) ps_LoseCallingratio,
(TchReqNumIncludeHo_a+TchReqNumIncludeHo_b) TchReqNumIncludeHo,
(TchReqNumExcludeHo_a+TchReqNumExcludeHo_b) TchReqNumExcludeHo,
(TchSuccNumIncludeHo_a+TchSuccNumIncludeHo_b) TchSuccNumIncludeHo,
(TchFNumIncludeHo_a1-TchFNumIncludeHo_a2+TchFNumIncludeHo_b1-TchFNumIncludeHo_b2) TchFNumIncludeHo,
round(100*(TchSuccIncludeHoRate_up_a+TchSuccIncludeHoRate_up_b)/decode(TchSuccIncludeHoRate_down_a+TchSuccIncludeHoRate_down_b,0,1,null,1,TchSuccIncludeHoRate_down_a+TchSuccIncludeHoRate_down_b),4) TchSuccIncludeHoRate,
(TchSuccNumExcludeHo_a+TchSuccNumExcludeHo_b) TchSuccNumExcludeHo,
(TchFNumExcludeHo_a1-TchFNumExcludeHo_a2+TchFNumExcludeHo_b1-TchFNumExcludeHo_b2) TchFNumExcludeHo,
round(100*(TchSuccExcludeHoRate_up_a+TchSuccExcludeHoRate_up_b)/decode(TchSuccExcludeHoRate_down_a+TchSuccExcludeHoRate_down_b,0,1,null,1,TchSuccExcludeHoRate_down_a+TchSuccExcludeHoRate_down_b),4) TchSuccExcludeHoRate,
(HandoffReqNum_a+HandoffReqNum_b) HandoffReqNum,
(HandoffSuccNum_a+HandoffSuccNum_b) HandoffSuccNum,
round(100*(HandoffSuccNum_a+HandoffSuccNum_b)/decode(HandoffReqNum_a+HandoffReqNum_b,0,1,null,1, HandoffReqNum_a+HandoffReqNum_b),4) HandoffSuccRate,
(HandoffReqNum_intra_a+HandoffReqNum_intra_b) HandoffReqNum_intra,
(HandoffSuccNum_intra_a+HandoffSuccNum_intra_b) HandoffSuccNum_intra,
round(100*(HandoffSuccNum_intra_a+HandoffSuccNum_intra_b)/decode(HandoffReqNum_intra_a+HandoffReqNum_intra_b,0,1,null,1,HandoffReqNum_intra_a+HandoffReqNum_intra_b),4) HandoffSuccRate_intra,
round(100*(cs_CallBlockFailRate_up_a+cs_CallBlockFailRate_up_b)/decode(cs_CallBlockFailRate_down,0,1,null,1,cs_CallBlockFailRate_down),4) cs_CallBlockFailRate,
ChannelNum,
ChannelAvailNum,
ChannelMaxUseNum
from a,b,c
where a.city_id = b.city_id and  b.city_id=c.city_id;

commit;
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CallPageReqNum,
CallPageSuccNum,
Numfailofcall,
cs_Numfailofcall,
CallPageSuccRate,
LoseCallingRate,
ps_CallPageSuccRate,
cs_CallPageSuccRate,
BadCellRatio,
cs_LoseCallingRate,
SHoFactor,
ps_SHOTraffic,
cs_TchFNumIncludeHo,
ChannelMaxUseRate,
FwdChMaxUseRate,
RevChMaxUseRate,
TrafficIncludeHo,
TCHLoadRate,
CEAvailRate,
BusyerCellratio,
BusyCellratio,
FreeCellratio,
SeriOverflowBtsratio,
OverflowBtsratio,
CallBlockFailNum,
CallBlockFailRate,
ps_CallBlockFailRate,
ps_CallBlockFailRateHardho,
ps_CallBlockFailRatesoftho,
LoseCallingratio,
cs_CallBlockFailRateHardho,
cs_CallBlockFailRatesoftho
)
select
int_id,
v_date,
0,
10004,
10,
sum(nvl(cs_CallPageReqNum,0)+nvl(ps_CallPageReqNum,0)) CallPageReqNum,
sum(nvl(cs_CallPageSuccNum,0)+nvl(ps_CallPageSuccNum,0)) CallPageSuccNum,
sum(nvl(cs_CallPageReqNum,0)+nvl(ps_CallPageReqNum,0)-nvl(cs_CallPageSuccNum,0)-nvl(ps_CallPageSuccNum,0))   Numfailofcall,
sum(nvl(cs_CallPageReqNum,0)-nvl(cs_CallPageSuccNum,0))   cs_Numfailofcall,

round(100*sum(nvl(cs_CallPageSuccNum,0)+nvl(ps_CallPageSuccNum,0))/decode(sum(nvl(cs_CallPageReqNum,0)+nvl(ps_CallPageReqNum,0)),0,1,null,1,sum(nvl(cs_CallPageReqNum,0)+nvl(ps_CallPageReqNum,0))),4) CallPageSuccRate,
round(100*sum(nvl(cs_LoseCallingNum,0)+nvl(ps_LoseCallingNum,0))/decode(sum(nvl(cs_TchSuccNumExcludeHo,0)+nvl(ps_TchSuccNumExcludeHo,0)),0,1,null,1,sum(nvl(cs_TchSuccNumExcludeHo,0)+nvl(ps_TchSuccNumExcludeHo,0))),4) LoseCallingRate,
round(100*sum(nvl(ps_CallPageSuccNum,0))/decode(sum(ps_CallPageReqNum),0,1,null,1,sum(ps_CallPageReqNum)),4) ps_CallPageSuccRate,
round(100*sum(nvl(cs_CallPageSuccNum,0))/decode(sum(cs_CallPageReqNum),0,1,null,1,sum(cs_CallPageReqNum)),4)  cs_CallPageSuccRate,
round(100*sum(nvl(BadCellNum,0))/decode(sum(CellNum),0,1,null,1,sum(CellNum)),4) BadCellRatio,
round(100*sum(nvl(cs_LoseCallingNum,0))/decode(sum(cs_TchSuccNumExcludeHo),0,1,null,1,sum(cs_TchSuccNumExcludeHo)),4) cs_LoseCallingRate,
round(100*sum(TCHLoadTrafficIncludeHo - TCHLoadTrafficExcludeHo)/decode(sum(TCHLoadTrafficExcludeHo),0,1,null,1,sum(TCHLoadTrafficExcludeHo)),4) SHoFactor,
sum((nvl(ps_CallTrafficIncludeHo,0)-nvl(ps_CallTrafficExcludeHo,0)))  ps_SHOTraffic,
sum(nvl(cs_TchReqNumIncludeHo,0)-nvl(cs_TchSuccNumIncludeHo,0)) cs_TchFNumIncludeHo,
round(100*sum(nvl(ChannelMaxUseNum,0))/decode(sum(ChannelAvailNum),null,1,0,1,sum(ChannelAvailNum)),4) ChannelMaxUseRate,
sum(round(nvl(FwdChMaxUseRate,0),4))  FwdChMaxUseRate ,
sum(round(nvl(RevChMaxUseRate,0),4))       RevChMaxUseRate ,
sum((nvl(cs_TrafficIncludeHo,0)+nvl(ps_CallTrafficIncludeHo,0))) TrafficIncludeHo,
--sum(round(100*(nvl(ps_CallTrafficIncludeHo,0)-nvl(ps_CallTrafficExcludeHo,0))/decode(nvl(ps_CallTrafficExcludeHo,0)+nvl(ps_CallTrafficIncludeHo-ps_CallTrafficExcludeHo,0),0,1,nvl(ps_CallTrafficExcludeHo,0)+nvl(ps_CallTrafficIncludeHo-ps_CallTrafficExcludeHo,0)),4))  ps_SHORate,
round(100*sum(nvl(TCHLoadTrafficIncludeHo,0))/decode(sum(Wirecapacity),null,1,0,1,sum(Wirecapacity)),4)  TCHLoadRate,
round(100*sum(nvl(CEAvailNum,0))/decode(sum(nvl(CENum,0)),null,1,0,1,sum(nvl(CENum,0))),4) CEAvailRate,
round(100*sum(nvl(BusyerCellNum,0))/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4) BusyerCellratio,
round(100*sum(nvl(BusyCellNum,0))/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4)  BusyCellratio,
round(100*sum(nvl(FreeCellNum,0))/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4) FreeCellratio,
round(100*sum(nvl(SeriOverflowBtsNum,0))/decode(sum(BtsNum),null,1,0,1,sum(BtsNum)),4)    SeriOverflowBtsratio,
round(100*sum(nvl(OverflowBtsNum,0))/decode(sum(BtsNum),null,1,0,1,sum(BtsNum)),4)  OverflowBtsratio,
sum(nvl(cs_CallBlockFailNum,0)+nvl(ps_CallBlockFailNum,0)) CallBlockFailNum,
round(100*sum(nvl(cs_CallBlockFailNum,0)+nvl(ps_CallBlockFailNum,0))/decode(sum(TchReqNumIncludeHo),null,1,0,1,sum(TchReqNumIncludeHo)),4) CallBlockFailRate,
round(100*sum(nvl(ps_CallBlockFailNum,0))/decode(sum(ps_TchReqNumIncludeHo),null,1,0,1,sum(ps_TchReqNumIncludeHo)),4)  ps_CallBlockFailRate,
round(100*sum(nvl(ps_TchReqNumHardho,0)-nvl(ps_TchSuccNumHardho,0))/decode(sum(ps_TchReqNumHardho),null,1,0,1,sum(ps_TchReqNumHardho)),4) ps_CallBlockFailRateHardho,
round(100*sum(nvl(ps_TchReqNumsoftho,0)-nvl(ps_TchSuccNumsoftho,0))/decode(sum(ps_TchReqNumsoftho),null,1,0,1,sum(ps_TchReqNumsoftho)),4) ps_CallBlockFailRatesoftho,
round(sum(nvl(TrafficExcludeHo,0))*60/decode(sum(LoseCallingNum),null,1,0,1,sum(LoseCallingNum)),4) LoseCallingratio,
round(100*sum(nvl(cs_TchReqNumHardho,0)-nvl(cs_TchSuccNumHardho,0))/decode(sum(cs_TchReqNumHardho),null,1,0,1,sum(cs_TchReqNumHardho)),4) cs_CallBlockFailRateHardho,
round(100*sum(nvl(cs_TchReqNumsoftho,0)-nvl(cs_TchSuccNumsoftho,0))/decode(sum(cs_TchReqNumsoftho),null,1,0,1,sum(cs_TchReqNumsoftho)),4) cs_CallBlockFailRatesoftho
from C_PERF_1X_SUM_LC_TEMP
group by int_id;






commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');
insert /*+append*/ into c_perf_1x_sum
(
int_id                        ,
scan_start_time             ,
sum_level                   ,
ne_type                     ,
vendor_id                   ,
callpagereqnum              ,
callpagesuccnum             ,
callpagesuccrate            ,
cs_callpagereqnum           ,
cs_callpagesuccnum          ,
cs_callpagesuccrate         ,
ps_callpagereqnum           ,
ps_callpagesuccnum          ,
ps_callpagesuccrate         ,
trafficincludeho            ,
trafficexcludeho            ,
cs_trafficincludeho         ,
cs_trafficexcludeho         ,
cs_trafficbywalsh           ,
cs_shotraffic               ,
cs_sshotraffic              ,
cs_shorate                  ,
ps_calltrafficincludeho     ,
ps_calltrafficexcludeho     ,
ps_trafficbywalsh           ,
ps_shotraffic               ,
ps_sshotraffic              ,
ps_shorate                  ,
losecallingnum              ,
losecallingrate             ,
losecallingratio            ,
cs_losecallingnum           ,
cs_losecallingrate          ,
cs_losecallingratio         ,
ps_losecallingnum           ,
ps_losecallingrate          ,
ps_losecallingratio         ,
tchreqnumincludeho          ,
tchsuccnumincludeho         ,
tchfnumincludeho            ,
tchsuccincludehorate        ,
tchreqnumexcludeho          ,
tchsuccnumexcludeho         ,
tchfnumexcludeho            ,
tchsuccexcludehorate        ,
callblockfailnum            ,
callblockfailrate           ,
cs_tchreqnumincludeho       ,
cs_tchsuccnumincludeho      ,
cs_tchfnumincludeho         ,
cs_tchsuccincludehorate     ,
cs_tchreqnumexcludeho       ,
cs_tchsuccnumexcludeho      ,
cs_tchfnumexcludeho         ,
cs_tchsuccexcludehorate     ,
cs_callblockfailnum         ,
cs_callblockfailrate        ,
cs_tchreqnumhardho          ,
cs_tchsuccnumhardho         ,
cs_callblockfailratehardho  ,
cs_tchreqnumsoftho          ,
cs_tchsuccnumsoftho         ,
cs_callblockfailratesoftho  ,
ps_tchreqnumincludeho       ,
ps_tchsuccnumincludeho      ,
ps_tchfnumincludeho         ,
ps_tchsuccincludehorate     ,
ps_tchreqnumexcludeho       ,
ps_tchsuccnumexcludeho      ,
ps_tchfnumexcludeho         ,
ps_tchsuccexcludehorate     ,
ps_callblockfailnum         ,
ps_callblockfailrate        ,
ps_tchreqnumhardho          ,
ps_tchsuccnumhardho         ,
ps_callblockfailratehardho  ,
ps_tchreqnumsoftho          ,
ps_tchsuccnumsoftho         ,
ps_callblockfailratesoftho  ,
handoffreqnum               ,
handoffsuccnum              ,
handoffsuccrate             ,
cs_handoffreqnum            ,
cs_handoffsuccnum           ,
cs_handoffsuccrate          ,
cs_hardhoreqnum             ,
cs_hardhosuccnum            ,
cs_hardhosuccrate           ,
cs_softhoreqnum             ,
cs_softhosuccnum            ,
cs_softhosuccrate           ,
cs_ssofthoreqnum            ,
cs_ssofthosuccnum           ,
cs_ssofthosuccrate          ,
ps_handoffreqnum            ,
ps_handoffsuccnum           ,
ps_handoffsuccrate          ,
ps_hardhoreqnum             ,
ps_hardhosuccnum            ,
ps_hardhosuccrate           ,
ps_softhoreqnum             ,
ps_softhosuccnum            ,
ps_softhosuccrate           ,
ps_ssofthoreqnum            ,
ps_ssofthosuccnum           ,
ps_ssofthosuccrate          ,
handoffreqnum_intra         ,
handoffsuccnum_intra        ,
handoffsuccrate_intra       ,
handoffreqnum_extra         ,
handoffsuccnum_extra        ,
handoffsuccrate_extra       ,
hardhoreqnum_intra          ,
hardhosuccnum_intra         ,
hardhosuccrate_intra        ,
shoreqnum_intra             ,
shosuccnum_intra            ,
shosuccrate_intra           ,
sshoreqnum_intra            ,
sshosuccnum_intra           ,
sshosuccrate_intra          ,
hardhoreqnum_extra          ,
hardhosuccnum_extra         ,
hardhosuccrate_extra        ,
shoreqnum_extra             ,
shosuccnum_extra            ,
shosuccrate_extra           ,
carrier1btsnum              ,
carrier2btsnum              ,
carrier3btsnum              ,
carrier4btsnum              ,
carriernum_1x               ,
channelnum                  ,
channelavailnum             ,
channelmaxusenum            ,
channelmaxuserate           ,
fwdchnum                    ,
fwdchavailnum               ,
fwdchmaxusenum              ,
fwdchmaxuserate             ,
revchnum                    ,
revchavailnum               ,
revchmaxusenum              ,
revchmaxuserate             ,
fwdrxtotalframe             ,
fdwtxtotalframeexcluderx    ,
rlpfwdchsizeexcluderx       ,
rlpfwdchrxsize              ,
rlpfwdlosesize              ,
fwdchrxrate                 ,
revrxtotalframe             ,
revtxtotalframeexcluderx    ,
rlprevchsize                ,
revchrxrate                 ,
btsnum                      ,
onecarrierbtsnum            ,
twocarrierbtsnum            ,
threecarrierbtsnum          ,
fourcarrierbtsnum           ,
cellnum                     ,
onecarriercellnum           ,
twocarriercellnum           ,
threecarriercellnum         ,
fourcarriercellnum          ,
cenum                       ,
wirecapacity                ,
tchnum                      ,
tchloadrate                 ,
shofactor                   ,
ceavailrate                 ,
tchblockfailrate            ,
busyercellratio             ,
busycellratio               ,
freecellratio               ,
serioverflowbtsratio        ,
overflowbtsratio            ,
btssyshardhosuccrate        ,
sysshosuccrate              ,
tchradiofrate               ,
callinterruptrate           ,
avgradiofperiod             ,
badcellratio                ,
ceavailnum                  ,
tchblockfailnumincludeho    ,
tchloadtrafficincludeho     ,
tchloadtrafficexcludeho     ,
loadtrafficbywalsh          ,
trafficcarrier1             ,
trafficcarrier2             ,
trafficcarrier3             ,
trafficcarrier4             ,
busyercellnum               ,
busycellnum                 ,
freecellnum                 ,
badcellnum                  ,
serioverflowbtsnum          ,
overflowbtsnum              ,
tchreqnumcallerexcludehosms ,
tchsuccnumcallerexcludehosms,
tchreqnumcalleeexcludehosms ,
tchsuccnumcalleeexcludehosms,
tchreqnumexcludehosms       ,
tchsuccnumexcludehosms      ,
tchreqnumincludehosms       ,
tchsuccnumincludehosms      ,
btssyshardhoreqnum          ,
btssyshardhosuccnum         ,
sysshoreqnum                ,
sysshosuccnum               ,
tchradiofnum                ,
callpagereqtotalnum         ,
numfailofcall               ,
ps_numfailofcall            ,
cs_numfailofcall
)
select
int_id                        ,
scan_start_time             ,
sum_level                   ,
ne_type                     ,
vendor_id                   ,
sum(callpagereqnum              ),
sum(callpagesuccnum             ),
sum(callpagesuccrate            ),
sum(cs_callpagereqnum           ),
sum(cs_callpagesuccnum          ),
sum(cs_callpagesuccrate         ),
sum(ps_callpagereqnum           ),
sum(ps_callpagesuccnum          ),
sum(ps_callpagesuccrate         ),
sum(trafficincludeho            ),
sum(trafficexcludeho            ),
sum(cs_trafficincludeho         ),
sum(cs_trafficexcludeho         ),
sum(cs_trafficbywalsh           ),
sum(cs_shotraffic               ),
sum(cs_sshotraffic              ),
sum(cs_shorate                  ),
sum(ps_calltrafficincludeho     ),
sum(ps_calltrafficexcludeho     ),
sum(ps_trafficbywalsh           ),
sum(ps_shotraffic               ),
sum(ps_sshotraffic              ),
sum(ps_shorate                  ),
sum(losecallingnum              ),
sum(losecallingrate             ),
sum(losecallingratio            ),
sum(cs_losecallingnum           ),
sum(cs_losecallingrate          ),
sum(cs_losecallingratio         ),
sum(ps_losecallingnum           ),
sum(ps_losecallingrate          ),
sum(ps_losecallingratio         ),
sum(tchreqnumincludeho          ),
sum(tchsuccnumincludeho         ),
sum(tchfnumincludeho            ),
sum(tchsuccincludehorate        ),
sum(tchreqnumexcludeho          ),
sum(tchsuccnumexcludeho         ),
sum(tchfnumexcludeho            ),
sum(tchsuccexcludehorate        ),
sum(callblockfailnum            ),
sum(callblockfailrate           ),
sum(cs_tchreqnumincludeho       ),
sum(cs_tchsuccnumincludeho      ),
sum(cs_tchfnumincludeho         ),
sum(cs_tchsuccincludehorate     ),
sum(cs_tchreqnumexcludeho       ),
sum(cs_tchsuccnumexcludeho      ),
sum(cs_tchfnumexcludeho         ),
sum(cs_tchsuccexcludehorate     ),
sum(cs_callblockfailnum         ),
sum(cs_callblockfailrate        ),
sum(cs_tchreqnumhardho          ),
sum(cs_tchsuccnumhardho         ),
sum(cs_callblockfailratehardho  ),
sum(cs_tchreqnumsoftho          ),
sum(cs_tchsuccnumsoftho         ),
sum(cs_callblockfailratesoftho  ),
sum(ps_tchreqnumincludeho       ),
sum(ps_tchsuccnumincludeho      ),
sum(ps_tchfnumincludeho         ),
sum(ps_tchsuccincludehorate     ),
sum(ps_tchreqnumexcludeho       ),
sum(ps_tchsuccnumexcludeho      ),
sum(ps_tchfnumexcludeho         ),
sum(ps_tchsuccexcludehorate     ),

sum(ps_CallBlockFailNum         ),

sum(ps_callblockfailrate        ),
sum(ps_tchreqnumhardho          ),
sum(ps_tchsuccnumhardho         ),
sum(ps_callblockfailratehardho  ),
sum(ps_tchreqnumsoftho          ),
sum(ps_tchsuccnumsoftho         ),
sum(ps_callblockfailratesoftho  ),
sum(handoffreqnum               ),
sum(handoffsuccnum              ),
sum(handoffsuccrate             ),
sum(cs_handoffreqnum            ),
sum(cs_handoffsuccnum           ),
sum(cs_handoffsuccrate          ),
sum(cs_hardhoreqnum             ),
sum(cs_hardhosuccnum            ),
sum(cs_hardhosuccrate           ),
sum(cs_softhoreqnum             ),
sum(cs_softhosuccnum            ),
sum(cs_softhosuccrate           ),
sum(cs_ssofthoreqnum            ),
sum(cs_ssofthosuccnum           ),
sum(cs_ssofthosuccrate          ),
sum(ps_handoffreqnum            ),
sum(ps_handoffsuccnum           ),
sum(ps_handoffsuccrate          ),
sum(ps_hardhoreqnum             ),
sum(ps_hardhosuccnum            ),
sum(ps_hardhosuccrate           ),
sum(ps_softhoreqnum             ),
sum(ps_softhosuccnum            ),
sum(ps_softhosuccrate           ),
sum(ps_ssofthoreqnum            ),
sum(ps_ssofthosuccnum           ),
sum(ps_ssofthosuccrate          ),
sum(handoffreqnum_intra         ),
sum(handoffsuccnum_intra        ),
sum(handoffsuccrate_intra       ),
sum(handoffreqnum_extra         ),
sum(handoffsuccnum_extra        ),
sum(handoffsuccrate_extra       ),
sum(hardhoreqnum_intra          ),
sum(hardhosuccnum_intra         ),
sum(hardhosuccrate_intra        ),
sum(shoreqnum_intra             ),
sum(shosuccnum_intra            ),
sum(shosuccrate_intra           ),
sum(sshoreqnum_intra            ),
sum(sshosuccnum_intra           ),
sum(sshosuccrate_intra          ),
sum(hardhoreqnum_extra          ),
sum(hardhosuccnum_extra         ),
sum(hardhosuccrate_extra        ),
sum(shoreqnum_extra             ),
sum(shosuccnum_extra            ),
sum(shosuccrate_extra           ),
sum(carrier1btsnum              ),
sum(carrier2btsnum              ),
sum(carrier3btsnum              ),
sum(nvl(carrier4btsnum,0)       ),
sum(carriernum_1x               ),
sum(channelnum                  ),
sum(channelavailnum             ),
sum(channelmaxusenum            ),
sum(channelmaxuserate           ),
sum(nvl(fwdchnum,0)             ),
sum(nvl(fwdchavailnum,0)        ),
sum(nvl(fwdchmaxusenum,0)       ),
sum(nvl(fwdchmaxuserate,0)      ),
sum(nvl(revchnum,0)             ),
sum(nvl(revchavailnum,0)        ),
sum(nvl(revchmaxusenum,0)       ),
sum(revchmaxuserate             ),
sum(nvl(fwdrxtotalframe,0)      ),
sum(fdwtxtotalframeexcluderx    ),
sum(rlpfwdchsizeexcluderx       ),
sum(rlpfwdchrxsize              ),
sum(nvl(rlpfwdlosesize,0)       ),
sum(fwdchrxrate                 ),
sum(revrxtotalframe             ),
sum(revtxtotalframeexcluderx    ),
sum(rlprevchsize                ),
sum(revchrxrate                 ),
sum(btsnum                      ),
sum(nvl(onecarrierbtsnum,0)            ),
sum(nvl(twocarrierbtsnum,0)            ),
sum(nvl(threecarrierbtsnum,0)          ),
sum(nvl(fourcarrierbtsnum,0)           ),
sum(cellnum                     ),
sum(onecarriercellnum           ),
sum(twocarriercellnum           ),
sum(threecarriercellnum         ),
sum(fourcarriercellnum          ),
sum(cenum                       ),
sum(wirecapacity                ),
sum(tchnum                      ),
sum(tchloadrate                 ),
sum(shofactor                   ),
sum(case when ceavailrate>=100 then 100 else ceavailrate end ),
sum(tchblockfailrate            ),
sum(busyercellratio             ),
sum(busycellratio               ),
sum(freecellratio               ),
sum(serioverflowbtsratio        ),
sum(overflowbtsratio            ),
sum(btssyshardhosuccrate        ),
round(100*sum(nvl(SysSHoSuccNum,0))/decode(sum(nvl(SysSHoReqNum,0)),0,1,sum(nvl(SysSHoReqNum,0))),4),
sum(tchradiofrate               ),
sum(callinterruptrate           ),
--sum(avgradiofperiod             ),
round(100*sum(tCHLoadTrafficExcludeHo)/decode(sum(TCHRadioFNum),0,1,sum(TCHRadioFNum)),4),
sum(badcellratio                ),
round(sum(ceavailnum                  )),
sum(tchblockfailnumincludeho    ),
sum(tchloadtrafficincludeho     ),
sum(tchloadtrafficexcludeho     ),
sum(loadtrafficbywalsh          ),
sum(trafficcarrier1             ),
sum(trafficcarrier2             ),
sum(trafficcarrier3             ),
sum(trafficcarrier4             ),
sum(busyercellnum               ),
sum(busycellnum                 ),
sum(freecellnum                 ),
sum(nvl(badcellnum,0)           ),
sum(serioverflowbtsnum          ),
sum(overflowbtsnum              ),
sum(tchreqnumcallerexcludehosms ),
sum(tchsuccnumcallerexcludehosms),
sum(tchreqnumcalleeexcludehosms ),
sum(tchsuccnumcalleeexcludehosms),
sum(tchreqnumexcludehosms       ),
sum(tchsuccnumexcludehosms      ),
sum(tchreqnumincludehosms       ),
sum(tchsuccnumincludehosms      ),
sum(btssyshardhoreqnum          ),
sum(btssyshardhosuccnum         ),
sum(sysshoreqnum                ),
sum(sysshosuccnum               ),
sum(tchradiofnum                ),
sum(callpagereqtotalnum         ),
sum(numfailofcall               ),
round(sum(nvl(ps_CallPageReqNum,0) - nvl(ps_CallPageSuccNum,0))),
sum(cs_numfailofcall            )
from C_PERF_1X_SUM_LC_TEMP
group by int_id,scan_start_time,sum_level,ne_type,vendor_id;

commit;

v_sql:='truncate table  C_PERF_1X_SUM_LC_TEMP';
dbms_output.put_line(v_sql);
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');
execute immediate v_sql;
commit;

---------------------------------------------------------------------------------------------10000-begion
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
OnecarrierBtsNum,
Carrier1BtsNum
)
select
a.province_id,
v_date,
0,
10000,
10,nvl(a.OnecarrierBtsNum,0),nvl(b.Carrier1BtsNum,0)
from
(
select province_id,count(distinct related_bts) OnecarrierBtsNum
from
(select r.province_id,c.related_bts from
c_carrier c,c_region_city r where cdma_freq in (283,242,201,160,119) and vendor_id=10 and c.city_id=r.city_id
group by r.province_id,c.related_bts having count(distinct cdma_freq)=1 )
group by province_id) a,
(
select r.province_id,
-- sum((case when cdma_freq=283 then 1 else 0 end))/count(distinct (case when cdma_freq=283 then int_id end ))*count(distinct (case when cdma_freq=283 then related_bts end ))  Carrier1BtsNum
count(distinct a.related_bts)  Carrier1BtsNum
 from c_carrier a,c_region_city r
  where   a.vendor_id=10  and  cdma_freq=283 and a.city_id=r.city_id
 group by r.province_id) b where a.province_id=b.province_id(+);

commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TwocarrierbtsNum,
Carrier2BtsNum
)
select a.province_id,
v_date,
0,
10000,
10,nvl(a.TwocarrierbtsNum,0),nvl(b.Carrier2BtsNum,0)
from
(
select province_id,count(distinct related_bts) TwocarrierBtsNum
from
(select province_id,related_bts from
c_carrier c,c_region_city r where cdma_freq in (283,242,201,160,119) and vendor_id=10 and c.city_id=r.city_id
group by province_id,related_bts having count(distinct cdma_freq)=2 )
group by province_id) a,
(
select r.province_id,
-- sum((case when cdma_freq=201 then 1 else 0 end))/count(distinct (case when cdma_freq=201 then int_id end ))*count(distinct (case when cdma_freq=201 then related_bts end ))  Carrier2BtsNum
count(distinct a.related_bts)  Carrier2BtsNum
 from c_carrier a,c_region_city r
  where   a.vendor_id=10 and  cdma_freq=201 and a.city_id=r.city_id
 group by r.province_id) b where a.province_id=b.province_id(+);
commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');



insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
threecarrierbtsNum,
Carrier3BtsNum
)
select
a.province_id,
v_date,
0,
10000,
10,nvl(a.threecarrierbtsNum,0),nvl(b.Carrier3BtsNum,0)
from
(
select province_id,count(distinct related_bts) threecarrierbtsNum
from
(select province_id,related_bts from
c_carrier c,c_region_city r where cdma_freq in (283,242,201,160,119) and vendor_id=10 and c.city_id=r.city_id
group by province_id,related_bts having count(distinct cdma_freq)=3 )
group by province_id) a,
(
select r.province_id,
-- sum((case when cdma_freq=242 then 1 else 0 end))/count(distinct (case when cdma_freq=242 then int_id end ))*count(distinct (case when cdma_freq=242 then related_bts end ))  Carrier3BtsNum
count(distinct a.related_bts) Carrier3BtsNum
 from c_carrier a  ,c_region_city r
  where   a.vendor_id=10  and  cdma_freq=242  and a.city_id=r.city_id
 group by r.province_id) b where a.province_id=b.province_id(+);


 commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
FourcarrierbtsNum,
Carrier4BtsNum
)
select r.province_id,
v_date,
0,
10000,
10,sum(nvl(a.FourcarrierbtsNum,0)),sum(nvl(b.Carrier4BtsNum,0))
from
(
select city_id,count(distinct related_bts) FourcarrierbtsNum
from
(select city_id,related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=10
group by city_id,related_bts having count(distinct cdma_freq)=4)
where city_id is not null
group by city_id) a,
(
select a.city_id,
 --sum((case when cdma_freq=160 then 1 else 0 end))/count(distinct (case when cdma_freq=160 then int_id end ))*count(distinct (case when cdma_freq=160 then related_bts end ))  Carrier4BtsNum
count(distinct a.related_bts) Carrier4BtsNum
 from c_carrier a
  where   a.vendor_id=10 and  cdma_freq=160
 group by a.city_id) b,c_region_city r
where a.city_id=b.city_id(+) and a.city_id=r.city_id
group by r.province_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CellNum,
BusyerCellNum,
BusyCellNum  ,
FreeCellNum,
btsNum
)
select a.province_id,
v_date,
0,
10000,
10,a.CellNum,nvl(b.BusyerCellNum,0),nvl(c.BusyCellNum,0),nvl(d.FreeCellNum,0),nvl(a.btsNum,0)
from
(
select r.province_id ,count(distinct a.related_cell) CellNum,count(distinct a.related_bts) btsNum
from c_carrier a,c_cell b,c_region_city r
where a.related_cell=b.int_id and  a.cdma_freq in (283,242,201,160,119) and b.city_id=r.city_id
and a.vendor_id=10 and b.city_id is not null
group by r.province_id ) a,
(
select r.province_id,count(distinct b.int_id) BusyerCellNum
from
(
select r.province_id ,b.related_bts int_id,sum(nvl(a.c006,0)+ nvl(a.c011,0)+nvl(a.c012,0) + nvl(a.c276,0) + nvl(a.c278,0)) temp
from c_tpd_cnt_carr_lc a,c_carrier b,c_region_city r
where a.int_id=b.int_id and a.scan_start_time=v_date and b.vendor_id=10 and b.city_id=r.city_id
group by r.province_id ,b.related_bts) a,c_cell b,c_tpd_sts_bts c,c_erl d,c_region_city r
where a.int_id=c.int_id and b.related_bts=a.int_id
and  c.scan_start_time=v_date and b.vendor_id=10 and d.tchnum=c.nbrAvailCe and b.city_id=r.city_id
and 100*a.temp/(decode(erl02,null,1,0,1,erl02)*360)>75
group by r.province_id
) b,
(
select r.province_id,count(distinct b.int_id) BusyCellNum
from
(
select r.province_id ,b.related_bts int_id,sum(nvl(a.c006,0)+ nvl(a.c011,0)+nvl(a.c012,0) + nvl(a.c276,0) + nvl(a.c278,0)) temp
from c_tpd_cnt_carr_lc a,c_carrier b,c_region_city r
where a.int_id=b.int_id and a.scan_start_time=v_date and b.vendor_id=10 and b.city_id=r.city_id
group by r.province_id ,b.related_bts) a,c_cell b,c_tpd_sts_bts c,c_erl d,c_region_city r
where a.int_id=c.int_id and b.related_bts=a.int_id
and  c.scan_start_time=v_date and b.vendor_id=10 and d.tchnum=c.nbrAvailCe and b.city_id=r.city_id
and 100*a.temp/(decode(erl02,null,1,0,1,erl02)*360)<75
and 100*a.temp/(decode(erl02,null,1,0,1,erl02)*360)>60
group by r.province_id
) c,
(
select r.province_id,count(distinct b.int_id) FreeCellNum
from
(
select b.city_id ,b.related_bts int_id,
sum(nvl(a.c006,0)+ nvl(a.c011,0)+nvl(a.c012,0) + nvl(a.c276,0) + nvl(a.c278,0)) temp
from c_tpd_cnt_carr_lc a,c_carrier b,c_region_city r
where a.int_id=b.int_id and a.scan_start_time=v_date and b.vendor_id=10 and b.city_id=r.city_id
group by b.city_id ,b.related_bts) a,c_cell b,c_tpd_sts_bts c,c_erl d,c_region_city r
where a.int_id=c.int_id and b.related_bts=a.int_id and b.city_id=r.city_id
and  c.scan_start_time=v_date and b.vendor_id=10 and d.tchnum=c.nbrAvailCe
and 100*a.temp/(decode(erl02,null,1,0,1,erl02)*360)<10
group by r.province_id
)d
where a.province_id=b.province_id(+) and a.province_id=c.province_id(+) and c.province_id=d.province_id(+);
commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');



 insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
OnecarrierCellNum,
TwocarrierCellNum,
threecarrierCellNum,
FourcarrierCellNum
)
select a.province_id,
v_date,
0,
10000,
10,count(distinct a.OnecarrierCellNum),
count(distinct a.TwocarrierCellNum) TwocarrierCellNum,
count(distinct a.threecarrierCellNum),
count(distinct a.FourcarrierCellNum)
from
(select province_id ,
case when count(distinct cdma_freq)=1 then max(distinct related_cell) end  OnecarrierCellNum,
case when count(distinct cdma_freq)=2 then max(distinct related_cell) end  TwocarrierCellNum,
case when count(distinct cdma_freq)=3 then max(distinct related_cell) end  threecarrierCellNum,
case when count(distinct cdma_freq)=4 then max(distinct related_cell) end  FourcarrierCellNum
from
c_carrier c,c_region_city r where cdma_freq in (283,242,201,160,119) and vendor_id=10 and c.city_id=r.city_id
group by province_id,related_cell  ) a
group by a.province_id;

commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');


insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CENum,
TCHNum,
Wirecapacity
)
with temp1 as (
select
c.int_id,
round(c.Channel_nbr) CENum,
round(a.l2/360) TCHNum
from C_tpd_cnt_bts_lc a, c_bts c
where a.int_id = c.int_id and a.scan_start_time = v_date
and c.vendor_id=10)
select
r.province_id,
v_date,
0,
10000,
10,
sum(temp1.cenum) cenum,
sum(temp1.tchnum) tchnum,
sum(c_erl.erl02) Wirecapacity
from temp1,c_erl,c_bts ,c_region_city r
where temp1.TCHNum=c_erl.TCHNum and temp1.int_id=c_bts.int_id and c_bts.city_id=r.city_id
group by r.province_id;
commit;
 dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TrafficCarrier1,
TrafficCarrier2,
TrafficCarrier3,
TrafficCarrier4)
select
province_id,
v_date,
0,
10000,
10,
round(nvl(sum(case when cdma_freq=283 then
          round(nvl(a.c006,0)+ nvl(a.c085,0))/360 + (2*nvl(a.L038,0)
          +4*nvl(a.L039,0) + 8*nvl(a.L040,0) + 16*nvl(a.L041,0) +nvl(a.L076,0)
          +2*nvl(a.L077,0) + 4*nvl(a.L078,0) +8*nvl(a.L079,0))/500/360 + (nvl(a.L043,0)
          + 2*nvl(a.L044,0) + 4*nvl(a.L045,0) + 8*nvl(a.L046,0))/500/360  end),0),4) TrafficCarrier1,
round(nvl(sum(case when cdma_freq=201 then
          round( nvl(a.c006,0)+ nvl(a.c085,0))/360 + (2*nvl(a.L038,0) +4*nvl(a.L039,0) + 8*nvl(a.L040,0)
          + 16*nvl(a.L041,0) +nvl(a.L076,0) +2*nvl(a.L077,0) + 4*nvl(a.L078,0) +8*nvl(a.L079,0))/500/360 +
        (nvl(a.L043,0) + 2*nvl(a.L044,0) + 4*nvl(a.L045,0) + 8*nvl(a.L046,0))/500/360   end),0),4) TrafficCarrier2,
round(nvl(sum(case when cdma_freq=242 then
        (nvl(a.c006,0)+ nvl(a.c085,0))/360 + (2*nvl(a.L038,0) +4*nvl(a.L039,0) + 8*nvl(a.L040,0) + 16*nvl(a.L041,0) +nvl(a.L076,0) +2*nvl(a.L077,0)
         + 4*nvl(a.L078,0) +8*nvl(a.L079,0))/500/360 +(nvl(a.L043,0) + 2*nvl(a.L044,0) + 4*nvl(a.L045,0) + 8*nvl(a.L046,0))/500/360 end ),0),4)TrafficCarrier3,
         round(nvl(sum(case when  cdma_freq=160  then
      round((nvl(a.c006,0)+ nvl(a.c085,0))/360 + (2*nvl(a.L038,0) +4*nvl(a.L039,0) + 8*nvl(a.L040,0) +
      16*nvl(a.L041,0) +nvl(a.L076,0) +2*nvl(a.L077,0) + 4*nvl(a.L078,0) +8*nvl(a.L079,0))/500/360 +
    (nvl(a.L043,0) + 2*nvl(a.L044,0) + 4*nvl(a.L045,0) + 8*nvl(a.L046,0))/500/360,4) end),0),4)  TrafficCarrier4

from C_tpd_cnt_carr_lc a,c_carrier c,c_region_city r
where a.int_id=c.int_id and c.vendor_id=10 and  c.city_id=r.city_id
and a.scan_start_time= v_date
group by province_id;


commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');


insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
cs_CallBlockFailNum,
TCHBlockFailRate,
AvgRadioFPeriod,
CEAvailNum,
TCHBlockFailNumIncludeHo,
SeriOverflowBtsNum,
OverflowBtsNum
)
select
r.province_id,
v_date,
0,
10000,
10,
sum(t.cs007+t.cs008+ t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 +t.c031 + t.c033 + t.c034 + t.c035 + t.c036) cs_CallBlockFailNum,
round(sum(t.cs007+t.cs008+ t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 +t.c031 + t.c033 + t.c034 + t.c035 + t.c036)/decode(sum(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106),0,1,null,1,
sum(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106))*100,4)  TCHBlockFailRate,
sum(t.l1)/360*60/decode(sum(t.sc017+t.sc018+t.sc040+t.sc041),0,1,null,1,sum(t.sc017+t.sc018+t.sc040+t.sc041)) AvgRadioFPeriod,
sum(t.l1/360) CEAvailNum,
--update-8-25
sum(t.cs007+t.cs008+ t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 + t.c031 + t.c033 + t.c034 + t.c035 + t.c036) TCHBlockFailNumIncludeHo,
sum(case when (t.cs007+t.cs008+t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 + t.c031
 + t.c033 + t.c034 + t.c035 + t.c036)/
decode((t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110
 +t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106),0,1,null,1,(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36+t.sc110
 +t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106))*100 >=3 then 1 else 0 end)  SeriOverflowBtsNum,
sum(case when (t.cs007+t.cs008+t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 + t.c031
+ t.c033 + t.c034 + t.c035 + t.c036)/decode((t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062
+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106),0,1,null,1,(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062
+t.c063+t.vo34+t.vo36+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106))*100 >=1
and (t.cs007+t.cs008+t.a70+t.esc24+ t.esc25+ t.esc26+ t.esc27+t.ec01 + t.ec02 + t.c029 + t.c031 + t.c033 + t.c034
+ t.c035 + t.c036)/decode((t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36
+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106),0,1,null,1,(t.sc019+t.sc020+t.sc032+t.sc033-t.sc160-t.sc162-t.sc164-t.sc166+t.c062+t.c063+t.vo34+t.vo36
+t.sc110+t.sc108+t.vo33+t.vo35+t.sc107+t.sc109+t.vo31+t.vo32+t.sc105+t.sc106))*100 <3 then 1 else 0 end) OverflowBtsNum
from
(select
t1.related_msc related_msc,
t1.city_id city_id,
t1.l1     l1,
t1.cs007  cs007,
t1.cs008  cs008,
t1.a70    a70,
t2.esc24  esc24,
t2.esc25  esc25,
t2.esc26  esc26,
t2.esc27  esc27,
t2.esc28  esc28,
t2.esc29  esc29,
t2.esc30  esc30,
t2.esc32  esc32,
t2.esc34  esc34,
t2.esc35  esc35,
t2.esc43  esc43,
t2.esc44  esc44,
t2.esc45  esc45,
t2.esc46  esc46,
t2.ec01   ec01 ,
t2.ec02   ec02 ,
t2.c006   c006 ,
t2.c008   c008 ,
t2.c011   c011 ,
t2.c012   c012 ,
t2.c029   c029 ,
t2.c031   c031 ,
t2.c033   c033 ,
t2.c034   c034 ,
t2.c035   c035 ,
t2.c036   c036 ,
t2.c085   c085 ,
t2.c086   c086 ,
t2.c276 c276,
t2.c278 c278,
t2.sc017  sc017,
t2.sc018  sc018,
t2.sc019  sc019,
t2.sc020  sc020,
t2.sc022  sc022,
t2.sc023  sc023,
t2.sc024  sc024,
t2.sc032  sc032,
t2.sc033  sc033,
t2.sc036  sc036,
t2.sc037  sc037,
t2.sc040  sc040,
t2.sc041  sc041,
t2.sc048  sc048,
t2.sc050  sc050,
t2.sc051  sc051,
t2.sc053  sc053,
t2.sc054  sc054,
t2.sc056  sc056,
t2.sc057  sc057,
t2.sc059  sc059,
t2.sc104  sc104,
t2.sc105  sc105,
t2.sc106  sc106,
t2.sc110  sc110,
t2.sc108  sc108,
t2.sc107  sc107,
t2.sc109  sc109,
t2.sc115  sc115,
t2.sc116  sc116,
t2.sc117  sc117,
t2.sc118  sc118,
t2.sc119  sc119,
t2.sc159  sc159,
t2.sc160  sc160,
t2.sc161  sc161,
t2.sc162  sc162,
t2.sc163  sc163,
t2.sc164  sc164,
t2.sc165  sc165,
t2.sc166  sc166,
t2.sc167  sc167,
t2.sc168  sc168,
t2.c062   c062,
t2.c063   c063,
t2.vo30   vo30,
t2.vo31   vo31,
t2.vo32   vo32,
t2.vo33   vo33,
t2.vo34   vo34,
t2.vo35   vo35,
t2.vo36   vo36,
t2.vo38   vo38,
t2.vo39   vo39,
t2.vo40   vo40,
t1.cnt1+t2.cnt2 cnt
from
(select
t.related_msc related_msc,
t.city_id   city_id,
sum(c.l1) l1,
sum(c.cs007) cs007,
sum(c.cs008) cs008,
sum(c.a70) a70,
sum(case when round(c.l1/360) > 2.5
then 1 else 0 end) cnt1
from C_tpd_cnt_bts_lc c,c_bts t
where c.int_id = t.int_id
and c.scan_start_time = v_date
group by t.related_msc,t.city_id) t1,
(select
c.related_msc related_msc,
c.city_id city_id,
sum(a.esc24) esc24,
sum(a.esc25) esc25,
sum(a.esc26) esc26,
sum(a.esc27) esc27,
sum(a.esc28) esc28,
sum(a.esc29) esc29,
sum(a.esc30) esc30,
sum(a.esc32) esc32,
sum(a.esc34) esc34,
sum(a.esc35) esc35,
sum(a.esc43) esc43,
sum(a.esc44) esc44,
sum(a.esc45) esc45,
sum(a.esc46) esc46,
sum(a.ec01)  ec01,
sum(a.ec02)  ec02,
sum(a.c006)  c006,
sum(a.c008)  c008,
sum(a.c011)  c011,
sum(a.c012)  c012,
sum(a.c029)  c029,
sum(a.c031)  c031,
sum(a.c033)  c033,
sum(a.c034)  c034,
sum(a.c035)  c035,
sum(a.c036)  c036,
sum(a.c085)  c085,
sum(a.c086)  c086,
sum(a.c276) c276,
sum(a.c278) c278,
sum(a.sc017) sc017,
sum(a.sc018) sc018,
sum(a.sc019) sc019,
sum(a.sc020) sc020,
sum(a.sc022) sc022,
sum(a.sc023) sc023,
sum(a.sc024) sc024,
sum(a.sc032) sc032,
sum(a.sc033) sc033,
sum(a.sc036) sc036,
sum(a.sc037) sc037,
sum(a.sc040) sc040,
sum(a.sc041) sc041,
sum(a.sc048) sc048,
sum(a.sc050) sc050,
sum(a.sc051) sc051,
sum(a.sc053) sc053,
sum(a.sc054) sc054,
sum(a.sc056) sc056,
sum(a.sc057) sc057,
sum(a.sc059) sc059,
sum(a.sc104) sc104,
sum(a.sc105) sc105,
sum(a.sc106) sc106,
sum(a.sc110) sc110,
sum(a.sc108) sc108,
sum(a.sc107) sc107,
sum(a.sc109) sc109,
sum(a.sc115) sc115,
sum(a.sc116) sc116,
sum(a.sc117) sc117,
sum(a.sc118) sc118,
sum(a.sc119) sc119,
sum(a.sc159) sc159,
sum(a.sc160) sc160,
sum(a.sc161) sc161,
sum(a.sc162) sc162,
sum(a.sc163) sc163,
sum(a.sc164) sc164,
sum(a.sc165) sc165,
sum(a.sc166) sc166,
sum(a.sc167) sc167,
sum(a.sc168) sc168,
sum(a.c062) c062,
sum(a.c063) c063,
sum(a.vo30) vo30,
sum(a.vo31) vo31,
sum(a.vo32) vo32,
sum(a.vo33) vo33,
sum(a.vo34) vo34,
sum(a.vo35) vo35,
sum(a.vo36) vo36,
sum(a.vo38) vo38,
sum(a.vo39) vo39,
sum(a.vo40) vo40,
sum(case when a.sc017+a.sc018+a.sc040+a.sc041 >= 3
then 1 else 0 end
+
case when a.sc017+a.sc018
+a.sc040+a.sc041/
decode((a.vo30-a.vo38
+a.vo31-a.vo39+a.vo32-a.vo40
+a.sc104-a.sc115+a.sc105-a.sc116
+a.sc106-a.sc117+a.sc023-a.sc048
+a.sc050-a.esc28-a.sc118-a.esc34
-a.esc43-a.sc159-a.sc160-a.sc194
-a.sc196+a.sc024-a.sc051+a.sc053
-a.esc45-a.sc163-a.sc164-a.sc167
-a.esc30+a.sc036-a.sc054+a.sc056
-a.esc29-a.sc119-a.esc35-a.esc44
-a.sc161-a.sc162-a.sc195-a.sc197
+a.sc037-a.sc057+a.sc059-a.esc46
-a.sc165-a.sc166-a.sc168-a.esc32
+a.c062+a.c063),0,1,null,1,(a.vo30-a.vo38
+a.vo31-a.vo39+a.vo32-a.vo40
+a.sc104-a.sc115+a.sc105-a.sc116+a.sc106-a.sc117+a.sc023-a.sc048
+a.sc050-a.esc28-a.sc118-a.esc34-a.esc43-a.sc159-a.sc160-a.sc194
-a.sc196+a.sc024-a.sc051+a.sc053-a.esc45-a.sc163-a.sc164-a.sc167
-a.esc30+a.sc036-a.sc054+a.sc056-a.esc29-a.sc119-a.esc35-a.esc44
-a.sc161-a.sc162-a.sc195-a.sc197+a.sc037-a.sc057+a.sc059-a.esc46
-a.sc165-a.sc166-a.sc168-a.esc32+a.c062+a.c063))*100 > 2.5
then 1 else 0 end) cnt2
from C_tpd_cnt_carr_lc a,c_carrier c
where a.int_id = c.int_id
and a.scan_start_time = v_date
group by c.related_msc,c.city_id) t2,
(select count(*) cnt_cell from c_cell where do_cell=0) cc
where t1.related_msc = t2.related_msc(+) ) t,c_region_city r
where t.city_id=r.city_id
group by r.province_id;



commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');



-------------------------------------------------------------------------------------------------------10000--end
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
cs_SSHOTraffic,
cs_TrafficIncludeHo         ,
ps_CallTrafficIncludeHo     ,
ps_CallTrafficExcludeHo     ,
LoseCallingNum              ,
cs_LoseCallingNum           ,
cs_TchReqNumIncludeHo       ,
cs_TchSuccNumIncludeHo      ,
cs_TchSuccIncludeHoRate     ,
cs_HardhoReqNum             ,
cs_HardhoSuccNum            ,
cs_HardhoSuccRate           ,
cs_SofthoReqNum             ,
cs_SofthoSuccNum            ,
cs_SofthoSuccRate           ,
cs_SSofthoReqNum            ,
cs_SSofthoSuccNum           ,
cs_SSofthoSuccRate          ,
TchReqNumCallerExcludeHoSms ,
TchSuccNumCallerExcludeHoSms,
TchReqNumCalleeExcludeHoSms ,
TchSuccNumCalleeExcludeHoSms,
TchReqNumExcludeHoSms       ,
TchSuccNumExcludeHoSms      ,
TchReqNumIncludeHoSms       ,
TchSuccNumIncludeHoSms      ,
BtsSysHardHoReqNum          ,
BtsSysHardHoSuccNum         ,
SysSHoReqNum                ,
SysSHoSuccNum               ,
TCHRadioFNum                ,
CallPageReqTotalNum         ,
HardhoReqNum_intra          ,
HardhoSuccNum_intra         ,
HardhoSuccRate_intra        ,
ShoReqNum_intra             ,
ShoSuccNum_intra            ,
ShoSuccRate_intra           ,
HardhoReqNum_Extra          ,
HardhoSuccNum_Extra         ,
HardhoSuccRate_Extra        ,
ShoReqNum_Extra             ,
ShoSuccNum_Extra            ,
ShoSuccRate_Extra           ,
FdwTxTotalFrameExcludeRx    ,
RLPFwdChSizeExcludeRx       ,
RLPFwdChRxSize              ,
FwdChRxRate                 ,
RevTxTotalFrameExcludeRx    ,
RLPRevChSize                ,
RevChRxRate                 ,
BtsSysHardHoSuccRate        ,
SysSHoSuccRate              ,
TchRadioFRate               ,
CallInterruptRate           ,
SShoReqNum_intra            ,
SShoSuccNum_intra           ,
SShoSuccRate_intra          ,
ps_CallPageReqNum,
cs_LoseCallingratio,
carriernum_1x,
cs_SHOTraffic,
cs_TchReqNumHardho,
cs_TchSuccNumHardho,
cs_TchReqNumsoftho,
cs_TchSuccNumsoftho,
cs_CallPageSuccNum,
cs_CallPageReqNum,
TCHLoadTrafficIncludeHo,
TrafficExcludeHo,
cs_TrafficExcludeHo,
TCHLoadTrafficExcludeHo,
ps_TchReqNumHardho ,
ps_TchSuccNumHardho,
ps_TchReqNumsoftho ,
ps_TchSuccNumsoftho,
ps_LoseCallingNum,
ps_HandoffReqNum,
ps_HandoffSuccNum,
ps_HandoffSuccRate,
ps_HardhoReqNum,
ps_HardhoSuccNum,
ps_HardhoSuccRate,
ps_SofthoReqNum,
ps_SofthoSuccNum,
ps_SofthoSuccRate,
ps_SSofthoReqNum,
ps_SSofthoSuccNum,
ps_SSofthoSuccRate,
ps_CallPageSuccNum,
cs_trafficByWalsh,
ps_trafficByWalsh,
LoadTrafficByWalsh,
cs_SHORate,
ps_SHORate,
cs_TchReqNumExcludeHo,
cs_TchSuccNumExcludeHo,
cs_TchFNumExcludeHo,
cs_TchSuccExcludeHoRate,
cs_HandoffReqNum,
cs_HandoffSuccNum,
cs_HandoffSuccRate,
HandoffReqNum_Extra,
HandoffSuccNum_Extra,
HandoffSuccRate_Extra,
ps_SSHOTraffic,
ps_LoseCallingRate,
ps_TchReqNumIncludeHo,
ps_TchSuccNumIncludeHo,
ps_TchFNumIncludeHo,
ps_CallBlockFailNum,
ps_TchSuccIncludeHoRate,
ps_TchReqNumExcludeHo,
ps_TchSuccNumExcludeHo,
ps_TchFNumExcludeHo,
ps_TchSuccExcludeHoRate,
ps_LoseCallingratio,
TchReqNumIncludeHo,
TchReqNumExcludeHo,
TchSuccNumIncludeHo,
TchFNumIncludeHo,
TchSuccIncludeHoRate,
TchSuccNumExcludeHo,
TchFNumExcludeHo,
TchSuccExcludeHoRate,
HandoffReqNum,
HandoffSuccNum,
HandoffSuccRate,
HandoffReqNum_intra,
HandoffSuccNum_intra,
HandoffSuccRate_intra,
cs_CallBlockFailRate,
ChannelNum,
ChannelAvailNum,
ChannelMaxUseNum
)
with a as(
select
r.province_id province_id,
sum(nvl(a.c02,0))  c02,
sum(nvl(a.c05,0))  c05,
sum(nvl(a.escpd29,0)) escpd29,
sum(nvl(a.escpd32,0)) escpd32,
sum(nvl(a.escpd35,0)) escpd35,
sum(nvl(a.escpd44,0)) escpd44,
sum(nvl(a.escpd46,0)) escpd46,
sum(nvl(a.scpd017,0)) scpd017,
sum(nvl(a.scpd018,0)) scpd018,
sum(nvl(a.scpd036,0)) scpd036,
sum(nvl(a.scpd037,0)) scpd037,
sum(nvl(a.scpd040,0)) scpd040,
sum(nvl(a.scpd041,0)) scpd041,
sum(nvl(a.scpd042,0)) scpd042,
sum(nvl(a.scpd043,0)) scpd043,
sum(nvl(a.scpd044,0)) scpd044,
sum(nvl(a.scpd045,0)) scpd045,
sum(nvl(a.scpd046,0)) scpd046,
sum(nvl(a.scpd047,0)) scpd047,
sum(nvl(a.scpd054,0)) scpd054,
sum(nvl(a.scpd056,0)) scpd056,
sum(nvl(a.scpd057,0)) scpd057,
sum(nvl(a.scpd059,0)) scpd059,
sum(nvl(a.scpd104,0)) scpd104,
sum(nvl(a.scpd115,0)) scpd115,
sum(nvl(a.scpd119,0)) scpd119,
sum(nvl(a.scpd161,0)) scpd161,
sum(nvl(a.scpd162,0)) scpd162,
sum(nvl(a.scpd165,0)) scpd165,
sum(nvl(a.scpd166,0)) scpd166,
sum(nvl(a.scpd168,0)) scpd168,
sum(nvl(a.scpd195,0)) scpd195,
sum(nvl(a.scpd197,0)) scpd197,
sum(nvl(a.c006,0)) c006 ,
sum(nvl(a.c008,0)) c008 ,
sum(nvl(a.c011,0)) c011 ,
sum(nvl(a.c012,0)) c012 ,
sum(nvl(a.c062,0)) c062 ,
sum(nvl(a.c063,0)) c063 ,
sum(nvl(a.c085,0)) c085 ,
sum(nvl(a.c086,0)) c086 ,
sum(nvl(a.c152,0)) c152 ,
sum(nvl(a.c153,0)) c153 ,
sum(nvl(a.c264,0)) c264 ,
sum(nvl(a.c276,0)) c276,
sum(nvl(a.c277,0)) c277,
sum(nvl(a.c278,0)) c278,
sum(nvl(a.ec22,0)) ec22 ,
sum(nvl(a.ec23,0)) ec23 ,
sum(nvl(a.esc01,0)) esc01,
sum(nvl(a.esc02,0)) esc02,
sum(nvl(a.esc03,0)) esc03,
sum(nvl(a.esc04,0)) esc04,
sum(nvl(a.esc05,0)) esc05,
sum(nvl(a.esc06,0)) esc06,
sum(nvl(a.esc07,0)) esc07,
sum(nvl(a.esc08,0)) esc08,
sum(nvl(a.esc09,0)) esc09,
sum(nvl(a.esc12,0)) esc12,
sum(nvl(a.esc13,0)) esc13,
sum(nvl(a.esc14,0)) esc14,
sum(nvl(a.esc15,0)) esc15,
sum(nvl(a.esc16,0)) esc16,
sum(nvl(a.esc17,0)) esc17,
sum(nvl(a.esc18,0)) esc18,
sum(nvl(a.esc19,0)) esc19,
sum(nvl(a.esc20,0)) esc20,
sum(nvl(a.esc21,0)) esc21,
sum(nvl(a.esc22,0)) esc22,
sum(nvl(a.esc23,0)) esc23,
sum(nvl(a.esc28,0)) esc28,
sum(nvl(a.esc29,0)) esc29,
sum(nvl(a.esc30,0)) esc30,
sum(nvl(a.esc32,0)) esc32,
sum(nvl(a.esc34,0)) esc34,
sum(nvl(a.esc35,0)) esc35,
sum(nvl(a.esc43,0)) esc43,
sum(nvl(a.esc44,0)) esc44,
sum(nvl(a.esc45,0)) esc45,
sum(nvl(a.esc46,0)) esc46,
sum(nvl(a.L037,0)) L037 ,
sum(nvl(a.L038,0)) L038 ,
sum(nvl(a.L039,0)) L039 ,
sum(nvl(a.L040,0)) L040 ,
sum(nvl(a.L041,0)) L041 ,
sum(nvl(a.L042,0)) L042 ,
sum(nvl(a.L043,0)) L043 ,
sum(nvl(a.L044,0)) L044 ,
sum(nvl(a.L045,0)) L045 ,
sum(nvl(a.L046,0)) L046 ,
sum(nvl(a.L076,0)) L076 ,
sum(nvl(a.L077,0)) L077 ,
sum(nvl(a.L078,0)) L078 ,
sum(nvl(a.L079,0)) L079 ,
sum(nvl(a.L097,0)) L097 ,
sum(nvl(a.L098,0)) L098 ,
sum(nvl(a.L099,0)) L099 ,
sum(nvl(a.sc015,0)) sc015,
sum(nvl(a.sc016,0)) sc016,
sum(nvl(a.sc017,0)) sc017,
sum(nvl(a.sc018,0)) sc018,
sum(nvl(a.sc019,0)) sc019,
sum(nvl(a.sc020,0)) sc020,
sum(nvl(a.sc021,0)) sc021,
sum(nvl(a.sc022,0)) sc022,
sum(nvl(a.sc023,0)) sc023,
sum(nvl(a.sc024,0)) sc024,
sum(nvl(a.sc032,0)) sc032,
sum(nvl(a.sc033,0)) sc033,
sum(nvl(a.sc036,0)) sc036,
sum(nvl(a.sc037,0)) sc037,
sum(nvl(a.sc038,0)) sc038,
sum(nvl(a.sc039,0)) sc039,
sum(nvl(a.sc040,0)) sc040,
sum(nvl(a.sc041,0)) sc041,
sum(nvl(a.sc042,0)) sc042,
sum(nvl(a.sc043,0)) sc043,
sum(nvl(a.sc044,0)) sc044,
sum(nvl(a.sc045,0)) sc045,
sum(nvl(a.sc046,0)) sc046,
sum(nvl(a.sc047,0)) sc047,
sum(nvl(a.sc048,0)) sc048,
sum(nvl(a.sc050,0)) sc050,
sum(nvl(a.sc051,0)) sc051,
sum(nvl(a.sc053,0)) sc053,
sum(nvl(a.sc054,0)) sc054,
sum(nvl(a.sc056,0)) sc056,
sum(nvl(a.sc057,0)) sc057,
sum(nvl(a.sc059,0)) sc059,
sum(nvl(a.sc068,0)) sc068,
sum(nvl(a.sc069,0)) sc069,
sum(nvl(a.sc070,0)) sc070,
sum(nvl(a.sc071,0)) sc071,
sum(nvl(a.sc104,0)) sc104,
sum(nvl(a.sc105,0)) sc105,
sum(nvl(a.sc106,0)) sc106,
sum(nvl(a.sc107,0)) sc107,
sum(nvl(a.sc108,0)) sc108,
sum(nvl(a.sc109,0)) sc109,
sum(nvl(a.sc110,0)) sc110,
sum(nvl(a.sc111,0)) sc111,
sum(nvl(a.sc112,0)) sc112,
sum(nvl(a.sc113,0)) sc113,
sum(nvl(a.sc114,0)) sc114,
sum(nvl(a.sc115,0)) sc115,
sum(nvl(a.sc116,0)) sc116,
sum(nvl(a.sc117,0)) sc117,
sum(nvl(a.sc118,0)) sc118,
sum(nvl(a.sc119,0)) sc119,
sum(nvl(a.sc159,0)) sc159,
sum(nvl(a.sc160,0)) sc160,
sum(nvl(a.sc161,0)) sc161,
sum(nvl(a.sc162,0)) sc162,
sum(nvl(a.sc163,0)) sc163,
sum(nvl(a.sc164,0)) sc164,
sum(nvl(a.sc165,0)) sc165,
sum(nvl(a.sc166,0)) sc166,
sum(nvl(a.sc167,0)) sc167,
sum(nvl(a.sc168,0)) sc168,
sum(nvl(a.sc195,0)) sc195,
sum(nvl(a.sc197,0)) sc197,
sum(nvl(a.vo13,0)) vo13 ,
sum(nvl(a.vo16,0)) vo16 ,
sum(nvl(a.vo20,0)) vo20 ,
sum(nvl(a.vo30,0)) vo30 ,
sum(nvl(a.vo31,0)) vo31 ,
sum(nvl(a.vo32,0)) vo32 ,
sum(nvl(a.vo33,0)) vo33 ,
sum(nvl(a.vo34,0)) vo34 ,
sum(nvl(a.vo35,0)) vo35 ,
sum(nvl(a.vo36,0)) vo36 ,
sum(nvl(a.vo37,0)) vo37 ,
sum(nvl(a.vo38,0)) vo38 ,
sum(nvl(a.vo39,0)) vo39 ,
sum(nvl(a.vo40,0)) vo40,
sum(nvl(a.c02,0)+nvl(a.c05,0))/360  cs_trafficByWalsh,
sum(a.c04)*10/3600    ps_trafficByWalsh,
sum(nvl(a.c02,0)+nvl(a.c05,0))/360  LoadTrafficByWalsh,
sum(nvl(c04,0)) v1
from C_TPD_1X_SUM_LC_TEMP a,c_cell c,c_region_city r
where  a.unique_rdn = c.unique_rdn and a.scan_start_time = v_date and a.vendor_id=10 and c.city_id=r.city_id
group by r.province_id),
b as(
select
r.province_id  province_id,
sum(nvl(a.c006,0))  c006,
sum(nvl(a.c276,0))  c276,
sum(nvl(a.c278,0))  c278,
count(distinct c.int_id) CARRIERNUM_1X,
sum(nvl(c008,0)+nvl(c277,0)+nvl(c279,0))/360 cs_SHOTraffic,
sum(nvl(vo34,0)+nvl(vo36,0)+nvl(vo33,0)+nvl(vo35,0)+nvl(sc110,0)+nvl(sc108,0)+nvl(sc107,0)+nvl(sc109,0)) cs_TchReqNumHardho,
sum(nvl(vo16,0)+nvl(vo20,0)+nvl(vo13,0)+nvl(vo37,0)+nvl(sc112,0)+nvl(sc114,0) +nvl(sc111,0)+nvl(sc113,0)) cs_TchSuccNumHardho,
sum(nvl(vo30,0)+nvl(vo31,0)+nvl(vo32,0)+nvl(sc104,0)+nvl(sc105,0)+nvl(sc106,0)) cs_TchReqNumsoftho,
sum(nvl(vo31,0)-nvl(vo39,0) +nvl(vo32,0)-nvl(vo40,0) + nvl(sc105,0)-nvl(sc116,0)+nvl(sc106,0)-nvl(sc117,0)) cs_TchSuccNumsoftho,
-----------------
sum(
(case when
(nvl(sc019,0)-nvl(esc03,0)-nvl(esc01,0)-nvl(esc05,0)+nvl(esc13,0)-nvl(sc015,0)-nvl(sc160,0))>0 then
(nvl(sc019,0)-nvl(esc03,0)-nvl(esc01,0)-nvl(esc05,0)+nvl(esc13,0)-nvl(sc015,0)-nvl(sc160,0)) else 0 end)
+
(case when
(nvl(sc020,0)-nvl(esc04,0)-nvl(esc02,0)-nvl(esc06,0)-nvl(esc12,0)-nvl(sc016,0)-nvl(esc07,0)-nvl(esc08,0)-nvl(esc09,0)-nvl(sc164,0))>0 then
(nvl(sc020,0)-nvl(esc04,0)-nvl(esc02,0)-nvl(esc06,0)-nvl(esc12,0)-nvl(sc016,0)-nvl(esc07,0)-nvl(esc08,0)-nvl(esc09,0)-nvl(sc164,0)) else 0 end)
+
(case when
(nvl(sc032,0)-nvl(esc14,0)-nvl(esc16,0)-nvl(esc18,0)-nvl(sc038,0)-nvl(sc162,0))>0 then
(nvl(sc032,0)-nvl(esc14,0)-nvl(esc16,0)-nvl(esc18,0)-nvl(sc038,0)-nvl(sc162,0))  else 0 end)
+
(case when
(nvl(sc033,0)-nvl(esc15,0)-nvl(esc17,0)-nvl(esc19,0)-nvl(esc20,0)-nvl(sc039,0)-nvl(esc21,0)-nvl(esc22,0)-nvl(esc23,0)-nvl(sc166,0))>0 then
(nvl(sc033,0)-nvl(esc15,0)-nvl(esc17,0)-nvl(esc19,0)-nvl(esc20,0)-nvl(sc039,0)-nvl(esc21,0)-nvl(esc22,0)-nvl(esc23,0)-nvl(sc166,0)) else 0 end )
) cs_CallPageSuccNum,
sum(
(case when
(nvl(sc023 ,0)-nvl(sc048 ,0)+nvl(sc050 ,0)+ nvl(sc042,0) +nvl(sc044 ,0)+nvl(sc046 ,0)-nvl(esc28 ,0)-nvl(sc118 ,0)-nvl(esc34 ,0)-nvl(esc43 ,0)-nvl(sc159 ,0)-nvl(sc160 ,0)-nvl(sc194 ,0)-nvl(sc196 ,0))>0 then
(nvl(sc023 ,0)-nvl(sc048 ,0)+nvl(sc050 ,0)+ nvl(sc042,0) +nvl(sc044 ,0)+nvl(sc046 ,0)-nvl(esc28 ,0)-nvl(sc118 ,0)-nvl(esc34 ,0)-nvl(esc43 ,0)-nvl(sc159 ,0)-nvl(sc160 ,0)-nvl(sc194 ,0)-nvl(sc196 ,0)) else 0 end)
+
(case when
(nvl(sc024 ,0)-nvl(sc051,0)+ nvl(sc053 ,0)+ nvl(sc043 ,0)+ nvl(sc045 ,0)+ nvl(sc047 ,0)- nvl(esc45 ,0)- nvl(sc163 ,0)- nvl(sc164 ,0)-nvl(sc167 ,0)-nvl(esc30 ,0))>0 then
(nvl(sc024 ,0)-nvl(sc051,0)+ nvl(sc053 ,0)+ nvl(sc043 ,0)+ nvl(sc045 ,0)+ nvl(sc047 ,0)- nvl(esc45 ,0)- nvl(sc163 ,0)- nvl(sc164 ,0)-nvl(sc167 ,0)-nvl(esc30 ,0)) else 0 end)
+
(case when
(nvl(sc037,0)-nvl(sc057,0)+nvl(sc059,0)-nvl(sc043,0)-nvl(sc045,0)-nvl(sc047,0)-nvl(esc46,0)-nvl(sc165,0)-nvl(sc166,0)-nvl(sc168,0)-nvl(esc32,0))>0 then
(nvl(sc037,0)-nvl(sc057,0)+nvl(sc059,0)-nvl(sc043,0)-nvl(sc045,0)-nvl(sc047,0)-nvl(esc46,0)-nvl(sc165,0)-nvl(sc166,0)-nvl(sc168,0)-nvl(esc32,0)) else 0 end)
+
(case when
(nvl(sc036,0)-nvl(sc054,0)+nvl(sc056,0)-nvl(sc042,0)- nvl(sc044,0)-nvl(sc046,0)-nvl(esc29,0)-nvl(sc119,0)-nvl(esc35,0)-nvl(esc44,0)-nvl(sc161,0)-nvl(sc162,0)-nvl(sc195,0)-nvl(sc197,0))>0 then
(nvl(sc036,0)-nvl(sc054,0)+nvl(sc056,0)-nvl(sc042,0)- nvl(sc044,0)-nvl(sc046,0)-nvl(esc29,0)-nvl(sc119,0)-nvl(esc35,0)-nvl(esc44,0)-nvl(sc161,0)-nvl(sc162,0)-nvl(sc195,0)-nvl(sc197,0)) else 0 end)
)  cs_CallPageReqNum,
round(sum(nvl(a.c006,0) + nvl(a.c011,0)+nvl(a.c012,0)+nvl(a.c276,0) + nvl(a.c278,0))/360,4) TCHLoadTrafficIncludeHo,
sum(nvl(a.c006,0)-nvl(a.c008,0)+nvl(a.c011,0)-nvl(a.c013,0)+nvl(a.c012,0)-nvl(a.c014,0) +nvl(a.c276,0)-nvl(a.c277,0)
+nvl(a.c278,0)-nvl(a.c279,0)+nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360 TrafficExcludeHo ,
sum(nvl(a.c006,0)-nvl(a.c008,0) +nvl(a.c011,0)-nvl(a.c013,0) +nvl(a.c012,0)
-nvl(a.c014,0) +nvl(a.c276,0)-nvl(a.c277,0) +nvl(a.c278,0)-nvl(a.c279,0))/360  cs_TrafficExcludeHo,
sum(nvl(a.c006,0)-nvl(a.c008,0)+nvl(a.c011,0)- nvl(a.c013,0) + nvl(a.c012,0)-nvl(a.c014,0)+nvl(a.c276,0)-nvl(a.c277,0)+nvl(a.c278,0)-nvl(a.c279,0))/360 TCHLoadTrafficExcludeHo,
sum(nvl(scpd107,0)+nvl(scpd108,0)+nvl(scpd109,0)+nvl(scpd110,0)) ps_TchReqNumHardho,
sum(nvl(scpd111,0)+nvl(scpd112,0)+nvl(scpd113,0)+nvl(scpd114,0)) ps_TchSuccNumHardho,
sum(nvl(scpd104,0)+nvl(scpd105,0)+nvl(scpd106,0)) ps_TchReqNumsoftho,
sum(nvl(scpd104,0)-nvl(scpd115,0)+nvl(scpd105,0)-nvl(scpd116,0)+nvl(scpd106,0)-nvl(scpd117,0)) ps_TchSuccNumsoftho,
sum(nvl(a.scpd017,0) + nvl(a.scpd018,0) + nvl(a.scpd040,0) + nvl(a.scpd041,0)) ps_LoseCallingNum ,
sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0) + nvl(a.scpd105,0) + nvl(a.scpd106,0) + nvl(a.scpd104,0)) ps_HandoffReqNum  ,
sum(nvl(a.scpd105,0) - nvl(a.scpd116,0) + nvl(a.scpd106,0) - nvl(a.scpd117,0) + nvl(a.scpd104,0) - nvl(a.scpd115,0) + nvl(a.scpd111,0) + nvl(a.scpd112,0) + nvl(a.scpd113,0) + nvl(a.scpd114,0)) ps_HandoffSuccNum ,
round(sum(nvl(a.scpd105,0) - nvl(a.scpd116,0) + nvl(a.scpd106,0) - nvl(a.scpd117,0) + nvl(a.scpd104,0) - nvl(a.scpd115,0) + nvl(a.scpd111,0) + nvl(a.scpd112,0) + nvl(a.scpd113,0) + nvl(a.scpd114,0))/
decode(sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0) + nvl(a.scpd105,0) + nvl(a.scpd106,0) + nvl(a.scpd104,0)),0,1,null,1,sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0) + nvl(a.scpd105,0) + nvl(a.scpd106,0) + nvl(a.scpd104,0)))*100,4) ps_HandoffSuccRate,
sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0)) ps_HardhoReqNum   ,
sum(nvl(a.scpd111,0) + nvl(a.scpd112,0) + nvl(a.scpd113,0) + nvl(a.scpd114,0)) ps_HardhoSuccNum  ,
round(sum(nvl(a.scpd111,0) + nvl(a.scpd112,0) + nvl(a.scpd113,0) + nvl(a.scpd114,0))/decode(sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0)),0,1,null,1,sum(nvl(a.scpd107,0) + nvl(a.scpd108,0) + nvl(a.scpd109,0) + nvl(a.scpd110,0)))*100,4) ps_HardhoSuccRate ,
sum(nvl(a.scpd105,0) + nvl(a.scpd106,0)) ps_SofthoReqNum   ,
sum(nvl(a.scpd105,0) - nvl(a.scpd116,0) + nvl(a.scpd106,0) - nvl(a.scpd117,0)) ps_SofthoSuccNum  ,
round(sum(nvl(a.scpd105,0) - nvl(a.scpd116,0) + nvl(a.scpd106,0) - nvl(a.scpd117,0))/decode(sum(nvl(a.scpd105,0) + nvl(a.scpd106,0)),0,1,null,1,sum(nvl(a.scpd105,0) + nvl(a.scpd106,0)))*100,4) ps_SofthoSuccRate ,
sum(nvl(a.scpd104,0)) ps_SSofthoReqNum  ,
sum(nvl(a.scpd104,0)- nvl(a.scpd115,0)) ps_SSofthoSuccNum ,
round(sum(nvl(a.scpd104,0)- nvl(a.scpd115,0))/decode(sum(a.scpd104),0,1,null,1,sum(a.scpd104))*100,4)   ps_SSofthoSuccRate,
sum(
case when(nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)) > 0
then nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0) else 0 end)
+
sum(
case when(nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) > 0
then nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0) else 0 end) ps_CallPageSuccNum,
sum(nvl(a.c008,0)
+nvl(a.c277,0)
+nvl(a.c279,0)) cs_SHORate_up,
sum(nvl(a.c006,0)
-nvl(a.c008,0)
+nvl(a.c011,0)
-nvl(a.c013,0)
+nvl(a.c012,0)
-nvl(a.c014,0)
+nvl(a.c276,0)
-nvl(a.c277,0)
+nvl(a.c278,0)
-nvl(a.c279,0)
+nvl(a.c008,0)
+nvl(a.c277,0)
+nvl(a.c279,0)) cs_SHORate_down,
sum(nvl(a.c085,0)-nvl(a.c276,0) - nvl(a.c085,0)+nvl(a.c086,0) + nvl(a.c276,0)-nvl(a.c277,0)) ps_SHORate_up,
sum(nvl(a.c085,0)-nvl(a.c276,0)) ps_SHORate_down,
sum(nvl(a.sc017,0)+nvl(a.sc018,0)
+nvl(a.sc040,0)+nvl(a.sc041,0)) cs_LoseCallingRate_up,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) cs_LoseCallingRate_down,
60*sum(nvl(a.c006,0)
-nvl(a.c008,0)
+nvl(a.c011,0)
-nvl(a.c013,0)
+nvl(a.c012,0)
-nvl(a.c014,0)
+nvl(a.c276,0)
-nvl(a.c277,0)
+nvl(a.c278,0)
-nvl(a.c279,0))/360 cs_LoseCallingratio_up,
sum(nvl(a.sc017,0)
+nvl(a.sc018,0)
+nvl(a.sc040,0)
+nvl(a.sc041,0)) cs_LoseCallingratio_down,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) cs_TchReqNumExcludeHo,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) cs_TchSuccNumExcludeHo,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) cs_TchFNumExcludeHo_a1,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) cs_TchFNumExcludeHo_a2,
sum(nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)
+nvl(a.vo30 ,0)
+nvl(a.sc104,0)) cs_HandoffReqNum,
sum(nvl(a.vo16,0)
+nvl(a.vo20 ,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)
+nvl(a.vo30 ,0)
-nvl(a.vo38 ,0)
+nvl(a.sc104,0)
-nvl(a.sc115,0)) cs_HandoffSuccNum,
sum(nvl(a.vo34,0)
+nvl(a.vo36 ,0)
+nvl(a.sc108,0)
+nvl(a.sc110,0)
+nvl(a.vo32 ,0)
+nvl(a.sc106,0)) HandoffReqNum_Extra,
sum(nvl(a.vo16,0)
+nvl(a.vo20 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)) HandoffSuccNum_Extra,
sum(nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360 v2,
sum(nvl(a.scpd017,0)
+nvl(a.scpd018,0)
+nvl(a.scpd040,0)
+nvl(a.scpd041,0)) ps_LoseCallingRate_up,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) ps_LoseCallingRate_down,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) ps_TchReqNumIncludeHo,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) ps_TchSuccNumIncludeHo,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) ps_TchFNumIncludeHo_b1,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) ps_TchFNumIncludeHo_b2,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)) ps_TchReqNumExcludeHo,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) ps_TchSuccNumExcludeHo,
60*sum(nvl(a.c006,0)
-nvl(a.c008,0)
+nvl(a.c011,0)
-nvl(a.c013,0)
+nvl(a.c012,0)
-nvl(a.c014,0)
+nvl(a.c276,0)
-nvl(a.c277,0)
+nvl(a.c278,0)
-nvl(a.c279,0)
+nvl(a.c085,0)
-nvl(a.c086,0)
-nvl(a.c276,0)
+nvl(a.c277,0))/360 LoseCallingratio_up,
sum(nvl(a.sc017,0)
+nvl(a.sc018,0)
+nvl(a.sc040,0)
+nvl(a.sc041,0)) LoseCallingratio_down_a,
60*sum(nvl(a.c085,0)
-nvl(a.c086,0)
-nvl(a.c276,0)
+nvl(a.c277,0))/360 ps_LoseCallingratio_up,
sum(nvl(a.sc019,0)
+nvl(a.sc020,0)
+nvl(a.sc032,0)
+nvl(a.sc033,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)
+nvl(a.c062 ,0)
+nvl(a.c063 ,0)
+nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)) TchReqNumIncludeHo_a,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) TchReqNumExcludeHo_a,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)
+nvl(a.c152 ,0)
+nvl(a.c153 ,0)
+nvl(a.vo16 ,0)
+nvl(a.vo20 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)) TchSuccNumIncludeHo_a,
sum(nvl(a.sc019,0)
+nvl(a.sc020,0)
+nvl(a.sc032,0)
+nvl(a.sc033,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)
+nvl(a.c062 ,0)
+nvl(a.c063 ,0)
+nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)) TchFNumIncludeHo_a1,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)
+nvl(a.c152 ,0)
+nvl(a.c153 ,0)
+nvl(a.vo16 ,0)
+nvl(a.vo20 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)) TchFNumIncludeHo_a2,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)
+nvl(a.c152 ,0)
+nvl(a.c153 ,0)
+nvl(a.vo16 ,0)
+nvl(a.vo20 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)) TchSuccIncludeHoRate_up_a,
sum(nvl(a.sc019,0)
+nvl(a.sc020,0)
+nvl(a.sc032,0)
+nvl(a.sc033,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)
+nvl(a.c062 ,0)
+nvl(a.c063 ,0)
+nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)) TchSuccIncludeHoRate_down_a,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) TchSuccNumExcludeHo_a,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) TchFNumExcludeHo_a1,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) TchFNumExcludeHo_a2,
sum(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0)) TchSuccExcludeHoRate_up_a,
sum(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
+nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)) TchSuccExcludeHoRate_down_a,
sum(nvl(a.vo34,0)
+nvl(a.vo36 ,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)
+nvl(a.vo30 ,0)
+nvl(a.sc104,0)) HandoffReqNum_a,
sum(nvl(a.vo16 ,0)
+nvl(a.vo20 ,0)
+nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc112,0)
+nvl(a.sc114,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.vo32 ,0)
-nvl(a.vo40 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.sc106,0)
-nvl(a.sc117,0)
+nvl(a.vo30 ,0)
-nvl(a.vo38 ,0)
+nvl(a.sc104,0)
-nvl(a.sc115,0)) HandoffSuccNum_a,
sum(nvl(a.vo33,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.sc105,0)
+nvl(a.vo30 ,0)
+nvl(a.sc104,0))  HandoffReqNum_intra_a,
sum(nvl(a.vo13 ,0)
+nvl(a.vo37 ,0)
+nvl(a.sc111,0)
+nvl(a.sc113,0)
+nvl(a.vo31 ,0)
-nvl(a.vo39 ,0)
+nvl(a.sc105,0)
-nvl(a.sc116,0)
+nvl(a.vo30 ,0)
+nvl(a.sc104,0)) HandoffSuccNum_intra_a,
sum(nvl(a.scpd017,0)
+nvl(a.scpd018,0)
+nvl(a.scpd040,0)
+nvl(a.scpd041,0)) LoseCallingratio_down_b,
sum(nvl(a.scpd017,0)
+nvl(a.scpd018,0)
+nvl(a.scpd040,0)
+nvl(a.scpd041,0)) ps_LoseCallingratio_down,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) TchReqNumIncludeHo_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)) TchReqNumExcludeHo_b,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) TchSuccNumIncludeHo_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) TchFNumIncludeHo_b1,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) TchFNumIncludeHo_b2,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)) TchSuccIncludeHoRate_up_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)
+nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd104,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)) TchSuccIncludeHoRate_down_b,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) TchSuccNumExcludeHo_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)) TchFNumExcludeHo_b1,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) TchFNumExcludeHo_b2,
sum(nvl(a.scpd019,0)
-nvl(a.escpd03,0)
-nvl(a.escpd01,0)
-nvl(a.escpd05,0)
+nvl(a.escpd13,0)
-nvl(a.scpd015,0)
-nvl(a.scpd160,0)
+nvl(a.scpd032,0)
-nvl(a.escpd14,0)
-nvl(a.escpd16,0)
-nvl(a.escpd18,0)
-nvl(a.scpd038,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
-nvl(a.escpd04,0)
-nvl(a.escpd02,0)
-nvl(a.escpd06,0)
-nvl(a.escpd12,0)
-nvl(a.scpd016,0)
-nvl(a.escpd07,0)
-nvl(a.escpd08,0)
-nvl(a.escpd09,0)
-nvl(a.scpd164,0)
+nvl(a.scpd033,0)
-nvl(a.escpd15,0)
-nvl(a.escpd17,0)
-nvl(a.escpd19,0)
-nvl(a.escpd20,0)
-nvl(a.scpd039,0)
-nvl(a.escpd21,0)
-nvl(a.escpd22,0)
-nvl(a.escpd23,0)
-nvl(a.scpd166,0)) TchSuccExcludeHoRate_up_b,
sum(nvl(a.scpd019,0)
+nvl(a.scpd032,0)
-nvl(a.scpd160,0)
-nvl(a.scpd162,0)
+nvl(a.scpd020,0)
+nvl(a.scpd033,0)
-nvl(a.scpd164,0)
-nvl(a.scpd166,0)) TchSuccExcludeHoRate_down_b,
sum(nvl(a.scpd107,0)
+nvl(a.scpd108,0)
+nvl(a.scpd109,0)
+nvl(a.scpd110,0)
+nvl(a.scpd105,0)
+nvl(a.scpd106,0)
+nvl(a.scpd104,0)) HandoffReqNum_b,
sum(nvl(a.scpd105,0)
-nvl(a.scpd116,0)
+nvl(a.scpd106,0)
-nvl(a.scpd117,0)
+nvl(a.scpd104,0)
-nvl(a.scpd115,0)
+nvl(a.scpd111,0)
+nvl(a.scpd112,0)
+nvl(a.scpd113,0)
+nvl(a.scpd114,0)) HandoffSuccNum_b,
sum(nvl(a.scpd104,0)) HandoffReqNum_intra_b,
sum(nvl(a.scpd104,0)) HandoffSuccNum_intra_b,
sum(nvl(a.esc24,0)
+nvl(a.esc25,0)
+nvl(a.esc26,0)
+nvl(a.esc27,0)
+nvl(a.ec01 ,0)
+nvl(a.ec02 ,0)
+nvl(a.c029 ,0)
+nvl(a.c031 ,0)
+nvl(a.c033 ,0)
+nvl(a.c034 ,0)
+nvl(a.c035 ,0)
+nvl(a.c036 ,0))  cs_CallBlockFailRate_up_a,
sum(nvl(a.sc019,0)
+nvl(a.sc020,0)
+nvl(a.sc032,0)
+nvl(a.sc033,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0)
+nvl(a.c062 ,0)
+nvl(a.c063 ,0)
+nvl(a.vo34 ,0)
+nvl(a.vo36 ,0)
+nvl(a.sc110,0)
+nvl(a.sc108,0)
+nvl(a.vo33 ,0)
+nvl(a.vo35 ,0)
+nvl(a.sc107,0)
+nvl(a.sc109,0)
+nvl(a.vo31 ,0)
+nvl(a.vo32 ,0)
+nvl(a.sc105,0)
+nvl(a.sc106,0)) cs_CallBlockFailRate_down
from C_TPD_1X_SUM_LC_TEMP a,c_carrier c,c_region_city r
where  a.int_id = c.int_id
and a.scan_start_time = v_date and a.vendor_id=10 and c.city_id=r.city_id
group by r.province_id
),
c as(
select
r.province_id,
sum(nvl(a.cs007,0)
+nvl(a.cs008,0)
+nvl(a.a70  ,0)) cs_CallBlockFailRate_up_b,
round(sum(l1)) ChannelNum,
round(sum(l1)/360) ChannelAvailNum,
sum(cs004) ChannelMaxUseNum
from C_TPD_1X_SUM_LC_TEMP a,c_bts,c_region_city r
where a.int_id = c_bts.int_id and a.scan_start_time = v_date and c_bts.city_id=r.city_id
group by r.province_id
)
select
a.province_id,
v_date,
0,
10000,
10,
(nvl(a.c02,0)+nvl(a.c05,0))/360-(nvl(b.c006,0)+nvl(b.c276,0)+nvl(b.c278,0))/360  cs_SSHOTraffic,
round((nvl(a.c006,0) +nvl(a.c011,0)+nvl(a.c012,0)+ nvl(a.c276,0) + nvl(a.c278,0))/360,4) cs_TrafficIncludeHo,
round((nvl(a.c085,0)-nvl(a.c276,0))/360,4) ps_CallTrafficIncludeHo,
round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4)  ps_CallTrafficExcludeHo,
round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4)+round(nvl(a.scpd017,0)+nvl(a.scpd018,0)+nvl(a.scpd040,0)+nvl(a.scpd041,0),4) LoseCallingNum,
round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4) cs_LoseCallingNum,
round(nvl(a.sc019,0)+nvl(a.sc020,0)+nvl(a.sc032,0)+nvl(a.sc033,0)-nvl(a.sc160,0)-nvl(a.sc162,0)-nvl(a.sc164,0)-nvl(a.sc166,0)+nvl(a.c062,0)+nvl(a.c063,0)+nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc105,0)+nvl(a.sc106,0),4) cs_TchReqNumIncludeHo,
round(nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0)+nvl(a.c152,0)+nvl(a.c153,0)+nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0)+nvl(a.vo31,0)-nvl(a.vo39,0)+nvl(a.vo32,0)-nvl(a.vo40,0)+nvl(a.sc105,0)-nvl(a.sc116,0)+nvl(a.sc106,0)-nvl(a.sc117,0),4) cs_TchSuccNumIncludeHo,
round(100*(nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0)+nvl(a.c152,0)+nvl(a.c153,0)+nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0)+nvl(a.vo31,0)-nvl(a.vo39,0)+nvl(a.vo32,0)-nvl(a.vo40,0)+nvl(a.sc105,0)-nvl(a.sc116,0)+nvl(a.sc106,0)-nvl(a.sc117,0))/
decode(nvl(a.sc019,0)+nvl(a.sc020,0)+nvl(a.sc032,0)+nvl(a.sc033,0)-nvl(a.sc160,0)-nvl(a.sc162,0)-nvl(a.sc164,0)-nvl(a.sc166,0)+nvl(a.c062,0)+nvl(a.c063,0)+nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc105,0)+nvl(a.sc106,0),0,1,null,1,nvl(a.sc019,0)+nvl(a.sc020,0)+nvl(a.sc032,0)+nvl(a.sc033,0)-nvl(a.sc160,0)-nvl(a.sc162,0)-nvl(a.sc164,0)-nvl(a.sc166,0)+nvl(a.c062,0)+nvl(a.c063,0)+nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc105,0)+nvl(a.sc106,0)),4)      cs_TchSuccIncludeHoRate,
round(nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.sc107,0)+nvl(a.sc109,0),4) cs_HardhoReqNum,
round(nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.sc111,0)+nvl(a.sc113,0),4) cs_HardhoSuccNum,
case when  nvl(a.vo34,0) + nvl(a.vo36,0) +nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc110,0) + nvl(a.sc108,0) + nvl(a.sc107,0) + nvl(a.sc109,0) is  null then 100
     when  nvl(a.vo34,0) + nvl(a.vo36,0) +nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc110,0) + nvl(a.sc108,0) + nvl(a.sc107,0) + nvl(a.sc109,0) =  0     then  100
else round(100*(nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.sc111,0)+nvl(a.sc113,0))/decode(
  nvl(a.vo34,0) + nvl(a.vo36,0) +nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc110,0) + nvl(a.sc108,0) + nvl(a.sc107,0) + nvl(a.sc109,0),0,1,nvl(a.vo34,0) + nvl(a.vo36,0) +nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc110,0) + nvl(a.sc108,0) + nvl(a.sc107,0) + nvl(a.sc109,0)),4)
end cs_HardhoSuccRate,
round(nvl(a.vo31,0) + nvl(a.vo32,0) + nvl(a.sc105,0) + nvl(a.sc106,0),4)  cs_SofthoReqNum ,
round(nvl(a.vo31,0) - nvl(a.vo39,0) + nvl(a.vo32 ,0) - nvl(a.vo40 ,0)+ nvl(a.sc105,0)- nvl(a.sc116,0) + nvl(a.sc106,0) - nvl(a.sc117,0),4)  cs_SofthoSuccNum ,
round(100*(nvl(a.vo31,0) - nvl(a.vo39,0) + nvl(a.vo32 ,0) - nvl(a.vo40 ,0)+ nvl(a.sc105,0)- nvl(a.sc116,0) + nvl(a.sc106,0) - nvl(a.sc117,0))/
decode(nvl(a.vo31,0) + nvl(a.vo32,0) + nvl(a.sc105,0) + nvl(a.sc106,0),0,1,null,1,nvl(a.vo31,0) + nvl(a.vo32,0) + nvl(a.sc105,0) + nvl(a.sc106,0)),4) cs_SofthoSuccRate,
round(nvl(a.vo30,0) + nvl(a.sc104,0),4) cs_SSofthoReqNum,
round(nvl(a.vo30,0) - nvl(a.vo38,0) + nvl(a.sc104,0) - nvl(a.sc115,0),4) cs_SSofthoSuccNum,
round(100*(nvl(a.vo30,0) - nvl(a.vo38,0) + nvl(a.sc104,0) - nvl(a.sc115,0))/decode(nvl(a.vo30,0) + nvl(a.sc104,0),0,1,null,1,nvl(a.vo30,0) + nvl(a.sc104,0)),4) cs_SSofthoSuccRate,
round(nvl(a.sc019,0)
+nvl(a.sc032,0)
-nvl(a.sc160,0)
-nvl(a.sc162,0),4) TchReqNumCallerExcludeHoSms  ,
round(nvl(a.sc019,0)
-nvl(a.esc03,0)
-nvl(a.esc01,0)
-nvl(a.esc05,0)
+nvl(a.esc13,0)
-nvl(a.sc015,0)
-nvl(a.sc160,0)
+nvl(a.sc032,0)
-nvl(a.esc14,0)
-nvl(a.esc16,0)
-nvl(a.esc18,0)
-nvl(a.sc038,0)
-nvl(a.sc162,0),4) TchSuccNumCallerExcludeHoSms ,
round(nvl(a.sc020,0)
+nvl(a.sc033,0)
-nvl(a.sc164,0)
-nvl(a.sc166,0),4) TchReqNumCalleeExcludeHoSms  ,
round(nvl(a.sc020,0)
-nvl(a.esc04,0)
-nvl(a.esc02,0)
-nvl(a.esc06,0)
-nvl(a.esc12,0)
-nvl(a.sc016,0)
-nvl(a.esc07,0)
-nvl(a.esc08,0)
-nvl(a.esc09,0)
-nvl(a.sc164,0)
+nvl(a.sc033,0)
-nvl(a.esc15,0)
-nvl(a.esc17,0)
-nvl(a.esc19,0)
-nvl(a.esc20,0)
-nvl(a.sc039,0)
-nvl(a.esc21,0)
-nvl(a.esc22,0)
-nvl(a.esc23,0)
-nvl(a.sc166,0),4) TchSuccNumCalleeExcludeHoSms ,
round(nvl(a.sc019,0) + nvl(a.sc020,0) +nvl(a.sc032,0)+ nvl(a.sc033,0) + nvl(a.c062,0) + nvl(a.c063,0) - nvl(a.sc160,0) - nvl(a.sc162,0) - nvl(a.sc164,0)- nvl(a.sc166,0),4) TchReqNumExcludeHoSms,
round(nvl(a.sc019,0) - nvl(a.esc03,0) -nvl(a.esc01,0)- nvl(a.esc05,0) + nvl(a.esc13,0) - nvl(a.sc015,0) - nvl(a.sc160,0) + nvl(a.sc032,0) - nvl(a.esc14,0) - nvl(a.esc16,0)- nvl(a.esc18,0) - nvl(a.sc038,0) - nvl(a.sc162,0) + nvl(a.sc020,0) - nvl(a.esc04,0) - nvl(a.esc02,0) - nvl(a.esc06,0) - nvl(a.esc12,0) - nvl(a.sc016,0) - nvl(a.esc07,0) - nvl(a.esc08,0) - nvl(a.esc09,0) - nvl(a.sc164,0) + nvl(a.sc033,0) - nvl(a.esc15,0) - nvl(a.esc17,0) - nvl(a.esc19,0) - nvl(a.esc20,0) - nvl(a.sc039,0) - nvl(a.esc21,0) - nvl(a.esc22,0) - nvl(a.esc23,0) - nvl(a.sc166,0) + nvl(a.c152,0) + nvl(a.c153,0),4) TchSuccNumExcludeHoSms       ,
round(nvl(a.sc019,0)+nvl(a.sc020,0)+nvl(a.sc032,0)+nvl(a.sc033,0)-nvl(a.sc160,0)-nvl(a.sc162,0)-nvl(a.sc164,0)-nvl(a.sc166,0)+nvl(a.c062,0)+nvl(a.c063,0)+nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc105,0)+nvl(a.sc106,0),4) TchReqNumIncludeHoSms        ,
round(nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0)+nvl(a.c152,0)+nvl(a.c153,0)+nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0)+nvl(a.vo31,0)-nvl(a.vo39,0)+nvl(a.vo32,0)-nvl(a.vo40,0)+nvl(a.sc105,0)-nvl(a.sc116,0)+nvl(a.sc106,0)-nvl(a.sc117,0),4) TchSuccNumIncludeHoSms,
round(nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0),4) BtsSysHardHoReqNum           ,
round(nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0),4) BtsSysHardHoSuccNum          ,
round(nvl(a.vo30,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc104,0)+nvl(a.sc105,0)+nvl(a.sc106,0),4) SysSHoReqNum                 ,
round(nvl(a.vo30,0)-nvl(a.vo38,0)+nvl(a.vo31,0)-nvl(a.vo39,0)+nvl(a.vo32,0)-nvl(a.vo40,0)+nvl(a.sc104,0)-nvl(a.sc115,0)+nvl(a.sc105,0)-nvl(a.sc116,0)+nvl(a.sc106,0)-nvl(a.sc117,0),4) SysSHoSuccNum,
round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4) TCHRadioFNum                 ,
round((nvl(a.sc023,0)- nvl(a.sc048,0) + nvl(a.sc050,0) - nvl(a.esc28,0) - nvl(a.sc118,0) - nvl(a.esc34,0) - nvl(a.esc43,0) - nvl(a.sc159,0) - nvl(a.sc160,0)) + nvl(a.sc024,0)- nvl(a.sc051,0) + nvl(a.sc053,0) - nvl(a.esc45,0) - nvl(a.sc163,0) - nvl(a.sc164,0) - nvl(a.sc167,0) - nvl(a.esc30,0) + nvl(a.sc036,0) - nvl(a.sc054,0) + nvl(a.sc056,0) -nvl(a.esc29,0) - nvl(a.sc119,0) - nvl(a.esc35,0) - nvl(a.esc44,0) - nvl(a.sc161,0) - nvl(a.sc162,0)- nvl(a.sc195,0) - nvl(a.sc197,0) + nvl(a.sc037,0) - nvl(a.sc057,0) +nvl(a.sc059,0) -nvl(a.esc46,0)-nvl(a.sc165,0)-nvl(a.sc166,0)-nvl(a.sc168,0)-nvl(a.esc32,0)+nvl(a.c062,0)+nvl(a.c063,0),4) CallPageReqTotalNum          ,
round(nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc107,0) + nvl(a.sc109,0),4) HardhoReqNum_intra           ,
round(nvl(a.vo13,0) + nvl(a.vo37,0) + nvl(a.sc111,0) + nvl(a.sc113,0),4) HardhoSuccNum_intra          ,
round(100*(nvl(a.vo13,0) + nvl(a.vo37,0) + nvl(a.sc111,0) + nvl(a.sc113,0))/
decode(nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc107,0) + nvl(a.sc109,0),0,1,null,1,nvl(a.vo33,0) + nvl(a.vo35,0) + nvl(a.sc107,0) + nvl(a.sc109,0)),4) HardhoSuccRate_intra,
round(nvl(a.vo31,0) + nvl(a.sc105,0),4) ShoReqNum_intra,
round(nvl(a.vo31,0) - nvl(a.vo39,0) + nvl(a.sc105,0) - nvl(a.sc116,0),4) ShoSuccNum_intra,
round(100*(nvl(a.vo31,0) - nvl(a.vo39,0) + nvl(a.sc105,0) - nvl(a.sc116,0))/
decode(nvl(a.vo31,0) + nvl(a.sc105,0),0,1,null,1,nvl(a.vo31,0) + nvl(a.sc105,0)),4) ShoSuccRate_intra,
round(nvl(a.vo34,0) + nvl(a.vo36,0) + nvl(a.sc108,0) + nvl(a.sc110,0),4) HardhoReqNum_Extra,
round(nvl(a.vo16,0) + nvl(a.vo20,0) + nvl(a.sc112,0) + nvl(a.sc114,0),4) HardhoSuccNum_Extra,
round(100*(nvl(a.vo16,0) + nvl(a.vo20,0) + nvl(a.sc112,0) + nvl(a.sc114,0))/
decode(nvl(a.vo34,0) + nvl(a.vo36,0) + nvl(a.sc108,0) + nvl(a.sc110,0),0,1,null,1,nvl(a.vo34,0) + nvl(a.vo36,0) + nvl(a.sc108,0) + nvl(a.sc110,0)),4) HardhoSuccRate_Extra,
round(nvl(a.vo32,0) + nvl(a.sc106,0),4) ShoReqNum_Extra,
round(nvl(a.vo32,0) - nvl(a.vo40,0) + nvl(a.sc106,0) - nvl(a.sc117,0),4) ShoSuccNum_Extra,
round(100*(nvl(a.vo32,0) - nvl(a.vo40,0) + nvl(a.sc106,0) - nvl(a.sc117,0))/
decode(nvl(a.vo32,0) + nvl(a.sc106,0),0,1,null,1,nvl(a.vo32,0) + nvl(a.sc106,0)),4) ShoSuccRate_Extra,
round(nvl(a.L037,0)+nvl(a.L038,0) + nvl(a.L039,0) + nvl(a.L040,0)+ nvl(a.L041,0),4) FdwTxTotalFrameExcludeRx,
round(a.L097/1024,4) RLPFwdChSizeExcludeRx,
round(a.L099,4) RLPFwdChRxSize,
round(100*nvl(a.L099,0)/decode(nvl(a.L097,0),0,1,null,1,nvl(a.L097,0)),4) FwdChRxRate,
round(nvl(a.L042,0)+ nvl(a.L043,0) + nvl(a.L044,0) + nvl(a.L045,0) +nvl(a.L046,0),4) RevTxTotalFrameExcludeRx,
round(a.L098/1024,4) RLPRevChSize,
round(100*nvl(a.L098,0)/1024/decode(nvl(a.L042,0)+ nvl(a.L043,0) + nvl(a.L044,0) + nvl(a.L045,0) +nvl(a.L046,0),0,1,null,1,nvl(a.L042,0)+ nvl(a.L043,0) + nvl(a.L044,0) + nvl(a.L045,0) +nvl(a.L046,0)),4) RevChRxRate,
round(100*(nvl(a.vo16,0)+nvl(a.vo20,0)+nvl(a.sc112,0)+nvl(a.sc114,0)+nvl(a.vo13,0)+nvl(a.vo37,0)+nvl(a.sc111,0)+nvl(a.sc113,0))/decode(nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0),0,1,null,1,nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0)),4) BtsSysHardHoSuccRate,
round(100*(nvl(a.vo34,0)+nvl(a.vo36,0)+nvl(a.sc110,0)+nvl(a.sc108,0)+nvl(a.vo33,0)+nvl(a.vo35,0)+nvl(a.sc107,0)+nvl(a.sc109,0))/decode(nvl(a.vo30,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc104,0)+nvl(a.sc105,0)+nvl(a.sc106,0),0,1,null,1,nvl(a.vo30,0)+nvl(a.vo31,0)+nvl(a.vo32,0)+nvl(a.sc104,0)+nvl(a.sc105,0)+nvl(a.sc106,0)),4) SysSHoSuccRate,
round(100*(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0))/
decode(nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)
-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)
-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)
-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)
-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)
-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0),0,1,null,1,
nvl(a.sc019,0)-nvl(a.esc03,0)-nvl(a.esc01,0)-nvl(a.esc05,0)+nvl(a.esc13,0)-nvl(a.sc015,0)
-nvl(a.sc160,0)+nvl(a.sc032,0)-nvl(a.esc14,0)-nvl(a.esc16,0)-nvl(a.esc18,0)-nvl(a.sc038,0)
-nvl(a.sc162,0)+nvl(a.sc020,0)-nvl(a.esc04,0)-nvl(a.esc02,0)-nvl(a.esc06,0)-nvl(a.esc12,0)
-nvl(a.sc016,0)-nvl(a.esc07,0)-nvl(a.esc08,0)-nvl(a.esc09,0)-nvl(a.sc164,0)+nvl(a.sc033,0)
-nvl(a.esc15,0)-nvl(a.esc17,0)-nvl(a.esc19,0)-nvl(a.esc20,0)-nvl(a.sc039,0)-nvl(a.esc21,0)
-nvl(a.esc22,0)-nvl(a.esc23,0)-nvl(a.sc166,0)),4) TchRadioFRate,
round(100*(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0))/
decode((case when(a.sc019 - a.esc03 - a.esc01 - a.esc05 + a.esc13 - a.sc015 - a.sc160) > 0
then (a.sc019 - a.esc03 - a.esc01 - a.esc05 + a.esc13 - a.sc015 - a.sc160) else 0 end)
+
(case when(a.sc020-a.esc04-a.esc02-a.esc06-a.esc12-a.sc016-a.esc07-a.esc08-a.esc09 - a.sc164) > 0
then (a.sc020-a.esc04-a.esc02-a.esc06-a.esc12-a.sc016-a.esc07-a.esc08-a.esc09 - a.sc164) else 0 end)
+
(case when(a.sc032 - a.esc14 - a.esc16- a.esc18 - a.sc038 - a.sc162) > 0
then (a.sc032 - a.esc14 - a.esc16- a.esc18 - a.sc038 - a.sc162) else 0 end)
+
(case when(a.sc033-a.esc15-a.esc17-a.esc19-a.esc20-a.sc039-a.esc21-a.esc22-a.esc23 - a.sc166) > 0
then (a.sc033-a.esc15-a.esc17-a.esc19-a.esc20-a.sc039-a.esc21-a.esc22-a.esc23 - a.sc166) else 0 end
),0,1,null,1,(case when(a.sc019 - a.esc03 - a.esc01 - a.esc05 + a.esc13 - a.sc015 - a.sc160) > 0
then (a.sc019 - a.esc03 - a.esc01 - a.esc05 + a.esc13 - a.sc015 - a.sc160) else 0 end)
+
(case when(a.sc020-a.esc04-a.esc02-a.esc06-a.esc12-a.sc016-a.esc07-a.esc08-a.esc09 - a.sc164) > 0
then (a.sc020-a.esc04-a.esc02-a.esc06-a.esc12-a.sc016-a.esc07-a.esc08-a.esc09 - a.sc164) else 0 end)
+
(case when(a.sc032 - a.esc14 - a.esc16- a.esc18 - a.sc038 - a.sc162) > 0
then (a.sc032 - a.esc14 - a.esc16- a.esc18 - a.sc038 - a.sc162) else 0 end)
+
(case when(a.sc033-a.esc15-a.esc17-a.esc19-a.esc20-a.sc039-a.esc21-a.esc22-a.esc23 - a.sc166) > 0
then (a.sc033-a.esc15-a.esc17-a.esc19-a.esc20-a.sc039-a.esc21-a.esc22-a.esc23 - a.sc166) else 0 end)
),4) CallInterruptRate,
round(nvl(a.vo30,0) + nvl(a.sc104,0),4)+round(nvl(a.scpd104,0),4) SShoReqNum_intra,
round(nvl(a.vo30,0) + nvl(a.sc104,0)-nvl(a.vo38,0)-nvl(a.sc115,0),4)+round(nvl(a.scpd104,0)-nvl(a.scpd115,0),4) SShoSuccNum_intra,
round(100*(a.vo30 -a.vo38+ a.sc104-a.sc115+a.scpd104-a.scpd115)/
decode(a.vo30 + a.sc104 + a.scpd104,0,1,null,1,a.vo30 + a.sc104 + a.scpd104),4) SShoSuccRate_intra,
round(
(case when(nvl(a.scpd036,0)
-nvl(a.scpd054,0)
+nvl(a.scpd056,0)
-nvl(a.scpd042,0)
-nvl(a.scpd044,0)
-nvl(a.scpd046,0)
-nvl(a.escpd29,0)
-nvl(a.escpd35,0)
-nvl(a.escpd44,0)
-nvl(a.scpd161,0)
-nvl(a.scpd162,0)
-nvl(a.scpd119,0)
-nvl(a.scpd195,0)
-nvl(a.scpd197,0)
-nvl(a.c264,0)
-nvl(a.ec22,0)) > 0
then( nvl(a.scpd036,0)
-nvl(a.scpd054,0)
+nvl(a.scpd056,0)
-nvl(a.scpd042,0)
-nvl(a.scpd044,0)
-nvl(a.scpd046,0)
-nvl(a.escpd29,0)
-nvl(a.escpd35,0)
-nvl(a.escpd44,0)
-nvl(a.scpd161,0)
-nvl(a.scpd162,0)
-nvl(a.scpd119,0)
-nvl(a.scpd195,0)
-nvl(a.scpd197,0)
-nvl(a.c264,0)
-nvl(a.ec22,0)) else 0 end)
+
(case when(nvl(a.scpd037,0)
-nvl(a.scpd043,0)
-nvl(a.scpd045,0)
-nvl(a.scpd047,0)
-nvl(a.scpd057,0)
+nvl(a.scpd059,0)
-nvl(a.escpd46,0)
-nvl(a.scpd165,0)
-nvl(a.scpd166,0)
-nvl(a.scpd168,0)
-nvl(a.escpd32,0)
-nvl(a.ec23,0)) > 0
then( nvl(a.scpd037,0)
-nvl(a.scpd043,0)
-nvl(a.scpd045,0)
-nvl(a.scpd047,0)
-nvl(a.scpd057,0)
+nvl(a.scpd059,0)
-nvl(a.escpd46,0)
-nvl(a.scpd165,0)
-nvl(a.scpd166,0)
-nvl(a.scpd168,0)
-nvl(a.escpd32,0)
-nvl(a.ec23,0)) else 0 end),4)  ps_CallPageReqNum,
case when (round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4)) is null then 1000
     when (round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4))=0 then 1000 else round(cs_TrafficExcludeHo*60/decode((round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4)),0,1,(round(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0),4))),4) end cs_LoseCallingratio,

b.carriernum_1x,
b.cs_SHOTraffic,
b.cs_TchReqNumHardho,
b.cs_TchSuccNumHardho,
b.cs_TchReqNumsoftho,
b.cs_TchSuccNumsoftho,
b.cs_CallPageSuccNum,
b.cs_CallPageReqNum,
b.TCHLoadTrafficIncludeHo,
b.TrafficExcludeHo,
b.cs_TrafficExcludeHo,
b.TCHLoadTrafficExcludeHo,
b.ps_TchReqNumHardho ,
b.ps_TchSuccNumHardho,
b.ps_TchReqNumsoftho ,
b.ps_TchSuccNumsoftho,
b.ps_LoseCallingNum,
b.ps_HandoffReqNum,
b.ps_HandoffSuccNum,
b.ps_HandoffSuccRate,
b.ps_HardhoReqNum,
b.ps_HardhoSuccNum,
b.ps_HardhoSuccRate,
b.ps_SofthoReqNum,
b.ps_SofthoSuccNum,
b.ps_SofthoSuccRate,
b.ps_SSofthoReqNum,
b.ps_SSofthoSuccNum,
b.ps_SSofthoSuccRate,
b.ps_CallPageSuccNum,
a.cs_trafficByWalsh,
a.ps_trafficByWalsh,
a.LoadTrafficByWalsh,
--count(case when BadCellNum_1 > 2.5 and BadCellNum_2 >= 3 and BadCellNum_3 > 0.025 then a.int_i end) BadCellNum,
--b.BadCellNum,
round(100*b.cs_SHORate_up/decode(b.cs_SHORate_down,0,1,null,1,b.cs_SHORate_down),4) cs_SHORate,
round(100*b.ps_SHORate_up/decode(b.ps_SHORate_down,0,1,null,1,b.ps_SHORate_down),4) ps_SHORate,
--round(100*(nvl(round((nvl(a.c085,0)-nvl(a.c276,0))/360,4),0)-nvl(round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0))/decode(nvl(round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0)+nvl(round((nvl(a.c085,0)-nvl(a.c276,0))/360,4)-round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0),0,1,nvl(round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0)+nvl(round((nvl(a.c085,0)-nvl(a.c276,0))/360,4)-round((nvl(a.c085,0)-nvl(a.c086,0)-nvl(a.c276,0)+nvl(a.c277,0))/360,4),0)),4) ps_SHORate,
b.cs_TchReqNumExcludeHo cs_TchReqNumExcludeHo,
b.cs_TchSuccNumExcludeHo cs_TchSuccNumExcludeHo,
b.cs_TchFNumExcludeHo_a1- b.cs_TchFNumExcludeHo_a2 cs_TchFNumExcludeHo,
round(100*b.cs_TchFNumExcludeHo_a2/decode(b.cs_TchFNumExcludeHo_a1,0,1,null,1,b.cs_TchFNumExcludeHo_a1),4) cs_TchSuccExcludeHoRate,
b.cs_HandoffReqNum cs_HandoffReqNum,
b.cs_HandoffSuccNum cs_HandoffSuccNum,
round(100*b.cs_HandoffSuccNum/decode(cs_HandoffReqNum,0,1,null,1,b.cs_HandoffReqNum),4) cs_HandoffSuccRate,
b.HandoffReqNum_Extra HandoffReqNum_Extra,
b.HandoffSuccNum_Extra HandoffSuccNum_Extra,
--update-2011-9-14
round(100*b.HandoffSuccNum_Extra/decode(b.HandoffReqNum_Extra,0,1,null,1,b.HandoffReqNum_Extra),4) HandoffSuccRate_Extra,
v1-v2 ps_SSHOTraffic,
round(100*b.ps_LoseCallingRate_up/decode(b.ps_LoseCallingRate_down,0,1,null,1,b.ps_LoseCallingRate_down),4) ps_LoseCallingRate,
b.ps_TchReqNumIncludeHo ps_TchReqNumIncludeHo,
b.ps_TchSuccNumIncludeHo ps_TchSuccNumIncludeHo,
(b.ps_TchFNumIncludeHo_b1 - b.ps_TchFNumIncludeHo_b2) ps_TchFNumIncludeHo,
(b.ps_TchFNumIncludeHo_b1 - b.ps_TchFNumIncludeHo_b2) ps_CallBlockFailNum,
round(100*b.ps_TchFNumIncludeHo_b2/decode(b.ps_TchFNumIncludeHo_b1,0,1,null,1,b.ps_TchFNumIncludeHo_b1),4) ps_TchSuccIncludeHoRate,
b.ps_TchReqNumExcludeHo ps_TchReqNumExcludeHo,
b.ps_TchSuccNumExcludeHo ps_TchSuccNumExcludeHo,
b.ps_TchReqNumExcludeHo - b.ps_TchSuccNumExcludeHo  ps_TchFNumExcludeHo,
round(100*b.ps_TchSuccNumExcludeHo /decode(b.ps_TchReqNumExcludeHo,0,1,null,1,b.ps_TchReqNumExcludeHo),4)  ps_TchSuccExcludeHoRate,
round(ps_LoseCallingratio_up/decode(ps_LoseCallingratio_down,0,1,null,1,ps_LoseCallingratio_down),4) ps_LoseCallingratio,
(TchReqNumIncludeHo_a+TchReqNumIncludeHo_b) TchReqNumIncludeHo,
(TchReqNumExcludeHo_a+TchReqNumExcludeHo_b) TchReqNumExcludeHo,
(TchSuccNumIncludeHo_a+TchSuccNumIncludeHo_b) TchSuccNumIncludeHo,
(TchFNumIncludeHo_a1-TchFNumIncludeHo_a2+TchFNumIncludeHo_b1-TchFNumIncludeHo_b2) TchFNumIncludeHo,
round(100*(TchSuccIncludeHoRate_up_a+TchSuccIncludeHoRate_up_b)/decode(TchSuccIncludeHoRate_down_a+TchSuccIncludeHoRate_down_b,0,1,null,1,TchSuccIncludeHoRate_down_a+TchSuccIncludeHoRate_down_b),4) TchSuccIncludeHoRate,
(TchSuccNumExcludeHo_a+TchSuccNumExcludeHo_b) TchSuccNumExcludeHo,
(TchFNumExcludeHo_a1-TchFNumExcludeHo_a2+TchFNumExcludeHo_b1-TchFNumExcludeHo_b2) TchFNumExcludeHo,
round(100*(TchSuccExcludeHoRate_up_a+TchSuccExcludeHoRate_up_b)/decode(TchSuccExcludeHoRate_down_a+TchSuccExcludeHoRate_down_b,0,1,null,1,TchSuccExcludeHoRate_down_a+TchSuccExcludeHoRate_down_b),4) TchSuccExcludeHoRate,
(HandoffReqNum_a+HandoffReqNum_b) HandoffReqNum,
(HandoffSuccNum_a+HandoffSuccNum_b) HandoffSuccNum,
round(100*(HandoffSuccNum_a+HandoffSuccNum_b)/decode(HandoffReqNum_a+HandoffReqNum_b,0,1,null,1, HandoffReqNum_a+HandoffReqNum_b),4) HandoffSuccRate,
(HandoffReqNum_intra_a+HandoffReqNum_intra_b) HandoffReqNum_intra,
(HandoffSuccNum_intra_a+HandoffSuccNum_intra_b) HandoffSuccNum_intra,
round(100*(HandoffSuccNum_intra_a+HandoffSuccNum_intra_b)/decode(HandoffReqNum_intra_a+HandoffReqNum_intra_b,0,1,null,1,HandoffReqNum_intra_a+HandoffReqNum_intra_b),4) HandoffSuccRate_intra,
round(100*(cs_CallBlockFailRate_up_a+cs_CallBlockFailRate_up_b)/decode(cs_CallBlockFailRate_down,0,1,null,1,cs_CallBlockFailRate_down),4) cs_CallBlockFailRate,
ChannelNum,
ChannelAvailNum,
ChannelMaxUseNum
from a,b,c
where a.province_id = b.province_id(+) and  b.province_id=c.province_id(+);

commit;
insert /*+append*/ into C_PERF_1X_SUM_LC_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CallPageReqNum,
CallPageSuccNum,
Numfailofcall,
cs_Numfailofcall,
CallPageSuccRate,
LoseCallingRate,
ps_CallPageSuccRate,
cs_CallPageSuccRate,
BadCellRatio,
cs_LoseCallingRate,
SHoFactor,
ps_SHOTraffic,
cs_TchFNumIncludeHo,
ChannelMaxUseRate,
FwdChMaxUseRate,
RevChMaxUseRate,
TrafficIncludeHo,
TCHLoadRate,
CEAvailRate,
BusyerCellratio,
BusyCellratio,
FreeCellratio,
SeriOverflowBtsratio,
OverflowBtsratio,
CallBlockFailNum,
CallBlockFailRate,
ps_CallBlockFailRate,
ps_CallBlockFailRateHardho,
ps_CallBlockFailRatesoftho,
LoseCallingratio,
cs_CallBlockFailRateHardho,
cs_CallBlockFailRatesoftho
)
select
int_id,
v_date,
0,
10000,
10,
sum(nvl(cs_CallPageReqNum,0)+nvl(ps_CallPageReqNum,0)) CallPageReqNum,
sum(nvl(cs_CallPageSuccNum,0)+nvl(ps_CallPageSuccNum,0)) CallPageSuccNum,
sum(nvl(cs_CallPageReqNum,0)+nvl(ps_CallPageReqNum,0)-nvl(cs_CallPageSuccNum,0)-nvl(ps_CallPageSuccNum,0))   Numfailofcall,
sum(nvl(cs_CallPageReqNum,0)-nvl(cs_CallPageSuccNum,0))   cs_Numfailofcall,

round(100*sum(nvl(cs_CallPageSuccNum,0)+nvl(ps_CallPageSuccNum,0))/decode(sum(nvl(cs_CallPageReqNum,0)+nvl(ps_CallPageReqNum,0)),0,1,null,1,sum(nvl(cs_CallPageReqNum,0)+nvl(ps_CallPageReqNum,0))),4) CallPageSuccRate,
round(100*sum(nvl(cs_LoseCallingNum,0)+nvl(ps_LoseCallingNum,0))/decode(sum(nvl(cs_TchSuccNumExcludeHo,0)+nvl(ps_TchSuccNumExcludeHo,0)),0,1,null,1,sum(nvl(cs_TchSuccNumExcludeHo,0)+nvl(ps_TchSuccNumExcludeHo,0))),4) LoseCallingRate,
round(100*sum(nvl(ps_CallPageSuccNum,0))/decode(sum(ps_CallPageReqNum),0,1,null,1,sum(ps_CallPageReqNum)),4) ps_CallPageSuccRate,
round(100*sum(nvl(cs_CallPageSuccNum,0))/decode(sum(cs_CallPageReqNum),0,1,null,1,sum(cs_CallPageReqNum)),4)  cs_CallPageSuccRate,
round(100*sum(nvl(BadCellNum,0))/decode(sum(CellNum),0,1,null,1,sum(CellNum)),4) BadCellRatio,
round(100*sum(nvl(cs_LoseCallingNum,0))/decode(sum(cs_TchSuccNumExcludeHo),0,1,null,1,sum(cs_TchSuccNumExcludeHo)),4) cs_LoseCallingRate,
round(100*sum(TCHLoadTrafficIncludeHo - TCHLoadTrafficExcludeHo)/decode(sum(TCHLoadTrafficExcludeHo),0,1,null,1,sum(TCHLoadTrafficExcludeHo)),4) SHoFactor,
sum((nvl(ps_CallTrafficIncludeHo,0)-nvl(ps_CallTrafficExcludeHo,0)))  ps_SHOTraffic,
sum(nvl(cs_TchReqNumIncludeHo,0)-nvl(cs_TchSuccNumIncludeHo,0)) cs_TchFNumIncludeHo,
round(100*sum(nvl(ChannelMaxUseNum,0))/decode(sum(ChannelAvailNum),null,1,0,1,sum(ChannelAvailNum)),4) ChannelMaxUseRate,
sum(round(nvl(FwdChMaxUseRate,0),4))  FwdChMaxUseRate ,
sum(round(nvl(RevChMaxUseRate,0),4))       RevChMaxUseRate ,
sum((nvl(cs_TrafficIncludeHo,0)+nvl(ps_CallTrafficIncludeHo,0))) TrafficIncludeHo,
--sum(round(100*(nvl(ps_CallTrafficIncludeHo,0)-nvl(ps_CallTrafficExcludeHo,0))/decode(nvl(ps_CallTrafficExcludeHo,0)+nvl(ps_CallTrafficIncludeHo-ps_CallTrafficExcludeHo,0),0,1,nvl(ps_CallTrafficExcludeHo,0)+nvl(ps_CallTrafficIncludeHo-ps_CallTrafficExcludeHo,0)),4))  ps_SHORate,
round(100*sum(nvl(TCHLoadTrafficIncludeHo,0))/decode(sum(Wirecapacity),null,1,0,1,sum(Wirecapacity)),4)  TCHLoadRate,
round(100*sum(nvl(CEAvailNum,0))/decode(sum(nvl(CENum,0)),null,1,0,1,sum(nvl(CENum,0))),4) CEAvailRate,
round(100*sum(nvl(BusyerCellNum,0))/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4) BusyerCellratio,
round(100*sum(nvl(BusyCellNum,0))/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4)  BusyCellratio,
round(100*sum(nvl(FreeCellNum,0))/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4) FreeCellratio,
round(100*sum(nvl(SeriOverflowBtsNum,0))/decode(sum(BtsNum),null,1,0,1,sum(BtsNum)),4)    SeriOverflowBtsratio,
round(100*sum(nvl(OverflowBtsNum,0))/decode(sum(BtsNum),null,1,0,1,sum(BtsNum)),4)  OverflowBtsratio,
sum(nvl(cs_CallBlockFailNum,0)+nvl(ps_CallBlockFailNum,0)) CallBlockFailNum,
round(100*sum(nvl(cs_CallBlockFailNum,0)+nvl(ps_CallBlockFailNum,0))/decode(sum(TchReqNumIncludeHo),null,1,0,1,sum(TchReqNumIncludeHo)),4) CallBlockFailRate,
round(100*sum(nvl(ps_CallBlockFailNum,0))/decode(sum(ps_TchReqNumIncludeHo),null,1,0,1,sum(ps_TchReqNumIncludeHo)),4)  ps_CallBlockFailRate,
round(100*sum(nvl(ps_TchReqNumHardho,0)-nvl(ps_TchSuccNumHardho,0))/decode(sum(ps_TchReqNumHardho),null,1,0,1,sum(ps_TchReqNumHardho)),4) ps_CallBlockFailRateHardho,
round(100*sum(nvl(ps_TchReqNumsoftho,0)-nvl(ps_TchSuccNumsoftho,0))/decode(sum(ps_TchReqNumsoftho),null,1,0,1,sum(ps_TchReqNumsoftho)),4) ps_CallBlockFailRatesoftho,
round(sum(nvl(TrafficExcludeHo,0))*60/decode(sum(LoseCallingNum),null,1,0,1,sum(LoseCallingNum)),4) LoseCallingratio,
round(100*sum(nvl(cs_TchReqNumHardho,0)-nvl(cs_TchSuccNumHardho,0))/decode(sum(cs_TchReqNumHardho),null,1,0,1,sum(cs_TchReqNumHardho)),4) cs_CallBlockFailRateHardho,
round(100*sum(nvl(cs_TchReqNumsoftho,0)-nvl(cs_TchSuccNumsoftho,0))/decode(sum(cs_TchReqNumsoftho),null,1,0,1,sum(cs_TchReqNumsoftho)),4) cs_CallBlockFailRatesoftho
from C_PERF_1X_SUM_LC_TEMP
group by int_id;






commit;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');
insert /*+append*/ into c_perf_1x_sum
(
int_id                        ,
scan_start_time             ,
sum_level                   ,
ne_type                     ,
vendor_id                   ,
callpagereqnum              ,
callpagesuccnum             ,
callpagesuccrate            ,
cs_callpagereqnum           ,
cs_callpagesuccnum          ,
cs_callpagesuccrate         ,
ps_callpagereqnum           ,
ps_callpagesuccnum          ,
ps_callpagesuccrate         ,
trafficincludeho            ,
trafficexcludeho            ,
cs_trafficincludeho         ,
cs_trafficexcludeho         ,
cs_trafficbywalsh           ,
cs_shotraffic               ,
cs_sshotraffic              ,
cs_shorate                  ,
ps_calltrafficincludeho     ,
ps_calltrafficexcludeho     ,
ps_trafficbywalsh           ,
ps_shotraffic               ,
ps_sshotraffic              ,
ps_shorate                  ,
losecallingnum              ,
losecallingrate             ,
losecallingratio            ,
cs_losecallingnum           ,
cs_losecallingrate          ,
cs_losecallingratio         ,
ps_losecallingnum           ,
ps_losecallingrate          ,
ps_losecallingratio         ,
tchreqnumincludeho          ,
tchsuccnumincludeho         ,
tchfnumincludeho            ,
tchsuccincludehorate        ,
tchreqnumexcludeho          ,
tchsuccnumexcludeho         ,
tchfnumexcludeho            ,
tchsuccexcludehorate        ,
callblockfailnum            ,
callblockfailrate           ,
cs_tchreqnumincludeho       ,
cs_tchsuccnumincludeho      ,
cs_tchfnumincludeho         ,
cs_tchsuccincludehorate     ,
cs_tchreqnumexcludeho       ,
cs_tchsuccnumexcludeho      ,
cs_tchfnumexcludeho         ,
cs_tchsuccexcludehorate     ,
cs_callblockfailnum         ,
cs_callblockfailrate        ,
cs_tchreqnumhardho          ,
cs_tchsuccnumhardho         ,
cs_callblockfailratehardho  ,
cs_tchreqnumsoftho          ,
cs_tchsuccnumsoftho         ,
cs_callblockfailratesoftho  ,
ps_tchreqnumincludeho       ,
ps_tchsuccnumincludeho      ,
ps_tchfnumincludeho         ,
ps_tchsuccincludehorate     ,
ps_tchreqnumexcludeho       ,
ps_tchsuccnumexcludeho      ,
ps_tchfnumexcludeho         ,
ps_tchsuccexcludehorate     ,
ps_callblockfailnum         ,
ps_callblockfailrate        ,
ps_tchreqnumhardho          ,
ps_tchsuccnumhardho         ,
ps_callblockfailratehardho  ,
ps_tchreqnumsoftho          ,
ps_tchsuccnumsoftho         ,
ps_callblockfailratesoftho  ,
handoffreqnum               ,
handoffsuccnum              ,
handoffsuccrate             ,
cs_handoffreqnum            ,
cs_handoffsuccnum           ,
cs_handoffsuccrate          ,
cs_hardhoreqnum             ,
cs_hardhosuccnum            ,
cs_hardhosuccrate           ,
cs_softhoreqnum             ,
cs_softhosuccnum            ,
cs_softhosuccrate           ,
cs_ssofthoreqnum            ,
cs_ssofthosuccnum           ,
cs_ssofthosuccrate          ,
ps_handoffreqnum            ,
ps_handoffsuccnum           ,
ps_handoffsuccrate          ,
ps_hardhoreqnum             ,
ps_hardhosuccnum            ,
ps_hardhosuccrate           ,
ps_softhoreqnum             ,
ps_softhosuccnum            ,
ps_softhosuccrate           ,
ps_ssofthoreqnum            ,
ps_ssofthosuccnum           ,
ps_ssofthosuccrate          ,
handoffreqnum_intra         ,
handoffsuccnum_intra        ,
handoffsuccrate_intra       ,
handoffreqnum_extra         ,
handoffsuccnum_extra        ,
handoffsuccrate_extra       ,
hardhoreqnum_intra          ,
hardhosuccnum_intra         ,
hardhosuccrate_intra        ,
shoreqnum_intra             ,
shosuccnum_intra            ,
shosuccrate_intra           ,
sshoreqnum_intra            ,
sshosuccnum_intra           ,
sshosuccrate_intra          ,
hardhoreqnum_extra          ,
hardhosuccnum_extra         ,
hardhosuccrate_extra        ,
shoreqnum_extra             ,
shosuccnum_extra            ,
shosuccrate_extra           ,
carrier1btsnum              ,
carrier2btsnum              ,
carrier3btsnum              ,
carrier4btsnum              ,
carriernum_1x               ,
channelnum                  ,
channelavailnum             ,
channelmaxusenum            ,
channelmaxuserate           ,
fwdchnum                    ,
fwdchavailnum               ,
fwdchmaxusenum              ,
fwdchmaxuserate             ,
revchnum                    ,
revchavailnum               ,
revchmaxusenum              ,
revchmaxuserate             ,
fwdrxtotalframe             ,
fdwtxtotalframeexcluderx    ,
rlpfwdchsizeexcluderx       ,
rlpfwdchrxsize              ,
rlpfwdlosesize              ,
fwdchrxrate                 ,
revrxtotalframe             ,
revtxtotalframeexcluderx    ,
rlprevchsize                ,
revchrxrate                 ,
btsnum                      ,
onecarrierbtsnum            ,
twocarrierbtsnum            ,
threecarrierbtsnum          ,
fourcarrierbtsnum           ,
cellnum                     ,
onecarriercellnum           ,
twocarriercellnum           ,
threecarriercellnum         ,
fourcarriercellnum          ,
cenum                       ,
wirecapacity                ,
tchnum                      ,
tchloadrate                 ,
shofactor                   ,
ceavailrate                 ,
tchblockfailrate            ,
busyercellratio             ,
busycellratio               ,
freecellratio               ,
serioverflowbtsratio        ,
overflowbtsratio            ,
btssyshardhosuccrate        ,
sysshosuccrate              ,
tchradiofrate               ,
callinterruptrate           ,
avgradiofperiod             ,
badcellratio                ,
ceavailnum                  ,
tchblockfailnumincludeho    ,
tchloadtrafficincludeho     ,
tchloadtrafficexcludeho     ,
loadtrafficbywalsh          ,
trafficcarrier1             ,
trafficcarrier2             ,
trafficcarrier3             ,
trafficcarrier4             ,
busyercellnum               ,
busycellnum                 ,
freecellnum                 ,
badcellnum                  ,
serioverflowbtsnum          ,
overflowbtsnum              ,
tchreqnumcallerexcludehosms ,
tchsuccnumcallerexcludehosms,
tchreqnumcalleeexcludehosms ,
tchsuccnumcalleeexcludehosms,
tchreqnumexcludehosms       ,
tchsuccnumexcludehosms      ,
tchreqnumincludehosms       ,
tchsuccnumincludehosms      ,
btssyshardhoreqnum          ,
btssyshardhosuccnum         ,
sysshoreqnum                ,
sysshosuccnum               ,
tchradiofnum                ,
callpagereqtotalnum         ,
numfailofcall               ,
ps_numfailofcall            ,
cs_numfailofcall
)
select
int_id                        ,
scan_start_time             ,
sum_level                   ,
ne_type                     ,
vendor_id                   ,
sum(callpagereqnum              ),
sum(callpagesuccnum             ),
sum(callpagesuccrate            ),
sum(cs_callpagereqnum           ),
sum(cs_callpagesuccnum          ),
sum(cs_callpagesuccrate         ),
sum(ps_callpagereqnum           ),
sum(ps_callpagesuccnum          ),
sum(ps_callpagesuccrate         ),
sum(trafficincludeho            ),
sum(trafficexcludeho            ),
sum(cs_trafficincludeho         ),
sum(cs_trafficexcludeho         ),
sum(cs_trafficbywalsh           ),
sum(cs_shotraffic               ),
sum(cs_sshotraffic              ),
sum(cs_shorate                  ),
sum(ps_calltrafficincludeho     ),
sum(ps_calltrafficexcludeho     ),
sum(ps_trafficbywalsh           ),
sum(ps_shotraffic               ),
sum(ps_sshotraffic              ),
sum(ps_shorate                  ),
sum(losecallingnum              ),
sum(losecallingrate             ),
sum(losecallingratio            ),
sum(cs_losecallingnum           ),
sum(cs_losecallingrate          ),
sum(cs_losecallingratio         ),
sum(ps_losecallingnum           ),
sum(ps_losecallingrate          ),
sum(ps_losecallingratio         ),
sum(tchreqnumincludeho          ),
sum(tchsuccnumincludeho         ),
sum(tchfnumincludeho            ),
sum(tchsuccincludehorate        ),
sum(tchreqnumexcludeho          ),
sum(tchsuccnumexcludeho         ),
sum(tchfnumexcludeho            ),
sum(tchsuccexcludehorate        ),
sum(callblockfailnum            ),
sum(callblockfailrate           ),
sum(cs_tchreqnumincludeho       ),
sum(cs_tchsuccnumincludeho      ),
sum(cs_tchfnumincludeho         ),
sum(cs_tchsuccincludehorate     ),
sum(cs_tchreqnumexcludeho       ),
sum(cs_tchsuccnumexcludeho      ),
sum(cs_tchfnumexcludeho         ),
sum(cs_tchsuccexcludehorate     ),
sum(cs_callblockfailnum         ),
sum(cs_callblockfailrate        ),
sum(cs_tchreqnumhardho          ),
sum(cs_tchsuccnumhardho         ),
sum(cs_callblockfailratehardho  ),
sum(cs_tchreqnumsoftho          ),
sum(cs_tchsuccnumsoftho         ),
sum(cs_callblockfailratesoftho  ),
sum(ps_tchreqnumincludeho       ),
sum(ps_tchsuccnumincludeho      ),
sum(ps_tchfnumincludeho         ),
sum(ps_tchsuccincludehorate     ),
sum(ps_tchreqnumexcludeho       ),
sum(ps_tchsuccnumexcludeho      ),
sum(ps_tchfnumexcludeho         ),
sum(ps_tchsuccexcludehorate     ),

sum(ps_CallBlockFailNum         ),

sum(ps_callblockfailrate        ),
sum(ps_tchreqnumhardho          ),
sum(ps_tchsuccnumhardho         ),
sum(ps_callblockfailratehardho  ),
sum(ps_tchreqnumsoftho          ),
sum(ps_tchsuccnumsoftho         ),
sum(ps_callblockfailratesoftho  ),
sum(handoffreqnum               ),
sum(handoffsuccnum              ),
sum(handoffsuccrate             ),
sum(cs_handoffreqnum            ),
sum(cs_handoffsuccnum           ),
sum(cs_handoffsuccrate          ),
sum(cs_hardhoreqnum             ),
sum(cs_hardhosuccnum            ),
sum(cs_hardhosuccrate           ),
sum(cs_softhoreqnum             ),
sum(cs_softhosuccnum            ),
sum(cs_softhosuccrate           ),
sum(cs_ssofthoreqnum            ),
sum(cs_ssofthosuccnum           ),
sum(cs_ssofthosuccrate          ),
sum(ps_handoffreqnum            ),
sum(ps_handoffsuccnum           ),
sum(ps_handoffsuccrate          ),
sum(ps_hardhoreqnum             ),
sum(ps_hardhosuccnum            ),
sum(ps_hardhosuccrate           ),
sum(ps_softhoreqnum             ),
sum(ps_softhosuccnum            ),
sum(ps_softhosuccrate           ),
sum(ps_ssofthoreqnum            ),
sum(ps_ssofthosuccnum           ),
sum(ps_ssofthosuccrate          ),
sum(handoffreqnum_intra         ),
sum(handoffsuccnum_intra        ),
sum(handoffsuccrate_intra       ),
sum(handoffreqnum_extra         ),
sum(handoffsuccnum_extra        ),
sum(handoffsuccrate_extra       ),
sum(hardhoreqnum_intra          ),
sum(hardhosuccnum_intra         ),
sum(hardhosuccrate_intra        ),
sum(shoreqnum_intra             ),
sum(shosuccnum_intra            ),
sum(shosuccrate_intra           ),
sum(sshoreqnum_intra            ),
sum(sshosuccnum_intra           ),
sum(sshosuccrate_intra          ),
sum(hardhoreqnum_extra          ),
sum(hardhosuccnum_extra         ),
sum(hardhosuccrate_extra        ),
sum(shoreqnum_extra             ),
sum(shosuccnum_extra            ),
sum(shosuccrate_extra           ),
sum(carrier1btsnum              ),
sum(carrier2btsnum              ),
sum(carrier3btsnum              ),
sum(nvl(carrier4btsnum,0)       ),
sum(carriernum_1x               ),
sum(channelnum                  ),
sum(channelavailnum             ),
sum(channelmaxusenum            ),
sum(channelmaxuserate           ),
sum(nvl(fwdchnum,0)             ),
sum(nvl(fwdchavailnum,0)        ),
sum(nvl(fwdchmaxusenum,0)       ),
sum(nvl(fwdchmaxuserate,0)      ),
sum(nvl(revchnum,0)             ),
sum(nvl(revchavailnum,0)        ),
sum(nvl(revchmaxusenum,0)       ),
sum(revchmaxuserate             ),
sum(nvl(fwdrxtotalframe,0)      ),
sum(fdwtxtotalframeexcluderx    ),
sum(rlpfwdchsizeexcluderx       ),
sum(rlpfwdchrxsize              ),
sum(nvl(rlpfwdlosesize,0)       ),
sum(fwdchrxrate                 ),
sum(revrxtotalframe             ),
sum(revtxtotalframeexcluderx    ),
sum(rlprevchsize                ),
sum(revchrxrate                 ),
sum(btsnum                      ),
sum(nvl(onecarrierbtsnum,0)            ),
sum(nvl(twocarrierbtsnum,0)            ),
sum(nvl(threecarrierbtsnum,0)          ),
sum(nvl(fourcarrierbtsnum,0)           ),
sum(cellnum                     ),
sum(onecarriercellnum           ),
sum(twocarriercellnum           ),
sum(threecarriercellnum         ),
sum(fourcarriercellnum          ),
sum(cenum                       ),
sum(wirecapacity                ),
sum(tchnum                      ),
sum(tchloadrate                 ),
sum(shofactor                   ),
sum(case when ceavailrate>=100 then 100 else ceavailrate end ),
sum(tchblockfailrate            ),
sum(busyercellratio             ),
round(100*sum(nvl(BusyCellNum,0))/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4),
round(100*sum(nvl(FreeCellNum,0))/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4),
sum(serioverflowbtsratio        ),
sum(overflowbtsratio            ),
sum(btssyshardhosuccrate        ),
round(100*sum(nvl(SysSHoSuccNum,0))/decode(sum(nvl(SysSHoReqNum,0)),0,1,sum(nvl(SysSHoReqNum,0))),4),
sum(tchradiofrate               ),
sum(callinterruptrate           ),
--sum(avgradiofperiod             ),
round(100*sum(tCHLoadTrafficExcludeHo)/decode(sum(TCHRadioFNum),0,1,sum(TCHRadioFNum)),4),
sum(badcellratio                ),
round(sum(ceavailnum            )),
sum(tchblockfailnumincludeho    ),
sum(tchloadtrafficincludeho     ),
sum(tchloadtrafficexcludeho     ),
sum(loadtrafficbywalsh          ),
sum(trafficcarrier1             ),
sum(trafficcarrier2             ),
sum(trafficcarrier3             ),
sum(trafficcarrier4             ),
sum(busyercellnum               ),
sum(busycellnum                 ),
sum(freecellnum                 ),
sum(nvl(badcellnum,0)           ),
sum(serioverflowbtsnum          ),
sum(overflowbtsnum              ),
sum(tchreqnumcallerexcludehosms ),
sum(tchsuccnumcallerexcludehosms),
sum(tchreqnumcalleeexcludehosms ),
sum(tchsuccnumcalleeexcludehosms),
sum(tchreqnumexcludehosms       ),
sum(tchsuccnumexcludehosms      ),
sum(tchreqnumincludehosms       ),
sum(tchsuccnumincludehosms      ),
sum(btssyshardhoreqnum          ),
sum(btssyshardhosuccnum         ),
sum(sysshoreqnum                ),
sum(sysshosuccnum               ),
sum(tchradiofnum                ),
sum(callpagereqtotalnum         ),
sum(numfailofcall               ),
round(sum(nvl(ps_CallPageReqNum,0) - nvl(ps_CallPageSuccNum,0))),
sum(cs_numfailofcall            )
from C_PERF_1X_SUM_LC_TEMP
group by int_id,scan_start_time,sum_level,ne_type,vendor_id;

commit;

v_sql:='truncate table  C_PERF_1X_SUM_LC_TEMP';
dbms_output.put_line(v_sql);
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');
execute immediate v_sql;
commit;


merge /*+ APPEND*/ into c_perf_1x_sum c_perf
using(
select
int_id,
ne_type,
sum(nvl(CallPageReqNum,0)) CallPageReqNum,
sum(nvl(CallPageSuccNum,0)) CallPageSuccNum,
sum(nvl(cs_CallPageReqNum,0) + nvl(ps_CallPageReqNum,0) - nvl(cs_CallPageSuccNum,0) - nvl(ps_CallPageSuccNum,0)) Numfailofcall,
sum(nvl(cs_CallPageReqNum,0) - nvl(cs_CallPageSuccNum,0)) cs_Numfailofcall,
sum(nvl(ps_CallPageReqNum,0) - nvl(ps_CallPageSuccNum,0)) ps_Numfailofcall,
100*sum(CallPageSuccNum)/decode(sum(CallPageReqNum),null,1,0,1,sum(CallPageReqNum)) CallPageSuccRate            ,
sum(nvl(cs_CallPageReqNum           ,0)) cs_CallPageReqNum           ,
sum(nvl(cs_CallPageSuccNum          ,0)) cs_CallPageSuccNum          ,
100*sum(cs_CallPageSuccNum)/decode(sum(cs_CallPageReqNum),0,1,null,1,sum(cs_CallPageReqNum)) cs_CallPageSuccRate         ,
sum(nvl(ps_CallPageReqNum           ,0)) ps_CallPageReqNum           ,
sum(nvl(ps_CallPageSuccNum          ,0)) ps_CallPageSuccNum          ,
100*sum(ps_CallPageSuccNum)/decode(sum(ps_CallPageReqNum),0,1,null,1,sum(ps_CallPageReqNum)) ps_CallPageSuccRate         ,
sum(nvl(TrafficIncludeHo            ,0)) TrafficIncludeHo            ,
sum(nvl(TrafficExcludeHo            ,0)) TrafficExcludeHo            ,
sum(nvl(cs_TrafficIncludeHo         ,0)) cs_TrafficIncludeHo         ,
sum(nvl(cs_TrafficExcludeHo         ,0)) cs_TrafficExcludeHo         ,
sum(nvl(cs_trafficByWalsh           ,0)) cs_trafficByWalsh           ,
sum(nvl(cs_SHOTraffic               ,0)) cs_SHOTraffic               ,
sum(nvl(cs_SSHOTraffic              ,0)) cs_SSHOTraffic              ,
100*sum(cs_SHOTraffic)/decode(sum(cs_TrafficExcludeHo+cs_SHOTraffic),null,1,0,1,sum(cs_TrafficExcludeHo+cs_SHOTraffic)) cs_SHORate                  ,
sum(nvl(ps_CallTrafficIncludeHo     ,0)) ps_CallTrafficIncludeHo     ,
sum(nvl(ps_CallTrafficExcludeHo     ,0)) ps_CallTrafficExcludeHo     ,
sum(nvl(ps_trafficByWalsh           ,0)) ps_trafficByWalsh           ,
sum(nvl(ps_SHOTraffic               ,0)) ps_SHOTraffic               ,
sum(nvl(ps_SSHOTraffic              ,0)) ps_SSHOTraffic              ,
100*sum(ps_SHOTraffic)/decode(sum(ps_CallTrafficExcludeHo + ps_SHOTraffic),null,1,0,1,sum(ps_CallTrafficExcludeHo + ps_SHOTraffic))  ps_SHORate                  ,
sum(nvl(LoseCallingNum              ,0)) LoseCallingNum              ,
100*sum(LoseCallingNum)/decode(sum(TchSuccNumExcludeHo),0,1,null,1,sum(TchSuccNumExcludeHo)) LoseCallingRate             ,
sum(TrafficExcludeHo)*60/decode(sum(LoseCallingNum),null,1,0,1,sum(LoseCallingNum))     LoseCallingratio,
sum(nvl(cs_LoseCallingNum           ,0)) cs_LoseCallingNum           ,
100*sum(cs_LoseCallingNum)/decode(sum(cs_TchSuccNumExcludeHo),null,1,0,1,sum(cs_TchSuccNumExcludeHo)) cs_LoseCallingRate   ,
case when sum(cs_LoseCallingNum) is null then 1000
     when sum(cs_LoseCallingNum) = 0     then 1000
else sum(nvl(cs_TrafficExcludeHo,0))*60/sum(cs_LoseCallingNum)
end                                            cs_LoseCallingratio,

sum(nvl(ps_LoseCallingNum           ,0)) ps_LoseCallingNum           ,
100*sum(ps_LoseCallingNum)/decode(sum(ps_TchSuccNumExcludeHo),null,1,0,1,sum(ps_TchSuccNumExcludeHo)) ps_LoseCallingRate          ,
sum(ps_CallTrafficExcludeHo)*60/decode(sum(ps_LoseCallingNum),null,1,0,1,sum(ps_LoseCallingNum)) ps_LoseCallingratio,
sum(nvl(TchReqNumIncludeHo          ,0)) TchReqNumIncludeHo          ,
sum(nvl(TchSuccNumIncludeHo         ,0)) TchSuccNumIncludeHo         ,
sum(nvl(TchFNumIncludeHo            ,0)) TchFNumIncludeHo            ,
100*sum(TchSuccNumIncludeHo)/decode(sum(TchReqNumIncludeHo),null,1,0,1,sum(TchReqNumIncludeHo)) TchSuccIncludeHoRate        ,
sum(nvl(TchReqNumExcludeHo          ,0)) TchReqNumExcludeHo          ,
sum(nvl(TchSuccNumExcludeHo         ,0)) TchSuccNumExcludeHo         ,
sum(nvl(TchFNumExcludeHo            ,0)) TchFNumExcludeHo            ,
100*sum(TchSuccNumExcludeHo)/decode(sum(TchReqNumExcludeHo),null,1,0,1,sum(TchReqNumExcludeHo)) TchSuccExcludeHoRate        ,
sum(nvl(CallBlockFailNum            ,0)) CallBlockFailNum            ,
100*sum(CallBlockFailNum)/decode(sum(TchReqNumIncludeHo),null,1,0,1,sum(TchReqNumIncludeHo)) CallBlockFailRate,
sum(nvl(cs_TchReqNumIncludeHo       ,0)) cs_TchReqNumIncludeHo       ,
sum(nvl(cs_TchSuccNumIncludeHo      ,0)) cs_TchSuccNumIncludeHo      ,
sum(nvl(cs_TchFNumIncludeHo         ,0)) cs_TchFNumIncludeHo         ,
100*sum(cs_TchSuccNumIncludeHo)/decode(sum(cs_TchReqNumIncludeHo),null,1,0,1,sum(cs_TchReqNumIncludeHo))  cs_TchSuccIncludeHoRate,
sum(nvl(cs_TchReqNumExcludeHo       ,0)) cs_TchReqNumExcludeHo       ,
sum(nvl(cs_TchSuccNumExcludeHo      ,0)) cs_TchSuccNumExcludeHo      ,
sum(nvl(cs_TchFNumExcludeHo         ,0)) cs_TchFNumExcludeHo         ,
avg(nvl(cs_TchSuccExcludeHoRate     ,0)) cs_TchSuccExcludeHoRate     ,
sum(nvl(cs_CallBlockFailNum         ,0)) cs_CallBlockFailNum         ,
100*sum(cs_CallBlockFailNum)/decode(sum(cs_TchReqNumIncludeHo),null,1,0,1,sum(cs_TchReqNumIncludeHo)) cs_CallBlockFailRate,
sum(nvl(cs_TchReqNumHardho          ,0)) cs_TchReqNumHardho          ,
sum(nvl(cs_TchSuccNumHardho         ,0)) cs_TchSuccNumHardho         ,
100*sum(cs_TchReqNumHardho-cs_TchSuccNumHardho)/decode(sum(cs_TchReqNumHardho),null,1,0,1,sum(cs_TchReqNumHardho)) cs_CallBlockFailRateHardho  ,
sum(nvl(cs_TchReqNumsoftho          ,0)) cs_TchReqNumsoftho          ,
sum(nvl(cs_TchSuccNumsoftho         ,0)) cs_TchSuccNumsoftho         ,
100*sum(cs_TchReqNumsoftho-cs_TchSuccNumsoftho)/decode(sum(cs_TchReqNumsoftho),null,1,0,1,sum(cs_TchReqNumsoftho)) cs_CallBlockFailRatesoftho  ,
sum(nvl(ps_TchReqNumIncludeHo       ,0)) ps_TchReqNumIncludeHo       ,
sum(nvl(ps_TchSuccNumIncludeHo      ,0)) ps_TchSuccNumIncludeHo      ,
sum(nvl(ps_TchFNumIncludeHo         ,0)) ps_TchFNumIncludeHo         ,
100*sum(ps_TchSuccNumIncludeHo)/decode(sum(ps_TchReqNumIncludeHo),null,1,0,1,sum(ps_TchReqNumIncludeHo)) ps_TchSuccIncludeHoRate     ,
sum(nvl(ps_TchReqNumExcludeHo       ,0)) ps_TchReqNumExcludeHo       ,
sum(nvl(ps_TchSuccNumExcludeHo      ,0)) ps_TchSuccNumExcludeHo      ,
sum(nvl(ps_TchFNumExcludeHo         ,0)) ps_TchFNumExcludeHo         ,
100*sum(ps_TchSuccNumExcludeHo)/decode(sum(ps_TchReqNumExcludeHo),null,1,0,1,sum(ps_TchReqNumExcludeHo)) ps_TchSuccExcludeHoRate     ,
sum(nvl(ps_CallBlockFailNum         ,0)) ps_CallBlockFailNum         ,
100* sum(ps_CallBlockFailNum)/decode(sum(ps_TchReqNumIncludeHo),null,1,0,1,sum(ps_TchReqNumIncludeHo)) ps_CallBlockFailRate        ,
sum(nvl(ps_TchReqNumHardho          ,0)) ps_TchReqNumHardho          ,
sum(nvl(ps_TchSuccNumHardho         ,0)) ps_TchSuccNumHardho         ,
100*sum(ps_TchReqNumHardho-ps_TchSuccNumHardho)/decode(sum(ps_TchReqNumHardho),null,1,0,1,sum(ps_TchReqNumHardho))  ps_CallBlockFailRateHardho  ,
sum(nvl(ps_TchReqNumsoftho          ,0)) ps_TchReqNumsoftho          ,
sum(nvl(ps_TchSuccNumsoftho         ,0)) ps_TchSuccNumsoftho         ,
100*sum(ps_TchReqNumsoftho-ps_TchSuccNumsoftho)/decode(sum(ps_TchReqNumsoftho),null,1,0,1,sum(ps_TchReqNumsoftho)) ps_CallBlockFailRatesoftho  ,
sum(nvl(HandoffReqNum               ,0)) HandoffReqNum               ,
sum(nvl(HandoffSuccNum              ,0)) HandoffSuccNum              ,
100*sum(HandoffSuccNum)/decode(sum(HandoffReqNum),null,1,0,1,sum(HandoffReqNum)) HandoffSuccRate,
sum(nvl(cs_HandoffReqNum            ,0)) cs_HandoffReqNum            ,
sum(nvl(cs_HandoffSuccNum           ,0)) cs_HandoffSuccNum           ,
100*sum(cs_HandoffSuccNum)/decode(sum(cs_HandoffReqNum),null,1,0,1,sum(cs_HandoffReqNum)) cs_HandoffSuccRate,
sum(nvl(cs_HardhoReqNum             ,0)) cs_HardhoReqNum             ,
sum(nvl(cs_HardhoSuccNum            ,0)) cs_HardhoSuccNum            ,
case when   sum(cs_HardhoReqNum) is null  then  100
     when   sum(cs_HardhoReqNum)   =  0   then  100
else  100*sum(nvl(cs_HardhoSuccNum,0))/sum(cs_HardhoReqNum)
end                                                          cs_HardhoSuccRate,

sum(nvl(cs_SofthoReqNum             ,0)) cs_SofthoReqNum             ,
sum(nvl(cs_SofthoSuccNum            ,0)) cs_SofthoSuccNum            ,
100*sum(cs_SofthoSuccNum)/decode(sum(cs_SofthoReqNum),null,1,0,1,sum(cs_SofthoReqNum)) cs_SofthoSuccRate,
sum(nvl(cs_SSofthoReqNum            ,0)) cs_SSofthoReqNum            ,
sum(nvl(cs_SSofthoSuccNum           ,0)) cs_SSofthoSuccNum           ,
100*sum(cs_SSofthoSuccNum)/decode(sum(cs_SSofthoReqNum),null,1,0,1,sum(cs_SSofthoReqNum)) cs_SSofthoSuccRate,
sum(nvl(ps_HandoffReqNum            ,0)) ps_HandoffReqNum            ,
sum(nvl(ps_HandoffSuccNum           ,0)) ps_HandoffSuccNum           ,
100*sum(ps_HandoffSuccNum)/decode(sum(ps_HandoffReqNum),null,1,0,1,sum(ps_HandoffReqNum)) ps_HandoffSuccRate          ,
sum(nvl(ps_HardhoReqNum             ,0)) ps_HardhoReqNum             ,
sum(nvl(ps_HardhoSuccNum            ,0)) ps_HardhoSuccNum            ,
100*sum(ps_HardhoSuccNum)/decode(sum(ps_HardhoReqNum),null,1,0,1,sum(ps_HardhoReqNum)) ps_HardhoSuccRate           ,
sum(nvl(ps_SofthoReqNum             ,0)) ps_SofthoReqNum             ,
sum(nvl(ps_SofthoSuccNum            ,0)) ps_SofthoSuccNum            ,
100*sum(ps_SofthoSuccNum)/decode(sum(ps_SofthoReqNum),null,1,0,1,sum(ps_SofthoReqNum)) ps_SofthoSuccRate           ,
sum(nvl(ps_SSofthoReqNum            ,0)) ps_SSofthoReqNum            ,
sum(nvl(ps_SSofthoSuccNum           ,0)) ps_SSofthoSuccNum           ,
100*sum(ps_SSofthoSuccNum)/decode(sum(ps_SSofthoReqNum),null,1,0,1,sum(ps_SSofthoReqNum)) ps_SSofthoSuccRate          ,
sum(nvl(HandoffReqNum_intra         ,0)) HandoffReqNum_intra         ,
sum(nvl(HandoffSuccNum_intra        ,0)) HandoffSuccNum_intra        ,
100*sum(HandoffSuccNum_intra)/decode(sum(HandoffReqNum_intra),null,1,0,1,sum(HandoffReqNum_intra)) HandoffSuccRate_intra       ,
sum(nvl(HandoffReqNum_Extra         ,0)) HandoffReqNum_Extra         ,
sum(nvl(HandoffSuccNum_Extra        ,0)) HandoffSuccNum_Extra        ,
100*sum(HandoffSuccNum_Extra)/decode(sum(HandoffReqNum_Extra),null,1,0,1,sum(HandoffReqNum_Extra)) HandoffSuccRate_Extra       ,
sum(nvl(HardhoReqNum_intra          ,0)) HardhoReqNum_intra          ,
sum(nvl(HardhoSuccNum_intra         ,0)) HardhoSuccNum_intra         ,
100*sum(HardhoSuccNum_intra)/decode(sum(HardhoReqNum_intra),null,1,0,1,sum(HardhoReqNum_intra)) HardhoSuccRate_intra        ,
sum(nvl(ShoReqNum_intra             ,0)) ShoReqNum_intra             ,
sum(nvl(ShoSuccNum_intra            ,0)) ShoSuccNum_intra            ,
100*sum(ShoSuccNum_intra)/decode(sum(ShoReqNum_intra),null,1,0,1,sum(ShoReqNum_intra)) ShoSuccRate_intra           ,
sum(nvl(SShoReqNum_intra            ,0)) SShoReqNum_intra            ,
sum(nvl(SShoSuccNum_intra           ,0)) SShoSuccNum_intra           ,
100*sum(SShoSuccNum_intra)/decode(sum(SShoReqNum_intra),null,1,0,1,sum(SShoReqNum_intra)) SShoSuccRate_intra          ,
sum(nvl(HardhoReqNum_Extra          ,0)) HardhoReqNum_Extra          ,
sum(nvl(HardhoSuccNum_Extra         ,0)) HardhoSuccNum_Extra         ,
100*sum(HardhoSuccNum_Extra)/decode(sum(HardhoReqNum_Extra),null,1,0,1,sum(HardhoReqNum_Extra)) HardhoSuccRate_Extra        ,
sum(nvl(ShoReqNum_Extra             ,0)) ShoReqNum_Extra             ,
sum(nvl(ShoSuccNum_Extra            ,0)) ShoSuccNum_Extra            ,
100*sum(ShoSuccNum_Extra)/decode(sum(ShoReqNum_Extra),null,1,0,1,sum(ShoReqNum_Extra)) ShoSuccRate_Extra           ,
sum(nvl(Carrier1BtsNum              ,0)) Carrier1BtsNum              ,
sum(nvl(Carrier2BtsNum              ,0)) Carrier2BtsNum              ,
sum(nvl(Carrier3BtsNum              ,0)) Carrier3BtsNum              ,
sum(nvl(Carrier4BtsNum              ,0)) Carrier4BtsNum              ,
sum(nvl(CARRIERNUM_1X               ,0)) CARRIERNUM_1X               ,
sum(nvl(ChannelNum                  ,0)) ChannelNum                  ,
sum(nvl(ChannelAvailNum             ,0)) ChannelAvailNum             ,
sum(nvl(ChannelMaxUseNum            ,0)) ChannelMaxUseNum            ,
max(nvl(ChannelMaxUseRate           ,0)) ChannelMaxUseRate           ,
sum(nvl(FwdChNum                    ,0)) FwdChNum                    ,
sum(nvl(FwdChAvailNum               ,0)) FwdChAvailNum               ,
sum(nvl(FwdChMaxUseNum              ,0)) FwdChMaxUseNum              ,
avg(nvl(FwdChMaxUseRate             ,0)) FwdChMaxUseRate             ,
sum(nvl(RevChNum                    ,0)) RevChNum                    ,
sum(nvl(RevChAvailNum               ,0)) RevChAvailNum               ,
sum(nvl(RevChMaxUseNum              ,0)) RevChMaxUseNum              ,
avg(nvl(RevChMaxUseRate             ,0)) RevChMaxUseRate             ,
sum(nvl(FwdRxTotalFrame             ,0)) FwdRxTotalFrame             ,
sum(nvl(FdwTxTotalFrameExcludeRx    ,0)) FdwTxTotalFrameExcludeRx    ,
sum(nvl(RLPFwdChSizeExcludeRx       ,0)) RLPFwdChSizeExcludeRx       ,
sum(nvl(RLPFwdChRxSize              ,0)) RLPFwdChRxSize              ,
sum(nvl(RLPFwdLoseSize              ,0)) RLPFwdLoseSize              ,
avg(nvl(FwdChRxRate                 ,0)) FwdChRxRate                 ,
sum(nvl(RevRxTotalFrame             ,0)) RevRxTotalFrame             ,
sum(nvl(RevTxTotalFrameExcludeRx    ,0)) RevTxTotalFrameExcludeRx    ,
sum(nvl(RLPRevChSize                ,0)) RLPRevChSize                ,
100*sum(RevRxTotalFrame)/decode(sum(RevTxTotalFrameExcludeRx),null,1,0,1,sum(RevTxTotalFrameExcludeRx)) RevChRxRate                 ,
sum(nvl(BtsNum                      ,0)) BtsNum                      ,
sum(nvl(OnecarrierBtsNum            ,0)) OnecarrierBtsNum            ,
sum(nvl(TwocarrierBtsNum            ,0)) TwocarrierBtsNum            ,
sum(nvl(threecarrierBtsNum          ,0)) threecarrierBtsNum          ,
sum(nvl(FourcarrierBtsNum           ,0)) FourcarrierBtsNum           ,
sum(nvl(CellNum                     ,0)) CellNum                     ,
sum(nvl(OnecarrierCellNum           ,0)) OnecarrierCellNum           ,
sum(nvl(TwocarrierCellNum           ,0)) TwocarrierCellNum           ,
sum(nvl(threecarrierCellNum         ,0)) threecarrierCellNum         ,
sum(nvl(FourcarrierCellNum          ,0)) FourcarrierCellNum          ,
sum(nvl(CENum                       ,0)) CENum                       ,
sum(nvl(Wirecapacity                ,0)) Wirecapacity                ,
sum(nvl(TCHNum                      ,0)) TCHNum                      ,
100*sum(TCHLoadTrafficIncludeHo)/decode(sum(Wirecapacity),null,1,0,1,sum(Wirecapacity)) TCHLoadRate                 ,
100*sum(TCHLoadTrafficIncludeHo - TCHLoadTrafficExcludeHo)/decode(sum(TCHLoadTrafficExcludeHo),0,1,null,1,sum(TCHLoadTrafficExcludeHo)) SHoFactor                   ,
case when 100*sum(CEAvailNum)/decode(sum(CENum),null,1,0,1,sum(CENum))>=100 then 100 else 100*sum(CEAvailNum)/decode(sum(CENum),null,1,0,1,sum(CENum)) end CEAvailRate                 ,
100*sum(TCHBlockFailNumIncludeHo)/decode(sum(TchReqNumIncludeHoSms),null,1,0,1,sum(TchReqNumIncludeHoSms)) TCHBlockFailRate            ,
100*sum(BusyerCellNum)/decode(sum(CellNum),null,1,0,1,sum(CellNum)) BusyerCellratio             ,
100*sum(BusyCellNum)/decode(sum(CellNum),null,1,0,1,sum(CellNum))  BusyCellratio               ,
100*sum(FreeCellNum)/decode(sum(CellNum),null,1,0,1,sum(CellNum))  FreeCellratio               ,
100*sum(SeriOverflowBtsNum)/decode(sum(BtsNum),null,1,0,1,sum(BtsNum)) SeriOverflowBtsratio        ,
100*sum(OverflowBtsNum)/decode(sum(BtsNum),null,1,0,1,sum(BtsNum))  OverflowBtsratio            ,
100*sum(BtsSysHardHoSuccNum)/decode(sum(BtsSysHardHoReqNum),null,1,0,1,sum(BtsSysHardHoReqNum)) BtsSysHardHoSuccRate        ,
100*sum(SysSHoSuccNum)/decode(sum(SysSHoReqNum),null,1,0,1,sum(SysSHoReqNum))  SysSHoSuccRate              ,
100*sum(TCHRadioFNum)/decode(sum(TchSuccNumCallerExcludeHoSms+TchSuccNumCalleeExcludeHoSms),null,1,0,1,sum(TchSuccNumCallerExcludeHoSms+TchSuccNumCalleeExcludeHoSms)) TchRadioFRate               ,
100*sum(TCHRadioFNum)/decode(sum(cs_CallPageSuccNum),null,1,0,1,sum(cs_CallPageSuccNum))  CallInterruptRate           ,
60*sum(TCHLoadTrafficExcludeHo)/decode(sum(TCHRadioFNum),null,1,0,1,sum(TCHRadioFNum)) AvgRadioFPeriod             ,
100*sum(nvl(BadCellNum,0))/decode(sum(CellNum),0,1,null,1,sum(CellNum)) BadCellRatio                ,
sum(nvl(CEAvailNum                  ,0)) CEAvailNum                  ,
sum(nvl(TCHBlockFailNumIncludeHo    ,0)) TCHBlockFailNumIncludeHo    ,
sum(nvl(TCHLoadTrafficIncludeHo     ,0)) TCHLoadTrafficIncludeHo     ,
sum(nvl(TCHLoadTrafficExcludeHo     ,0)) TCHLoadTrafficExcludeHo     ,
sum(nvl(LoadTrafficByWalsh          ,0)) LoadTrafficByWalsh          ,
sum(nvl(TrafficCarrier1             ,0)) TrafficCarrier1             ,
sum(nvl(TrafficCarrier2             ,0)) TrafficCarrier2             ,
sum(nvl(TrafficCarrier3             ,0)) TrafficCarrier3             ,
sum(nvl(TrafficCarrier4             ,0)) TrafficCarrier4             ,
sum(nvl(BusyerCellNum               ,0)) BusyerCellNum               ,
sum(nvl(BusyCellNum                 ,0)) BusyCellNum                 ,
sum(nvl(FreeCellNum                 ,0)) FreeCellNum                 ,
sum(nvl(BadCellNum                  ,0)) BadCellNum                  ,
sum(nvl(SeriOverflowBtsNum          ,0)) SeriOverflowBtsNum          ,
sum(nvl(OverflowBtsNum              ,0)) OverflowBtsNum              ,
sum(nvl(TchReqNumCallerExcludeHoSms ,0)) TchReqNumCallerExcludeHoSms ,
sum(nvl(TchSuccNumCallerExcludeHoSms,0)) TchSuccNumCallerExcludeHoSms,
sum(nvl(TchReqNumCalleeExcludeHoSms ,0)) TchReqNumCalleeExcludeHoSms ,
sum(nvl(TchSuccNumCalleeExcludeHoSms,0)) TchSuccNumCalleeExcludeHoSms,
sum(nvl(TchReqNumExcludeHoSms       ,0)) TchReqNumExcludeHoSms       ,
sum(nvl(TchSuccNumExcludeHoSms      ,0)) TchSuccNumExcludeHoSms      ,
sum(nvl(TchReqNumIncludeHoSms       ,0)) TchReqNumIncludeHoSms       ,
sum(nvl(TchSuccNumIncludeHoSms      ,0)) TchSuccNumIncludeHoSms      ,
sum(nvl(BtsSysHardHoReqNum          ,0)) BtsSysHardHoReqNum          ,
sum(nvl(BtsSysHardHoSuccNum         ,0)) BtsSysHardHoSuccNum         ,
sum(nvl(SysSHoReqNum                ,0)) SysSHoReqNum                ,
sum(nvl(SysSHoSuccNum               ,0)) SysSHoSuccNum               ,
sum(nvl(TCHRadioFNum                ,0)) TCHRadioFNum                ,
sum(nvl(CallPageReqTotalNum,0)) CallPageReqTotalNum
from c_perf_1x_sum
where scan_start_time = v_date and vendor_id in (7,10) and sum_level=0 and ne_type=10000
group by int_id,ne_type) t
on(c_perf.int_id = t.int_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10000 and c_perf.sum_level=0 and c_perf.vendor_id=99)
when matched then update set
CallPageReqNum               = t.CallPageReqNum          ,
CallPageSuccNum              = t.CallPageSuccNum         ,
Numfailofcall                = t.Numfailofcall,
cs_Numfailofcall             = t.cs_Numfailofcall,
ps_Numfailofcall = t.ps_Numfailofcall,
CallPageSuccRate             = t.CallPageSuccRate        ,
cs_CallPageReqNum            = t.cs_CallPageReqNum       ,
cs_CallPageSuccNum           = t.cs_CallPageSuccNum      ,
cs_CallPageSuccRate          = t.cs_CallPageSuccRate     ,
ps_CallPageReqNum            = t.ps_CallPageReqNum       ,
ps_CallPageSuccNum           = t.ps_CallPageSuccNum      ,
ps_CallPageSuccRate          = t.ps_CallPageSuccRate     ,
TrafficIncludeHo             = t.TrafficIncludeHo        ,
TrafficExcludeHo             = t.TrafficExcludeHo        ,
cs_TrafficIncludeHo          = t.cs_TrafficIncludeHo     ,
cs_TrafficExcludeHo          = t.cs_TrafficExcludeHo     ,
cs_trafficByWalsh            = t.cs_trafficByWalsh       ,
cs_SHOTraffic                = t.cs_SHOTraffic           ,
cs_SSHOTraffic               = t.cs_SSHOTraffic          ,
cs_SHORate                   = t.cs_SHORate              ,
ps_CallTrafficIncludeHo      = t.ps_CallTrafficIncludeHo ,
ps_CallTrafficExcludeHo      = t.ps_CallTrafficExcludeHo ,
ps_trafficByWalsh            = t.ps_trafficByWalsh       ,
ps_SHOTraffic                = t.ps_SHOTraffic           ,
ps_SSHOTraffic               = t.ps_SSHOTraffic          ,
ps_SHORate                   = t.ps_SHORate              ,
LoseCallingNum               = t.LoseCallingNum          ,
LoseCallingRate              = t.LoseCallingRate         ,
LoseCallingratio             = t.LoseCallingratio        ,
cs_LoseCallingNum            = t.cs_LoseCallingNum       ,
cs_LoseCallingRate           = t.cs_LoseCallingRate      ,
cs_LoseCallingratio          = t.cs_LoseCallingratio     ,
ps_LoseCallingNum            = t.ps_LoseCallingNum       ,
ps_LoseCallingRate           = t.ps_LoseCallingRate      ,
ps_LoseCallingratio          = t.ps_LoseCallingratio     ,
TchReqNumIncludeHo           = t.TchReqNumIncludeHo      ,
TchSuccNumIncludeHo          = t.TchSuccNumIncludeHo     ,
TchFNumIncludeHo             = t.TchFNumIncludeHo        ,
TchSuccIncludeHoRate         = t.TchSuccIncludeHoRate    ,
TchReqNumExcludeHo           = t.TchReqNumExcludeHo      ,
TchSuccNumExcludeHo          = t.TchSuccNumExcludeHo     ,
TchFNumExcludeHo             = t.TchFNumExcludeHo        ,
TchSuccExcludeHoRate         = t.TchSuccExcludeHoRate    ,
CallBlockFailNum             = t.CallBlockFailNum        ,
CallBlockFailRate            = t.CallBlockFailRate       ,
cs_TchReqNumIncludeHo        = t.cs_TchReqNumIncludeHo   ,
cs_TchSuccNumIncludeHo       = t.cs_TchSuccNumIncludeHo  ,
cs_TchFNumIncludeHo          = t.cs_TchFNumIncludeHo     ,
cs_TchSuccIncludeHoRate      = t.cs_TchSuccIncludeHoRate ,
cs_TchReqNumExcludeHo        = t.cs_TchReqNumExcludeHo   ,
cs_TchSuccNumExcludeHo       = t.cs_TchSuccNumExcludeHo  ,
cs_TchFNumExcludeHo          = t.cs_TchFNumExcludeHo     ,
cs_TchSuccExcludeHoRate      = t.cs_TchSuccExcludeHoRate ,
cs_CallBlockFailNum          = t.cs_CallBlockFailNum     ,
cs_CallBlockFailRate         = t.cs_CallBlockFailRate    ,
cs_TchReqNumHardho           = t.cs_TchReqNumHardho      ,
cs_TchSuccNumHardho          = t.cs_TchSuccNumHardho     ,
cs_CallBlockFailRateHardho   = t.cs_CallBlockFailRateHardho,
cs_TchReqNumsoftho           = t.cs_TchReqNumsoftho        ,
cs_TchSuccNumsoftho          = t.cs_TchSuccNumsoftho       ,
cs_CallBlockFailRatesoftho   = t.cs_CallBlockFailRatesoftho,
ps_TchReqNumIncludeHo        = t.ps_TchReqNumIncludeHo     ,
ps_TchSuccNumIncludeHo       = t.ps_TchSuccNumIncludeHo    ,
ps_TchFNumIncludeHo          = t.ps_TchFNumIncludeHo       ,
ps_TchSuccIncludeHoRate      = t.ps_TchSuccIncludeHoRate   ,
ps_TchReqNumExcludeHo        = t.ps_TchReqNumExcludeHo     ,
ps_TchSuccNumExcludeHo       = t.ps_TchSuccNumExcludeHo    ,
ps_TchFNumExcludeHo          = t.ps_TchFNumExcludeHo       ,
ps_TchSuccExcludeHoRate      = t.ps_TchSuccExcludeHoRate   ,
ps_CallBlockFailNum          = t.ps_CallBlockFailNum       ,
ps_CallBlockFailRate         = t.ps_CallBlockFailRate      ,
ps_TchReqNumHardho           = t.ps_TchReqNumHardho        ,
ps_TchSuccNumHardho          = t.ps_TchSuccNumHardho       ,
ps_CallBlockFailRateHardho   = t.ps_CallBlockFailRateHardho,
ps_TchReqNumsoftho           = t.ps_TchReqNumsoftho        ,
ps_TchSuccNumsoftho          = t.ps_TchSuccNumsoftho       ,
ps_CallBlockFailRatesoftho   = t.ps_CallBlockFailRatesoftho,
HandoffReqNum                = t.HandoffReqNum             ,
HandoffSuccNum               = t.HandoffSuccNum            ,
HandoffSuccRate              = t.HandoffSuccRate           ,
cs_HandoffReqNum             = t.cs_HandoffReqNum          ,
cs_HandoffSuccNum            = t.cs_HandoffSuccNum         ,
cs_HandoffSuccRate           = t.cs_HandoffSuccRate        ,
cs_HardhoReqNum              = t.cs_HardhoReqNum           ,
cs_HardhoSuccNum             = t.cs_HardhoSuccNum          ,
cs_HardhoSuccRate            = t.cs_HardhoSuccRate         ,
cs_SofthoReqNum              = t.cs_SofthoReqNum           ,
cs_SofthoSuccNum             = t.cs_SofthoSuccNum          ,
cs_SofthoSuccRate            = t.cs_SofthoSuccRate         ,
cs_SSofthoReqNum             = t.cs_SSofthoReqNum          ,
cs_SSofthoSuccNum            = t.cs_SSofthoSuccNum         ,
cs_SSofthoSuccRate           = t.cs_SSofthoSuccRate        ,
ps_HandoffReqNum             = t.ps_HandoffReqNum          ,
ps_HandoffSuccNum            = t.ps_HandoffSuccNum         ,
ps_HandoffSuccRate           = t.ps_HandoffSuccRate        ,
ps_HardhoReqNum              = t.ps_HardhoReqNum           ,
ps_HardhoSuccNum             = t.ps_HardhoSuccNum          ,
ps_HardhoSuccRate            = t.ps_HardhoSuccRate         ,
ps_SofthoReqNum              = t.ps_SofthoReqNum           ,
ps_SofthoSuccNum             = t.ps_SofthoSuccNum          ,
ps_SofthoSuccRate            = t.ps_SofthoSuccRate         ,
ps_SSofthoReqNum             = t.ps_SSofthoReqNum          ,
ps_SSofthoSuccNum            = t.ps_SSofthoSuccNum         ,
ps_SSofthoSuccRate           = t.ps_SSofthoSuccRate        ,
HandoffReqNum_intra          = t.HandoffReqNum_intra       ,
HandoffSuccNum_intra         = t.HandoffSuccNum_intra      ,
HandoffSuccRate_intra        = t.HandoffSuccRate_intra     ,
HandoffReqNum_Extra          = t.HandoffReqNum_Extra       ,
HandoffSuccNum_Extra         = t.HandoffSuccNum_Extra      ,
HandoffSuccRate_Extra        = t.HandoffSuccRate_Extra     ,
HardhoReqNum_intra           = t.HardhoReqNum_intra        ,
HardhoSuccNum_intra          = t.HardhoSuccNum_intra       ,
HardhoSuccRate_intra         = t.HardhoSuccRate_intra      ,
ShoReqNum_intra              = t.ShoReqNum_intra           ,
ShoSuccNum_intra             = t.ShoSuccNum_intra          ,
ShoSuccRate_intra            = t.ShoSuccRate_intra         ,
SShoReqNum_intra             = t.SShoReqNum_intra          ,
SShoSuccNum_intra            = t.SShoSuccNum_intra         ,
SShoSuccRate_intra           = t.SShoSuccRate_intra        ,
HardhoReqNum_Extra           = t.HardhoReqNum_Extra        ,
HardhoSuccNum_Extra          = t.HardhoSuccNum_Extra       ,
HardhoSuccRate_Extra         = t.HardhoSuccRate_Extra      ,
ShoReqNum_Extra              = t.ShoReqNum_Extra           ,
ShoSuccNum_Extra             = t.ShoSuccNum_Extra          ,
ShoSuccRate_Extra            = t.ShoSuccRate_Extra         ,
Carrier1BtsNum               = t.Carrier1BtsNum            ,
Carrier2BtsNum               = t.Carrier2BtsNum            ,
Carrier3BtsNum               = t.Carrier3BtsNum            ,
Carrier4BtsNum               = t.Carrier4BtsNum            ,
CARRIERNUM_1X                = t.CARRIERNUM_1X             ,
ChannelNum                   = t.ChannelNum                ,
ChannelAvailNum              = t.ChannelAvailNum           ,
ChannelMaxUseNum             = t.ChannelMaxUseNum          ,
ChannelMaxUseRate            = t.ChannelMaxUseRate         ,
FwdChNum                     = t.FwdChNum                  ,
FwdChAvailNum                = t.FwdChAvailNum             ,
FwdChMaxUseNum               = t.FwdChMaxUseNum            ,
FwdChMaxUseRate              = t.FwdChMaxUseRate           ,
RevChNum                     = t.RevChNum                  ,
RevChAvailNum                = t.RevChAvailNum             ,
RevChMaxUseNum               = t.RevChMaxUseNum            ,
RevChMaxUseRate              = t.RevChMaxUseRate           ,
FwdRxTotalFrame              = t.FwdRxTotalFrame           ,
FdwTxTotalFrameExcludeRx     = t.FdwTxTotalFrameExcludeRx  ,
RLPFwdChSizeExcludeRx        = t.RLPFwdChSizeExcludeRx     ,
RLPFwdChRxSize               = t.RLPFwdChRxSize            ,
RLPFwdLoseSize               = t.RLPFwdLoseSize            ,
FwdChRxRate                  = t.FwdChRxRate               ,
RevRxTotalFrame              = t.RevRxTotalFrame           ,
RevTxTotalFrameExcludeRx     = t.RevTxTotalFrameExcludeRx  ,
RLPRevChSize                 = t.RLPRevChSize              ,
RevChRxRate                  = t.RevChRxRate               ,
BtsNum                       = t.BtsNum                    ,
OnecarrierBtsNum             = t.OnecarrierBtsNum          ,
TwocarrierBtsNum             = t.TwocarrierBtsNum          ,
threecarrierBtsNum           = t.threecarrierBtsNum        ,
FourcarrierBtsNum            = t.FourcarrierBtsNum         ,
CellNum                      = t.CellNum                   ,
OnecarrierCellNum            = t.OnecarrierCellNum         ,
TwocarrierCellNum            = t.TwocarrierCellNum         ,
threecarrierCellNum          = t.threecarrierCellNum       ,
FourcarrierCellNum           = t.FourcarrierCellNum        ,
CENum                        = t.CENum                     ,
Wirecapacity                 = t.Wirecapacity              ,
TCHNum                       = t.TCHNum                    ,
TCHLoadRate                  = t.TCHLoadRate               ,
SHoFactor                    = t.SHoFactor                 ,
CEAvailRate                  = t.CEAvailRate               ,
TCHBlockFailRate             = t.TCHBlockFailRate          ,
BusyerCellratio              = t.BusyerCellratio           ,
BusyCellratio                = t.BusyCellratio             ,
FreeCellratio                = t.FreeCellratio             ,
SeriOverflowBtsratio         = t.SeriOverflowBtsratio      ,
OverflowBtsratio             = t.OverflowBtsratio          ,
BtsSysHardHoSuccRate         = t.BtsSysHardHoSuccRate      ,
SysSHoSuccRate               = t.SysSHoSuccRate            ,
TchRadioFRate                = t.TchRadioFRate             ,
CallInterruptRate            = t.CallInterruptRate         ,
AvgRadioFPeriod              = t.AvgRadioFPeriod           ,
BadCellRatio                 = t.BadCellRatio              ,
CEAvailNum                   = t.CEAvailNum                ,
TCHBlockFailNumIncludeHo     = t.TCHBlockFailNumIncludeHo  ,
TCHLoadTrafficIncludeHo      = t.TCHLoadTrafficIncludeHo   ,
TCHLoadTrafficExcludeHo      = t.TCHLoadTrafficExcludeHo   ,
LoadTrafficByWalsh           = t.LoadTrafficByWalsh        ,
TrafficCarrier1              = t.TrafficCarrier1           ,
TrafficCarrier2              = t.TrafficCarrier2           ,
TrafficCarrier3              = t.TrafficCarrier3           ,
TrafficCarrier4              = t.TrafficCarrier4           ,
BusyerCellNum                = t.BusyerCellNum             ,
BusyCellNum                  = t.BusyCellNum               ,
FreeCellNum                  = t.FreeCellNum               ,
BadCellNum                   = t.BadCellNum                ,
SeriOverflowBtsNum           = t.SeriOverflowBtsNum        ,
OverflowBtsNum               = t.OverflowBtsNum            ,
TchReqNumCallerExcludeHoSms  = t.TchReqNumCallerExcludeHoSms ,
TchSuccNumCallerExcludeHoSms = t.TchSuccNumCallerExcludeHoSms,
TchReqNumCalleeExcludeHoSms  = t.TchReqNumCalleeExcludeHoSms ,
TchSuccNumCalleeExcludeHoSms = t.TchSuccNumCalleeExcludeHoSms,
TchReqNumExcludeHoSms        = t.TchReqNumExcludeHoSms       ,
TchSuccNumExcludeHoSms       = t.TchSuccNumExcludeHoSms      ,
TchReqNumIncludeHoSms        = t.TchReqNumIncludeHoSms       ,
TchSuccNumIncludeHoSms       = t.TchSuccNumIncludeHoSms      ,
BtsSysHardHoReqNum           = t.BtsSysHardHoReqNum          ,
BtsSysHardHoSuccNum          = t.BtsSysHardHoSuccNum         ,
SysSHoReqNum                 = t.SysSHoReqNum                ,
SysSHoSuccNum                = t.SysSHoSuccNum               ,
TCHRadioFNum                 = t.TCHRadioFNum                ,
CallPageReqTotalNum          = t.CallPageReqTotalNum
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CallPageReqNum          ,
CallPageSuccNum         ,
Numfailofcall,
cs_Numfailofcall,
ps_Numfailofcall,
CallPageSuccRate        ,
cs_CallPageReqNum       ,
cs_CallPageSuccNum      ,
cs_CallPageSuccRate     ,
ps_CallPageReqNum       ,
ps_CallPageSuccNum      ,
ps_CallPageSuccRate     ,
TrafficIncludeHo        ,
TrafficExcludeHo        ,
cs_TrafficIncludeHo     ,
cs_TrafficExcludeHo     ,
cs_trafficByWalsh       ,
cs_SHOTraffic           ,
cs_SSHOTraffic          ,
cs_SHORate              ,
ps_CallTrafficIncludeHo ,
ps_CallTrafficExcludeHo ,
ps_trafficByWalsh       ,
ps_SHOTraffic           ,
ps_SSHOTraffic          ,
ps_SHORate              ,
LoseCallingNum          ,
LoseCallingRate         ,
LoseCallingratio        ,
cs_LoseCallingNum       ,
cs_LoseCallingRate      ,
cs_LoseCallingratio     ,
ps_LoseCallingNum       ,
ps_LoseCallingRate      ,
ps_LoseCallingratio     ,
TchReqNumIncludeHo      ,
TchSuccNumIncludeHo     ,
TchFNumIncludeHo        ,
TchSuccIncludeHoRate    ,
TchReqNumExcludeHo      ,
TchSuccNumExcludeHo     ,
TchFNumExcludeHo        ,
TchSuccExcludeHoRate    ,
CallBlockFailNum        ,
CallBlockFailRate       ,
cs_TchReqNumIncludeHo   ,
cs_TchSuccNumIncludeHo  ,
cs_TchFNumIncludeHo     ,
cs_TchSuccIncludeHoRate ,
cs_TchReqNumExcludeHo   ,
cs_TchSuccNumExcludeHo  ,
cs_TchFNumExcludeHo     ,
cs_TchSuccExcludeHoRate ,
cs_CallBlockFailNum     ,
cs_CallBlockFailRate    ,
cs_TchReqNumHardho      ,
cs_TchSuccNumHardho     ,
cs_CallBlockFailRateHardho,
cs_TchReqNumsoftho        ,
cs_TchSuccNumsoftho       ,
cs_CallBlockFailRatesoftho,
ps_TchReqNumIncludeHo     ,
ps_TchSuccNumIncludeHo    ,
ps_TchFNumIncludeHo       ,
ps_TchSuccIncludeHoRate   ,
ps_TchReqNumExcludeHo     ,
ps_TchSuccNumExcludeHo    ,
ps_TchFNumExcludeHo       ,
ps_TchSuccExcludeHoRate   ,
ps_CallBlockFailNum       ,
ps_CallBlockFailRate      ,
ps_TchReqNumHardho        ,
ps_TchSuccNumHardho       ,
ps_CallBlockFailRateHardho,
ps_TchReqNumsoftho        ,
ps_TchSuccNumsoftho       ,
ps_CallBlockFailRatesoftho,
HandoffReqNum             ,
HandoffSuccNum            ,
HandoffSuccRate           ,
cs_HandoffReqNum          ,
cs_HandoffSuccNum         ,
cs_HandoffSuccRate        ,
cs_HardhoReqNum           ,
cs_HardhoSuccNum          ,
cs_HardhoSuccRate         ,
cs_SofthoReqNum           ,
cs_SofthoSuccNum          ,
cs_SofthoSuccRate         ,
cs_SSofthoReqNum          ,
cs_SSofthoSuccNum         ,
cs_SSofthoSuccRate        ,
ps_HandoffReqNum          ,
ps_HandoffSuccNum         ,
ps_HandoffSuccRate        ,
ps_HardhoReqNum           ,
ps_HardhoSuccNum          ,
ps_HardhoSuccRate         ,
ps_SofthoReqNum           ,
ps_SofthoSuccNum          ,
ps_SofthoSuccRate         ,
ps_SSofthoReqNum          ,
ps_SSofthoSuccNum         ,
ps_SSofthoSuccRate        ,
HandoffReqNum_intra       ,
HandoffSuccNum_intra      ,
HandoffSuccRate_intra     ,
HandoffReqNum_Extra       ,
HandoffSuccNum_Extra      ,
HandoffSuccRate_Extra     ,
HardhoReqNum_intra        ,
HardhoSuccNum_intra       ,
HardhoSuccRate_intra      ,
ShoReqNum_intra           ,
ShoSuccNum_intra          ,
ShoSuccRate_intra         ,
SShoReqNum_intra          ,
SShoSuccNum_intra         ,
SShoSuccRate_intra        ,
HardhoReqNum_Extra        ,
HardhoSuccNum_Extra       ,
HardhoSuccRate_Extra      ,
ShoReqNum_Extra           ,
ShoSuccNum_Extra          ,
ShoSuccRate_Extra         ,
Carrier1BtsNum            ,
Carrier2BtsNum            ,
Carrier3BtsNum            ,
Carrier4BtsNum            ,
CARRIERNUM_1X             ,
ChannelNum                ,
ChannelAvailNum           ,
ChannelMaxUseNum          ,
ChannelMaxUseRate         ,
FwdChNum                  ,
FwdChAvailNum             ,
FwdChMaxUseNum            ,
FwdChMaxUseRate           ,
RevChNum                  ,
RevChAvailNum             ,
RevChMaxUseNum            ,
RevChMaxUseRate           ,
FwdRxTotalFrame           ,
FdwTxTotalFrameExcludeRx  ,
RLPFwdChSizeExcludeRx     ,
RLPFwdChRxSize            ,
RLPFwdLoseSize            ,
FwdChRxRate               ,
RevRxTotalFrame           ,
RevTxTotalFrameExcludeRx  ,
RLPRevChSize              ,
RevChRxRate               ,
BtsNum                    ,
OnecarrierBtsNum          ,
TwocarrierBtsNum          ,
threecarrierBtsNum        ,
FourcarrierBtsNum         ,
CellNum                   ,
OnecarrierCellNum         ,
TwocarrierCellNum         ,
threecarrierCellNum       ,
FourcarrierCellNum        ,
CENum                     ,
Wirecapacity              ,
TCHNum                    ,
TCHLoadRate               ,
SHoFactor                 ,
CEAvailRate               ,
TCHBlockFailRate          ,
BusyerCellratio           ,
BusyCellratio             ,
FreeCellratio             ,
SeriOverflowBtsratio      ,
OverflowBtsratio          ,
BtsSysHardHoSuccRate      ,
SysSHoSuccRate            ,
TchRadioFRate             ,
CallInterruptRate         ,
AvgRadioFPeriod           ,
BadCellRatio              ,
CEAvailNum                ,
TCHBlockFailNumIncludeHo  ,
TCHLoadTrafficIncludeHo   ,
TCHLoadTrafficExcludeHo   ,
LoadTrafficByWalsh        ,
TrafficCarrier1           ,
TrafficCarrier2           ,
TrafficCarrier3           ,
TrafficCarrier4           ,
BusyerCellNum             ,
BusyCellNum               ,
FreeCellNum               ,
BadCellNum                ,
SeriOverflowBtsNum        ,
OverflowBtsNum            ,
TchReqNumCallerExcludeHoSms ,
TchSuccNumCallerExcludeHoSms,
TchReqNumCalleeExcludeHoSms ,
TchSuccNumCalleeExcludeHoSms,
TchReqNumExcludeHoSms       ,
TchSuccNumExcludeHoSms      ,
TchReqNumIncludeHoSms       ,
TchSuccNumIncludeHoSms      ,
BtsSysHardHoReqNum          ,
BtsSysHardHoSuccNum         ,
SysSHoReqNum                ,
SysSHoSuccNum               ,
TCHRadioFNum                ,
CallPageReqTotalNum)
values(
t.int_id,
v_date,
0,
10000,
99,
t.CallPageReqNum          ,
t.CallPageSuccNum         ,
t.Numfailofcall,
t.cs_Numfailofcall,
t.ps_Numfailofcall,
t.CallPageSuccRate        ,
t.cs_CallPageReqNum       ,
t.cs_CallPageSuccNum      ,
t.cs_CallPageSuccRate     ,
t.ps_CallPageReqNum       ,
t.ps_CallPageSuccNum      ,
t.ps_CallPageSuccRate     ,
t.TrafficIncludeHo        ,
t.TrafficExcludeHo        ,
t.cs_TrafficIncludeHo     ,
t.cs_TrafficExcludeHo     ,
t.cs_trafficByWalsh       ,
t.cs_SHOTraffic           ,
t.cs_SSHOTraffic          ,
t.cs_SHORate              ,
t.ps_CallTrafficIncludeHo ,
t.ps_CallTrafficExcludeHo ,
t.ps_trafficByWalsh       ,
t.ps_SHOTraffic           ,
t.ps_SSHOTraffic          ,
t.ps_SHORate              ,
t.LoseCallingNum          ,
t.LoseCallingRate         ,
t.LoseCallingratio        ,
t.cs_LoseCallingNum       ,
t.cs_LoseCallingRate      ,
t.cs_LoseCallingratio     ,
t.ps_LoseCallingNum       ,
t.ps_LoseCallingRate      ,
t.ps_LoseCallingratio     ,
t.TchReqNumIncludeHo      ,
t.TchSuccNumIncludeHo     ,
t.TchFNumIncludeHo        ,
t.TchSuccIncludeHoRate    ,
t.TchReqNumExcludeHo      ,
t.TchSuccNumExcludeHo     ,
t.TchFNumExcludeHo        ,
t.TchSuccExcludeHoRate    ,
t.CallBlockFailNum        ,
t.CallBlockFailRate       ,
t.cs_TchReqNumIncludeHo   ,
t.cs_TchSuccNumIncludeHo  ,
t.cs_TchFNumIncludeHo     ,
t.cs_TchSuccIncludeHoRate ,
t.cs_TchReqNumExcludeHo   ,
t.cs_TchSuccNumExcludeHo  ,
t.cs_TchFNumExcludeHo     ,
t.cs_TchSuccExcludeHoRate ,
t.cs_CallBlockFailNum     ,
t.cs_CallBlockFailRate    ,
t.cs_TchReqNumHardho      ,
t.cs_TchSuccNumHardho     ,
t.cs_CallBlockFailRateHardho,
t.cs_TchReqNumsoftho        ,
t.cs_TchSuccNumsoftho       ,
t.cs_CallBlockFailRatesoftho,
t.ps_TchReqNumIncludeHo     ,
t.ps_TchSuccNumIncludeHo    ,
t.ps_TchFNumIncludeHo       ,
t.ps_TchSuccIncludeHoRate   ,
t.ps_TchReqNumExcludeHo     ,
t.ps_TchSuccNumExcludeHo    ,
t.ps_TchFNumExcludeHo       ,
t.ps_TchSuccExcludeHoRate   ,
t.ps_CallBlockFailNum       ,
t.ps_CallBlockFailRate      ,
t.ps_TchReqNumHardho        ,
t.ps_TchSuccNumHardho       ,
t.ps_CallBlockFailRateHardho,
t.ps_TchReqNumsoftho        ,
t.ps_TchSuccNumsoftho       ,
t.ps_CallBlockFailRatesoftho,
t.HandoffReqNum             ,
t.HandoffSuccNum            ,
t.HandoffSuccRate           ,
t.cs_HandoffReqNum          ,
t.cs_HandoffSuccNum         ,
t.cs_HandoffSuccRate        ,
t.cs_HardhoReqNum           ,
t.cs_HardhoSuccNum          ,
t.cs_HardhoSuccRate         ,
t.cs_SofthoReqNum           ,
t.cs_SofthoSuccNum          ,
t.cs_SofthoSuccRate         ,
t.cs_SSofthoReqNum          ,
t.cs_SSofthoSuccNum         ,
t.cs_SSofthoSuccRate        ,
t.ps_HandoffReqNum          ,
t.ps_HandoffSuccNum         ,
t.ps_HandoffSuccRate        ,
t.ps_HardhoReqNum           ,
t.ps_HardhoSuccNum          ,
t.ps_HardhoSuccRate         ,
t.ps_SofthoReqNum           ,
t.ps_SofthoSuccNum          ,
t.ps_SofthoSuccRate         ,
t.ps_SSofthoReqNum          ,
t.ps_SSofthoSuccNum         ,
t.ps_SSofthoSuccRate        ,
t.HandoffReqNum_intra       ,
t.HandoffSuccNum_intra      ,
t.HandoffSuccRate_intra     ,
t.HandoffReqNum_Extra       ,
t.HandoffSuccNum_Extra      ,
t.HandoffSuccRate_Extra     ,
t.HardhoReqNum_intra        ,
t.HardhoSuccNum_intra       ,
t.HardhoSuccRate_intra      ,
t.ShoReqNum_intra           ,
t.ShoSuccNum_intra          ,
t.ShoSuccRate_intra         ,
t.SShoReqNum_intra          ,
t.SShoSuccNum_intra         ,
t.SShoSuccRate_intra        ,
t.HardhoReqNum_Extra        ,
t.HardhoSuccNum_Extra       ,
t.HardhoSuccRate_Extra      ,
t.ShoReqNum_Extra           ,
t.ShoSuccNum_Extra          ,
t.ShoSuccRate_Extra         ,
t.Carrier1BtsNum            ,
t.Carrier2BtsNum            ,
t.Carrier3BtsNum            ,
t.Carrier4BtsNum            ,
t.CARRIERNUM_1X             ,
t.ChannelNum                ,
t.ChannelAvailNum           ,
t.ChannelMaxUseNum          ,
t.ChannelMaxUseRate         ,
t.FwdChNum                  ,
t.FwdChAvailNum             ,
t.FwdChMaxUseNum            ,
t.FwdChMaxUseRate           ,
t.RevChNum                  ,
t.RevChAvailNum             ,
t.RevChMaxUseNum            ,
t.RevChMaxUseRate           ,
t.FwdRxTotalFrame           ,
t.FdwTxTotalFrameExcludeRx  ,
t.RLPFwdChSizeExcludeRx     ,
t.RLPFwdChRxSize            ,
t.RLPFwdLoseSize            ,
t.FwdChRxRate               ,
t.RevRxTotalFrame           ,
t.RevTxTotalFrameExcludeRx  ,
t.RLPRevChSize              ,
t.RevChRxRate               ,
t.BtsNum                    ,
t.OnecarrierBtsNum          ,
t.TwocarrierBtsNum          ,
t.threecarrierBtsNum        ,
t.FourcarrierBtsNum         ,
t.CellNum                   ,
t.OnecarrierCellNum         ,
t.TwocarrierCellNum         ,
t.threecarrierCellNum       ,
t.FourcarrierCellNum        ,
t.CENum                     ,
t.Wirecapacity              ,
t.TCHNum                    ,
t.TCHLoadRate               ,
t.SHoFactor                 ,
t.CEAvailRate               ,
t.TCHBlockFailRate          ,
t.BusyerCellratio           ,
t.BusyCellratio             ,
t.FreeCellratio             ,
t.SeriOverflowBtsratio      ,
t.OverflowBtsratio          ,
t.BtsSysHardHoSuccRate      ,
t.SysSHoSuccRate            ,
t.TchRadioFRate             ,
t.CallInterruptRate         ,
t.AvgRadioFPeriod           ,
t.BadCellRatio              ,
t.CEAvailNum                ,
t.TCHBlockFailNumIncludeHo  ,
t.TCHLoadTrafficIncludeHo   ,
t.TCHLoadTrafficExcludeHo   ,
t.LoadTrafficByWalsh        ,
t.TrafficCarrier1           ,
t.TrafficCarrier2           ,
t.TrafficCarrier3           ,
t.TrafficCarrier4           ,
t.BusyerCellNum             ,
t.BusyCellNum               ,
t.FreeCellNum               ,
t.BadCellNum                ,
t.SeriOverflowBtsNum        ,
t.OverflowBtsNum            ,
t.TchReqNumCallerExcludeHoSms ,
t.TchSuccNumCallerExcludeHoSms,
t.TchReqNumCalleeExcludeHoSms ,
t.TchSuccNumCalleeExcludeHoSms,
t.TchReqNumExcludeHoSms       ,
t.TchSuccNumExcludeHoSms      ,
t.TchReqNumIncludeHoSms       ,
t.TchSuccNumIncludeHoSms      ,
t.BtsSysHardHoReqNum          ,
t.BtsSysHardHoSuccNum         ,
t.SysSHoReqNum                ,
t.SysSHoSuccNum               ,
t.TCHRadioFNum                ,
t.CallPageReqTotalNum);
commit;


dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');


v_sql:='truncate table  C_PERF_1X_SUM_LC_TEMP';
dbms_output.put_line(v_sql);
execute immediate v_sql;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');

v_sql:='truncate table C_TPD_1X_SUM_LC_TEMP';
dbms_output.put_line(v_sql);
execute immediate v_sql;
dbms_output.put_line('Now time:'||sysdate||'----------------------------------------');




-----------------------------------------------------------------------------------------------------
exception when others then
s_error := sqlerrm;
rollback;
insert into job_log values(sysdate,'proc_c_perf_1x_sum_lc',s_error);
commit;

end;
