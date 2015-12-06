create or replace procedure proc_c_perf_do_sum_zx(p_date date)
as
v_date date;
s_error varchar2(4000);

begin
--if null then v_date = sysdate-3 (3hours before) else v_date = p_date
select trunc(decode(p_date,null,trunc(sysdate-3/24,'hh24'),p_date),'hh24') into v_date from dual;

--C_tpd_cnt_carr_do_zx a,C_tpd_cnt_bsc_mdu_do_zx b,C_tpd_cnt_bsc_do_zx c,
--C_tpd_cnt_bsc_flux_do_zx d,C_tpd_cnt_carr_ho_do_zx e,c_thw_par_carr_do f,C_tpd_cnt_bts_do_zx g
--C_tpd_cnt_board_do_zx h,C_tpd_cnt_bts_E1_zx i,C_tpd_cnt_bsc_carr_ho_do_zx j

--ne_type= 101 sum_level=0
--由a实现
merge into c_perf_do_sum c_perf
using(
select
c.related_msc related_msc,

--modify-2011-11-04
round(sum(nvl(a.CMO_CallSNum,0)
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
+nvl(a.FMT_OtherFailureNum_bssapfail,0)))*100,4)  WireConnectSuccRate,
round(sum(nvl(a.CMO_CallSNum,0)
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
+nvl(a.CMO_OtherFailureNum_bssapfail,0)))*100,4) AT_ConnectSuccRate,
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
round(100*sum(nvl(a.CMT_CallSNum ,0)
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
+nvl(a.FMT_OtherFailureNum_bssapfail,0)),4) AN_ConnectSuccRate,
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
sum(a.RlsSNum) WireConnectReleaseNumExPDSN,
sum(a.PDSNReleaseNum) ReleaseNumByPDSN,
sum(a.AirlinkLostDropNum)  WireRadioFNum1,
sum(nvl(a.OtherDropNum,0)) WireRadioFNum3,
round(sum(nvl(a.SetupSuccessNum,0))/decode(sum(a.SetupAttemptNum),0,1,null,1,sum(a.SetupAttemptNum))*100,4) UATI_AssgnSuccRate,
sum(nvl(a.SetupAttemptNum,0)) UATI_AssgnReqNum,
sum(nvl(a.SetupSuccessNum,0)) UATI_AssgnSuccNum,
sum(nvl(a.SetupFailureNum,0)) UATI_AssgnFailNum,
sum(nvl(a.EquUserNum,0)) EqlUserNum,
sum(nvl(a.CallDuration,0)/3600) Call_Traffic,
sum(nvl(a.CallDuration,0)+nvl(a.SHoDuration,0))/3600 CE_Traffic,
sum(nvl(a.SHoDuration,0))/3600 Sho_Traffic,
--update-2011-9-18
--100*sum(nvl(a.SHoDuration,0))/3600/decode(sum(a.CallDuration),0,1,null,1,sum(a.CallDuration))/3600 Sho_Factor,
round(100*sum(nvl(a.SHoDuration,0))/decode(sum(a.CallDuration),0,1,null,1,sum(a.CallDuration)),4) Sho_Factor,
sum(nvl(a.RevAFwdTCHPhyBytes,0)+nvl(a.Rls0FwdTCHPhyBytes,0))*8.0/1000/3600 FwdTCHPhyAvgThroughput,
sum(nvl(a.RevAFwdTCHPhyBytes,0)+nvl(a.Rls0FwdTCHPhyBytes,0))*8.0/decode((sum(a.RevAFwdTCHSendSlotNum)+sum(a.Rls0FwdTCHSendSlotNum)*1.667),0,1,null,1,(sum(a.RevAFwdTCHSendSlotNum)+sum(a.Rls0FwdTCHSendSlotNum)*1.667)) FwdTCHPhyOutburstThroughput,
sum(nvl(a.RevARevTCHPhyBytes,0)+nvl(a.Rls0RevTCHPhyBytes,0))*8.0/1000/3600 RevTCHPhyAvgThroughput,
sum(nvl(a.RevARevTCHPhyBytes,0)+nvl(a.Rls0RevTCHPhyBytes,0))*8.0/decode((sum(a.RevSlotNum)*1.667),0,1,null,1,(sum(a.RevSlotNum)*1.667)) RevTCHPhyOutburstThroughput,
100*round(avg(nvl(a.FwdCCHSendSlotNum,0))*1.667/1000/3600,4) FwdCCHPhyTimeSlotUseRate,
round(sum(nvl(a.RABBusyNum,0))/decode(sum(nvl(a.RABBusyNum,0)+nvl(a.RABFreeNum,0)),0,1,null,1,sum(nvl(a.RABBusyNum,0)+nvl(a.RABFreeNum,0)))*100,4) RevCircuitBusyRate,
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
--update-8-25
100*round(avg(nvl(a.RevAFwdTCHSendSlotNum,0)+nvl(a.Rls0FwdTCHSendSlotNum,0))*1.667/(1000*3600),4) FwdTCHPhyTimeSlotUseRate,
round(100*sum(nvl(a.AirlinkLostDropNum,0)
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
+nvl(a.OtherDropNum,0))),4) WireRadioFRate,
--udpate-2011-9-14
max(nvl(a.UserNum,0)) FwdMaxBusyNum_MacIndex,
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
sum(nvl(a.Cell_Session_SetupTime,0))/decode(sum(nvl(a.SetupSuccessNum,0)),0,1,null,1,sum(nvl(a.SetupSuccessNum,0))) UATI_AvgSetupDuration,
sum(nvl(a.RequestNum,0)) SessionAuthenticationSNum,
sum(nvl(a.TxByteNum+ReTxByteNum,0))*8.0/(1000*3600) FwdRLPThroughput,
round(sum(nvl(a.ReTxByteNum,0))/decode(sum(a.TxByteNum)+sum(a.ReTxByteNum),0,1,null,1,sum(a.TxByteNum)+sum(a.ReTxByteNum))*100,4) FwdRLPRxRate,
sum(nvl(a.RevARevTCHMACBytes,0)+nvl(a.Rls0RevTCHMACBytes,0))*8.0/(1000*3600) RevRLPThroughput,
round(sum(nvl(a.ReReByteNum,0))/decode(sum(nvl(a.RevARevTCHMACBytes,0))+sum(nvl(a.Rls0RevTCHMACBytes,0)),null,1,0,1,sum(nvl(a.RevARevTCHMACBytes,0))+sum(nvl(a.Rls0RevTCHMACBytes,0))),4) RevRLPRxRate,
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
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
WireConnectReleaseNumExPDSN = t.WireConnectReleaseNumExPDSN,
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
t.related_msc,
v_date,
0,
101,
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




--由b实现
merge into c_perf_do_sum c_perf
using(
select
c.related_msc related_msc,
--sum(nvl(b.SessionSetupDuration,0)) UATI_AvgSetupDuration,
round(sum(nvl(b.DC_CallSNum,0)+nvl(b.PC_CallSNum,0))/decode(sum(nvl(b.DC_CallSNum,0)+nvl(b.DC_CallFNum,0)+nvl(b.PC_CallSNum,0)+nvl(b.PC_CallFNum,0)),0,1,null,1,sum(nvl(b.DC_CallSNum,0)+nvl(b.DC_CallFNum,0)+nvl(b.PC_CallSNum,0)+nvl(b.PC_CallFNum,0)))*100,4) User_DAAcitveSuccRate,
sum(nvl(b.DC_CallSNum,0)+nvl(b.DC_CallFNum,0)+nvl(b.PC_CallSNum,0)+nvl(b.PC_CallFNum,0)) User_DAAcitveReqNum,
sum(nvl(b.DC_CallSNum,0)+nvl(b.PC_CallSNum,0)) User_DAAcitveSuccNum,
round(sum(nvl(b.DC_CallSNum,0))/decode(sum(nvl(b.DC_CallSNum,0)+nvl(b.DC_CallFNum,0)),0,1,null,1,sum(nvl(b.DC_CallSNum,0)+nvl(b.DC_CallFNum,0)))*100,4) AT_DAAcitveSuccRate,
sum(nvl(b.DC_CallSNum,0)+nvl(b.DC_CallFNum,0)) AT_DAAcitveReqNum,
sum(nvl(b.DC_CallSNum,0)) AT_DAAcitveSuccNum,
sum(nvl(b.DC_CallFNum,0)) AT_DAAcitveFailNum,
round(sum(nvl(b.PC_CallSNum,0))/decode(sum(nvl(b.PC_CallSNum,0)+nvl(b.PC_CallFNum,0)),0,1,null,1,sum(nvl(b.PC_CallSNum,0)+nvl(b.PC_CallFNum,0)))*100,4) AN_DAAcitveSuccRate,
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
where b.unique_rdn = c.unique_rdn
and b.scan_start_time = v_date
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
SessionNum	= t.SessionNum,
SessionNum_Active = t.SessionNum_Active,
SessionNum_NotActive = t.SessionNum_NotActive,
PCFRevDataSize=t.PCFRevDataSize,
PCFFwdDataSize = t.PCFFwdDataSize,
PCFRevPSMsg = t.PCFRevPSMsg,
PCFFwdPSMsg = t.PCFFwdPSMsg,
RevPSDiscardNum = t.RevPSDiscardNum,
FwdPSDiscardNum = t.FwdPSDiscardNum
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
t.related_msc,
v_date,
0,
101,
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
t.related_msc related_msc,
--sum(nvl(c.AuthenticationSNum,0)) SessionAuthenticationSNum,
--round(sum(nvl(c.SessionNegoSNum_subnet,0))/decode(sum(nvl(c.SessionNegoSNum_subnet,0)+nvl(c.SessionNegoFNum_subnet,0)),0,1,null,1,sum(nvl(c.SessionNegoSNum_subnet,0)+nvl(c.SessionNegoFNum_subnet,0)))*100,4) SessionNegoSRate,
round(sum(nvl(c.SessionNegoSNum,0))/decode(sum(nvl(c.SessionNegoSNum,0)+nvl(c.SessionNegoFNum,0)),0,1,null,1,sum(nvl(c.SessionNegoSNum,0)+nvl(c.SessionNegoFNum,0))),5)*100 SessionNegoSRate,
sum(nvl(c.SessionNegoSNum,0)) SessionNegoSNum,
sum(nvl(c.SessionNegoFNum,0)) SessionNegoFNum,
round(sum(nvl(c.A13DA_HandoffSNum_subnet,0)+nvl(c.A13DD_HandoffSNum_subnet,0))/decode(sum(nvl(c.A13DA_HandoffFNum_subnet,0)+nvl(c.A13DD_HandoffFNum_subnet,0)+nvl(c.A13DA_HandoffSNum_subnet,0)+nvl(c.A13DD_HandoffSNum_subnet,0)),0,1,null,1,sum(nvl(c.A13DA_HandoffFNum_subnet,0)+nvl(c.A13DD_HandoffFNum_subnet,0)+nvl(c.A13DA_HandoffSNum_subnet,0)+nvl(c.A13DD_HandoffSNum_subnet,0)))*100,4) A13_HandoffSRate,
sum(nvl(c.A13DA_HandoffFNum_subnet,0)+nvl(c.A13DA_HandoffSNum_subnet,0)) A13_HandoffNum,
sum(nvl(c.A13DA_HandoffSNum_subnet,0)) A13_HandoffSNum,
--sum(nvl(c.ActiveSessionNum,0)+nvl(c.SessionNum,0)-nvl(c.ActiveSessionNum,0)) SessionNum,
--sum(nvl(c.ActiveSessionNum,0)) SessionNum_Active,
--sum(nvl(c.SessionNum,0)- nvl(c.ActiveSessionNum,0)) SessionNum_NotActive,
round(sum(nvl(c.ATConnectionReqNum,0))/decode(sum(c.BssapPagingNum),0,1,null,1,sum(c.BssapPagingNum))*100,4) PageResponceRate,
sum(nvl(c.BssapPagingNum,0)) PageReqNum,
sum(nvl(c.ATConnectionReqNum,0)) PageResponceNum
from C_tpd_cnt_bsc_do_zx c,c_bsc t
where c.int_id = t.int_id
and c.scan_start_time = v_date
group by t.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
--SessionAuthenticationSNum = t.SessionAuthenticationSNum,
SessionNegoSRate          = t.SessionNegoSRate,
SessionNegoSNum           = t.SessionNegoSNum,
SessionNegoFNum           = t.SessionNegoFNum,
A13_HandoffSRate          = t.A13_HandoffSRate,
A13_HandoffNum            = t.A13_HandoffNum,
A13_HandoffSNum           = t.A13_HandoffSNum,
--SessionNum                = t.SessionNum,
--SessionNum_Active         = t.SessionNum_Active,
--SessionNum_NotActive      = t.SessionNum_NotActive,
PageResponceRate          = t.PageResponceRate,
PageReqNum                = t.PageReqNum,
PageResponceNum           = t.PageResponceNum
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
--SessionAuthenticationSNum,
SessionNegoSRate,
SessionNegoSNum,
SessionNegoFNum,
A13_HandoffSRate,
A13_HandoffNum,
A13_HandoffSNum,
--SessionNum,
--SessionNum_Active,
--SessionNum_NotActive,
PageResponceRate,
PageReqNum,
PageResponceNum)
values(
t.related_msc,
v_date,
0,
101,
7,
--t.SessionAuthenticationSNum,
t.SessionNegoSRate,
t.SessionNegoSNum,
t.SessionNegoFNum,
t.A13_HandoffSRate,
t.A13_HandoffNum,
t.A13_HandoffSNum,
--t.SessionNum,
--t.SessionNum_Active,
--t.SessionNum_NotActive,
t.PageResponceRate,
t.PageReqNum,
t.PageResponceNum);
commit;


--由d实现
--merge into c_perf_do_sum c_perf
--using(
--select
--c.related_msc related_msc,
--sum(nvl(d.FwdTransmitBytes,0))*8.0/1000/3600 FwdRLPThroughput,
--sum(nvl(d.FwdRetransmitBytes,0))/decode(sum(d.FwdTransmitBytes),0,1,null,1,sum(d.FwdTransmitBytes))*100 FwdRLPRxRate,
--sum(nvl(d.RevReceiveByteNum,0))*8.0/1000/3600 RevRLPThroughput,
--sum(nvl(d.FwdRetransmitBytes,0)) FwdRxSize,
--sum(nvl(d.FwdTransmitBytes,0)) FwdTxSize,
--sum(nvl(d.RevReceiveByteNum,0)) RevTxSize
--from C_tpd_cnt_bsc_flux_do_zx d,c_bsc c
--where d.unique_rdn = c.unique_rdn
--and d.scan_start_time = v_date
--group by c.related_msc) t
--on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
--when matched then update set
--FwdRLPThroughput = t.FwdRLPThroughput,
--FwdRLPRxRate     = t.FwdRLPRxRate,
--RevRLPThroughput = t.RevRLPThroughput,
--FwdRxSize        = t.FwdRxSize,
--FwdTxSize        = t.FwdTxSize,
--RevTxSize        = t.RevTxSize
--when not matched then insert(
--int_id,
--scan_start_time,
--sum_level,
--ne_type,
--vendor_id,
--FwdRLPThroughput,
--FwdRLPRxRate,
--RevRLPThroughput,
--FwdRxSize,
--FwdTxSize,
--RevTxSize)
--values(
--t.related_msc,
--v_date,
--0,
--101,
--7,
--t.FwdRLPThroughput,
--t.FwdRLPRxRate,
--t.RevRLPThroughput,
--t.FwdRxSize,
--t.FwdTxSize,
--t.RevTxSize);
--commit;


--由e实现
merge into c_perf_do_sum c_perf
using(
select
c_cell.related_msc related_msc,
--sum(nvl(e.HardHoAdd_SuccessNum,0))/decode(sum(e.HardHoAdd_ReqestNum),0,1,null,1,sum(e.HardHoAdd_ReqestNum))  HardHoSuccRate_intraAN,
--sum(nvl(e.TgtANTgtHo_IFRReqestNum,0))+sum(nvl(e.SrcANTgtHo_IFRReqestNum,0)) HardHoReqNum_intraAN,
--sum(nvl(e.SrcANTgtHo_IFRSuccessNum,0))+sum(nvl(e.TgtANTgtHo_IFRSuccessNum,0)) HardHoSuccNum_intraAN,
--sum(nvl(e.HardHoAdd_SuccessNum,0))/decode(sum(e.HardHoAdd_ReqestNum),0,1,null,1,sum(e.HardHoAdd_ReqestNum))  HardHoSuccRate_amongAN,
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
--move-2011-9-19
round(100*sum(e.SrcANTgtHo_IFRSuccessNum+e.TgtANTgtHo_IFRSuccessNum)/
decode(sum(e.SrcANTgtHo_IFRReqestNum+e.TgtANTgtHo_IFRReqestNum),0,1,null,1,sum(e.SrcANTgtHo_IFRReqestNum+e.TgtANTgtHo_IFRReqestNum)),4) HardHoSuccRate_amongAN
from C_tpd_cnt_carr_ho_do_zx e,c_carrier c,c_cell
where e.int_id = c.int_id and c.related_cell = c_cell.int_id and c_cell.vendor_id = 7
and e.scan_start_time = v_date
group by c_cell.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
SHoReqNum_intraAN = t.SHoReqNum_intraAN,
SHoSuccNum_intraAN = t.SHoSuccNum_intraAN
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
t.related_msc,
v_date,
0,
101,
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


--complicate column
--sum(b.SessionSetupDuration)*sum(a.SetupSuccessNum) SessionSetupTotalDuration
--merge into c_perf_do_sum c_perf
--using(
--select
--t1.related_msc related_msc
--t1.SessionSetupDuration * t2.SetupSuccessNum SessionSetupTotalDuration
--from
--(
--select c.related_msc related_msc,
--sum(nvl(b.SessionSetupDuration,0)) SessionSetupDuration
--from C_tpd_cnt_bsc_mdu_do_zx b,c_bsc c
--where b.unique_rdn = c.unique_rdn
--and b.scan_start_time = v_date
--group by c.related_msc) t1,
--(
--select c.related_msc related_msc,
--sum(nvl(a.SetupSuccessNum,0)) SetupSuccessNum
--from C_tpd_cnt_carr_do_zx a,c_carrier c
--where a.int_id = c.int_id
--and a.scan_start_time = v_date
--group by c.related_msc) t2
--where t1.related_msc = t2.related_msc) t
--on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
--t.related_msc,
--v_date,
--0,
--101,
--7,
--t.SessionSetupTotalDuration);
--commit;

---------------------------------------------2010.5.4 document add------------------------------------------------------------------

--BtsTotalNum
--OnecarrierBtsNum
--TwocarrierBtsNum
--threecarrierBtsNum
--FourcarrierBtsNum


merge into c_perf_do_sum c_perf
using(
select b.related_msc ,count(distinct a.related_bts) BtsTotalNum
from c_carrier a,c_cell b
where a.related_cell=b.int_id and  a.car_type='DO'
and a.vendor_id=7
group by b.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.BtsTotalNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.related_msc,count(distinct a.related_bts) OnecarrierBtsNum
from
(select related_bts from
c_carrier where car_type='DO' and vendor_id=7
group by related_msc,related_bts having count(distinct car_type)=1 ) a,c_cell b
where a.related_bts=b.related_bts
group by b.related_msc ) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.OnecarrierBtsNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.related_msc,count(distinct a.related_bts) TwocarrierBtsNum
from
(select related_bts from
c_carrier
where car_type='DO' and vendor_id=7
group by related_msc,related_bts
having count(distinct car_type)=2 ) a,c_cell b
where a.related_bts=b.related_bts
group by b.related_msc ) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.TwocarrierBtsNum);
commit;

merge into c_perf_do_sum c_perf
using(
select b.related_msc,count(distinct a.related_bts) ThreecarrierBtsNum
from
(select related_bts from
c_carrier
where car_type='DO' and vendor_id=7
group by related_msc,related_bts
having count(distinct car_type)=3 ) a,c_cell b
where a.related_bts=b.related_bts
group by b.related_msc ) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.ThreecarrierBtsNum);
commit;


merge into c_perf_do_sum c_perf
using(
select b.related_msc,count(distinct a.related_bts) FourcarrierBtsNum
from
(select related_bts from
c_carrier
where car_type='DO' and vendor_id=7
group by related_msc,related_bts
having count(distinct car_type)=4 ) a,c_cell b
where a.related_bts=b.related_bts
group by b.related_msc ) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
c.related_msc related_msc,
round(sum(g.MaxBusyCENum)/
decode(sum(g.CEReliableNum+g.CE5500ReliableNum),0,1,null,1,sum(g.CEReliableNum+g.CE5500ReliableNum)),4)* 100   RevCEMaxUseRate,
sum(nvl(g.MaxBusyCENum,0)) RevCEMaxBusyNum,
sum(nvl(g.CEReliableNum,0)+nvl(g.CE5500ReliableNum,0)) RevCEAvailNum
from C_tpd_cnt_bts_do_zx g,c_bts c
where g.int_id = c.int_id and g.scan_start_time = v_date
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
RevCEMaxUseRate = t.RevCEMaxUseRate,
RevCEMaxBusyNum = t.RevCEMaxBusyNum,
RevCEAvailNum   = t.RevCEAvailNum;
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
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
where c.related_cell=c_cell.int_id and c.car_type='DO' and c.vendor_id=7
group by c_cell.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
7,
t.DOCarrierTotalNum);
commit;


--delete-2011-9-2
--merge into c_perf_do_sum c_perf
--using(
--select
--c.related_msc related_msc,
--count(a.int_id) DOCarrierTotalNum
--from C_tpd_cnt_carr_do_zx a,c_carrier c
--where a.int_id = c.int_id and a.scan_start_time = v_date
--group by c.related_msc) t
--on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
--select b.related_msc,count(b.int_id) OneDOCarrierCellNum
--from
--(select related_cell int_id from
--c_carrier where cdma_freq in (37,78) and vendor_id=7
--group by related_msc,related_cell having count(distinct cdma_freq)=1 ) a,c_cell b
--where a.int_id=b.int_id
--group by b.related_msc) a,
--(
--select b.related_msc,count(a.int_id) CarrierCellNum
--from c_carrier a ,c_cell b  where a.related_cell=b.int_id
--and a.cdma_freq in (37,78) and a.vendor_id=7 and b.vendor_id=7
--group by b.related_msc
--) b
--where a.related_msc=b.related_msc(+)) t
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
  ne.related_msc,
  sum(OneDOCarrierCellNum) OneDOCarrierCellNum,
  sum(TwoDOCarrierCellNum) TwoDOCarrierCellNum,
  sum(threeDOCarrierCellNum) ThreeDOCarrierCellNum,
  sum(DOCellNum) DOCellNum,
  sum(CarrierCellNum ) CarrierCellNum
  from c_cell ne,a
  where ne.int_id=a.int_id and ne.vendor_id=7
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
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
OneDOCarrierCellNum = t.OneDOCarrierCellNum,
TwoDOCarrierCellNum   = t.TwoDOCarrierCellNum,
ThreeDOCarrierCellNum = t.ThreeDOCarrierCellNum,
CarrierCellNum      = t.CarrierCellNum
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
7,
t.OneDOCarrierCellNum,
t.TwoDOCarrierCellNum,
t.ThreeDOCarrierCellNum,
t.CarrierCellNum);
commit;

--delete-8-30
--merge into c_perf_do_sum c_perf
--using(
--select related_msc,count(b.int_id) TwoDOCarrierCellNum
--from
--(select related_cell int_id from
--c_carrier where cdma_freq in (37,78) and vendor_id=7
--group by related_msc,related_cell
--having count(distinct cdma_freq)=2 ) a,c_cell b
--where a.int_id=b.int_id
--group by b.related_msc) t
--on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
--7,
--t.TwoDOCarrierCellNum);
--commit;

--delete-8-30
--merge into c_perf_do_sum c_perf
--using(
--select
--c.related_msc related_msc,
--count(d.int_id) ThreeDOCarrierCellNum
--from c_cell c,c_carrier d
--where c.int_id = d.related_cell and c.do_cell=1 and numfa=3 and c.vendor_id = 7
--group by c.related_msc) t
--on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
--t.related_msc,
--v_date,
--0,
--101,
--7,
--t.ThreeDOCarrierCellNum);
--commit;

--delete-8-30
--merge into c_perf_do_sum c_perf
--using(
--select b.related_msc ,count(distinct a.related_cell) DOCellNum
--from c_carrier a,c_cell b where a.related_cell=b.int_id
--and  a.cdma_freq in (37,78)
--and a.vendor_id=7
--group by b.related_msc) t
--on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
--7,
--t.DOCellNum);
--commit;
--
--

merge into c_perf_do_sum c_perf
using (
with temp1 as
(select b.related_msc related_msc,
sum(nvl(SetupTime,0)) SetupTime,
sum(nvl(ConnectTime,0)) ConnectTime,
sum(nvl(RlsSNum,0))  RlsSNum,
sum(nvl(AirlinkLostDropNum,0))  AirlinkLostDropNum,
sum(nvl(HHODropNum,0)) HHODropNum,
sum(nvl(OtherDropNum,0)) OtherDropNum,
sum(nvl(PDSNReleaseNum,0)) PDSNReleaseNum
from C_tpd_cnt_bsc_carr_do_zx a,c_bsc b
where a.unique_rdn=b.unique_rdn and a.scan_start_time=v_date
group by b.related_msc),
temp2 as(
select
c.related_msc related_msc,
sum(nvl(CMO_CallSNum,0)) CMO_CallSNum,
sum(nvl(soft_CMO_CallSuccessNum,0)) soft_CMO_CallSuccessNum,
sum(nvl(CMT_CallSNum,0)) CMT_CallSNum,
sum(nvl(soft_CMT_CallSuccessNum,0)) soft_CMT_CallSuccessNum,
sum(nvl(FMT_CallSNum,0)) FMT_CallSNum,
sum(nvl(soft_FMT_CallSuccessNum,0)) soft_FMT_CallSuccessNum
from C_tpd_cnt_carr_do_zx a,c_carrier c
where a.int_id=c.int_id and a.scan_start_time=v_date
group by  c.related_msc)
select
temp1.related_msc related_msc,
(temp1.SetupTime)/(temp2.CMO_CallSNum
+temp2.soft_CMO_CallSuccessNum
+temp2.CMT_CallSNum
+temp2.soft_CMT_CallSuccessNum
+temp2.FMT_CallSNum
+temp2.soft_FMT_CallSuccessNum) ConnectAvgSetupDuration,
temp1.ConnectTime/(temp1.RlsSNum+temp1.AirlinkLostDropNum+temp1.HHODropNum+temp1.OtherDropNum+temp1.PDSNReleaseNum) ConnectAvgUseDuration
from temp1,temp2
where temp1.related_msc=temp2.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
ConnectAvgSetupDuration = t.ConnectAvgSetupDuration,
ConnectAvgUseDuration = t.ConnectAvgUseDuration
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
ConnectAvgSetupDuration,
ConnectAvgUseDuration)
values(
t.related_msc,
v_date,
0,
101,
7,
t.ConnectAvgSetupDuration,
t.ConnectAvgUseDuration);
commit;









-----add by 6.16
merge into c_perf_do_sum c_perf
using(
with temp1 as
(select b.int_id int_id,
count(*)/2  AbisPortBandWidth
from C_tpd_cnt_bts_E1_zx a,c_bts b where a.Unique_rdn=b.Unique_rdn  and a.scan_start_time=v_date
group by b.int_id,b.btsid*2)
select c.related_msc related_msc,
sum(AbisPortBandWidth) AbisPortBandWidth
from temp1 a,c_bts c
where a.int_id=c.int_id
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
t.related_msc,
v_date,
0,
101,
7,
t.AbisPortBandWidth);
commit;

merge into c_perf_do_sum c_perf
using(
with temp1 as (
select b.int_id int_id,
sum(AvgFlux_IP/2000) AbisAvgUseBandWidth
from C_tpd_cnt_bts_E1_zx a,c_bts b where a.Unique_rdn=b.Unique_rdn and a.scan_start_time=v_date
group by b.int_id, b.btsid)
select  c.related_msc related_msc,
sum(AbisAvgUseBandWidth) AbisAvgUseBandWidth
from temp1 a,c_bts c
where a.int_id=c.int_id
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
t.related_msc,
v_date,
0,
101,
7,
t.AbisAvgUseBandWidth);
commit;
------end of 2011.6.16



---------------------------------------------end of 2010.5.4------------------------------------------------------------------

----------------add by Lv------------
merge into c_perf_do_sum c_perf
using(
with a as(
select
b.related_msc int_id,
sum(a.Common_Call_SetupTime+a.Soft_SetupTime)    ConnectSetupTotalDuration
from C_tpd_cnt_carr_do_zx a ,c_carrier b
where a.int_id=b.int_id and a.scan_start_time = v_date and b.vendor_id=7
group by b.related_msc
),
c as(
select
b.related_msc int_id,
sum(a.ConnectTime)  ConnectUseTotalDuration
from C_tpd_cnt_bsc_carr_do_zx a ,c_bsc b
where a.unique_rdn=b.unique_rdn and a.scan_start_time = v_date and b.vendor_id=7
group by b.related_msc
)
select
 a.int_id,
 a.ConnectSetupTotalDuration,
 c.ConnectUseTotalDuration,
 --a.ConnectSetupTotalDuration/decode((nvl(b.AT_ConnectSuccNum,0)+nvl(b.AN_ConnectSuccNum,0)),null,1,0,1,(nvl(b.AT_ConnectSuccNum,0)+nvl(b.AN_ConnectSuccNum,0)))  ConnectAvgSetupDuration,
 --a.ConnectUseTotalDuration /decode((nvl(b.AT_ConnectSuccNum,0)+nvl(b.AN_ConnectSuccNum,0)),null,1,0,1,(nvl(b.AT_ConnectSuccNum,0)+nvl(b.AN_ConnectSuccNum,0)))   ConnectAvgUseDuration,
 ---------2010--8-19----------
 round(100*b.FwdMaxBusyNum_MacIndex/115,4)  FwdMaxUseRate_MacIndex,
 round(b.AbisAvgUseBandWidth/decode(b.AbisPortBandWidth,null,1,0,1,b.AbisPortBandWidth),4) ABisBWAvgUseRate,
 round(100*b.WireConnectSuccNumInA8A10/decode(b.WireConnectReqNumInA8A10,null,1,0,1,b.WireConnectReqNumInA8A10),4) WireConnectSuccRateInA8A10,
 round(100*b.UserEarlyReleaseNum/decode((nvl(b.AT_ConnectReqNum,0)+nvl(b.AN_ConnectReqNum,0)),null,1,0,1,(nvl(b.AT_ConnectReqNum,0)+nvl(b.AN_ConnectReqNum,0))),4)  UserEarlyReleaseRate,
 --(nvl(b.WireConnectReleaseNumInPDSN,0)-nvl(b.ReleaseNumByPDSN,0)) WireConnectReleaseNumExPDSN,
 round(100*(nvl(b.ReleaseNumByPDSN,0)+nvl(b.WireRadioFNum1,0)+nvl(b.WireRadioFNum2,0)+nvl(b.WireRadioFNum3,0))/
 decode((nvl(b.WireConnectReleaseNumInPDSN,0)+nvl(b.WireRadioFNum1,0)+nvl(b.WireRadioFNum2,0)+nvl(b.WireRadioFNum3,0)),null,1,0,1,(nvl(b.WireConnectReleaseNumInPDSN,0)+nvl(b.WireRadioFNum1,0)+nvl(b.WireRadioFNum2,0)+nvl(b.WireRadioFNum3,0))),4) NetWorkRadioFRate,
 100*round(b.DRCApplyNum_FwdSpeed1/decode((nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0)),null,1,0,1,(nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0))),4) DRCApplyRate_FwdSpeed1,
 100*round(b.DRCApplyNum_FwdSpeed2/decode((nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0)),null,1,0,1,(nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0))),4) DRCApplyRate_FwdSpeed2,
 100*round(b.DRCApplyNum_FwdSpeed3/decode((nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0)),null,1,0,1,(nvl(b.DRCApplyNum_FwdSpeed1,0)+nvl(b.DRCApplyNum_FwdSpeed2,0)+nvl(b.DRCApplyNum_FwdSpeed3,0))),4) DRCApplyRate_FwdSpeed3,
 round(100*b.SessionAuthenticationSNum/decode((nvl(b.SessionAuthenticationSNum,0)+nvl(b.SessionAuthenticationRejNum,0)+nvl(b.SessionAuthenticationFNum,0)),null,1,0,1,(nvl(b.SessionAuthenticationSNum,0)+nvl(b.SessionAuthenticationRejNum,0)+nvl(b.SessionAuthenticationFNum,0))),4) SessionAuthenticationSRate,
 (nvl(b.SessionAuthenticationSNum,0)+nvl(b.SessionAuthenticationRejNum,0)+nvl(b.SessionAuthenticationFNum,0)) SessionAuthenticationReqNum,
 round(b.RevPSDiscardNum/decode(b.PCFRevPSMsg,null,1,0,1,b.PCFRevPSMsg),4) RevPSDiscardRate,
 round(b.FwdPSDiscardNum/decode(b.PCFFwdPSMsg,null,1,0,1,b.PCFFwdPSMsg),4) FwdPSDiscardRate,
 --round(100*b.RevRxSize/decode(b.RevTxSize,null,1,0,1,b.RevTxSize) RevRLPRxRate,
 round(100*b.SHoSuccNum_intraAN/decode(b.SHoReqNum_intraAN,null,1,0,1,b.SHoReqNum_intraAN),4) SHoSuccRate_intraAN,
 round(100*b.SHoSuccNum_amongAN/decode(b.SHoReqNum_amongAN,null,1,0,1,b.SHoReqNum_amongAN),4) SHoSuccRate_amongAN
 -----------------------------
from a,c_perf_do_sum b,c
where a.int_id=b.int_id and b.int_id=c.int_id and b.ne_type=101 and  b.scan_start_time=v_date and b.sum_level=0 and b.vendor_id=7
) t
on(c_perf.int_id = t.int_id and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
--WireConnectReleaseNumExPDSN =t.WireConnectReleaseNumExPDSN,
NetWorkRadioFRate           =t.NetWorkRadioFRate,
DRCApplyRate_FwdSpeed1      =t.DRCApplyRate_FwdSpeed1,
DRCApplyRate_FwdSpeed2      =t.DRCApplyRate_FwdSpeed2,
DRCApplyRate_FwdSpeed3      =t.DRCApplyRate_FwdSpeed3,
SessionAuthenticationSRate  =t.SessionAuthenticationSRate,
SessionAuthenticationReqNum =t.SessionAuthenticationReqNum,
RevPSDiscardRate            =t.RevPSDiscardRate,
FwdPSDiscardRate            =t.FwdPSDiscardRate,
--RevRLPRxRate                =t.RevRLPRxRate,
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
--WireConnectReleaseNumExPDSN,
NetWorkRadioFRate,
DRCApplyRate_FwdSpeed1,
DRCApplyRate_FwdSpeed2,
DRCApplyRate_FwdSpeed3,
SessionAuthenticationSRate,
SessionAuthenticationReqNum,
RevPSDiscardRate,
FwdPSDiscardRate,
--RevRLPRxRate,
SHoSuccRate_intraAN,
SHoSuccRate_amongAN
---------------------------
)
values(
t.int_id,
v_date,
0,
101,
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
--t.WireConnectReleaseNumExPDSN,
t.NetWorkRadioFRate,
t.DRCApplyRate_FwdSpeed1,
t.DRCApplyRate_FwdSpeed2,
t.DRCApplyRate_FwdSpeed3,
t.SessionAuthenticationSRate,
t.SessionAuthenticationReqNum,
t.RevPSDiscardRate,
t.FwdPSDiscardRate,
--t.RevRLPRxRate,
t.SHoSuccRate_intraAN,
t.SHoSuccRate_amongAN
---------------------------
);
commit;


merge into c_perf_do_sum c_perf
using(
select
c.related_msc related_msc,
--udpate-2011-9-14
avg(h.AvgUseRate) PCFMeanCpuAvgLoad
from C_tpd_cnt_board_do_zx h,c_bsc c
where h.unique_rdn = c.unique_rdn
and h.BoardName = 23
and h.scan_start_time = v_date
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
t.related_msc,
v_date,
0,
101,
7,
t.PCFMeanCpuAvgLoad);
commit;

merge into c_perf_do_sum c_perf
using(
select c.related_msc related_msc,
count(distinct a.int_id)*20000  PCFMaxHRPDSessionNum,
count(distinct a.int_id)*20000  PCFMaxActiveHRPDSessionNum,
count(distinct a.int_id)*1000  PCFUplinkThroughputRate,
count(distinct a.int_id)*1000 PCFDownlinkThroughputRate
 from c_pcf a,c_bsc c
where a.related_bsc=c.int_id  and a.vendor_id=7
group by  c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
t.related_msc,
v_date,
0,
101,
7,
t.PCFMaxHRPDSessionNum,
t.PCFMaxActiveHRPDSessionNum,
t.PCFUplinkThroughputRate,
t.PCFDownlinkThroughputRate);
commit;



merge into c_perf_do_sum c_perf
using (
with temp1 as
(select b.related_msc related_msc,
sum(SuccessCapsuleNum) SuccessCapsuleNum,
sum(FailureCapsuleNum) FailureCapsuleNum
from C_tpd_cnt_carr_do_zx a,c_carrier b
where a.int_id=b.int_id and a.scan_start_time = v_date
group by b.related_msc),
temp2 as(
select
c.related_msc related_msc,
sum(ACHDurationFor68XX)  ACHDurationFor68XX
from c_tzx_par_carr_do a,c_carrier c
where a.int_id=c.int_id
group by  c.related_msc)
select
temp1.related_msc related_msc,
round((temp1.SuccessCapsuleNum+temp1.FailureCapsuleNum)/decode(temp2.ACHDurationFor68XX,null,1,0,1,temp2.ACHDurationFor68XX),4) RevACHPhySlotUseRate
from temp1,temp2
where temp1.related_msc=temp2.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
when matched then update set
RevACHPhySlotUseRate = t.RevACHPhySlotUseRate
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
RevACHPhySlotUseRate)
values(
t.related_msc,
v_date,
0,
101,
7,
t.RevACHPhySlotUseRate);
commit;


--merge into c_perf_do_sum c_perf
--using(
--with temp1 as
--(select  c.related_bts int_id, scan_start_time,
----update-8-25
----sum(RevAFwdTCHSendSlotNum+Rls0FwdTCHSendSlotNum*8.0) FwdTCHPhyTimeSlotUseRate,
--sum((nvl(a.RevAFwdTCHSendSlotNum,0)+nvl(a.Rls0FwdTCHSendSlotNum,0))*1.667/(1000*3600)) FwdTCHPhyTimeSlotUseRate,
--sum(EquUserNum) EquUserNum
--from C_tpd_cnt_carr_do_zx a,c_carrier c
--where a.int_id = c.int_id
--and a.scan_start_time = v_date
--group by c.related_bts,scan_start_time
--),
--temp2 as
--(select  c.int_id, c.related_msc,scan_start_time,
--case when FwdTCHPhyTimeSlotUseRate>=0.7 and EquUserNum>=4  then 1 else 0 end BusyerBtsNum ,
--case when FwdTCHPhyTimeSlotUseRate<=0.5 and EquUserNum<=1   then 1 else 0 end FreeBtsNum
--from temp1 a,c_carrier c
--where a.int_id = c.related_bts
--and a.scan_start_time = v_date)
--select  temp2.related_msc related_msc,
--sum(BusyerBtsNum) BusyerBtsNum,
--sum(FreeBtsNum) FreeBtsNum
--from temp2
--where scan_start_time=v_date
--group by related_msc) t
--on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
--when matched then update set
--BusyerBtsNum         = t.BusyerBtsNum,
--FreeBtsNum          = t.FreeBtsNum
--when not matched then insert(
--int_id,
--scan_start_time,
--sum_level,
--ne_type,
--vendor_id,
--BusyerBtsNum,
--FreeBtsNum)
--values(
--t.related_msc,
--v_date,
--0,
--101,
--7,
--t.BusyerBtsNum,
--t.FreeBtsNum);
--commit;


--add-2011-9-1
--add--BusyerBtsNum--FreeBtsNum
merge into c_perf_do_sum c_perf
using(
with temp as
(select
c.int_id int_id,
c.related_msc related_msc,
--update-2011-9-1
case when (a.RevAFwdTCHSendSlotNum+a.Rls0FwdTCHSendSlotNum)*8.0/ 3600>=0.7 and a.EquUserNum>=4  then 1 else 0 end BusyerBtsNum,
case when (a.RevAFwdTCHSendSlotNum+a.Rls0FwdTCHSendSlotNum)*8.0/ 3600<=0.7 and a.EquUserNum<=1  then 1 else 0 end FreeBtsNum
from C_tpd_cnt_carr_do_zx a,c_carrier c
where a.int_id = c.int_id
and a.scan_start_time = v_date)
select  temp.related_msc related_msc,
case when sum(BusyerBtsNum)>=1 then 1 else 2 end BusyerBtsNum,
case when sum(FreeBtsNum)<=1 then 0 else 2 end FreeBtsNum
from temp
--where scan_start_time=v_date
group by related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
t.related_msc,
v_date,
0,
101,
7,
t.BusyerBtsNum,
t.FreeBtsNum);
commit;


--add-2011-9-14
--ConnectAvgUseDuration
merge into c_perf_do_sum c_perf
using(
select
c.related_msc related_msc,
avg(nvl(a.ConnectTime,0)/
decode(nvl(a.RlsSNum,0)+nvl(a.AirlinkLostDropNum,0)+nvl(a.HHODropNum,0)+nvl(a.OtherDropNum,0)+nvl(a.PDSNReleaseNum,0),
0,1,null,1,
nvl(a.RlsSNum,0)+nvl(a.AirlinkLostDropNum,0)+nvl(a.HHODropNum,0)+nvl(a.OtherDropNum,0)+nvl(a.PDSNReleaseNum,0))) ConnectAvgUseDuration
from C_tpd_cnt_bsc_carr_do_zx a,c_carrier c
where a.int_id=c.int_id and scan_start_time=v_date
group by related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
t.related_msc,
v_date,
0,
101,
7,
t.ConnectAvgUseDuration);
commit;



merge into c_perf_do_sum c_perf
using(
select
c.related_msc related_msc,
round(sum(nvl(j.SrcANTgtHo_SFTSuccessNum,0)
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
+nvl(j.TgtANTgtHo_AFRReqestNum,0)))*100,4) GlobalSHoSuccRate,
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
round(100*sum(nvl(j.SrcANTgtHo_IFRSuccessNum,0)+nvl(j.TgtANTgtHo_IFRSuccessNum,0))/decode(sum(nvl(j.SrcANTgtHo_IFRReqestNum,0)+nvl(j.TgtANTgtHo_IFRReqestNum,0)),0,1,null,1,sum(nvl(j.SrcANTgtHo_IFRReqestNum,0)+nvl(j.TgtANTgtHo_IFRReqestNum,0))),4) HardHoSuccRate_intraAN
from C_tpd_cnt_bsc_carr_ho_do_zx j,c_bsc c
where j.unique_rdn = c.unique_rdn
and j.scan_start_time = v_date
group by c.related_msc) t
on(c_perf.int_id = t.related_msc and c_perf.scan_start_time = v_date and c_perf.ne_type=101 and c_perf.sum_level=0 and c_perf.vendor_id=7)
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
t.related_msc,
v_date,
0,
101,
7,
t.GlobalSHoSuccRate,
t.GlobalSHoReqNum,
t.GlobalSHoSuccNum,
t.HardHoReqNum_intraAN,
t.HardHoSuccNum_intraAN,
t.HardHoSuccRate_intraAN);
commit;


update c_perf_do_sum perf
set
(
BtsTotalNum	,
OnecarrierBtsNum	,
TwocarrierBtsNum	,
threecarrierBtsNum	,
FourcarrierBtsNum	,
CarrierCellNum	,
RevCEMaxUseRate	,
RevCEMaxBusyNum	,
RevCEAvailNum	,
PCFNum	,
PCFMaxHRPDSessionNum	,
PCFMaxActiveHRPDSessionNum	,
BusyerBtsNum	,
FreeBtsNum	,
AT_ConnectReqNum	,
AN_ConnectReqNum	,
AT_ConnectSuccNum	,
AN_ConnectSuccNum	,
UserEarlyReleaseNum	,
WireConnectFailNum1	,
WireConnectFailNum2	,
WireConnectFailNum3	,
WireConnectReleaseNumInPDSN	,
WireConnectReleaseNumExPDSN	,
ReleaseNumByPDSN	,
WireRadioFNum1	,
WireRadioFNum2	,
WireRadioFNum3	,
WireRadioFRate	,
NetWorkRadioFRate	,
ConnectAvgSetupDuration	,
ConnectAvgUseDuration	,
DRCApplyRate_FwdSpeed1	,
DRCApplyRate_FwdSpeed2	,
DRCApplyRate_FwdSpeed3	,
UATI_AssgnSuccRate	,
UATI_AssgnReqNum	,
UATI_AssgnSuccNum	,
UATI_AssgnFailNum	,
UATI_AvgSetupDuration	,
SessionAuthenticationSRate	,
SessionAuthenticationSNum	,
SessionAuthenticationReqNum	,
SessionAuthenticationRejNum	,
SessionAuthenticationFNum	,
SessionNegoSRate	,
SessionNegoSNum	,
SessionNegoFNum	,
A13_HandoffSRate	,
A13_HandoffNum	,
A13_HandoffSNum	,
SessionNum	,
SessionNum_Active	,
SessionNum_NotActive	,
User_DAAcitveSuccRate	,
User_DAAcitveReqNum	,
User_DAAcitveSuccNum	,
AT_DAAcitveSuccRate	,
AT_DAAcitveReqNum	,
AT_DAAcitveSuccNum	,
AT_DAAcitveFailNum	,
AN_DAAcitveSuccRate	,
AN_DAAcitveReqNum	,
AN_DAAcitveSuccNum	,
AN_DAAcitveFailNum	,
EqlUserNum	,
Call_Traffic	,
CE_Traffic	,
Sho_Traffic	,
Sho_Factor	,
PCFRevDataSize	,
PCFFwdDataSize	,
PCFRevPSMsg	,
PCFFwdPSMsg	,
RevPSDiscardNum	,
FwdPSDiscardNum	,
GlobalSHoReqNum	,
GlobalSHoSuccNum	,
PageReqNum	,
PageResponceNum	,
DOCarrier37	,
DOCarrier78	,
DOCarrier119	,
DOCarrierTotalNum	,
DOCarrier37Traffic	,
DOCarrier78Traffic	,
DOCarrier119Traffic	,
OneDOCarrierCellNum	,
TwoDOCarrierCellNum	,
ThreeDOCarrierCellNum	,
DOCellNum	,
ConnectSetupTotalDuration	,
ConnectUseTotalDuration	,
SessionSetupTotalDuration	,
FwdRxSize	,
FwdTxSize	,
RevRxSize	,
RevTxSize	,
RABBusyNum	,
RABFreeNum	,
FwdAvailNum_MacIndex	,
DRCApplyNum_FwdSpeed1	,
DRCApplyNum_FwdSpeed2	,
DRCApplyNum_FwdSpeed3	,
FwdTCHPhyTxBitNum	,
FwdPhyUseTimeSlotDuration	,
RevTCHPhyTxBitNum	,
RevPhyUseTimeSlotDuration
)=
(
select
decode(	BtsTotalNum	,null,0,	BtsTotalNum	),
decode(	OnecarrierBtsNum	,null,0,	OnecarrierBtsNum	),
decode(	TwocarrierBtsNum	,null,0,	TwocarrierBtsNum	),
decode(	threecarrierBtsNum	,null,0,	threecarrierBtsNum	),
decode(	FourcarrierBtsNum	,null,0,	FourcarrierBtsNum	),
decode(	CarrierCellNum	,null,0,	CarrierCellNum	),
decode(	RevCEMaxUseRate	,null,0,	RevCEMaxUseRate	),
decode(	RevCEMaxBusyNum	,null,0,	RevCEMaxBusyNum	),
decode(	RevCEAvailNum	,null,0,	RevCEAvailNum	),
decode(	PCFNum	,null,0,	PCFNum	),
decode(	PCFMaxHRPDSessionNum	,null,0,	PCFMaxHRPDSessionNum	),
decode(	PCFMaxActiveHRPDSessionNum	,null,0,	PCFMaxActiveHRPDSessionNum	),
decode(	BusyerBtsNum	,null,0,	BusyerBtsNum	),
decode(	FreeBtsNum	,null,0,	FreeBtsNum	),
decode(	AT_ConnectReqNum	,null,0,	AT_ConnectReqNum	),
decode(	AN_ConnectReqNum	,null,0,	AN_ConnectReqNum	),
decode(	AT_ConnectSuccNum	,null,0,	AT_ConnectSuccNum	),
decode(	AN_ConnectSuccNum	,null,0,	AN_ConnectSuccNum	),
decode(	UserEarlyReleaseNum	,null,0,	UserEarlyReleaseNum	),
decode(	WireConnectFailNum1	,null,0,	WireConnectFailNum1	),
decode(	WireConnectFailNum2	,null,0,	WireConnectFailNum2	),
decode(	WireConnectFailNum3	,null,0,	WireConnectFailNum3	),
decode(	WireConnectReleaseNumInPDSN	,null,0,	WireConnectReleaseNumInPDSN	),
decode(	WireConnectReleaseNumExPDSN	,null,0,	WireConnectReleaseNumExPDSN	),
decode(	ReleaseNumByPDSN	,null,0,	ReleaseNumByPDSN	),
decode(	WireRadioFNum1	,null,0,	WireRadioFNum1	),
decode(	WireRadioFNum2	,null,0,	WireRadioFNum2	),
decode(	WireRadioFNum3	,null,0,	WireRadioFNum3	),
decode(	WireRadioFRate	,null,0,	WireRadioFRate	),
decode(	NetWorkRadioFRate	,null,0,	NetWorkRadioFRate	),
decode(	ConnectAvgSetupDuration	,null,0,	ConnectAvgSetupDuration	),
decode(	ConnectAvgUseDuration	,null,0,	ConnectAvgUseDuration	),
decode(	DRCApplyRate_FwdSpeed1	,null,0,	DRCApplyRate_FwdSpeed1	),
decode(	DRCApplyRate_FwdSpeed2	,null,0,	DRCApplyRate_FwdSpeed2	),
decode(	DRCApplyRate_FwdSpeed3	,null,0,	DRCApplyRate_FwdSpeed3	),
decode(	UATI_AssgnSuccRate	,null,0,	UATI_AssgnSuccRate	),
decode(	UATI_AssgnReqNum	,null,0,	UATI_AssgnReqNum	),
decode(	UATI_AssgnSuccNum	,null,0,	UATI_AssgnSuccNum	),
decode(	UATI_AssgnFailNum	,null,0,	UATI_AssgnFailNum	),
decode(	UATI_AvgSetupDuration	,null,0,	UATI_AvgSetupDuration	),
decode(	SessionAuthenticationSRate	,null,0,	SessionAuthenticationSRate	),
decode(	SessionAuthenticationSNum	,null,0,	SessionAuthenticationSNum	),
decode(	SessionAuthenticationReqNum	,null,0,	SessionAuthenticationReqNum	),
decode(	SessionAuthenticationRejNum	,null,0,	SessionAuthenticationRejNum	),
decode(	SessionAuthenticationFNum	,null,0,	SessionAuthenticationFNum	),
decode(	SessionNegoSRate	,null,0,	SessionNegoSRate	),
decode(	SessionNegoSNum	,null,0,	SessionNegoSNum	),
decode(	SessionNegoFNum	,null,0,	SessionNegoFNum	),
decode(	A13_HandoffSRate	,null,0,	A13_HandoffSRate	),
decode(	A13_HandoffNum	,null,0,	A13_HandoffNum	),
decode(	A13_HandoffSNum	,null,0,	A13_HandoffSNum	),
decode(	SessionNum	,null,0,	SessionNum	),
decode(	SessionNum_Active	,null,0,	SessionNum_Active	),
decode(	SessionNum_NotActive	,null,0,	SessionNum_NotActive	),
decode(	User_DAAcitveSuccRate	,null,0,	User_DAAcitveSuccRate	),
decode(	User_DAAcitveReqNum	,null,0,	User_DAAcitveReqNum	),
decode(	User_DAAcitveSuccNum	,null,0,	User_DAAcitveSuccNum	),
decode(	AT_DAAcitveSuccRate	,null,0,	AT_DAAcitveSuccRate	),
decode(	AT_DAAcitveReqNum	,null,0,	AT_DAAcitveReqNum	),
decode(	AT_DAAcitveSuccNum	,null,0,	AT_DAAcitveSuccNum	),
decode(	AT_DAAcitveFailNum	,null,0,	AT_DAAcitveFailNum	),
decode(	AN_DAAcitveSuccRate	,null,0,	AN_DAAcitveSuccRate	),
decode(	AN_DAAcitveReqNum	,null,0,	AN_DAAcitveReqNum	),
decode(	AN_DAAcitveSuccNum	,null,0,	AN_DAAcitveSuccNum	),
decode(	AN_DAAcitveFailNum	,null,0,	AN_DAAcitveFailNum	),
decode(	EqlUserNum	,null,0,	EqlUserNum	),
decode(	Call_Traffic	,null,0,	Call_Traffic	),
decode(	CE_Traffic	,null,0,	CE_Traffic	),
decode(	Sho_Traffic	,null,0,	Sho_Traffic	),
decode(	Sho_Factor	,null,0,	Sho_Factor	),
decode(	PCFRevDataSize	,null,0,	PCFRevDataSize	),
decode(	PCFFwdDataSize	,null,0,	PCFFwdDataSize	),
decode(	PCFRevPSMsg	,null,0,	PCFRevPSMsg	),
decode(	PCFFwdPSMsg	,null,0,	PCFFwdPSMsg	),
decode(	RevPSDiscardNum	,null,0,	RevPSDiscardNum	),
decode(	FwdPSDiscardNum	,null,0,	FwdPSDiscardNum	),
decode(	GlobalSHoReqNum	,null,0,	GlobalSHoReqNum	),
decode(	GlobalSHoSuccNum	,null,0,	GlobalSHoSuccNum	),
decode(	PageReqNum	,null,0,	PageReqNum	),
decode(	PageResponceNum	,null,0,	PageResponceNum	),
decode(	DOCarrier37	,null,0,	DOCarrier37	),
decode(	DOCarrier78	,null,0,	DOCarrier78	),
decode(	DOCarrier119	,null,0,	DOCarrier119	),
decode(	DOCarrierTotalNum	,null,0,	DOCarrierTotalNum	),
decode(	DOCarrier37Traffic	,null,0,	DOCarrier37Traffic	),
decode(	DOCarrier78Traffic	,null,0,	DOCarrier78Traffic	),
decode(	DOCarrier119Traffic	,null,0,	DOCarrier119Traffic	),
decode(	OneDOCarrierCellNum	,null,0,	OneDOCarrierCellNum	),
decode(	TwoDOCarrierCellNum	,null,0,	TwoDOCarrierCellNum	),
decode(	ThreeDOCarrierCellNum	,null,0,	ThreeDOCarrierCellNum	),
decode(	DOCellNum	,null,0,	DOCellNum	),
decode(	ConnectSetupTotalDuration	,null,0,	ConnectSetupTotalDuration	),
decode(	ConnectUseTotalDuration	,null,0,	ConnectUseTotalDuration	),
decode(	SessionSetupTotalDuration	,null,0,	SessionSetupTotalDuration	),
decode(	FwdRxSize	,null,0,	FwdRxSize	),
decode(	FwdTxSize	,null,0,	FwdTxSize	),
decode(	RevRxSize	,null,0,	RevRxSize	),
decode(	RevTxSize	,null,0,	RevTxSize	),
decode(	RABBusyNum	,null,0,	RABBusyNum	),
decode(	RABFreeNum	,null,0,	RABFreeNum	),
decode(	FwdAvailNum_MacIndex	,null,0,	FwdAvailNum_MacIndex	),
decode(	DRCApplyNum_FwdSpeed1	,null,0,	DRCApplyNum_FwdSpeed1	),
decode(	DRCApplyNum_FwdSpeed2	,null,0,	DRCApplyNum_FwdSpeed2	),
decode(	DRCApplyNum_FwdSpeed3	,null,0,	DRCApplyNum_FwdSpeed3	),
decode(	FwdTCHPhyTxBitNum	,null,0,	FwdTCHPhyTxBitNum	),
decode(	FwdPhyUseTimeSlotDuration	,null,0,	FwdPhyUseTimeSlotDuration	),
decode(	RevTCHPhyTxBitNum	,null,0,	RevTCHPhyTxBitNum	),
decode(	RevPhyUseTimeSlotDuration	,null,0,	RevPhyUseTimeSlotDuration	)
from c_perf_do_sum where scan_start_time= v_date and sum_level=0 and ne_type=101 and vendor_id=7
and int_id=perf.int_id
)
where scan_start_time= v_date and sum_level=0 and ne_type=101 and vendor_id=7 ;
commit;




exception when others then
s_error := sqlerrm;
rollback;
insert into job_log values(sysdate,'c_perf_do_sum_zx',s_error);
commit;

end;
