create or replace procedure proc_c_perf_do_sum_zx_cell(p_date date)
as
v_date date;
s_error varchar2(4000);

begin
--if null then v_date = sysdate-3 (3hours before) else v_date = p_date
select trunc(decode(p_date,null,trunc(sysdate-3/24,'hh24'),p_date),'hh24') into v_date from dual;

--C_tpd_cnt_carr_do_zx a,C_tpd_cnt_bsc_mdu_do_zx b,C_tpd_cnt_bsc_do_zx c,
--C_tpd_cnt_bsc_flux_do_zx d,C_tpd_cnt_carr_ho_do_zx e,c_thw_par_carr_do f,C_tpd_cnt_bts_do_zx g

--ne_type= 300 sum_level=0
--由a实现




merge into c_perf_do_sum c_perf
using(
select
c.city_id city_id,

--modify-2011-11-04
sum(nvl(a.CMO_CallSNum,0)
+nvl(a.soft_CMO_CallSuccessNum,0)
+nvl(a.CMT_CallSNum,0)
+nvl(a.soft_CMT_CallSuccessNum,0)
+nvl(a.FMT_CallSNum,0)
+nvl(a.soft_FMT_CallSuccessNum,0))/decode(sum(nvl(a.CMO_CallSNum,0)
+nvl(a.CMO_ExtInterruptNum,0)
+nvl(a.CMO_BlockFNum,0)
+nvl(a.CMO_OtherFNum,0)
+nvl(a.CMO_RTCHCapFNum,0)
+nvl(a.CMO_TCCTimeoutFNum,0)
+nvl(a.soft_CMO_CallSuccessNum,0)
+nvl(a.soft_CMO_ExtInterruptNum,0)
+nvl(a.soft_CMO_BlockFailureNum,0)
+nvl(a.soft_CMO_OtherFailureNum,0)
+nvl(a.soft_CMO_RTCHCapFNum,0)
+nvl(a.soft_CMO_TCCTimeoutFNum,0)
+nvl(a.CMO_ExtInterruptNum_bssapfail,0)
+nvl(a.CMO_BlockFailureNum_bssapfail,0)
+nvl(a.CMO_OtherFailureNum_bssapfail,0)
+nvl(a.CMT_CallSNum,0)
+nvl(a.CMT_ExtInterruptNum,0)
+nvl(a.CMT_BlockFNum,0)
+nvl(a.CMT_OtherFNum,0)
+nvl(a.CMT_RTCHCapFNum,0)
+nvl(a.CMT_TCCTimeoutFNum,0)
+nvl(a.soft_CMT_CallSuccessNum,0)
+nvl(a.soft_CMT_ExtInterruptNum,0)
+nvl(a.soft_CMT_BlockFailureNum,0)
+nvl(a.soft_CMT_OtherFailureNum,0)
+nvl(a.soft_CMT_RTCHCapFNum,0)
+nvl(a.soft_CMT_TCCTimeoutFNum,0)
+nvl(a.FMT_CallSNum,0)
+nvl(a.FMT_ExtInterruptNum,0)
+nvl(a.FMT_BlockFNum,0)
+nvl(a.FMT_OtherFNum,0)
+nvl(a.FMT_InvalidReqNum,0)
+nvl(a.FMT_RFAccessFailureNum,0)
+nvl(a.soft_FMT_CallSuccessNum,0)
+nvl(a.soft_FMT_ExtInterruptNum,0)
+nvl(a.soft_FMT_BlockFailureNum,0)
+nvl(a.soft_FMT_OtherFailureNum,0)
+nvl(a.soft_FMT_InvalidReqNum,0)
+nvl(a.soft_FMT_RFAccessFailureNum,0)
+nvl(a.CMT_ExtInterruptNum_bssapfail,0)
+nvl(a.CMT_BlockFailureNum_bssapfail,0)
+nvl(a.CMT_OtherFailureNum_bssapfail,0)
+nvl(a.FMT_ExtInterruptNum_bssapfail,0)
+nvl(a.FMT_BlockFailureNum_bssapfail,0)
+nvl(a.FMT_OtherFailureNum_bssapfail,0)) ,0,1,null,1,
sum(nvl(a.CMO_CallSNum,0)
+nvl(a.CMO_ExtInterruptNum,0)
+nvl(a.CMO_BlockFNum,0)
+nvl(a.CMO_OtherFNum,0)
+nvl(a.CMO_RTCHCapFNum,0)
+nvl(a.CMO_TCCTimeoutFNum,0)
+nvl(a.soft_CMO_CallSuccessNum,0)
+nvl(a.soft_CMO_ExtInterruptNum,0)
+nvl(a.soft_CMO_BlockFailureNum,0)
+nvl(a.soft_CMO_OtherFailureNum,0)
+nvl(a.soft_CMO_RTCHCapFNum,0)
+nvl(a.soft_CMO_TCCTimeoutFNum,0)
+nvl(a.CMO_ExtInterruptNum_bssapfail,0)
+nvl(a.CMO_BlockFailureNum_bssapfail,0)
+nvl(a.CMO_OtherFailureNum_bssapfail,0)
+nvl(a.CMT_CallSNum,0)
+nvl(a.CMT_ExtInterruptNum,0)
+nvl(a.CMT_BlockFNum,0)
+nvl(a.CMT_OtherFNum,0)
+nvl(a.CMT_RTCHCapFNum,0)
+nvl(a.CMT_TCCTimeoutFNum,0)
+nvl(a.soft_CMT_CallSuccessNum,0)
+nvl(a.soft_CMT_ExtInterruptNum,0)
+nvl(a.soft_CMT_BlockFailureNum,0)
+nvl(a.soft_CMT_OtherFailureNum,0)
+nvl(a.soft_CMT_RTCHCapFNum,0)
+nvl(a.soft_CMT_TCCTimeoutFNum,0)
+nvl(a.FMT_CallSNum,0)
+nvl(a.FMT_ExtInterruptNum,0)
+nvl(a.FMT_BlockFNum,0)
+nvl(a.FMT_OtherFNum,0)
+nvl(a.FMT_InvalidReqNum,0)
+nvl(a.FMT_RFAccessFailureNum,0)
+nvl(a.soft_FMT_CallSuccessNum,0)
+nvl(a.soft_FMT_ExtInterruptNum,0)
+nvl(a.soft_FMT_BlockFailureNum,0)
+nvl(a.soft_FMT_OtherFailureNum,0)
+nvl(a.soft_FMT_InvalidReqNum,0)
+nvl(a.soft_FMT_RFAccessFailureNum,0)
+nvl(a.CMT_ExtInterruptNum_bssapfail,0)
+nvl(a.CMT_BlockFailureNum_bssapfail,0)
+nvl(a.CMT_OtherFailureNum_bssapfail,0)
+nvl(a.FMT_ExtInterruptNum_bssapfail,0)
+nvl(a.FMT_BlockFailureNum_bssapfail,0)
+nvl(a.FMT_OtherFailureNum_bssapfail,0)))*100  WireConnectSuccRate,
 sum(nvl(a.CMO_CallSNum,0)
+nvl(a.soft_CMO_CallSuccessNum,0)
+nvl(a.CMO_ExtInterruptNum,0)
+nvl(a.soft_CMO_ExtInterruptNum,0)
+nvl(a.CMO_ExtInterruptNum_bssapfail,0))/
decode(sum(nvl(a.CMO_CallSNum,0)
+nvl(a.CMO_ExtInterruptNum,0)
+nvl(a.CMO_BlockFNum,0)
+nvl(a.CMO_OtherFNum,0)
+nvl(a.CMO_InvalidReqNum,0)
+nvl(a.CMO_RFAccessFailureNum,0)
+nvl(a.soft_CMO_CallSuccessNum,0)
+nvl(a.soft_CMO_ExtInterruptNum,0)
+nvl(a.soft_CMO_BlockFailureNum,0)
+nvl(a.soft_CMO_OtherFailureNum,0)
+nvl(a.soft_CMO_InvalidReqNum,0)
+nvl(a.soft_CMO_RFAccessFailureNum,0)
+nvl(a.CMO_ExtInterruptNum_bssapfail,0)
+nvl(a.CMO_BlockFailureNum_bssapfail,0)
+nvl(a.CMO_OtherFailureNum_bssapfail,0)),0,1,null,1,sum(nvl(a.CMO_CallSNum,0)
+nvl(a.CMO_ExtInterruptNum,0)
+nvl(a.CMO_BlockFNum,0)
+nvl(a.CMO_OtherFNum,0)
+nvl(a.CMO_InvalidReqNum,0)
+nvl(a.CMO_RFAccessFailureNum,0)
+nvl(a.soft_CMO_CallSuccessNum,0)
+nvl(a.soft_CMO_ExtInterruptNum,0)
+nvl(a.soft_CMO_BlockFailureNum,0)
+nvl(a.soft_CMO_OtherFailureNum,0)
+nvl(a.soft_CMO_InvalidReqNum,0)
+nvl(a.soft_CMO_RFAccessFailureNum,0)
+nvl(a.CMO_ExtInterruptNum_bssapfail,0)
+nvl(a.CMO_BlockFailureNum_bssapfail,0)
+nvl(a.CMO_OtherFailureNum_bssapfail,0)))*100 AT_ConnectSuccRate,
--update-2011-9-19
--sum(nvl(a.CMT_CallSNum,0)
--+nvl(a.soft_CMT_CallSuccessNum,0)
--+nvl(a.CMT_ExtInterruptNum,0)
--+nvl(a.soft_CMT_ExtInterruptNum,0)
--+nvl(a.FMT_CallSNum,0)
--+nvl(a.soft_FMT_CallSuccessNum,0)
--+nvl(a.FMT_ExtInterruptNum,0)
--+nvl(a.soft_FMT_ExtInterruptNum,0)
--+nvl(a.CMT_ExtInterruptNum_bssapfail,0)
--+nvl(a.FMT_ExtInterruptNum_bssapfail,0))/
--decode(sum(nvl(a.CMT_OtherFNum,0)
--+nvl(a.CMT_InvalidReqNum,0)
--+nvl(a.CMT_RFAccessFailureNum,0)
--+nvl(a.soft_CMT_CallSuccessNum,0)
--+nvl(a.soft_CMT_ExtInterruptNum,0)
--+nvl(a.soft_CMT_BlockFailureNum,0)
--+nvl(a.soft_CMT_OtherFailureNum,0)
--+nvl(a.soft_CMT_InvalidReqNum,0)
--+nvl(a.soft_CMT_RFAccessFailureNum,0)
--+nvl(a.FMT_CallSNum,0)
--+nvl(a.FMT_ExtInterruptNum,0)
--+nvl(a.FMT_BlockFNum,0)
--+nvl(a.FMT_OtherFNum,0)
--+nvl(a.FMT_InvalidReqNum,0)
--+nvl(a.FMT_RFAccessFailureNum,0)
--+nvl(a.soft_FMT_CallSuccessNum,0)
--+nvl(a.soft_FMT_ExtInterruptNum,0)
--+nvl(a.soft_FMT_BlockFailureNum,0)
--+nvl(a.soft_FMT_OtherFailureNum,0)
--+nvl(a.soft_FMT_InvalidReqNum,0)
--+nvl(a.soft_FMT_RFAccessFailureNum,0)
--+nvl(a.CMT_ExtInterruptNum_bssapfail,0)
--+nvl(a.CMT_BlockFailureNum_bssapfail,0)
--+nvl(a.CMT_OtherFailureNum_bssapfail,0)
--+nvl(a.FMT_ExtInterruptNum_bssapfail,0)
--+nvl(a.FMT_BlockFailureNum_bssapfail,0)
--+nvl(a.FMT_OtherFailureNum_bssapfail,0)),0,1,null,1,sum(nvl(a.CMT_OtherFNum,0)
--+nvl(a.CMT_InvalidReqNum,0)
--+nvl(a.CMT_RFAccessFailureNum,0)
--+nvl(a.soft_CMT_CallSuccessNum,0)
--+nvl(a.soft_CMT_ExtInterruptNum,0)
--+nvl(a.soft_CMT_BlockFailureNum,0)
--+nvl(a.soft_CMT_OtherFailureNum,0)
--+nvl(a.soft_CMT_InvalidReqNum,0)
--+nvl(a.soft_CMT_RFAccessFailureNum,0)
--+nvl(a.FMT_CallSNum,0)
--+nvl(a.FMT_ExtInterruptNum,0)
--+nvl(a.FMT_BlockFNum,0)
--+nvl(a.FMT_OtherFNum,0)
--+nvl(a.FMT_InvalidReqNum,0)
--+nvl(a.FMT_RFAccessFailureNum,0)
--+nvl(a.soft_FMT_CallSuccessNum,0)
--+nvl(a.soft_FMT_ExtInterruptNum,0)
--+nvl(a.soft_FMT_BlockFailureNum,0)
--+nvl(a.soft_FMT_OtherFailureNum,0)
--+nvl(a.soft_FMT_InvalidReqNum,0)
--+nvl(a.soft_FMT_RFAccessFailureNum,0)
--+nvl(a.CMT_ExtInterruptNum_bssapfail,0)
--+nvl(a.CMT_BlockFailureNum_bssapfail,0)
--+nvl(a.CMT_OtherFailureNum_bssapfail,0)
--+nvl(a.FMT_ExtInterruptNum_bssapfail,0)
--+nvl(a.FMT_BlockFailureNum_bssapfail,0)
--+nvl(a.FMT_OtherFailureNum_bssapfail,0))) AN_ConnectSuccRate,
100*sum(nvl(a.CMT_CallSNum ,0)
+nvl(a.soft_CMT_CallSuccessNum   ,0)
+nvl(a.FMT_CallSNum              ,0)
+nvl(a.soft_FMT_CallSuccessNum,0))/
sum(nvl(a.CMT_CallSNum           ,0)
+nvl(a.CMT_ExtInterruptNum       ,0)
+nvl(a.CMT_BlockFNum             ,0)
+nvl(a.CMT_OtherFNum             ,0)
+nvl(a.CMT_RTCHCapFNum           ,0)
+nvl(a.CMT_TCCTimeoutFNum        ,0)
+nvl(a.soft_CMT_CallSuccessNum   ,0)
+nvl(a.soft_CMT_ExtInterruptNum  ,0)
+nvl(a.soft_CMT_BlockFailureNum  ,0)
+nvl(a.soft_CMT_OtherFailureNum  ,0)
+nvl(a.soft_CMT_RTCHCapFNum      ,0)
+nvl(a.soft_CMT_TCCTimeoutFNum   ,0)
+nvl(a.FMT_CallSNum              ,0)
+nvl(a.FMT_ExtInterruptNum       ,0)
+nvl(a.FMT_BlockFNum             ,0)
+nvl(a.FMT_OtherFNum             ,0)
+nvl(a.FMT_InvalidReqNum         ,0)
+nvl(a.FMT_RFAccessFailureNum    ,0)
+nvl(a.soft_FMT_CallSuccessNum   ,0)
+nvl(a.soft_FMT_ExtInterruptNum  ,0)
+nvl(a.soft_FMT_BlockFailureNum  ,0)
+nvl(a.soft_FMT_OtherFailureNum  ,0)
+nvl(a.soft_FMT_InvalidReqNum    ,0)
+nvl(a.soft_FMT_RFAccessFailureNum ,0)
+nvl(a.CMT_ExtInterruptNum_bssapfail,0)
+nvl(a.CMT_BlockFailureNum_bssapfail,0)
+nvl(a.CMT_OtherFailureNum_bssapfail,0)
+nvl(a.FMT_ExtInterruptNum_bssapfail,0)
+nvl(a.FMT_BlockFailureNum_bssapfail,0)
+nvl(a.FMT_OtherFailureNum_bssapfail,0)) AN_ConnectSuccRate,
sum(nvl(a.CMO_CallSNum,0)
+nvl(a.CMO_ExtInterruptNum,0)
+nvl(a.CMO_BlockFNum,0)
+nvl(a.CMO_OtherFNum,0)
+nvl(a.CMO_RTCHCapFNum,0)
+nvl(a.CMO_TCCTimeoutFNum,0)
+nvl(a.soft_CMO_CallSuccessNum,0)
+nvl(a.soft_CMO_ExtInterruptNum,0)
+nvl(a.soft_CMO_BlockFailureNum,0)
+nvl(a.soft_CMO_OtherFailureNum,0)
+nvl(a.soft_CMO_RTCHCapFNum,0)
+nvl(a.soft_CMO_TCCTimeoutFNum,0)
+nvl(a.CMO_ExtInterruptNum_bssapfail,0)
+nvl(a.CMO_BlockFailureNum_bssapfail,0)
+nvl(a.CMO_OtherFailureNum_bssapfail,0)) AT_ConnectReqNum,
sum(nvl(a.CMT_CallSNum,0)
+nvl(a.CMT_ExtInterruptNum,0)
+nvl(a.CMT_BlockFNum,0)
+nvl(a.CMT_OtherFNum,0)
+nvl(a.CMT_RTCHCapFNum,0)
+nvl(a.CMT_TCCTimeoutFNum,0)
+nvl(a.soft_CMT_CallSuccessNum,0)
+nvl(a.soft_CMT_ExtInterruptNum,0)
+nvl(a.soft_CMT_BlockFailureNum,0)
+nvl(a.soft_CMT_OtherFailureNum,0)
+nvl(a.soft_CMT_RTCHCapFNum,0)
+nvl(a.soft_CMT_TCCTimeoutFNum,0)
+nvl(a.FMT_CallSNum,0)
+nvl(a.FMT_ExtInterruptNum,0)
+nvl(a.FMT_BlockFNum,0)
+nvl(a.FMT_OtherFNum,0)
+nvl(a.FMT_InvalidReqNum,0)
+nvl(a.FMT_RFAccessFailureNum,0)
+nvl(a.soft_FMT_CallSuccessNum,0)
+nvl(a.soft_FMT_ExtInterruptNum,0)
+nvl(a.soft_FMT_BlockFailureNum,0)
+nvl(a.soft_FMT_OtherFailureNum,0)
+nvl(a.soft_FMT_InvalidReqNum,0)
+nvl(a.soft_FMT_RFAccessFailureNum,0)
+nvl(a.CMT_ExtInterruptNum_bssapfail,0)
+nvl(a.CMT_BlockFailureNum_bssapfail,0)
+nvl(a.CMT_OtherFailureNum_bssapfail,0)
+nvl(a.FMT_ExtInterruptNum_bssapfail,0)
+nvl(a.FMT_BlockFailureNum_bssapfail,0)
+nvl(a.FMT_OtherFailureNum_bssapfail,0)) AN_ConnectReqNum,
sum(nvl(a.CMO_CallSNum,0)
+nvl(a.soft_CMO_CallSuccessNum,0)) AT_ConnectSuccNum,
sum(nvl(a.CMT_CallSNum,0)
+nvl(a.soft_CMT_CallSuccessNum,0)
+nvl(a.FMT_CallSNum,0)
+nvl(a.soft_FMT_CallSuccessNum,0)) AN_ConnectSuccNum,
sum(nvl(a.CMO_BlockFNum,0)
+nvl(a.soft_CMO_BlockFailureNum,0)
+nvl(a.CMO_BlockFailureNum_bssapfail,0)
+nvl(a.CMT_BlockFNum,0)
+nvl(a.soft_CMT_BlockFailureNum,0)
+nvl(a.CMT_BlockFailureNum_bssapfail,0)
+nvl(a.FMT_BlockFNum,0)
+nvl(a.soft_FMT_BlockFailureNum,0)
+nvl(a.FMT_BlockFailureNum_bssapfail,0)) WireConnectFailNum1,
sum(nvl(a.RlsSNum,0)+nvl(a.PDSNReleaseNum,0)) WireConnectReleaseNumInPDSN,
--sum(a.RlsSNum-a.ANReleaseNum) WireConnectReleaseNumExPDSN,
sum(a.RlsSNum) WireConnectReleaseNumExPDSN,
sum(a.PDSNReleaseNum) ReleaseNumByPDSN,
sum(a.AirlinkLostDropNum)  WireRadioFNum1,
sum(nvl(a.OtherDropNum,0)) WireRadioFNum3,
case when sum(nvl(a.SetupSuccessNum,0))> sum(a.SetupAttemptNum)
then 100
else
sum(nvl(a.SetupSuccessNum,0))/decode(sum(a.SetupAttemptNum),0,1,null,1,sum(a.SetupAttemptNum))*100
end  UATI_AssgnSuccRate,
sum(nvl(a.SetupAttemptNum,0)) UATI_AssgnReqNum,
sum(nvl(a.SetupSuccessNum,0)) UATI_AssgnSuccNum,
sum(nvl(a.SetupFailureNum,0)) UATI_AssgnFailNum,
sum(nvl(a.EquUserNum,0)) EqlUserNum,
sum(nvl(a.CallDuration,0)/3600) Call_Traffic,
sum(nvl(a.CallDuration,0)+nvl(a.SHoDuration,0))/3600 CE_Traffic,
sum(nvl(a.SHoDuration,0))/3600 Sho_Traffic,
--update-2011-9-18
--100*sum(nvl(a.SHoDuration,0))/3600/decode(sum(a.CallDuration),0,1,null,1,sum(a.CallDuration))/3600 Sho_Factor,
100*sum(nvl(a.SHoDuration,0))/decode(sum(a.CallDuration),0,1,null,1,sum(a.CallDuration)) Sho_Factor,
sum(nvl(a.RevAFwdTCHPhyBytes,0)+nvl(a.Rls0FwdTCHPhyBytes,0))*8.0/1000/3600 FwdTCHPhyAvgThroughput,
sum(nvl(a.RevAFwdTCHPhyBytes,0)+nvl(a.Rls0FwdTCHPhyBytes,0))*8.0/decode((sum(a.RevAFwdTCHSendSlotNum)+sum(a.Rls0FwdTCHSendSlotNum)*1.667),0,1,null,1,(sum(a.RevAFwdTCHSendSlotNum)+sum(a.Rls0FwdTCHSendSlotNum)*1.667)) FwdTCHPhyOutburstThroughput,
sum(nvl(a.RevARevTCHPhyBytes,0)+nvl(a.Rls0RevTCHPhyBytes,0))*8.0/1000/3600 RevTCHPhyAvgThroughput,
sum(nvl(a.RevARevTCHPhyBytes,0)+nvl(a.Rls0RevTCHPhyBytes,0))*8.0/decode((sum(a.RevSlotNum)*1.667),0,1,null,1,(sum(a.RevSlotNum)*1.667)) RevTCHPhyOutburstThroughput,
--update by zhengting
100*avg((nvl(a.FwdCCHSendSlotNum,0))*1.667/1000/3600) FwdCCHPhyTimeSlotUseRate,
sum(nvl(a.RABBusyNum,0))/decode(sum(nvl(a.RABBusyNum,0)+nvl(a.RABFreeNum,0)),0,1,null,1,sum(nvl(a.RABBusyNum,0)+nvl(a.RABFreeNum,0)))*100 RevCircuitBusyRate,
sum(decode(c.cdma_freq,37,(nvl(a.CallDuration,0)+nvl(a.SHoDuration,0)+nvl(a.SSHoDuration,0))/3600,0)) DOCarrier37Traffic,
sum(decode(c.cdma_freq,78,(nvl(a.CallDuration,0)+nvl(a.SHoDuration,0)+nvl(a.SSHoDuration,0))/3600,0)) DOCarrier78Traffic,
sum(decode(c.cdma_freq,119,(nvl(a.CallDuration,0)+nvl(a.SHoDuration,0)+nvl(a.SSHoDuration,0))/3600,0)) DOCarrier119Traffic,
sum(a.RABBusyNum) RABBusyNum,
sum(a.RABFreeNum) RABFreeNum,
sum(nvl(a.RevAFwdTCHPhyBytes,0)+nvl(a.Rls0FwdTCHPhyBytes,0))*8.0  FwdTCHPhyTxBitNum,
sum(nvl(a.RevAFwdTCHSendSlotNum,0)+nvl(a.Rls0FwdTCHSendSlotNum,0))*1.667/1000 FwdPhyUseTimeSlotDuration,
sum(nvl(a.RevARevTCHPhyBytes,0)+nvl(a.Rls0RevTCHPhyBytes,0))*8.0 RevTCHPhyTxBitNum,
sum(nvl(a.RevSlotNum,0))*1.667/1000 RevPhyUseTimeSlotDuration,
sum(nvl(a.HHODropNum,0)) WireRadioFNum2,
--update by zhengting
100*avg((nvl(a.RevAFwdTCHSendSlotNum,0)+nvl(a.Rls0FwdTCHSendSlotNum,0))*1.667/(1000*3600)) FwdTCHPhyTimeSlotUseRate,
100*sum(nvl(a.AirlinkLostDropNum,0)
+nvl(a.HHODropNum,0)
+nvl(a.OtherDropNum,0))/
decode(sum(nvl(a.RlsSNum,0)
+nvl(a.PDSNReleaseNum,0)
+nvl(a.AirlinkLostDropNum,0)
+nvl(a.HHODropNum,0)
+nvl(a.OtherDropNum ,0)),0,1,null,1,sum(nvl(a.RlsSNum,0)
+nvl(a.PDSNReleaseNum,0)
+nvl(a.AirlinkLostDropNum,0)
+nvl(a.HHODropNum,0)
+nvl(a.OtherDropNum,0))) WireRadioFRate,
max(nvl(a.usernum,0)) FwdMaxBusyNum_MacIndex,
sum(nvl(a.MO_WireNetCallSucNum,0)
+nvl(a.MT_WireNetSucNum,0)
+nvl(a.Soft_MO_WireNetCallSucNum,0)
+nvl(a.Soft_MT_WireNetSucNum,0)) WireConnectSuccNumInA8A10,
sum(nvl(a.CMO_CallSNum,0)
+nvl(a.CMO_ExtInterruptNum,0)
+nvl(a.CMO_BlockFNum,0)
+nvl(a.CMO_OtherFNum,0)
+nvl(a.CMO_RTCHCapFNum,0)
+nvl(a.CMO_TCCTimeoutFNum,0)
+nvl(a.soft_CMO_CallSuccessNum,0)
+nvl(a.soft_CMO_ExtInterruptNum,0)
+nvl(a.soft_CMO_BlockFailureNum,0)
+nvl(a.soft_CMO_OtherFailureNum,0)
+nvl(a.soft_CMO_RTCHCapFNum,0)
+nvl(a.soft_CMO_TCCTimeoutFNum,0)
+nvl(a.CMO_ExtInterruptNum_bssapfail,0)
+nvl(a.CMO_BlockFailureNum_bssapfail,0)
+nvl(a.CMO_OtherFailureNum_bssapfail,0)
+nvl(a.CMT_CallSNum,0)
+nvl(a.CMT_ExtInterruptNum,0)
+nvl(a.CMT_BlockFNum,0)
+nvl(a.CMT_OtherFNum,0)
+nvl(a.CMT_RTCHCapFNum,0)
+nvl(a.CMT_TCCTimeoutFNum,0)
+nvl(a.soft_CMT_CallSuccessNum,0)
+nvl(a.soft_CMT_ExtInterruptNum,0)
+nvl(a.soft_CMT_BlockFailureNum,0)
+nvl(a.soft_CMT_OtherFailureNum,0)
+nvl(a.soft_CMT_RTCHCapFNum,0)
+nvl(a.soft_CMT_TCCTimeoutFNum,0)
+nvl(a.FMT_CallSNum,0)
+nvl(a.FMT_ExtInterruptNum,0)
+nvl(a.FMT_BlockFNum,0)
+nvl(a.FMT_OtherFNum,0)
+nvl(a.FMT_InvalidReqNum,0)
+nvl(a.FMT_RFAccessFailureNum,0)
+nvl(a.soft_FMT_CallSuccessNum,0)
+nvl(a.soft_FMT_ExtInterruptNum,0)
+nvl(a.soft_FMT_BlockFailureNum,0)
+nvl(a.soft_FMT_OtherFailureNum,0)
+nvl(a.soft_FMT_InvalidReqNum,0)
+nvl(a.soft_FMT_RFAccessFailureNum,0)
+nvl(a.CMT_ExtInterruptNum_bssapfail,0)
+nvl(a.CMT_BlockFailureNum_bssapfail,0)
+nvl(a.CMT_OtherFailureNum_bssapfail,0)
+nvl(a.FMT_ExtInterruptNum_bssapfail,0)
+nvl(a.FMT_BlockFailureNum_bssapfail,0)
+nvl(a.FMT_OtherFailureNum_bssapfail,0)) WireConnectReqNumInA8A10,
sum(nvl(a.CMT_ExtInterruptNum,0)
+nvl(a.soft_CMT_ExtInterruptNum,0)
+nvl(a.CMT_ExtInterruptNum_bssapfail,0)
+nvl(a.FMT_ExtInterruptNum,0)
+nvl(a.soft_FMT_ExtInterruptNum,0)
+nvl(a.FMT_ExtInterruptNum_bssapfail,0)
+nvl(a.CMO_ExtInterruptNum,0)
+nvl(a.soft_CMO_ExtInterruptNum,0)
+nvl(a.CMO_ExtInterruptNum_bssapfail,0)) UserEarlyReleaseNum,
sum(nvl(a.CMO_RTCHCapFNum,0)
+nvl(a.soft_CMO_RTCHCapFNum,0)
+nvl(a.CMT_RTCHCapFNum,0)
+nvl(a.soft_CMT_RTCHCapFNum,0)
+nvl(a.FMT_RTCHCapFNum,0)
+nvl(a.soft_FMT_RTCHCapFNum,0)) WireConnectFailNum2,
sum(nvl(a.CMO_TCCTimeoutFNum,0)
+nvl(a.soft_CMO_TCCTimeoutFNum,0)
+nvl(a.CMT_TCCTimeoutFNum,0)
+nvl(a.soft_CMT_TCCTimeoutFNum,0)
+nvl(a.FMT_TCCTimeoutFNum,0)
+nvl(a.soft_FMT_TCCTimeoutFNum,0)) WireConnectFailNum3,
sum(nvl(a.Cell_Session_SetupTime,0)+nvl(a.SetupSuccessNum,0)) UATI_AvgSetupDuration,
sum(nvl(a.RequestNum,0)) SessionAuthenticationSNum,
sum(nvl(a.TxByteNum+ReTxByteNum,0))*8.0/(1000*3600) FwdRLPThroughput,
sum(nvl(a.ReTxByteNum,0))/decode(sum(a.TxByteNum)+sum(a.ReTxByteNum),0,1,null,1,sum(a.TxByteNum)+sum(a.ReTxByteNum))*100 FwdRLPRxRate,
sum(nvl(a.RevARevTCHMACBytes,0)+nvl(a.Rls0RevTCHMACBytes,0))*8.0/1000/3600 RevRLPThroughput,
100*sum(nvl(a.ReReByteNum,0))/decode(sum(nvl(a.RevARevTCHMACBytes,0))+sum(nvl(a.Rls0RevTCHMACBytes,0)),null,1,0,1,sum(nvl(a.RevARevTCHMACBytes,0))+sum(nvl(a.Rls0RevTCHMACBytes,0))) RevRLPRxRate,
sum(nvl(a.Cell_Session_SetupTime,0)) SessionSetupTotalDuration,
sum(nvl(a.ReTxByteNum,0)) FwdRxSize,
sum(nvl(a.TxByteNum,0)+nvl(a.ReTxByteNum,0))  FwdTxSize,
sum(nvl(a.ReReByteNum,0)) RevRxSize,
sum(nvl(a.RevARevTCHMACBytes,0)+nvl(a.Rls0RevTCHMACBytes,0))  RevTxSize,
sum(nvl(a.Range1ReqNum,0)) DRCApplyNum_FwdSpeed1,
sum(nvl(a.Range2ReqNum,0)+nvl(a.Range3ReqNum,0))  DRCApplyNum_FwdSpeed2,
sum(nvl(a.Range4ReqNum,0)) DRCApplyNum_FwdSpeed3
from C_tpd_cnt_carr_do_zx a,c_carrier c
where a.int_id = c.int_id
and a.scan_start_time = v_date
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
WireConnectSuccRate         = t.WireConnectSuccRate,
AT_ConnectSuccRate          = t.AT_ConnectSuccRate,
AN_ConnectSuccRate          = t.AN_ConnectSuccRate,
AT_ConnectReqNum            = t.AT_ConnectReqNum,
AN_ConnectReqNum            = t.AN_ConnectReqNum,
AT_ConnectSuccNum           = t.AT_ConnectSuccNum,
AN_ConnectSuccNum           = t.AN_ConnectSuccNum,
WireConnectFailNum1         = t.WireConnectFailNum1,
WireConnectReleaseNumInPDSN = t.WireConnectReleaseNumInPDSN,
WireConnectReleaseNumExPDSN=t.WireConnectReleaseNumExPDSN,
WireRadioFNum1              = t.WireRadioFNum1,
WireRadioFNum3              = t.WireRadioFNum3,
UATI_AssgnSuccRate          = t.UATI_AssgnSuccRate,
UATI_AssgnReqNum            = t.UATI_AssgnReqNum,
UATI_AssgnSuccNum           = t.UATI_AssgnSuccNum,
UATI_AssgnFailNum           = t.UATI_AssgnFailNum,
EqlUserNum                  = t.EqlUserNum,
Call_Traffic                = t.Call_Traffic,
CE_Traffic                  = t.CE_Traffic,
Sho_Traffic                 = t.Sho_Traffic,
Sho_Factor                  = t.Sho_Factor,
FwdTCHPhyAvgThroughput      = t.FwdTCHPhyAvgThroughput,
FwdTCHPhyOutburstThroughput = t.FwdTCHPhyOutburstThroughput,
RevTCHPhyAvgThroughput      = t.RevTCHPhyAvgThroughput,
RevTCHPhyOutburstThroughput = t.RevTCHPhyOutburstThroughput,
FwdCCHPhyTimeSlotUseRate    = t.FwdCCHPhyTimeSlotUseRate,
RevCircuitBusyRate          = t.RevCircuitBusyRate,
DOCarrier37Traffic          = t.DOCarrier37Traffic,
DOCarrier78Traffic          = t.DOCarrier78Traffic,
DOCarrier119Traffic         = t.DOCarrier119Traffic,
RABBusyNum                  = t.RABBusyNum,
RABFreeNum                  = t.RABFreeNum,
FwdTCHPhyTxBitNum           = t.FwdTCHPhyTxBitNum,
FwdPhyUseTimeSlotDuration   = t.FwdPhyUseTimeSlotDuration,
RevTCHPhyTxBitNum           = t.RevTCHPhyTxBitNum,
RevPhyUseTimeSlotDuration   = t.RevPhyUseTimeSlotDuration,
WireRadioFNum2 = t.WireRadioFNum2,
FwdTCHPhyTimeSlotUseRate = t.FwdTCHPhyTimeSlotUseRate,
WireRadioFRate = t.WireRadioFRate,
FwdMaxBusyNum_MacIndex = t.FwdMaxBusyNum_MacIndex,
WireConnectSuccNumInA8A10 = t.WireConnectSuccNumInA8A10,
WireConnectReqNumInA8A10 = t.WireConnectReqNumInA8A10,
UserEarlyReleaseNum = t.UserEarlyReleaseNum,
WireConnectFailNum2 = t.WireConnectFailNum2,
WireConnectFailNum3 = t.WireConnectFailNum3,
UATI_AvgSetupDuration = t.UATI_AvgSetupDuration,
SessionAuthenticationSNum = t.SessionAuthenticationSNum,
FwdRLPThroughput = t.FwdRLPThroughput,
FwdRLPRxRate = t.FwdRLPRxRate,
RevRLPThroughput = t.RevRLPThroughput,
RevRLPRxRate = t.RevRLPRxRate,
SessionSetupTotalDuration=t.SessionSetupTotalDuration,
FwdRxSize=t.FwdRxSize,
FwdTxSize=t.FwdTxSize,
RevRxSize=t.RevRxSize,
RevTxSize=t.RevTxSize,
DRCApplyNum_FwdSpeed1=t.DRCApplyNum_FwdSpeed1,
DRCApplyNum_FwdSpeed2=t.DRCApplyNum_FwdSpeed2,
DRCApplyNum_FwdSpeed3=t.DRCApplyNum_FwdSpeed3
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
WireConnectSuccRate,
AT_ConnectSuccRate,
AN_ConnectSuccRate,
AT_ConnectReqNum,
AN_ConnectReqNum,
AT_ConnectSuccNum,
AN_ConnectSuccNum,
WireConnectFailNum1,
WireConnectReleaseNumInPDSN,
WireConnectReleaseNumExPDSN,
WireRadioFNum1,
WireRadioFNum3,
UATI_AssgnSuccRate,
UATI_AssgnReqNum,
UATI_AssgnSuccNum,
UATI_AssgnFailNum,
EqlUserNum,
Call_Traffic,
CE_Traffic,
Sho_Traffic,
Sho_Factor,
FwdTCHPhyAvgThroughput,
FwdTCHPhyOutburstThroughput,
RevTCHPhyAvgThroughput,
RevTCHPhyOutburstThroughput,
FwdCCHPhyTimeSlotUseRate,
RevCircuitBusyRate,
DOCarrier37Traffic,
DOCarrier78Traffic,
DOCarrier119Traffic,
RABBusyNum,
RABFreeNum,
FwdTCHPhyTxBitNum,
FwdPhyUseTimeSlotDuration,
RevTCHPhyTxBitNum,
RevPhyUseTimeSlotDuration,
WireRadioFNum2,
FwdTCHPhyTimeSlotUseRate,
WireRadioFRate,
FwdMaxBusyNum_MacIndex,
WireConnectSuccNumInA8A10,
WireConnectReqNumInA8A10,
UserEarlyReleaseNum,
WireConnectFailNum2,
WireConnectFailNum3,
UATI_AvgSetupDuration,
SessionAuthenticationSNum,
FwdRLPThroughput,
FwdRLPRxRate,
RevRLPThroughput,
RevRLPRxRate,
SessionSetupTotalDuration,
FwdRxSize,
FwdTxSize,
RevRxSize,
RevTxSize,
DRCApplyNum_FwdSpeed1,
DRCApplyNum_FwdSpeed2,
DRCApplyNum_FwdSpeed3)
values(
t.city_id,
v_date,
0,
10004,
7,
t.WireConnectSuccRate,
t.AT_ConnectSuccRate,
t.AN_ConnectSuccRate,
t.AT_ConnectReqNum,
t.AN_ConnectReqNum,
t.AT_ConnectSuccNum,
t.AN_ConnectSuccNum,
t.WireConnectFailNum1,
t.WireConnectReleaseNumInPDSN,
t.WireConnectReleaseNumExPDSN,
t.WireRadioFNum1,
t.WireRadioFNum3,
t.UATI_AssgnSuccRate,
t.UATI_AssgnReqNum,
t.UATI_AssgnSuccNum,
t.UATI_AssgnFailNum,
t.EqlUserNum,
t.Call_Traffic,
t.CE_Traffic,
t.Sho_Traffic,
t.Sho_Factor,
t.FwdTCHPhyAvgThroughput,
t.FwdTCHPhyOutburstThroughput,
t.RevTCHPhyAvgThroughput,
t.RevTCHPhyOutburstThroughput,
t.FwdCCHPhyTimeSlotUseRate,
t.RevCircuitBusyRate,
t.DOCarrier37Traffic,
t.DOCarrier78Traffic,
t.DOCarrier119Traffic,
t.RABBusyNum,
t.RABFreeNum,
t.FwdTCHPhyTxBitNum,
t.FwdPhyUseTimeSlotDuration,
t.RevTCHPhyTxBitNum,
t.RevPhyUseTimeSlotDuration,
t.WireRadioFNum2,
t.FwdTCHPhyTimeSlotUseRate,
t.WireRadioFRate,
t.FwdMaxBusyNum_MacIndex,
t.WireConnectSuccNumInA8A10,
t.WireConnectReqNumInA8A10,
t.UserEarlyReleaseNum,
t.WireConnectFailNum2,
t.WireConnectFailNum3,
t.UATI_AvgSetupDuration,
t.SessionAuthenticationSNum,
t.FwdRLPThroughput,
t.FwdRLPRxRate,
t.RevRLPThroughput,
t.RevRLPRxRate,
t.SessionSetupTotalDuration,
t.FwdRxSize,
t.FwdTxSize,
t.RevRxSize,
t.RevTxSize,
t.DRCApplyNum_FwdSpeed1,
t.DRCApplyNum_FwdSpeed2,
t.DRCApplyNum_FwdSpeed3);
commit;
















--由e实现
merge into c_perf_do_sum c_perf
using(
select
c_cell.city_id city_id,
--100*sum(nvl(e.HardHoAdd_SuccessNum,0))/decode(sum(e.HardHoAdd_ReqestNum),0,1,null,1,sum(e.HardHoAdd_ReqestNum))  HardHoSuccRate_intraAN,
--sum(nvl(e.HardHoAdd_ReqestNum,0)) HardHoReqNum_intraAN,
--sum(nvl(e.HardHoAdd_SuccessNum,0)) HardHoSuccNum_intraAN,
sum(nvl(e.HardHoAdd_SuccessNum,0))+sum(nvl(e.HardHoAdd_BlockNum,0))+sum(nvl(e.HardHo_RTCHCapFNum,0))+sum(nvl(e.HardHo_TCCTimeoutFNum,0))+sum(nvl(e.HardHoAdd_OtherFailureNum,0)) HardHoReqNum_amongAN,
sum(nvl(e.HardHoAdd_SuccessNum,0)) HardHoSuccNum_amongAN,
--100*sum(nvl(e.SrcANTgtHo_SFTSuccessNum,0)
--+nvl(e.InterANTgtHoOut_SuccessNum  ,0)
--+nvl(e.TgtANTgtHo_SFTSuccessNum    ,0)
--+nvl(e.InterANTgtHoIn_IFRSuccessNum,0))/
--decode(sum(nvl(e.SrcANTgtHo_SFTRequestNum,0)
--+nvl(e.InterANTgtHoOut_ReqestNum   ,0)
--+nvl(e.TgtANTgtHo_SFTReqestNum     ,0)
--+nvl(e.InterANTgtHoIn_IFRRequestNum,0)),0,1,null,1,sum(nvl(e.SrcANTgtHo_SFTRequestNum,0)
--+nvl(e.InterANTgtHoOut_ReqestNum   ,0)
--+nvl(e.TgtANTgtHo_SFTReqestNum     ,0)
--+nvl(e.InterANTgtHoIn_IFRRequestNum,0))) GlobalSHoSuccRate,
--sum(nvl(e.SrcANTgtHo_SFTRequestNum,0)
--+nvl(e.InterANTgtHoOut_ReqestNum   ,0)
--+nvl(e.TgtANTgtHo_SFTReqestNum     ,0)
--+nvl(e.InterANTgtHoIn_IFRRequestNum,0))  GlobalSHoReqNum,
--sum(nvl(e.SrcANTgtHo_SFTSuccessNum,0)+nvl(e.InterANTgtHoOut_SuccessNum,0)
--+nvl(e.TgtANTgtHo_SFTSuccessNum,0)+nvl(e.InterANTgtHoIn_IFRSuccessNum,0)) GlobalSHoSuccNum,
sum(nvl(e.SrcANTgtHo_SFTRequestNum,0)
+nvl(e.SrcANTgtHo_SFRReqestNum,0)
+nvl(e.SrcANTgtHo_AFRReqestNum,0)
+nvl(e.TgtANTgtHo_SFTReqestNum,0)
+nvl(e.TgtANTgtHo_SFRRequestNum,0)
+nvl(e.TgtANTgtHo_AFRReqestNum,0)) SHoReqNum_intraAN,
sum(nvl(e.SrcANTgtHo_SFTSuccessNum,0)
+nvl(e.SrcANTgtHo_SFRSuccessNum,0)
+nvl(e.SrcANTgtHo_AFRSuccessNum,0)
+nvl(e.TgtANTgtHo_SFTSuccessNum,0)
+nvl(e.TgtANTgtHo_SFRSuccessNum,0)
+nvl(e.TgtANTgtHo_AFRSuccessNum,0)) SHoSuccNum_intraAN,
--100*sum(nvl(e.HardHoAdd_SuccessNum,0))/decode(sum(e.HardHoAdd_ReqestNum),0,1,null,1,sum(e.HardHoAdd_ReqestNum))  HardHoSuccRate_amongAN
100*sum(nvl(e.HardHoAdd_SuccessNum,0))/
decode(sum(nvl(e.HardHoAdd_SuccessNum,0)+nvl(e.HardHoAdd_BlockNum,0)+nvl(e.HardHo_RTCHCapFNum,0)+nvl(e.HardHo_TCCTimeoutFNum,0)+nvl(e.HardHoAdd_OtherFailureNum,0)),null,1,0,1,
sum(nvl(e.HardHoAdd_SuccessNum,0)+nvl(e.HardHoAdd_BlockNum,0)+nvl(e.HardHo_RTCHCapFNum,0)+nvl(e.HardHo_TCCTimeoutFNum,0)+nvl(e.HardHoAdd_OtherFailureNum,0)))  HardHoSuccRate_amongAN
from C_tpd_cnt_carr_ho_do_zx e,c_carrier c,c_cell
where e.int_id = c.int_id and c.related_cell = c_cell.int_id and c_cell.vendor_id=7
and e.scan_start_time = v_date and c_cell.city_id is not null
group by c_cell.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
--HardHoSuccRate_intraAN = t.HardHoSuccRate_intraAN,
--HardHoReqNum_intraAN   = t.HardHoReqNum_intraAN,
--HardHoSuccNum_intraAN  = t.HardHoSuccNum_intraAN,
HardHoSuccRate_amongAN = t.HardHoSuccRate_amongAN,
HardHoReqNum_amongAN   = t.HardHoReqNum_amongAN,
HardHoSuccNum_amongAN  = t.HardHoSuccNum_amongAN,
--GlobalSHoSuccRate      = t.GlobalSHoSuccRate,
--GlobalSHoReqNum        = t.GlobalSHoReqNum,
--GlobalSHoSuccNum       = t.GlobalSHoSuccNum,
SHoReqNum_intraAN=t.SHoReqNum_intraAN,
SHoSuccNum_intraAN=t.SHoSuccNum_intraAN
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
--HardHoSuccRate_intraAN,
--HardHoReqNum_intraAN,
--HardHoSuccNum_intraAN,
HardHoSuccRate_amongAN,
HardHoReqNum_amongAN,
HardHoSuccNum_amongAN,
--GlobalSHoSuccRate,
--GlobalSHoReqNum,
--GlobalSHoSuccNum,
SHoReqNum_intraAN,
SHoSuccNum_intraAN)
values(
t.city_id,
v_date,
0,
10004,
7,
--t.HardHoSuccRate_intraAN,
--t.HardHoReqNum_intraAN,
--t.HardHoSuccNum_intraAN,
t.HardHoSuccRate_amongAN,
t.HardHoReqNum_amongAN,
t.HardHoSuccNum_amongAN,
--t.GlobalSHoSuccRate,
--t.GlobalSHoReqNum,
--t.GlobalSHoSuccNum,
t.SHoReqNum_intraAN,
t.SHoSuccNum_intraAN);
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
where c.cdma_freq = 37 and c.vendor_id = 7  and c.city_id is not null
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.DOCarrier37);
commit;

merge into c_perf_do_sum c_perf
using(
select
c.city_id city_id,
count(c.int_id) DOCarrier78
from c_carrier c
where c.cdma_freq = 78 and c.vendor_id = 7 and c.city_id is not null
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.DOCarrier78);
commit;

merge into c_perf_do_sum c_perf
using(
select
c.city_id city_id,
count(c.int_id) DOCarrier119
from c_carrier c
where c.cdma_freq = 119 and c.vendor_id = 7 and c.city_id is not null
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
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
where c.related_cell=c_cell.int_id and c.car_type='DO' and c.vendor_id=7
group by c_cell.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.DOCarrierTotalNum);
commit;

--delete-2011-9-2
--merge into c_perf_do_sum c_perf
--using(
--select
--c_cell.city_id city_id,
--count(a.int_id) DOCarrierTotalNum
--from C_tpd_cnt_carr_do_zx a,c_carrier c,c_cell
--where a.int_id = c.int_id and c.related_cell = c_cell.int_id
--and a.scan_start_time = v_date and c_cell.vendor_id=7 and c_cell.city_id is not null
--group by c_cell.city_id) t
--on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
--7,
--t.DOCarrierTotalNum);
--commit;

--OneDOCarrierCellNum
--TwoDOCarrierCellNum
--ThreeDOCarrierCellNum
--DOCellNum

--update-8-30
merge into c_perf_do_sum c_perf
using(
--select a.city_id,a.OneDOCarrierCellNum,b.CarrierCellNum
--from
--(
--select b.city_id,count(b.int_id) OneDOCarrierCellNum
--from
--(select related_cell int_id from
--c_carrier where cdma_freq in (37,78) and vendor_id=7
--group by city_id,related_cell having count(distinct cdma_freq)=1 ) a,c_cell b
--where a.int_id=b.int_id and b.city_id is not null
--group by b.city_id) a,
--(
--select b.city_id,count(a.int_id) CarrierCellNum from c_carrier a ,c_cell b  where a.related_cell=b.int_id
--and a.cdma_freq in (37,78) and a.vendor_id=7 and b.vendor_id=7
--and b.city_id is not null
--group by b.city_id
--) b
--where a.city_id=b.city_id(+)) t
with a as(
select
ne.int_id,
case count(c.int_id) when 1 then 1 else 0 end  OneDOCarrierCellNum,
case count(c.int_id) when 2 then 1 else 0 end  TwoDOCarrierCellNum,
case count(c.int_id) when 3 then 1 else 0 end  ThreeDOCarrierCellNum,
 count(distinct ne.int_id) DOCellNum,
 count(c.int_id) CarrierCellNum
from c_carrier c,c_cell ne
where c.related_cell=ne.int_id and c.car_type='DO' and c.vendor_id=7
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
  where ne.int_id=a.int_id and ne.vendor_id=7
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
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.OneDOCarrierCellNum,
t.TwoDOCarrierCellNum,
t.ThreeDOCarrierCellNum,
t.CarrierCellNum);
commit;

--delete-8-30
--merge into c_perf_do_sum c_perf
--using(
--select city_id,count(b.int_id) TwoDOCarrierCellNum
--from
--(select related_cell int_id from
--c_carrier where cdma_freq in (37,78) and vendor_id=7
--group by city_id,related_cell having count(distinct cdma_freq)=2 ) a,c_cell b
--where a.int_id=b.int_id and b.city_id is not null
--group by b.city_id) t
--on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
--7,
--t.TwoDOCarrierCellNum);
--commit;

--delete-8-30
--merge into c_perf_do_sum c_perf
--using(
--select
--c.city_id city_id,
--count(d.int_id) ThreeDOCarrierCellNum
--from c_cell c,c_carrier d
--where c.int_id = d.related_cell and c.do_cell=1 and numfa=3 and c.vendor_id = 7 and c.city_id is not null
--group by c.city_id) t
--on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
--when matched then update set
--ThreeDOCarrierCellNum = t.ThreeDOCarrierCellNum
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
--7,
--t.ThreeDOCarrierCellNum);
--commit;

--delete-8-30
--merge into c_perf_do_sum c_perf
--using(
--select b.city_id ,count(distinct a.related_cell) DOCellNum
--from c_carrier a,c_cell b where a.related_cell=b.int_id and b.city_id is not null and  a.cdma_freq in (37,78)
--and a.vendor_id=7 group by b.city_id) t
--on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
--7,
--t.DOCellNum);
--commit;

----------------------------------由bsc到city--------------------------------------------------------------
--由b实现
merge into c_perf_do_sum c_perf
using(
select
c.city_id city_id,
--sum(nvl(b.SessionSetupDuration,0)) UATI_AvgSetupDuration,
100*sum(nvl(b.DC_CallSNum,0)+nvl(b.PC_CallSNum,0))/
decode(sum(nvl(b.DC_CallSNum,0)+nvl(b.DC_CallFNum,0)
+nvl(b.PC_CallSNum,0)+nvl(b.PC_CallFNum,0)),0,1,null,1,sum(nvl(b.DC_CallSNum,0)
+nvl(b.DC_CallFNum,0)+nvl(b.PC_CallSNum,0)+nvl(b.PC_CallFNum,0))) User_DAAcitveSuccRate,
sum(nvl(b.DC_CallSNum,0)+nvl(b.DC_CallFNum,0)+nvl(b.PC_CallSNum,0)+nvl(b.PC_CallFNum,0)) User_DAAcitveReqNum,
sum(nvl(b.DC_CallSNum,0)+nvl(b.PC_CallSNum,0)) User_DAAcitveSuccNum,
sum(nvl(b.DC_CallSNum,0))/decode(sum(nvl(b.DC_CallSNum,0)+nvl(b.DC_CallFNum,0)),0,1,null,1,sum(nvl(b.DC_CallSNum,0)+nvl(b.DC_CallFNum,0)))*100 AT_DAAcitveSuccRate,
sum(nvl(b.DC_CallSNum,0)+nvl(b.DC_CallFNum,0)) AT_DAAcitveReqNum,
sum(nvl(b.DC_CallSNum,0)) AT_DAAcitveSuccNum,
sum(nvl(b.DC_CallFNum,0)) AT_DAAcitveFailNum,
sum(nvl(b.PC_CallSNum,0))/decode(sum(nvl(b.PC_CallSNum,0)+nvl(b.PC_CallFNum,0)),0,1,null,1,sum(nvl(b.PC_CallSNum,0)+nvl(b.PC_CallFNum,0)))*100 AN_DAAcitveSuccRate,
sum(nvl(b.PC_CallSNum,0)+nvl(b.PC_CallFNum,0)) AN_DAAcitveReqNum,
sum(nvl(b.PC_CallSNum,0)) AN_DAAcitveSuccNum,
sum(nvl(b.PC_CallFNum,0)) AN_DAAcitveFailNum,
--sum(nvl(b.dwDiscardNumforBufferLack,0)+nvl(b.dwDiscardNumforUnknownMS,0)+nvl(b.dwDiscardNumforOtherRsn,0)) FwdPSDiscardNum,
sum(nvl(b.AvgSessionNum,0)) SessionNum,
sum(nvl(b.AvgActiveSessionNum,0)) SessionNum_Active,
sum(nvl(b.AvgDormantSessionNum,0)) SessionNum_NotActive,
sum(nvl(b.dwSDU2PCFFlux/1024/1024,0)) PCFRevDataSize,
sum(nvl(b.dwPDSN2PCFFlux/1024/1024,0)) PCFFwdDataSize,
sum(nvl(b.dwSDU2PCFPktNum,0)+nvl(b.dwRDiscardPktforBufLack,0)+nvl(b.dwRDiscardPktforMS,0)+nvl(b.dwRDiscardPktforOthers,0))/1000 PCFRevPSMsg,
sum(nvl(b.dwPDSN2PCFPktNum,0)+nvl(b.dwFDiscardPktforBufLack,0)+nvl(b.dwFDiscardPktforMS,0)+nvl(b.dwFDiscardPktforOthers,0))/1000 PCFFwdPSMsg,
sum(nvl(b.dwRDiscardPktforBufLack,0)+nvl(b.dwRDiscardPktforMS,0)+nvl(b.dwRDiscardPktforOthers,0))/1000 RevPSDiscardNum,
sum(nvl(b.dwFDiscardPktforBufLack,0)+nvl(b.dwFDiscardPktforMS,0)+nvl(b.dwFDiscardPktforOthers,0))/1000 FwdPSDiscardNum
from C_tpd_cnt_bsc_mdu_do_zx b,c_bsc c
where b.unique_rdn = c.unique_rdn and c.vendor_id=7 and c.city_id is not null
and b.scan_start_time = v_date
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
--UATI_AvgSetupDuration = t.UATI_AvgSetupDuration,
User_DAAcitveSuccRate = t.User_DAAcitveSuccRate,
User_DAAcitveReqNum   = t.User_DAAcitveReqNum,
User_DAAcitveSuccNum  = t.User_DAAcitveSuccNum,
AT_DAAcitveSuccRate   = t.AT_DAAcitveSuccRate,
AT_DAAcitveReqNum     = t.AT_DAAcitveReqNum,
AT_DAAcitveSuccNum    = t.AT_DAAcitveSuccNum,
AT_DAAcitveFailNum    = t.AT_DAAcitveFailNum,
AN_DAAcitveSuccRate   = t.AN_DAAcitveSuccRate,
AN_DAAcitveReqNum     = t.AN_DAAcitveReqNum,
AN_DAAcitveSuccNum    = t.AN_DAAcitveSuccNum,
AN_DAAcitveFailNum    = t.AN_DAAcitveFailNum,
--FwdPSDiscardNum       = t.FwdPSDiscardNum,
SessionNum=t.SessionNum,
SessionNum_Active=t.SessionNum_Active,
SessionNum_NotActive=t.SessionNum_NotActive,
PCFRevDataSize=t.PCFRevDataSize,
PCFFwdDataSize=t.PCFFwdDataSize,
PCFRevPSMsg=t.PCFRevPSMsg,
PCFFwdPSMsg=t.PCFFwdPSMsg,
RevPSDiscardNum=t.RevPSDiscardNum,
FwdPSDiscardNum=t.FwdPSDiscardNum
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
--UATI_AvgSetupDuration,
User_DAAcitveSuccRate,
User_DAAcitveReqNum,
User_DAAcitveSuccNum,
AT_DAAcitveSuccRate,
AT_DAAcitveReqNum,
AT_DAAcitveSuccNum,
AT_DAAcitveFailNum,
AN_DAAcitveSuccRate,
AN_DAAcitveReqNum,
AN_DAAcitveSuccNum,
AN_DAAcitveFailNum,
--FwdPSDiscardNum,
SessionNum,
SessionNum_Active,
SessionNum_NotActive,
PCFRevDataSize,
PCFFwdDataSize,
PCFRevPSMsg,
PCFFwdPSMsg,
RevPSDiscardNum,
FwdPSDiscardNum)
values(
t.city_id,
v_date,
0,
10004,
7,
--t.UATI_AvgSetupDuration,
t.User_DAAcitveSuccRate,
t.User_DAAcitveReqNum,
t.User_DAAcitveSuccNum,
t.AT_DAAcitveSuccRate,
t.AT_DAAcitveReqNum,
t.AT_DAAcitveSuccNum,
t.AT_DAAcitveFailNum,
t.AN_DAAcitveSuccRate,
t.AN_DAAcitveReqNum,
t.AN_DAAcitveSuccNum,
t.AN_DAAcitveFailNum,
--t.FwdPSDiscardNum,
t.SessionNum,
t.SessionNum_Active,
t.SessionNum_NotActive,
t.PCFRevDataSize,
t.PCFFwdDataSize,
t.PCFRevPSMsg,
t.PCFFwdPSMsg,
t.RevPSDiscardNum,
t.FwdPSDiscardNum);
commit;




--由c实现
merge into c_perf_do_sum c_perf
using(
select
t.city_id city_id,
sum(nvl(c.AuthenticationSNum,0)) SessionAuthenticationSNum,
--sum(nvl(c.SessionNegoSNum_subnet,0))/decode(sum(nvl(c.SessionNegoSNum_subnet,0)+nvl(c.SessionNegoFNum_subnet,0)),0,1,null,1,sum(nvl(c.SessionNegoSNum_subnet,0)+nvl(c.SessionNegoFNum_subnet,0)))*100 SessionNegoSRate,
round(sum(nvl(c.SessionNegoSNum,0))/decode(sum(nvl(c.SessionNegoSNum,0)+nvl(c.SessionNegoFNum,0)),0,1,null,1,sum(nvl(c.SessionNegoSNum,0)+nvl(c.SessionNegoFNum,0))),5)*100 SessionNegoSRate,
sum(nvl(c.SessionNegoSNum,0)) SessionNegoSNum,
sum(nvl(c.SessionNegoFNum,0)) SessionNegoFNum,
sum(nvl(c.A13DA_HandoffSNum_subnet,0)+nvl(c.A13DD_HandoffSNum_subnet,0))/decode(sum(nvl(c.A13DA_HandoffFNum_subnet,0)+nvl(c.A13DD_HandoffFNum_subnet,0)+nvl(c.A13DA_HandoffSNum_subnet,0)+nvl(c.A13DD_HandoffSNum_subnet,0)),0,1,null,1,sum(nvl(c.A13DA_HandoffFNum_subnet,0)+nvl(c.A13DD_HandoffFNum_subnet,0)+nvl(c.A13DA_HandoffSNum_subnet,0)+nvl(c.A13DD_HandoffSNum_subnet,0)))*100 A13_HandoffSRate,
sum(nvl(c.A13DA_HandoffFNum_subnet,0)+nvl(c.A13DA_HandoffSNum_subnet,0)) A13_HandoffNum,
sum(nvl(c.A13DA_HandoffSNum_subnet,0)) A13_HandoffSNum,
sum(nvl(c.ActiveSessionNum,0)+nvl(c.SessionNum,0)-nvl(c.ActiveSessionNum,0)) SessionNum,
sum(nvl(c.ActiveSessionNum,0)) SessionNum_Active,
sum(nvl(c.SessionNum,0)- nvl(c.ActiveSessionNum,0)) SessionNum_NotActive,
sum(nvl(c.ATConnectionReqNum,0))/decode(sum(c.BssapPagingNum),0,1,null,1,sum(c.BssapPagingNum))*100 PageResponceRate,
sum(nvl(c.BssapPagingNum,0)) PageReqNum,
sum(nvl(c.ATConnectionReqNum,0)) PageResponceNum,
sum(BscToBtsDataSize)*8/1000/3600 thrput_bsc2bts,
sum(BtsToBscDataSize)*8/1000/3600 thrput_bts2bsc
from C_tpd_cnt_bsc_do_zx c,c_bsc t
where c.int_id = t.int_id and t.vendor_id=7
and c.scan_start_time = v_date and t.city_id is not null
group by t.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
SessionAuthenticationSNum = t.SessionAuthenticationSNum,
SessionNegoSRate          = t.SessionNegoSRate,
SessionNegoSNum           = t.SessionNegoSNum,
SessionNegoFNum           = t.SessionNegoFNum,
A13_HandoffSRate          = t.A13_HandoffSRate,
A13_HandoffNum            = t.A13_HandoffNum,
A13_HandoffSNum           = t.A13_HandoffSNum,
SessionNum                = t.SessionNum,
SessionNum_Active         = t.SessionNum_Active,
SessionNum_NotActive      = t.SessionNum_NotActive,
PageResponceRate          = t.PageResponceRate,
PageReqNum                = t.PageReqNum,
PageResponceNum           = t.PageResponceNum,
thrput_bsc2bts = t.thrput_bsc2bts,
thrput_bts2bsc = t.thrput_bts2bsc
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
SessionAuthenticationSNum,
SessionNegoSRate,
SessionNegoSNum,
SessionNegoFNum,
A13_HandoffSRate,
A13_HandoffNum,
A13_HandoffSNum,
SessionNum,
SessionNum_Active,
SessionNum_NotActive,
PageResponceRate,
PageReqNum,
PageResponceNum,
thrput_bsc2bts,
thrput_bts2bsc)
values(
t.city_id,
v_date,
0,
10004,
7,
t.SessionAuthenticationSNum,
t.SessionNegoSRate,
t.SessionNegoSNum,
t.SessionNegoFNum,
t.A13_HandoffSRate,
t.A13_HandoffNum,
t.A13_HandoffSNum,
t.SessionNum,
t.SessionNum_Active,
t.SessionNum_NotActive,
t.PageResponceRate,
t.PageReqNum,
t.PageResponceNum,
t.thrput_bsc2bts,
t.thrput_bts2bsc);
commit;


--由d实现
--merge into c_perf_do_sum c_perf
--using(
--select
--c.city_id city_id,
--sum(nvl(d.FwdTransmitBytes,0))*8.0/1000/3600 FwdRLPThroughput,
--sum(nvl(d.FwdRetransmitBytes,0))/decode(sum(d.FwdTransmitBytes),0,1,null,1,sum(d.FwdTransmitBytes))*100 FwdRLPRxRate,
--sum(nvl(d.RevReceiveByteNum,0))*8.0/1000/3600 RevRLPThroughput,
--sum(nvl(d.FwdRetransmitBytes,0)) FwdRxSize,
--sum(nvl(d.FwdTransmitBytes,0)) FwdTxSize,
--sum(nvl(d.RevReceiveByteNum,0)) RevTxSize
--from C_tpd_cnt_bsc_flux_do_zx d,c_bsc c
--where d.unique_rdn = c.unique_rdn and c.vendor_id=7
--and d.scan_start_time = v_date and c.city_id is not null
--group by c.city_id) t
--on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
--when matched then update set
--FwdRLPThroughput = t.FwdRLPThroughput,
--FwdRLPRxRate     = t.FwdRLPRxRate,
--RevRLPThroughput = t.RevRLPThroughput,
----FwdRxSize        = t.FwdRxSize,
----FwdTxSize        = t.FwdTxSize,
----RevTxSize        = t.RevTxSize
--when not matched then insert(
--int_id,
--scan_start_time,
--sum_level,
--ne_type,
--vendor_id,
--FwdRLPThroughput,
--FwdRLPRxRate,
--RevRLPThroughput,
----FwdRxSize,
----FwdTxSize,
----RevTxSize)
--values(
--t.city_id,
--v_date,
--0,
--10004,
--7,
--t.FwdRLPThroughput,
--t.FwdRLPRxRate,
--t.RevRLPThroughput,
----t.FwdRxSize,
----t.FwdTxSize,
----t.RevTxSize);
--commit;



--complicate column
--sum(b.SessionSetupDuration)*sum(a.SetupSuccessNum) SessionSetupTotalDuration
--merge into c_perf_do_sum c_perf
--using(
--select
--t1.city_id city_id,
--t1.SessionSetupDuration * t2.SetupSuccessNum SessionSetupTotalDuration
--from
--(
--select c.city_id city_id,
--sum(nvl(b.SessionSetupDuration,0)) SessionSetupDuration
--from C_tpd_cnt_bsc_mdu_do_zx b,c_bsc c
--where b.unique_rdn = c.unique_rdn and c.vendor_id=7
--and b.scan_start_time = v_date
--group by c.city_id) t1,
--(
--select c.city_id city_id,
--sum(nvl(a.SetupSuccessNum,0)) SetupSuccessNum
--from C_tpd_cnt_carr_do_zx a,c_carrier c
--where a.int_id = c.int_id and c.vendor_id=7
--and a.scan_start_time = v_date
--group by c.city_id) t2
--where t1.city_id = t2.city_id and t1.city_id is not null) t
--on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
--when matched then update set
--SessionSetupTotalDuration = t.SessionSetupTotalDuration
--when not matched then insert(
--int_id,
--scan_start_time,
--sum_level,
--ne_type,
--vendor_id,
--SessionSetupTotalDuration)
--values(
--t.city_id,
--v_date,
--0,
--10004,
--7,
--t.SessionSetupTotalDuration);
--commit;

--BtsTotalNum
--OnecarrierBtsNum
--TwocarrierBtsNum
--threecarrierBtsNum
--FourcarrierBtsNum


merge into c_perf_do_sum c_perf
using(
select b.city_id ,count(distinct a.related_bts) BtsTotalNum
from c_carrier a,c_cell b
where a.related_cell=b.int_id and b.city_id is not null and  a.car_type='DO'
and a.vendor_id=7 group by b.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.BtsTotalNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.city_id,count(distinct a.related_bts) OnecarrierBtsNum
from
(select related_bts from
c_carrier where car_type='DO' and vendor_id=7
group by city_id,related_bts having count(distinct car_type)=1 ) a,c_cell b
where a.related_bts=b.related_bts and b.city_id is not null
group by b.city_id ) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.OnecarrierBtsNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.city_id,count(distinct a.related_bts) TwocarrierBtsNum
from
(select related_bts from
c_carrier where  car_type='DO' and vendor_id=7
group by city_id,related_bts having count(distinct car_type)=2 ) a,c_cell b
where a.related_bts=b.related_bts and b.city_id is not null
group by b.city_id ) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.TwocarrierBtsNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.city_id,count(distinct a.related_bts) ThreecarrierBtsNum
from
(select related_bts from
c_carrier where  car_type='DO' and vendor_id=7
group by city_id,related_bts having count(distinct car_type)=3) a,c_cell b
where a.related_bts=b.related_bts and b.city_id is not null
group by b.city_id ) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.ThreecarrierBtsNum);
commit;


merge into c_perf_do_sum c_perf
using(
select b.city_id,count(distinct a.related_bts) FourcarrierBtsNum
from
(select related_bts from
c_carrier where  car_type='DO' and vendor_id=7
group by city_id,related_bts having count(distinct car_type)=4) a,c_cell b
where a.related_bts=b.related_bts and b.city_id is not null
group by b.city_id ) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.FourcarrierBtsNum);
commit;


--from g
--RevCEMaxUseRate
--RevCEMaxBusyNum
--RevCEAvailNum


merge into c_perf_do_sum c_perf
using(
select
c.city_id city_id,
sum(g.MaxBusyCENum)/
decode(sum(g.CEReliableNum+g.CE5500ReliableNum),0,1,null,1,sum(g.CEReliableNum+g.CE5500ReliableNum))* 100 RevCEMaxUseRate,
sum(nvl(g.MaxBusyCENum,0)) RevCEMaxBusyNum,
sum(nvl(g.CEReliableNum,0)+nvl(g.CE5500ReliableNum,0)) RevCEAvailNum
from C_tpd_cnt_bts_do_zx g,c_bts c
where g.int_id = c.int_id and g.scan_start_time = v_date and c.vendor_id = 7 and c.city_id is not null
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.RevCEMaxUseRate,
t.RevCEMaxBusyNum,
t.RevCEAvailNum);
commit;

merge into c_perf_do_sum c_perf
using(
with temp1 as (
select b.int_id int_id,
sum((nvl(AvgFlux_IP,0)+nvl(AvgFlux_HIRS,0))/1000) AbisAvgUseBandWidth
from C_tpd_cnt_bts_E1_zx a,c_bts b where a.Unique_rdn=b.Unique_rdn and a.scan_start_time=v_date
and a.direction=0
group by b.int_id)
select  c.city_id city_id,
sum(AbisAvgUseBandWidth) AbisAvgUseBandWidth
from temp1 a,c_bts c
where a.int_id=c.int_id
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
AbisAvgUseBandWidth = t.AbisAvgUseBandWidth
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
AbisAvgUseBandWidth)
values(
t.city_id,
v_date,
0,
10004,
7,
t.AbisAvgUseBandWidth);
commit;

merge into c_perf_do_sum c_perf
using(
with temp1 as
(select b.int_id int_id,
count(a.Direction)*1937.5  AbisPortBandWidth
from C_tpd_cnt_bts_E1_zx a,c_bts b where a.Unique_rdn=b.Unique_rdn  and a.scan_start_time=v_date
and a.direction=0
group by b.int_id)
select c.city_id city_id,
sum(AbisPortBandWidth) AbisPortBandWidth
from temp1 a,c_bts c
where a.int_id=c.int_id
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
AbisPortBandWidth = t.AbisPortBandWidth
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
AbisPortBandWidth)
values(
t.city_id,
v_date,
0,
10004,
7,
t.AbisPortBandWidth);
commit;

----------------add by Lv------------
merge into c_perf_do_sum c_perf
using(
with a as(
select
b.city_id city_id,
sum(a.Common_Call_SetupTime+a.Soft_SetupTime)    ConnectSetupTotalDuration
from C_tpd_cnt_carr_do_zx a ,c_carrier b
where a.int_id=b.int_id and a.scan_start_time = v_date and b.vendor_id=7
group by b.city_id
),
c as(
select
b.city_id city_id,
sum(a.ConnectTime)  ConnectUseTotalDuration
from C_tpd_cnt_bsc_carr_do_zx a ,c_bsc b
where a.unique_rdn=b.unique_rdn and a.scan_start_time = v_date and b.vendor_id=7
group by b.city_id
)
select
 a.city_id,
 a.ConnectSetupTotalDuration,
 c.ConnectUseTotalDuration,
 --a.ConnectSetupTotalDuration/decode((nvl(b.AT_ConnectSuccNum,0)+nvl(b.AN_ConnectSuccNum,0)),null,1,0,1,(nvl(b.AT_ConnectSuccNum,0)+nvl(b.AN_ConnectSuccNum,0)))  ConnectAvgSetupDuration,
 --a.ConnectUseTotalDuration /decode((nvl(b.AT_ConnectSuccNum,0)+nvl(b.AN_ConnectSuccNum,0)),null,1,0,1,(nvl(b.AT_ConnectSuccNum,0)+nvl(b.AN_ConnectSuccNum,0)))   ConnectAvgUseDuration,
 ---------2010--8-19----------
 100*b.FwdMaxBusyNum_MacIndex/115  FwdMaxUseRate_MacIndex,
 b.AbisAvgUseBandWidth/decode(b.AbisPortBandWidth,null,1,0,1,b.AbisPortBandWidth)*100 ABisBWAvgUseRate,
 100*b.WireConnectSuccNumInA8A10/decode(b.WireConnectReqNumInA8A10,null,1,0,1,b.WireConnectReqNumInA8A10) WireConnectSuccRateInA8A10,
 100*b.UserEarlyReleaseNum/decode((nvl(b.AT_ConnectReqNum,0)+nvl(b.AN_ConnectReqNum,0)),null,1,0,1,(nvl(b.AT_ConnectReqNum,0)+nvl(b.AN_ConnectReqNum,0)))  UserEarlyReleaseRate,
 (nvl(b.WireConnectReleaseNumInPDSN,0)-nvl(b.ReleaseNumByPDSN,0)) WireConnectReleaseNumExPDSN,
 100*(nvl(b.ReleaseNumByPDSN,0)+nvl(b.WireRadioFNum1,0)+nvl(b.WireRadioFNum2,0)+nvl(b.WireRadioFNum3,0))/
 decode((nvl(b.WireConnectReleaseNumInPDSN,0)+nvl(b.WireRadioFNum1,0)+nvl(b.WireRadioFNum2,0)+nvl(b.WireRadioFNum3,0)),
 null,1,0,1,(nvl(b.WireConnectReleaseNumInPDSN,0)+nvl(b.WireRadioFNum1,0)+nvl(b.WireRadioFNum2,0)+nvl(b.WireRadioFNum3,0))) NetWorkRadioFRate,
 100*b.DRCApplyNum_FwdSpeed1/decode((nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0)),null,1,
 0,1,(nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0))) DRCApplyRate_FwdSpeed1,
 100*b.DRCApplyNum_FwdSpeed2/decode((nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0)),null,1,
 0,1,(nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0))) DRCApplyRate_FwdSpeed2,
 100*b.DRCApplyNum_FwdSpeed3/decode((nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0)),null,1,
 0,1,(nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0))) DRCApplyRate_FwdSpeed3,
 100*b.SessionAuthenticationSNum/decode((nvl(b.SessionAuthenticationSNum,0)+nvl(b.SessionAuthenticationRejNum,0)+nvl(b.SessionAuthenticationFNum,0))
 ,null,1,0,1,(nvl(b.SessionAuthenticationSNum,0)+nvl(b.SessionAuthenticationRejNum,0)+nvl(b.SessionAuthenticationFNum,0))) SessionAuthenticationSRate,
 (nvl(b.SessionAuthenticationSNum,0)+nvl(b.SessionAuthenticationRejNum,0)+nvl(b.SessionAuthenticationFNum,0)) SessionAuthenticationReqNum,
 b.RevPSDiscardNum/decode(b.PCFRevPSMsg,null,1,0,1,b.PCFRevPSMsg) RevPSDiscardRate,
 b.FwdPSDiscardNum/decode(b.PCFFwdPSMsg,null,1,0,1,b.PCFFwdPSMsg) FwdPSDiscardRate,
 100*b.RevRxSize/decode(b.RevTxSize,null,1,0,1,b.RevTxSize) RevRLPRxRate,
 100*b.SHoSuccNum_intraAN/decode(b.SHoReqNum_intraAN,null,1,0,1,b.SHoReqNum_intraAN) SHoSuccRate_intraAN,
 b.SHoSuccNum_amongAN/decode(b.SHoReqNum_amongAN,null,1,0,1,b.SHoReqNum_amongAN) SHoSuccRate_amongAN
 -----------------------------
from a,c_perf_do_sum b,c
where a.city_id=b.int_id and b.int_id=c.city_id and b.ne_type=10004 and  b.scan_start_time=v_date and b.sum_level=0 and b.vendor_id=7 and a.city_id is not null
) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
ConnectSetupTotalDuration=t.ConnectSetupTotalDuration,
ConnectUseTotalDuration  =t.ConnectUseTotalDuration,
--ConnectAvgSetupDuration  =t.ConnectAvgSetupDuration,
--ConnectAvgUseDuration    =t.ConnectAvgUseDuration,
---------2010-08-19--------
FwdMaxUseRate_MacIndex      =t.FwdMaxUseRate_MacIndex,
ABisBWAvgUseRate            =t.ABisBWAvgUseRate,
WireConnectSuccRateInA8A10  =t.WireConnectSuccRateInA8A10,
UserEarlyReleaseRate        =t.UserEarlyReleaseRate,
WireConnectReleaseNumExPDSN =t.WireConnectReleaseNumExPDSN,
NetWorkRadioFRate           =t.NetWorkRadioFRate,
DRCApplyRate_FwdSpeed1      =t.DRCApplyRate_FwdSpeed1,
DRCApplyRate_FwdSpeed2      =t.DRCApplyRate_FwdSpeed2,
DRCApplyRate_FwdSpeed3      =t.DRCApplyRate_FwdSpeed3,
SessionAuthenticationSRate  =t.SessionAuthenticationSRate,
SessionAuthenticationReqNum =t.SessionAuthenticationReqNum,
RevPSDiscardRate            =t.RevPSDiscardRate,
FwdPSDiscardRate            =t.FwdPSDiscardRate,
RevRLPRxRate                =t.RevRLPRxRate,
SHoSuccRate_intraAN         =t.SHoSuccRate_intraAN,
SHoSuccRate_amongAN         =t.SHoSuccRate_amongAN
---------------------------
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
ConnectSetupTotalDuration,
ConnectUseTotalDuration,
--ConnectAvgSetupDuration,
--ConnectAvgUseDuration,
---------2010-08-19--------
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
SessionAuthenticationReqNum,
RevPSDiscardRate,
FwdPSDiscardRate,
RevRLPRxRate,
SHoSuccRate_intraAN,
SHoSuccRate_amongAN
---------------------------
)
values(
t.city_id,
v_date,
0,
10004,
7,
t.ConnectSetupTotalDuration,
t.ConnectUseTotalDuration,
--t.ConnectAvgSetupDuration,
--t.ConnectAvgUseDuration,
---------2010-08-19--------
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
t.SessionAuthenticationReqNum,
t.RevPSDiscardRate,
t.FwdPSDiscardRate,
t.RevRLPRxRate,
t.SHoSuccRate_intraAN,
t.SHoSuccRate_amongAN
---------------------------
);
commit;



merge into c_perf_do_sum c_perf
using(
select
c.city_id city_id,
avg(h.AvgUseRate) PCFMeanCpuAvgLoad
from C_tpd_cnt_board_do_zx h,c_bsc c
where h.unique_rdn = c.unique_rdn
and h.BoardName = 23
and h.scan_start_time = v_date
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
PCFMeanCpuAvgLoad = t.PCFMeanCpuAvgLoad
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
PCFMeanCpuAvgLoad)
values(
t.city_id,
v_date,
0,
10004,
7,
t.PCFMeanCpuAvgLoad);
commit;

merge into c_perf_do_sum c_perf
using(
select c.city_id city_id,
count(distinct a.int_id)*20000  PCFMaxHRPDSessionNum,
count(distinct a.int_id)*20000  PCFMaxActiveHRPDSessionNum,
count(distinct a.int_id)*1000  PCFUplinkThroughputRate,
count(distinct a.int_id)*1000 PCFDownlinkThroughputRate
 from c_pcf a,c_bsc c
where a.related_bsc=c.int_id and a.vendor_id=7
group by  c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
PCFMaxHRPDSessionNum = t.PCFMaxHRPDSessionNum,
PCFMaxActiveHRPDSessionNum = t.PCFMaxActiveHRPDSessionNum,
PCFUplinkThroughputRate = t.PCFUplinkThroughputRate,
PCFDownlinkThroughputRate = t.PCFDownlinkThroughputRate
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
PCFMaxHRPDSessionNum,
PCFMaxActiveHRPDSessionNum,
PCFUplinkThroughputRate,
PCFDownlinkThroughputRate)
values(
t.city_id,
v_date,
0,
10004,
7,
t.PCFMaxHRPDSessionNum,
t.PCFMaxActiveHRPDSessionNum,
t.PCFUplinkThroughputRate,
t.PCFDownlinkThroughputRate);
commit;


merge into c_perf_do_sum c_perf
using (
with temp1 as
(select b.city_id city_id,
sum(nvl(SetupTime,0)) SetupTime,
sum(nvl(ConnectTime,0)) ConnectTime,
sum(nvl(RlsSNum,0))  RlsSNum,
sum(nvl(AirlinkLostDropNum,0))  AirlinkLostDropNum,
sum(nvl(HHODropNum,0)) HHODropNum,
sum(nvl(OtherDropNum,0)) OtherDropNum,
sum(nvl(PDSNReleaseNum,0)) PDSNReleaseNum
from C_tpd_cnt_bsc_carr_do_zx a,c_bsc b
where a.unique_rdn=b.unique_rdn and a.scan_start_time=v_date
group by b.city_id),
temp2 as(
select
c.city_id city_id,
sum(nvl(CMO_CallSNum,0)) CMO_CallSNum,
sum(nvl(soft_CMO_CallSuccessNum,0)) soft_CMO_CallSuccessNum,
sum(nvl(CMT_CallSNum,0)) CMT_CallSNum,
sum(nvl(soft_CMT_CallSuccessNum,0)) soft_CMT_CallSuccessNum,
sum(nvl(FMT_CallSNum,0)) FMT_CallSNum,
sum(nvl(soft_FMT_CallSuccessNum,0)) soft_FMT_CallSuccessNum
from C_tpd_cnt_carr_do_zx a,c_carrier c
where a.int_id=c.int_id and a.scan_start_time=v_date
group by  c.city_id)
select
temp1.city_id city_id,
(temp1.SetupTime)/(temp2.CMO_CallSNum
+temp2.soft_CMO_CallSuccessNum
+temp2.CMT_CallSNum
+temp2.soft_CMT_CallSuccessNum
+temp2.FMT_CallSNum
+temp2.soft_FMT_CallSuccessNum) ConnectAvgSetupDuration
--temp1.ConnectTime/(temp1.RlsSNum+temp1.AirlinkLostDropNum+temp1.HHODropNum+temp1.OtherDropNum+temp1.PDSNReleaseNum) ConnectAvgUseDuration
from temp1,temp2
where temp1.city_id=temp2.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
ConnectAvgSetupDuration = t.ConnectAvgSetupDuration
--ConnectAvgUseDuration = t.ConnectAvgUseDuration
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
ConnectAvgSetupDuration)
--ConnectAvgUseDuration)
values(
t.city_id,
v_date,
0,
10004,
7,
t.ConnectAvgSetupDuration);
--t.ConnectAvgUseDuration);
commit;


--add-2011-9-26
--ConnectAvgUseDuration
merge into c_perf_do_sum c_perf
using(
--select
--c.city_id city_id,
--avg(nvl(a.ConnectTime,0)/
--decode(nvl(a.RlsSNum,0)+nvl(a.AirlinkLostDropNum,0)+nvl(a.HHODropNum,0)+nvl(a.OtherDropNum,0)+nvl(a.PDSNReleaseNum,0),
--0,1,null,1,
--nvl(a.RlsSNum,0)+nvl(a.AirlinkLostDropNum,0)+nvl(a.HHODropNum,0)+nvl(a.OtherDropNum,0)+nvl(a.PDSNReleaseNum,0))) ConnectAvgUseDuration
--from C_tpd_cnt_bsc_carr_do_zx a,c_carrier c
--where a.int_id=c.int_id   and a.scan_start_time=v_date
--group by city_id
with a as(
select
b.city_id city_id,
decode(sum(nvl(a.CMO_CallSNum,0)+nvl(a.soft_CMO_CallSuccessNum,0)+nvl(a.CMT_CallSNum,0)+nvl(a.soft_CMT_CallSuccessNum,0)+nvl(a.FMT_CallSNum,0)+nvl(a.soft_FMT_CallSuccessNum,0)),null,1,0,1,
sum(nvl(a.CMO_CallSNum,0)+nvl(a.soft_CMO_CallSuccessNum,0)+nvl(a.CMT_CallSNum,0)+nvl(a.soft_CMT_CallSuccessNum,0)+nvl(a.FMT_CallSNum,0)+nvl(a.soft_FMT_CallSuccessNum,0)))
ConnectAvgUseDuration_down
from C_tpd_cnt_carr_do_zx a ,c_carrier b
where a.int_id=b.int_id and a.scan_start_time = v_date and b.vendor_id=7
group by b.city_id
),
c as(
select
b.city_id city_id,
sum(a.ConnectTime)  ConnectAvgUseDuration_up
from C_tpd_cnt_bsc_carr_do_zx a ,c_bsc b
where a.unique_rdn=b.unique_rdn and a.scan_start_time = v_date and b.vendor_id=7
group by b.city_id
)
select
c.city_id city_id,
100*ConnectAvgUseDuration_up/ConnectAvgUseDuration_down ConnectAvgUseDuration

from a,c
where  a.city_id=c.city_id and a.city_id is not null
) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
ConnectAvgUseDuration          = t.ConnectAvgUseDuration
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
ConnectAvgUseDuration)
values(
t.city_id,
v_date,
0,
10004,
7,
t.ConnectAvgUseDuration);
commit;


--add-2011-9-1
--add--BusyerBtsNum--FreeBtsNum
merge into c_perf_do_sum c_perf
using(
with temp as
(select
c.int_id,
c.city_id  city_id,
scan_start_time,
--update-2011-9-1
--case when FwdTCHPhyTimeSlotUseRate>=0.7 and EquUserNum>=4  then 1 else 0 end BusyerBtsNum ,
case when (a.RevAFwdTCHSendSlotNum+a.Rls0FwdTCHSendSlotNum)*8.0/ 3600>=0.7 and a.EquUserNum>=4  then 1 else 0 end BusyerBtsNum,
--case when FwdTCHPhyTimeSlotUseRate<=0.5 and EquUserNum<=1   then 1 else 0 end FreeBtsNum
case when (a.RevAFwdTCHSendSlotNum+a.Rls0FwdTCHSendSlotNum)*8.0/ 3600<=0.7 and a.EquUserNum<=1  then 1 else 0 end FreeBtsNum
from C_tpd_cnt_carr_do_zx a,c_carrier c
where a.int_id = c.int_id
and a.scan_start_time = v_date)
select  temp.city_id city_id,
case when sum(BusyerBtsNum)>=1 then 1 else 2 end BusyerBtsNum,
case when sum(FreeBtsNum)<=1 then 0 else 2 end FreeBtsNum
from temp
where scan_start_time=v_date
group by city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
BusyerBtsNum         = t.BusyerBtsNum,
FreeBtsNum          = t.FreeBtsNum
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
7,
t.BusyerBtsNum,
t.FreeBtsNum);
commit;




merge into c_perf_do_sum c_perf
using(
select
c.city_id city_id,
sum(nvl(j.SrcANTgtHo_SFTSuccessNum,0)
+nvl(j.SrcANTgtHo_SFRSuccessNum   ,0)
+nvl(j.InterANTgtHoOut_SuccessNum     ,0)
+nvl(j.SrcANTgtHo_AFRSuccessNum,0)
+nvl(j.TgtANTgtHo_SFRSuccessNum,0)
+nvl(j.TgtANTgtHo_SFRSuccessNum,0)
+nvl(j.InterANTgtHoIn_SuccessNum,0)
+nvl(j.TgtANTgtHo_AFRSuccessNum,0))/decode(sum(nvl(j.SrcANTgtHo_SFTReqestNum,0)
+nvl(j.SrcANTgtHo_SFRReqestNum  ,0)
+nvl(j.InterANTgtHoOut_ReqestNum    ,0)
+nvl(j.SrcANTgtHo_AFRReqestNum,0)
+nvl(j.TgtANTgtHo_SFTReqestNum,0)
+nvl(j.TgtANTgtHo_SFRReqestNum,0)
+nvl(j.InterANTgtHoIn_ReqestNum,0)
+nvl(j.TgtANTgtHo_AFRReqestNum,0)),0,1,null,1,sum(nvl(j.SrcANTgtHo_SFTReqestNum,0)
+nvl(j.SrcANTgtHo_SFRReqestNum  ,0)
+nvl(j.InterANTgtHoOut_ReqestNum    ,0)
+nvl(j.SrcANTgtHo_AFRReqestNum,0)
+nvl(j.TgtANTgtHo_SFTReqestNum,0)
+nvl(j.TgtANTgtHo_SFRReqestNum,0)
+nvl(j.InterANTgtHoIn_ReqestNum,0)
+nvl(j.TgtANTgtHo_AFRReqestNum,0)))*100 GlobalSHoSuccRate,
sum(nvl(j.SrcANTgtHo_SFTReqestNum,0)
+nvl(j.SrcANTgtHo_SFRReqestNum  ,0)
+nvl(j.InterANTgtHoOut_ReqestNum    ,0)
+nvl(j.SrcANTgtHo_AFRReqestNum,0)
+nvl(j.TgtANTgtHo_SFTReqestNum,0)
+nvl(j.TgtANTgtHo_SFRReqestNum,0)
+nvl(j.InterANTgtHoIn_ReqestNum,0)
+nvl(j.TgtANTgtHo_AFRReqestNum,0))  GlobalSHoReqNum,
sum(nvl(j.SrcANTgtHo_SFTSuccessNum,0)
+nvl(j.SrcANTgtHo_SFRSuccessNum   ,0)
+nvl(j.InterANTgtHoOut_SuccessNum     ,0)
+nvl(j.SrcANTgtHo_AFRSuccessNum,0)
+nvl(j.TgtANTgtHo_SFRSuccessNum,0)
+nvl(j.TgtANTgtHo_SFRSuccessNum,0)
+nvl(j.InterANTgtHoIn_SuccessNum,0)
+nvl(j.TgtANTgtHo_AFRSuccessNum,0)) GlobalSHoSuccNum,
sum(nvl(j.SrcANTgtHo_IFRReqestNum,0)+(nvl(j.TgtANTgtHo_IFRReqestNum,0))) HardHoReqNum_intraAN,
sum(nvl(j.SrcANTgtHo_IFRSuccessNum,0)+(nvl(j.TgtANTgtHo_IFRSuccessNum,0))) HardHoSuccNum_intraAN,
100*sum(nvl(j.HardHoAdd_SuccessNum,0))/decode(sum(j.HardHoAdd_ReqestNum),0,1,null,1,sum(j.HardHoAdd_ReqestNum))  HardHoSuccRate_amongAN,
--sum(nvl(j.SrcANTgtHo_IFRReqestNum,0)+nvl(j.TgtANTgtHo_IFRReqestNum,0))/decode(sum(nvl(j.SrcANTgtHo_IFRSuccessNum,0)+nvl(j.TgtANTgtHo_IFRSuccessNum,0)),0,1,null,1,sum(nvl(j.SrcANTgtHo_IFRSuccessNum,0)+nvl(j.TgtANTgtHo_IFRSuccessNum,0)))  HardHoSuccRate_intraAN
100*sum(nvl(j.SrcANTgtHo_IFRSuccessNum,0)+nvl(j.TgtANTgtHo_IFRSuccessNum,0))/decode(sum(nvl(j.SrcANTgtHo_IFRReqestNum,0)+nvl(j.TgtANTgtHo_IFRReqestNum,0)),0,1,null,1,sum(nvl(j.SrcANTgtHo_IFRReqestNum,0)+nvl(j.TgtANTgtHo_IFRReqestNum,0))) HardHoSuccRate_intraAN
from C_tpd_cnt_bsc_carr_ho_do_zx j,c_bsc c
where j.unique_rdn = c.unique_rdn
and j.scan_start_time = v_date
group by c.city_id) t
on(c_perf.int_id = t.city_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10004 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
GlobalSHoSuccRate      = t.GlobalSHoSuccRate,
GlobalSHoReqNum        = t.GlobalSHoReqNum,
GlobalSHoSuccNum       = t.GlobalSHoSuccNum,
HardHoReqNum_intraAN  = t.HardHoReqNum_intraAN,
HardHoSuccNum_intraAN  = t.HardHoSuccNum_intraAN,
HardHoSuccRate_intraAN  = t.HardHoSuccRate_intraAN
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
GlobalSHoSuccRate,
GlobalSHoReqNum,
GlobalSHoSuccNum,
HardHoReqNum_intraAN,
HardHoSuccNum_intraAN,
HardHoSuccRate_intraAN)
values(
t.city_id,
v_date,
0,
10004,
7,
t.GlobalSHoSuccRate,
t.GlobalSHoReqNum,
t.GlobalSHoSuccNum,
t.HardHoReqNum_intraAN,
t.HardHoSuccNum_intraAN,
t.HardHoSuccRate_intraAN);
commit;


----update by zhengting
 merge into c_perf_do_sum c_perf
using(
select
r.city_id city_id,
sum(a.SuccessCapsuleNum+a.FailureCapsuleNum)/decode(sum(3600/d.ACHDurationFor68XX),0,1,null,1,sum(3600/d.ACHDurationFor68XX))     RevACHPhySlotUseRate
from C_tpd_cnt_carr_do_zx a ,c_carrier c,c_region_city r,c_tzx_par_carr_do d
where a.int_id=c.int_id
and  d.int_id=c.int_id
and c.city_id=r.city_id
and a.scan_start_time =v_date
group by r.city_id ) t
on(c_perf.int_id = t.city_id
and c_perf.scan_start_time = v_date
and c_perf.ne_type=10004
and c_perf.sum_level=0
and c_perf.vendor_id=7)
when matched then update set
c_perf.RevACHPhySlotUseRate=t.RevACHPhySlotUseRate
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type ,
vendor_id ,
FwdRLPRxRate)
values(
t.city_id,
v_date,
0,
10004,
7,
t.RevACHPhySlotUseRate);
commit;



-------------------------------------
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
from c_perf_do_sum where scan_start_time= v_date and sum_level=0 and ne_type=10004 and vendor_id=7
and int_id=perf.int_id
)
where scan_start_time= v_date and sum_level=0 and ne_type=10004 and vendor_id=7 ;
commit;
---------------------------
----------------------------------end of 由bsc到city--------------------------------------------------------------



--ne_type=10000(province) time_level=hour
merge into c_perf_do_sum c_perf
using(
select
c.province_id province_id,
sum(BtsTotalNum                    )                    BtsTotalNum                   ,
sum(OnecarrierBtsNum               )                    OnecarrierBtsNum              ,
sum(TwocarrierBtsNum               )                    TwocarrierBtsNum              ,
sum(threecarrierBtsNum             )                    threecarrierBtsNum            ,
sum(FourcarrierBtsNum              )                    FourcarrierBtsNum             ,
sum(CarrierCellNum                 )                    CarrierCellNum                ,

--update-2011-10-11
--sum(RevCEMaxUseRate              )/count(city_id)     RevCEMaxUseRate               ,
100*sum(nvl(RevCEMaxBusyNum,0))/decode(sum(nvl(RevCEAvailNum,0)),0,1,sum(nvl(RevCEAvailNum,0)))  RevCEMaxUseRate,

sum(RevCEMaxBusyNum                )                    RevCEMaxBusyNum               ,
sum(RevCEAvailNum                  )                    RevCEAvailNum                 ,
--update-2011-9-18
--sum(FwdMaxUseRate_MacIndex         )                    FwdMaxUseRate_MacIndex        ,
100*max(FwdMaxBusyNum_MacIndex)/115  FwdMaxUseRate_MacIndex,
--update-2011-9-18
max(nvl(a.FwdMaxBusyNum_MacIndex,0)) FwdMaxBusyNum_MacIndex,
sum(PCFNum                         )                    PCFNum                        ,
--update-2011-9-18
avg(PCFMeanCpuAvgLoad              )                    PCFMeanCpuAvgLoad             ,
sum(PCFMaxHRPDSessionNum           )                    PCFMaxHRPDSessionNum          ,
sum(PCFMaxActiveHRPDSessionNum     )                    PCFMaxActiveHRPDSessionNum    ,

--update-2011-10-11     配置值为1000
sum(PCFUplinkThroughputRate        )/count(city_id)     PCFUplinkThroughputRate       ,

--update-2011-10-11     配置值为1000
sum(PCFDownlinkThroughputRate      )/count(city_id)     PCFDownlinkThroughputRate     ,

--update-2011-10-11
--sum(ABisBWAvgUseRate               )/count(city_id)     ABisBWAvgUseRate              ,
100*sum(nvl(AbisAvgUseBandWidth,0))/(decode(sum(nvl(AbisPortBandWidth,0)),0,1,sum(nvl(AbisPortBandWidth,0))))  ABisBWAvgUseRate,

sum(AbisPortBandWidth              )                    AbisPortBandWidth             ,
sum(AbisAvgUseBandWidth            )                    AbisAvgUseBandWidth           ,
sum(BusyerBtsNum                   )                    BusyerBtsNum                  ,
sum(FreeBtsNum                     )                    FreeBtsNum                    ,
100*sum(AT_ConnectSuccNum+AN_ConnectSuccNum)/
decode(sum(AT_ConnectReqNum+AN_ConnectReqNum),0,1,null,1,sum(AT_ConnectReqNum+AN_ConnectReqNum)) WireConnectSuccRate           ,

--update-2011-10-11
--sum(AT_ConnectSuccRate           )/count(city_id)     AT_ConnectSuccRate            ,
100*sum(nvl(AT_ConnectSuccNum,0))/decode(sum(nvl(AT_ConnectReqNum,0)),0,1,sum(nvl(AT_ConnectReqNum,0)))  AT_ConnectSuccRate,

--100*sum(AN_ConnectSuccRate       )/count(city_id)     AN_ConnectSuccRate            ,
sum(AT_ConnectReqNum               )                    AT_ConnectReqNum              ,
sum(AN_ConnectReqNum               )                    AN_ConnectReqNum              ,
sum(AT_ConnectSuccNum              )                    AT_ConnectSuccNum             ,
sum(AN_ConnectSuccNum              )                    AN_ConnectSuccNum             ,
sum(WireConnectSuccRateInA8A10     )                    WireConnectSuccRateInA8A10    ,
sum(WireConnectSuccNumInA8A10      )                    WireConnectSuccNumInA8A10     ,
sum(WireConnectReqNumInA8A10       )                    WireConnectReqNumInA8A10      ,

--update-2011-10-11
--sum(UserEarlyReleaseRate         )/count(city_id)     UserEarlyReleaseRate          ,
sum(nvl(UserEarlyReleaseNum,0))/decode(sum(nvl(AT_ConnectReqNum+AN_ConnectReqNum,0)),0,1,sum(nvl(AT_ConnectReqNum+AN_ConnectReqNum,0)))  UserEarlyReleaseRate,

sum(UserEarlyReleaseNum            )                    UserEarlyReleaseNum           ,
sum(WireConnectFailNum1            )                    WireConnectFailNum1           ,
sum(WireConnectFailNum2            )                    WireConnectFailNum2           ,
sum(WireConnectFailNum3            )                    WireConnectFailNum3           ,
sum(WireConnectReleaseNumInPDSN    )                    WireConnectReleaseNumInPDSN   ,
sum(WireConnectReleaseNumExPDSN    )                    WireConnectReleaseNumExPDSN   ,
sum(ReleaseNumByPDSN               )                    ReleaseNumByPDSN              ,
sum(WireRadioFNum1                 )                    WireRadioFNum1                ,
sum(WireRadioFNum2                 )                    WireRadioFNum2                ,
sum(WireRadioFNum3                 )                    WireRadioFNum3                ,
sum(WireRadioFNum1+WireRadioFNum2+WireRadioFNum3)/
decode(sum(WireConnectReleaseNumInPDSN
+WireRadioFNum1
+WireRadioFNum2
+WireRadioFNum3),0,1,null,1,sum(WireConnectReleaseNumInPDSN
+WireRadioFNum1
+WireRadioFNum2
+WireRadioFNum3)) WireRadioFRate,

--update-2011-10-11
--sum(NetWorkRadioFRate            )/count(city_id)     NetWorkRadioFRate             ,
100*sum(nvl(ReleaseNumByPDSN,0)+nvl(WireRadioFNum1,0)+nvl(WireRadioFNum2,0)+nvl(WireRadioFNum3,0))/
decode(sum(nvl(WireConnectReleaseNumExPDSN,0)+nvl(WireRadioFNum1,0)+nvl(WireRadioFNum2,0)+nvl(WireRadioFNum3,0)),0,1,
sum(nvl(WireConnectReleaseNumExPDSN,0)+nvl(WireRadioFNum1,0)+nvl(WireRadioFNum2,0)+nvl(WireRadioFNum3,0)))   NetWorkRadioFRate,

avg(ConnectAvgSetupDuration        )                    ConnectAvgSetupDuration       ,
--update-2011-9-18
avg(ConnectAvgUseDuration          )                    ConnectAvgUseDuration         ,
sum(DRCApplyRate_FwdSpeed1         )                    DRCApplyRate_FwdSpeed1        ,
sum(DRCApplyRate_FwdSpeed2         )                    DRCApplyRate_FwdSpeed2        ,
sum(DRCApplyRate_FwdSpeed3         )                    DRCApplyRate_FwdSpeed3        ,
case when sum(UATI_AssgnSuccNum) >sum(UATI_AssgnReqNum)
then 100
  else
100*sum(UATI_AssgnSuccNum)/decode(sum(UATI_AssgnReqNum),0,1,null,1,sum(UATI_AssgnReqNum))
end UATI_AssgnSuccRate,
sum(UATI_AssgnReqNum               )                    UATI_AssgnReqNum              ,
sum(UATI_AssgnSuccNum              )                    UATI_AssgnSuccNum             ,
sum(UATI_AssgnFailNum              )                    UATI_AssgnFailNum             ,
sum(UATI_AvgSetupDuration          )                    UATI_AvgSetupDuration         ,

--update-2011-10-11
--sum(SessionAuthenticationSRate   )/count(city_id)     SessionAuthenticationSRate    ,
case when sum(nvl(SessionAuthenticationSNum,0))>sum(nvl(SessionAuthenticationReqNum,0)) then 100
  else
100*sum(nvl(SessionAuthenticationSNum,0))/decode(sum(nvl(SessionAuthenticationReqNum,0)),0,1,sum(nvl(SessionAuthenticationReqNum,0)))
end  SessionAuthenticationSRate,

sum(SessionAuthenticationSNum      )                    SessionAuthenticationSNum     ,
sum(SessionAuthenticationReqNum    )                    SessionAuthenticationReqNum   ,
sum(SessionAuthenticationRejNum    )                    SessionAuthenticationRejNum   ,
sum(SessionAuthenticationFNum      )                    SessionAuthenticationFNum     ,

--update-2011-10-11
--sum(SessionNegoSRate             )/count(city_id)     SessionNegoSRate              ,
100*sum(nvl(SessionNegoSNum,0))/decode(sum(nvl(SessionNegoSNum,0)+nvl(SessionNegoFNum,0)),0,1,sum(nvl(SessionNegoSNum,0)+nvl(SessionNegoFNum,0)))  SessionNegoSRate,

sum(SessionNegoSNum                )                    SessionNegoSNum               ,
sum(SessionNegoFNum                )                    SessionNegoFNum               ,

--update-2011-10-11
--sum(A13_HandoffSRate             )/count(city_id)     A13_HandoffSRate              ,
100*sum(nvl(A13_HandoffSNum,0))/decode(sum(nvl(A13_HandoffNum,0)),0,1,sum(nvl(A13_HandoffNum,0)))  A13_HandoffSRate,

sum(A13_HandoffNum                 )                    A13_HandoffNum                ,
sum(A13_HandoffSNum                )                    A13_HandoffSNum               ,
sum(SessionNum                     )                    SessionNum                    ,
sum(SessionNum_Active              )                    SessionNum_Active             ,
sum(SessionNum_NotActive           )                    SessionNum_NotActive          ,

--update-2011-10-11
--sum(User_DAAcitveSuccRate        )/count(city_id)     User_DAAcitveSuccRate         ,
100*sum(nvl(User_DAAcitveSuccNum,0))/decode(sum(nvl(User_DAAcitveReqNum,0)),0,1,sum(nvl(User_DAAcitveReqNum,0)))  User_DAAcitveSuccRate,

sum(User_DAAcitveReqNum            )                    User_DAAcitveReqNum           ,
sum(User_DAAcitveSuccNum           )                    User_DAAcitveSuccNum          ,

--update-2011-10-11
--sum(AT_DAAcitveSuccRate          )/count(city_id)     AT_DAAcitveSuccRate           ,
100*sum(nvl(AT_DAAcitveSuccNum,0))/decode(sum(nvl(AT_DAAcitveReqNum,0)),0,1,sum(nvl(AT_DAAcitveReqNum,0)))  AT_DAAcitveSuccRate,

sum(AT_DAAcitveReqNum              )                    AT_DAAcitveReqNum             ,
sum(AT_DAAcitveSuccNum             )                    AT_DAAcitveSuccNum            ,
sum(AT_DAAcitveFailNum             )                    AT_DAAcitveFailNum            ,

--update-2011-10-11
--sum(AN_DAAcitveSuccRate          )/count(city_id)     AN_DAAcitveSuccRate           ,
100*sum(nvl(AN_DAAcitveSuccNum,0))/decode(sum(nvl(AN_DAAcitveReqNum,0)),0,1,sum(nvl(AN_DAAcitveReqNum,0)))  AN_DAAcitveSuccRate,

sum(AN_DAAcitveReqNum              )                    AN_DAAcitveReqNum             ,
sum(AN_DAAcitveSuccNum             )                    AN_DAAcitveSuccNum            ,
sum(AN_DAAcitveFailNum             )                    AN_DAAcitveFailNum            ,
sum(EqlUserNum                     )                    EqlUserNum                    ,
sum(Call_Traffic                   )                    Call_Traffic                  ,
sum(CE_Traffic                     )                    CE_Traffic                    ,
sum(Sho_Traffic                    )                    Sho_Traffic                   ,
--100*sum(Sho_Factor                     )                    Sho_Factor                    ,
---update by zhengting
avg(Sho_Factor)  Sho_Factor  ,
sum(PCFRevDataSize                 )                    PCFRevDataSize                ,
sum(PCFFwdDataSize                 )                    PCFFwdDataSize                ,
sum(PCFRevPSMsg                    )                    PCFRevPSMsg                   ,
sum(PCFFwdPSMsg                    )                    PCFFwdPSMsg                   ,
sum(RevPSDiscardNum                )                    RevPSDiscardNum               ,
sum(FwdPSDiscardNum                )                    FwdPSDiscardNum               ,

--update-2011-10-11
--sum(RevPSDiscardRate             )/count(city_id)     RevPSDiscardRate              ,
sum(nvl(RevPSDiscardNum,0))/decode(sum(nvl(PCFRevPSMsg,0)),0,1,sum(nvl(PCFRevPSMsg,0)))  RevPSDiscardRate,

--update-2011-10-11
--sum(FwdPSDiscardRate             )/count(city_id)     FwdPSDiscardRate              ,
sum(nvl(FwdPSDiscardNum,0))/decode(sum(nvl(PCFFwdPSMsg,0)),0,1,sum(nvl(PCFFwdPSMsg,0)))  FwdPSDiscardRate,

sum(FwdRLPThroughput               )                    FwdRLPThroughput              ,

--update-2011-10-11         算法是中文
--sum(FwdRLPRxRate                   )/count(city_id)     FwdRLPRxRate                  ,

sum(RevRLPThroughput               )                    RevRLPThroughput              ,

--update-2011-10-11         算法是中文
--sum(RevRLPRxRate                   )/count(city_id)     RevRLPRxRate                  ,

sum(FwdTCHPhyAvgThroughput         )                    FwdTCHPhyAvgThroughput        ,
sum(FwdTCHPhyOutburstThroughput    )                    FwdTCHPhyOutburstThroughput   ,
sum(RevTCHPhyAvgThroughput         )                    RevTCHPhyAvgThroughput        ,
sum(RevTCHPhyOutburstThroughput    )                    RevTCHPhyOutburstThroughput   ,

--update-2011-10-11
avg(FwdTCHPhyTimeSlotUseRate)     FwdTCHPhyTimeSlotUseRate      ,

--update-2011-10-11        算法是中文
--sum(FwdCCHPhyTimeSlotUseRate     )/count(city_id)     FwdCCHPhyTimeSlotUseRate      ,

--update-2011-10-11        算法是中文
--sum(RevACHPhySlotUseRate         )/count(city_id)     RevACHPhySlotUseRate          ,

--update-2011-10-11
--sum(RevCircuitBusyRate           )/count(city_id)     RevCircuitBusyRate            ,
100*sum(nvl(RABBusyNum,0))/decode(sum(nvl(RABBusyNum,0)+nvl(RABFreeNum,0)),0,1,sum(nvl(RABBusyNum,0)+nvl(RABFreeNum,0)))  RevCircuitBusyRate,

100*sum(GlobalSHoSuccNum)/decode(sum(GlobalSHoReqNum),0,1,null,1,sum(GlobalSHoReqNum)) GlobalSHoSuccRate,
sum(GlobalSHoReqNum                )  GlobalSHoReqNum               ,
sum(GlobalSHoSuccNum               )  GlobalSHoSuccNum              ,
sum(SHoSuccRate_intraAN            )                    SHoSuccRate_intraAN           ,
sum(SHoReqNum_intraAN              )                    SHoReqNum_intraAN             ,
sum(SHoSuccNum_intraAN             )                    SHoSuccNum_intraAN            ,
sum(SHoSuccRate_amongAN            )                    SHoSuccRate_amongAN           ,
sum(SHoReqNum_amongAN              )                    SHoReqNum_amongAN             ,
sum(SHoSuccNum_amongAN             )                    SHoSuccNum_amongAN            ,
100*sum(HardHoSuccRate_intraAN         )                    HardHoSuccRate_intraAN        ,
sum(HardHoReqNum_intraAN           )                    HardHoReqNum_intraAN          ,
sum(HardHoSuccNum_intraAN          )                    HardHoSuccNum_intraAN         ,
sum(HardHoSuccRate_amongAN         )                    HardHoSuccRate_amongAN        ,
sum(HardHoReqNum_amongAN           )                    HardHoReqNum_amongAN          ,
sum(HardHoSuccNum_amongAN          )                    HardHoSuccNum_amongAN         ,

--update-2011-10-11
--sum(PageResponceRate             )/count(city_id)     PageResponceRate              ,
100*sum(nvl(PageResponceNum,0))/decode(sum(nvl(PageReqNum,0)),0,1,sum(nvl(PageReqNum,0)))  PageResponceRate,

sum(PageReqNum                     )                    PageReqNum                    ,
sum(PageResponceNum                )                    PageResponceNum               ,
sum(DOCarrier37                    )                    DOCarrier37                   ,
sum(DOCarrier78                    )                    DOCarrier78                   ,
sum(DOCarrier119                   )                    DOCarrier119                  ,
sum(DOCarrierTotalNum              )                    DOCarrierTotalNum             ,
sum(DOCarrier37Traffic             )                    DOCarrier37Traffic            ,
sum(DOCarrier78Traffic             )                    DOCarrier78Traffic            ,
sum(DOCarrier119Traffic            )                    DOCarrier119Traffic           ,
sum(OneDOCarrierCellNum            )                    OneDOCarrierCellNum           ,
sum(TwoDOCarrierCellNum            )                    TwoDOCarrierCellNum           ,
sum(ThreeDOCarrierCellNum          )                    ThreeDOCarrierCellNum         ,
sum(DOCellNum                      )                    DOCellNum                     ,
sum(ConnectSetupTotalDuration      )                    ConnectSetupTotalDuration     ,
sum(ConnectUseTotalDuration        )                    ConnectUseTotalDuration       ,
sum(SessionSetupTotalDuration      )                    SessionSetupTotalDuration     ,
sum(FwdRxSize                      )                    FwdRxSize                     ,
sum(FwdTxSize                      )                    FwdTxSize                     ,
sum(RevRxSize                      )                    RevRxSize                     ,
sum(RevTxSize                      )                    RevTxSize                     ,
sum(RABBusyNum                     )                    RABBusyNum                    ,
sum(RABFreeNum                     )                    RABFreeNum                    ,
sum(FwdAvailNum_MacIndex           )                    FwdAvailNum_MacIndex          ,
sum(DRCApplyNum_FwdSpeed1          )                    DRCApplyNum_FwdSpeed1         ,
sum(DRCApplyNum_FwdSpeed2          )                    DRCApplyNum_FwdSpeed2         ,
sum(DRCApplyNum_FwdSpeed3          )                    DRCApplyNum_FwdSpeed3         ,
sum(FwdTCHPhyTxBitNum              )                    FwdTCHPhyTxBitNum             ,
sum(FwdPhyUseTimeSlotDuration      )                    FwdPhyUseTimeSlotDuration     ,
sum(RevTCHPhyTxBitNum              )                    RevTCHPhyTxBitNum             ,
sum(RevPhyUseTimeSlotDuration      )                    RevPhyUseTimeSlotDuration
from c_perf_do_sum a,c_region_city c
where a.int_id = c.city_id
and a.scan_start_time = v_date
and a.ne_type = 10004
and a.sum_level = 0
and a.vendor_id = 7
group by c.province_id) t
on(c_perf.int_id = t.province_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10000 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
--AN_ConnectSuccRate            = t.AN_ConnectSuccRate           ,
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
FwdTCHPhyTimeSlotUseRate      = t.FwdTCHPhyTimeSlotUseRate     ,
--FwdCCHPhyTimeSlotUseRate      = t.FwdCCHPhyTimeSlotUseRate     ,
--RevACHPhySlotUseRate          = t.RevACHPhySlotUseRate         ,
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
--AN_ConnectSuccRate          ,
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
FwdTCHPhyTimeSlotUseRate    ,
--FwdCCHPhyTimeSlotUseRate    ,
--RevACHPhySlotUseRate        ,
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
7,
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
--t.AN_ConnectSuccRate           ,
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
t.FwdTCHPhyTimeSlotUseRate     ,
--t.FwdCCHPhyTimeSlotUseRate     ,
--t.RevACHPhySlotUseRate         ,
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


-----------------------------------

--add-2011-10-12
--add-FwdRLPRxRate
merge into c_perf_do_sum c_perf
using(
select
province_id,
sum(a.ReTxByteNum)/
decode(sum(a.TxByteNum+a.ReTxByteNum),0,1,null,1,sum(a.TxByteNum+a.ReTxByteNum))   FwdRLPRxRate
from C_tpd_cnt_carr_do_zx a ,c_carrier c,c_region_city r
where a.int_id=c.int_id
and c.city_id=r.city_id
and a.scan_start_time = v_date
group by r.province_id ) t
on(c_perf.int_id = t.province_id
and c_perf.scan_start_time = v_date
and c_perf.ne_type=10000
and c_perf.sum_level=0
and c_perf.vendor_id=7)
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
7,
t.FwdRLPRxRate);
commit;


--add-2011-10-12
--add-RevRLPRxRate
merge into c_perf_do_sum c_perf
using(
select
province_id,
100*sum(a.ReReByteNum)/
decode(sum(a.RevARevTCHMACBytes+a.Rls0RevTCHMACBytes),0,1,null,1,sum(a.RevARevTCHMACBytes+a.Rls0RevTCHMACBytes))    RevRLPRxRate
from  C_tpd_cnt_carr_do_zx a, c_carrier c,c_region_city r
where a.int_id=c.int_id
and   c.city_id=r.city_id
and a.scan_start_time = v_date
group by r.province_id) t
on(c_perf.int_id = t.province_id
and c_perf.scan_start_time = v_date
and c_perf.ne_type=10000
and c_perf.sum_level=0
and c_perf.vendor_id=7)
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
7,
t.RevRLPRxRate);
commit;

--add-2011-10-12
--add-FwdCCHPhyTimeSlotUseRate
merge into c_perf_do_sum c_perf
using(
select
province_id,
---update by zhengting
100*avg(1.667*(nvl(a.FwdCCHSendSlotNum,0))/1000/3600)  FwdCCHPhyTimeSlotUseRate
from C_tpd_cnt_carr_do_zx a ,c_carrier c,c_region_city r
where a.int_id=c.int_id
and c.city_id=r.city_id
and a.scan_start_time = v_date
group by r.province_id ) t
on(c_perf.int_id = t.province_id
and c_perf.scan_start_time = v_date
and c_perf.ne_type=10000
and c_perf.sum_level=0
and c_perf.vendor_id=7)
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
7,
t.FwdCCHPhyTimeSlotUseRate);
commit;

--add-2011-10-12
--add-RevACHPhySlotUseRate
merge into c_perf_do_sum c_perf
using(
select
province_id,
sum(a.SuccessCapsuleNum
+a.FailureCapsuleNum)/decode(sum(3600/d.ACHDurationFor68XX),0,1,null,1,sum(3600/d.ACHDurationFor68XX))     RevACHPhySlotUseRate
from C_tpd_cnt_carr_do_zx a ,c_carrier c,c_region_city r,c_tzx_par_carr_do d
where a.int_id=c.int_id
and  d.int_id=c.int_id
and c.city_id=r.city_id
and a.scan_start_time = v_date
group by r.province_id ) t
on(c_perf.int_id = t.province_id
and c_perf.scan_start_time = v_date
and c_perf.ne_type=10000
and c_perf.sum_level=0
and c_perf.vendor_id=7)
when matched then update set
c_perf.RevACHPhySlotUseRate=t.RevACHPhySlotUseRate
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
7,
t.RevACHPhySlotUseRate);
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
100*sum(RevCEMaxBusyNum)/decode(sum(RevCEAvailNum),null,1,0,1,sum(RevCEAvailNum))  RevCEMaxUseRate            ,
sum(nvl(RevCEMaxBusyNum            ,0))  RevCEMaxBusyNum            ,
sum(nvl(RevCEAvailNum              ,0))  RevCEAvailNum              ,
--upddate-2011-9-18
--100*sum(FwdMaxBusyNum_MacIndex)/decode(sum(FwdAvailNum_MacIndex),null,1,0,1,sum(FwdAvailNum_MacIndex))  FwdMaxUseRate_MacIndex     ,
100*max(FwdMaxBusyNum_MacIndex)/115  FwdMaxUseRate_MacIndex   ,
--update by zhengting
--sum(nvl(FwdMaxBusyNum_MacIndex     ,0))  FwdMaxBusyNum_MacIndex     ,
max(nvl(FwdMaxBusyNum_MacIndex     ,0))  FwdMaxBusyNum_MacIndex     ,
sum(nvl(PCFNum                     ,0))  PCFNum                     ,
--update-2011-9-18
avg(nvl(PCFMeanCpuAvgLoad          ,0))  PCFMeanCpuAvgLoad          ,
sum(nvl(PCFMaxHRPDSessionNum       ,0))  PCFMaxHRPDSessionNum       ,
sum(nvl(PCFMaxActiveHRPDSessionNum ,0))  PCFMaxActiveHRPDSessionNum ,
avg(nvl(PCFUplinkThroughputRate    ,0))  PCFUplinkThroughputRate    ,
avg(nvl(PCFDownlinkThroughputRate  ,0))  PCFDownlinkThroughputRate  ,
100*sum(AbisAvgUseBandWidth)/decode(sum(AbisPortBandWidth),null,1,0,1,sum(AbisPortBandWidth))  ABisBWAvgUseRate           ,
sum(nvl(AbisPortBandWidth          ,0))  AbisPortBandWidth          ,
sum(nvl(AbisAvgUseBandWidth        ,0))  AbisAvgUseBandWidth        ,
sum(nvl(BusyerBtsNum               ,0))  BusyerBtsNum               ,
sum(nvl(FreeBtsNum                 ,0))  FreeBtsNum                 ,
100*sum(AT_ConnectSuccNum+AN_ConnectSuccNum)/
decode(sum(AT_ConnectReqNum+AN_ConnectReqNum),0,1,null,1,sum(AT_ConnectReqNum+AN_ConnectReqNum))  WireConnectSuccRate        ,
100*sum(AT_ConnectSuccNum)/decode(sum(AT_ConnectReqNum),null,1,0,1,sum(AT_ConnectReqNum))  AT_ConnectSuccRate         ,
--avg(nvl(AN_ConnectSuccRate         ,0))  AN_ConnectSuccRate         ,
100*sum(AN_ConnectSuccNum)/decode(sum(AN_ConnectReqNum),null,1,0,1,sum(AN_ConnectReqNum))  AN_ConnectSuccRate         ,
sum(nvl(AT_ConnectReqNum           ,0))  AT_ConnectReqNum           ,
sum(nvl(AN_ConnectReqNum           ,0))  AN_ConnectReqNum           ,
sum(nvl(AT_ConnectSuccNum          ,0))  AT_ConnectSuccNum          ,
sum(nvl(AN_ConnectSuccNum          ,0))  AN_ConnectSuccNum          ,
100*sum(WireConnectSuccNumInA8A10)/decode(sum(WireConnectReqNumInA8A10),null,1,0,1,sum(WireConnectReqNumInA8A10))  WireConnectSuccRateInA8A10 ,
sum(WireConnectSuccNumInA8A10) WireConnectSuccNumInA8A10,
sum(WireConnectReqNumInA8A10) WireConnectReqNumInA8A10,
100*sum(UserEarlyReleaseNum)/decode(sum(nvl(AT_ConnectReqNum,0)+nvl(AN_ConnectReqNum,0)),null,1,0,1,sum(nvl(AT_ConnectReqNum,0)+nvl(AN_ConnectReqNum,0)))  UserEarlyReleaseRate,
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
---update by zhengting
100*sum(WireRadioFNum1+WireRadioFNum2+WireRadioFNum3)/
decode(sum(WireConnectReleaseNumInPDSN+WireRadioFNum1+WireRadioFNum2+WireRadioFNum3),0,1,null,1,sum(WireConnectReleaseNumInPDSN+WireRadioFNum1+WireRadioFNum2+WireRadioFNum3))  WireRadioFRate             ,
100*sum(nvl(ReleaseNumByPDSN,0)+nvl(WireRadioFNum1,0)+nvl(WireRadioFNum2,0)+nvl(WireRadioFNum3,0))/
decode(sum(WireConnectReleaseNumInPDSN+WireRadioFNum1+WireRadioFNum2+WireRadioFNum3),
null,1,0,1,sum(WireConnectReleaseNumInPDSN+WireRadioFNum1+WireRadioFNum2+WireRadioFNum3))  NetWorkRadioFRate          ,
--update by zhengting
avg(ConnectAvgSetupDuration) ConnectAvgSetupDuration,
--update by zhengting
avg(ConnectAvgUseDuration) ConnectAvgUseDuration ,
100*sum(DRCApplyNum_FwdSpeed1)/decode(sum(DRCApplyNum_FwdSpeed1+DRCApplyNum_FwdSpeed2+DRCApplyNum_FwdSpeed3),null,1,
0,1,sum(DRCApplyNum_FwdSpeed1+DRCApplyNum_FwdSpeed2+DRCApplyNum_FwdSpeed3))  DRCApplyRate_FwdSpeed1     ,
100*sum(DRCApplyNum_FwdSpeed2)/decode(sum(DRCApplyNum_FwdSpeed1+DRCApplyNum_FwdSpeed2+DRCApplyNum_FwdSpeed3),null,1,
0,1,sum(DRCApplyNum_FwdSpeed1+DRCApplyNum_FwdSpeed2+DRCApplyNum_FwdSpeed3))  DRCApplyRate_FwdSpeed2     ,
100*sum(DRCApplyNum_FwdSpeed3)/decode(sum(DRCApplyNum_FwdSpeed1+DRCApplyNum_FwdSpeed2+DRCApplyNum_FwdSpeed3),null,1,
0,1,sum(DRCApplyNum_FwdSpeed1+DRCApplyNum_FwdSpeed2+DRCApplyNum_FwdSpeed3))  DRCApplyRate_FwdSpeed3     ,
case when sum(UATI_AssgnSuccNum)>sum(UATI_AssgnReqNum) then 100
  else
100*sum(UATI_AssgnSuccNum)/
decode(sum(UATI_AssgnReqNum),0,1,null,1,sum(UATI_AssgnReqNum))
end  UATI_AssgnSuccRate,
sum(nvl(UATI_AssgnReqNum           ,0))  UATI_AssgnReqNum           ,
sum(nvl(UATI_AssgnSuccNum          ,0))  UATI_AssgnSuccNum          ,
sum(nvl(UATI_AssgnFailNum          ,0))  UATI_AssgnFailNum          ,
sum(nvl(UATI_AvgSetupDuration      ,0))  UATI_AvgSetupDuration      ,
case when sum(SessionAuthenticationSNum)>sum(SessionAuthenticationReqNum) then 100
else
100*sum(SessionAuthenticationSNum)/decode(sum(SessionAuthenticationReqNum),null,1,0,1,sum(SessionAuthenticationReqNum))
end  SessionAuthenticationSRate ,
sum(nvl(SessionAuthenticationSNum  ,0))  SessionAuthenticationSNum  ,
sum(nvl(SessionAuthenticationReqNum,0))  SessionAuthenticationReqNum,
sum(nvl(SessionAuthenticationRejNum,0))  SessionAuthenticationRejNum,
sum(nvl(SessionAuthenticationFNum  ,0))  SessionAuthenticationFNum  ,
100*sum(SessionNegoSNum)/decode(sum(SessionNegoSNum+SessionNegoFNum),null,1,0,1,sum(SessionNegoSNum+SessionNegoFNum))  SessionNegoSRate           ,
sum(nvl(SessionNegoSNum            ,0))  SessionNegoSNum            ,
sum(nvl(SessionNegoFNum            ,0))  SessionNegoFNum            ,
100*sum(A13_HandoffSNum)/decode(sum(A13_HandoffNum),null,1,0,1,sum(A13_HandoffNum))  A13_HandoffSRate           ,
sum(nvl(A13_HandoffNum             ,0))  A13_HandoffNum             ,
sum(nvl(A13_HandoffSNum            ,0))  A13_HandoffSNum            ,
sum(nvl(SessionNum                 ,0))  SessionNum                 ,
sum(nvl(SessionNum_Active          ,0))  SessionNum_Active          ,
sum(nvl(SessionNum_NotActive       ,0))  SessionNum_NotActive       ,
100*sum(AT_DAAcitveSuccNum+AN_DAAcitveSuccNum)/ decode(sum(AT_DAAcitveReqNum+AN_DAAcitveReqNum),null,1,0,1,sum(AT_DAAcitveReqNum+AN_DAAcitveReqNum))  User_DAAcitveSuccRate ,
sum(nvl(User_DAAcitveReqNum        ,0))  User_DAAcitveReqNum        ,
sum(nvl(User_DAAcitveSuccNum       ,0))  User_DAAcitveSuccNum       ,
100*sum(AT_DAAcitveSuccNum)/decode(sum(AT_DAAcitveReqNum),null,1,0,1,sum(AT_DAAcitveReqNum))  AT_DAAcitveSuccRate        ,
sum(nvl(AT_DAAcitveReqNum          ,0))  AT_DAAcitveReqNum          ,
sum(nvl(AT_DAAcitveSuccNum         ,0))  AT_DAAcitveSuccNum         ,
sum(nvl(AT_DAAcitveFailNum         ,0))  AT_DAAcitveFailNum         ,
100*sum(AN_DAAcitveSuccNum)/decode(sum(AN_DAAcitveReqNum),null,1,0,1,sum(AN_DAAcitveReqNum))  AN_DAAcitveSuccRate        ,
sum(nvl(AN_DAAcitveReqNum          ,0))  AN_DAAcitveReqNum          ,
sum(nvl(AN_DAAcitveSuccNum         ,0))  AN_DAAcitveSuccNum         ,
sum(nvl(AN_DAAcitveFailNum         ,0))  AN_DAAcitveFailNum         ,
sum(nvl(EqlUserNum                 ,0))  EqlUserNum                 ,
sum(nvl(Call_Traffic               ,0))  Call_Traffic               ,
sum(nvl(CE_Traffic                 ,0))  CE_Traffic                 ,
sum(nvl(Sho_Traffic                ,0))  Sho_Traffic                ,
--update by zhengting
avg(Sho_Factor)  Sho_Factor                 ,
sum(nvl(PCFRevDataSize             ,0))  PCFRevDataSize             ,
sum(nvl(PCFFwdDataSize             ,0))  PCFFwdDataSize             ,
sum(nvl(PCFRevPSMsg                ,0))  PCFRevPSMsg                ,
sum(nvl(PCFFwdPSMsg                ,0))  PCFFwdPSMsg                ,
sum(nvl(RevPSDiscardNum            ,0))  RevPSDiscardNum            ,
sum(nvl(FwdPSDiscardNum            ,0))  FwdPSDiscardNum            ,
sum(RevPSDiscardNum)/decode(sum(PCFRevPSMsg),null,1,0,1,sum(PCFRevPSMsg))  RevPSDiscardRate           ,
sum(FwdPSDiscardNum)/decode(sum(PCFFwdPSMsg),null,1,0,1,sum(PCFFwdPSMsg))  FwdPSDiscardRate           ,
sum(nvl(FwdRLPThroughput           ,0))  FwdRLPThroughput           ,
--update by zhengting
--avg(nvl(FwdRLPRxRate               ,0))  FwdRLPRxRate               ,
100*sum(nvl(FwdRxSize,0))/decode(sum(FwdTxSize),0,1,null,1,sum(FwdTxSize)) FwdRLPRxRate,
sum(nvl(RevRLPThroughput           ,0))  RevRLPThroughput           ,
----update by zhengting
--avg(nvl(RevRLPRxRate               ,0))  RevRLPRxRate               ,
100*sum(RevRxSize)/decode(sum(RevTxSize),0,1,null,1,sum(RevTxSize)) RevRLPRxRate,
sum(nvl(FwdTCHPhyAvgThroughput     ,0))  FwdTCHPhyAvgThroughput     ,
sum(nvl(FwdTCHPhyOutburstThroughput,0))  FwdTCHPhyOutburstThroughput,
sum(nvl(RevTCHPhyAvgThroughput     ,0))  RevTCHPhyAvgThroughput     ,
sum(nvl(RevTCHPhyOutburstThroughput,0))  RevTCHPhyOutburstThroughput,
avg(nvl(FwdTCHPhyTimeSlotUseRate   ,0))  FwdTCHPhyTimeSlotUseRate   ,
avg(nvl(FwdCCHPhyTimeSlotUseRate   ,0))  FwdCCHPhyTimeSlotUseRate   ,
avg(nvl(RevACHPhySlotUseRate       ,0))  RevACHPhySlotUseRate       ,
100*sum(RABBusyNum)/decode(sum(RABBusyNum+RABFreeNum),null,1,0,1,sum(RABBusyNum+RABFreeNum))  RevCircuitBusyRate         ,
100*sum(GlobalSHoSuccNum)/decode(sum(GlobalSHoReqNum),0,1,null,1,sum(GlobalSHoReqNum))  GlobalSHoSuccRate          ,
sum(nvl(GlobalSHoReqNum            ,0))  GlobalSHoReqNum            ,
sum(nvl(GlobalSHoSuccNum           ,0))  GlobalSHoSuccNum           ,
100*sum(SHoSuccNum_intraAN)/decode(sum(SHoReqNum_intraAN),null,1,0,1,sum(SHoReqNum_intraAN))  SHoSuccRate_intraAN        ,
sum(nvl(SHoReqNum_intraAN          ,0))  SHoReqNum_intraAN          ,
sum(nvl(SHoSuccNum_intraAN         ,0))  SHoSuccNum_intraAN         ,
sum(SHoSuccNum_amongAN)/decode(sum(SHoReqNum_amongAN),null,1,0,1,sum(SHoReqNum_amongAN))  SHoSuccRate_amongAN        ,
sum(nvl(SHoReqNum_amongAN          ,0))  SHoReqNum_amongAN          ,
sum(nvl(SHoSuccNum_amongAN         ,0))  SHoSuccNum_amongAN         ,
100*sum(HardHoSuccNum_intraAN)/decode(sum(HardHoReqNum_intraAN),null,1,0,1,sum(HardHoReqNum_intraAN))  HardHoSuccRate_intraAN     ,
sum(nvl(HardHoReqNum_intraAN       ,0))  HardHoReqNum_intraAN       ,
sum(nvl(HardHoSuccNum_intraAN      ,0))  HardHoSuccNum_intraAN      ,
--delete-2011-9-19
--sum(HardHoSuccNum_amongAN)/decode(sum(HardHoReqNum_amongAN),null,1,0,1,sum(HardHoReqNum_amongAN))  HardHoSuccRate_amongAN     ,
sum(nvl(HardHoReqNum_amongAN       ,0))  HardHoReqNum_amongAN       ,
sum(nvl(HardHoSuccNum_amongAN      ,0))  HardHoSuccNum_amongAN      ,
--move-2011-9-19
100*sum(HardHoSuccNum_amongAN)/decode(sum(HardHoReqNum_amongAN),null,1,0,1,sum(HardHoReqNum_amongAN))  HardHoSuccRate_amongAN     ,
100*sum(PageResponceNum)/decode(sum(PageReqNum),null,1,0,1,sum(PageReqNum))  PageResponceRate           ,
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
--delete-2011-9-19
--HardHoSuccRate_amongAN      = t.HardHoSuccRate_amongAN      ,
HardHoReqNum_amongAN        = t.HardHoReqNum_amongAN        ,
HardHoSuccNum_amongAN       = t.HardHoSuccNum_amongAN       ,
--move-2011-9-19
HardHoSuccRate_amongAN      = t.HardHoSuccRate_amongAN      ,
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
--HardHoSuccRate_amongAN      ,
HardHoReqNum_amongAN        ,
HardHoSuccNum_amongAN       ,
HardHoSuccRate_amongAN      ,
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
--t.HardHoSuccRate_amongAN      ,
t.HardHoReqNum_amongAN        ,
t.HardHoSuccNum_amongAN       ,
t.HardHoSuccRate_amongAN      ,
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





exception when others then
s_error := sqlerrm;
rollback;
insert into job_log values(sysdate,'c_perf_do_sum_zx_cell',s_error);
commit;




end;
