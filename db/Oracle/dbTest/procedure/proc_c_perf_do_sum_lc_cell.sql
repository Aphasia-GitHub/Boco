create or replace procedure proc_c_perf_do_sum_lc_cell(p_date date)
as
v_date date;
s_error varchar2(4000);

begin
--if null then v_date = sysdate-3 (3hours before) else v_date = p_date
select trunc(decode(p_date,null,trunc(sysdate-3/24,'hh24'),p_date),'hh24') into v_date from dual;
--c_tpd_carr_do_ag_lc a,c_tpd_carr_do_lc b,c_carrier c,c_tpd_evm_do_lc d
--ne_type =300(cell) sum_level=0
--由a实现


merge into c_perf_do_sum c_perf
using(
select
c_cell.city_id city_id,

--2011-11-04
--modify-225-226 ---by zhengting 20111109
round(sum(nvl(a.Hdr293,0)+nvl(a.Hdr292,0)-nvl(a.hdr311,0))/
decode(sum(nvl(a.Hdr225,0)+nvl(a.Hdr226,0)-nvl(a.hdr310,0)),0,1,null,1,sum(nvl(a.Hdr225,0)+nvl(a.Hdr226,0)-nvl(a.hdr310,0)))*100,4) WireConnectSuccRate,
round(sum(nvl(a.Hdr293,0))/
decode(sum(nvl(a.Hdr225,0)-nvl(a.Hdr509,0)-nvl(a.Hdr306,0)+nvl(a.Hdr304,0)),0,1,null,1,sum(nvl(a.Hdr225,0)-nvl(a.Hdr509,0)-nvl(a.Hdr306,0)+nvl(a.Hdr304,0)))*100,4) AT_ConnectSuccRate,
round(sum(nvl(a.Hdr292,0))/
decode(sum(nvl(a.Hdr226,0)-nvl(a.Hdr510,0)-nvl(a.Hdr307,0)+nvl(a.Hdr305,0)),0,1,null,1,sum(nvl(a.Hdr226,0)-nvl(a.Hdr510,0)-nvl(a.Hdr307,0)+nvl(a.Hdr305,0)))*100,4) AN_ConnectSuccRate,
sum(nvl(a.Hdr226,0)-nvl(hdr310,0)) AT_ConnectReqNum,
sum(nvl(a.Hdr225,0)) AN_ConnectReqNum,
sum(nvl(a.Hdr293,0)-nvl(Hdr311,0)) AT_ConnectSuccNum,
sum(nvl(a.Hdr292,0)) AN_ConnectSuccNum,
sum(nvl(a.Hdr023,0)+nvl(a.Hdr024,0)+nvl(a.Hdr026,0)+nvl(a.Hdr220,0)) WireConnectReleaseNumInPDSN,
sum(nvl(a.Hdr028,0)) WireRadioFNum3,
round(sum(nvl(a.Hdr247,0))/
decode(sum(nvl(a.Hdr238,0)),0,1,null,1,sum(nvl(a.Hdr238,0)))*100,4) UATI_AssgnSuccRate,
sum(nvl(a.Hdr238,0)) UATI_AssgnReqNum,
sum(nvl(a.Hdr247,0)) UATI_AssgnSuccNum,
--update-2011-9-14
--sum(nvl(a.Hdr238,0)+nvl(a.Hdr237,0)+nvl(a.Hdr373,0)-nvl(a.Hdr247,0)-nvl(a.Hdr271,0)-nvl(a.Hdr376,0)) UATI_AssgnFailNum,
sum(nvl(a.Hdr238,0) -nvl(a.Hdr247,0)) UATI_AssgnFailNum,
round(100*sum(nvl(a.Hdr095,0)-nvl(a.Hdr022,0)-nvl(a.Hdr021,0))/
decode(sum(nvl(a.Hdr095,0)-nvl(a.Hdr022,0)-nvl(a.Hdr021,0)+nvl(a.Hdr022,0)+nvl(a.Hdr021,0)),0,1,null,1,sum(nvl(a.Hdr095,0)-nvl(a.Hdr022,0)-nvl(a.Hdr021,0)+nvl(a.Hdr022,0)+nvl(a.Hdr021,0))),4) SessionNegoSRate,
sum(nvl(a.Hdr095,0)-nvl(a.Hdr022,0)-nvl(a.Hdr021,0)) SessionNegoSNum,
sum(nvl(a.Hdr022,0)+nvl(a.Hdr021,0)) SessionNegoFNum,
--update-8-25
sum((a.HDR002*8)/decode((360*1000*(nvl(a.Hdr059,0)+nvl(a.Hdr060,0)
+nvl(a.Hdr061,0)+nvl(a.Hdr062,0)+nvl(a.Hdr063,0)
+nvl(a.Hdr064,0)+nvl(a.Hdr065,0)+nvl(a.Hdr066,0)
+nvl(a.Hdr067,0)+nvl(a.Hdr068,0)+nvl(a.Hdr069,0)
--update-8-25
+nvl(a.Hdr070,0))*0.00667),0,1,null,1,(1000*360*(nvl(a.Hdr059,0)+nvl(a.Hdr060,0)
+nvl(a.Hdr061,0)+nvl(a.Hdr062,0)+nvl(a.Hdr063,0)
+nvl(a.Hdr064,0)+nvl(a.Hdr065,0)+nvl(a.Hdr066,0)
+nvl(a.Hdr067,0)+nvl(a.Hdr068,0)+nvl(a.Hdr069,0)
+nvl(a.Hdr070,0))*0.00667))) RevRLPThroughput,
round(sum(nvl(a.Hdr003,0)+nvl(a.Hdr108,0))/decode(sum(nvl(a.Hdr002,0)-nvl(a.Hdr115,0)-nvl(a.Hdr111,0)-nvl(a.Hdr112,0)),0,1,null,1,sum(nvl(a.Hdr002,0)-nvl(a.Hdr115,0)-nvl(a.Hdr111,0)-nvl(a.Hdr112,0)))*100,4) RevRLPRxRate,
(sum(128*nvl(a.Hdr059,0)+256*nvl(a.Hdr060,0)
+512*nvl(a.Hdr061,0)+768*nvl(a.Hdr062,0)
+1024*nvl(a.Hdr063,0)+1536*nvl(a.Hdr064,0)
+2048*nvl(a.Hdr065,0)+3072*nvl(a.Hdr066,0)
+4096*nvl(a.Hdr067,0)+6144*nvl(a.Hdr068,0)
+8192*nvl(a.Hdr069,0)+12288*nvl(a.Hdr070,0))/1000)/3600 RevTCHPhyAvgThroughput,
(sum(128*nvl(a.Hdr059,0)+256*nvl(a.Hdr060,0)
+512*nvl(a.Hdr061,0)+768*nvl(a.Hdr062,0)
+1024*nvl(a.Hdr063,0)+1536*nvl(a.Hdr064,0)
+2048*nvl(a.Hdr065,0)+3072*nvl(a.Hdr066,0)
+4096*nvl(a.Hdr067,0)+6144*nvl(a.Hdr068,0)
+8192*nvl(a.Hdr069,0)+12288*nvl(a.Hdr070,0))/1000)/
decode((sum(nvl(a.Hdr059,0)+nvl(a.Hdr060,0)
+nvl(a.Hdr061,0)+nvl(a.Hdr062,0)
+nvl(a.Hdr063,0)+nvl(a.Hdr064,0)
+nvl(a.Hdr065,0)+nvl(a.Hdr066,0)
+nvl(a.Hdr067,0)+nvl(a.Hdr068,0)
+nvl(a.Hdr069,0)+nvl(a.Hdr070,0))*0.00667),0,1,null,1,(sum(nvl(a.Hdr059,0)+nvl(a.Hdr060,0)
+nvl(a.Hdr061,0)+nvl(a.Hdr062,0)
+nvl(a.Hdr063,0)+nvl(a.Hdr064,0)
+nvl(a.Hdr065,0)+nvl(a.Hdr066,0)
+nvl(a.Hdr067,0)+nvl(a.Hdr068,0)
+nvl(a.Hdr069,0)+nvl(a.Hdr070,0))*0.00667)) RevTCHPhyOutburstThroughput,
sum(nvl(a.Hdr003,0)+nvl(a.hdr108,0)) RevRxSize,
sum(nvl(a.Hdr002,0)-nvl(a.Hdr115,0)-nvl(a.Hdr111,0)-nvl(a.Hdr112,0)) RevTxSize,
sum(nvl(a.Hdr025,0)) WireRadioFNum1,
sum(nvl(a.Hdr153,0)) WireRadioFNum2,
sum(nvl(a.Hdr233,0)) GlobalSHoReqNum,
sum(nvl(a.Hdr233,0)-nvl(a.Hdr316,0)-nvl(Hdr318,0)-nvl(a.Hdr244,0)-(nvl(a.Hdr235,0)+nvl(a.Hdr236,0)+round(nvl(a.Hdr052,0)/2,0)+nvl(a.Hdr053,0))) GlobalSHoSuccNum,
sum(128*nvl(a.Hdr059,0)
+256*nvl(a.Hdr060,0)
+512*nvl(a.Hdr061,0)
+768*nvl(a.Hdr062,0)
+1024*nvl(a.Hdr063,0)
+1536*nvl(a.Hdr064,0)
+2048*nvl(a.Hdr065,0)
+3072*nvl(a.Hdr066,0)
+4096*nvl(a.Hdr067,0)
+6144*nvl(a.Hdr068,0)
+8192*nvl(a.Hdr069,0)
+12288*nvl(a.Hdr070,0)) RevTCHPhyTxBitNum,
sum(nvl(a.Hdr071,0)
+nvl(a.Hdr072,0)
+nvl(a.Hdr073,0)
+nvl(a.Hdr074,0)
+nvl(a.Hdr075,0)
+nvl(a.Hdr076,0)
+nvl(a.Hdr077,0)
+nvl(a.Hdr078,0)
+nvl(a.Hdr079,0)
+nvl(a.Hdr080,0)
+nvl(a.Hdr081,0)
+nvl(a.Hdr082,0))*0.00667 RevPhyUseTimeSlotDuration,

--modify-2011-10-31
round(100*sum(nvl(a.Hdr025,0)
+nvl(a.Hdr153,0)
+nvl(a.Hdr028,0))/
decode(sum(nvl(a.Hdr023,0)
+nvl(a.Hdr024,0)
+nvl(a.Hdr026,0)
+nvl(a.Hdr220,0)
+nvl(a.Hdr025,0)
+nvl(a.Hdr153,0)
+nvl(a.Hdr028,0)),0,1,null,1,sum(nvl(a.Hdr023,0)
+nvl(a.Hdr024,0)
+nvl(a.Hdr026,0)
+nvl(a.Hdr220,0)
+nvl(a.Hdr025,0)
+nvl(a.Hdr153,0)
+nvl(a.Hdr028,0))),4) WireRadioFRate,

round(100*sum(nvl(a.Hdr233,0)-nvl(a.Hdr316,0)-nvl(Hdr318,0)-nvl(a.Hdr244,0)-(nvl(a.Hdr235,0)+nvl(a.Hdr236,0)+nvl(a.Hdr052,0)/2+nvl(a.Hdr053,0)))/
decode(sum(nvl(a.Hdr233,0)),0,1,null,1,sum(nvl(a.Hdr233,0))),4)  GlobalSHoSuccRate,

--modify—2011-10-31
max(nvl(a.Hdr294,0)) FwdMaxBusyNum_MacIndex,
sum(nvl(a.Hdr225,0)) AT_DAAcitveReqNum,
sum(nvl(a.Hdr293,0)) AT_DAAcitveSuccNum,
sum(nvl(a.Hdr225,0)-nvl(a.Hdr293,0)) AT_DAAcitveFailNum,

sum(nvl(a.Hdr293,0)+nvl(a.Hdr292,0)) WireConnectSuccNumInA8A10,
sum(nvl(a.Hdr225,0)+nvl(a.Hdr226,0)) WireConnectReqNumInA8A10,
sum(nvl(a.Hdr229,0)+nvl(a.Hdr230,0)) WireConnectFailNum1,
sum(nvl(a.Hdr019,0)+nvl(a.Hdr020,0)) WireConnectFailNum2,
sum(nvl(a.Hdr231,0)+nvl(a.Hdr232,0)) WireConnectFailNum3,
sum(nvl(a.Hdr024,0))  ReleaseNumByPDSN,
sum(nvl(a.Hdr237,0)+nvl(a.Hdr050,0)) A13_HandoffNum,
sum((nvl(a.Hdr237,0)-(nvl(a.Hdr254,0)+nvl(a.Hdr256,0)+nvl(a.Hdr259,0)+nvl(a.Hdr255,0)+nvl(a.Hdr561,0)))+(nvl(a.Hdr050,0)-(nvl(a.Hdr224,0)+nvl(a.Hdr556,0)+nvl(a.Hdr555,0)+nvl(a.Hdr562,0)+nvl(a.Hdr269,0)+nvl(a.Hdr051,0)))) A13_HandoffSNum,
sum(nvl(a.Hdr226,0)) AN_DAAcitveReqNum,
sum(nvl(a.Hdr292,0)) AN_DAAcitveSuccNum,
sum(nvl(a.Hdr233,0)-nvl(a.Hdr316,0)-nvl(a.Hdr318,0)-nvl(a.Hdr244,0)) SHoReqNum_intraAN,
sum(nvl(a.Hdr233,0)-nvl(a.Hdr316,0)-nvl(a.Hdr318,0)-nvl(a.Hdr244,0)-(nvl(a.Hdr235,0)+nvl(a.Hdr236,0)+nvl(a.Hdr052,0)+nvl(a.Hdr053,0))) SHoSuccNum_intraAN,
sum(nvl(a.Hdr233,0)-nvl(a.Hdr316,0)-nvl(a.Hdr318,0)-nvl(a.Hdr244,0)) SHoReqNum_amongAN,
sum(nvl(a.Hdr233,0)-nvl(a.Hdr316,0)-nvl(a.Hdr318,0)-nvl(a.Hdr244,0)-(nvl(a.Hdr235,0)+nvl(a.Hdr236,0)+nvl(a.Hdr052,0)+nvl(a.Hdr053,0))) SHoSuccNum_amongAN,
sum(nvl(a.Hdr274,0)-nvl(a.Hdr288,0)-nvl(a.Hdr286,0)) HardHoReqNum_intraAN,
sum(nvl(a.Hdr274,0)-nvl(a.Hdr288,0)-nvl(a.Hdr286,0)-(nvl(a.Hdr276,0)+nvl(a.Hdr277,0)+nvl(a.Hdr278,0)+nvl(a.Hdr279,0))) HardHoSuccNum_intraAN,
sum(nvl(a.Hdr571,0)) HardHoReqNum_amongAN,
sum(nvl(a.Hdr573,0)) HardHoSuccNum_amongAN
from c_tpd_carr_do_ag_lc a,c_carrier c,c_cell
where a.int_id = c.int_id and c.related_cell = c_cell.int_id and c_cell.vendor_id=10
and a.scan_start_time = v_date and c_cell.city_id is not null
group by c_cell.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
WireConnectSuccRate         = t.WireConnectSuccRate        ,
AT_ConnectSuccRate          = t.AT_ConnectSuccRate         ,
AN_ConnectSuccRate          = t.AN_ConnectSuccRate         ,
AT_ConnectReqNum            = t.AT_ConnectReqNum           ,
AN_ConnectReqNum            = t.AN_ConnectReqNum           ,
AT_ConnectSuccNum           = t.AT_ConnectSuccNum          ,
AN_ConnectSuccNum           = t.AN_ConnectSuccNum          ,
WireConnectReleaseNumInPDSN = t.WireConnectReleaseNumInPDSN,
WireRadioFNum3              = t.WireRadioFNum3             ,
UATI_AssgnSuccRate          = t.UATI_AssgnSuccRate         ,
UATI_AssgnReqNum            = t.UATI_AssgnReqNum           ,
UATI_AssgnSuccNum           = t.UATI_AssgnSuccNum          ,
UATI_AssgnFailNum           = t.UATI_AssgnFailNum          ,
SessionNegoSRate            = t.SessionNegoSRate           ,
SessionNegoSNum             = t.SessionNegoSNum            ,
SessionNegoFNum             = t.SessionNegoFNum,
RevRLPThroughput            = t.RevRLPThroughput,
RevRLPRxRate                = t.RevRLPRxRate,
RevTCHPhyAvgThroughput      = t.RevTCHPhyAvgThroughput,
RevTCHPhyOutburstThroughput = t.RevTCHPhyOutburstThroughput,
RevRxSize                   = t.RevRxSize,
RevTxSize                   = t.RevTxSize,
WireRadioFNum1 = t.WireRadioFNum1,
WireRadioFNum2 = t.WireRadioFNum2,
GlobalSHoReqNum = t.GlobalSHoReqNum,
GlobalSHoSuccNum = t.GlobalSHoSuccNum,
RevTCHPhyTxBitNum = t.RevTCHPhyTxBitNum,
RevPhyUseTimeSlotDuration = t.RevPhyUseTimeSlotDuration,
WireRadioFRate = t.WireRadioFRate,
GlobalSHoSuccRate = t.GlobalSHoSuccRate,
------------modify by Lv--------
FwdMaxBusyNum_MacIndex=t.FwdMaxBusyNum_MacIndex,
AT_DAAcitveReqNum     =t.AT_DAAcitveReqNum,
AT_DAAcitveSuccNum    =t.AT_DAAcitveSuccNum,
AT_DAAcitveFailNum    =t.AT_DAAcitveFailNum,
WireConnectSuccNumInA8A10=t.WireConnectSuccNumInA8A10,
WireConnectReqNumInA8A10=t.WireConnectReqNumInA8A10,
WireConnectFailNum1=t.WireConnectFailNum1,
WireConnectFailNum2=t.WireConnectFailNum2,
WireConnectFailNum3=t.WireConnectFailNum3,
ReleaseNumByPDSN=t.ReleaseNumByPDSN,
A13_HandoffNum=t.A13_HandoffNum,
A13_HandoffSNum=t.A13_HandoffSNum,
AN_DAAcitveReqNum=t.AN_DAAcitveReqNum,
AN_DAAcitveSuccNum=t.AN_DAAcitveSuccNum,
SHoReqNum_intraAN=t.SHoReqNum_intraAN,
SHoSuccNum_intraAN=t.SHoSuccNum_intraAN,
SHoReqNum_amongAN=t.SHoReqNum_amongAN,
SHoSuccNum_amongAN=t.SHoSuccNum_amongAN,
HardHoReqNum_intraAN=t.HardHoReqNum_intraAN,
HardHoSuccNum_intraAN=t.HardHoSuccNum_intraAN,
HardHoReqNum_amongAN=t.HardHoReqNum_amongAN,
HardHoSuccNum_amongAN=t.HardHoSuccNum_amongAN
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
WireConnectSuccRate         ,
AT_ConnectSuccRate          ,
AN_ConnectSuccRate          ,
AT_ConnectReqNum            ,
AN_ConnectReqNum            ,
AT_ConnectSuccNum           ,
AN_ConnectSuccNum           ,
WireConnectReleaseNumInPDSN ,
WireRadioFNum3              ,
UATI_AssgnSuccRate          ,
UATI_AssgnReqNum            ,
UATI_AssgnSuccNum           ,
UATI_AssgnFailNum           ,
SessionNegoSRate            ,
SessionNegoSNum             ,
SessionNegoFNum,
RevRLPThroughput,
RevRLPRxRate,
RevTCHPhyAvgThroughput,
RevTCHPhyOutburstThroughput,
RevRxSize,
RevTxSize,
WireRadioFNum1,
WireRadioFNum2,
GlobalSHoReqNum,
GlobalSHoSuccNum,
RevTCHPhyTxBitNum,
RevPhyUseTimeSlotDuration,
WireRadioFRate,
GlobalSHoSuccRate,
----------modify by Lv----
FwdMaxBusyNum_MacIndex,
AT_DAAcitveReqNum,
AT_DAAcitveSuccNum,
AT_DAAcitveFailNum,
WireConnectSuccNumInA8A10,
WireConnectReqNumInA8A10,
WireConnectFailNum1,
WireConnectFailNum2,
WireConnectFailNum3,
ReleaseNumByPDSN,
A13_HandoffNum,
A13_HandoffSNum,
AN_DAAcitveReqNum,
AN_DAAcitveSuccNum,
SHoReqNum_intraAN,
SHoSuccNum_intraAN,
SHoReqNum_amongAN,
SHoSuccNum_amongAN,
HardHoReqNum_intraAN,
HardHoSuccNum_intraAN,
HardHoReqNum_amongAN,
HardHoSuccNum_amongAN
)
values(
t.city_id,
v_date,
0,
10004,
10,
t.WireConnectSuccRate         ,
t.AT_ConnectSuccRate          ,
t.AN_ConnectSuccRate          ,
t.AT_ConnectReqNum            ,
t.AN_ConnectReqNum            ,
t.AT_ConnectSuccNum           ,
t.AN_ConnectSuccNum           ,
t.WireConnectReleaseNumInPDSN ,
t.WireRadioFNum3              ,
t.UATI_AssgnSuccRate          ,
t.UATI_AssgnReqNum            ,
t.UATI_AssgnSuccNum           ,
t.UATI_AssgnFailNum           ,
t.SessionNegoSRate            ,
t.SessionNegoSNum             ,
t.SessionNegoFNum,
t.RevRLPThroughput,
t.RevRLPRxRate,
t.RevTCHPhyAvgThroughput,
t.RevTCHPhyOutburstThroughput,
t.RevRxSize,
t.RevTxSize,
t.WireRadioFNum1,
t.WireRadioFNum2,
t.GlobalSHoReqNum,
t.GlobalSHoSuccNum,
t.RevTCHPhyTxBitNum,
t.RevPhyUseTimeSlotDuration,
t.WireRadioFRate,
t.GlobalSHoSuccRate,
------modify by Lv---
t.FwdMaxBusyNum_MacIndex,
t.AT_DAAcitveReqNum,
t.AT_DAAcitveSuccNum,
t.AT_DAAcitveFailNum,
t.WireConnectSuccNumInA8A10,
t.WireConnectReqNumInA8A10,
t.WireConnectFailNum1,
t.WireConnectFailNum2,
t.WireConnectFailNum3,
t.ReleaseNumByPDSN,
t.A13_HandoffNum,
t.A13_HandoffSNum,
t.AN_DAAcitveReqNum,
t.AN_DAAcitveSuccNum,
t.SHoReqNum_intraAN,
t.SHoSuccNum_intraAN,
t.SHoReqNum_amongAN,
t.SHoSuccNum_amongAN,
t.HardHoReqNum_intraAN,
t.HardHoSuccNum_intraAN,
t.HardHoReqNum_amongAN,
t.HardHoSuccNum_amongAN
);
commit;




--由b实现
merge into c_perf_do_sum c_perf
using(
select
c_cell.city_id city_id,
------------2010-08-19------
sum(nvl(EVMACTIVEUSAGE,0))*0.001667/3600  EqlUserNum,
sum(nvl(EVMDRCRATE_0,0)+nvl(EVMDRCRATE_38_4,0)+nvl(EVMDRCRATE_76_8,0)+nvl(EVMDRCRATE_153_6,0)) DRCApplyNum_FwdSpeed1,
sum(nvl(EVMDRCRATE_307_2,0)+nvl(EVMDRCRATE_307_2_L,0)+nvl(EVMDRCRATE_614_4,0)+nvl(EVMDRCRATE_614_4_L,0)+nvl(EVMDRCRATE_921_6,0)+nvl(EVMDRCRATE_1228_8,0)+nvl(EVMDRCRATE_1228_8_L,0)) DRCApplyNum_FwdSpeed2,
sum(nvl(EVMDRCRATE_1536,0)+nvl(EVMDRCRATE_1843_2,0)+nvl(EVMDRCRATE_2457_6,0)+nvl(EVMDRCRATE_3072,0)) DRCApplyNum_FwdSpeed3,
sum(nvl(EVMFTCTOTBYTES_4_8,0)    +nvl(EVMFTCTOTBYTES_9_6,0)   +nvl(EVMFTCTOTBYTES_19_2,0) +
nvl(EVMFTCTOTBYTES_38_4,0)   +nvl(EVMFTCTOTBYTES_76_8,0)  +nvl(EVMFTCTOTBYTES_153_6,0) +nvl(EVMFTCTOTBYTES_307_2,0) +
nvl(EVMFTCTOTBYTES_614_4,0)  +nvl(EVMFTCTOTBYTES_921_6,0) +nvl(EVMFTCTOTBYTES_1228_8,0)+nvl(EVMFTCTOTBYTES_1536,0)  +
nvl(EVMFTCTOTBYTES_1843_2,0) +nvl(EVMFTCTOTBYTES_2457_6,0)+nvl(EVMFTCTOTBYTES_3072,0))*8 FwdTCHPhyTxBitNum,
sum(nvl(EVMFTCNUMSLOT_4_8,0)    +nvl(EVMFTCNUMSLOT_9_6,0)   +nvl(EVMFTCNUMSLOT_19_2,0) +
nvl(EVMFTCNUMSLOT_38_4,0)   +nvl(EVMFTCNUMSLOT_76_8,0)  +nvl(EVMFTCNUMSLOT_153_6,0) +nvl(EVMFTCNUMSLOT_307_2,0) +
nvl(EVMFTCNUMSLOT_614_4,0)  +nvl(EVMFTCNUMSLOT_921_6,0) +nvl(EVMFTCNUMSLOT_1228_8,0)+nvl(EVMFTCNUMSLOT_1536,0)  +
nvl(EVMFTCNUMSLOT_1843_2,0) +nvl(EVMFTCNUMSLOT_2457_6,0)+nvl(EVMFTCNUMSLOT_3072,0))*0.001667 FwdPhyUseTimeSlotDuration,
----------------------------
sum(nvl(b.EVMAVGDRCPOINTEDUSERS,0)*0.001) Call_Traffic,
sum(nvl(b.EVMRLPTXEDFTCBe,0)+nvl(b.EVMRLPTXEDFTCSMC,0)+nvl(b.EVMRLPTXEDFTCCPS,0)+nvl(b.EVMRLPTXEDFTCCS,0)+nvl(b.EVMRLPTXEDFTCCV,0))*8/(1000*3600) FwdRLPThroughput,
round(sum(nvl(b.EVMRLPRETXEDFTCBE,0)+nvl(b.EVMRLPRETXEDFTCSMC,0)+nvl(b.EVMRLPRETXEDFTCDARQBE,0)+nvl(b.EVMRLPRETXEDFTCDARQCPS,0)
+nvl(b.EVMRLPRETXEDFTCDARQCS,0)+nvl(b.EVMRLPRETXEDFTCDARQCV,0)+nvl(b.EVMRLPRETXEDFTCDARQSMC,0))/
decode(sum(nvl(b.EVMRLPTXEDFTCBE,0)+nvl(b.EVMRLPTXEDFTCSMC,0)+nvl(b.EVMRLPTXEDFTCCPS,0)+nvl(b.EVMRLPTXEDFTCCS,0)
+nvl(b.EVMRLPTXEDFTCCV,0)),0,1,null,1,sum(nvl(b.EVMRLPTXEDFTCBE,0)+nvl(b.EVMRLPTXEDFTCSMC,0)+nvl(b.EVMRLPTXEDFTCCPS,0)+nvl(b.EVMRLPTXEDFTCCS,0)
+nvl(b.EVMRLPTXEDFTCCV,0)))*100,4) FwdRLPRxRate,
sum(((nvl(b.EVMFTCTOTBYTES_4_8,0)
+nvl(b.EVMFTCTOTBYTES_9_6,0)
+nvl(b.EVMFTCTOTBYTES_19_2,0)
+nvl(b.EVMFTCTOTBYTES_38_4,0)
+nvl(b.EVMFTCTOTBYTES_76_8,0)
+nvl(b.EVMFTCTOTBYTES_153_6,0)
+nvl(b.EVMFTCTOTBYTES_307_2,0)
+nvl(b.EVMFTCTOTBYTES_614_4,0)
+nvl(b.EVMFTCTOTBYTES_921_6,0)
+nvl(b.EVMFTCTOTBYTES_1228_8,0)
+nvl(b.EVMFTCTOTBYTES_1536,0)
+nvl(b.EVMFTCTOTBYTES_1843_2,0)
+nvl(b.EVMFTCTOTBYTES_2457_6,0)
+nvl(b.EVMFTCTOTBYTES_3072,0))*8)/1000)/3600 FwdTCHPhyAvgThroughput,
--(sum(nvl(b.EVMFTCTOTBYTES_4_8,0)
--+nvl(b.EVMFTCTOTBYTES_9_6,0)
--+nvl(b.EVMFTCTOTBYTES_19_2,0)
--+nvl(b.EVMFTCTOTBYTES_38_4,0)
--+nvl(b.EVMFTCTOTBYTES_76_8,0)
--+nvl(b.EVMFTCTOTBYTES_153_6,0)
--+nvl(b.EVMFTCTOTBYTES_307_2,0)
--+nvl(b.EVMFTCTOTBYTES_614_4,0)
--+nvl(b.EVMFTCTOTBYTES_921_6,0)
--+nvl(b.EVMFTCTOTBYTES_1228_8,0)
--+nvl(b.EVMFTCTOTBYTES_1536,0)
--+nvl(b.EVMFTCTOTBYTES_1843_2,0)
--+nvl(b.EVMFTCTOTBYTES_2457_6,0)
--+nvl(b.EVMFTCTOTBYTES_3072,0))*8/1000)/
--decode(sum(nvl(b.EVMFTCTOTBYTES_4_8,0)
--+nvl(b.EVMFTCTOTBYTES_9_6,0)
--+nvl(b.EVMFTCTOTBYTES_19_2,0)
--+nvl(b.EVMFTCTOTBYTES_38_4,0)
--+nvl(b.EVMFTCTOTBYTES_76_8,0)
--+nvl(b.EVMFTCTOTBYTES_153_6,0)
--+nvl(b.EVMFTCTOTBYTES_307_2,0)
--+nvl(b.EVMFTCTOTBYTES_614_4,0)
--+nvl(b.EVMFTCTOTBYTES_921_6,0)
--+nvl(b.EVMFTCTOTBYTES_1228_8,0)
--+nvl(b.EVMFTCTOTBYTES_1536,0)
--+nvl(b.EVMFTCTOTBYTES_1843_2,0)
--+nvl(b.EVMFTCTOTBYTES_2457_6,0)
--+nvl(b.EVMFTCTOTBYTES_3072,0))*0.001667,0,1,null,1,
--sum(nvl(b.EVMFTCTOTBYTES_4_8,0)
--+nvl(b.EVMFTCTOTBYTES_9_6,0)
--+nvl(b.EVMFTCTOTBYTES_19_2,0)
--+nvl(b.EVMFTCTOTBYTES_38_4,0)
--+nvl(b.EVMFTCTOTBYTES_76_8,0)
--+nvl(b.EVMFTCTOTBYTES_153_6,0)
--+nvl(b.EVMFTCTOTBYTES_307_2,0)
--+nvl(b.EVMFTCTOTBYTES_614_4,0)
--+nvl(b.EVMFTCTOTBYTES_921_6,0)
--+nvl(b.EVMFTCTOTBYTES_1228_8,0)
--+nvl(b.EVMFTCTOTBYTES_1536,0)
--+nvl(b.EVMFTCTOTBYTES_1843_2,0)
--+nvl(b.EVMFTCTOTBYTES_2457_6,0)
--+nvl(b.EVMFTCTOTBYTES_3072,0))*0.001667) FwdTCHPhyOutburstThroughput,
--udpate-20119-15
(sum(b.EVMFTCTOTBYTES_4_8+b.EVMFTCTOTBYTES_9_6
+b.EVMFTCTOTBYTES_19_2+b.EVMFTCTOTBYTES_38_4+b.EVMFTCTOTBYTES_76_8
+b.EVMFTCTOTBYTES_153_6+b.EVMFTCTOTBYTES_307_2+b.EVMFTCTOTBYTES_614_4
+b.EVMFTCTOTBYTES_921_6+b.EVMFTCTOTBYTES_1228_8+b.EVMFTCTOTBYTES_1536
+b.EVMFTCTOTBYTES_1843_2+b.EVMFTCTOTBYTES_2457_6+b.EVMFTCTOTBYTES_3072)*8)/1000/
(decode(sum(b.EVMFTCNUMSLOT_4_8+b.EVMFTCNUMSLOT_9_6+b.EVMFTCNUMSLOT_19_2+b.EVMFTCNUMSLOT_38_4
+b.EVMFTCNUMSLOT_76_8+b.EVMFTCNUMSLOT_153_6+b.EVMFTCNUMSLOT_307_2+b.EVMFTCNUMSLOT_614_4
+b.EVMFTCNUMSLOT_921_6+b.EVMFTCNUMSLOT_1228_8+b.EVMFTCNUMSLOT_1536+b.EVMFTCNUMSLOT_1843_2
+b.EVMFTCNUMSLOT_2457_6+b.EVMFTCNUMSLOT_3072)*0.001667,0,1,null,1,
sum(b.EVMFTCNUMSLOT_4_8+b.EVMFTCNUMSLOT_9_6+b.EVMFTCNUMSLOT_19_2+b.EVMFTCNUMSLOT_38_4
+b.EVMFTCNUMSLOT_76_8+b.EVMFTCNUMSLOT_153_6+b.EVMFTCNUMSLOT_307_2+b.EVMFTCNUMSLOT_614_4
+b.EVMFTCNUMSLOT_921_6+b.EVMFTCNUMSLOT_1228_8+b.EVMFTCNUMSLOT_1536+b.EVMFTCNUMSLOT_1843_2
+b.EVMFTCNUMSLOT_2457_6+b.EVMFTCNUMSLOT_3072)*0.001667)) FwdTCHPhyOutburstThroughput,
100*round(sum(nvl(b.EVMTOTALBUSYSLOTSBE,0)
+nvl(b.EVMTOTALBUSYSLOTSEF,0))/
decode(sum(nvl(b.TIMESLOTSINPEGGINGINTERVAL,0)),0,1,null,1,sum(nvl(b.TIMESLOTSINPEGGINGINTERVAL,0))),4) FwdTCHPhyTimeSlotUseRate,
sum(decode(c.cdma_freq,37 ,b.EVMAVGDRCPOINTEDUSERS*0.001,0)) DOCarrier37Traffic,
sum(decode(c.cdma_freq,78 ,b.EVMAVGDRCPOINTEDUSERS*0.001,0)) DOCarrier78Traffic,
sum(decode(c.cdma_freq,119,b.EVMAVGDRCPOINTEDUSERS*0.001,0)) DOCarrier119Traffic,
sum(nvl(b.EVMRLPRETXEDFTCBE ,0)
+nvl(b.EVMRLPRETXEDFTCSMC,0)
+nvl(b.EVMRLPRETXEDFTCDARQBE,0)
+nvl(b.EVMRLPRETXEDFTCDARQCPS,0)
+nvl(b.EVMRLPRETXEDFTCDARQCS,0)
+nvl(b.EVMRLPRETXEDFTCDARQCV,0)
+nvl(b.EVMRLPRETXEDFTCDARQSMC,0)) FwdRxSize,
sum(nvl(b.EVMRLPTXEDFTCBE,0)+nvl(b.EVMRLPTXEDFTCSMC,0)+nvl(b.EVMRLPTXEDFTCCPS,0)+nvl(b.EVMRLPTXEDFTCCS,0)+nvl(b.EVMRLPTXEDFTCCV,0)) FwdTxSize,
100*round(sum(nvl(b.EVMCCSLOTSSYNCMSGXMIT,0)
+nvl(b.EVMCCSLOTSSUBSYNCMSGXMIT,0))/
decode(sum(nvl(b.TIMESLOTSINPEGGINGINTERVAL,0)),0,1,null,1,sum(nvl(b.TIMESLOTSINPEGGINGINTERVAL,0))),4) FwdCCHPhyTimeSlotUseRate
from c_tpd_carr_do_lc b,c_carrier c,c_cell
where b.int_id = c.int_id and c.related_cell = c_cell.int_id
and b.scan_start_time = v_date and c_cell.vendor_id=10 and c_cell.city_id is not null
group by c_cell.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
-------------2010-08-19------------
EqlUserNum           =t.EqlUserNum ,
DRCApplyNum_FwdSpeed1=t.DRCApplyNum_FwdSpeed1,
DRCApplyNum_FwdSpeed2=t.DRCApplyNum_FwdSpeed2,
DRCApplyNum_FwdSpeed3=t.DRCApplyNum_FwdSpeed3,
FwdTCHPhyTxBitNum           =t.FwdTCHPhyTxBitNum,
FwdPhyUseTimeSlotDuration   =t.FwdPhyUseTimeSlotDuration,
-----------------------------------
Call_Traffic                = t.Call_Traffic,
FwdRLPThroughput            = t.FwdRLPThroughput,
FwdRLPRxRate                = t.FwdRLPRxRate,
FwdTCHPhyAvgThroughput      = t.FwdTCHPhyAvgThroughput,
FwdTCHPhyOutburstThroughput = t.FwdTCHPhyOutburstThroughput,
FwdTCHPhyTimeSlotUseRate    = t.FwdTCHPhyTimeSlotUseRate,
DOCarrier37Traffic          = t.DOCarrier37Traffic,
DOCarrier78Traffic          = t.DOCarrier78Traffic,
DOCarrier119Traffic         = t.DOCarrier119Traffic,
FwdRxSize                   = t.FwdRxSize,
FwdTxSize                   = t.FwdTxSize,
FwdCCHPhyTimeSlotUseRate    = t.FwdCCHPhyTimeSlotUseRate
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
----2010-08-19----------
EqlUserNum,
DRCApplyNum_FwdSpeed1,
DRCApplyNum_FwdSpeed2,
DRCApplyNum_FwdSpeed3,
FwdTCHPhyTxBitNum,
FwdPhyUseTimeSlotDuration,
------------------------
Call_Traffic,
FwdRLPThroughput,
FwdRLPRxRate,
FwdTCHPhyAvgThroughput,
FwdTCHPhyOutburstThroughput,
FwdTCHPhyTimeSlotUseRate,
DOCarrier37Traffic,
DOCarrier78Traffic,
DOCarrier119Traffic,
FwdRxSize,
FwdTxSize,
FwdCCHPhyTimeSlotUseRate)
values(
t.city_id,
v_date,
0,
10004,
10,
----2010-08-19----------
t.EqlUserNum,
t.DRCApplyNum_FwdSpeed1,
t.DRCApplyNum_FwdSpeed2,
t.DRCApplyNum_FwdSpeed3,
t.FwdTCHPhyTxBitNum,
t.FwdPhyUseTimeSlotDuration,
------------------------
t.Call_Traffic,
t.FwdRLPThroughput,
t.FwdRLPRxRate,
t.FwdTCHPhyAvgThroughput,
t.FwdTCHPhyOutburstThroughput,
t.FwdTCHPhyTimeSlotUseRate,
t.DOCarrier37Traffic,
t.DOCarrier78Traffic,
t.DOCarrier119Traffic,
t.FwdRxSize,
t.FwdTxSize,
t.FwdCCHPhyTimeSlotUseRate);
commit;


--RevCEMaxUseRate
--RevCEMaxBusyNum
--RevCEAvailNum

merge into c_perf_do_sum c_perf
using(
select
c.city_id city_id,
round(sum(d.MODEM_CE_PEAK_USAGE)/
decode(sum(d.MODEM_CE_LICENSE_QUANTITY),0,1,null,1,sum(d.MODEM_CE_LICENSE_QUANTITY)),4) RevCEMaxUseRate,
sum(d.MODEM_CE_PEAK_USAGE) RevCEMaxBusyNum,
sum(d.MODEM_CE_LICENSE_QUANTITY) RevCEAvailNum
from c_tpd_evm_do_lc d,c_cell c
where d.int_id = c.int_id and d.scan_start_time = v_date and c.vendor_id=10 and c.city_id is not null
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
RevCEMaxUseRate = t.RevCEMaxUseRate,
RevCEMaxBusyNum = t.RevCEMaxBusyNum,
RevCEAvailNum   = t.RevCEAvailNum
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
RevCEMaxUseRate,
RevCEMaxBusyNum,
RevCEAvailNum)
values(
t.city_id,
v_date,
0,
10004,
10,
t.RevCEMaxUseRate,
t.RevCEMaxBusyNum,
t.RevCEAvailNum);
commit;


--DOCarrier37
--DOCarrier78
--DOCarrier119
--DOCarrierTotalNum

merge into c_perf_do_sum c_perf
using(
select
c.city_id city_id,
count(c.int_id) DOCarrier37
from c_carrier c
where c.cdma_freq = 37 and c.vendor_id = 10 and c.city_id is not null
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
DOCarrier37 = t.DOCarrier37
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
DOCarrier37)
values(
t.city_id,
v_date,
0,
10004,
10,
t.DOCarrier37);
commit;

merge into c_perf_do_sum c_perf
using(
select
c.city_id city_id,
count(c.int_id) DOCarrier78
from c_carrier c
where c.cdma_freq = 78 and c.vendor_id = 10 and c.city_id is not null
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
DOCarrier78 = t.DOCarrier78
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
DOCarrier78)
values(
t.city_id,
v_date,
0,
10004,
10,
t.DOCarrier78);
commit;

merge into c_perf_do_sum c_perf
using(
select
c.city_id city_id,
count(c.int_id) DOCarrier119
from c_carrier c
where c.cdma_freq = 119 and c.vendor_id = 10 and c.city_id is not null
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
DOCarrier119 = t.DOCarrier119
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
DOCarrier119)
values(
t.city_id,
v_date,
0,
10004,
10,
t.DOCarrier119);
commit;

--udpate-2011-9-2
--DOCarrierTotalNum
merge into c_perf_do_sum c_perf
using(
select
c_cell.city_id city_id,
count(c.int_id) DOCarrierTotalNum
from c_carrier c,c_cell
where c.related_cell=c_cell.int_id and c.car_type='DO' and c.vendor_id=10
and c_cell.city_id is not null
group by c_cell.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
DOCarrierTotalNum = t.DOCarrierTotalNum
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
DOCarrierTotalNum)
values(
t.city_id,
v_date,
0,
10004,
10,
t.DOCarrierTotalNum);
commit;


--merge into c_perf_do_sum c_perf
--using(
--with a as(
--select
--c.related_cell related_cell,
--count(a.int_id) cnt
--from c_tpd_carr_do_lc a,c_carrier c
--where a.int_id = c.int_id and a.scan_start_time = v_date
--group by c.related_cell),
--b as(
--select
--c.related_cell related_cell,
--count(a.int_id) cnt
--from c_tpd_carr_do_ag_lc a,c_carrier c
--where a.int_id = c.int_id and a.scan_start_time = v_date
--group by c.related_cell)
--select c_cell.city_id city_id,sum(a.cnt+b.cnt) DOCarrierTotalNum
--from a,b,c_cell
--where a.related_cell = b.related_cell and b.related_cell = c_cell.int_id and c_cell.vendor_id=10 and c_cell.city_id is not null
--group by c_cell.city_id) t
--on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
--when matched then update set
--DOCarrierTotalNum = t.DOCarrierTotalNum
--when not matched then insert(
--int_id,
--scan_start_time,
--sum_level,
--ne_type,
--vendor_id,
--DOCarrierTotalNum)
--values(
--t.city_id,
--v_date,
--0,
--10004,
--10,
--t.DOCarrierTotalNum);
--commit;

--OneDOCarrierCellNum
--TwoDOCarrierCellNum
--ThreeDOCarrierCellNum
--DOCellNum

--update-2011-8-30
merge into c_perf_do_sum c_perf
using(
--select a.city_id,a.OneDOCarrierCellNum,b.CarrierCellNum
--from
--(
--select b.city_id,count(distinct b.int_id) OneDOCarrierCellNum
--from
--(select related_cell int_id from
--c_carrier where cdma_freq in (37,78) and vendor_id=10
--group by city_id,related_cell having count(distinct cdma_freq)=1 ) a,c_cell b
--where a.int_id=b.int_id and b.city_id is not null
--group by b.city_id) a,
--(
--select b.city_id,count(distinct a.int_id) CarrierCellNum from c_carrier a ,c_cell b  where a.related_cell=b.int_id
--and a.cdma_freq in (37,78) and a.vendor_id=10 and b.vendor_id=10
--and b.city_id is not null
--group by b.city_id
--) b
--where a.city_id=b.city_id(+) ) t
with a as(
select
ne.int_id,
case count(c.int_id) when 1 then 1 else 0 end  OneDOCarrierCellNum,
case count(c.int_id) when 2 then 1 else 0 end  TwoDOCarrierCellNum,
case count(c.int_id) when 3 then 1 else 0 end  ThreeDOCarrierCellNum,
count(distinct ne.int_id) DOCellNum,
count(distinct c.int_id) CarrierCellNum
from c_carrier c,c_cell ne
where c.related_cell=ne.int_id and c.car_type='DO' and c.vendor_id=10
and ne.city_id is not null
group by ne.int_id
),

b as (
select
  ne.city_id,
  sum(OneDOCarrierCellNum) OneDOCarrierCellNum,
  sum(TwoDOCarrierCellNum) TwoDOCarrierCellNum,
  sum(threeDOCarrierCellNum) ThreeDOCarrierCellNum,
  sum(DOCellNum) DOCellNum,
  sum(CarrierCellNum) CarrierCellNum
  from c_cell ne,a
  where ne.int_id=a.int_id and ne.vendor_id=10
  group by ne.city_id
)
select
b.city_id,
10004 ne_type,
OneDOCarrierCellNum,
TwoDOCarrierCellNum,
ThreeDOCarrierCellNum,
DOCellNum,
CarrierCellNum
from b ) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
OneDOCarrierCellNum   = t.OneDOCarrierCellNum,
TwoDOCarrierCellNum    = t.TwoDOCarrierCellNum,
ThreeDOCarrierCellNum = t.ThreeDOCarrierCellNum,
CarrierCellNum        = t.CarrierCellNum
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
OneDOCarrierCellNum,
TwoDOCarrierCellNum,
ThreeDOCarrierCellNum,
CarrierCellNum)
values(
t.city_id,
v_date,
0,
10004,
10,
t.OneDOCarrierCellNum,
t.TwoDOCarrierCellNum,
t.ThreeDOCarrierCellNum,
t.CarrierCellNum);
commit;

--delete-8-30
--merge into c_perf_do_sum c_perf
--using(
--select b.city_id,count(distinct b.int_id) TwoDOCarrierCellNum
--from
--(select related_cell int_id from
--c_carrier where cdma_freq in (37,78) and vendor_id=10
--group by city_id,related_cell having count(distinct cdma_freq)=2 ) a,c_cell b
--where a.int_id=b.int_id and b.city_id is not null
--group by b.city_id) t
--on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
--when matched then update set
--TwoDOCarrierCellNum = t.TwoDOCarrierCellNum
--when not matched then insert(
--int_id,
--scan_start_time,
--sum_level,
--ne_type,
--vendor_id,
--TwoDOCarrierCellNum)
--values(
--t.city_id,
--v_date,
--0,
--10004,
--10,
--t.TwoDOCarrierCellNum);
--commit;

--delete-8-30
--merge into c_perf_do_sum c_perf
--using(
--select
--c.city_id city_id,
--count(d.int_id) ThreeDOCarrierCellNum
--from c_cell c,c_carrier d
--where c.int_id = d.related_cell and c.do_cell=1 and numfa=3 and c.vendor_id = 10 and c.city_id is not null
--group by c.city_id) t
--on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
--when matched then update set
--/*ThreeDOCarrierCellNum = t.ThreeDOCarrierCellNum*/
--ThreeDOCarrierCellNum=0
--when not matched then insert(
--int_id,
--scan_start_time,
--sum_level,
--ne_type,
--vendor_id,
--ThreeDOCarrierCellNum)
--values(
--t.city_id,
--v_date,
--0,
--10004,
--10,
----t.ThreeDOCarrierCellNum
--0);
--commit;

--delete-8-30
--merge into c_perf_do_sum c_perf
--using(
--select b.city_id ,count(distinct a.related_cell) DOCellNum
--from c_carrier a,c_cell b where a.related_cell=b.int_id and b.city_id is not null and  a.cdma_freq in (37,78)
--and a.vendor_id=10 group by b.city_id) t
--on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
--when matched then update set
--DOCellNum = t.DOCellNum
--when not matched then insert(
--int_id,
--scan_start_time,
--sum_level,
--ne_type,
--vendor_id,
--DOCellNum)
--values(
--t.city_id,
--v_date,
--0,
--10004,
--10,
--t.DOCellNum);
--commit;

--------------add by Lv-------------------
merge into c_perf_do_sum c_perf
using(
select
b.city_id,
--sum(nvl(a.PCF_INIT_REACT_ATTMPT,0)) AN_DAAcitveReqNum,
--sum(nvl(a.PCF_INIT_REACT_ATTMPT,0)-nvl(a.PCF_INIT_REACT_FAIL,0)) AN_DAAcitveSuccNum,
sum(nvl(PCF_INIT_REACT_FAIL,0))                          AN_DAAcitveFailNum
from c_tpd_tp_do_ag_lc a,c_bsc b
where a.unique_rdn=b.object_rdn and a.scan_start_time=v_date and b.vendor_id=10 and b.city_id is not null
group by b.city_id
) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
--AN_DAAcitveReqNum =t.AN_DAAcitveReqNum,
--AN_DAAcitveSuccNum=t.AN_DAAcitveSuccNum,
AN_DAAcitveFailNum=t.AN_DAAcitveFailNum
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
--AN_DAAcitveReqNum,
--AN_DAAcitveSuccNum,
AN_DAAcitveFailNum
)
values(
t.city_id,
v_date,
0,
10004,
10,
--t.AN_DAAcitveReqNum,
--t.AN_DAAcitveSuccNum,
t.AN_DAAcitveFailNum
);
commit;
------------------------------------------
-------------------------------------------------直接到city---------------------------------------------------


--udpate-2011-9-2
--BtsTotalNum
--OnecarrierBtsNum
--TwocarrierBtsNum
--threecarrierBtsNum
--FourcarrierBtsNum


merge into c_perf_do_sum c_perf
using(
select b.city_id ,count(distinct a.related_bts) BtsTotalNum
from c_carrier a,c_cell b where a.related_cell=b.int_id and b.city_id is not null and  a.car_type='DO'
and a.vendor_id=10 group by b.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
BtsTotalNum = t.BtsTotalNum
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
BtsTotalNum)
values(
t.city_id,
v_date,
0,
10004,
10,
t.BtsTotalNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.city_id,count(distinct a.related_bts) OnecarrierBtsNum
from
(select related_bts from
c_carrier where car_type='DO' and vendor_id=10
group by city_id,related_bts having count(distinct car_type)=1 ) a,c_cell b
where a.related_bts=b.related_bts and b.city_id is not null and b.vendor_id=10
group by b.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
OnecarrierBtsNum = t.OnecarrierBtsNum
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
OnecarrierBtsNum)
values(
t.city_id,
v_date,
0,
10004,
10,
t.OnecarrierBtsNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.city_id,count(distinct a.related_bts) TwocarrierBtsNum
from
(select related_bts from
c_carrier where car_type='DO' and vendor_id=10
group by city_id,related_bts having count(distinct car_type)=2 ) a,c_cell b
where a.related_bts=b.related_bts and b.city_id is not null and b.vendor_id=10
group by b.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
TwocarrierBtsNum = t.TwocarrierBtsNum
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TwocarrierBtsNum)
values(
t.city_id,
v_date,
0,
10004,
10,
t.TwocarrierBtsNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.city_id,count(distinct a.related_bts) ThreecarrierBtsNum
from
(select related_bts from
c_carrier where car_type='DO' and vendor_id=10
group by city_id,related_bts having count(distinct car_type)=3 ) a,c_cell b
where a.related_bts=b.related_bts and b.city_id is not null and b.vendor_id=10
group by b.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
ThreecarrierBtsNum = t.ThreecarrierBtsNum
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
ThreecarrierBtsNum)
values(
t.city_id,
v_date,
0,
10004,
10,
t.ThreecarrierBtsNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.city_id,count(distinct a.related_bts) FourcarrierBtsNum
from
(select related_bts from
c_carrier where car_type='DO' and vendor_id=10
group by city_id,related_bts having count(distinct car_type)=4 ) a,c_cell b
where a.related_bts=b.related_bts and b.city_id is not null and b.vendor_id=10
group by b.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
FourcarrierBtsNum = t.FourcarrierBtsNum
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
FourcarrierBtsNum)
values(
t.city_id,
v_date,
0,
10004,
10,
t.FourcarrierBtsNum);
commit;

--update-8-26
merge into c_perf_do_sum c_perf
using(
--select
--update-8-26
--c.city_id city_id,
--sum(nvl(a.Hdr243,0)+nvl(b.SAMPLES_IN_PEGGING_INTER_OHM,0)) CE_Traffic
--from c_tpd_carr_do_ag_lc a,c_tpd_ohm_do_ag_lc b,c_carrier c
--where a.int_id = b.int_id and  a.int_id=c.int_id
--and a.scan_start_time = v_date
--group by c.city_id
with a as (select c.city_id city_id,
sum(nvl(a.Hdr243,0)) Hdr243
from c_tpd_carr_do_ag_lc a,c_carrier c
where a.int_id=c.int_id
and c.vendor_id=10
and a.scan_start_time=v_date
and c.city_id is not null
group by c.city_id),
 b as (select c.city_id city_id,
sum(nvl(a.SAMPLES_IN_PEGGING_INTER_OHM,0)) SAMPLES_IN_PEGGING_INTER_OHM
from c_tpd_ohm_do_ag_lc a,c_bsc c
where a.unique_rdn=c.object_rdn
and c.vendor_id=10
and a.scan_start_time=v_date
group by c.city_id)
select
a.city_id city_id,
--update-2011-9-19
--nvl(a.Hdr243,0)/decode(b.SAMPLES_IN_PEGGING_INTER_OHM,0,1,null,1,b.SAMPLES_IN_PEGGING_INTER_OHM) CE_Traffic
nvl(a.Hdr243,0)+b.SAMPLES_IN_PEGGING_INTER_OHM CE_Traffic
from  a
left join b  on
 a.city_id = b.city_id
) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
CE_Traffic = t.CE_Traffic
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CE_Traffic)
values(
t.city_id,
v_date,
0,
10004,
10,
t.CE_Traffic);
commit;
--end

--add-2011-9-1
--add-BusyerBtsNum-FreeBtsNum
merge into c_perf_do_sum c_perf
using(
with tmp as (
select
c.city_id city_id,
case when
((d.EVMTOTALBUSYSLOTSBE+d.EVMTOTALBUSYSLOTSEF)/decode(d.TIMESLOTSINPEGGINGINTERVAL,null,0,1)) >=0.7 and (d.EVMACTIVEUSAGE*0.001667/3600)>=4 then 1 else 0 end BusyerBtsNum1,
case when
((d.EVMTOTALBUSYSLOTSBE+d.EVMTOTALBUSYSLOTSEF)/decode(d.TIMESLOTSINPEGGINGINTERVAL,null,0,1))<=0.5 and (d.EVMACTIVEUSAGE*0.001667/3600)<=1 then 1 else 0 end FreeBtsNum1
from c_tpd_carr_do_lc d,c_carrier c
where d.int_id=c.int_id and d.scan_start_time=v_date
and c.city_id is not null)
select
tmp.city_id city_id,
case when sum(BusyerBtsNum1)>=1 then 1 else 0 end BusyerBtsNum,
case when sum(FreeBtsNum1) <=1 then 1 else 0 end FreeBtsNum
from tmp
group by tmp.city_id)t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
BusyerBtsNum = t.BusyerBtsNum,
FreeBtsNum   = t.FreeBtsNum
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
BusyerBtsNum,
FreeBtsNum)
values(
t.city_id,
v_date,
0,
10004,
10,
t.BusyerBtsNum,
t.FreeBtsNum);
commit;


--------------------------add by lv----------------
merge into c_perf_do_sum c_perf
using(
with a as(
select
c.city_id city_id,
sum(a.EVMAVGDRCPOINTEDUSERS*0.001*3600*(nvl(b.Hdr293,0)+nvl(b.Hdr292,0))) ConnectUseTotalDuration,
sum(nvl(b.Hdr293,0)+nvl(b.Hdr292,0))  ConnectSetupTotalDuration_1
from c_tpd_carr_do_lc a,c_tpd_carr_do_ag_lc b ,c_carrier c
where a.int_id=c.int_id and b.int_id=c.int_id and c.vendor_id=10
and a.scan_start_time=b.scan_start_time and a.scan_start_time=v_date
group by c.city_id)
select
a.city_id city_id,
b.ConnectSetupTotalDuration/decode(a.ConnectSetupTotalDuration_1,null,1,0,1,a.ConnectSetupTotalDuration_1) ConnectAvgSetupDuration,
a.ConnectUseTotalDuration ConnectUseTotalDuration,
a.ConnectUseTotalDuration/decode((nvl(b.AT_ConnectSuccNum,0)+nvl(b.AN_ConnectSuccNum,0)),null,1,0,1,(nvl(b.AT_ConnectSuccNum,0)+nvl(b.AN_ConnectSuccNum,0))) ConnectAvgUseDuration,
round(100*(nvl(b.AT_DAAcitveSuccNum,0)+nvl(b.AN_DAAcitveSuccNum,0))/decode((nvl(b.AT_DAAcitveReqNum,0)+nvl(b.AN_DAAcitveReqNum,0)),null,1,0,1,(nvl(b.AT_DAAcitveReqNum,0)+nvl(b.AN_DAAcitveReqNum,0))),4)  User_DAAcitveSuccRate,
------2010-08-19---------------
--update-2011-9-18
--round(100*b.FwdMaxBusyNum_MacIndex/decode(b.FwdAvailNum_MacIndex,null,1,0,1,b.FwdAvailNum_MacIndex) FwdMaxUseRate_MacIndex,
round(100*b.FwdMaxBusyNum_MacIndex/115,4) FwdMaxUseRate_MacIndex,
round(100*b.AbisAvgUseBandWidth/decode(b.AbisPortBandWidth,null,1,0,1,b.AbisPortBandWidth),4)  ABisBWAvgUseRate,
round(100*b.WireConnectSuccNumInA8A10/decode(b.WireConnectReqNumInA8A10,null,1,0,1,b.WireConnectReqNumInA8A10),4) WireConnectSuccRateInA8A10,
round(100*b.UserEarlyReleaseNum/decode((nvl(b.AT_ConnectReqNum,0)+nvl(b.AN_ConnectReqNum,0)),null,1,0,1,(nvl(b.AT_ConnectReqNum,0)+nvl(b.AN_ConnectReqNum,0))),4) UserEarlyReleaseRate,
(nvl(b.WireConnectReleaseNumInPDSN,0)-nvl(b.ReleaseNumByPDSN,0)) WireConnectReleaseNumExPDSN,
round(100*(nvl(b.ReleaseNumByPDSN,0)+nvl(b.WireRadioFNum1,0)+nvl(b.WireRadioFNum2,0)+nvl(b.WireRadioFNum3,0))/
decode((nvl(b.WireConnectReleaseNumInPDSN,0)+nvl(b.WireRadioFNum1,0)+nvl(b.WireRadioFNum2,0)+nvl(b.WireRadioFNum3,0)),null,1,0,1,(nvl(b.WireConnectReleaseNumInPDSN,0)+nvl(b.WireRadioFNum1,0)+nvl(b.WireRadioFNum2,0)+nvl(b.WireRadioFNum3,0))),4) NetWorkRadioFRate,
round(b.DRCApplyNum_FwdSpeed1/decode((nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0)),null,1,0,1,(nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0))),4) DRCApplyRate_FwdSpeed1,
round(b.DRCApplyNum_FwdSpeed2/decode((nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0)),null,1,0,1,(nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0))),4) DRCApplyRate_FwdSpeed2,
round(b.DRCApplyNum_FwdSpeed3/decode((nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0)),null,1,0,1,(nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0))),4) DRCApplyRate_FwdSpeed3,
round(100*b.SessionAuthenticationSNum/decode(b.SessionAuthenticationReqNum,null,1,0,1,b.SessionAuthenticationReqNum),4) SessionAuthenticationSRate,
round(100*b.A13_HandoffSNum/decode(b.A13_HandoffNum,null,1,0,1,b.A13_HandoffNum),4) A13_HandoffSRate,
(nvl(b.SessionNum_Active,0)+nvl(b.SessionNum_NotActive,0)) SessionNum,
(nvl(b.AT_DAAcitveReqNum,0)+nvl(b.AN_DAAcitveReqNum,0)) User_DAAcitveReqNum,
(nvl(b.AT_DAAcitveSuccNum,0)+nvl(b.AN_DAAcitveSuccNum,0)) User_DAAcitveSuccNum,
round(100*b.AT_DAAcitveSuccNum/decode(b.AT_DAAcitveReqNum,null,1,0,1,b.AT_DAAcitveReqNum),4) AT_DAAcitveSuccRate,
round(100*b.AN_DAAcitveSuccNum/decode(b.AN_DAAcitveReqNum,null,1,0,1,b.AN_DAAcitveReqNum),4)  AN_DAAcitveSuccRate,
(nvl(b.Ce_Traffic,0)-nvl(b.Call_Traffic,0)) Sho_Traffic,
b.Sho_Traffic/decode(b.Call_Traffic,null,1,0,1,b.Call_Traffic) Sho_Factor,
round(b.RevPSDiscardNum/decode(b.PCFRevPSMsg,null,1,0,1,b.PCFRevPSMsg),4) RevPSDiscardRate,
round(b.FwdPSDiscardNum/decode(b.PCFFwdPSMsg,null,1,0,1,b.PCFFwdPSMsg),4) FwdPSDiscardRate,
round(100*b.RABBusyNum/decode((nvl(b.RABBusyNum,0)+nvl(b.RABFreeNum,0)),null,1,0,1,(nvl(b.RABBusyNum,0)+nvl(b.RABFreeNum,0))),4) RevCircuitBusyRate,
round(100*b.SHoSuccNum_intraAN/decode(b.SHoReqNum_intraAN,null,1,0,1,b.SHoReqNum_intraAN),4) SHoSuccRate_intraAN,
round(b.SHoSuccNum_amongAN/decode(b.SHoReqNum_amongAN,null,1,0,1,b.SHoReqNum_amongAN),4) SHoSuccRate_amongAN,
round(100*b.HardHoSuccNum_intraAN/decode(b.HardHoReqNum_intraAN,null,1,0,1,b.HardHoReqNum_intraAN),4)  HardHoSuccRate_intraAN,
round(b.HardHoSuccNum_amongAN/decode(b.HardHoReqNum_amongAN,null,1,0,1,b.HardHoReqNum_amongAN),4)  HardHoSuccRate_amongAN,
round(100*b.PageResponceNum/decode(b.PageReqNum,null,1,0,1,b.PageReqNum),4)  PageResponceRate
-------------------------------
from a,c_perf_do_sum b
where a.city_id=b.int_id and b.scan_start_time = v_date and b.ne_type=10004 and b.sum_level=0 and b.vendor_id=10
)t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
ConnectUseTotalDuration = t.ConnectUseTotalDuration,
ConnectAvgUseDuration   = t.ConnectAvgUseDuration,
User_DAAcitveSuccRate   = t.User_DAAcitveSuccRate,
------2010-08-19-------------
ConnectAvgSetupDuration    =t.ConnectAvgSetupDuration     ,
FwdMaxUseRate_MacIndex     =t.FwdMaxUseRate_MacIndex      ,
ABisBWAvgUseRate           =t.ABisBWAvgUseRate            ,
WireConnectSuccRateInA8A10 =t.WireConnectSuccRateInA8A10  ,
UserEarlyReleaseRate       =t.UserEarlyReleaseRate        ,
WireConnectReleaseNumExPDSN=t.WireConnectReleaseNumExPDSN ,
NetWorkRadioFRate          =t.NetWorkRadioFRate           ,
DRCApplyRate_FwdSpeed1     =t.DRCApplyRate_FwdSpeed1      ,
DRCApplyRate_FwdSpeed2     =t.DRCApplyRate_FwdSpeed2      ,
DRCApplyRate_FwdSpeed3     =t.DRCApplyRate_FwdSpeed3      ,
SessionAuthenticationSRate =t.SessionAuthenticationSRate  ,
A13_HandoffSRate           =t.A13_HandoffSRate            ,
SessionNum                 =t.SessionNum                  ,
User_DAAcitveReqNum        =t.User_DAAcitveReqNum         ,
User_DAAcitveSuccNum       =t.User_DAAcitveSuccNum        ,
AT_DAAcitveSuccRate        =t.AT_DAAcitveSuccRate         ,
AN_DAAcitveSuccRate        =t.AN_DAAcitveSuccRate         ,
Sho_Traffic                 =t.Sho_Traffic                  ,
Sho_Factor                 =t.Sho_Factor                  ,
RevPSDiscardRate           =t.RevPSDiscardRate            ,
FwdPSDiscardRate           =t.FwdPSDiscardRate            ,
RevCircuitBusyRate         =t.RevCircuitBusyRate          ,
SHoSuccRate_intraAN        =t.SHoSuccRate_intraAN         ,
SHoSuccRate_amongAN        =t.SHoSuccRate_amongAN         ,
HardHoSuccRate_intraAN     =t.HardHoSuccRate_intraAN      ,
HardHoSuccRate_amongAN     =t.HardHoSuccRate_amongAN      ,
PageResponceRate           =t.PageResponceRate
-----------------------------
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
ConnectUseTotalDuration,
ConnectAvgUseDuration,
User_DAAcitveSuccRate,
----------2010-08-19---------
ConnectAvgSetupDuration,
FwdMaxUseRate_MacIndex,
ABisBWAvgUseRate,
WireConnectSuccRateInA8A10,
UserEarlyReleaseRate,
WireConnectReleaseNumExPDSN,
NetWorkRadioFRate,
DRCApplyRate_FwdSpeed1,
DRCApplyRate_FwdSpeed2,
DRCApplyRate_FwdSpeed3,
SessionAuthenticationSRate,
A13_HandoffSRate,
SessionNum,
User_DAAcitveReqNum,
User_DAAcitveSuccNum,
AT_DAAcitveSuccRate,
AN_DAAcitveSuccRate,
Sho_Traffic,
Sho_Factor,
RevPSDiscardRate,
FwdPSDiscardRate,
RevCircuitBusyRate,
SHoSuccRate_intraAN,
SHoSuccRate_amongAN,
HardHoSuccRate_intraAN,
HardHoSuccRate_amongAN,
PageResponceRate
)
values(
t.city_id,
v_date,
0,
10004,
10,
t.ConnectUseTotalDuration,
t.ConnectAvgUseDuration,
t.User_DAAcitveSuccRate,
-------2010-08-19------------
t.ConnectAvgSetupDuration,
t.FwdMaxUseRate_MacIndex,
t.ABisBWAvgUseRate,
t.WireConnectSuccRateInA8A10,
t.UserEarlyReleaseRate,
t.WireConnectReleaseNumExPDSN,
t.NetWorkRadioFRate,
t.DRCApplyRate_FwdSpeed1,
t.DRCApplyRate_FwdSpeed2,
t.DRCApplyRate_FwdSpeed3,
t.SessionAuthenticationSRate,
t.A13_HandoffSRate,
t.SessionNum,
t.User_DAAcitveReqNum,
t.User_DAAcitveSuccNum,
t.AT_DAAcitveSuccRate,
t.AN_DAAcitveSuccRate,
t.Sho_Traffic,
t.Sho_Factor,
t.RevPSDiscardRate,
t.FwdPSDiscardRate,
t.RevCircuitBusyRate,
t.SHoSuccRate_intraAN,
t.SHoSuccRate_amongAN,
t.HardHoSuccRate_intraAN,
t.HardHoSuccRate_amongAN,
t.PageResponceRate
-----------------------------
);
commit;


-----------update---------------------
update c_perf_do_sum perf
set
(
BtsTotalNum  ,
OnecarrierBtsNum  ,
TwocarrierBtsNum  ,
threecarrierBtsNum  ,
FourcarrierBtsNum  ,
CarrierCellNum  ,
RevCEMaxUseRate  ,
RevCEMaxBusyNum  ,
RevCEAvailNum  ,
PCFNum  ,
PCFMaxHRPDSessionNum  ,
PCFMaxActiveHRPDSessionNum  ,
BusyerBtsNum  ,
FreeBtsNum  ,
AT_ConnectReqNum  ,
AN_ConnectReqNum  ,
AT_ConnectSuccNum  ,
AN_ConnectSuccNum  ,
UserEarlyReleaseNum  ,
WireConnectFailNum1  ,
WireConnectFailNum2  ,
WireConnectFailNum3  ,
WireConnectReleaseNumInPDSN  ,
WireConnectReleaseNumExPDSN  ,
ReleaseNumByPDSN  ,
WireRadioFNum1  ,
WireRadioFNum2  ,
WireRadioFNum3  ,
WireRadioFRate  ,
NetWorkRadioFRate  ,
ConnectAvgSetupDuration  ,
ConnectAvgUseDuration  ,
DRCApplyRate_FwdSpeed1  ,
DRCApplyRate_FwdSpeed2  ,
DRCApplyRate_FwdSpeed3  ,
UATI_AssgnSuccRate  ,
UATI_AssgnReqNum  ,
UATI_AssgnSuccNum  ,
UATI_AssgnFailNum  ,
UATI_AvgSetupDuration  ,
SessionAuthenticationSRate  ,
SessionAuthenticationSNum  ,
SessionAuthenticationReqNum  ,
SessionAuthenticationRejNum  ,
SessionAuthenticationFNum  ,
SessionNegoSRate  ,
SessionNegoSNum  ,
SessionNegoFNum  ,
A13_HandoffSRate  ,
A13_HandoffNum  ,
A13_HandoffSNum  ,
SessionNum  ,
SessionNum_Active  ,
SessionNum_NotActive  ,
User_DAAcitveSuccRate  ,
User_DAAcitveReqNum  ,
User_DAAcitveSuccNum  ,
AT_DAAcitveSuccRate  ,
AT_DAAcitveReqNum  ,
AT_DAAcitveSuccNum  ,
AT_DAAcitveFailNum  ,
AN_DAAcitveSuccRate  ,
AN_DAAcitveReqNum  ,
AN_DAAcitveSuccNum  ,
AN_DAAcitveFailNum  ,
EqlUserNum  ,
Call_Traffic  ,
CE_Traffic  ,
Sho_Traffic  ,
Sho_Factor  ,
PCFRevDataSize  ,
PCFFwdDataSize  ,
PCFRevPSMsg  ,
PCFFwdPSMsg  ,
RevPSDiscardNum  ,
FwdPSDiscardNum  ,
GlobalSHoReqNum  ,
GlobalSHoSuccNum  ,
PageReqNum  ,
PageResponceNum  ,
DOCarrier37  ,
DOCarrier78  ,
DOCarrier119  ,
DOCarrierTotalNum  ,
DOCarrier37Traffic  ,
DOCarrier78Traffic  ,
DOCarrier119Traffic  ,
OneDOCarrierCellNum  ,
TwoDOCarrierCellNum  ,
ThreeDOCarrierCellNum  ,
DOCellNum  ,
ConnectSetupTotalDuration  ,
ConnectUseTotalDuration  ,
SessionSetupTotalDuration  ,
FwdRxSize  ,
FwdTxSize  ,
RevRxSize  ,
RevTxSize  ,
RABBusyNum  ,
RABFreeNum  ,
FwdAvailNum_MacIndex  ,
DRCApplyNum_FwdSpeed1  ,
DRCApplyNum_FwdSpeed2  ,
DRCApplyNum_FwdSpeed3  ,
FwdTCHPhyTxBitNum  ,
FwdPhyUseTimeSlotDuration  ,
RevTCHPhyTxBitNum  ,
RevPhyUseTimeSlotDuration
)=
(
select
decode(  BtsTotalNum  ,null,0,  BtsTotalNum  ),
decode(  OnecarrierBtsNum  ,null,0,  OnecarrierBtsNum  ),
decode(  TwocarrierBtsNum  ,null,0,  TwocarrierBtsNum  ),
decode(  threecarrierBtsNum  ,null,0,  threecarrierBtsNum  ),
decode(  FourcarrierBtsNum  ,null,0,  FourcarrierBtsNum  ),
decode(  CarrierCellNum  ,null,0,  CarrierCellNum  ),
decode(  RevCEMaxUseRate  ,null,0,  RevCEMaxUseRate  ),
decode(  RevCEMaxBusyNum  ,null,0,  RevCEMaxBusyNum  ),
decode(  RevCEAvailNum  ,null,0,  RevCEAvailNum  ),
decode(  PCFNum  ,null,0,  PCFNum  ),
decode(  PCFMaxHRPDSessionNum  ,null,0,  PCFMaxHRPDSessionNum  ),
decode(  PCFMaxActiveHRPDSessionNum  ,null,0,  PCFMaxActiveHRPDSessionNum  ),
decode(  BusyerBtsNum  ,null,0,  BusyerBtsNum  ),
decode(  FreeBtsNum  ,null,0,  FreeBtsNum  ),
decode(  AT_ConnectReqNum  ,null,0,  AT_ConnectReqNum  ),
decode(  AN_ConnectReqNum  ,null,0,  AN_ConnectReqNum  ),
decode(  AT_ConnectSuccNum  ,null,0,  AT_ConnectSuccNum  ),
decode(  AN_ConnectSuccNum  ,null,0,  AN_ConnectSuccNum  ),
decode(  UserEarlyReleaseNum  ,null,0,  UserEarlyReleaseNum  ),
decode(  WireConnectFailNum1  ,null,0,  WireConnectFailNum1  ),
decode(  WireConnectFailNum2  ,null,0,  WireConnectFailNum2  ),
decode(  WireConnectFailNum3  ,null,0,  WireConnectFailNum3  ),
decode(  WireConnectReleaseNumInPDSN  ,null,0,  WireConnectReleaseNumInPDSN  ),
decode(  WireConnectReleaseNumExPDSN  ,null,0,  WireConnectReleaseNumExPDSN  ),
decode(  ReleaseNumByPDSN  ,null,0,  ReleaseNumByPDSN  ),
decode(  WireRadioFNum1  ,null,0,  WireRadioFNum1  ),
decode(  WireRadioFNum2  ,null,0,  WireRadioFNum2  ),
decode(  WireRadioFNum3  ,null,0,  WireRadioFNum3  ),
decode(  WireRadioFRate  ,null,0,  WireRadioFRate  ),
decode(  NetWorkRadioFRate  ,null,0,  NetWorkRadioFRate  ),
decode(  ConnectAvgSetupDuration  ,null,0,  ConnectAvgSetupDuration  ),
decode(  ConnectAvgUseDuration  ,null,0,  ConnectAvgUseDuration  ),
decode(  DRCApplyRate_FwdSpeed1  ,null,0,  DRCApplyRate_FwdSpeed1  ),
decode(  DRCApplyRate_FwdSpeed2  ,null,0,  DRCApplyRate_FwdSpeed2  ),
decode(  DRCApplyRate_FwdSpeed3  ,null,0,  DRCApplyRate_FwdSpeed3  ),
decode(  UATI_AssgnSuccRate  ,null,0,  UATI_AssgnSuccRate  ),
decode(  UATI_AssgnReqNum  ,null,0,  UATI_AssgnReqNum  ),
decode(  UATI_AssgnSuccNum  ,null,0,  UATI_AssgnSuccNum  ),
decode(  UATI_AssgnFailNum  ,null,0,  UATI_AssgnFailNum  ),
decode(  UATI_AvgSetupDuration  ,null,0,  UATI_AvgSetupDuration  ),
decode(  SessionAuthenticationSRate  ,null,0,  SessionAuthenticationSRate  ),
decode(  SessionAuthenticationSNum  ,null,0,  SessionAuthenticationSNum  ),
decode(  SessionAuthenticationReqNum  ,null,0,  SessionAuthenticationReqNum  ),
decode(  SessionAuthenticationRejNum  ,null,0,  SessionAuthenticationRejNum  ),
decode(  SessionAuthenticationFNum  ,null,0,  SessionAuthenticationFNum  ),
decode(  SessionNegoSRate  ,null,0,  SessionNegoSRate  ),
decode(  SessionNegoSNum  ,null,0,  SessionNegoSNum  ),
decode(  SessionNegoFNum  ,null,0,  SessionNegoFNum  ),
decode(  A13_HandoffSRate  ,null,0,  A13_HandoffSRate  ),
decode(  A13_HandoffNum  ,null,0,  A13_HandoffNum  ),
decode(  A13_HandoffSNum  ,null,0,  A13_HandoffSNum  ),
decode(  SessionNum  ,null,0,  SessionNum  ),
decode(  SessionNum_Active  ,null,0,  SessionNum_Active  ),
decode(  SessionNum_NotActive  ,null,0,  SessionNum_NotActive  ),
decode(  User_DAAcitveSuccRate  ,null,0,  User_DAAcitveSuccRate  ),
decode(  User_DAAcitveReqNum  ,null,0,  User_DAAcitveReqNum  ),
decode(  User_DAAcitveSuccNum  ,null,0,  User_DAAcitveSuccNum  ),
decode(  AT_DAAcitveSuccRate  ,null,0,  AT_DAAcitveSuccRate  ),
decode(  AT_DAAcitveReqNum  ,null,0,  AT_DAAcitveReqNum  ),
decode(  AT_DAAcitveSuccNum  ,null,0,  AT_DAAcitveSuccNum  ),
decode(  AT_DAAcitveFailNum  ,null,0,  AT_DAAcitveFailNum  ),
decode(  AN_DAAcitveSuccRate  ,null,0,  AN_DAAcitveSuccRate  ),
decode(  AN_DAAcitveReqNum  ,null,0,  AN_DAAcitveReqNum  ),
decode(  AN_DAAcitveSuccNum  ,null,0,  AN_DAAcitveSuccNum  ),
decode(  AN_DAAcitveFailNum  ,null,0,  AN_DAAcitveFailNum  ),
decode(  EqlUserNum  ,null,0,  EqlUserNum  ),
decode(  Call_Traffic  ,null,0,  Call_Traffic  ),
decode(  CE_Traffic  ,null,0,  CE_Traffic  ),
decode(  Sho_Traffic  ,null,0,  Sho_Traffic  ),
decode(  Sho_Factor  ,null,0,  Sho_Factor  ),
decode(  PCFRevDataSize  ,null,0,  PCFRevDataSize  ),
decode(  PCFFwdDataSize  ,null,0,  PCFFwdDataSize  ),
decode(  PCFRevPSMsg  ,null,0,  PCFRevPSMsg  ),
decode(  PCFFwdPSMsg  ,null,0,  PCFFwdPSMsg  ),
decode(  RevPSDiscardNum  ,null,0,  RevPSDiscardNum  ),
decode(  FwdPSDiscardNum  ,null,0,  FwdPSDiscardNum  ),
decode(  GlobalSHoReqNum  ,null,0,  GlobalSHoReqNum  ),
decode(  GlobalSHoSuccNum  ,null,0,  GlobalSHoSuccNum  ),
decode(  PageReqNum  ,null,0,  PageReqNum  ),
decode(  PageResponceNum  ,null,0,  PageResponceNum  ),
decode(  DOCarrier37  ,null,0,  DOCarrier37  ),
decode(  DOCarrier78  ,null,0,  DOCarrier78  ),
decode(  DOCarrier119  ,null,0,  DOCarrier119  ),
decode(  DOCarrierTotalNum  ,null,0,  DOCarrierTotalNum  ),
decode(  DOCarrier37Traffic  ,null,0,  DOCarrier37Traffic  ),
decode(  DOCarrier78Traffic  ,null,0,  DOCarrier78Traffic  ),
decode(  DOCarrier119Traffic  ,null,0,  DOCarrier119Traffic  ),
decode(  OneDOCarrierCellNum  ,null,0,  OneDOCarrierCellNum  ),
decode(  TwoDOCarrierCellNum  ,null,0,  TwoDOCarrierCellNum  ),
decode(  ThreeDOCarrierCellNum  ,null,0,  ThreeDOCarrierCellNum  ),
decode(  DOCellNum  ,null,0,  DOCellNum  ),
decode(  ConnectSetupTotalDuration  ,null,0,  ConnectSetupTotalDuration  ),
decode(  ConnectUseTotalDuration  ,null,0,  ConnectUseTotalDuration  ),
decode(  SessionSetupTotalDuration  ,null,0,  SessionSetupTotalDuration  ),
decode(  FwdRxSize  ,null,0,  FwdRxSize  ),
decode(  FwdTxSize  ,null,0,  FwdTxSize  ),
decode(  RevRxSize  ,null,0,  RevRxSize  ),
decode(  RevTxSize  ,null,0,  RevTxSize  ),
decode(  RABBusyNum  ,null,0,  RABBusyNum  ),
decode(  RABFreeNum  ,null,0,  RABFreeNum  ),
decode(  FwdAvailNum_MacIndex  ,null,0,  FwdAvailNum_MacIndex  ),
decode(  DRCApplyNum_FwdSpeed1  ,null,0,  DRCApplyNum_FwdSpeed1  ),
decode(  DRCApplyNum_FwdSpeed2  ,null,0,  DRCApplyNum_FwdSpeed2  ),
decode(  DRCApplyNum_FwdSpeed3  ,null,0,  DRCApplyNum_FwdSpeed3  ),
decode(  FwdTCHPhyTxBitNum  ,null,0,  FwdTCHPhyTxBitNum  ),
decode(  FwdPhyUseTimeSlotDuration  ,null,0,  FwdPhyUseTimeSlotDuration  ),
decode(  RevTCHPhyTxBitNum  ,null,0,  RevTCHPhyTxBitNum  ),
decode(  RevPhyUseTimeSlotDuration  ,null,0,  RevPhyUseTimeSlotDuration  )
from c_perf_do_sum where scan_start_time= v_date and sum_level=0 and ne_type=10004 and vendor_id=10
and int_id=perf.int_id
)
where scan_start_time= v_date and sum_level=0 and ne_type=10004 and vendor_id=10 ;
commit;
---------------------------




----------------------------------------end of 直接到city---------------------------------------------------



--ne_type=10000(province) time_level=hour
merge into c_perf_do_sum c_perf
using(
select
c.province_id province_id,
sum(BtsTotalNum)    BtsTotalNum,
sum(OnecarrierBtsNum)    OnecarrierBtsNum,
sum(TwocarrierBtsNum)    TwocarrierBtsNum,
sum(threecarrierBtsNum)    threecarrierBtsNum,
sum(FourcarrierBtsNum)    FourcarrierBtsNum,
sum(CarrierCellNum)    CarrierCellNum,

--update-2011-10-12
--sum(RevCEMaxUseRate)/count(city_id)     RevCEMaxUseRate,
round(100*sum(nvl(RevCEMaxBusyNum,0))/decode(sum(nvl(RevCEAvailNum,0)),0,1,sum(nvl(RevCEAvailNum,0))),4)  RevCEMaxUseRate,

sum(RevCEMaxBusyNum)    RevCEMaxBusyNum,
sum(RevCEAvailNum)    RevCEAvailNum,
round(max(FwdMaxUseRate_MacIndex),4)    FwdMaxUseRate_MacIndex,
--update-2011-9-18
--sum(FwdMaxBusyNum_MacIndex) FwdMaxBusyNum_MacIndex,
max(FwdMaxBusyNum_MacIndex) FwdMaxBusyNum_MacIndex,
sum(PCFNum)                    PCFNum,
--update-2011-9-18
--sum(PCFMeanCpuAvgLoad)    PCFMeanCpuAvgLoad,
avg(PCFMeanCpuAvgLoad)    PCFMeanCpuAvgLoad,
sum(PCFMaxHRPDSessionNum)    PCFMaxHRPDSessionNum,
sum(PCFMaxActiveHRPDSessionNum)    PCFMaxActiveHRPDSessionNum    ,

--update-2011-10-12        无算法
round(sum(PCFUplinkThroughputRate)/count(city_id),4)     PCFUplinkThroughputRate,

--update-2011-10-12        无算法
round(sum(PCFDownlinkThroughputRate)/count(city_id),4)     PCFDownlinkThroughputRate,


--update-2011-10-12
---sum(ABisBWAvgUseRate)/count(city_id)     ABisBWAvgUseRate,
round(sum(nvl(AbisPortBandWidth,0))/decode(sum(nvl(AbisAvgUseBandWidth,0)),0,1,sum(nvl(AbisAvgUseBandWidth,0))),4)  ABisBWAvgUseRate,

sum(AbisPortBandWidth)    AbisPortBandWidth,
sum(AbisAvgUseBandWidth)    AbisAvgUseBandWidth,
sum(BusyerBtsNum)    BusyerBtsNum,
sum(FreeBtsNum)    FreeBtsNum,
round(100*sum(AT_ConnectSuccNum+AN_ConnectSuccNum)/
decode(sum(AT_ConnectReqNum+AN_ConnectReqNum),0,1,null,1,sum(AT_ConnectReqNum+AN_ConnectReqNum)),4) WireConnectSuccRate,

--update-2011-10-12
--sum(AT_ConnectSuccRate)/count(city_id)     AT_ConnectSuccRate,
round(100*sum(nvl(AT_ConnectSuccNum,0))/decode(sum(nvl(AT_ConnectReqNum,0)),0,1,sum(nvl(AT_ConnectReqNum,0))),4)  AT_ConnectSuccRate,

--update-2011-10-12
--sum(AN_ConnectSuccRate)/count(city_id)     AN_ConnectSuccRate,
round(100*sum(nvl(AN_ConnectSuccNum,0))/decode(sum(nvl(AN_ConnectReqNum,0)),0,1,sum(nvl(AN_ConnectReqNum,0))),4)  AN_ConnectSuccRate,

sum(AT_ConnectReqNum)    AT_ConnectReqNum,
sum(AN_ConnectReqNum)    AN_ConnectReqNum,
sum(AT_ConnectSuccNum)    AT_ConnectSuccNum,
sum(AN_ConnectSuccNum)    AN_ConnectSuccNum,
round(sum(WireConnectSuccRateInA8A10),4)    WireConnectSuccRateInA8A10,
sum(WireConnectSuccNumInA8A10)    WireConnectSuccNumInA8A10,
sum(WireConnectReqNumInA8A10)    WireConnectReqNumInA8A10,

--update-2011-10-12
--sum(UserEarlyReleaseRate)/count(city_id)     UserEarlyReleaseRate,
round(sum(nvl(UserEarlyReleaseNum,0))/decode(sum(nvl(AT_ConnectReqNum,0)+nvl(AN_ConnectReqNum,0)),0,1,sum(nvl(AT_ConnectReqNum,0)+nvl(AN_ConnectReqNum,0))),4)  UserEarlyReleaseRate,

sum(UserEarlyReleaseNum)    UserEarlyReleaseNum,
sum(WireConnectFailNum1)    WireConnectFailNum1,
sum(WireConnectFailNum2)    WireConnectFailNum2,
sum(WireConnectFailNum3)    WireConnectFailNum3,
sum(WireConnectReleaseNumInPDSN)    WireConnectReleaseNumInPDSN,
sum(WireConnectReleaseNumExPDSN)    WireConnectReleaseNumExPDSN,
sum(ReleaseNumByPDSN)    ReleaseNumByPDSN,
sum(WireRadioFNum1)    WireRadioFNum1,
sum(WireRadioFNum2)    WireRadioFNum2,
sum(WireRadioFNum3)    WireRadioFNum3,
--update by zhengting
round(100*sum(WireRadioFNum1+WireRadioFNum2+WireRadioFNum3)/
decode(sum(WireConnectReleaseNumInPDSN
+WireRadioFNum1
+WireRadioFNum2
+WireRadioFNum3),0,1,null,1,sum(WireConnectReleaseNumInPDSN
+WireRadioFNum1
+WireRadioFNum2
+WireRadioFNum3)),4) WireRadioFRate,

--update-2011-10-12
--sum(NetWorkRadioFRate)/count(city_id)     NetWorkRadioFRate,
round(100*sum(nvl(ReleaseNumByPDSN,0)+nvl(WireRadioFNum1,0)+nvl(WireRadioFNum2,0)+nvl(WireRadioFNum3,0))/
decode(sum(nvl(WireConnectReleaseNumExPDSN,0)+nvl(WireRadioFNum1,0)+nvl(WireRadioFNum2,0)+nvl(WireRadioFNum3,0)),0,1,
sum(nvl(WireConnectReleaseNumExPDSN,0)+nvl(WireRadioFNum1,0)+nvl(WireRadioFNum2,0)+nvl(WireRadioFNum3,0))),4)   NetWorkRadioFRate,

sum(ConnectAvgSetupDuration)    ConnectAvgSetupDuration,
avg(ConnectAvgUseDuration)    ConnectAvgUseDuration,
round(sum(DRCApplyRate_FwdSpeed1),4)    DRCApplyRate_FwdSpeed1,
round(sum(DRCApplyRate_FwdSpeed2),4)    DRCApplyRate_FwdSpeed2,
round(sum(DRCApplyRate_FwdSpeed3),4)    DRCApplyRate_FwdSpeed3,
round(100*sum(UATI_AssgnSuccNum)/decode(sum(UATI_AssgnReqNum),0,1,null,1,sum(UATI_AssgnReqNum)),4) UATI_AssgnSuccRate,
sum(UATI_AssgnReqNum)                    UATI_AssgnReqNum,
sum(UATI_AssgnSuccNum)                    UATI_AssgnSuccNum,
sum(UATI_AssgnFailNum)                    UATI_AssgnFailNum,
sum(UATI_AvgSetupDuration)                    UATI_AvgSetupDuration,

--update-2011-10-12
--sum(SessionAuthenticationSRate)/count(city_id)     SessionAuthenticationSRate,
round(100*sum(nvl(SessionAuthenticationSNum,0))/decode(sum(nvl(SessionAuthenticationReqNum,0)),0,1,sum(nvl(SessionAuthenticationReqNum,0))),4)  SessionAuthenticationSRate,

sum(SessionAuthenticationSNum)                    SessionAuthenticationSNum,
sum(SessionAuthenticationReqNum)                    SessionAuthenticationReqNum,
sum(SessionAuthenticationRejNum)                    SessionAuthenticationRejNum,
sum(SessionAuthenticationFNum)                    SessionAuthenticationFNum,

--update-2011-10-12
--sum(SessionNegoSRate)/count(city_id)     SessionNegoSRate,
round(100*sum(nvl(SessionNegoSNum,0))/decode(sum(nvl(SessionNegoSNum,0)+nvl(SessionNegoFNum,0)),0,1,sum(nvl(SessionNegoSNum,0)+nvl(SessionNegoFNum,0))),4)  SessionNegoSRate,

sum(SessionNegoSNum)                    SessionNegoSNum,
sum(SessionNegoFNum)                    SessionNegoFNum,

--update-2011-10-12
--sum(A13_HandoffSRate)/count(city_id)     A13_HandoffSRate,
round(100*sum(nvl(A13_HandoffSNum,0))/decode(sum(nvl(A13_HandoffNum,0)),0,1,sum(nvl(A13_HandoffNum,0))),4)  A13_HandoffSRate,

sum(A13_HandoffNum)                    A13_HandoffNum,
sum(A13_HandoffSNum)                    A13_HandoffSNum,
sum(SessionNum)                    SessionNum,
sum(SessionNum_Active)                    SessionNum_Active,
sum(SessionNum_NotActive)    SessionNum_NotActive,

--update-2011-10-12
--round(100*sum(User_DAAcitveSuccRate)/count(city_id)     User_DAAcitveSuccRate,
round(100*sum(nvl(User_DAAcitveSuccNum,0))/decode(sum(nvl(User_DAAcitveReqNum,0)),0,1,sum(nvl(User_DAAcitveReqNum,0))),4)  User_DAAcitveSuccRate,

sum(User_DAAcitveReqNum)    User_DAAcitveReqNum,
sum(User_DAAcitveSuccNum)    User_DAAcitveSuccNum,

--update-2011-10-12
--sum(AT_DAAcitveSuccRate)/count(city_id)     AT_DAAcitveSuccRate,
round(100*sum(nvl(AT_DAAcitveSuccNum,0))/decode(sum(nvl(AT_DAAcitveReqNum,0)),0,1,sum(nvl(AT_DAAcitveReqNum,0))),4)  AT_DAAcitveSuccRate,

sum(AT_DAAcitveReqNum)    AT_DAAcitveReqNum,
sum(AT_DAAcitveSuccNum)    AT_DAAcitveSuccNum,
sum(AT_DAAcitveFailNum)    AT_DAAcitveFailNum,

--update-2011-10-12
--sum(AN_DAAcitveSuccRate)/count(city_id)     AN_DAAcitveSuccRate,
round(100*sum(nvl(AN_DAAcitveSuccNum,0))/decode(sum(nvl(AN_DAAcitveReqNum,0)),0,1,sum(nvl(AN_DAAcitveReqNum,0))),4)  AN_DAAcitveSuccRate,

sum(AN_DAAcitveReqNum)    AN_DAAcitveReqNum,
sum(AN_DAAcitveSuccNum)    AN_DAAcitveSuccNum,
sum(AN_DAAcitveFailNum)    AN_DAAcitveFailNum,
sum(EqlUserNum)    EqlUserNum,
sum(Call_Traffic)    Call_Traffic,
sum(CE_Traffic)    CE_Traffic,
sum(Sho_Traffic)    Sho_Traffic,
avg(Sho_Factor)    Sho_Factor,
sum(PCFRevDataSize)    PCFRevDataSize,
sum(PCFFwdDataSize)    PCFFwdDataSize,
sum(PCFRevPSMsg)    PCFRevPSMsg,
sum(PCFFwdPSMsg)    PCFFwdPSMsg,
sum(RevPSDiscardNum)    RevPSDiscardNum,
sum(FwdPSDiscardNum)    FwdPSDiscardNum,

--update-2011-10-12
--sum(RevPSDiscardRate)/count(city_id)     RevPSDiscardRate,
round(sum(nvl(RevPSDiscardNum,0))/decode(sum(nvl(PCFRevPSMsg,0)),0,1,sum(nvl(PCFRevPSMsg,0))),4)  RevPSDiscardRate,

--update-2011-10-12
--sum(FwdPSDiscardRate)/count(city_id)     FwdPSDiscardRate,
round(sum(nvl(FwdPSDiscardNum,0))/decode(sum(nvl(PCFFwdPSMsg,0)),0,1,sum(nvl(PCFFwdPSMsg,0))),4)  FwdPSDiscardRate,

sum(FwdRLPThroughput)                    FwdRLPThroughput,

--update-2011-10-12    算法是中文
--sum(FwdRLPRxRate)/count(city_id)     FwdRLPRxRate,

sum(RevRLPThroughput)                    RevRLPThroughput,

--update-2011-10-12   算法是中文
--sum(RevRLPRxRate)/count(city_id)     RevRLPRxRate,

sum(FwdTCHPhyAvgThroughput)                    FwdTCHPhyAvgThroughput,
sum(FwdTCHPhyOutburstThroughput)                    FwdTCHPhyOutburstThroughput,
sum(RevTCHPhyAvgThroughput)                    RevTCHPhyAvgThroughput,
sum(RevTCHPhyOutburstThroughput)                    RevTCHPhyOutburstThroughput,

--update-2011-10-12    算法是中文
--sum(FwdTCHPhyTimeSlotUseRate)/count(city_id)     FwdTCHPhyTimeSlotUseRate,

--update-2011-10-12    算法是中文
--sum(FwdCCHPhyTimeSlotUseRate)/count(city_id)     FwdCCHPhyTimeSlotUseRate,

--update-2011-10-12    无算法
round(sum(RevACHPhySlotUseRate)/count(city_id),4)     RevACHPhySlotUseRate,

--update-2011-10-12
--sum(RevCircuitBusyRate)/count(city_id)     RevCircuitBusyRate,
round(100*sum(nvl(RABBusyNum,0))/decode(sum(nvl(RABBusyNum,0)+nvl(RABFreeNum,0)),0,1,sum(nvl(RABBusyNum,0)+nvl(RABFreeNum,0))),4)  RevCircuitBusyRate,


round(100*sum(GlobalSHoSuccNum)/decode(sum(GlobalSHoReqNum),0,1,null,1,sum(GlobalSHoReqNum)),4) GlobalSHoSuccRate,
sum(GlobalSHoReqNum)  GlobalSHoReqNum,
sum(GlobalSHoSuccNum)  GlobalSHoSuccNum,
round(sum(SHoSuccRate_intraAN),4)                    SHoSuccRate_intraAN,
sum(SHoReqNum_intraAN)                    SHoReqNum_intraAN,
sum(SHoSuccNum_intraAN)                    SHoSuccNum_intraAN,
round(sum(SHoSuccRate_amongAN),4)                   SHoSuccRate_amongAN,
sum(SHoReqNum_amongAN)                    SHoReqNum_amongAN,
sum(SHoSuccNum_amongAN)                    SHoSuccNum_amongAN,
round(sum(HardHoSuccRate_intraAN),4)                    HardHoSuccRate_intraAN,
sum(HardHoReqNum_intraAN)                    HardHoReqNum_intraAN,
sum(HardHoSuccNum_intraAN)                    HardHoSuccNum_intraAN,
round(sum(HardHoSuccRate_amongAN),4)                    HardHoSuccRate_amongAN,
sum(HardHoReqNum_amongAN)                    HardHoReqNum_amongAN,
sum(HardHoSuccNum_amongAN)                    HardHoSuccNum_amongAN,

--update-2011-10-12
--sum(PageResponceRate)/count(city_id)     PageResponceRate,
round(100*sum(nvl(PageResponceNum,0))/decode(sum(nvl(PageReqNum,0)),0,1,sum(nvl(PageReqNum,0))),4)  PageResponceRate,

sum(PageReqNum)                    PageReqNum,
sum(PageResponceNum)                    PageResponceNum,
sum(DOCarrier37)                    DOCarrier37,
sum(DOCarrier78)                    DOCarrier78,
sum(DOCarrier119)                    DOCarrier119,
sum(DOCarrierTotalNum)                    DOCarrierTotalNum,
sum(DOCarrier37Traffic)                    DOCarrier37Traffic,
sum(DOCarrier78Traffic)                    DOCarrier78Traffic,
sum(DOCarrier119Traffic)                    DOCarrier119Traffic,
sum(OneDOCarrierCellNum)                    OneDOCarrierCellNum,
sum(TwoDOCarrierCellNum)                    TwoDOCarrierCellNum,
sum(ThreeDOCarrierCellNum)                    ThreeDOCarrierCellNum,
sum(DOCellNum)                    DOCellNum,
sum(ConnectSetupTotalDuration)                    ConnectSetupTotalDuration,
sum(ConnectUseTotalDuration)                    ConnectUseTotalDuration,
sum(SessionSetupTotalDuration)                    SessionSetupTotalDuration,
sum(FwdRxSize)                    FwdRxSize,
sum(FwdTxSize)                    FwdTxSize,
sum(RevRxSize)                    RevRxSize,
sum(RevTxSize)                    RevTxSize,
sum(RABBusyNum)                    RABBusyNum,
sum(RABFreeNum)                    RABFreeNum,
sum(FwdAvailNum_MacIndex)                    FwdAvailNum_MacIndex,
sum(DRCApplyNum_FwdSpeed1)                    DRCApplyNum_FwdSpeed1,
sum(DRCApplyNum_FwdSpeed2)                    DRCApplyNum_FwdSpeed2,
sum(DRCApplyNum_FwdSpeed3)                    DRCApplyNum_FwdSpeed3,
sum(FwdTCHPhyTxBitNum)                    FwdTCHPhyTxBitNum,
sum(FwdPhyUseTimeSlotDuration)                    FwdPhyUseTimeSlotDuration,
sum(RevTCHPhyTxBitNum)                    RevTCHPhyTxBitNum,
sum(RevPhyUseTimeSlotDuration)                    RevPhyUseTimeSlotDuration
from c_perf_do_sum a,c_region_city c
where a.int_id = c.city_id
and a.scan_start_time = v_date
and a.ne_type = 10004
and a.sum_level = 0
and a.vendor_id = 10
group by c.province_id) t
on(c_perf.int_id = t.province_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10000 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
BtsTotalNum                   = t.BtsTotalNum                  ,
OnecarrierBtsNum              = t.OnecarrierBtsNum             ,
TwocarrierBtsNum              = t.TwocarrierBtsNum             ,
threecarrierBtsNum            = t.threecarrierBtsNum           ,
FourcarrierBtsNum             = t.FourcarrierBtsNum            ,
CarrierCellNum                = t.CarrierCellNum               ,
RevCEMaxUseRate               = t.RevCEMaxUseRate              ,
RevCEMaxBusyNum               = t.RevCEMaxBusyNum              ,
RevCEAvailNum                 = t.RevCEAvailNum                ,
FwdMaxUseRate_MacIndex        = t.FwdMaxUseRate_MacIndex       ,
FwdMaxBusyNum_MacIndex        = t.FwdMaxBusyNum_MacIndex       ,
PCFNum                        = t.PCFNum                       ,
PCFMeanCpuAvgLoad             = t.PCFMeanCpuAvgLoad            ,
PCFMaxHRPDSessionNum          = t.PCFMaxHRPDSessionNum         ,
PCFMaxActiveHRPDSessionNum    = t.PCFMaxActiveHRPDSessionNum   ,
PCFUplinkThroughputRate       = t.PCFUplinkThroughputRate      ,
PCFDownlinkThroughputRate     = t.PCFDownlinkThroughputRate    ,
ABisBWAvgUseRate              = t.ABisBWAvgUseRate             ,
AbisPortBandWidth             = t.AbisPortBandWidth            ,
AbisAvgUseBandWidth           = t.AbisAvgUseBandWidth          ,
BusyerBtsNum                  = t.BusyerBtsNum                 ,
FreeBtsNum                    = t.FreeBtsNum                   ,
WireConnectSuccRate           = t.WireConnectSuccRate          ,
AT_ConnectSuccRate            = t.AT_ConnectSuccRate           ,
AN_ConnectSuccRate            = t.AN_ConnectSuccRate           ,
AT_ConnectReqNum              = t.AT_ConnectReqNum             ,
AN_ConnectReqNum              = t.AN_ConnectReqNum             ,
AT_ConnectSuccNum             = t.AT_ConnectSuccNum            ,
AN_ConnectSuccNum             = t.AN_ConnectSuccNum            ,
WireConnectSuccRateInA8A10    = t.WireConnectSuccRateInA8A10   ,
WireConnectSuccNumInA8A10     = t.WireConnectSuccNumInA8A10    ,
WireConnectReqNumInA8A10      = t.WireConnectReqNumInA8A10     ,
UserEarlyReleaseRate          = t.UserEarlyReleaseRate         ,
UserEarlyReleaseNum           = t.UserEarlyReleaseNum          ,
WireConnectFailNum1           = t.WireConnectFailNum1          ,
WireConnectFailNum2           = t.WireConnectFailNum2          ,
WireConnectFailNum3           = t.WireConnectFailNum3          ,
WireConnectReleaseNumInPDSN   = t.WireConnectReleaseNumInPDSN  ,
WireConnectReleaseNumExPDSN   = t.WireConnectReleaseNumExPDSN  ,
ReleaseNumByPDSN              = t.ReleaseNumByPDSN             ,
WireRadioFNum1                = t.WireRadioFNum1               ,
WireRadioFNum2                = t.WireRadioFNum2               ,
WireRadioFNum3                = t.WireRadioFNum3               ,
WireRadioFRate                = t.WireRadioFRate               ,
NetWorkRadioFRate             = t.NetWorkRadioFRate            ,
ConnectAvgSetupDuration       = t.ConnectAvgSetupDuration      ,
ConnectAvgUseDuration         = t.ConnectAvgUseDuration        ,
DRCApplyRate_FwdSpeed1        = t.DRCApplyRate_FwdSpeed1       ,
DRCApplyRate_FwdSpeed2        = t.DRCApplyRate_FwdSpeed2       ,
DRCApplyRate_FwdSpeed3        = t.DRCApplyRate_FwdSpeed3       ,
UATI_AssgnSuccRate            = t.UATI_AssgnSuccRate           ,
UATI_AssgnReqNum              = t.UATI_AssgnReqNum             ,
UATI_AssgnSuccNum             = t.UATI_AssgnSuccNum            ,
UATI_AssgnFailNum             = t.UATI_AssgnFailNum            ,
UATI_AvgSetupDuration         = t.UATI_AvgSetupDuration        ,
SessionAuthenticationSRate    = t.SessionAuthenticationSRate   ,
SessionAuthenticationSNum     = t.SessionAuthenticationSNum    ,
SessionAuthenticationReqNum   = t.SessionAuthenticationReqNum  ,
SessionAuthenticationRejNum   = t.SessionAuthenticationRejNum  ,
SessionAuthenticationFNum     = t.SessionAuthenticationFNum    ,
SessionNegoSRate              = t.SessionNegoSRate             ,
SessionNegoSNum               = t.SessionNegoSNum              ,
SessionNegoFNum               = t.SessionNegoFNum              ,
A13_HandoffSRate              = t.A13_HandoffSRate             ,
A13_HandoffNum                = t.A13_HandoffNum               ,
A13_HandoffSNum               = t.A13_HandoffSNum              ,
SessionNum                    = t.SessionNum                   ,
SessionNum_Active             = t.SessionNum_Active            ,
SessionNum_NotActive          = t.SessionNum_NotActive         ,
User_DAAcitveSuccRate         = t.User_DAAcitveSuccRate        ,
User_DAAcitveReqNum           = t.User_DAAcitveReqNum          ,
User_DAAcitveSuccNum          = t.User_DAAcitveSuccNum         ,
AT_DAAcitveSuccRate           = t.AT_DAAcitveSuccRate          ,
AT_DAAcitveReqNum             = t.AT_DAAcitveReqNum            ,
AT_DAAcitveSuccNum            = t.AT_DAAcitveSuccNum           ,
AT_DAAcitveFailNum            = t.AT_DAAcitveFailNum           ,
AN_DAAcitveSuccRate           = t.AN_DAAcitveSuccRate          ,
AN_DAAcitveReqNum             = t.AN_DAAcitveReqNum            ,
AN_DAAcitveSuccNum            = t.AN_DAAcitveSuccNum           ,
AN_DAAcitveFailNum            = t.AN_DAAcitveFailNum           ,
EqlUserNum                    = t.EqlUserNum                   ,
Call_Traffic                  = t.Call_Traffic                 ,
CE_Traffic                    = t.CE_Traffic                   ,
Sho_Traffic                   = t.Sho_Traffic                  ,
Sho_Factor                    = t.Sho_Factor                   ,
PCFRevDataSize                = t.PCFRevDataSize               ,
PCFFwdDataSize                = t.PCFFwdDataSize               ,
PCFRevPSMsg                   = t.PCFRevPSMsg                  ,
PCFFwdPSMsg                   = t.PCFFwdPSMsg                  ,
RevPSDiscardNum               = t.RevPSDiscardNum              ,
FwdPSDiscardNum               = t.FwdPSDiscardNum              ,
RevPSDiscardRate              = t.RevPSDiscardRate             ,
FwdPSDiscardRate              = t.FwdPSDiscardRate             ,
FwdRLPThroughput              = t.FwdRLPThroughput             ,
--FwdRLPRxRate                  = t.FwdRLPRxRate                 ,
RevRLPThroughput              = t.RevRLPThroughput             ,
--RevRLPRxRate                  = t.RevRLPRxRate                 ,
FwdTCHPhyAvgThroughput        = t.FwdTCHPhyAvgThroughput       ,
FwdTCHPhyOutburstThroughput   = t.FwdTCHPhyOutburstThroughput  ,
RevTCHPhyAvgThroughput        = t.RevTCHPhyAvgThroughput       ,
RevTCHPhyOutburstThroughput   = t.RevTCHPhyOutburstThroughput  ,
--FwdTCHPhyTimeSlotUseRate      = t.FwdTCHPhyTimeSlotUseRate     ,
--FwdCCHPhyTimeSlotUseRate      = t.FwdCCHPhyTimeSlotUseRate     ,
RevACHPhySlotUseRate          = t.RevACHPhySlotUseRate         ,
RevCircuitBusyRate            = t.RevCircuitBusyRate           ,
GlobalSHoSuccRate             = t.GlobalSHoSuccRate            ,
GlobalSHoReqNum               = t.GlobalSHoReqNum              ,
GlobalSHoSuccNum              = t.GlobalSHoSuccNum             ,
SHoSuccRate_intraAN           = t.SHoSuccRate_intraAN          ,
SHoReqNum_intraAN             = t.SHoReqNum_intraAN            ,
SHoSuccNum_intraAN            = t.SHoSuccNum_intraAN           ,
SHoSuccRate_amongAN           = t.SHoSuccRate_amongAN          ,
SHoReqNum_amongAN             = t.SHoReqNum_amongAN            ,
SHoSuccNum_amongAN            = t.SHoSuccNum_amongAN           ,
HardHoSuccRate_intraAN        = t.HardHoSuccRate_intraAN       ,
HardHoReqNum_intraAN          = t.HardHoReqNum_intraAN         ,
HardHoSuccNum_intraAN         = t.HardHoSuccNum_intraAN        ,
HardHoSuccRate_amongAN        = t.HardHoSuccRate_amongAN       ,
HardHoReqNum_amongAN          = t.HardHoReqNum_amongAN         ,
HardHoSuccNum_amongAN         = t.HardHoSuccNum_amongAN        ,
PageResponceRate              = t.PageResponceRate             ,
PageReqNum                    = t.PageReqNum                   ,
PageResponceNum               = t.PageResponceNum              ,
DOCarrier37                   = t.DOCarrier37                  ,
DOCarrier78                   = t.DOCarrier78                  ,
DOCarrier119                  = t.DOCarrier119                 ,
DOCarrierTotalNum             = t.DOCarrierTotalNum            ,
DOCarrier37Traffic            = t.DOCarrier37Traffic           ,
DOCarrier78Traffic            = t.DOCarrier78Traffic           ,
DOCarrier119Traffic           = t.DOCarrier119Traffic          ,
OneDOCarrierCellNum           = t.OneDOCarrierCellNum          ,
TwoDOCarrierCellNum           = t.TwoDOCarrierCellNum          ,
ThreeDOCarrierCellNum         = t.ThreeDOCarrierCellNum        ,
DOCellNum                     = t.DOCellNum                    ,
ConnectSetupTotalDuration     = t.ConnectSetupTotalDuration    ,
ConnectUseTotalDuration       = t.ConnectUseTotalDuration      ,
SessionSetupTotalDuration     = t.SessionSetupTotalDuration    ,
FwdRxSize                     = t.FwdRxSize                    ,
FwdTxSize                     = t.FwdTxSize                    ,
RevRxSize                     = t.RevRxSize                    ,
RevTxSize                     = t.RevTxSize                    ,
RABBusyNum                    = t.RABBusyNum                   ,
RABFreeNum                    = t.RABFreeNum                   ,
FwdAvailNum_MacIndex          = t.FwdAvailNum_MacIndex         ,
DRCApplyNum_FwdSpeed1         = t.DRCApplyNum_FwdSpeed1        ,
DRCApplyNum_FwdSpeed2         = t.DRCApplyNum_FwdSpeed2        ,
DRCApplyNum_FwdSpeed3         = t.DRCApplyNum_FwdSpeed3        ,
FwdTCHPhyTxBitNum             = t.FwdTCHPhyTxBitNum            ,
FwdPhyUseTimeSlotDuration     = t.FwdPhyUseTimeSlotDuration    ,
RevTCHPhyTxBitNum             = t.RevTCHPhyTxBitNum            ,
RevPhyUseTimeSlotDuration     = t.RevPhyUseTimeSlotDuration
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type ,
vendor_id ,
BtsTotalNum                 ,
OnecarrierBtsNum            ,
TwocarrierBtsNum            ,
threecarrierBtsNum          ,
FourcarrierBtsNum           ,
CarrierCellNum              ,
RevCEMaxUseRate             ,
RevCEMaxBusyNum             ,
RevCEAvailNum               ,
FwdMaxUseRate_MacIndex      ,
FwdMaxBusyNum_MacIndex      ,
PCFNum                      ,
PCFMeanCpuAvgLoad           ,
PCFMaxHRPDSessionNum        ,
PCFMaxActiveHRPDSessionNum  ,
PCFUplinkThroughputRate     ,
PCFDownlinkThroughputRate   ,
ABisBWAvgUseRate            ,
AbisPortBandWidth           ,
AbisAvgUseBandWidth         ,
BusyerBtsNum                ,
FreeBtsNum                  ,
WireConnectSuccRate         ,
AT_ConnectSuccRate          ,
AN_ConnectSuccRate          ,
AT_ConnectReqNum            ,
AN_ConnectReqNum            ,
AT_ConnectSuccNum           ,
AN_ConnectSuccNum           ,
WireConnectSuccRateInA8A10  ,
WireConnectSuccNumInA8A10   ,
WireConnectReqNumInA8A10    ,
UserEarlyReleaseRate        ,
UserEarlyReleaseNum         ,
WireConnectFailNum1         ,
WireConnectFailNum2         ,
WireConnectFailNum3         ,
WireConnectReleaseNumInPDSN ,
WireConnectReleaseNumExPDSN ,
ReleaseNumByPDSN            ,
WireRadioFNum1              ,
WireRadioFNum2              ,
WireRadioFNum3              ,
WireRadioFRate              ,
NetWorkRadioFRate           ,
ConnectAvgSetupDuration     ,
ConnectAvgUseDuration       ,
DRCApplyRate_FwdSpeed1      ,
DRCApplyRate_FwdSpeed2      ,
DRCApplyRate_FwdSpeed3      ,
UATI_AssgnSuccRate          ,
UATI_AssgnReqNum            ,
UATI_AssgnSuccNum           ,
UATI_AssgnFailNum           ,
UATI_AvgSetupDuration       ,
SessionAuthenticationSRate  ,
SessionAuthenticationSNum   ,
SessionAuthenticationReqNum ,
SessionAuthenticationRejNum ,
SessionAuthenticationFNum   ,
SessionNegoSRate            ,
SessionNegoSNum             ,
SessionNegoFNum             ,
A13_HandoffSRate            ,
A13_HandoffNum              ,
A13_HandoffSNum             ,
SessionNum                  ,
SessionNum_Active           ,
SessionNum_NotActive        ,
User_DAAcitveSuccRate       ,
User_DAAcitveReqNum         ,
User_DAAcitveSuccNum        ,
AT_DAAcitveSuccRate         ,
AT_DAAcitveReqNum           ,
AT_DAAcitveSuccNum          ,
AT_DAAcitveFailNum          ,
AN_DAAcitveSuccRate         ,
AN_DAAcitveReqNum           ,
AN_DAAcitveSuccNum          ,
AN_DAAcitveFailNum          ,
EqlUserNum                  ,
Call_Traffic                ,
CE_Traffic                  ,
Sho_Traffic                 ,
Sho_Factor                  ,
PCFRevDataSize              ,
PCFFwdDataSize              ,
PCFRevPSMsg                 ,
PCFFwdPSMsg                 ,
RevPSDiscardNum             ,
FwdPSDiscardNum             ,
RevPSDiscardRate            ,
FwdPSDiscardRate            ,
FwdRLPThroughput            ,
--FwdRLPRxRate                ,
RevRLPThroughput            ,
--RevRLPRxRate                ,
FwdTCHPhyAvgThroughput      ,
FwdTCHPhyOutburstThroughput ,
RevTCHPhyAvgThroughput      ,
RevTCHPhyOutburstThroughput ,
--FwdTCHPhyTimeSlotUseRate    ,
--FwdCCHPhyTimeSlotUseRate    ,
RevACHPhySlotUseRate        ,
RevCircuitBusyRate          ,
GlobalSHoSuccRate           ,
GlobalSHoReqNum             ,
GlobalSHoSuccNum            ,
SHoSuccRate_intraAN         ,
SHoReqNum_intraAN           ,
SHoSuccNum_intraAN          ,
SHoSuccRate_amongAN         ,
SHoReqNum_amongAN           ,
SHoSuccNum_amongAN          ,
HardHoSuccRate_intraAN      ,
HardHoReqNum_intraAN        ,
HardHoSuccNum_intraAN       ,
HardHoSuccRate_amongAN      ,
HardHoReqNum_amongAN        ,
HardHoSuccNum_amongAN       ,
PageResponceRate            ,
PageReqNum                  ,
PageResponceNum             ,
DOCarrier37                 ,
DOCarrier78                 ,
DOCarrier119                ,
DOCarrierTotalNum           ,
DOCarrier37Traffic          ,
DOCarrier78Traffic          ,
DOCarrier119Traffic         ,
OneDOCarrierCellNum         ,
TwoDOCarrierCellNum         ,
ThreeDOCarrierCellNum       ,
DOCellNum                   ,
ConnectSetupTotalDuration   ,
ConnectUseTotalDuration     ,
SessionSetupTotalDuration   ,
FwdRxSize                   ,
FwdTxSize                   ,
RevRxSize                   ,
RevTxSize                   ,
RABBusyNum                  ,
RABFreeNum                  ,
FwdAvailNum_MacIndex        ,
DRCApplyNum_FwdSpeed1       ,
DRCApplyNum_FwdSpeed2       ,
DRCApplyNum_FwdSpeed3       ,
FwdTCHPhyTxBitNum           ,
FwdPhyUseTimeSlotDuration   ,
RevTCHPhyTxBitNum           ,
RevPhyUseTimeSlotDuration  )
values(
t.province_id,
v_date,
0,
10000,
10,
t.BtsTotalNum                  ,
t.OnecarrierBtsNum             ,
t.TwocarrierBtsNum             ,
t.threecarrierBtsNum           ,
t.FourcarrierBtsNum            ,
t.CarrierCellNum               ,
t.RevCEMaxUseRate              ,
t.RevCEMaxBusyNum              ,
t.RevCEAvailNum                ,
t.FwdMaxUseRate_MacIndex       ,
t.FwdMaxBusyNum_MacIndex       ,
t.PCFNum                       ,
t.PCFMeanCpuAvgLoad            ,
t.PCFMaxHRPDSessionNum         ,
t.PCFMaxActiveHRPDSessionNum   ,
t.PCFUplinkThroughputRate      ,
t.PCFDownlinkThroughputRate    ,
t.ABisBWAvgUseRate             ,
t.AbisPortBandWidth            ,
t.AbisAvgUseBandWidth          ,
t.BusyerBtsNum                 ,
t.FreeBtsNum                   ,
t.WireConnectSuccRate          ,
t.AT_ConnectSuccRate           ,
t.AN_ConnectSuccRate           ,
t.AT_ConnectReqNum             ,
t.AN_ConnectReqNum             ,
t.AT_ConnectSuccNum            ,
t.AN_ConnectSuccNum            ,
t.WireConnectSuccRateInA8A10   ,
t.WireConnectSuccNumInA8A10    ,
t.WireConnectReqNumInA8A10     ,
t.UserEarlyReleaseRate         ,
t.UserEarlyReleaseNum          ,
t.WireConnectFailNum1          ,
t.WireConnectFailNum2          ,
t.WireConnectFailNum3          ,
t.WireConnectReleaseNumInPDSN  ,
t.WireConnectReleaseNumExPDSN  ,
t.ReleaseNumByPDSN             ,
t.WireRadioFNum1               ,
t.WireRadioFNum2               ,
t.WireRadioFNum3               ,
t.WireRadioFRate               ,
t.NetWorkRadioFRate            ,
t.ConnectAvgSetupDuration      ,
t.ConnectAvgUseDuration        ,
t.DRCApplyRate_FwdSpeed1       ,
t.DRCApplyRate_FwdSpeed2       ,
t.DRCApplyRate_FwdSpeed3       ,
t.UATI_AssgnSuccRate           ,
t.UATI_AssgnReqNum             ,
t.UATI_AssgnSuccNum            ,
t.UATI_AssgnFailNum            ,
t.UATI_AvgSetupDuration        ,
t.SessionAuthenticationSRate   ,
t.SessionAuthenticationSNum    ,
t.SessionAuthenticationReqNum  ,
t.SessionAuthenticationRejNum  ,
t.SessionAuthenticationFNum    ,
t.SessionNegoSRate             ,
t.SessionNegoSNum              ,
t.SessionNegoFNum              ,
t.A13_HandoffSRate             ,
t.A13_HandoffNum               ,
t.A13_HandoffSNum              ,
t.SessionNum                   ,
t.SessionNum_Active            ,
t.SessionNum_NotActive         ,
t.User_DAAcitveSuccRate        ,
t.User_DAAcitveReqNum          ,
t.User_DAAcitveSuccNum         ,
t.AT_DAAcitveSuccRate          ,
t.AT_DAAcitveReqNum            ,
t.AT_DAAcitveSuccNum           ,
t.AT_DAAcitveFailNum           ,
t.AN_DAAcitveSuccRate          ,
t.AN_DAAcitveReqNum            ,
t.AN_DAAcitveSuccNum           ,
t.AN_DAAcitveFailNum           ,
t.EqlUserNum                   ,
t.Call_Traffic                 ,
t.CE_Traffic                   ,
t.Sho_Traffic                  ,
t.Sho_Factor                   ,
t.PCFRevDataSize               ,
t.PCFFwdDataSize               ,
t.PCFRevPSMsg                  ,
t.PCFFwdPSMsg                  ,
t.RevPSDiscardNum              ,
t.FwdPSDiscardNum              ,
t.RevPSDiscardRate             ,
t.FwdPSDiscardRate             ,
t.FwdRLPThroughput             ,
--t.FwdRLPRxRate                 ,
t.RevRLPThroughput             ,
--t.RevRLPRxRate                 ,
t.FwdTCHPhyAvgThroughput       ,
t.FwdTCHPhyOutburstThroughput  ,
t.RevTCHPhyAvgThroughput       ,
t.RevTCHPhyOutburstThroughput  ,
--t.FwdTCHPhyTimeSlotUseRate     ,
--t.FwdCCHPhyTimeSlotUseRate     ,
t.RevACHPhySlotUseRate         ,
t.RevCircuitBusyRate           ,
t.GlobalSHoSuccRate            ,
t.GlobalSHoReqNum              ,
t.GlobalSHoSuccNum             ,
t.SHoSuccRate_intraAN          ,
t.SHoReqNum_intraAN            ,
t.SHoSuccNum_intraAN           ,
t.SHoSuccRate_amongAN          ,
t.SHoReqNum_amongAN            ,
t.SHoSuccNum_amongAN           ,
t.HardHoSuccRate_intraAN       ,
t.HardHoReqNum_intraAN         ,
t.HardHoSuccNum_intraAN        ,
t.HardHoSuccRate_amongAN       ,
t.HardHoReqNum_amongAN         ,
t.HardHoSuccNum_amongAN        ,
t.PageResponceRate             ,
t.PageReqNum                   ,
t.PageResponceNum              ,
t.DOCarrier37                  ,
t.DOCarrier78                  ,
t.DOCarrier119                 ,
t.DOCarrierTotalNum            ,
t.DOCarrier37Traffic           ,
t.DOCarrier78Traffic           ,
t.DOCarrier119Traffic          ,
t.OneDOCarrierCellNum          ,
t.TwoDOCarrierCellNum          ,
t.ThreeDOCarrierCellNum        ,
t.DOCellNum                    ,
t.ConnectSetupTotalDuration    ,
t.ConnectUseTotalDuration      ,
t.SessionSetupTotalDuration    ,
t.FwdRxSize                    ,
t.FwdTxSize                    ,
t.RevRxSize                    ,
t.RevTxSize                    ,
t.RABBusyNum                   ,
t.RABFreeNum                   ,
t.FwdAvailNum_MacIndex         ,
t.DRCApplyNum_FwdSpeed1        ,
t.DRCApplyNum_FwdSpeed2        ,
t.DRCApplyNum_FwdSpeed3        ,
t.FwdTCHPhyTxBitNum            ,
t.FwdPhyUseTimeSlotDuration    ,
t.RevTCHPhyTxBitNum            ,
t.RevPhyUseTimeSlotDuration);

commit;

---------------------------

--add-2011-10-12
--add-FwdRLPRxRate
merge into c_perf_do_sum c_perf
using(
select
province_id ,
---update by zhengting
100*sum(a.EVMRLPRETXEDFTCBE
+a.EVMRLPRETXEDFTCSMC
+a.EVMRLPRETXEDFTCDARQBE
+a.EVMRLPRETXEDFTCDARQCPS
+a.EVMRLPRETXEDFTCDARQCS
+a.EVMRLPRETXEDFTCDARQCV
+a.EVMRLPRETXEDFTCDARQSMC)/decode(
sum(a.EVMRLPTXEDFTCBE
+a.EVMRLPTXEDFTCSMC
+a.EVMRLPTXEDFTCCPS
+a.EVMRLPTXEDFTCCS
+a.EVMRLPTXEDFTCCV),0,1,null,1,sum(a.EVMRLPTXEDFTCBE
+a.EVMRLPTXEDFTCSMC
+a.EVMRLPTXEDFTCCPS
+a.EVMRLPTXEDFTCCS
+a.EVMRLPTXEDFTCCV))            FwdRLPRxRate
from c_tpd_carr_do_lc a ,c_carrier c,c_region_city r
where a.int_id=c.int_id
and c.city_id=r.city_id
and a.scan_start_time = v_date
group by r.province_id ) t
on(c_perf.int_id = t.province_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10000 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
c_perf.FwdRLPRxRate=t.FwdRLPRxRate
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type ,
vendor_id ,
FwdRLPRxRate)
values(
t.province_id,
v_date,
0,
10000,
10,
t.FwdRLPRxRate);
commit;

--add-2011-10-12
--add-RevRLPRxRate
merge into c_perf_do_sum c_perf
using(
select
province_id,
round(sum(a.Hdr003
+a.Hdr108)/decode(
sum(a.Hdr002
-a.Hdr115
-a.Hdr111
-a.Hdr112),0,1,null,1,sum(a.Hdr002
-a.Hdr115
-a.Hdr111
-a.Hdr112)),4)        RevRLPRxRate
from  c_tpd_carr_do_ag_lc a, c_carrier c,c_region_city r
where a.int_id=c.int_id
and   c.city_id=r.city_id
and a.scan_start_time = v_date
group by r.province_id) t
on(c_perf.int_id = t.province_id
and c_perf.scan_start_time = v_date
and c_perf.ne_type=10000
and c_perf.sum_level=0
and c_perf.vendor_id=10)
when matched then update set
c_perf.RevRLPRxRate=t.RevRLPRxRate
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type ,
vendor_id ,
RevRLPRxRate)
values(
t.province_id,
v_date,
0,
10000,
10,
t.RevRLPRxRate);
commit;


--add-2011-10-12
--add-FwdTCHPhyTimeSlotUseRate
merge into c_perf_do_sum c_perf
using(
select
province_id,
round(sum(a.EVMTOTALBUSYSLOTSBE
+ a.EVMTOTALBUSYSLOTSEF) /
decode(sum(a.TIMESLOTSINPEGGINGINTERVAL),0,1,null,1,sum(a.TIMESLOTSINPEGGINGINTERVAL)),4)   FwdTCHPhyTimeSlotUseRate
from  c_tpd_carr_do_lc a, c_carrier c,c_region_city r
where a.int_id=c.int_id
and   c.city_id=r.city_id
and a.scan_start_time = v_date
group by r.province_id) t
on(c_perf.int_id = t.province_id
and c_perf.scan_start_time = v_date
and c_perf.ne_type=10000
and c_perf.sum_level=0
and c_perf.vendor_id=10)
when matched then update set
c_perf.FwdTCHPhyTimeSlotUseRate=t.FwdTCHPhyTimeSlotUseRate
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type ,
vendor_id ,
RevRLPRxRate)
values(
t.province_id,
v_date,
0,
10000,
10,
t.FwdTCHPhyTimeSlotUseRate);
commit;


--add-2011-10-12
--add-FwdCCHPhyTimeSlotUseRate
merge into c_perf_do_sum c_perf
using(
select
province_id,
round(sum(a.EVMCCSLOTSSYNCMSGXMIT
+a.EVMCCSLOTSSUBSYNCMSGXMIT)/decode
(sum(a.TIMESLOTSINPEGGINGINTERVAL),0,1,null,1,sum(a.TIMESLOTSINPEGGINGINTERVAL)),4)   FwdCCHPhyTimeSlotUseRate
from c_tpd_carr_do_lc a ,c_carrier c,c_region_city r
where a.int_id=c.int_id
and c.city_id=r.city_id
and a.scan_start_time = v_date
group by r.province_id ) t
on(c_perf.int_id = t.province_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10000 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
c_perf.FwdCCHPhyTimeSlotUseRate=t.FwdCCHPhyTimeSlotUseRate
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type ,
vendor_id ,
FwdRLPRxRate)
values(
t.province_id,
v_date,
0,
10000,
10,
t.FwdCCHPhyTimeSlotUseRate);
commit;


--merge different vendor
merge into c_perf_do_sum c_perf
using(
select
int_id,
ne_type,
sum(nvl(BtsTotalNum                ,0))  BtsTotalNum                ,
sum(nvl(OnecarrierBtsNum           ,0))  OnecarrierBtsNum           ,
sum(nvl(TwocarrierBtsNum           ,0))  TwocarrierBtsNum           ,
sum(nvl(threecarrierBtsNum         ,0))  threecarrierBtsNum         ,
sum(nvl(FourcarrierBtsNum          ,0))  FourcarrierBtsNum          ,
sum(nvl(CarrierCellNum             ,0))  CarrierCellNum             ,
round(100*sum(RevCEMaxBusyNum)/decode(sum(RevCEAvailNum),null,1,0,1,sum(RevCEAvailNum)),4)  RevCEMaxUseRate            ,
sum(nvl(RevCEMaxBusyNum            ,0))  RevCEMaxBusyNum            ,
sum(nvl(RevCEAvailNum              ,0))  RevCEAvailNum              ,
--update-2011-9-18
--round(100*sum(FwdMaxBusyNum_MacIndex)/decode(sum(FwdAvailNum_MacIndex),null,1,0,1,sum(FwdAvailNum_MacIndex))  FwdMaxUseRate_MacIndex     ,
round(max(FwdMaxUseRate_MacIndex),4) FwdMaxUseRate_MacIndex,
max(nvl(FwdMaxBusyNum_MacIndex     ,0))  FwdMaxBusyNum_MacIndex     ,
sum(nvl(PCFNum                     ,0))  PCFNum                     ,
--update-2011-18
--sum(nvl(PCFMeanCpuAvgLoad          ,0))  PCFMeanCpuAvgLoad          ,
avg(nvl(PCFMeanCpuAvgLoad          ,0))  PCFMeanCpuAvgLoad          ,
sum(nvl(PCFMaxHRPDSessionNum       ,0))  PCFMaxHRPDSessionNum       ,
sum(nvl(PCFMaxActiveHRPDSessionNum ,0))  PCFMaxActiveHRPDSessionNum ,
round(avg(nvl(PCFUplinkThroughputRate    ,0)),4)  PCFUplinkThroughputRate    ,
round(avg(nvl(PCFDownlinkThroughputRate  ,0)),4)  PCFDownlinkThroughputRate  ,
round(sum(AbisAvgUseBandWidth)/decode(sum(AbisPortBandWidth),null,1,0,1,sum(AbisPortBandWidth)),4)  ABisBWAvgUseRate           ,
sum(nvl(AbisPortBandWidth          ,0))  AbisPortBandWidth          ,
sum(nvl(AbisAvgUseBandWidth        ,0))  AbisAvgUseBandWidth        ,
sum(nvl(BusyerBtsNum               ,0))  BusyerBtsNum               ,
sum(nvl(FreeBtsNum                 ,0))  FreeBtsNum                 ,
round(100*sum(AT_ConnectSuccNum+AN_ConnectSuccNum)/
decode(sum(AT_ConnectReqNum+AN_ConnectReqNum),0,1,null,1,sum(AT_ConnectReqNum+AN_ConnectReqNum)),4)  WireConnectSuccRate        ,
round(100*sum(AT_ConnectSuccNum)/decode(sum(AT_ConnectReqNum),null,1,0,1,sum(AT_ConnectReqNum)) ,4) AT_ConnectSuccRate         ,
round(avg(nvl(AN_ConnectSuccRate         ,0)),4)  AN_ConnectSuccRate         ,
sum(nvl(AT_ConnectReqNum           ,0))  AT_ConnectReqNum           ,
sum(nvl(AN_ConnectReqNum           ,0))  AN_ConnectReqNum           ,
sum(nvl(AT_ConnectSuccNum          ,0))  AT_ConnectSuccNum          ,
sum(nvl(AN_ConnectSuccNum          ,0))  AN_ConnectSuccNum          ,
round(100*sum(WireConnectSuccNumInA8A10)/decode(sum(WireConnectReqNumInA8A10),null,1,0,1,sum(WireConnectReqNumInA8A10)),4)  WireConnectSuccRateInA8A10 ,
sum(nvl(WireConnectSuccNumInA8A10  ,0))  WireConnectSuccNumInA8A10  ,
sum(nvl(WireConnectReqNumInA8A10   ,0))  WireConnectReqNumInA8A10   ,
round(100*sum(UserEarlyReleaseNum)/decode(sum(AT_ConnectReqNum+AN_ConnectReqNum),null,1,0,1,sum(AT_ConnectReqNum+AN_ConnectReqNum)),4)  UserEarlyReleaseRate       ,
sum(nvl(UserEarlyReleaseNum        ,0))  UserEarlyReleaseNum        ,
sum(nvl(WireConnectFailNum1        ,0))  WireConnectFailNum1        ,
sum(nvl(WireConnectFailNum2        ,0))  WireConnectFailNum2        ,
sum(nvl(WireConnectFailNum3        ,0))  WireConnectFailNum3        ,
sum(nvl(WireConnectReleaseNumInPDSN,0))  WireConnectReleaseNumInPDSN,
sum(nvl(WireConnectReleaseNumExPDSN,0))  WireConnectReleaseNumExPDSN,
sum(nvl(ReleaseNumByPDSN           ,0))  ReleaseNumByPDSN           ,
sum(nvl(WireRadioFNum1             ,0))  WireRadioFNum1             ,
sum(nvl(WireRadioFNum2             ,0))  WireRadioFNum2             ,
sum(nvl(WireRadioFNum3             ,0))  WireRadioFNum3             ,
round(100*sum(WireRadioFNum1+WireRadioFNum2+WireRadioFNum3)/
decode(sum(WireConnectReleaseNumInPDSN+WireRadioFNum1+WireRadioFNum2+WireRadioFNum3),0,1,null,1,sum(WireConnectReleaseNumInPDSN+WireRadioFNum1+WireRadioFNum2+WireRadioFNum3)),4)  WireRadioFRate             ,
---update by zhengting
round(100*sum(nvl(ReleaseNumByPDSN,0)+nvl(WireRadioFNum1,0)+nvl(WireRadioFNum2,0)+nvl(WireRadioFNum3,0))/
decode(sum(WireConnectReleaseNumInPDSN+WireRadioFNum1+WireRadioFNum2+WireRadioFNum3),
null,1,0,1,sum(WireConnectReleaseNumInPDSN+WireRadioFNum1+WireRadioFNum2+WireRadioFNum3)),4)  NetWorkRadioFRate          ,
round(100*sum(ConnectSetupTotalDuration)/decode(sum(AT_ConnectSuccNum+AN_ConnectSuccNum),null,1,0,1,sum(AT_ConnectSuccNum+AN_ConnectSuccNum)),4) ConnectAvgSetupDuration,
--update by zhengting
avg(nvl(ConnectAvgUseDuration,0)) ConnectAvgUseDuration ,
round(100*sum(DRCApplyNum_FwdSpeed1)/decode(sum(DRCApplyNum_FwdSpeed1+DRCApplyNum_FwdSpeed2+DRCApplyNum_FwdSpeed3),null,1,0,1,sum(DRCApplyNum_FwdSpeed1+DRCApplyNum_FwdSpeed2+DRCApplyNum_FwdSpeed3)),4)  DRCApplyRate_FwdSpeed1     ,
round(100*sum(DRCApplyNum_FwdSpeed2)/decode(sum(DRCApplyNum_FwdSpeed1+DRCApplyNum_FwdSpeed2+DRCApplyNum_FwdSpeed3),null,1,0,1,sum(DRCApplyNum_FwdSpeed1+DRCApplyNum_FwdSpeed2+DRCApplyNum_FwdSpeed3)),4)  DRCApplyRate_FwdSpeed2     ,
round(100*sum(DRCApplyNum_FwdSpeed3)/decode(sum(DRCApplyNum_FwdSpeed1+DRCApplyNum_FwdSpeed2+DRCApplyNum_FwdSpeed3),null,1,0,1,sum(DRCApplyNum_FwdSpeed1+DRCApplyNum_FwdSpeed2+DRCApplyNum_FwdSpeed3)),4)  DRCApplyRate_FwdSpeed3     ,
round(100*sum(UATI_AssgnSuccNum)/decode(sum(UATI_AssgnReqNum),0,1,null,1,sum(UATI_AssgnReqNum)),4)  UATI_AssgnSuccRate,
sum(nvl(UATI_AssgnReqNum           ,0))  UATI_AssgnReqNum           ,
sum(nvl(UATI_AssgnSuccNum          ,0))  UATI_AssgnSuccNum          ,
sum(nvl(UATI_AssgnFailNum          ,0))  UATI_AssgnFailNum          ,
sum(nvl(UATI_AvgSetupDuration      ,0))  UATI_AvgSetupDuration      ,
round(100*sum(SessionAuthenticationSNum)/decode(sum(SessionAuthenticationReqNum),null,1,0,1,sum(SessionAuthenticationReqNum)),4)  SessionAuthenticationSRate ,
sum(nvl(SessionAuthenticationSNum  ,0))  SessionAuthenticationSNum  ,
sum(nvl(SessionAuthenticationReqNum,0))  SessionAuthenticationReqNum,
sum(nvl(SessionAuthenticationRejNum,0))  SessionAuthenticationRejNum,
sum(nvl(SessionAuthenticationFNum  ,0))  SessionAuthenticationFNum  ,
round(100*sum(SessionNegoSNum)/decode(sum(SessionNegoSNum+SessionNegoFNum),null,1,0,1,sum(SessionNegoSNum+SessionNegoFNum)),4)  SessionNegoSRate           ,
sum(nvl(SessionNegoSNum            ,0))  SessionNegoSNum            ,
sum(nvl(SessionNegoFNum            ,0))  SessionNegoFNum            ,
round(100*sum(A13_HandoffSNum)/decode(sum(A13_HandoffNum),null,1,0,1,sum(A13_HandoffNum)),4)  A13_HandoffSRate           ,
sum(nvl(A13_HandoffNum             ,0))  A13_HandoffNum             ,
sum(nvl(A13_HandoffSNum            ,0))  A13_HandoffSNum            ,
sum(nvl(SessionNum                 ,0))  SessionNum                 ,
sum(nvl(SessionNum_Active          ,0))  SessionNum_Active          ,
sum(nvl(SessionNum_NotActive       ,0))  SessionNum_NotActive       ,
round(100*sum(AT_DAAcitveSuccNum+AN_DAAcitveSuccNum)/ decode(sum(AT_DAAcitveReqNum+AN_DAAcitveReqNum),null,1,0,1,sum(AT_DAAcitveReqNum+AN_DAAcitveReqNum)),4)  User_DAAcitveSuccRate ,
sum(nvl(User_DAAcitveReqNum        ,0))  User_DAAcitveReqNum        ,
sum(nvl(User_DAAcitveSuccNum       ,0))  User_DAAcitveSuccNum       ,
round(100*sum(AT_DAAcitveSuccNum)/decode(sum(AT_DAAcitveReqNum),null,1,0,1,sum(AT_DAAcitveReqNum)),4)  AT_DAAcitveSuccRate        ,
sum(nvl(AT_DAAcitveReqNum          ,0))  AT_DAAcitveReqNum          ,
sum(nvl(AT_DAAcitveSuccNum         ,0))  AT_DAAcitveSuccNum         ,
sum(nvl(AT_DAAcitveFailNum         ,0))  AT_DAAcitveFailNum         ,
round(100*sum(AN_DAAcitveSuccNum)/decode(sum(AN_DAAcitveReqNum),null,1,0,1,sum(AN_DAAcitveReqNum)),4)  AN_DAAcitveSuccRate        ,
sum(nvl(AN_DAAcitveReqNum          ,0))  AN_DAAcitveReqNum          ,
sum(nvl(AN_DAAcitveSuccNum         ,0))  AN_DAAcitveSuccNum         ,
sum(nvl(AN_DAAcitveFailNum         ,0))  AN_DAAcitveFailNum         ,
sum(nvl(EqlUserNum                 ,0))  EqlUserNum                 ,
sum(nvl(Call_Traffic               ,0))  Call_Traffic               ,
sum(nvl(CE_Traffic                 ,0))  CE_Traffic                 ,
sum(nvl(Sho_Traffic                ,0))  Sho_Traffic                ,
---update by zhengting
avg(Sho_Factor)  Sho_Factor                 ,
sum(nvl(PCFRevDataSize             ,0))  PCFRevDataSize             ,
sum(nvl(PCFFwdDataSize             ,0))  PCFFwdDataSize             ,
sum(nvl(PCFRevPSMsg                ,0))  PCFRevPSMsg                ,
sum(nvl(PCFFwdPSMsg                ,0))  PCFFwdPSMsg                ,
sum(nvl(RevPSDiscardNum            ,0))  RevPSDiscardNum            ,
sum(nvl(FwdPSDiscardNum            ,0))  FwdPSDiscardNum            ,
round(sum(RevPSDiscardNum)/decode(sum(PCFRevPSMsg),null,1,0,1,sum(PCFRevPSMsg)),4)  RevPSDiscardRate           ,
round(sum(FwdPSDiscardNum)/decode(sum(PCFFwdPSMsg),null,1,0,1,sum(PCFFwdPSMsg)),4)  FwdPSDiscardRate           ,
sum(nvl(FwdRLPThroughput           ,0))  FwdRLPThroughput           ,
--update by zhengting
--avg(nvl(FwdRLPRxRate               ,0))  FwdRLPRxRate               ,
round(100*sum(nvl(FwdRxSize,0))/decode(sum(FwdTxSize),0,1,null,1,sum(FwdTxSize)),4) FwdRLPRxRate,
sum(nvl(RevRLPThroughput           ,0))  RevRLPThroughput           ,
round(avg(nvl(RevRLPRxRate               ,0)),4)  RevRLPRxRate               ,
sum(nvl(FwdTCHPhyAvgThroughput     ,0))  FwdTCHPhyAvgThroughput     ,
sum(nvl(FwdTCHPhyOutburstThroughput,0))  FwdTCHPhyOutburstThroughput,
sum(nvl(RevTCHPhyAvgThroughput     ,0))  RevTCHPhyAvgThroughput     ,
sum(nvl(RevTCHPhyOutburstThroughput,0))  RevTCHPhyOutburstThroughput,
round(avg(nvl(FwdTCHPhyTimeSlotUseRate   ,0)),4)  FwdTCHPhyTimeSlotUseRate   ,
round(avg(nvl(FwdCCHPhyTimeSlotUseRate   ,0)),4)  FwdCCHPhyTimeSlotUseRate   ,
round(avg(nvl(RevACHPhySlotUseRate       ,0)),4)  RevACHPhySlotUseRate       ,
round(100*sum(RABBusyNum)/decode(sum(RABBusyNum+RABFreeNum),null,1,0,1,sum(RABBusyNum+RABFreeNum)),4)  RevCircuitBusyRate         ,
round(100*sum(GlobalSHoSuccNum)/decode(sum(GlobalSHoReqNum),0,1,null,1,sum(GlobalSHoReqNum)),4)  GlobalSHoSuccRate          ,
sum(nvl(GlobalSHoReqNum            ,0))  GlobalSHoReqNum            ,
sum(nvl(GlobalSHoSuccNum           ,0))  GlobalSHoSuccNum           ,
round(sum(SHoSuccNum_intraAN)/decode(sum(SHoReqNum_intraAN),null,1,0,1,sum(SHoReqNum_intraAN)),4)  SHoSuccRate_intraAN        ,
sum(nvl(SHoReqNum_intraAN          ,0))  SHoReqNum_intraAN          ,
sum(nvl(SHoSuccNum_intraAN         ,0))  SHoSuccNum_intraAN         ,
round(sum(SHoSuccNum_amongAN)/decode(sum(SHoReqNum_amongAN),null,1,0,1,sum(SHoReqNum_amongAN)),4)  SHoSuccRate_amongAN        ,
sum(nvl(SHoReqNum_amongAN          ,0))  SHoReqNum_amongAN          ,
sum(nvl(SHoSuccNum_amongAN         ,0))  SHoSuccNum_amongAN         ,
round(100*sum(HardHoSuccNum_intraAN)/decode(sum(HardHoReqNum_intraAN),null,1,0,1,sum(HardHoReqNum_intraAN)),4)  HardHoSuccRate_intraAN     ,
sum(nvl(HardHoReqNum_intraAN       ,0))  HardHoReqNum_intraAN       ,
sum(nvl(HardHoSuccNum_intraAN      ,0))  HardHoSuccNum_intraAN      ,
round(sum(HardHoSuccNum_amongAN)/decode(sum(HardHoReqNum_amongAN),null,1,0,1,sum(HardHoReqNum_amongAN)),4)  HardHoSuccRate_amongAN     ,
sum(nvl(HardHoReqNum_amongAN       ,0))  HardHoReqNum_amongAN       ,
sum(nvl(HardHoSuccNum_amongAN      ,0))  HardHoSuccNum_amongAN      ,
round(100*sum(PageResponceNum)/decode(sum(PageReqNum),null,1,0,1,sum(PageReqNum)),4)  PageResponceRate           ,
sum(nvl(PageReqNum                 ,0))  PageReqNum                 ,
sum(nvl(PageResponceNum            ,0))  PageResponceNum            ,
sum(nvl(DOCarrier37                ,0))  DOCarrier37                ,
sum(nvl(DOCarrier78                ,0))  DOCarrier78                ,
sum(nvl(DOCarrier119               ,0))  DOCarrier119               ,
sum(nvl(DOCarrierTotalNum          ,0))  DOCarrierTotalNum          ,
sum(nvl(DOCarrier37Traffic         ,0))  DOCarrier37Traffic         ,
sum(nvl(DOCarrier78Traffic         ,0))  DOCarrier78Traffic         ,
sum(nvl(DOCarrier119Traffic        ,0))  DOCarrier119Traffic        ,
sum(nvl(OneDOCarrierCellNum        ,0))  OneDOCarrierCellNum        ,
sum(nvl(TwoDOCarrierCellNum        ,0))  TwoDOCarrierCellNum        ,
sum(nvl(ThreeDOCarrierCellNum      ,0))  ThreeDOCarrierCellNum      ,
sum(nvl(DOCellNum                  ,0))  DOCellNum                  ,
sum(nvl(ConnectSetupTotalDuration  ,0))  ConnectSetupTotalDuration  ,
sum(nvl(ConnectUseTotalDuration    ,0))  ConnectUseTotalDuration    ,
sum(nvl(SessionSetupTotalDuration  ,0))  SessionSetupTotalDuration  ,
sum(nvl(FwdRxSize                  ,0))  FwdRxSize                  ,
sum(nvl(FwdTxSize                  ,0))  FwdTxSize                  ,
sum(nvl(RevRxSize                  ,0))  RevRxSize                  ,
sum(nvl(RevTxSize                  ,0))  RevTxSize                  ,
sum(nvl(RABBusyNum                 ,0))  RABBusyNum                 ,
sum(nvl(RABFreeNum                 ,0))  RABFreeNum                 ,
sum(nvl(FwdAvailNum_MacIndex       ,0))  FwdAvailNum_MacIndex       ,
sum(nvl(DRCApplyNum_FwdSpeed1      ,0))  DRCApplyNum_FwdSpeed1      ,
sum(nvl(DRCApplyNum_FwdSpeed2      ,0))  DRCApplyNum_FwdSpeed2      ,
sum(nvl(DRCApplyNum_FwdSpeed3      ,0))  DRCApplyNum_FwdSpeed3      ,
sum(nvl(FwdTCHPhyTxBitNum          ,0))  FwdTCHPhyTxBitNum          ,
sum(nvl(FwdPhyUseTimeSlotDuration  ,0))  FwdPhyUseTimeSlotDuration  ,
sum(nvl(RevTCHPhyTxBitNum          ,0))  RevTCHPhyTxBitNum          ,
sum(nvl(RevPhyUseTimeSlotDuration  ,0))  RevPhyUseTimeSlotDuration
from c_perf_do_sum
where scan_start_time = v_date and vendor_id in (7,8,10) and sum_level=0 and ne_type=10000
group by int_id,ne_type) t
on(c_perf.int_id = t.int_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10000 and c_perf.sum_level=0 and c_perf.vendor_id=99)
when matched then update set
BtsTotalNum                 = t.BtsTotalNum                 ,
OnecarrierBtsNum            = t.OnecarrierBtsNum            ,
TwocarrierBtsNum            = t.TwocarrierBtsNum            ,
threecarrierBtsNum          = t.threecarrierBtsNum          ,
FourcarrierBtsNum           = t.FourcarrierBtsNum           ,
CarrierCellNum              = t.CarrierCellNum              ,
RevCEMaxUseRate             = t.RevCEMaxUseRate             ,
RevCEMaxBusyNum             = t.RevCEMaxBusyNum             ,
RevCEAvailNum               = t.RevCEAvailNum               ,
FwdMaxUseRate_MacIndex      = t.FwdMaxUseRate_MacIndex      ,
FwdMaxBusyNum_MacIndex      = t.FwdMaxBusyNum_MacIndex      ,
PCFNum                      = t.PCFNum                      ,
PCFMeanCpuAvgLoad           = t.PCFMeanCpuAvgLoad           ,
PCFMaxHRPDSessionNum        = t.PCFMaxHRPDSessionNum        ,
PCFMaxActiveHRPDSessionNum  = t.PCFMaxActiveHRPDSessionNum  ,
PCFUplinkThroughputRate     = t.PCFUplinkThroughputRate     ,
PCFDownlinkThroughputRate   = t.PCFDownlinkThroughputRate   ,
ABisBWAvgUseRate            = t.ABisBWAvgUseRate            ,
AbisPortBandWidth           = t.AbisPortBandWidth           ,
AbisAvgUseBandWidth         = t.AbisAvgUseBandWidth         ,
BusyerBtsNum                = t.BusyerBtsNum                ,
FreeBtsNum                  = t.FreeBtsNum                  ,
WireConnectSuccRate         = t.WireConnectSuccRate         ,
AT_ConnectSuccRate          = t.AT_ConnectSuccRate          ,
AN_ConnectSuccRate          = t.AN_ConnectSuccRate          ,
AT_ConnectReqNum            = t.AT_ConnectReqNum            ,
AN_ConnectReqNum            = t.AN_ConnectReqNum            ,
AT_ConnectSuccNum           = t.AT_ConnectSuccNum           ,
AN_ConnectSuccNum           = t.AN_ConnectSuccNum           ,
WireConnectSuccRateInA8A10  = t.WireConnectSuccRateInA8A10  ,
WireConnectSuccNumInA8A10   = t.WireConnectSuccNumInA8A10   ,
WireConnectReqNumInA8A10    = t.WireConnectReqNumInA8A10    ,
UserEarlyReleaseRate        = t.UserEarlyReleaseRate        ,
UserEarlyReleaseNum         = t.UserEarlyReleaseNum         ,
WireConnectFailNum1         = t.WireConnectFailNum1         ,
WireConnectFailNum2         = t.WireConnectFailNum2         ,
WireConnectFailNum3         = t.WireConnectFailNum3         ,
WireConnectReleaseNumInPDSN = t.WireConnectReleaseNumInPDSN ,
WireConnectReleaseNumExPDSN = t.WireConnectReleaseNumExPDSN ,
ReleaseNumByPDSN            = t.ReleaseNumByPDSN            ,
WireRadioFNum1              = t.WireRadioFNum1              ,
WireRadioFNum2              = t.WireRadioFNum2              ,
WireRadioFNum3              = t.WireRadioFNum3              ,
WireRadioFRate              = t.WireRadioFRate              ,
NetWorkRadioFRate           = t.NetWorkRadioFRate           ,
ConnectAvgSetupDuration     = t.ConnectAvgSetupDuration     ,
ConnectAvgUseDuration       = t.ConnectAvgUseDuration       ,
DRCApplyRate_FwdSpeed1      = t.DRCApplyRate_FwdSpeed1      ,
DRCApplyRate_FwdSpeed2      = t.DRCApplyRate_FwdSpeed2      ,
DRCApplyRate_FwdSpeed3      = t.DRCApplyRate_FwdSpeed3      ,
UATI_AssgnSuccRate          = t.UATI_AssgnSuccRate          ,
UATI_AssgnReqNum            = t.UATI_AssgnReqNum            ,
UATI_AssgnSuccNum           = t.UATI_AssgnSuccNum           ,
UATI_AssgnFailNum           = t.UATI_AssgnFailNum           ,
UATI_AvgSetupDuration       = t.UATI_AvgSetupDuration       ,
SessionAuthenticationSRate  = t.SessionAuthenticationSRate  ,
SessionAuthenticationSNum   = t.SessionAuthenticationSNum   ,
SessionAuthenticationReqNum = t.SessionAuthenticationReqNum ,
SessionAuthenticationRejNum = t.SessionAuthenticationRejNum ,
SessionAuthenticationFNum   = t.SessionAuthenticationFNum   ,
SessionNegoSRate            = t.SessionNegoSRate            ,
SessionNegoSNum             = t.SessionNegoSNum             ,
SessionNegoFNum             = t.SessionNegoFNum             ,
A13_HandoffSRate            = t.A13_HandoffSRate            ,
A13_HandoffNum              = t.A13_HandoffNum              ,
A13_HandoffSNum             = t.A13_HandoffSNum             ,
SessionNum                  = t.SessionNum                  ,
SessionNum_Active           = t.SessionNum_Active           ,
SessionNum_NotActive        = t.SessionNum_NotActive        ,
User_DAAcitveSuccRate       = t.User_DAAcitveSuccRate       ,
User_DAAcitveReqNum         = t.User_DAAcitveReqNum         ,
User_DAAcitveSuccNum        = t.User_DAAcitveSuccNum        ,
AT_DAAcitveSuccRate         = t.AT_DAAcitveSuccRate         ,
AT_DAAcitveReqNum           = t.AT_DAAcitveReqNum           ,
AT_DAAcitveSuccNum          = t.AT_DAAcitveSuccNum          ,
AT_DAAcitveFailNum          = t.AT_DAAcitveFailNum          ,
AN_DAAcitveSuccRate         = t.AN_DAAcitveSuccRate         ,
AN_DAAcitveReqNum           = t.AN_DAAcitveReqNum           ,
AN_DAAcitveSuccNum          = t.AN_DAAcitveSuccNum          ,
AN_DAAcitveFailNum          = t.AN_DAAcitveFailNum          ,
EqlUserNum                  = t.EqlUserNum                  ,
Call_Traffic                = t.Call_Traffic                ,
CE_Traffic                  = t.CE_Traffic                  ,
Sho_Traffic                 = t.Sho_Traffic                 ,
Sho_Factor                  = t.Sho_Factor                  ,
PCFRevDataSize              = t.PCFRevDataSize              ,
PCFFwdDataSize              = t.PCFFwdDataSize              ,
PCFRevPSMsg                 = t.PCFRevPSMsg                 ,
PCFFwdPSMsg                 = t.PCFFwdPSMsg                 ,
RevPSDiscardNum             = t.RevPSDiscardNum             ,
FwdPSDiscardNum             = t.FwdPSDiscardNum             ,
RevPSDiscardRate            = t.RevPSDiscardRate            ,
FwdPSDiscardRate            = t.FwdPSDiscardRate            ,
FwdRLPThroughput            = t.FwdRLPThroughput            ,
FwdRLPRxRate                = t.FwdRLPRxRate                ,
RevRLPThroughput            = t.RevRLPThroughput            ,
RevRLPRxRate                = t.RevRLPRxRate                ,
FwdTCHPhyAvgThroughput      = t.FwdTCHPhyAvgThroughput      ,
FwdTCHPhyOutburstThroughput = t.FwdTCHPhyOutburstThroughput ,
RevTCHPhyAvgThroughput      = t.RevTCHPhyAvgThroughput      ,
RevTCHPhyOutburstThroughput = t.RevTCHPhyOutburstThroughput ,
FwdTCHPhyTimeSlotUseRate    = t.FwdTCHPhyTimeSlotUseRate    ,
FwdCCHPhyTimeSlotUseRate    = t.FwdCCHPhyTimeSlotUseRate    ,
RevACHPhySlotUseRate        = t.RevACHPhySlotUseRate        ,
RevCircuitBusyRate          = t.RevCircuitBusyRate          ,
GlobalSHoSuccRate           = t.GlobalSHoSuccRate           ,
GlobalSHoReqNum             = t.GlobalSHoReqNum             ,
GlobalSHoSuccNum            = t.GlobalSHoSuccNum            ,
SHoSuccRate_intraAN         = t.SHoSuccRate_intraAN         ,
SHoReqNum_intraAN           = t.SHoReqNum_intraAN           ,
SHoSuccNum_intraAN          = t.SHoSuccNum_intraAN          ,
SHoSuccRate_amongAN         = t.SHoSuccRate_amongAN         ,
SHoReqNum_amongAN           = t.SHoReqNum_amongAN           ,
SHoSuccNum_amongAN          = t.SHoSuccNum_amongAN          ,
HardHoSuccRate_intraAN      = t.HardHoSuccRate_intraAN      ,
HardHoReqNum_intraAN        = t.HardHoReqNum_intraAN        ,
HardHoSuccNum_intraAN       = t.HardHoSuccNum_intraAN       ,
HardHoSuccRate_amongAN      = t.HardHoSuccRate_amongAN      ,
HardHoReqNum_amongAN        = t.HardHoReqNum_amongAN        ,
HardHoSuccNum_amongAN       = t.HardHoSuccNum_amongAN       ,
PageResponceRate            = t.PageResponceRate            ,
PageReqNum                  = t.PageReqNum                  ,
PageResponceNum             = t.PageResponceNum             ,
DOCarrier37                 = t.DOCarrier37                 ,
DOCarrier78                 = t.DOCarrier78                 ,
DOCarrier119                = t.DOCarrier119                ,
DOCarrierTotalNum           = t.DOCarrierTotalNum           ,
DOCarrier37Traffic          = t.DOCarrier37Traffic          ,
DOCarrier78Traffic          = t.DOCarrier78Traffic          ,
DOCarrier119Traffic         = t.DOCarrier119Traffic         ,
OneDOCarrierCellNum         = t.OneDOCarrierCellNum         ,
TwoDOCarrierCellNum         = t.TwoDOCarrierCellNum         ,
ThreeDOCarrierCellNum       = t.ThreeDOCarrierCellNum       ,
DOCellNum                   = t.DOCellNum                   ,
ConnectSetupTotalDuration   = t.ConnectSetupTotalDuration   ,
ConnectUseTotalDuration     = t.ConnectUseTotalDuration     ,
SessionSetupTotalDuration   = t.SessionSetupTotalDuration   ,
FwdRxSize                   = t.FwdRxSize                   ,
FwdTxSize                   = t.FwdTxSize                   ,
RevRxSize                   = t.RevRxSize                   ,
RevTxSize                   = t.RevTxSize                   ,
RABBusyNum                  = t.RABBusyNum                  ,
RABFreeNum                  = t.RABFreeNum                  ,
FwdAvailNum_MacIndex        = t.FwdAvailNum_MacIndex        ,
DRCApplyNum_FwdSpeed1       = t.DRCApplyNum_FwdSpeed1       ,
DRCApplyNum_FwdSpeed2       = t.DRCApplyNum_FwdSpeed2       ,
DRCApplyNum_FwdSpeed3       = t.DRCApplyNum_FwdSpeed3       ,
FwdTCHPhyTxBitNum           = t.FwdTCHPhyTxBitNum           ,
FwdPhyUseTimeSlotDuration   = t.FwdPhyUseTimeSlotDuration   ,
RevTCHPhyTxBitNum           = t.RevTCHPhyTxBitNum           ,
RevPhyUseTimeSlotDuration   = t.RevPhyUseTimeSlotDuration
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
BtsTotalNum                 ,
OnecarrierBtsNum            ,
TwocarrierBtsNum            ,
threecarrierBtsNum          ,
FourcarrierBtsNum           ,
CarrierCellNum              ,
RevCEMaxUseRate             ,
RevCEMaxBusyNum             ,
RevCEAvailNum               ,
FwdMaxUseRate_MacIndex      ,
FwdMaxBusyNum_MacIndex      ,
PCFNum                      ,
PCFMeanCpuAvgLoad           ,
PCFMaxHRPDSessionNum        ,
PCFMaxActiveHRPDSessionNum  ,
PCFUplinkThroughputRate     ,
PCFDownlinkThroughputRate   ,
ABisBWAvgUseRate            ,
AbisPortBandWidth           ,
AbisAvgUseBandWidth         ,
BusyerBtsNum                ,
FreeBtsNum                  ,
WireConnectSuccRate         ,
AT_ConnectSuccRate          ,
AN_ConnectSuccRate          ,
AT_ConnectReqNum            ,
AN_ConnectReqNum            ,
AT_ConnectSuccNum           ,
AN_ConnectSuccNum           ,
WireConnectSuccRateInA8A10  ,
WireConnectSuccNumInA8A10   ,
WireConnectReqNumInA8A10    ,
UserEarlyReleaseRate        ,
UserEarlyReleaseNum         ,
WireConnectFailNum1         ,
WireConnectFailNum2         ,
WireConnectFailNum3         ,
WireConnectReleaseNumInPDSN ,
WireConnectReleaseNumExPDSN ,
ReleaseNumByPDSN            ,
WireRadioFNum1              ,
WireRadioFNum2              ,
WireRadioFNum3              ,
WireRadioFRate              ,
NetWorkRadioFRate           ,
ConnectAvgSetupDuration     ,
ConnectAvgUseDuration       ,
DRCApplyRate_FwdSpeed1      ,
DRCApplyRate_FwdSpeed2      ,
DRCApplyRate_FwdSpeed3      ,
UATI_AssgnSuccRate          ,
UATI_AssgnReqNum            ,
UATI_AssgnSuccNum           ,
UATI_AssgnFailNum           ,
UATI_AvgSetupDuration       ,
SessionAuthenticationSRate  ,
SessionAuthenticationSNum   ,
SessionAuthenticationReqNum ,
SessionAuthenticationRejNum ,
SessionAuthenticationFNum   ,
SessionNegoSRate            ,
SessionNegoSNum             ,
SessionNegoFNum             ,
A13_HandoffSRate            ,
A13_HandoffNum              ,
A13_HandoffSNum             ,
SessionNum                  ,
SessionNum_Active           ,
SessionNum_NotActive        ,
User_DAAcitveSuccRate       ,
User_DAAcitveReqNum         ,
User_DAAcitveSuccNum        ,
AT_DAAcitveSuccRate         ,
AT_DAAcitveReqNum           ,
AT_DAAcitveSuccNum          ,
AT_DAAcitveFailNum          ,
AN_DAAcitveSuccRate         ,
AN_DAAcitveReqNum           ,
AN_DAAcitveSuccNum          ,
AN_DAAcitveFailNum          ,
EqlUserNum                  ,
Call_Traffic                ,
CE_Traffic                  ,
Sho_Traffic                 ,
Sho_Factor                  ,
PCFRevDataSize              ,
PCFFwdDataSize              ,
PCFRevPSMsg                 ,
PCFFwdPSMsg                 ,
RevPSDiscardNum             ,
FwdPSDiscardNum             ,
RevPSDiscardRate            ,
FwdPSDiscardRate            ,
FwdRLPThroughput            ,
FwdRLPRxRate                ,
RevRLPThroughput            ,
RevRLPRxRate                ,
FwdTCHPhyAvgThroughput      ,
FwdTCHPhyOutburstThroughput ,
RevTCHPhyAvgThroughput      ,
RevTCHPhyOutburstThroughput ,
FwdTCHPhyTimeSlotUseRate    ,
FwdCCHPhyTimeSlotUseRate    ,
RevACHPhySlotUseRate        ,
RevCircuitBusyRate          ,
GlobalSHoSuccRate           ,
GlobalSHoReqNum             ,
GlobalSHoSuccNum            ,
SHoSuccRate_intraAN         ,
SHoReqNum_intraAN           ,
SHoSuccNum_intraAN          ,
SHoSuccRate_amongAN         ,
SHoReqNum_amongAN           ,
SHoSuccNum_amongAN          ,
HardHoSuccRate_intraAN      ,
HardHoReqNum_intraAN        ,
HardHoSuccNum_intraAN       ,
HardHoSuccRate_amongAN      ,
HardHoReqNum_amongAN        ,
HardHoSuccNum_amongAN       ,
PageResponceRate            ,
PageReqNum                  ,
PageResponceNum             ,
DOCarrier37                 ,
DOCarrier78                 ,
DOCarrier119                ,
DOCarrierTotalNum           ,
DOCarrier37Traffic          ,
DOCarrier78Traffic          ,
DOCarrier119Traffic         ,
OneDOCarrierCellNum         ,
TwoDOCarrierCellNum         ,
ThreeDOCarrierCellNum       ,
DOCellNum                   ,
ConnectSetupTotalDuration   ,
ConnectUseTotalDuration     ,
SessionSetupTotalDuration   ,
FwdRxSize                   ,
FwdTxSize                   ,
RevRxSize                   ,
RevTxSize                   ,
RABBusyNum                  ,
RABFreeNum                  ,
FwdAvailNum_MacIndex        ,
DRCApplyNum_FwdSpeed1       ,
DRCApplyNum_FwdSpeed2       ,
DRCApplyNum_FwdSpeed3       ,
FwdTCHPhyTxBitNum           ,
FwdPhyUseTimeSlotDuration   ,
RevTCHPhyTxBitNum           ,
RevPhyUseTimeSlotDuration
)
values(
t.int_id,
v_date,
0,
10000,
99,
t.BtsTotalNum                 ,
t.OnecarrierBtsNum            ,
t.TwocarrierBtsNum            ,
t.threecarrierBtsNum          ,
t.FourcarrierBtsNum           ,
t.CarrierCellNum              ,
t.RevCEMaxUseRate             ,
t.RevCEMaxBusyNum             ,
t.RevCEAvailNum               ,
t.FwdMaxUseRate_MacIndex      ,
t.FwdMaxBusyNum_MacIndex      ,
t.PCFNum                      ,
t.PCFMeanCpuAvgLoad           ,
t.PCFMaxHRPDSessionNum        ,
t.PCFMaxActiveHRPDSessionNum  ,
t.PCFUplinkThroughputRate     ,
t.PCFDownlinkThroughputRate   ,
t.ABisBWAvgUseRate            ,
t.AbisPortBandWidth           ,
t.AbisAvgUseBandWidth         ,
t.BusyerBtsNum                ,
t.FreeBtsNum                  ,
t.WireConnectSuccRate         ,
t.AT_ConnectSuccRate          ,
t.AN_ConnectSuccRate          ,
t.AT_ConnectReqNum            ,
t.AN_ConnectReqNum            ,
t.AT_ConnectSuccNum           ,
t.AN_ConnectSuccNum           ,
t.WireConnectSuccRateInA8A10  ,
t.WireConnectSuccNumInA8A10   ,
t.WireConnectReqNumInA8A10    ,
t.UserEarlyReleaseRate        ,
t.UserEarlyReleaseNum         ,
t.WireConnectFailNum1         ,
t.WireConnectFailNum2         ,
t.WireConnectFailNum3         ,
t.WireConnectReleaseNumInPDSN ,
t.WireConnectReleaseNumExPDSN ,
t.ReleaseNumByPDSN            ,
t.WireRadioFNum1              ,
t.WireRadioFNum2              ,
t.WireRadioFNum3              ,
t.WireRadioFRate              ,
t.NetWorkRadioFRate           ,
t.ConnectAvgSetupDuration     ,
t.ConnectAvgUseDuration       ,
t.DRCApplyRate_FwdSpeed1      ,
t.DRCApplyRate_FwdSpeed2      ,
t.DRCApplyRate_FwdSpeed3      ,
t.UATI_AssgnSuccRate          ,
t.UATI_AssgnReqNum            ,
t.UATI_AssgnSuccNum           ,
t.UATI_AssgnFailNum           ,
t.UATI_AvgSetupDuration       ,
t.SessionAuthenticationSRate  ,
t.SessionAuthenticationSNum   ,
t.SessionAuthenticationReqNum ,
t.SessionAuthenticationRejNum ,
t.SessionAuthenticationFNum   ,
t.SessionNegoSRate            ,
t.SessionNegoSNum             ,
t.SessionNegoFNum             ,
t.A13_HandoffSRate            ,
t.A13_HandoffNum              ,
t.A13_HandoffSNum             ,
t.SessionNum                  ,
t.SessionNum_Active           ,
t.SessionNum_NotActive        ,
t.User_DAAcitveSuccRate       ,
t.User_DAAcitveReqNum         ,
t.User_DAAcitveSuccNum        ,
t.AT_DAAcitveSuccRate         ,
t.AT_DAAcitveReqNum           ,
t.AT_DAAcitveSuccNum          ,
t.AT_DAAcitveFailNum          ,
t.AN_DAAcitveSuccRate         ,
t.AN_DAAcitveReqNum           ,
t.AN_DAAcitveSuccNum          ,
t.AN_DAAcitveFailNum          ,
t.EqlUserNum                  ,
t.Call_Traffic                ,
t.CE_Traffic                  ,
t.Sho_Traffic                 ,
t.Sho_Factor                  ,
t.PCFRevDataSize              ,
t.PCFFwdDataSize              ,
t.PCFRevPSMsg                 ,
t.PCFFwdPSMsg                 ,
t.RevPSDiscardNum             ,
t.FwdPSDiscardNum             ,
t.RevPSDiscardRate            ,
t.FwdPSDiscardRate            ,
t.FwdRLPThroughput            ,
t.FwdRLPRxRate                ,
t.RevRLPThroughput            ,
t.RevRLPRxRate                ,
t.FwdTCHPhyAvgThroughput      ,
t.FwdTCHPhyOutburstThroughput ,
t.RevTCHPhyAvgThroughput      ,
t.RevTCHPhyOutburstThroughput ,
t.FwdTCHPhyTimeSlotUseRate    ,
t.FwdCCHPhyTimeSlotUseRate    ,
t.RevACHPhySlotUseRate        ,
t.RevCircuitBusyRate          ,
t.GlobalSHoSuccRate           ,
t.GlobalSHoReqNum             ,
t.GlobalSHoSuccNum            ,
t.SHoSuccRate_intraAN         ,
t.SHoReqNum_intraAN           ,
t.SHoSuccNum_intraAN          ,
t.SHoSuccRate_amongAN         ,
t.SHoReqNum_amongAN           ,
t.SHoSuccNum_amongAN          ,
t.HardHoSuccRate_intraAN      ,
t.HardHoReqNum_intraAN        ,
t.HardHoSuccNum_intraAN       ,
t.HardHoSuccRate_amongAN      ,
t.HardHoReqNum_amongAN        ,
t.HardHoSuccNum_amongAN       ,
t.PageResponceRate            ,
t.PageReqNum                  ,
t.PageResponceNum             ,
t.DOCarrier37                 ,
t.DOCarrier78                 ,
t.DOCarrier119                ,
t.DOCarrierTotalNum           ,
t.DOCarrier37Traffic          ,
t.DOCarrier78Traffic          ,
t.DOCarrier119Traffic         ,
t.OneDOCarrierCellNum         ,
t.TwoDOCarrierCellNum         ,
t.ThreeDOCarrierCellNum       ,
t.DOCellNum                   ,
t.ConnectSetupTotalDuration   ,
t.ConnectUseTotalDuration     ,
t.SessionSetupTotalDuration   ,
t.FwdRxSize                   ,
t.FwdTxSize                   ,
t.RevRxSize                   ,
t.RevTxSize                   ,
t.RABBusyNum                  ,
t.RABFreeNum                  ,
t.FwdAvailNum_MacIndex        ,
t.DRCApplyNum_FwdSpeed1       ,
t.DRCApplyNum_FwdSpeed2       ,
t.DRCApplyNum_FwdSpeed3       ,
t.FwdTCHPhyTxBitNum           ,
t.FwdPhyUseTimeSlotDuration   ,
t.RevTCHPhyTxBitNum           ,
t.RevPhyUseTimeSlotDuration );
commit;

/*delete                   --20120329
from  c_perf_do_sum  c_perf
where  c_perf.vendor_id  in(7,10)
and    c_perf.ne_type = 10000
and    c_perf.scan_start_time = v_date;
commit;*/

exception when others then
s_error := sqlerrm;
rollback;
insert into job_log values(sysdate,'c_perf_do_sum_lc_cell',s_error);
commit;


end;
