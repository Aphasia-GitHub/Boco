create or replace procedure proc_c_perf_do_sum_lc(p_date date)
as
v_date date;
s_error varchar2(4000);

begin
--if null then v_date = sysdate-3 (3hours before) else v_date = p_date
select trunc(decode(p_date,null,trunc(sysdate-5/24,'hh24'),p_date),'hh24') into v_date from dual;
--c_tpd_carr_do_ag_lc a,c_tpd_carr_do_lc b,c_carrier c,c_tpd_evm_do_lc d
--ne_type =101(msc) sum_level=0
--由a实现

merge into c_perf_do_sum c_perf
using(
select
c.related_msc related_msc,

--2011-11-04
--modify-225-226--by zhengting 20111109
round(sum(nvl(a.Hdr293,0)+nvl(a.Hdr292,0)-nvl(a.hdr311,0))/
decode(sum(nvl(a.Hdr225,0)+nvl(a.Hdr226,0)-nvl(a.hdr310,0)),0,1,null,1,sum(nvl(a.Hdr225,0)+nvl(a.Hdr226,0)-nvl(a.hdr310,0)))*100,4) WireConnectSuccRate,
round(sum(nvl(a.Hdr293,0))/
decode(sum(nvl(a.Hdr225,0)-nvl(a.Hdr509,0)-nvl(a.Hdr306,0)+nvl(a.Hdr304,0)),0,1,null,1,sum(nvl(a.Hdr225,0)-nvl(a.Hdr509,0)-nvl(a.Hdr306,0)+nvl(a.Hdr304,0)))*100,4) AT_ConnectSuccRate,
round(sum(nvl(a.Hdr292,0))/
decode(sum(nvl(a.Hdr226,0)-nvl(a.Hdr510,0)-nvl(a.Hdr307,0)+nvl(a.Hdr305,0)),0,1,null,1,sum(nvl(a.Hdr226,0)-nvl(a.Hdr510,0)-nvl(a.Hdr307,0)+nvl(a.Hdr305,0)))*100,4) AN_ConnectSuccRate,
sum(nvl(a.Hdr226,0)-nvl(hdr310,0))  AT_ConnectReqNum,
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
sum(nvl(a.Hdr233,0)-nvl(a.Hdr316,0)-nvl(Hdr318,0)-nvl(a.Hdr244,0)-(nvl(a.Hdr235,0)+nvl(a.Hdr236,0)+nvl(a.Hdr052,0)+nvl(a.Hdr053,0))) GlobalSHoSuccNum,
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

round(100*sum(nvl(a.Hdr233,0)-nvl(a.Hdr316,0)-nvl(Hdr318,0)-nvl(a.Hdr244,0)-(nvl(a.Hdr235,0)+nvl(a.Hdr236,0)+nvl(a.Hdr052,0)+nvl(a.Hdr053,0)))/
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
--add-2011-9-14
--UATI_AssgnFailNum
--sum(a.Hdr238+a.Hdr237+a.Hdr373-(a.Hdr247+a.Hdr271+a.Hdr376)) UATI_AssgnFailNum
from c_tpd_carr_do_ag_lc a,c_carrier c
where a.int_id = c.int_id
and a.scan_start_time = v_date
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
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
--UATI_AssgnFailNum=t.UATI_AssgnFailNum
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
--UATI_AssgnFailNum
)
---------------------------
values(
t.related_msc,
v_date,
0,
101,
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
--t.UATI_AssgnFailNum
);

commit;




--由b实现
merge into c_perf_do_sum c_perf
using(
select
c.related_msc related_msc,
------------2010-08-19------
sum(nvl(EVMACTIVEUSAGE,0))*0.001667/3600  EqlUserNum,
sum(nvl(EVMDRCRATE_0,0)+nvl(EVMDRCRATE_38_4,0)+nvl(EVMDRCRATE_76_8,0)+nvl(EVMDRCRATE_153_6,0)) DRCApplyNum_FwdSpeed1,
sum(nvl(EVMDRCRATE_307_2,0)+nvl(EVMDRCRATE_307_2_L,0)+nvl(EVMDRCRATE_614_4,0)+nvl(EVMDRCRATE_614_4_L,0)+nvl(EVMDRCRATE_921_6,0)+nvl(EVMDRCRATE_1228_8,0)+nvl(EVMDRCRATE_1228_8_L,0)) DRCApplyNum_FwdSpeed2,
sum(nvl(EVMDRCRATE_1536,0)+nvl(EVMDRCRATE_1843_2,0)+nvl(EVMDRCRATE_2457_6,0)+nvl(EVMDRCRATE_3072,0)) DRCApplyNum_FwdSpeed3,
sum(nvl(EVMFTCTOTBYTES_4_8,0)+nvl(EVMFTCTOTBYTES_9_6,0)   +nvl(EVMFTCTOTBYTES_19_2,0) +
nvl(EVMFTCTOTBYTES_38_4,0)   +nvl(EVMFTCTOTBYTES_76_8,0)  +nvl(EVMFTCTOTBYTES_153_6,0) +nvl(EVMFTCTOTBYTES_307_2,0) +
nvl(EVMFTCTOTBYTES_614_4,0)  +nvl(EVMFTCTOTBYTES_921_6,0) +nvl(EVMFTCTOTBYTES_1228_8,0)+nvl(EVMFTCTOTBYTES_1536,0)  +
nvl(EVMFTCTOTBYTES_1843_2,0) +nvl(EVMFTCTOTBYTES_2457_6,0)+nvl(EVMFTCTOTBYTES_3072,0))*8 FwdTCHPhyTxBitNum,
(avg(nvl(EVMFTCNUMSLOT_4_8,0)+nvl(EVMFTCNUMSLOT_9_6,0)   +nvl(EVMFTCNUMSLOT_19_2,0) +
nvl(EVMFTCNUMSLOT_38_4,0)   +nvl(EVMFTCNUMSLOT_76_8,0)  +nvl(EVMFTCNUMSLOT_153_6,0) +nvl(EVMFTCNUMSLOT_307_2,0) +
nvl(EVMFTCNUMSLOT_614_4,0)  +nvl(EVMFTCNUMSLOT_921_6,0) +nvl(EVMFTCNUMSLOT_1228_8,0)+nvl(EVMFTCNUMSLOT_1536,0)  +
nvl(EVMFTCNUMSLOT_1843_2,0) +nvl(EVMFTCNUMSLOT_2457_6,0)+nvl(EVMFTCNUMSLOT_3072,0))*0.001667)/3600 FwdPhyUseTimeSlotDuration,
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
--update-2011-9-14
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
----sum(nvl(b.EVMFTCTOTBYTES_4_8,0)
----+nvl(b.EVMFTCTOTBYTES_9_6,0)
----+nvl(b.EVMFTCTOTBYTES_19_2,0)
----+nvl(b.EVMFTCTOTBYTES_38_4,0)
----+nvl(b.EVMFTCTOTBYTES_76_8,0)
----+nvl(b.EVMFTCTOTBYTES_153_6,0)
----+nvl(b.EVMFTCTOTBYTES_307_2,0)
----+nvl(b.EVMFTCTOTBYTES_614_4,0)
----+nvl(b.EVMFTCTOTBYTES_921_6,0)
----+nvl(b.EVMFTCTOTBYTES_1228_8,0)
----+nvl(b.EVMFTCTOTBYTES_1536,0)
----+nvl(b.EVMFTCTOTBYTES_1843_2,0)
----+nvl(b.EVMFTCTOTBYTES_2457_6,0)
----+nvl(b.EVMFTCTOTBYTES_3072,0)*8/1000)
------update-2011-9-14
----/decode(sum((nvl(b.EVM_FTC_NUM_SLOT_4_8,0)
----+nvl(b.EVM_FTC_NUM_SLOT_9_6,0)
----+nvl(b.EVM_FTC_NUM_SLOT_19_2,0)
----+nvl(b.EVM_FTC_NUM_SLOT_38_4,0)
----+nvl(b.EVM_FTC_NUM_SLOT_76_8,0)
----+nvl(b.EVM_FTC_NUM_SLOT_153_6,0)
----+nvl(b.EVM_FTC_NUM_SLOT_307_2,0)
----+nvl(b.EVM_FTC_NUM_SLOT_614_4,0)
----+nvl(b.EVM_FTC_NUM_SLOT_921_6,0)
----+nvl(b.EVM_FTC_NUM_SLOT_1228_8,0)
----+nvl(b.EVM_FTC_NUM_SLOT_1536,0)
----+nvl(b.EVM_FTC_NUM_SLOT_1843_2,0)
----+nvl(b.EVM_FTC_NUM_SLOT_2457_6,0)
----+nvl(b.EVM_FTC_NUM_SLOT_3072,0))*0.001667),0,1,null,1,
----sum(nvl(b.EVMFTCTOTBYTES_4_8,0)
----+nvl(b.EVMFTCTOTBYTES_9_6,0)
----+nvl(b.EVMFTCTOTBYTES_19_2,0)
----+nvl(b.EVMFTCTOTBYTES_38_4,0)
----+nvl(b.EVMFTCTOTBYTES_76_8,0)
----+nvl(b.EVMFTCTOTBYTES_153_6,0)
----+nvl(b.EVMFTCTOTBYTES_307_2,0)
----+nvl(b.EVMFTCTOTBYTES_614_4,0)
----+nvl(b.EVMFTCTOTBYTES_921_6,0)
----+nvl(b.EVMFTCTOTBYTES_1228_8,0)
----+nvl(b.EVMFTCTOTBYTES_1536,0)
----+nvl(b.EVMFTCTOTBYTES_1843_2,0)
----+nvl(b.EVMFTCTOTBYTES_2457_6,0)
----+nvl(b.EVMFTCTOTBYTES_3072,0))*0.001667) FwdTCHPhyOutburstThroughput,
------update-2011-9-14
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
from c_tpd_carr_do_lc b,c_carrier c
where b.int_id = c.int_id
and b.scan_start_time = v_date
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
EqlUserNum           =t.EqlUserNum ,
DRCApplyNum_FwdSpeed1=t.DRCApplyNum_FwdSpeed1,
DRCApplyNum_FwdSpeed2=t.DRCApplyNum_FwdSpeed2,
DRCApplyNum_FwdSpeed3=t.DRCApplyNum_FwdSpeed3,
FwdTCHPhyTxBitNum           =t.FwdTCHPhyTxBitNum,
FwdPhyUseTimeSlotDuration   =t.FwdPhyUseTimeSlotDuration,
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
t.related_msc,
v_date,
0,
101,
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


--------------add by Lv-------------------
merge into c_perf_do_sum c_perf
using(
select
b.related_msc,
--sum(nvl(a.PCF_INIT_REACT_ATTMPT,0)) AN_DAAcitveReqNum,
--sum(nvl(a.PCF_INIT_REACT_ATTMPT,0)-nvl(a.PCF_INIT_REACT_FAIL,0)) AN_DAAcitveSuccNum,
sum(nvl(PCF_INIT_REACT_FAIL,0)) AN_DAAcitveFailNum
from c_tpd_tp_do_ag_lc a,c_bsc b
where a.unique_rdn=b.object_rdn and a.scan_start_time=v_date and b.vendor_id=10
group by b.related_msc
) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
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
t.related_msc,
v_date,
0,
101,
10,
--t.AN_DAAcitveReqNum,
--t.AN_DAAcitveSuccNum,
t.AN_DAAcitveFailNum
);
commit;
-------------------------------------------------2010.5.4 document add-----------------

--BtsTotalNum
--OnecarrierBtsNum
--TwocarrierBtsNum
--threecarrierBtsNum
--FourcarrierBtsNum

merge into c_perf_do_sum c_perf
using(
select b.related_msc ,count(distinct a.related_bts) BtsTotalNum
from c_carrier a,c_cell b
where a.related_cell=b.int_id and a.car_type='DO' and a.vendor_id=10
group by b.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
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
t.related_msc,
v_date,
0,
101,
10,
t.BtsTotalNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.related_msc,count(distinct a.related_bts) OnecarrierBtsNum
from
(select related_bts from
c_carrier where car_type='DO' and vendor_id=10
group by related_msc,related_bts having count(distinct car_type)=1 ) a,c_cell b
where a.related_bts=b.related_bts and b.vendor_id=10
group by b.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
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
t.related_msc,
v_date,
0,
101,
10,
t.OnecarrierBtsNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.related_msc,count(distinct a.related_bts) TwocarrierBtsNum
from
(select
related_bts from
c_carrier
where car_type='DO' and vendor_id=10
group by related_msc,related_bts having count(distinct car_type)=2 ) a,c_cell b
where a.related_bts=b.related_bts and b.vendor_id=10
group by b.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
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
t.related_msc,
v_date,
0,
101,
10,
t.TwocarrierBtsNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.related_msc,count(distinct a.related_bts) ThreecarrierBtsNum
from
(select
related_bts from
c_carrier
where car_type='DO' and vendor_id=10
group by related_msc,related_bts having count(distinct car_type)=3 ) a,c_cell b
where a.related_bts=b.related_bts and b.vendor_id=10
group by b.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
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
t.related_msc,
v_date,
0,
101,
10,
t.ThreecarrierBtsNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.related_msc,count(distinct a.related_bts) FourcarrierBtsNum
from
(select
related_bts from
c_carrier
where car_type='DO' and vendor_id=10
group by related_msc,related_bts having count(distinct car_type)=4 ) a,c_cell b
where a.related_bts=b.related_bts and b.vendor_id=10
group by b.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
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
t.related_msc,
v_date,
0,
101,
10,
t.FourcarrierBtsNum);
commit;


--RevCEMaxUseRate
--RevCEMaxBusyNum
--RevCEAvailNum

merge into c_perf_do_sum c_perf
using(
select
c.related_msc related_msc,
round(sum(d.MODEM_CE_PEAK_USAGE)/
decode(sum(d.MODEM_CE_LICENSE_QUANTITY),0,1,null,1,sum(d.MODEM_CE_LICENSE_QUANTITY)),4) RevCEMaxUseRate,
sum(d.MODEM_CE_PEAK_USAGE) RevCEMaxBusyNum,
sum(d.MODEM_CE_LICENSE_QUANTITY) RevCEAvailNum
from c_tpd_evm_do_lc d,c_cell c
where d.int_id = c.int_id and d.scan_start_time = v_date
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
RevCEMaxUseRate = t.RevCEMaxUseRate,
RevCEMaxBusyNum = t.RevCEMaxBusyNum,
RevCEAvailNum   = t.RevCEAvailNum;
commit;

--FwdMaxBusyNum_MacIndex

merge into c_perf_do_sum c_perf
using(
select
c.related_msc related_msc,
--update-2011-9-14
max(Hdr294) FwdMaxBusyNum_MacIndex
from c_tpd_carr_do_ag_lc a,c_carrier c
where a.int_id = c.int_id and a.scan_start_time = v_date
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
FwdMaxBusyNum_MacIndex = t.FwdMaxBusyNum_MacIndex;
commit;

--DOCarrier37
--DOCarrier78
--DOCarrier119
--DOCarrierTotalNum

merge into c_perf_do_sum c_perf
using(
select
c.related_msc related_msc,
count(c.int_id) DOCarrier37
from c_carrier c
where c.cdma_freq = 37
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
DOCarrier37 = t.DOCarrier37;
commit;

merge into c_perf_do_sum c_perf
using(
select
c.related_msc related_msc,
count(c.int_id) DOCarrier78
from c_carrier c
where c.cdma_freq = 78
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
DOCarrier78 = t.DOCarrier78;
commit;

merge into c_perf_do_sum c_perf
using(
select
c.related_msc related_msc,
count(c.int_id) DOCarrier119
from c_carrier c
where c.cdma_freq = 119
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
DOCarrier119 = t.DOCarrier119;
commit;

--udpate-2011-9-2
--DOCarrierTotalNum
merge into c_perf_do_sum c_perf
using(
select
c_cell.related_msc related_msc,
count(c.int_id) DOCarrierTotalNum
from c_carrier c,c_cell
where c.related_cell=c_cell.int_id and c.car_type='DO' and c.vendor_id=10
group by c_cell.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
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
t.related_msc,
v_date,
0,
101,
10,
t.DOCarrierTotalNum);
commit;


--merge into c_perf_do_sum c_perf
--using(
--with a as(
--select
--c.related_msc related_msc,
--count(a.int_id) cnt
--from c_tpd_carr_do_lc a,c_carrier c
--where a.int_id = c.int_id and a.scan_start_time = v_date
--group by c.related_msc),
--b as(
--select
--c.related_msc related_msc,
--count(a.int_id) cnt
--from c_tpd_carr_do_ag_lc a,c_carrier c
--where a.int_id = c.int_id and a.scan_start_time = v_date
--group by c.related_msc)
--select a.related_msc related_msc,a.cnt+b.cnt DOCarrierTotalNum
--from a,b
--where a.related_msc = b.related_msc) t
--on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
--when matched then update set
--DOCarrierTotalNum = t.DOCarrierTotalNum;
--commit;

--OneDOCarrierCellNum
--TwoDOCarrierCellNum
--ThreeDOCarrierCellNum
--DOCellNum


--update-8-30
merge into c_perf_do_sum c_perf
using(
--select a.related_msc,a.OneDOCarrierCellNum,b.CarrierCellNum
--from
--(
--select b.related_msc,count(distinct b.int_id) OneDOCarrierCellNum
--from
--(select related_cell int_id from
--c_carrier where cdma_freq in (37,78) and vendor_id=10
--group by related_msc,related_cell
--having count(distinct cdma_freq)=1 ) a,c_cell b
--where a.int_id=b.int_id
--group by b.related_msc) a,
--(
--select b.related_msc,count(distinct a.int_id) CarrierCellNum
--from c_carrier a ,c_cell b  where a.related_cell=b.int_id
--and a.cdma_freq in (37,78) and a.vendor_id=10 and b.vendor_id=10
--group by b.related_msc
--) b
--where a.related_msc=b.related_msc(+) ) t
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
group by ne.int_id
),
b as (
select
  ne.related_msc,
  sum(OneDOCarrierCellNum) OneDOCarrierCellNum,
  sum(TwoDOCarrierCellNum) TwoDOCarrierCellNum,
  sum(threeDOCarrierCellNum) ThreeDOCarrierCellNum,
  sum(DOCellNum) DOCellNum,
  sum(CarrierCellNum) CarrierCellNum
  from c_cell ne,a
  where ne.int_id=a.int_id and ne.vendor_id=10
  group by ne.related_msc
)
select
b.related_msc,
101 ne_type,
OneDOCarrierCellNum,
TwoDOCarrierCellNum,
ThreeDOCarrierCellNum,
DOCellNum,
CarrierCellNum
from b) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
OneDOCarrierCellNum   = t.OneDOCarrierCellNum,
TwoDOCarrierCellNum   = t.TwoDOCarrierCellNum,
ThreeDOCarrierCellNum = t.ThreeDOCarrierCellNum,
CarrierCellNum         = t.CarrierCellNum
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
t.related_msc,
v_date,
0,
101,
10,
t.OneDOCarrierCellNum,
t.TwoDOCarrierCellNum,
t.ThreeDOCarrierCellNum,
t.CarrierCellNum);
commit;

--delete-8-30
--merge into c_perf_do_sum c_perf
--using(
--select b.related_msc,count(distinct b.int_id) TwoDOCarrierCellNum
--from
--(select related_cell int_id from
--c_carrier where cdma_freq in (37,78) and vendor_id=10
--group by related_msc,related_cell having count(distinct cdma_freq)=2 ) a,c_cell b
--where a.int_id=b.int_id
--group by b.related_msc) t
--on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
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
--t.related_msc,
--v_date,
--0,
--101,
--10,
--t.TwoDOCarrierCellNum);
--commit;

--delete-8-30
--merge into c_perf_do_sum c_perf
--using(
--select
--c.related_msc related_msc,
--count(d.int_id) ThreeDOCarrierCellNum
--from c_cell c,c_carrier d
--where c.int_id = d.related_cell and c.do_cell=1 and numfa=3 and c.vendor_id = 10
--group by c.related_msc) t
--on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
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
--t.related_msc,
--v_date,
--0,
--101,
--10,
----t.ThreeDOCarrierCellNum
--0);
--commit;

--delete-8-30
--merge into c_perf_do_sum c_perf
--using(
--select b.related_msc ,count(distinct a.related_cell) DOCellNum
--from c_carrier a,c_cell b
--where a.related_cell=b.int_id and  a.cdma_freq in (37,78)
--and a.vendor_id=10
--group by b.related_msc) t
--on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
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
--t.related_msc,
--v_date,
--0,
--101,
--10,
--t.DOCellNum);
--commit;


--update-8-26
merge into c_perf_do_sum c_perf
using(
--select
--update-8-26
--c.related_msc related_msc,
--sum(nvl(a.Hdr243,0)+nvl(b.SAMPLES_IN_PEGGING_INTER_OHM,0)) CE_Traffic
--from c_tpd_carr_do_ag_lc a,c_tpd_ohm_do_ag_lc b,c_carrier c
--where a.int_id = b.int_id and  a.int_id=c.int_id
--and a.scan_start_time = v_date
--group by c.related_msc
with a as (
select c.related_msc related_msc,
sum(nvl(a.Hdr243,0)) Hdr243
from c_tpd_carr_do_ag_lc a,c_carrier c
where a.int_id=c.int_id
and c.vendor_id=10
and a.scan_start_time=v_date
group by c.related_msc),
 b as (select c.related_msc related_msc,
sum(nvl(a.SAMPLES_IN_PEGGING_INTER_OHM,0)) SAMPLES_IN_PEGGING_INTER_OHM
from c_tpd_ohm_do_ag_lc a,c_bsc c
where a.unique_rdn=c.object_rdn
and c.vendor_id=10
and a.scan_start_time=v_date
group by c.related_msc)
select
a.related_msc related_msc,
--update-2011-9-19
--'/'--'+'
--nvl(a.Hdr243,0)/decode(b.SAMPLES_IN_PEGGING_INTER_OHM,0,1,null,1,b.SAMPLES_IN_PEGGING_INTER_OHM) CE_Traffic
nvl(a.Hdr243,0)+b.SAMPLES_IN_PEGGING_INTER_OHM CE_Traffic
from  a
left join b  on
 a.related_msc = b.related_msc
) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
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
t.related_msc,
v_date,
0,
101,
10,
t.CE_Traffic);
commit;
--end


--------------------------add by lv----------------
merge into c_perf_do_sum c_perf
using(
with a as(
select
c.related_msc related_msc,
sum(a.EVMAVGDRCPOINTEDUSERS*0.001*3600*(nvl(b.Hdr293,0)+nvl(b.Hdr292,0))) ConnectUseTotalDuration,
sum(nvl(b.Hdr293,0)+nvl(b.Hdr292,0))  ConnectSetupTotalDuration_1
from c_tpd_carr_do_lc a,c_tpd_carr_do_ag_lc b ,c_carrier c
where a.int_id=c.int_id and b.int_id=c.int_id and c.vendor_id=10
and a.scan_start_time=b.scan_start_time and a.scan_start_time=v_date and c.related_msc is not null
group by c.related_msc)
select
a.related_msc related_msc,
--update-2011-9-14
--b.ConnectSetupTotalDuration/decode(a.ConnectSetupTotalDuration_1,null,1,0,1,a.ConnectSetupTotalDuration_1) ConnectAvgSetupDuration,
a.ConnectUseTotalDuration ConnectUseTotalDuration,
a.ConnectUseTotalDuration/decode((nvl(b.AT_ConnectSuccNum,0)+nvl(b.AN_ConnectSuccNum,0)),null,1,0,1,(nvl(b.AT_ConnectSuccNum,0)+nvl(b.AN_ConnectSuccNum,0))) ConnectAvgUseDuration,
round(100*(nvl(b.AT_DAAcitveSuccNum,0)+nvl(b.AN_DAAcitveSuccNum,0))/decode((nvl(b.AT_DAAcitveReqNum,0)+nvl(b.AN_DAAcitveReqNum,0)),null,1,0,1,(nvl(b.AT_DAAcitveReqNum,0)+nvl(b.AN_DAAcitveReqNum,0))),4)  User_DAAcitveSuccRate,
------2010-08-19---------------
--update-2011-9-9
--100*b.FwdMaxBusyNum_MacIndex/decode(b.FwdAvailNum_MacIndex,null,1,0,1,b.FwdAvailNum_MacIndex) FwdMaxUseRate_MacIndex,
round(100*b.FwdMaxBusyNum_MacIndex/115,4) FwdMaxUseRate_MacIndex,
round(100*b.AbisAvgUseBandWidth/decode(b.AbisPortBandWidth,null,1,0,1,b.AbisPortBandWidth),4)  ABisBWAvgUseRate,
round(100*b.WireConnectSuccNumInA8A10/decode(b.WireConnectReqNumInA8A10,null,1,0,1,b.WireConnectReqNumInA8A10),4) WireConnectSuccRateInA8A10,
round(100*b.UserEarlyReleaseNum/decode((nvl(b.AT_ConnectReqNum,0)+nvl(b.AN_ConnectReqNum,0)),null,1,0,1,(nvl(b.AT_ConnectReqNum,0)+nvl(b.AN_ConnectReqNum,0))),4) UserEarlyReleaseRate,
(nvl(b.WireConnectReleaseNumInPDSN,0)-nvl(b.ReleaseNumByPDSN,0)) WireConnectReleaseNumExPDSN,
round(100*(nvl(b.ReleaseNumByPDSN,0)+nvl(b.WireRadioFNum1,0)+nvl(b.WireRadioFNum2,0)+nvl(b.WireRadioFNum3,0))/
decode((nvl(b.WireConnectReleaseNumInPDSN,0)+nvl(b.WireRadioFNum1,0)+nvl(b.WireRadioFNum2,0)+nvl(b.WireRadioFNum3,0)),null,1,0,1,(nvl(b.WireConnectReleaseNumInPDSN,0)+nvl(b.WireRadioFNum1,0)+nvl(b.WireRadioFNum2,0)+nvl(b.WireRadioFNum3,0))),4) NetWorkRadioFRate,
round(b.DRCApplyNum_FwdSpeed1/decode((nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0)),null,1,
0,1,(nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0))),4) DRCApplyRate_FwdSpeed1,
round(b.DRCApplyNum_FwdSpeed2/decode((nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0)),null,1,
0,1,(nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0))),4) DRCApplyRate_FwdSpeed2,
round(b.DRCApplyNum_FwdSpeed3/decode((nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0)),null,1,
0,1,(nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0))),4) DRCApplyRate_FwdSpeed3,
round(100*b.SessionAuthenticationSNum/decode(b.SessionAuthenticationReqNum,null,1,0,1,b.SessionAuthenticationReqNum),4) SessionAuthenticationSRate,
round(100*b.A13_HandoffSNum/decode(b.A13_HandoffNum,null,1,0,1,b.A13_HandoffNum),4) A13_HandoffSRate,
(nvl(b.SessionNum_Active,0)+nvl(b.SessionNum_NotActive,0)) SessionNum,
(nvl(b.AT_DAAcitveReqNum,0)+nvl(b.AN_DAAcitveReqNum,0)) User_DAAcitveReqNum,
(nvl(b.AT_DAAcitveSuccNum,0)+nvl(b.AN_DAAcitveSuccNum,0)) User_DAAcitveSuccNum,
round(100*b.AT_DAAcitveSuccNum/decode(b.AT_DAAcitveReqNum,null,1,0,1,b.AT_DAAcitveReqNum),4) AT_DAAcitveSuccRate,
round(100*b.AN_DAAcitveSuccNum/decode(b.AN_DAAcitveReqNum,null,1,0,1,b.AN_DAAcitveReqNum),4)  AN_DAAcitveSuccRate,
(nvl(b.Ce_Traffic,0)-nvl(b.Call_Traffic,0)) Sho_Traffic,
--udpate-2011-9-19
--b.Sho_Traffic/decode(b.Call_Traffic,null,1,0,1,b.Call_Traffic) Sho_Factor,
round(b.Sho_Traffic/(decode(b.Call_Traffic,null,1,0,1,b.Call_Traffic)*0.001),4) Sho_Factor,
round(b.RevPSDiscardNum/decode(b.PCFRevPSMsg,null,1,0,1,b.PCFRevPSMsg),4) RevPSDiscardRate,
round(b.FwdPSDiscardNum/decode(b.PCFFwdPSMsg,null,1,0,1,b.PCFFwdPSMsg),4) FwdPSDiscardRate,
round(100*b.RABBusyNum/decode((nvl(b.RABBusyNum,0)+nvl(b.RABFreeNum,0)),null,1,0,1,(nvl(b.RABBusyNum,0)+nvl(b.RABFreeNum,0))),4) RevCircuitBusyRate,
round(100*b.SHoSuccNum_intraAN/decode(b.SHoReqNum_intraAN,null,1,0,1,b.SHoReqNum_intraAN),4) SHoSuccRate_intraAN,
round(100*b.SHoSuccNum_amongAN/decode(b.SHoReqNum_amongAN,null,1,0,1,b.SHoReqNum_amongAN),4) SHoSuccRate_amongAN,
round(100*b.HardHoSuccNum_intraAN/decode(b.HardHoReqNum_intraAN,null,1,0,1,b.HardHoReqNum_intraAN),4)  HardHoSuccRate_intraAN,
round(100*b.HardHoSuccNum_amongAN/decode(b.HardHoReqNum_amongAN,null,1,0,1,b.HardHoReqNum_amongAN),4)  HardHoSuccRate_amongAN,
round(100*b.PageResponceNum/decode(b.PageReqNum,null,1,0,1,b.PageReqNum),4)  PageResponceRate
-------------------------------
from a,c_perf_do_sum b
where a.related_msc=b.int_id and b.scan_start_time = v_date and b.ne_type=101 and b.sum_level=0 and b.vendor_id=10
)t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
ConnectUseTotalDuration = t.ConnectUseTotalDuration,
ConnectAvgUseDuration   = t.ConnectAvgUseDuration,
User_DAAcitveSuccRate   = t.User_DAAcitveSuccRate,
------2010-08-19-------------
--ConnectAvgSetupDuration    =t.ConnectAvgSetupDuration     ,
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
--ConnectAvgSetupDuration,
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
t.related_msc,
v_date,
0,
101,
10,
t.ConnectUseTotalDuration,
t.ConnectAvgUseDuration,
t.User_DAAcitveSuccRate,
-------2010-08-19------------
--t.ConnectAvgSetupDuration,
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



merge into c_perf_do_sum c_perf
using(
select
a.int_id,
round(100*SessionNegoSNum/decode((SessionNegoSNum+SessionNegoFNum),null,1,0,1,(SessionNegoSNum+SessionNegoFNum)),4)  SessionNegoSRate
from c_perf_do_sum a
where a.scan_start_time = v_date and a.ne_type=101 and a.sum_level=0 and a.vendor_id=10
)t
on(c_perf.int_id = t.int_id and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
SessionNegoSRate=t.SessionNegoSRate
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
SessionNegoSRate
)
values(
t.int_id,
v_date,
0,
101,
10,
t.SessionNegoSRate
);
commit;


--add-2011-9-1
--add-BusyerBtsNum-FreeBtsNum
merge into c_perf_do_sum c_perf
using(
with tmp as (
select
c.related_msc related_msc,
case when
((d.EVMTOTALBUSYSLOTSBE+d.EVMTOTALBUSYSLOTSEF)/decode(d.TIMESLOTSINPEGGINGINTERVAL,null,0,1)) >=0.7 and (d.EVMACTIVEUSAGE*0.001667/3600)>=4 then 1 else 0 end BusyerBtsNum1,
case when
((d.EVMTOTALBUSYSLOTSBE+d.EVMTOTALBUSYSLOTSEF)/decode(d.TIMESLOTSINPEGGINGINTERVAL,null,0,1))<=0.5 and (d.EVMACTIVEUSAGE*0.001667/3600)<=1 then 1 else 0 end FreeBtsNum1
from c_tpd_carr_do_lc d,c_carrier c
where d.int_id=c.int_id and d.scan_start_time=v_date)
select
tmp.related_msc related_msc,
case when sum(BusyerBtsNum1)>=1 then 1 else 0 end BusyerBtsNum,
case when sum(FreeBtsNum1) <=1 then 1 else 0 end FreeBtsNum
from tmp
group by tmp.related_msc)t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=10)
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
t.related_msc,
v_date,
0,
101,
10,
t.BusyerBtsNum,
t.FreeBtsNum);
commit;



-------------------------------------------------end of 2010.5.4 -----------------
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
from c_perf_do_sum where scan_start_time= v_date and sum_level=0 and ne_type=101 and vendor_id=10
and int_id=perf.int_id
)
where scan_start_time= v_date and sum_level=0 and ne_type=101 and vendor_id=10 ;
commit;

exception when others then
s_error := sqlerrm;
rollback;
insert into job_log values(sysdate,'c_perf_do_sum_lc',s_error);
commit;
end;
