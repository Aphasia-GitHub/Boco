create or replace procedure proc_c_perf_1x_sum_zx(p_date date)
as
v_date date;
s_error varchar2(4000);
v_sql varchar2(4000);
begin
select trunc(decode(p_date,null,trunc(sysdate-4/24,'hh24'),p_date),'hh24') into v_date from dual;

dbms_output.put_line('Now time:'||sysdate||'-');

v_sql:='truncate table C_PERF_1X_SUM_ZX_TEMP';
dbms_output.put_line(v_sql);
execute immediate v_sql;
dbms_output.put_line('Now time:'||sysdate||'-');

v_sql:='truncate table C_TPD_1X_SUM_ZX_TEMP';
dbms_output.put_line(v_sql);
execute immediate v_sql;
dbms_output.put_line('Now time:'||sysdate||'-');
commit;

insert /*+ APPEND*/ into C_TPD_1X_SUM_ZX_TEMP
(
int_id             ,
scan_start_time    ,
vendor_id          ,
V_AvfAssReq_AvfSvcAss_CallDur,
v_AvfSvcAss_AvfAssCmp_CallDur,
v_AvrAssCmp_AvfRlsReq_CallDur,
sm_AvfAssReq_AvfSvcAss_CallDur,
sm_AvfSvcAss_AvfAssCmp_CallDur,
sm_AvrAssCmp_AvfRlsReq_CallDur,
AvfSvcAss_AvfAssCmp_CallDur,
AvrAssCmp_AvfRlsReq_CallDur,
P_AvfAssReq_AvfSvcAss_CallDur,
p_AvfSvcAss_AvfAssCmp_CallDur,
p_AvrAssCmp_AvfRlsReq_CallDur,
v_CM_RadioFNum,
sm_CM_RadioLoseCallingNum,
ConVoc_RlsFailNum,
ConVocData_RlsFailNum,
p_CM_RadioFNum,
ConData_RlsFailNum,
v_AvfSvcAss_AvfAssCmp_SHoDur,
v_AvrAssCmp_AvfRlsReq_ShoDur,
sm_AvfSvcAss_AvfAssCmp_SHoDur,
sm_AvrAssCmp_AvfRlsReq_ShoDur,
AvfSvcAss_AvfAssCmp_SHoDur,
AvrAssCmp_AvfRlsReq_ShoDur,
v_AvfSvcAss_AvfAssCmp_SSHoDur,
V_AvrAssCmp_AvfRlsReq_SSHoDur,
sm_AvfSvcAss_AvfAssCmp_SSHoDur,
sm_AvrAssCmp_AvfRlsReq_SSHoDur,
AvfSvcAss_AvfAssCmp_SSHoDur,
AvrAssCmp_AvfRlsReq_SSHoDur,
p_AvfSvcAss_AvfAssCmp_SHoDur,
p_AvrAssCmp_AvfRlsReq_ShoDur,
p_AvfSvcAss_AvfAssCmp_SSHoDur,
p_AvrAssCmp_AvfRlsReq_SSHoDur,
V_AvfRlsReq_KilPrc_CallDur,
AvfRlsReq_KilPrc_CallDur,
sm_AvfRlsReq_KilPrc_CallDur,
V_AvfRlsReq_KilPrc_ShoDur,
sm_AvfRlsReq_KilPrc_ShoDur,
AvfRlsReq_KilPrc_ShoDur,
v_CallSuccessNum,
v_ExtInterruptNum,
v_BlockFailureNum,
v_OtherFailureNum,
v_CallSuccessNum_orig,
v_ExtInterruptNum_orig,
v_BlockFailureNum_orig,
v_OtherFailureNum_orig,
v_PageResponceNum,
v_MSOriginateNum,
p_CallSuccessNum_carrier,
p_ExtInterruptNum_carrier,
p_MSOriginateNum)
select
int_id             ,
scan_start_time    ,
vendor_id          ,
V_AvfAssReq_AvfSvcAss_CallDur,
v_AvfSvcAss_AvfAssCmp_CallDur,
v_AvrAssCmp_AvfRlsReq_CallDur,
sm_AvfAssReq_AvfSvcAss_CallDur,
sm_AvfSvcAss_AvfAssCmp_CallDur,
sm_AvrAssCmp_AvfRlsReq_CallDur,
AvfSvcAss_AvfAssCmp_CallDur,
AvrAssCmp_AvfRlsReq_CallDur,
P_AvfAssReq_AvfSvcAss_CallDur,
p_AvfSvcAss_AvfAssCmp_CallDur,
p_AvrAssCmp_AvfRlsReq_CallDur,
v_CM_RadioFNum,
sm_CM_RadioLoseCallingNum,
ConVoc_RlsFailNum,
ConVocData_RlsFailNum,
p_CM_RadioFNum,
ConData_RlsFailNum,
v_AvfSvcAss_AvfAssCmp_SHoDur,
v_AvrAssCmp_AvfRlsReq_ShoDur,
sm_AvfSvcAss_AvfAssCmp_SHoDur,
sm_AvrAssCmp_AvfRlsReq_ShoDur,
AvfSvcAss_AvfAssCmp_SHoDur,
AvrAssCmp_AvfRlsReq_ShoDur,
v_AvfSvcAss_AvfAssCmp_SSHoDur,
V_AvrAssCmp_AvfRlsReq_SSHoDur,
sm_AvfSvcAss_AvfAssCmp_SSHoDur,
sm_AvrAssCmp_AvfRlsReq_SSHoDur,
AvfSvcAss_AvfAssCmp_SSHoDur,
AvrAssCmp_AvfRlsReq_SSHoDur,
p_AvfSvcAss_AvfAssCmp_SHoDur,
p_AvrAssCmp_AvfRlsReq_ShoDur,
p_AvfSvcAss_AvfAssCmp_SSHoDur,
p_AvrAssCmp_AvfRlsReq_SSHoDur,
V_AvfRlsReq_KilPrc_CallDur,
AvfRlsReq_KilPrc_CallDur,
sm_AvfRlsReq_KilPrc_CallDur,
V_AvfRlsReq_KilPrc_ShoDur,
sm_AvfRlsReq_KilPrc_ShoDur,
AvfRlsReq_KilPrc_ShoDur,
v_CallSuccessNum,
v_ExtInterruptNum,
v_BlockFailureNum,
v_OtherFailureNum,
v_CallSuccessNum_orig,
v_ExtInterruptNum_orig,
v_BlockFailureNum_orig,
v_OtherFailureNum_orig,
v_PageResponceNum,
v_MSOriginateNum,
p_CallSuccessNum,
p_ExtInterruptNum,
p_MSOriginateNum
from  C_tpd_cnt_carr_zx
where scan_start_time=v_date;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-----------------------------------
insert /*+ APPEND*/ into C_TPD_1X_SUM_ZX_TEMP
(
int_id           ,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
v_TgtBscFREQ_HoSNum,
v_TgtBscFREQ_HoFNum,
v_TgtBscFO_HoSNum,
v_TgtBscFO_HoFNum,
v_TgtBscRC_HoSNum,
v_TgtBscRC_HoFNum,
v_SrcBscFREQ_HoSNum,
v_SrcBscFREQ_HoFNum,
v_SrcBscFO_HoSNum,
v_SrcBscFO_HoFNum,
v_SrcBscRC_HoSNum,
v_SrcBscRC_HoFNum,
VOC_HoAddSuccessNum,
VOC_HoExtInterruptNum,
VOC_HoBlockFailureNum,
VOC_HoOtherFailureNum,
CON_HoAddSuccessNum,
CON_HoExtInterruptNum,
CON_HoBlockFailureNum,
CON_HoOtherFailureNum,
v_TgtBscSoftAdd_HoSNum,
v_TgtBscSoftAdd_HoFNum,
v_TgtBscSofterAdd_HoSNum,
v_TgtBscSofterAdd_HoFNum,
v_InterBscHo_HoSNum_source,
v_InterBscHo_HoFNum_dest,
v_SrcBscSoftAdd_HoSNum,
v_SrcBscSoftAdd_HoFNum,
v_SrcBscSofterAdd_HoSNum,
v_SrcBscSofterAdd_HoFNum,
v_InterBscHo_HoSNum,
v_InterBscHo_HoFNum_source,
p_TgtBscFREQ_HoSNum,
p_TgtBscFREQ_HoFNum,
p_TgtBscFO_HoSNum,
p_TgtBscFO_HoFNum,
p_TgtBscRC_HoSNum,
p_TgtBscRC_HoFNum,
p_SrcBscFREQ_HoSNum,
p_SrcBscFREQ_HoFNum,
p_SrcBscFO_HoSNum,
p_SrcBscFO_HoFNum,
p_SrcBscRC_HoSNum,
p_SrcBscRC_HoFNum,
p_TgtBscSoftAdd_HoSNum,
p_TgtBscSoftAdd_HoFNum,
p_TgtBscSofterAdd_HoSNum,
p_TgtBscSofterAdd_HoFNum,
InterBscHo_HoSNum_dest,
InterBscHo_HoFNum,
p_SrcBscSoftAdd_HoSNum,
p_SrcBscSoftAdd_HoFNum,
p_SrcBscSofterAdd_HoSNum,
p_SrcBscSofterAdd_HoFNum,
p_InterBscHo_HoSNum,
p_InterBscHo_HoFNum,
data_HoAddSuccessNum,
data_HoExtInterruptNum,
data_HoBlockFailureNum,
data_HoOtherFailureNum,
V_SSHoDuration,
P_SHoDuration,
P_SSHoDuration,
v_SHoDuration
)
select
int_id           ,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
v_TgtBscFREQ_HoSNum,
v_TgtBscFREQ_HoFNum,
v_TgtBscFO_HoSNum,
v_TgtBscFO_HoFNum,
v_TgtBscRC_HoSNum,
v_TgtBscRC_HoFNum,
v_SrcBscFREQ_HoSNum,
v_SrcBscFREQ_HoFNum,
v_SrcBscFO_HoSNum,
v_SrcBscFO_HoFNum,
v_SrcBscRC_HoSNum,
v_SrcBscRC_HoFNum,
VOC_HoAddSuccessNum,
VOC_HoExtInterruptNum,
VOC_HoBlockFailureNum,
VOC_HoOtherFailureNum,
CON_HoAddSuccessNum,
CON_HoExtInterruptNum,
CON_HoBlockFailureNum,
CON_HoOtherFailureNum,
v_TgtBscSoftAdd_HoSNum,
v_TgtBscSoftAdd_HoFNum,
v_TgtBscSofterAdd_HoSNum,
v_TgtBscSofterAdd_HoFNum,
v_InterBscHo_HoSNum_source,
v_InterBscHo_HoFNum_dest,
v_SrcBscSoftAdd_HoSNum,
v_SrcBscSoftAdd_HoFNum,
v_SrcBscSofterAdd_HoSNum,
v_SrcBscSofterAdd_HoFNum,
v_InterBscHo_HoSNum,
v_InterBscHo_HoFNum_source,
p_TgtBscFREQ_HoSNum,
p_TgtBscFREQ_HoFNum,
p_TgtBscFO_HoSNum,
p_TgtBscFO_HoFNum,
p_TgtBscRC_HoSNum,
p_TgtBscRC_HoFNum,
p_SrcBscFREQ_HoSNum,
p_SrcBscFREQ_HoFNum,
p_SrcBscFO_HoSNum,
p_SrcBscFO_HoFNum,
p_SrcBscRC_HoSNum,
p_SrcBscRC_HoFNum,
p_TgtBscSoftAdd_HoSNum,
p_TgtBscSoftAdd_HoFNum,
p_TgtBscSofterAdd_HoSNum,
p_TgtBscSofterAdd_HoFNum,
InterBscHo_HoSNum_dest,
InterBscHo_HoFNum,
p_SrcBscSoftAdd_HoSNum,
p_SrcBscSoftAdd_HoFNum,
p_SrcBscSofterAdd_HoSNum,
p_SrcBscSofterAdd_HoFNum,
p_InterBscHo_HoSNum,
p_InterBscHo_HoFNum,
data_HoAddSuccessNum,
data_HoExtInterruptNum,
data_HoBlockFailureNum,
data_HoOtherFailureNum,
V_SSHoDuration,
P_SHoDuration,
P_SSHoDuration,
v_SHoDuration
from  C_tpd_cnt_carr_ho_zx
where scan_start_time=v_date;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
---------
insert /*+ APPEND*/ into C_TPD_1X_SUM_ZX_TEMP
(
int_id           ,
unique_rdn,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
v_CEBlockNum_carrier,
v_CHBlockNum_carrier,
v_FPWBlockNum_carrier,
v_FOBlockNum_carrier,
v_AbiscBlockNum_l3_carrier,
v_AbiscBlockNum_carrier,
p_CEBlockNum,
p_CHBlockNum,
p_FPWBlockNum,
p_FPWBlockNum_l3,
p_FOBlockNum,
p_FOBlockNum_l3,
p_AbiscBlockNum,
p_AbiscBlockNum_l3,
v_CEBlockNum_l3_carrier,
v_CHBlockNum_l3_carrier,
v_FPWBlockNum_l3_carrier,
v_FOBlockNum_l3_carrier,
p_CEBlockNum_l3,
p_CHBlockNum_l3
)
select
int_id           ,
unique_rdn,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
v_CEBlockNum,
v_CHBlockNum,
v_FPWBlockNum,
v_FOBlockNum,
v_AbiscBlockNum_l3,
v_AbiscBlockNum,
p_CEBlockNum,
p_CHBlockNum,
p_FPWBlockNum,
p_FPWBlockNum_l3,
p_FOBlockNum,
p_FOBlockNum_l3,
p_AbiscBlockNum,
p_AbiscBlockNum_l3,
v_CEBlockNum_l3,
v_CHBlockNum_l3,
v_FPWBlockNum_l3,
v_FOBlockNum_l3,
p_CEBlockNum_l3,
p_CHBlockNum_l3
from C_tpd_cnt_carr_serv_zx
where scan_start_time=v_date;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-------
insert /*+ APPEND*/ into C_TPD_1X_SUM_ZX_TEMP
(
int_id           ,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
dwTxRexmitFrame,
dwTxTotalFrame,
dwRxRexmitFrame,
dwRxTotalFrame
)
select
int_id           ,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
dwTxRexmitFrame,
dwTxTotalFrame,
dwRxRexmitFrame,
dwRxTotalFrame
from C_tpd_cnt_bsc_zx
where scan_start_time=v_date;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
--------------------------------
insert /*+ APPEND*/ into C_TPD_1X_SUM_ZX_TEMP
(
int_id             ,
scan_start_time    ,
vendor_id          ,
nbrAvailCe
)
select
int_id             ,
scan_start_time    ,
vendor_id          ,
nbrAvailCe
from c_tpd_sts_bts
where scan_start_time=v_date;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
------
insert /*+ APPEND*/ into C_TPD_1X_SUM_ZX_TEMP
(
int_id           ,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
v_CMO_CallSuccessNum,
v_CMO_ExtInterruptNum,
v_CMO_BlockFailureNum,
v_CMO_OtherFailureNum,
v_AccProbe_CallSuccessNum,
v_AccProbe_ExtInterruptNum,
v_AccProbe_BlockFailureNum,
v_AccProbe_OtherFailureNum,
v_AccHo_CallSuccessNum,
v_AccHo_ExtInterruptNum,
v_AccHo_BlockFailureNum,
v_AccHo_OtherFailureNum,
v_AssignSoft_CallSuccessNum,
v_AssignSoft_ExtInterruptNum,
v_AssignSoft_BlockFailureNum,
v_AssignSoft_OtherFailureNum,
v_CMO_PageResponceNum,
v_AssignSoft_PageResponceNum,
sm_CMO_PageResponceNum,
sm_AccProbe_PageResponceNum,
sm_AccHo_PageResponceNum,
sm_AssignSoft_PageResponceNum,
sm_CMO_CallSuccessNum,
sm_CMO_ExtInterruptNum,
sm_AccProbe_CallSuccessNum,
sm_AccProbe_ExtInterruptNum,
sm_AccHo_CallSuccessNum,
sm_AccHo_ExtInterruptNum,
sm_AssignSoft_CallSuccessNum,
sm_AssignSoft_ExtInterruptNum,
p_CMO_CallSuccessNum,
p_CMO_ExtInterruptNum,
p_AssignSoft_CallSuccessNum,
p_AssignSoft_ExtInterruptNum,
p_CallSuccessNum_pag,
p_ExtInterruptNum_pag,
p_CMO_PageResponceNum,
p_AssignSoft_PageResponceNum,
p_PageResponceNum,
V_AccProbe_ExtInvalidCallNum,
V_AccHo_ExtInvalidCallNum_pag,
Sm_AccProbe_BlockFailureNum,
Sm_AccProbe_OtherFailureNum,
Sm_AccHo_BlockFailureNum,
Sm_AccHo_OtherFailureNum
)
select
int_id           ,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
v_CMO_CallSuccessNum,
v_CMO_ExtInterruptNum,
v_CMO_BlockFailureNum,
v_CMO_OtherFailureNum,
v_AccProbe_CallSuccessNum,
v_AccProbe_ExtInterruptNum,
v_AccProbe_BlockFailureNum,
v_AccProbe_OtherFailureNum,
v_AccHo_CallSuccessNum,
v_AccHo_ExtInterruptNum,
v_AccHo_BlockFailureNum,
v_AccHo_OtherFailureNum,
v_AssignSoft_CallSuccessNum,
v_AssignSoft_ExtInterruptNum,
v_AssignSoft_BlockFailureNum,
v_AssignSoft_OtherFailureNum,
v_CMO_PageResponceNum,
v_AssignSoft_PageResponceNum,
sm_CMO_PageResponceNum,
sm_AccProbe_PageResponceNum,
sm_AccHo_PageResponceNum,
sm_AssignSoft_PageResponceNum,
sm_CMO_CallSuccessNum,
sm_CMO_ExtInterruptNum,
sm_AccProbe_CallSuccessNum,
sm_AccProbe_ExtInterruptNum,
sm_AccHo_CallSuccessNum,
sm_AccHo_ExtInterruptNum,
sm_AssignSoft_CallSuccessNum,
sm_AssignSoft_ExtInterruptNum,
p_CMO_CallSuccessNum,
p_CMO_ExtInterruptNum,
p_AssignSoft_CallSuccessNum,
p_AssignSoft_ExtInterruptNum,
p_CallSuccessNum,
p_ExtInterruptNum,
p_CMO_PageResponceNum,
p_AssignSoft_PageResponceNum,
p_PageResponceNum,
V_AccProbe_ExtInvalidCallNum,
V_AccHo_ExtInvalidCallNum,
Sm_AccProbe_BlockFailureNum,
Sm_AccProbe_OtherFailureNum,
Sm_AccHo_BlockFailureNum,
Sm_AccHo_OtherFailureNum
from  C_tpd_cnt_carr_pag_zx
where scan_start_time=v_date;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
---------------------

insert /*+ APPEND*/ into C_TPD_1X_SUM_ZX_TEMP
(
int_id           ,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
v_CMO_CallSuccessNum_ms_call,
v_CMO_ExtInterruptNum_call,
v_CMO_BlockFailureNum_call,
v_CMO_OtherFailureNum_call,
v_AccProbe_CallSuccessNum_call,
v_AccProbe_ExtInterruptNum_cal,
v_AccProbe_BlockFailureNum_cal,
v_AccProbe_OtherFailureNum_cal,
v_AccHo_CallSuccessNum_call,
v_AccHo_ExtInterruptNum_call,
v_AccHo_BlockFailureNum_call,
v_AccHo_OtherFailureNum_call,
v_AssignSoft_CallSuccessNum_ca,
v_AssignSoft_ExtInterruptNum_c,
v_AssignSoft_BlockFailureNum_c,
v_AssignSoft_OtherFailureNum_c,
v_CMO_MSOriginateNum,
v_AssignSoft_MSOriginateNum,
sm_CMO_MSOrigNum,
sm_AccProbe_MSOrigNum,
sm_AccHo_MSOrigNum,
sm_AssignSoft_MSOrigNum,
sm_CMO_CallSuccNum,
sm_CMO_ExtInterruptNum_call,
sm_AccProbe_CallSuccNum,
sm_AccProbe_ExtInterruptNum_ca,
sm_AccHo_CallSuccNum_call,
sm_AccHo_ExtInterruptNum_call,
sm_AssignSoft_CallSuccNum,
sm_AssignSoft_ExtInterruptNumc,
p_CMO_CallSuccessNum_call,
p_CMO_ExtInterruptNum_call,
p_AssignSoft_CallSuccessNum_ca,
p_AssignSoft_ExtInterruptNumc,
p_CMO_MSOriginateNum,
p_AssignSoft_MSOriginateNum,
sm_CMO_BlockFailNum,
sm_CMO_OtherFailNum,
Sm_AccProbe_BlockFailureNum_ca,
Sm_AccProbe_OtherFailureNum_ca,
Sm_AccHo_BlockFailureNum_call,
Sm_AccHo_OtherFailureNum_call,
sm_AssignSoft_BlockFailNum,
sm_AssignSoft_OtherFailNum,
V_AccProbe_ExtInvalidCallNum_c,
V_AccHo_ExtInvalidCallNum_call
)
select
int_id           ,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
v_CMO_CallSuccessNum_ms,
v_CMO_ExtInterruptNum,
v_CMO_BlockFailureNum,
v_CMO_OtherFailureNum,
v_AccProbe_CallSuccessNum,
v_AccProbe_ExtInterruptNum,
v_AccProbe_BlockFailureNum,
v_AccProbe_OtherFailureNum,
v_AccHo_CallSuccessNum,
v_AccHo_ExtInterruptNum,
v_AccHo_BlockFailureNum,
v_AccHo_OtherFailureNum,
v_AssignSoft_CallSuccessNum,
v_AssignSoft_ExtInterruptNum,
v_AssignSoft_BlockFailureNum,
v_AssignSoft_OtherFailureNum,
v_CMO_MSOriginateNum,
v_AssignSoft_MSOriginateNum,
sm_CMO_MSOrigNum,
sm_AccProbe_MSOrigNum,
sm_AccHo_MSOrigNum,
sm_AssignSoft_MSOrigNum,
sm_CMO_CallSuccNum,
sm_CMO_ExtInterruptNum,
sm_AccProbe_CallSuccNum,
sm_AccProbe_ExtInterruptNum,
sm_AccHo_CallSuccNum,
sm_AccHo_ExtInterruptNum,
sm_AssignSoft_CallSuccNum,
sm_AssignSoft_ExtInterruptNum,
p_CMO_CallSuccessNum,
p_CMO_ExtInterruptNum,
p_AssignSoft_CallSuccessNum,
p_AssignSoft_ExtInterruptNum,
p_CMO_MSOriginateNum,
p_AssignSoft_MSOriginateNum,
sm_CMO_BlockFailNum,
sm_CMO_OtherFailNum,
Sm_AccProbe_BlockFailureNum,
Sm_AccProbe_OtherFailureNum,
Sm_AccHo_BlockFailureNum,
Sm_AccHo_OtherFailureNum,
sm_AssignSoft_BlockFailNum,
sm_AssignSoft_OtherFailNum,
V_AccProbe_ExtInvalidCallNum,
V_AccHo_ExtInvalidCallNum
from C_tpd_cnt_carr_call_zx
where scan_start_time=v_date;
commit;
-----------------------------
dbms_output.put_line('Now time:'||sysdate||'-');
insert /*+ APPEND*/ into C_TPD_1X_SUM_ZX_TEMP
(
int_id           ,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
Reliable95CENum,
ReliableFCENum,
ReliableRCENum,
Total95CENum,
TotalPhyFCENum,
TotalPhyRCENum,
MaxBusyFCENum,
MaxBusyRCENum,
TotalLicRCENum
)
select
int_id           ,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
Reliable95CENum,
ReliableFCENum,
ReliableRCENum,
Total95CENum,
TotalPhyFCENum,
TotalPhyRCENum,
MaxBusyFCENum,
MaxBusyRCENum,
TotalLicRCENum
from C_tpd_cnt_bts_zx
where scan_start_time=v_date;
commit;
-------------------------
dbms_output.put_line('Now time:'||sysdate||'-');
insert /*+ APPEND*/ into C_TPD_1X_SUM_ZX_TEMP
(
int_id           ,
unique_rdn,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
v_VEBlockNum          ,
v_VEBlockNum_l3       ,
v_SEBlockNum          ,
v_SEBlockNum_l3       ,
v_CICBlockNum         ,
v_CICBlockNum_l3      ,
v_CEBlockNum_bsc      ,
v_CEBlockNum_l3_bsc   ,
v_CHBlockNum_bsc      ,
v_CHBlockNum_l3_bsc   ,
v_FPWBlockNum_bsc     ,
v_FPWBlockNum_l3_bsc  ,
v_FOBlockNum_bsc      ,
v_FOBlockNum_l3_bsc   ,
v_AbiscBlockNum_bsc   ,
v_AbiscBlockNum_l3_bsc
)
select
int_id           ,
unique_rdn,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
v_VEBlockNum          ,
v_VEBlockNum_l3       ,
v_SEBlockNum          ,
v_SEBlockNum_l3       ,
v_CICBlockNum         ,
v_CICBlockNum_l3      ,
v_CEBlockNum      ,
v_CEBlockNum_l3   ,
v_CHBlockNum      ,
v_CHBlockNum_l3   ,
v_FPWBlockNum     ,
v_FPWBlockNum_l3  ,
v_FOBlockNum      ,
v_FOBlockNum_l3   ,
v_AbiscBlockNum   ,
v_AbiscBlockNum_l3
from C_tpd_cnt_bsc_carr_serv_zx
where scan_start_time=v_date;
commit;
-----------------------------------
dbms_output.put_line('Now time:'||sysdate||'-');
insert /*+ APPEND*/ into C_TPD_1X_SUM_ZX_TEMP
(
int_id           ,
unique_rdn,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
sm_VEBlockNum,
sm_VEBlockNum_l3,
sm_SEBlockNum,
sm_SEBlockNum_l3,
sm_CICBlockNum,
sm_CICBlockNum_l3,
sm_CEBlockNum,
sm_CEBlockNum_l3,
sm_CHBlockNum,
sm_CHBlockNum_l3,
sm_FPWBlockNum,
sm_FPWBlockNum_l3,
sm_FOBlockNum,
sm_FOBlockNum_l3,
sm_AbiscBlockNum,
sm_AbiscBlockNum_l3
)
select
int_id           ,
unique_rdn,
scan_start_time  ,
scan_stop_time   ,
vendor_id        ,
sm_VEBlockNum,
sm_VEBlockNum_l3,
sm_SEBlockNum,
sm_SEBlockNum_l3,
sm_CICBlockNum,
sm_CICBlockNum_l3,
sm_CEBlockNum,
sm_CEBlockNum_l3,
sm_CHBlockNum,
sm_CHBlockNum_l3,
sm_FPWBlockNum,
sm_FPWBlockNum_l3,
sm_FOBlockNum,
sm_FOBlockNum_l3,
sm_AbiscBlockNum,
sm_AbiscBlockNum_l3
from C_tpd_cnt_bsc_carr_zx
where scan_start_time=v_date;

commit;
-----
dbms_output.put_line('Now time:'||sysdate||'-');
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TrafficExcludeHo,
cs_TrafficExcludeHo,
ps_CallTrafficExcludeHo,
LoseCallingNum,
cs_LoseCallingNum,
ps_LoseCallingNum,
AvgRadioFPeriod,
TCHLoadTrafficExcludeHo,
TCHRadioFNum,
cs_TchReqNumHardho,
cs_TchSuccNumHardho,
cs_CallBlockFailRateHardho,
cs_TchReqNumsoftho,
cs_TchSuccNumsoftho,
cs_CallBlockFailRatesoftho,
ps_TchReqNumHardho,
ps_TchSuccNumHardho,
ps_TchReqNumsoftho,
ps_TchSuccNumsoftho,
cs_HandoffReqNum,
cs_HandoffSuccNum,
cs_HandoffSuccRate,
cs_HardhoReqNum,
cs_HardhoSuccNum,
cs_HardhoSuccRate,
cs_SofthoReqNum,
cs_SofthoSuccNum,
cs_SSofthoReqNum,
cs_SSofthoSuccNum,
cs_SSofthoSuccRate,
ps_HardhoReqNum,
ps_HardhoSuccNum,
ps_SofthoReqNum,
ps_SofthoSuccNum,
ps_SSofthoReqNum,
ps_SSofthoSuccNum,
HandoffReqNum_intra,
HandoffSuccNum_intra,
HandoffReqNum_Extra,
HandoffSuccNum_Extra,
HardhoReqNum_intra,
HardhoSuccNum_intra,
ShoReqNum_intra,
ShoSuccNum_intra,
SShoReqNum_intra,
SShoSuccNum_intra,
HardhoReqNum_Extra,
HardhoSuccNum_Extra,
ShoReqNum_Extra,
ShoSuccNum_Extra,
BtsSysHardHoReqNum,
BtsSysHardHoSuccNum,
SysSHoReqNum,
SysSHoSuccNum,
CallBlockFailNum,
cs_CallBlockFailNum,
ps_CallBlockFailNum,
TrafficIncludeHo,
cs_TrafficIncludeHo,
cs_trafficByWalsh,
cs_SHOTraffic,
cs_SSHOTraffic,
ps_CallTrafficIncludeHo,
ps_trafficByWalsh,
ps_SHOTraffic,
ps_SSHOTraffic,
TCHLoadTrafficIncludeHo,
LoadTrafficByWalsh,
FwdRxTotalFrame,
FdwTxTotalFrameExcludeRx,
RevRxTotalFrame,
RevTxTotalFrameExcludeRx,
RevChRxRate,
TchReqNumCalleeExcludeHoSms,
TchSuccNumCalleeExcludeHoSms,
CEAvailNum,
cs_CallPageReqNum,
cs_CallPageSuccNum,
TchSuccNumExcludeHo,
ps_CallPageSuccNum,
ps_CallPageReqNum,
ChannelNum       ,
ChannelMaxUseNum ,
ChannelMaxUseRate,
FwdChNum         ,
FwdChAvailNum    ,
FwdChMaxUseNum   ,
FwdChMaxUseRate  ,
RevChNum         ,
RevChAvailNum    ,
RevChMaxUseNum   ,
RevChMaxUseRate  ,
CENum            ,
CEAvailRate ,
TchReqNumExcludeHoSms,
CallPageReqTotalNum,
TchReqNumCallerExcludeHoSms,
TchSuccNumCallerExcludeHoSms,
ChannelAvailNum,
TCHNum,
cs_TchReqNumExcludeHo,
TchRadioFRate,
ps_TchReqNumExcludeHo,
cs_TchSuccNumExcludeHo,
ps_TchSuccNumExcludeHo,
TchSuccNumExcludeHoSms,
cs_TchSuccNumIncludeHo,
ps_TchReqNumIncludeHo,
cs_TchReqNumIncludeHo,
ps_TchSuccNumIncludeHo,
TchReqNumIncludeHoSms,
TchSuccNumIncludeHoSms
)
with a as
(
select
c.related_msc related_msc,
sum(nvl(a.V_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.P_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0))/3600 TrafficExcludeHo,
sum(nvl(a.V_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0)) / 3600 cs_TrafficExcludeHo,
sum(nvl(a.P_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0))/3600 ps_CallTrafficExcludeHo,
sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.sm_CM_RadioLoseCallingNum,0)
+nvl(a.ConVoc_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0)
+nvl(a.p_CM_RadioFNum,0)
+nvl(a.ConData_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0)) LoseCallingNum,
sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.ConVoc_RlsFailNum    ,0)
+nvl(a.ConVocData_RlsFailNum,0)) cs_LoseCallingNum,
sum(nvl(a.p_CM_RadioFNum,0)
+nvl(a.ConData_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0)) ps_LoseCallingNum,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0))/3600*60/
decode(sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.ConVoc_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0)),0,1,null,1,sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.ConVoc_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0))) AvgRadioFPeriod,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0))/3600 TCHLoadTrafficExcludeHo,
sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.ConVoc_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0)) TCHRadioFNum,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscFO_HoFNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.v_TgtBscRC_HoFNum,0)
+nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoFNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscFO_HoFNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.v_SrcBscRC_HoFNum,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)) cs_TchReqNumHardho,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum,0)
+nvl(a.CON_HoExtInterruptNum,0)) cs_TchSuccNumHardho,
round(sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscFO_HoFNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.v_TgtBscRC_HoFNum,0)
+nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoFNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscFO_HoFNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.v_SrcBscRC_HoFNum,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)
-nvl(a.v_TgtBscFREQ_HoSNum,0)
-nvl(a.v_TgtBscFO_HoSNum,0)
-nvl(a.v_TgtBscRC_HoSNum,0)
-nvl(a.v_SrcBscFREQ_HoSNum,0)
-nvl(a.v_SrcBscFO_HoSNum,0)
-nvl(a.v_SrcBscRC_HoSNum,0)
-nvl(a.VOC_HoAddSuccessNum,0)
-nvl(a.VOC_HoExtInterruptNum,0)
-nvl(a.CON_HoAddSuccessNum,0)
-nvl(a.CON_HoExtInterruptNum,0))/
decode(sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscFO_HoFNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.v_TgtBscRC_HoFNum,0)
+nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoFNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscFO_HoFNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.v_SrcBscRC_HoFNum,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)),0,1,null,1,sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscFO_HoFNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.v_TgtBscRC_HoFNum,0)
+nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoFNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscFO_HoFNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.v_SrcBscRC_HoFNum,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)))*100,4) cs_CallBlockFailRateHardho,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_dest,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)) cs_TchReqNumsoftho,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum,0))  cs_TchSuccNumsoftho,
round(sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_dest,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
-nvl(a.v_TgtBscSoftAdd_HoSNum,0)
-nvl(a.v_TgtBscSofterAdd_HoSNum,0)
-nvl(a.v_InterBscHo_HoSNum_source,0)
-nvl(a.v_SrcBscSoftAdd_HoSNum,0)
-nvl(a.v_SrcBscSofterAdd_HoSNum,0)
-nvl(a.v_InterBscHo_HoSNum_source,0))/
decode(sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_dest,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)),0,1,null,1,sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_dest,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)))*100,4)  cs_CallBlockFailRatesoftho,
sum(nvl(a.p_TgtBscFREQ_HoSNum,0)
+nvl(a.p_TgtBscFREQ_HoFNum,0)
+nvl(a.p_TgtBscFO_HoSNum  ,0)
+nvl(a.p_TgtBscFO_HoFNum  ,0)
+nvl(a.p_TgtBscRC_HoSNum  ,0)
+nvl(a.p_TgtBscRC_HoFNum  ,0)
+nvl(a.p_SrcBscFREQ_HoSNum,0)
+nvl(a.p_SrcBscFREQ_HoFNum,0)
+nvl(a.p_SrcBscFO_HoSNum  ,0)
+nvl(a.p_SrcBscFO_HoFNum  ,0)
+nvl(a.p_SrcBscRC_HoSNum  ,0)
+nvl(a.p_SrcBscRC_HoFNum  ,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0))  ps_TchReqNumHardho,
sum(nvl(a.p_TgtBscFREQ_HoSNum  ,0)
+nvl(a.p_TgtBscFO_HoSNum    ,0)
+nvl(a.p_TgtBscRC_HoSNum    ,0)
+nvl(a.p_SrcBscFREQ_HoSNum  ,0)
+nvl(a.p_SrcBscFO_HoSNum    ,0)
+nvl(a.p_SrcBscRC_HoSNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)) ps_TchSuccNumHardho,
sum(nvl(a.p_TgtBscSoftAdd_HoSNum,0)
+nvl(a.p_TgtBscSoftAdd_HoFNum   ,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum ,0)
+nvl(a.p_TgtBscSofterAdd_HoFNum ,0)
+nvl(a.InterBscHo_HoSNum_dest   ,0)
+nvl(a.InterBscHo_HoFNum        ,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum   ,0)
+nvl(a.p_SrcBscSoftAdd_HoFNum   ,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum ,0)
+nvl(a.p_SrcBscSofterAdd_HoFNum ,0)
+nvl(a.p_InterBscHo_HoSNum      ,0)
+nvl(a.p_InterBscHo_HoFNum,0)) ps_TchReqNumsoftho,
sum(nvl(a.p_TgtBscSoftAdd_HoSNum,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.InterBscHo_HoSNum_dest,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum,0)
+nvl(a.p_InterBscHo_HoSNum,0)) ps_TchSuccNumsoftho,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum       ,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscFO_HoFNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoFNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFREQ_HoFNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscFO_HoFNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoFNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.VOC_HoBlockFailureNum     ,0)
+nvl(a.VOC_HoOtherFailureNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.CON_HoBlockFailureNum     ,0)
+nvl(a.CON_HoOtherFailureNum     ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum    ,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_InterBscHo_HoFNum_dest  ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0) ) cs_HandoffReqNum,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0))  cs_HandoffSuccNum,
round(sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0))/
decode(sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum       ,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscFO_HoFNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoFNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFREQ_HoFNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscFO_HoFNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoFNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.VOC_HoBlockFailureNum     ,0)
+nvl(a.VOC_HoOtherFailureNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.CON_HoBlockFailureNum     ,0)
+nvl(a.CON_HoOtherFailureNum     ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum    ,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_InterBscHo_HoFNum_dest  ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)),0,1,null,1,sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum       ,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscFO_HoFNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoFNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFREQ_HoFNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscFO_HoFNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoFNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.VOC_HoBlockFailureNum     ,0)
+nvl(a.VOC_HoOtherFailureNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.CON_HoBlockFailureNum     ,0)
+nvl(a.CON_HoOtherFailureNum     ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum    ,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_InterBscHo_HoFNum_dest  ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)))*100,4) cs_HandoffSuccRate,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)) cs_HardhoSuccNum,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum  ,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscFO_HoFNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoFNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFREQ_HoFNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscFO_HoFNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoFNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)) cs_HardhoReqNum,
--modify-2011-10-27
case when sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum  ,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscFO_HoFNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoFNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFREQ_HoFNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscFO_HoFNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoFNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)) is null then 100
when sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum  ,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscFO_HoFNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoFNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFREQ_HoFNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscFO_HoFNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoFNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)) = 0 then 100
else round(sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum,0)
+nvl(a.CON_HoExtInterruptNum,0))/
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum  ,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscFO_HoFNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoFNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFREQ_HoFNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscFO_HoFNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoFNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0))*100,4)
end                                    cs_HardhoSuccRate,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum    ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_InterBscHo_HoFNum_dest  ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum    ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)) cs_SofthoReqNum,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)) cs_SofthoSuccNum,
sum(nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)) cs_SSofthoReqNum,
sum(nvl(a.v_TgtBscSofterAdd_HoSNum,0)+nvl(a.v_SrcBscSofterAdd_HoSNum,0)) cs_SSofthoSuccNum,
round(sum(nvl(a.v_TgtBscSofterAdd_HoSNum,0)+nvl(a.v_SrcBscSofterAdd_HoSNum,0))/
decode(sum(nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)),0,1,null,1,sum(nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)))*100,4) cs_SSofthoSuccRate,
sum(nvl(a.p_TgtBscFREQ_HoSNum  ,0)
+nvl(a.p_TgtBscFREQ_HoFNum  ,0)
+nvl(a.p_TgtBscFO_HoSNum    ,0)
+nvl(a.p_TgtBscFO_HoFNum    ,0)
+nvl(a.p_TgtBscRC_HoSNum    ,0)
+nvl(a.p_TgtBscRC_HoFNum    ,0)
+nvl(a.p_SrcBscFREQ_HoSNum  ,0)
+nvl(a.p_SrcBscFREQ_HoFNum  ,0)
+nvl(a.p_SrcBscFO_HoSNum    ,0)
+nvl(a.p_SrcBscFO_HoFNum    ,0)
+nvl(a.p_SrcBscRC_HoSNum    ,0)
+nvl(a.p_SrcBscRC_HoFNum    ,0)
+nvl(a.data_HoAddSuccessNum  ,0)
+nvl(a.data_HoExtInterruptNum,0)
+nvl(a.data_HoBlockFailureNum,0)
+nvl(a.data_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)) ps_HardhoReqNum,
sum(nvl(a.p_TgtBscFREQ_HoSNum,0)
+nvl(a.p_TgtBscFO_HoSNum    ,0)
+nvl(a.p_TgtBscRC_HoSNum    ,0)
+nvl(a.p_SrcBscFREQ_HoSNum  ,0)
+nvl(a.p_SrcBscFO_HoSNum    ,0)
+nvl(a.p_SrcBscRC_HoSNum    ,0)
+nvl(a.data_HoAddSuccessNum  ,0)
+nvl(a.data_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)) ps_HardhoSuccNum,
sum(nvl(a.p_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.p_TgtBscSoftAdd_HoFNum  ,0)
+nvl(a.InterBscHo_HoSNum_dest,0)
+nvl(a.InterBscHo_HoFNum       ,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum  ,0)
+nvl(a.p_SrcBscSoftAdd_HoFNum  ,0)
+nvl(a.p_InterBscHo_HoSNum     ,0)
+nvl(a.p_InterBscHo_HoFNum     ,0)) ps_SofthoReqNum,
sum(nvl(a.p_TgtBscSoftAdd_HoSNum,0)
+nvl(a.InterBscHo_HoSNum_dest,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum  ,0)
+nvl(a.p_InterBscHo_HoSNum     ,0)) ps_SofthoSuccNum,
sum(nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_TgtBscSofterAdd_HoFNum,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum,0)
+nvl(a.p_SrcBscSofterAdd_HoFNum,0)) ps_SSofthoReqNum,
sum(nvl(a.p_TgtBscSofterAdd_HoSNum,0)+nvl(a.p_SrcBscSofterAdd_HoSNum,0)) ps_SSofthoSuccNum,
sum(nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoFNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscFO_HoFNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.v_SrcBscRC_HoFNum,0)
+nvl(a.p_SrcBscFREQ_HoSNum,0)
+nvl(a.p_SrcBscFREQ_HoFNum,0)
+nvl(a.p_SrcBscFO_HoSNum,0)
+nvl(a.p_SrcBscFO_HoFNum,0)
+nvl(a.p_SrcBscRC_HoSNum,0)
+nvl(a.p_SrcBscRC_HoFNum,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum,0)
+nvl(a.p_SrcBscSoftAdd_HoFNum,0)
+nvl(a.p_InterBscHo_HoSNum,0)
+nvl(a.p_InterBscHo_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum,0)
+nvl(a.p_SrcBscSofterAdd_HoFNum,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)) HandoffReqNum_intra,
--update-2011-9-14
sum(nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.p_SrcBscFREQ_HoSNum,0)
+nvl(a.p_SrcBscFO_HoSNum,0)
+nvl(a.p_SrcBscRC_HoSNum,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum,0)
+nvl(a.p_InterBscHo_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+ nvl(a.p_SrcBscSofterAdd_HoSNum,0)) HandoffSuccNum_intra,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum     ,0)
+nvl(a.v_TgtBscFO_HoSNum       ,0)
+nvl(a.v_TgtBscFO_HoFNum       ,0)
+nvl(a.v_TgtBscRC_HoSNum       ,0)
+nvl(a.v_TgtBscRC_HoFNum       ,0)
+nvl(a.VOC_HoAddSuccessNum     ,0)
+nvl(a.VOC_HoExtInterruptNum   ,0)
+nvl(a.VOC_HoBlockFailureNum   ,0)
+nvl(a.VOC_HoOtherFailureNum   ,0)
+nvl(a.CON_HoAddSuccessNum     ,0)
+nvl(a.CON_HoExtInterruptNum   ,0)
+nvl(a.CON_HoBlockFailureNum   ,0)
+nvl(a.CON_HoOtherFailureNum   ,0)
+nvl(a.p_TgtBscFREQ_HoSNum     ,0)
+nvl(a.p_TgtBscFREQ_HoFNum     ,0)
+nvl(a.p_TgtBscFO_HoSNum       ,0)
+nvl(a.p_TgtBscFO_HoFNum       ,0)
+nvl(a.p_TgtBscRC_HoSNum       ,0)
+nvl(a.p_TgtBscRC_HoFNum       ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum     ,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.p_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.p_TgtBscSoftAdd_HoFNum  ,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_TgtBscSofterAdd_HoFNum,0)
+nvl(a.p_InterBscHo_HoSNum     ,0)
+nvl(a.p_InterBscHo_HoFNum     ,0)) HandoffReqNum_Extra,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.VOC_HoAddSuccessNum     ,0)
+nvl(a.VOC_HoExtInterruptNum   ,0)
+nvl(a.CON_HoAddSuccessNum     ,0)
+nvl(a.CON_HoExtInterruptNum   ,0)
+nvl(a.p_TgtBscFREQ_HoSNum     ,0)
+nvl(a.p_TgtBscFO_HoSNum       ,0)
+nvl(a.p_TgtBscRC_HoSNum       ,0)
+nvl(a.VOC_HoAddSuccessNum     ,0)
+nvl(a.VOC_HoExtInterruptNum   ,0)
+nvl(a.CON_HoAddSuccessNum     ,0)
+nvl(a.CON_HoExtInterruptNum   ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum,0)
+nvl(a.p_TgtBscSoftAdd_HoSNum,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_InterBscHo_HoSNum,0)) HandoffSuccNum_Extra,
sum(nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoFNum,0)
+nvl(a.v_SrcBscFO_HoSNum  ,0)
+nvl(a.v_SrcBscFO_HoFNum  ,0)
+nvl(a.v_SrcBscRC_HoSNum  ,0)
+nvl(a.v_SrcBscRC_HoFNum  ,0)
+nvl(a.p_SrcBscFREQ_HoSNum,0)
+nvl(a.p_SrcBscFREQ_HoFNum,0)
+nvl(a.p_SrcBscFO_HoSNum  ,0)
+nvl(a.p_SrcBscFO_HoFNum  ,0)
+nvl(a.p_SrcBscRC_HoSNum  ,0)
+nvl(a.p_SrcBscRC_HoFNum,0)) HardhoReqNum_intra,
sum(nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFO_HoSNum  ,0)
+nvl(a.v_SrcBscRC_HoSNum  ,0)
+nvl(a.p_SrcBscFREQ_HoSNum,0)
+nvl(a.p_SrcBscFO_HoSNum  ,0)
+nvl(a.p_SrcBscRC_HoSNum,0)) HardhoSuccNum_intra,
sum(nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum   ,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum,0)
+nvl(a.p_SrcBscSoftAdd_HoFNum,0)
+nvl(a.p_InterBscHo_HoSNum   ,0)
+nvl(a.p_InterBscHo_HoFNum   ,0))  ShoReqNum_intra,
sum(nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum   ,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum,0)
+nvl(a.p_InterBscHo_HoSNum   ,0)) ShoSuccNum_intra,
sum(nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum,0)
+nvl(a.p_SrcBscSofterAdd_HoFNum,0))  SShoReqNum_intra,
sum(nvl(a.v_SrcBscSofterAdd_HoSNum,0)+nvl(a.p_SrcBscSofterAdd_HoSNum,0)) SShoSuccNum_intra,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum   ,0)
+nvl(a.v_TgtBscFO_HoSNum     ,0)
+nvl(a.v_TgtBscFO_HoFNum     ,0)
+nvl(a.v_TgtBscRC_HoSNum     ,0)
+nvl(a.v_TgtBscRC_HoFNum     ,0)
+nvl(a.VOC_HoAddSuccessNum   ,0)
+nvl(a.VOC_HoExtInterruptNum ,0)
+nvl(a.VOC_HoBlockFailureNum ,0)
+nvl(a.VOC_HoOtherFailureNum ,0)
+nvl(a.DATA_HoAddSuccessNum  ,0)
+nvl(a.DATA_HoExtInterruptNum,0)
+nvl(a.DATA_HoBlockFailureNum,0)
+nvl(a.DATA_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum   ,0)
+nvl(a.CON_HoExtInterruptNum ,0)
+nvl(a.CON_HoBlockFailureNum ,0)
+nvl(a.CON_HoOtherFailureNum ,0)
+nvl(a.p_TgtBscFREQ_HoSNum   ,0)
+nvl(a.p_TgtBscFREQ_HoFNum   ,0)
+nvl(a.p_TgtBscFO_HoSNum     ,0)
+nvl(a.p_TgtBscFO_HoFNum     ,0)
+nvl(a.p_TgtBscRC_HoSNum     ,0)
+nvl(a.p_TgtBscRC_HoFNum     ,0)) HardhoReqNum_Extra,
sum(nvl(a.v_TgtBscFREQ_HoSNum  ,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.p_TgtBscFREQ_HoSNum  ,0)
+nvl(a.p_TgtBscFO_HoSNum    ,0)
+nvl(a.p_TgtBscRC_HoSNum    ,0)) HardhoSuccNum_Extra,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum     ,0)
+nvl(a.v_InterBscHo_HoFNum_dest,0)
+nvl(a.p_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.p_TgtBscSoftAdd_HoFNum  ,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_TgtBscSofterAdd_HoFNum,0)
+nvl(a.InterBscHo_HoSNum_dest  ,0)
+nvl(a.InterBscHo_HoFNum,0)) ShoReqNum_Extra,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum     ,0)
+nvl(a.p_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_InterBscHo_HoSNum,0)) ShoSuccNum_Extra,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum  ,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscFO_HoFNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoFNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFREQ_HoFNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscFO_HoFNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoFNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)) BtsSysHardHoReqNum,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)) BtsSysHardHoSuccNum,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_InterBscHo_HoFNum_dest  ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)) SysSHoReqNum,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum     ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)) SysSHoSuccNum,
sum(nvl(a.v_CEBlockNum_carrier,0)
+nvl(a.v_CEBlockNum_carrier      ,0)
+nvl(a.v_CHBlockNum_carrier      ,0)
+nvl(a.v_CHBlockNum_carrier      ,0)
+nvl(a.v_FPWBlockNum_carrier     ,0)
+nvl(a.v_FPWBlockNum_carrier     ,0)
+nvl(a.v_FOBlockNum_carrier      ,0)
+nvl(a.v_FOBlockNum_carrier      ,0)
+nvl(a.v_AbiscBlockNum_l3_carrier,0)
+nvl(a.v_AbiscBlockNum_carrier   ,0)
+nvl(a.p_CEBlockNum      ,0)
+nvl(a.p_CEBlockNum      ,0)
+nvl(a.p_CHBlockNum      ,0)
+nvl(a.p_CHBlockNum      ,0)
+nvl(a.p_FPWBlockNum     ,0)
+nvl(a.p_FPWBlockNum_l3  ,0)
+nvl(a.p_FOBlockNum      ,0)
+nvl(a.p_FOBlockNum_l3   ,0)
+nvl(a.p_AbiscBlockNum   ,0)
+nvl(a.p_AbiscBlockNum_l3,0)) CallBlockFailNum,
sum(nvl(a.v_CEBlockNum_carrier,0)
+nvl(a.v_CEBlockNum_l3_carrier,0)
+nvl(a.v_CHBlockNum_carrier,0)
+nvl(a.v_CHBlockNum_l3_carrier,0)
+nvl(a.v_FPWBlockNum_carrier,0)
+nvl(a.v_FPWBlockNum_l3_carrier,0)
+nvl(a.v_FOBlockNum_carrier,0)
+nvl(a.v_FOBlockNum_l3_carrier,0)
+nvl(a.v_AbiscBlockNum_carrier,0)
+nvl(a.v_AbiscBlockNum_l3_carrier,0)) cs_CallBlockFailNum,
sum(nvl(a.p_CEBlockNum,0)
+nvl(a.p_CEBlockNum_l3,0)
+nvl(a.p_CHBlockNum,0)
+nvl(a.p_CHBlockNum_l3,0)
+nvl(a.p_FPWBlockNum,0)
+nvl(a.p_FPWBlockNum_l3,0)
+nvl(a.p_FOBlockNum,0)
+nvl(a.p_FOBlockNum_l3,0)
+nvl(a.p_AbiscBlockNum,0)
+nvl(a.p_AbiscBlockNum_l3,0)) ps_CallBlockFailNum,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(a.V_SSHoDuration                ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.V_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur   ,0)
+nvl(a.V_SSHoDuration,0))/ 3600
+ sum(nvl(a.P_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur  ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur   ,0)
+nvl(a.p_SHoDuration                ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur  ,0)
+nvl(a.P_SSHoDuration,0))/ 3600 TrafficIncludeHo,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur  ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur   ,0)
+nvl(a.V_SHoDuration,0)) / 3600 cs_TrafficIncludeHo,
sum(nvl(a.V_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.V_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur  ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur   ,0)
+nvl(a.V_SHoDuration                ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.V_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur  ,0)
+nvl(a.V_SSHoDuration,0))/3600 cs_trafficByWalsh,
sum(nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.V_AvrAssCmp_AvfRlsReq_ShoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.V_SHoDuration               ,0))/3600 cs_SHOTraffic,
sum(nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.V_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur  ,0)
+nvl(a.V_SSHoDuration               ,0))/3600 cs_SSHOTraffic,
sum(nvl(a.P_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur  ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur   ,0)
+nvl(a.p_SHoDuration,0)) / 3600  ps_CallTrafficIncludeHo,
sum(nvl(a.P_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.P_SHoDuration,0)
+nvl(a.P_SSHoDuration,0))/3600 ps_trafficByWalsh,
sum(nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.P_SHoDuration,0))/3600    ps_SHOTraffic,
sum(nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.P_SSHoDuration,0))/3600   ps_SSHOTraffic,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(a.v_SHoDuration                ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.V_AvfRlsReq_KilPrc_CallDur,0)
+nvl(a.AvfRlsReq_KilPrc_CallDur,0)
+nvl(a.sm_AvfRlsReq_KilPrc_CallDur,0)
+nvl(a.V_AvfRlsReq_KilPrc_ShoDur,0)
+nvl(a.sm_AvfRlsReq_KilPrc_ShoDur,0)
+nvl(a.AvfRlsReq_KilPrc_ShoDur,0))/3600 TCHLoadTrafficIncludeHo,
sum(nvl(a.AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SShoDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_SShoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.P_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.P_SHoDuration,0)
+nvl(a.P_SSHoDuration,0)
+nvl(a.v_SSHoDuration,0))/3600 LoadTrafficByWalsh,




sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum,0)
+nvl(a.v_CMO_BlockFailureNum,0)
+nvl(a.v_CMO_OtherFailureNum,0)
+nvl(a.v_AccProbe_CallSuccessNum,0)
+nvl(a.v_AccProbe_ExtInterruptNum ,0)
+nvl(a.v_AccProbe_BlockFailureNum ,0)
+nvl(a.v_AccProbe_OtherFailureNum ,0)
+nvl(a.v_AccHo_CallSuccessNum     ,0)
+nvl(a.v_AccHo_ExtInterruptNum    ,0)
+nvl(a.v_AccHo_BlockFailureNum    ,0)
+nvl(a.v_AccHo_OtherFailureNum    ,0)
+nvl(a.v_AssignSoft_CallSuccessNum,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)
+nvl(a.v_AssignSoft_BlockFailureNum,0)
+nvl(a.v_AssignSoft_OtherFailureNum,0)
+nvl(a.v_CallSuccessNum            ,0)
+nvl(a.v_ExtInterruptNum           ,0)
+nvl(a.v_BlockFailureNum           ,0)
+nvl(a.v_OtherFailureNum,0)) TchReqNumCalleeExcludeHoSms,
sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum       ,0)
+nvl(a.v_AccProbe_CallSuccessNum   ,0)
+nvl(a.v_AccProbe_ExtInterruptNum  ,0)
+nvl(a.v_AccHo_CallSuccessNum      ,0)
+nvl(a.v_AccHo_ExtInterruptNum     ,0)
+nvl(a.v_AssignSoft_CallSuccessNum ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)
+nvl(a.v_CallSuccessNum            ,0)
+nvl(a.v_ExtInterruptNum,0)) TchSuccNumCalleeExcludeHoSms,
--sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
--+nvl(a.v_CMO_ExtInterruptNum_call       ,0)
--+nvl(a.v_CMO_BlockFailureNum_call       ,0)
--+nvl(a.v_CMO_OtherFailureNum_call       ,0)
--+nvl(a.v_AccProbe_CallSuccessNum_call   ,0)
--+nvl(a.v_AccProbe_ExtInterruptNum_cal  ,0)
--+nvl(a.v_AccProbe_BlockFailureNum_cal  ,0)
--+nvl(a.v_AccProbe_OtherFailureNum_cal  ,0)
--+nvl(a.v_AccHo_CallSuccessNum_call      ,0)
--+nvl(a.v_AccHo_ExtInterruptNum_call     ,0)
--+nvl(a.v_AccHo_BlockFailureNum_call     ,0)
--+nvl(a.v_AccHo_OtherFailureNum_call     ,0)
--+nvl(a.v_AssignSoft_CallSuccessNum_ca ,0)
--+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)
--+nvl(a.v_AssignSoft_BlockFailureNum_c,0)
--+nvl(a.v_AssignSoft_OtherFailureNum_c,0)
--+nvl(a.v_CallSuccessNum_orig       ,0)
--+nvl(a.v_ExtInterruptNum_orig      ,0)
--+nvl(a.v_BlockFailureNum_orig      ,0)
--+nvl(a.v_OtherFailureNum_orig,0)) TchReqNumCallerExcludeHoSms,
--sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
--+nvl(a.v_CMO_ExtInterruptNum_call       ,0)
--+nvl(a.v_AccProbe_CallSuccessNum_call   ,0)
--+nvl(a.v_AccProbe_ExtInterruptNum_cal  ,0)
--+nvl(a.v_AccHo_CallSuccessNum_call      ,0)
--+nvl(a.v_AccHo_ExtInterruptNum_call     ,0)
--+nvl(a.v_AssignSoft_CallSuccessNum_ca ,0)
--+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)
--+nvl(a.v_CallSuccessNum_orig       ,0)
--+nvl(a.v_ExtInterruptNum_orig,0)) TchSuccNumCallerExcludeHoSms,


sum(nvl(a.v_PageResponceNum,0)
+nvl(a.v_MSOriginateNum,0)) cs_CallPageReqNum_a,
sum(nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_CallSuccessNum,0)
+nvl(a.v_ExtInterruptNum,0)) cs_CallPageSuccNum_a,
sum(nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_CallSuccessNum,0)
+nvl(a.v_ExtInterruptNum,0)
+nvl(a.p_CallSuccessNum_carrier,0)
+nvl(a.p_ExtInterruptNum_carrier,0))  TchSuccNumExcludeHo_a,
sum(nvl(a.p_CallSuccessNum_carrier,0)
+nvl(a.p_ExtInterruptNum_carrier,0)) ps_CallPageSuccNum_a,
sum(nvl(a.v_MSOriginateNum,0)) ps_CallPageReqNum_a,
sum(nvl(a.v_CMO_MSOriginateNum,0)
+nvl(a.v_AssignSoft_MSOriginateNum,0)
+nvl(a.sm_CMO_MSOrigNum           ,0)
+nvl(a.sm_AccProbe_MSOrigNum      ,0)
+nvl(a.sm_AccHo_MSOrigNum         ,0)
+nvl(a.sm_AssignSoft_MSOrigNum    ,0)) cs_CallPageReqNum_e,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c ,0)
+nvl(a.sm_CMO_CallSuccNum,0)
+nvl(a.sm_CMO_ExtInterruptNum_call,0)
+nvl(a.sm_AccProbe_CallSuccNum,0)
+nvl(a.sm_AccProbe_ExtInterruptNum_ca,0)
+nvl(a.sm_AccHo_CallSuccNum_call,0)
+nvl(a.sm_AccHo_ExtInterruptNum_call,0)
+nvl(a.sm_AssignSoft_CallSuccNum,0)
+nvl(a.sm_AssignSoft_ExtInterruptNumc,0)) cs_CallPageSuccNum_e  ,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.v_AssignSoft_BlockFailureNum_c,0)
+nvl(a.p_CMO_CallSuccessNum_call,0)
+nvl(a.p_CMO_ExtInterruptNum_call,0)
+nvl(a.p_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.p_AssignSoft_ExtInterruptNumc,0)) TchSuccNumExcludeHo_e,
sum(nvl(a.p_CMO_CallSuccessNum_call,0)
+nvl(a.p_CMO_ExtInterruptNum_call,0)
+nvl(a.p_AssignSoft_CallSuccessNum_ca ,0)
+nvl(a.p_AssignSoft_ExtInterruptNumc,0)) ps_CallPageSuccNum_e,
sum(nvl(a.p_CMO_MSOriginateNum,0)
+nvl(a.p_AssignSoft_MSOriginateNum ,0)) ps_CallPageReqNum_e,
sum(nvl(a.v_CMO_PageResponceNum,0)
+nvl(a.v_AssignSoft_PageResponceNum,0)
+nvl(a.sm_CMO_PageResponceNum,0)
+nvl(a.sm_AccProbe_PageResponceNum,0)
+nvl(a.sm_AccHo_PageResponceNum,0)
+nvl(a.sm_AssignSoft_PageResponceNum,0)) cs_CallPageReqNum_f,
sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum,0)
+nvl(a.v_AssignSoft_CallSuccessNum,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)
+nvl(a.sm_CMO_CallSuccessNum,0)
+nvl(a.sm_CMO_ExtInterruptNum,0)
+nvl(a.sm_AccProbe_CallSuccessNum,0)
+nvl(a.sm_AccProbe_ExtInterruptNum,0)
+nvl(a.sm_AccHo_CallSuccessNum,0)
+nvl(a.sm_AccHo_ExtInterruptNum,0)
+nvl(a.sm_AssignSoft_CallSuccessNum,0)
+nvl(a.sm_AssignSoft_ExtInterruptNum,0)) cs_CallPageSuccNum_f,
sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum,0)
+nvl(a.v_AssignSoft_CallSuccessNum,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)
+nvl(a.p_CMO_CallSuccessNum,0)
+nvl(a.p_CMO_ExtInterruptNum,0)
+nvl(a.p_AssignSoft_CallSuccessNum,0)
+nvl(a.p_AssignSoft_ExtInterruptNum,0)
+nvl(a.p_CallSuccessNum_pag,0)
+nvl(a.p_ExtInterruptNum_pag,0)) TchSuccNumExcludeHo_f,
sum(nvl(a.p_CMO_CallSuccessNum,0)
+nvl(a.p_CMO_ExtInterruptNum       ,0)
+nvl(a.p_AssignSoft_CallSuccessNum ,0)
+nvl(a.p_AssignSoft_ExtInterruptNum,0)
+nvl(a.p_CallSuccessNum_pag            ,0)
+nvl(a.p_ExtInterruptNum_pag           ,0)) ps_CallPageSuccNum_f,
sum(nvl(a.p_CMO_PageResponceNum,0)
+nvl(a.p_AssignSoft_PageResponceNum,0)
+nvl(a.p_PageResponceNum,0)) ps_CallPageReqNum_f,

sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call        ,0)
+nvl(a.v_CMO_BlockFailureNum_call        ,0)
+nvl(a.v_CMO_OtherFailureNum_call        ,0)
+nvl(a.v_AccProbe_CallSuccessNum_call    ,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal   ,0)
+nvl(a.v_AccProbe_BlockFailureNum_cal   ,0)
+nvl(a.v_AccProbe_OtherFailureNum_cal   ,0)
+nvl(a.v_AccHo_CallSuccessNum_call       ,0)
+nvl(a.v_AccHo_ExtInterruptNum_call      ,0)
+nvl(a.v_AccHo_BlockFailureNum_call      ,0)
+nvl(a.v_AccHo_OtherFailureNum_call      ,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca  ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c ,0)
+nvl(a.v_AssignSoft_BlockFailureNum_c ,0)
+nvl(a.v_AssignSoft_OtherFailureNum_c ,0)
+nvl(a.sm_CMO_CallSuccNum           ,0)
+nvl(a.sm_CMO_ExtInterruptNum_call       ,0)
+nvl(a.sm_CMO_BlockFailNum          ,0)
+nvl(a.sm_CMO_OtherFailNum          ,0)
+nvl(a.sm_AccProbe_CallSuccNum      ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum_ca  ,0)
+nvl(a.Sm_AccProbe_BlockFailureNum_ca  ,0)
+nvl(a.Sm_AccProbe_OtherFailureNum_ca  ,0)
+nvl(a.sm_AccHo_CallSuccNum_call         ,0)
+nvl(a.sm_AccHo_ExtInterruptNum_call     ,0)
+nvl(a.Sm_AccHo_BlockFailureNum_call     ,0)
+nvl(a.Sm_AccHo_OtherFailureNum_call     ,0)
+nvl(a.sm_AssignSoft_CallSuccNum    ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNumc,0)
+nvl(a.sm_AssignSoft_BlockFailNum   ,0)
+nvl(a.sm_AssignSoft_OtherFailNum   ,0)
+nvl(a.v_CallSuccessNum_orig        ,0)
+nvl(a.v_ExtInterruptNum_orig       ,0)
+nvl(a.v_BlockFailureNum_orig       ,0)
+nvl(a.v_OtherFailureNum_orig       ,0)
+nvl(a.v_CallSuccessNum             ,0)
+nvl(a.v_ExtInterruptNum            ,0)
+nvl(a.v_BlockFailureNum            ,0)
+nvl(a.v_OtherFailureNum            ,0)
+nvl(a.v_CMO_CallSuccessNum         ,0)
+nvl(a.v_CMO_ExtInterruptNum        ,0)
+nvl(a.v_CMO_BlockFailureNum        ,0)
+nvl(a.v_CMO_OtherFailureNum        ,0)
+nvl(a.v_AccProbe_CallSuccessNum    ,0)
+nvl(a.v_AccProbe_ExtInterruptNum   ,0)
+nvl(a.v_AccProbe_BlockFailureNum   ,0)
+nvl(a.v_AccProbe_OtherFailureNum   ,0)
+nvl(a.v_AccHo_CallSuccessNum       ,0)
+nvl(a.v_AccHo_ExtInterruptNum      ,0)
+nvl(a.v_AccHo_BlockFailureNum      ,0)
+nvl(a.v_AccHo_OtherFailureNum      ,0)
+nvl(a.v_AssignSoft_CallSuccessNum  ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum ,0)
+nvl(a.v_AssignSoft_BlockFailureNum ,0)
+nvl(a.v_AssignSoft_OtherFailureNum ,0)
+nvl(a.sm_CMO_CallSuccessNum        ,0)
+nvl(a.sm_CMO_ExtInterruptNum       ,0)
+nvl(a.sm_CMO_BlockFailureNum       ,0)
+nvl(a.sm_CMO_OtherFailureNum       ,0)
+nvl(a.sm_AccProbe_CallSuccessNum   ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum  ,0)
+nvl(a.sm_AccProbe_BlockFailureNum  ,0)
+nvl(a.sm_AccProbe_OtherFailureNum  ,0)
+nvl(a.sm_AccHo_CallSuccessNum      ,0)
+nvl(a.sm_AccHo_ExtInterruptNum     ,0)
+nvl(a.sm_AccHo_BlockFailureNum     ,0)
+nvl(a.sm_AccHo_OtherFailureNum     ,0)
+nvl(a.sm_AssignSoft_CallSuccessNum ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNum,0)
+nvl(a.sm_AssignSoft_BlockFailureNum,0)
+nvl(a.sm_AssignSoft_OtherFailureNum,0)) TchReqNumExcludeHoSms,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_CMO_BlockFailureNum_call,0)
+nvl(a.v_CMO_OtherFailureNum_call,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)
+nvl(a.v_AssignSoft_BlockFailureNum_c,0)
+nvl(a.v_AssignSoft_OtherFailureNum_c,0)
+nvl(a.v_AccProbe_CallSuccessNum_call,0)
+nvl(a.V_AccProbe_ExtInvalidCallNum_c,0)
+nvl(a.v_AccProbe_BlockFailureNum_cal,0)
+nvl(a.v_AccProbe_OtherFailureNum_cal,0)
+nvl(a.v_AccHo_CallSuccessNum_call,0)
+nvl(a.V_AccHo_ExtInvalidCallNum_call,0)
+nvl(a.v_AccHo_BlockFailureNum_call,0)
+nvl(a.v_AccHo_OtherFailureNum_call,0)
+nvl(a.sm_CMO_CallSuccNum,0)
+nvl(a.sm_CMO_ExtInterruptNum_call,0)
+nvl(a.sm_CMO_BlockFailNum,0)
+nvl(a.sm_CMO_OtherFailNum,0)
+nvl(a.sm_AccProbe_CallSuccNum,0)
+nvl(a.sm_AccProbe_ExtInterruptNum_ca,0)
+nvl(a.Sm_AccProbe_BlockFailureNum_ca,0)
+nvl(a.Sm_AccProbe_OtherFailureNum_ca,0)
+nvl(a.sm_AccHo_CallSuccNum_call,0)
+nvl(a.sm_AccHo_ExtInterruptNum_call,0)
+nvl(a.Sm_AccHo_BlockFailureNum_call,0)
+nvl(a.Sm_AccHo_OtherFailureNum_call,0)
+nvl(a.sm_AssignSoft_CallSuccNum,0)
+nvl(a.sm_AssignSoft_ExtInterruptNumc,0)
+nvl(a.sm_AssignSoft_BlockFailNum,0)
+nvl(a.sm_AssignSoft_OtherFailNum,0)
+nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_BlockFailureNum_orig,0)
+nvl(a.v_OtherFailureNum_orig,0)
+nvl(a.v_CallSuccessNum,0)
+nvl(a.v_ExtInterruptNum,0)
+nvl(a.v_BlockFailureNum,0)
+nvl(a.v_OtherFailureNum,0)
+nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum,0)
+nvl(a.v_CMO_BlockFailureNum,0)
+nvl(a.v_CMO_OtherFailureNum,0)
+nvl(a.v_AssignSoft_CallSuccessNum,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)
+nvl(a.v_AssignSoft_BlockFailureNum,0)
+nvl(a.v_AssignSoft_OtherFailureNum,0)
+nvl(a.V_AccProbe_CallSuccessNum,0)
+nvl(a.V_AccProbe_ExtInvalidCallNum,0)
+nvl(a.V_AccProbe_BlockFailureNum,0)
+nvl(a.V_AccProbe_OtherFailureNum,0)
+nvl(a.V_AccHo_CallSuccessNum,0)
+nvl(a.V_AccHo_ExtInterruptNum,0)
+nvl(a.V_AccHo_BlockFailureNum,0)
+nvl(a.V_AccHo_OtherFailureNum,0)
+nvl(a.sm_CMO_CallSuccessNum,0)
+nvl(a.sm_CMO_ExtInterruptNum,0)
+nvl(a.sm_CMO_BlockFailureNum,0)
+nvl(a.sm_CMO_OtherFailureNum,0)
+nvl(a.sm_AccProbe_CallSuccessNum,0)
+nvl(a.sm_AccProbe_ExtInterruptNum,0)
+nvl(a.sm_AccProbe_BlockFailureNum,0)
+nvl(a.sm_AccProbe_OtherFailureNum,0)
+nvl(a.sm_AccHo_CallSuccessNum,0)
+nvl(a.sm_AccHo_ExtInterruptNum,0)
+nvl(a.sm_AccHo_BlockFailureNum,0)
+nvl(a.sm_AccHo_OtherFailureNum,0)
+nvl(a.sm_AssignSoft_CallSuccessNum,0)
+nvl(a.sm_AssignSoft_ExtInterruptNum,0)
+nvl(a.sm_AssignSoft_BlockFailureNum,0)
+nvl(a.sm_AssignSoft_OtherFailureNum,0))  CallPageReqTotalNum,
-------------------------------------
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_CMO_BlockFailureNum_call,0)
+nvl(a.v_CMO_OtherFailureNum_call,0)
+nvl(a.v_AccProbe_CallSuccessNum_call,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal,0)
+nvl(a.v_AccProbe_BlockFailureNum_cal,0)
+nvl(a.v_AccProbe_OtherFailureNum_cal,0)
+nvl(a.v_AccHo_CallSuccessNum_call,0)
+nvl(a.v_AccHo_ExtInterruptNum_call,0)
+nvl(a.v_AccHo_BlockFailureNum_call,0)
+nvl(a.v_AccHo_OtherFailureNum_call,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)
+nvl(a.v_AssignSoft_BlockFailureNum_c,0)
+nvl(a.v_AssignSoft_OtherFailureNum_c,0)
+nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_BlockFailureNum_orig,0)
+nvl(a.v_OtherFailureNum_orig,0)) TchReqNumCallerExcludeHoSms,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_AccProbe_CallSuccessNum_call,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal,0)
+nvl(a.v_AccHo_CallSuccessNum_call,0)
+nvl(a.v_AccHo_ExtInterruptNum_call,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)
+nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum,0)) TchSuccNumCallerExcludeHoSms,
sum(nvl(a.v_MSOriginateNum,0)
+nvl(a.v_PageResponceNum,0)) cs_TchReqNumExcludeHo_a,
sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.ConVoc_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0)) TchRadioFRate_up,
sum(nvl(a.v_CallSuccessNum,0)
+nvl(a.v_ExtInterruptNum,0)
+nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)) TchRadioFRate_down_a,
sum(nvl(a.p_MSOriginateNum,0)) ps_TchReqNumExcludeHo_a,
sum(nvl(a.v_CallSuccessNum,0)
+nvl(a.v_ExtInterruptNum,0)
+nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)) cs_TchSuccNumExcludeHo_a,
sum(nvl(a.p_CallSuccessNum_carrier,0)
+nvl(a.p_ExtInterruptNum_carrier,0)) ps_TchSuccNumExcludeHo_a,
sum(nvl(a.v_CallSuccessNum       ,0)
+nvl(a.v_ExtInterruptNum         ,0)
+nvl(a.v_CallSuccessNum_orig     ,0)
+nvl(a.v_ExtInterruptNum_orig    ,0)) TchSuccNumExcludeHoSms_a,
sum(nvl(a.v_CMO_MSOriginateNum,0)
+nvl(a.v_AssignSoft_MSOriginateNum,0)) cs_TchReqNumExcludeHo_e,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call       ,0)
+nvl(a.v_AccProbe_CallSuccessNum_call   ,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal  ,0)
+nvl(a.v_AccHo_CallSuccessNum_call      ,0)
+nvl(a.v_AccHo_ExtInterruptNum_call     ,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)) TchRadioFRate_down_e,
sum(nvl(a.p_CMO_MSOriginateNum,0)
+nvl(a.p_AssignSoft_MSOriginateNum ,0)) ps_TchReqNumExcludeHo_e,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_AssignSoft_BlockFailureNum_c,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)) cs_TchSuccNumExcludeHo_e,
sum(nvl(a.p_CMO_CallSuccessNum_call,0)
+nvl(a.p_CMO_ExtInterruptNum_call,0)
+nvl(a.p_AssignSoft_CallSuccessNum_ca ,0)
+nvl(a.p_AssignSoft_ExtInterruptNumc,0)) ps_TchSuccNumExcludeHo_e,
sum(nvl(a.sm_CMO_CallSuccNum         ,0)
+nvl(a.sm_CMO_ExtInterruptNum_call        ,0)
+nvl(a.sm_AccProbe_CallSuccNum       ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum_ca,0)
+nvl(a.sm_AccHo_CallSuccNum_call,0)
+nvl(a.sm_AccHo_ExtInterruptNum_call  ,0)
+nvl(a.sm_AssignSoft_CallSuccNum     ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNumc ,0)
+nvl(a.v_CMO_CallSuccessNum_ms_call       ,0)
+nvl(a.v_CMO_ExtInterruptNum_call         ,0)
+nvl(a.v_AccProbe_CallSuccessNum_call     ,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal    ,0)
+nvl(a.v_AccHo_CallSuccessNum_call        ,0)
+nvl(a.v_AccHo_ExtInterruptNum_call       ,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca   ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c  ,0)) TchSuccNumExcludeHoSms_e,
sum(nvl(a.v_CMO_PageResponceNum,0)
+nvl(a.v_AssignSoft_PageResponceNum,0)) cs_TchReqNumExcludeHo_f,
sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum,0)
+nvl(a.v_AccProbe_CallSuccessNum,0)
+nvl(a.v_AccProbe_ExtInterruptNum,0)
+nvl(a.v_AccHo_CallSuccessNum,0)
+nvl(a.v_AccHo_ExtInterruptNum,0)
+nvl(a.v_AssignSoft_CallSuccessNum,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)) TchRadioFRate_down_f,
sum(nvl(a.p_CMO_PageResponceNum,0)
+nvl(a.p_AssignSoft_PageResponceNum,0)
+nvl(a.p_PageResponceNum,0)) ps_TchReqNumExcludeHo_f,
sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum,0)
+nvl(a.v_AssignSoft_CallSuccessNum ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)) cs_TchSuccNumExcludeHo_f,
sum(nvl(a.p_CMO_CallSuccessNum,0)
+nvl(a.p_CMO_ExtInterruptNum,0)
+nvl(a.p_AssignSoft_CallSuccessNum ,0)
+nvl(a.p_AssignSoft_ExtInterruptNum,0)
+nvl(a.p_CallSuccessNum_pag,0)
+nvl(a.p_ExtInterruptNum_pag,0)) ps_TchSuccNumExcludeHo_f,
sum(nvl(a.v_CMO_CallSuccessNum        ,0)
+nvl(a.v_CMO_ExtInterruptNum          ,0)
+nvl(a.v_AccProbe_CallSuccessNum      ,0)
+nvl(a.v_AccProbe_ExtInterruptNum     ,0)
+nvl(a.v_AccHo_CallSuccessNum         ,0)
+nvl(a.v_AccHo_ExtInterruptNum        ,0)
+nvl(a.v_AssignSoft_CallSuccessNum    ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum   ,0)
+nvl(a.sm_CMO_CallSuccessNum          ,0)
+nvl(a.sm_CMO_ExtInterruptNum         ,0)
+nvl(a.sm_AccProbe_CallSuccessNum     ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum    ,0)
+nvl(a.sm_AccHo_CallSuccessNum        ,0)
+nvl(a.sm_AccHo_ExtInterruptNum       ,0)
+nvl(a.sm_AssignSoft_CallSuccessNum   ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNum  ,0)) TchSuccNumExcludeHoSms_f,
sum(nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_CallSuccessNum,0)
+nvl(a.v_ExtInterruptNum,0)) cs_TchSuccNumIncludeHo_a,
sum(nvl(a.v_MSOriginateNum,0)) ps_TchReqNumIncludeHo_a,
sum(nvl(a.v_MSOriginateNum,0)+nvl(a.v_PageResponceNum,0)) cs_TchReqNumIncludeHo_a,
sum(nvl(a.p_CallSuccessNum_carrier,0)
+nvl(a.p_ExtInterruptNum_carrier,0)) ps_TchSuccNumIncludeHo_a,
sum(nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_BlockFailureNum_orig,0)
+nvl(a.v_OtherFailureNum_orig,0)
+nvl(a.v_CallSuccessNum      ,0)
+nvl(a.v_ExtInterruptNum     ,0)
+nvl(a.v_BlockFailureNum     ,0)
+nvl(a.v_OtherFailureNum     ,0)) TchReqNumIncludeHoSms_a,
sum(nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_CallSuccessNum     ,0)
+nvl(a.v_ExtInterruptNum    ,0)) TchSuccNumIncludeHoSms_a,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum        ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum    ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)) cs_TchSuccNumIncludeHo_b,
sum(nvl(a.p_TgtBscFREQ_HoSNum,0)
+nvl(a.p_TgtBscFREQ_HoFNum     ,0)
+nvl(a.p_TgtBscFO_HoSNum       ,0)
+nvl(a.p_TgtBscFO_HoFNum       ,0)
+nvl(a.p_TgtBscRC_HoSNum       ,0)
+nvl(a.p_TgtBscRC_HoFNum       ,0)
+nvl(a.p_SrcBscFREQ_HoSNum     ,0)
+nvl(a.p_SrcBscFREQ_HoFNum     ,0)
+nvl(a.p_SrcBscFO_HoSNum       ,0)
+nvl(a.p_SrcBscFO_HoFNum       ,0)
+nvl(a.p_SrcBscRC_HoSNum       ,0)
+nvl(a.p_SrcBscRC_HoFNum       ,0)
+nvl(a.VOC_HoAddSuccessNum     ,0)
+nvl(a.VOC_HoExtInterruptNum   ,0)
+nvl(a.VOC_HoBlockFailureNum   ,0)
+nvl(a.VOC_HoOtherFailureNum   ,0)
+nvl(a.CON_HoAddSuccessNum     ,0)
+nvl(a.CON_HoExtInterruptNum   ,0)
+nvl(a.CON_HoBlockFailureNum   ,0)
+nvl(a.CON_HoOtherFailureNum   ,0)
+nvl(a.p_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.p_TgtBscSoftAdd_HoFNum  ,0)
+nvl(a.InterBscHo_HoSNum_dest,0)
+nvl(a.InterBscHo_HoFNum       ,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum  ,0)
+nvl(a.p_SrcBscSoftAdd_HoFNum  ,0)
+nvl(a.p_InterBscHo_HoSNum     ,0)
+nvl(a.p_InterBscHo_HoFNum     ,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_TgtBscSofterAdd_HoFNum,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum,0)
+nvl(a.p_SrcBscSofterAdd_HoFNum,0)) ps_TchReqNumIncludeHo_b,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum         ,0)
+nvl(a.v_TgtBscFO_HoSNum           ,0)
+nvl(a.v_TgtBscFO_HoFNum           ,0)
+nvl(a.v_TgtBscRC_HoSNum           ,0)
+nvl(a.v_TgtBscRC_HoFNum           ,0)
+nvl(a.v_SrcBscFREQ_HoSNum         ,0)
+nvl(a.v_SrcBscFREQ_HoFNum         ,0)
+nvl(a.v_SrcBscFO_HoSNum           ,0)
+nvl(a.v_SrcBscFO_HoFNum           ,0)
+nvl(a.v_SrcBscRC_HoSNum           ,0)
+nvl(a.v_SrcBscRC_HoFNum           ,0)
+nvl(a.VOC_HoAddSuccessNum         ,0)
+nvl(a.VOC_HoExtInterruptNum       ,0)
+nvl(a.VOC_HoBlockFailureNum       ,0)
+nvl(a.VOC_HoOtherFailureNum       ,0)
+nvl(a.CON_HoAddSuccessNum         ,0)
+nvl(a.CON_HoExtInterruptNum       ,0)
+nvl(a.CON_HoBlockFailureNum       ,0)
+nvl(a.CON_HoOtherFailureNum       ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum      ,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum      ,0)
+nvl(a.v_InterBscHo_HoSNum         ,0)
+nvl(a.v_InterBscHo_HoFNum_dest    ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum      ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum      ,0)
+nvl(a.v_InterBscHo_HoSNum_source  ,0)
+nvl(a.v_InterBscHo_HoFNum_source  ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum    ,0)) cs_TchReqNumIncludeHo_b,
sum(nvl(a.p_TgtBscFREQ_HoSNum,0)
+nvl(a.p_TgtBscFO_HoSNum       ,0)
+nvl(a.p_TgtBscRC_HoSNum       ,0)
+nvl(a.p_SrcBscFREQ_HoSNum     ,0)
+nvl(a.p_SrcBscFO_HoSNum       ,0)
+nvl(a.p_SrcBscRC_HoSNum       ,0)
+nvl(a.VOC_HoAddSuccessNum     ,0)
+nvl(a.VOC_HoExtInterruptNum   ,0)
+nvl(a.CON_HoAddSuccessNum     ,0)
+nvl(a.CON_HoExtInterruptNum   ,0)
+nvl(a.p_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.InterBscHo_HoSNum_dest,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum  ,0)
+nvl(a.p_InterBscHo_HoSNum     ,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum,0))  ps_TchSuccNumIncludeHo_b,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_InterBscHo_HoFNum_source      ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum   ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.v_TgtBscFREQ_HoSNum       ,0)
+nvl(a.v_TgtBscFREQ_HoFNum       ,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscFO_HoFNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoFNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFREQ_HoFNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscFO_HoFNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoFNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.VOC_HoBlockFailureNum     ,0)
+nvl(a.VOC_HoOtherFailureNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.CON_HoBlockFailureNum     ,0)
+nvl(a.CON_HoOtherFailureNum     ,0)) TchReqNumIncludeHoSms_b,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_TgtBscFREQ_HoSNum       ,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)) TchSuccNumIncludeHoSms_b,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call       ,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)) cs_TchSuccNumIncludeHo_e,
sum(nvl(a.p_CMO_MSOriginateNum,0)
+nvl(a.p_AssignSoft_MSOriginateNum,0))  ps_TchReqNumIncludeHo_e,
sum(nvl(a.v_CMO_MSOriginateNum,0)
+nvl(a.v_AssignSoft_MSOriginateNum ,0)) cs_TchReqNumIncludeHo_e,
sum(nvl(a.p_CMO_CallSuccessNum_call,0)
+nvl(a.p_CMO_ExtInterruptNum_call       ,0)
+nvl(a.p_AssignSoft_CallSuccessNum_ca ,0)
+nvl(a.p_AssignSoft_ExtInterruptNumc,0)) ps_TchSuccNumIncludeHo_e,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_CMO_BlockFailureNum_call,0)
+nvl(a.v_CMO_OtherFailureNum_call,0)
+nvl(a.v_AccProbe_CallSuccessNum_call,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal,0)
+nvl(a.v_AccProbe_BlockFailureNum_cal,0)
+nvl(a.v_AccProbe_OtherFailureNum_cal,0)
+nvl(a.v_AccHo_CallSuccessNum_call,0)
+nvl(a.v_AccHo_ExtInterruptNum_call,0)
+nvl(a.v_AccHo_BlockFailureNum_call,0)
+nvl(a.v_AccHo_OtherFailureNum_call,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)
+nvl(a.v_AssignSoft_BlockFailureNum_c,0)
+nvl(a.v_AssignSoft_OtherFailureNum_c,0)
+nvl(a.sm_CMO_CallSuccNum,0)
+nvl(a.sm_CMO_ExtInterruptNum_call,0)
+nvl(a.sm_CMO_BlockFailNum,0)
+nvl(a.sm_CMO_OtherFailNum,0)
+nvl(a.sm_AccProbe_CallSuccNum,0)
+nvl(a.sm_AccProbe_ExtInterruptNum_ca,0)
+nvl(a.Sm_AccProbe_BlockFailureNum_ca,0)
+nvl(a.Sm_AccProbe_OtherFailureNum_ca,0)
+nvl(a.sm_AccHo_CallSuccNum_call,0)
+nvl(a.sm_AccHo_ExtInterruptNum_call,0)
+nvl(a.Sm_AccHo_BlockFailureNum_call,0)
+nvl(a.Sm_AccHo_OtherFailureNum_call,0)
+nvl(a.sm_AssignSoft_CallSuccNum,0)
+nvl(a.sm_AssignSoft_ExtInterruptNumc,0)
+nvl(a.sm_AssignSoft_BlockFailNum,0)
+nvl(a.sm_AssignSoft_OtherFailNum,0)) TchReqNumIncludeHoSms_e,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call   ,0)
+nvl(a.v_CMO_ExtInterruptNum_call        ,0)
+nvl(a.v_AccProbe_CallSuccessNum_call    ,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal   ,0)
+nvl(a.v_AccHo_CallSuccessNum_call       ,0)
+nvl(a.v_AccHo_ExtInterruptNum_call      ,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca  ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c ,0)
+nvl(a.sm_CMO_CallSuccNum           ,0)
+nvl(a.sm_CMO_ExtInterruptNum_call       ,0)
+nvl(a.sm_AccProbe_CallSuccNum      ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum_ca  ,0)
+nvl(a.sm_AccHo_CallSuccNum_call         ,0)
+nvl(a.sm_AccHo_ExtInterruptNum_call     ,0)
+nvl(a.sm_AssignSoft_CallSuccNum    ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNumc,0)) TchSuccNumIncludeHoSms_e,
sum(nvl(a.v_CMO_CallSuccessNum     ,0)
+nvl(a.v_CMO_ExtInterruptNum       ,0)
+nvl(a.v_AssignSoft_CallSuccessNum ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)) cs_TchSuccNumIncludeHo_f,
sum(nvl(a.p_CMO_PageResponceNum,0)
+nvl(a.p_AssignSoft_PageResponceNum,0)
+nvl(a.p_PageResponceNum,0))            ps_TchReqNumIncludeHo_f,
sum(nvl(a.v_CMO_PageResponceNum,0)
+nvl(a.v_AssignSoft_PageResponceNum,0)) cs_TchReqNumIncludeHo_f,
sum(nvl(a.p_CMO_CallSuccessNum,0)
+nvl(a.p_CMO_ExtInterruptNum       ,0)
+nvl(a.p_AssignSoft_CallSuccessNum ,0)
+nvl(a.p_AssignSoft_ExtInterruptNum,0)
+nvl(a.p_CallSuccessNum_carrier            ,0)
+nvl(a.p_ExtInterruptNum_carrier           ,0)) ps_TchSuccNumIncludeHo_f,
sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum        ,0)
+nvl(a.v_CMO_BlockFailureNum        ,0)
+nvl(a.v_CMO_OtherFailureNum        ,0)
+nvl(a.v_AccProbe_CallSuccessNum    ,0)
+nvl(a.v_AccProbe_ExtInterruptNum   ,0)
+nvl(a.v_AccProbe_BlockFailureNum   ,0)
+nvl(a.v_AccProbe_OtherFailureNum   ,0)
+nvl(a.v_AccHo_CallSuccessNum       ,0)
+nvl(a.v_AccHo_ExtInterruptNum      ,0)
+nvl(a.v_AccHo_BlockFailureNum      ,0)
+nvl(a.v_AccHo_OtherFailureNum      ,0)
+nvl(a.v_AssignSoft_CallSuccessNum  ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum ,0)
+nvl(a.v_AssignSoft_BlockFailureNum ,0)
+nvl(a.v_AssignSoft_OtherFailureNum ,0)
+nvl(a.sm_CMO_CallSuccessNum        ,0)
+nvl(a.sm_CMO_ExtInterruptNum       ,0)
+nvl(a.sm_CMO_BlockFailureNum       ,0)
+nvl(a.sm_CMO_OtherFailureNum       ,0)
+nvl(a.sm_AccProbe_CallSuccessNum   ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum  ,0)
+nvl(a.sm_AccProbe_BlockFailureNum  ,0)
+nvl(a.sm_AccProbe_OtherFailureNum  ,0)
+nvl(a.sm_AccHo_CallSuccessNum      ,0)
+nvl(a.sm_AccHo_ExtInterruptNum     ,0)
+nvl(a.sm_AccHo_BlockFailureNum     ,0)
+nvl(a.sm_AccHo_OtherFailureNum     ,0)
+nvl(a.sm_AssignSoft_CallSuccessNum ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNum,0)
+nvl(a.sm_AssignSoft_BlockFailureNum,0)
+nvl(a.sm_AssignSoft_OtherFailureNum,0)) TchReqNumIncludeHoSms_f,
sum(nvl(a.v_CMO_CallSuccessNum      ,0)
+nvl(a.v_CMO_ExtInterruptNum        ,0)
+nvl(a.v_AccProbe_CallSuccessNum    ,0)
+nvl(a.v_AccProbe_ExtInterruptNum   ,0)
+nvl(a.v_AccHo_CallSuccessNum      ,0)
+nvl(a.v_AccHo_ExtInterruptNum      ,0)
+nvl(a.v_AssignSoft_CallSuccessNum  ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum ,0)
+nvl(a.sm_CMO_CallSuccessNum        ,0)
+nvl(a.sm_CMO_ExtInterruptNum       ,0)
+nvl(a.sm_AccProbe_CallSuccessNum   ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum  ,0)
+nvl(a.sm_AccHo_CallSuccessNum      ,0)
+nvl(a.sm_AccHo_ExtInterruptNum     ,0)
+nvl(a.sm_AssignSoft_CallSuccessNum ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNum,0)) TchSuccNumIncludeHoSms_f

from C_TPD_1X_SUM_ZX_TEMP a,c_carrier c
where a.int_id = c.int_id and c.vendor_id=7
and a.scan_start_time = v_date
group by c.related_msc
),
b as(
select
c.related_msc related_msc,
sum(nvl(a.Reliable95CENum,0)+nvl(a.ReliableFCENum,0)+nvl(a.ReliableRCENum,0)) CEAvailNum,
--sum(case when c.do_bts =0 then nbrAvailCe else 0 end)   ChannelAvailNum,
sum(a.ReliableFCENum+a.ReliableRCENum) ChannelAvailNum,
sum(case when (ReliableFCENum > ReliableRCENum) then  ReliableRCENum else ReliableFCENum end) TCHNum,
sum(a.Total95CENum+a.TotalPhyFCENum+a.TotalPhyRCENum)    ChannelNum       ,
--sum(a.ReliableFCENum+a.ReliableRCENum+a.Reliable95CENum)                                                         ChannelMaxUseNum ,
sum(a.MaxBusyFCENum+a.MaxBusyRCENum) ChannelMaxUseNum,
round(sum(a.MaxBusyFCENum+a.MaxBusyRCENum)/
decode(sum(a.ReliableFCENum+a.ReliableRCENum),0,1,null,1,sum(a.ReliableFCENum+a.ReliableRCENum))*100,4)   ChannelMaxUseRate,
sum(a.TotalPhyFCENum)                                                                                            FwdChNum         ,
sum(a.ReliableFCENum)                                                                                            FwdChAvailNum    ,
sum(a.MaxBusyFCENum )                                                                                            FwdChMaxUseNum   ,
round(sum(a.MaxBusyFCENum)/
decode(sum(a.TotalPhyFCENum),0,1,null,1,sum(a.TotalPhyFCENum))*100,4) FwdChMaxUseRate,
sum(a.TotalPhyRCENum)                                                                                            RevChNum         ,
sum(a.ReliableRCENum)                                                                                            RevChAvailNum    ,
sum(a.MaxBusyRCENum )                                                                                            RevChMaxUseNum   ,
round(sum(nvl(a.MaxBusyRCENum,0))/
decode(sum(nvl(a.ReliableRCENum,0)),0,1,null,1,sum(nvl(a.ReliableRCENum,0)))*100,4) RevChMaxUseRate,
sum(a.TotalPhyFCENum+a.TotalLicRCENum)                                                                           CENum            ,
round(sum(a.Reliable95CENum+a.ReliableFCENum+a.ReliableRCENum)/
100*decode(sum(a.TotalPhyFCENum+a.TotalLicRCENum),0,1,null,1,sum(a.TotalPhyFCENum+a.TotalLicRCENum)),4)  CEAvailRate
from C_TPD_1X_SUM_ZX_TEMP a,c_bts c
where a.int_id = c.int_id
and a.scan_start_time = v_date and c.vendor_id=7
group by c.related_msc
),
c as(
select
c.related_msc related_msc,
sum(nvl(a.dwTxRexmitFrame,0)) FwdRxTotalFrame,
sum(nvl(a.dwTxTotalFrame,0)) FdwTxTotalFrameExcludeRx,
sum(nvl(a.dwRxRexmitFrame,0)) RevRxTotalFrame,
sum(nvl(a.dwRxTotalFrame,0)) RevTxTotalFrameExcludeRx,
round(sum(nvl(a.dwRxRexmitFrame,0))/decode(sum(a.dwRxTotalFrame),0,1,null,1,sum(a.dwRxTotalFrame))*100,4) RevChRxRate
from C_TPD_1X_SUM_ZX_TEMP a,c_bsc c
where a.int_id = c.int_id
and a.scan_start_time = v_date and c.vendor_id=7
group by c.related_msc
)
select
a.related_msc,
v_date,
0,
101,
7,
a.TrafficExcludeHo,
a.cs_TrafficExcludeHo,
a.ps_CallTrafficExcludeHo,
a.LoseCallingNum,
--a.LoseCallingratio,
a.cs_LoseCallingNum,
a.ps_LoseCallingNum,
--a.ps_LoseCallingratio,
a.AvgRadioFPeriod,
a.TCHLoadTrafficExcludeHo,
a.TCHRadioFNum,
a.cs_TchReqNumHardho,
a.cs_TchSuccNumHardho,
a.cs_CallBlockFailRateHardho,
a.cs_TchReqNumsoftho,
a.cs_TchSuccNumsoftho,
a.cs_CallBlockFailRatesoftho,
a.ps_TchReqNumHardho,
a.ps_TchSuccNumHardho,
a.ps_TchReqNumsoftho,
a.ps_TchSuccNumsoftho,
a.cs_HandoffReqNum,
a.cs_HandoffSuccNum,
a.cs_HandoffSuccRate,
a.cs_HardhoReqNum,
a.cs_HardhoSuccNum,
a.cs_HardhoSuccRate,
a.cs_SofthoReqNum,
a.cs_SofthoSuccNum,
--a.cs_SofthoSuccRate,
a.cs_SSofthoReqNum,
a.cs_SSofthoSuccNum,
a.cs_SSofthoSuccRate,
--a.ps_HandoffSuccRate,
a.ps_HardhoReqNum,
a.ps_HardhoSuccNum,
--a.ps_HardhoSuccRate,
a.ps_SofthoReqNum,
a.ps_SofthoSuccNum,
--a.ps_SofthoSuccRate,
a.ps_SSofthoReqNum,
a.ps_SSofthoSuccNum,
--a.ps_SSofthoSuccRate,
a.HandoffReqNum_intra,
a.HandoffSuccNum_intra,
a.HandoffReqNum_Extra,
a.HandoffSuccNum_Extra,
a.HardhoReqNum_intra,
a.HardhoSuccNum_intra,
--a.HardhoSuccRate_intra,
a.ShoReqNum_intra,
a.ShoSuccNum_intra,
--a.ShoSuccRate_intra,
a.SShoReqNum_intra,
a.SShoSuccNum_intra,
--a.SShoSuccRate_intra,
a.HardhoReqNum_Extra,
a.HardhoSuccNum_Extra,
a.ShoReqNum_Extra,
a.ShoSuccNum_Extra,
--a.ShoSuccRate_Extra,
--a.BtsSysHardHoSuccRate,
--a.SysSHoSuccRate,
a.BtsSysHardHoReqNum,
a.BtsSysHardHoSuccNum,
a.SysSHoReqNum,
a.SysSHoSuccNum,
a.CallBlockFailNum,
a.cs_CallBlockFailNum,
a.ps_CallBlockFailNum,
a.TrafficIncludeHo,
a.cs_TrafficIncludeHo,
a.cs_trafficByWalsh,
a.cs_SHOTraffic,
a.cs_SSHOTraffic,
a.ps_CallTrafficIncludeHo,
a.ps_trafficByWalsh,
a.ps_SHOTraffic,
a.ps_SSHOTraffic,
a.TCHLoadTrafficIncludeHo,
a.LoadTrafficByWalsh,
c.FwdRxTotalFrame,
c.FdwTxTotalFrameExcludeRx,
c.RevRxTotalFrame,
c.RevTxTotalFrameExcludeRx,
c.RevChRxRate,
a.TchReqNumCalleeExcludeHoSms,
a.TchSuccNumCalleeExcludeHoSms,
--a.TchReqNumCallerExcludeHoSms,
--a.TchSuccNumCallerExcludeHoSms,
b.CEAvailNum,
(cs_CallPageReqNum_a+a.cs_CallPageReqNum_e+a.cs_CallPageReqNum_f) cs_CallPageReqNum,
(cs_CallPageSuccNum_a+a.cs_CallPageSuccNum_e+a.cs_CallPageSuccNum_f) cs_CallPageSuccNum,
(TchSuccNumExcludeHo_a+TchSuccNumExcludeHo_e+TchSuccNumExcludeHo_f) TchSuccNumExcludeHo,
(ps_CallPageSuccNum_a+ps_CallPageSuccNum_e+ps_CallPageSuccNum_f) ps_CallPageSuccNum,
(ps_CallPageReqNum_a+ps_CallPageReqNum_e+ps_CallPageReqNum_f) ps_CallPageReqNum,
b.ChannelNum       ,
b.ChannelMaxUseNum ,
b.ChannelMaxUseRate,
b.FwdChNum         ,
b.FwdChAvailNum    ,
b.FwdChMaxUseNum   ,
b.FwdChMaxUseRate  ,
b.RevChNum         ,
b.RevChAvailNum    ,
b.RevChMaxUseNum   ,
b.RevChMaxUseRate  ,
b.CENum            ,
b.CEAvailRate      ,
a.TchReqNumExcludeHoSms,
a.CallPageReqTotalNum,
a.TchReqNumCallerExcludeHoSms,
a.TchSuccNumCallerExcludeHoSms,
b.ChannelAvailNum,
b.TCHNum,
(cs_TchReqNumExcludeHo_a+cs_TchReqNumExcludeHo_e+cs_TchReqNumExcludeHo_f) cs_TchReqNumExcludeHo,
round(100*(a.TchRadioFRate_up)/decode((a.TchRadioFRate_down_a+a.TchRadioFRate_down_e+a.TchRadioFRate_down_f),0,1,(a.TchRadioFRate_down_a+a.TchRadioFRate_down_e+a.TchRadioFRate_down_f)),4) TchRadioFRate,
(ps_TchReqNumExcludeHo_a+ps_TchReqNumExcludeHo_e+ps_TchReqNumExcludeHo_f) ps_TchReqNumExcludeHo,
(cs_TchSuccNumExcludeHo_a+cs_TchSuccNumExcludeHo_e+cs_TchSuccNumExcludeHo_f) cs_TchSuccNumExcludeHo,
(ps_TchSuccNumExcludeHo_a+ps_TchSuccNumExcludeHo_e+ps_TchSuccNumExcludeHo_f) ps_TchSuccNumExcludeHo,
(TchSuccNumExcludeHoSms_a+TchSuccNumExcludeHoSms_e+TchSuccNumExcludeHoSms_f) TchSuccNumExcludeHoSms,
(cs_TchSuccNumIncludeHo_a+cs_TchSuccNumIncludeHo_b+cs_TchSuccNumIncludeHo_e+cs_TchSuccNumIncludeHo_f) cs_TchSuccNumIncludeHo,
(ps_TchReqNumIncludeHo_a+ps_TchReqNumIncludeHo_b+ps_TchReqNumIncludeHo_e+ps_TchReqNumIncludeHo_f) ps_TchReqNumIncludeHo,
(cs_TchReqNumIncludeHo_a+cs_TchReqNumIncludeHo_b+cs_TchReqNumIncludeHo_e+cs_TchReqNumIncludeHo_f) cs_TchReqNumIncludeHo,
(ps_TchSuccNumIncludeHo_a+ps_TchSuccNumIncludeHo_b+ps_TchSuccNumIncludeHo_e+ps_TchSuccNumIncludeHo_f) ps_TchSuccNumIncludeHo,
(TchReqNumIncludeHoSms_a+TchReqNumIncludeHoSms_b+TchReqNumIncludeHoSms_e+TchReqNumIncludeHoSms_f) TchReqNumIncludeHoSms,
(TchSuccNumIncludeHoSms_a+TchSuccNumIncludeHoSms_b+TchSuccNumIncludeHoSms_e+TchSuccNumIncludeHoSms_f) TchSuccNumIncludeHoSms
from  a,b,c
where a.related_msc=b.related_msc and b.related_msc=c.related_msc;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-----------------------------------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
Carrier1BtsNum,
Carrier2BtsNum,
Carrier3BtsNum,
Carrier4BtsNum
)
with a as(
select
c.related_msc related_msc,
sum(case when c.cdma_freq = 283 then  1 else 0 end) Carrier1BtsNum,
sum(case when c.cdma_freq = 201 then  1 else 0 end) Carrier2BtsNum,
sum(case when c.cdma_freq = 242 then  1 else 0 end) Carrier3BtsNum,
sum(case when c.cdma_freq = 160 then  1 else 0 end) Carrier4BtsNum
from c_carrier c ,c_bts b
where c.related_bts = b.int_id  and b.do_bts = 0 and b.vendor_id=7
group by c.related_msc)
select
a.related_msc,
v_date,
0,
101,
7,
a.Carrier1BtsNum,
a.Carrier2BtsNum,
a.Carrier3BtsNum,
a.Carrier4BtsNum
from a;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
----------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CARRIERNUM_1X
)
select
c.related_msc related_msc,
v_date,
0,
101,
7,
count(a.int_id)  CARRIERNUM_1X
from C_tpd_cnt_carr_zx a,c_carrier c
where a.int_id = c.int_id and scan_start_time = v_date
group by c.related_msc;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
----------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
OnecarrierCellNum
)
with a as
(
select related_cell int_id from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_cell having count(distinct cdma_freq)=1
)
select b.related_msc,
v_date,
0,
101,
7,
count(distinct b.int_id) OnecarrierCellNum
from a,c_cell b
where a.int_id=b.int_id
group by b.related_msc;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-------------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TwocarrierCellNum
)
with a as
(
select related_cell int_id from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_cell having count(distinct cdma_freq)=2
)
select b.related_msc,
v_date,
0,
101,
7,
count(distinct b.int_id) TwocarrierCellNum
from a,c_cell b
where a.int_id=b.int_id
group by b.related_msc;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
--
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
threecarrierCellNum
)
with a as
(
select related_cell int_id from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_cell having count(distinct cdma_freq)=3
)
select b.related_msc,
v_date,
0,
101,
7,
count(distinct b.int_id) threecarrierCellNum
from a,c_cell b
where a.int_id=b.int_id
group by b.related_msc;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
---------------------------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
FourcarrierCellNum
)
with a as
(
select related_cell int_id from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_cell having count(distinct cdma_freq)=4
)
select b.related_msc,
v_date,
0,
101,
7,
count(distinct b.int_id) FourcarrierCellNum
from a,c_cell b
where a.int_id=b.int_id and b.city_id is not null
group by b.related_msc;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
--------------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
btsNum
)
select
b.related_msc ,
v_date,
0,
101,
7,
count(distinct a.related_bts) btsNum
from c_carrier a,c_cell b where a.related_cell=b.int_id
and  a.cdma_freq in (283,242,201,160,119)
and a.vendor_id=7
group by b.related_msc;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
OnecarrierBtsNum
)
select
b.related_msc,
v_date,
0,
101,
7,
count(distinct a.related_bts) OnecarrierBtsNum
from
(select related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_bts having count(distinct cdma_freq)=1 ) a,c_cell b
where a.related_bts=b.related_bts and b.vendor_id=7
group by b.related_msc;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TwocarrierBtsNum
)
select
b.related_msc,
v_date,
0,
101,
7,
count(distinct a.related_bts) TwocarrierBtsNum
from
(select related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_bts having count(distinct cdma_freq)=2 ) a,c_cell b
where a.related_bts=b.related_bts and b.vendor_id=7
group by b.related_msc;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
threecarrierbtsNum
)
select
b.related_msc,
v_date,
0,
101,
7,
count(distinct a.related_bts) threecarrierbtsNum
from
(select related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_bts having count(distinct cdma_freq)=3 ) a,c_cell b
where a.related_bts=b.related_bts and b.vendor_id=7
group by b.related_msc;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
FourcarrierbtsNum
)
select
b.related_msc,
v_date,
0,
101,
7,
count(distinct a.related_bts) FourcarrierbtsNum
from
(select related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_bts having count(distinct cdma_freq)=4 ) a,c_cell b
where a.related_bts=b.related_bts and b.vendor_id=7
group by b.related_msc;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
BadCellNum
)
with t1 as(
select
c.related_cell related_cell,
c.related_msc related_msc,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)) / 3600 v1,
sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.ConVoc_RlsFailNum    ,0)
+nvl(a.ConVocData_RlsFailNum,0)) v2,
sum(nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum    ,0)
+nvl(a.v_CallSuccessNum     ,0)
+nvl(a.v_ExtInterruptNum    ,0)) v3_down_a
from C_tpd_cnt_carr_zx a,c_carrier c
where a.int_id = c.int_id and c.vendor_id=7
and a.scan_start_time = v_date
group by c.related_cell,c.related_msc),
t3e as(
select
c.related_cell related_cell,
c.related_msc related_msc,
sum(nvl(e.v_CMO_CallSuccessNum_ms,0)
+nvl(e.v_CMO_ExtInterruptNum       ,0)
+nvl(e.v_AccProbe_CallSuccessNum   ,0)
+nvl(e.v_AccProbe_ExtInterruptNum  ,0)
+nvl(e.v_AccHo_CallSuccessNum      ,0)
+nvl(e.v_AccHo_ExtInterruptNum     ,0)
+nvl(e.v_AssignSoft_CallSuccessNum ,0)
+nvl(e.v_AssignSoft_ExtInterruptNum,0)) v3_down_e
from C_tpd_cnt_carr_call_zx e,c_carrier c
where e.int_id = c.int_id  and c.vendor_id=7
and e.scan_start_time = v_date
group by c.related_cell,c.related_msc),
t3f as(
select
c.related_cell related_cell,
c.related_msc related_msc,
sum(nvl(f.v_CMO_CallSuccessNum,0)
+nvl(f.v_CMO_ExtInterruptNum       ,0)
+nvl(f.v_AccProbe_CallSuccessNum   ,0)
+nvl(f.v_AccProbe_ExtInterruptNum  ,0)
+nvl(f.v_AccHo_CallSuccessNum     ,0)
+nvl(f.v_AccHo_ExtInterruptNum     ,0)
+nvl(f.v_AssignSoft_CallSuccessNum ,0)
+nvl(f.v_AssignSoft_ExtInterruptNum,0)) v3_down_f
from C_tpd_cnt_carr_pag_zx f,c_carrier c
where f.int_id = c.int_id and c.vendor_id=7
and f.scan_start_time = v_date
group by c.related_cell,c.related_msc)
select
t1.related_msc related_msc,
v_date,
0,
101,
7,
count(t1.related_cell) BadCellNum
from t1,t3e,t3f
where t1.v1>2.5 and t1.v2>3 and t1.v2/(t1.v3_down_a+t3e.v3_down_e+t3f.v3_down_f) > 0.025
and t1.related_cell = t3e.related_cell and t3e.related_cell = t3f.related_cell
group by t1.related_msc;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-----
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TrafficCarrier1,
TrafficCarrier2,
TrafficCarrier3,
TrafficCarrier4
)
select
c.related_msc related_msc,
v_date,
0,
101,
7,
sum(case when cdma_freq=283 then nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SHoDuration                 ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur   ,0)
+nvl(b.v_SSHoDuration                ,0)
+nvl(a.p_AvfAssReq_AvfSvcAss_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(b.p_SHoDuration                 ,0)
+nvl(b.p_SSHoDuration,0) else 0 end )/3600   TrafficCarrier1,
sum(case when cdma_freq=201 then nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SHoDuration                 ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur   ,0)
+nvl(b.v_SSHoDuration                ,0)
+nvl(a.p_AvfAssReq_AvfSvcAss_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(b.p_SHoDuration                 ,0)
+nvl(b.p_SSHoDuration,0) else 0 end )/3600   TrafficCarrier2,
sum(case when cdma_freq=242 then nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SHoDuration                 ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur   ,0)
+nvl(b.v_SSHoDuration                ,0)
+nvl(a.p_AvfAssReq_AvfSvcAss_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(b.p_SHoDuration                 ,0)
+nvl(b.p_SSHoDuration,0) else 0 end )/3600   TrafficCarrier3,
sum(case when cdma_freq=160 then nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SHoDuration                 ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur   ,0)
+nvl(b.v_SSHoDuration                ,0)
+nvl(a.p_AvfAssReq_AvfSvcAss_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(b.p_SHoDuration ,0)
+nvl(b.p_SSHoDuration,0) else 0 end) / 3600  TrafficCarrier4
from C_tpd_cnt_carr_zx a,C_tpd_cnt_carr_ho_zx b,c_carrier c
where a.int_id=c.int_id and b.int_id=c.int_id and c.vendor_id=7 and a.scan_start_time=b.scan_start_time
and a.scan_start_time=v_date
group by c.related_msc;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
--TCHNum,
Wirecapacity
)
select
c.related_msc related_msc,
v_date,
0,
101,
7,
--sum(case when (ReliableFCENum > ReliableRCENum) then  ReliableRCENum
--else ReliableFCENum end) TCHNum,
sum(nvl(d.erl02,0)) Wirecapacity
from c_tpd_cnt_bts_zx h,c_bts c,c_erl d
where h.int_id = c.int_id and h.scan_start_time = v_date
and c.vendor_id = 7 and least(h.ReliableFCENum,h.ReliableRCENum)=d.tchnum
group by c.related_msc;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CellNum,
BusyerCellNum,
BusyCellNum,
FreeCellNum
)
select
a.related_msc,
v_date,
0,
101,
7,
a.CellNum,
b.BusyerCellNum,
c.BusyCellNum,
d.FreeCellNum
from
(
select b.related_msc ,count(distinct a.related_cell) CellNum
from c_carrier a,c_cell b
where a.related_cell=b.int_id and  a.cdma_freq in (283,242,201,160,119)
and a.vendor_id=7
group by b.related_msc ) a,
(
select a.related_msc ,count(b.int_id) BusyerCellNum
from
(
select c.related_msc ,c.related_bts int_id,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur ,0)+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SSHoDuration ,0)+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur,0))/3600 temp
from C_tpd_cnt_carr_zx a,C_tpd_cnt_carr_ho_zx b,c_carrier c
where c.vendor_id=7 and a.int_id=b.int_id and a.int_id=c.int_id
and a.scan_start_time=v_date and b.scan_start_time=v_date
group by c.related_msc,c.related_bts  ) a,c_cell b,c_tpd_sts_bts d,c_erl e
where a.int_id=d.int_id and e.tchnum=d.nbrAvailCe
and d.scan_start_time=v_date and b.vendor_id=7 and b.related_bts=d.int_id
and 100*temp/(decode(erl02,null,1,0,1,erl02)*360)>75
group by a.related_msc
) b,
(
select a.related_msc ,count(b.int_id) BusyCellNum
from
(
select c.related_msc ,c.related_bts int_id,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur ,0)+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SSHoDuration ,0)+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur,0))/3600 temp
from C_tpd_cnt_carr_zx a,C_tpd_cnt_carr_ho_zx b,c_carrier c
where c.vendor_id=7 and a.int_id=b.int_id and a.int_id=c.int_id
and a.scan_start_time=v_date and b.scan_start_time=v_date
group by c.related_msc,c.related_bts  ) a,c_cell b,c_tpd_sts_bts d,c_erl e
where a.int_id=d.int_id and e.tchnum=d.nbrAvailCe
and d.scan_start_time=v_date and b.vendor_id=7 and b.related_bts=d.int_id
and 100*temp/(decode(erl02,null,1,0,1,erl02)*360)<75
and 100*temp/(decode(erl02,null,1,0,1,erl02)*360)>60
group by a.related_msc
) c,
(
select a.related_msc ,count(b.int_id) FreeCellNum
from
(
select c.related_msc ,c.related_bts int_id,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur ,0)+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SSHoDuration ,0)+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur,0))/3600 temp
from C_tpd_cnt_carr_zx a,C_tpd_cnt_carr_ho_zx b,c_carrier c
where c.vendor_id=7 and a.int_id=b.int_id and a.int_id=c.int_id
and a.scan_start_time=v_date and b.scan_start_time=v_date
group by c.related_msc,c.related_bts  ) a,c_cell b,c_tpd_sts_bts d,c_erl e
where a.int_id=d.int_id and e.tchnum=d.nbrAvailCe
and d.scan_start_time=v_date and b.vendor_id=7 and b.related_bts=d.int_id
and 100*temp/(decode(erl02,null,1,0,1,erl02)*360)<10
group by a.related_msc
)d
where a.related_msc=b.related_msc(+) and a.related_msc=c.related_msc(+) and a.related_msc=d.related_msc(+);
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TCHBlockFailNumIncludeHo
)
select c.related_msc int_id,
v_date,
0,
101,
7,
  sum(nvl(a.v_VEBlockNum, 0) + nvl(a.v_VEBlockNum_l3, 0) +
           nvl(a.v_SEBlockNum, 0) + nvl(a.v_SEBlockNum_l3, 0) +
           nvl(a.v_CICBlockNum, 0) + nvl(a.v_CICBlockNum_l3, 0) +
           nvl(a.v_CEBlockNum_bsc, 0) + nvl(a.v_CEBlockNum_l3_bsc, 0) +
           nvl(a.v_CHBlockNum_bsc, 0) + nvl(a.v_CHBlockNum_l3_bsc, 0) +
           nvl(a.v_FPWBlockNum_bsc, 0) + nvl(a.v_FPWBlockNum_l3_bsc, 0) +
           nvl(a.v_FOBlockNum_bsc, 0) + nvl(a.v_FOBlockNum_l3_bsc, 0) +
           nvl(a.v_AbiscBlockNum_bsc, 0) + nvl(a.v_AbiscBlockNum_l3_bsc, 0))
           +
           sum(nvl(a.sm_VEBlockNum, 0) + nvl(a.sm_VEBlockNum_l3, 0) +
           nvl(a.sm_SEBlockNum, 0) + nvl(a.sm_SEBlockNum_l3, 0) +
           nvl(a.sm_CICBlockNum, 0) + nvl(a.sm_CICBlockNum_l3, 0) +
           nvl(a.sm_CEBlockNum, 0) + nvl(a.sm_CEBlockNum_l3, 0) +
           nvl(a.sm_CHBlockNum, 0) + nvl(a.sm_CHBlockNum_l3, 0) +
           nvl(a.sm_FPWBlockNum, 0) + nvl(a.sm_FPWBlockNum_l3, 0) +
           nvl(a.sm_FOBlockNum, 0) + nvl(a.sm_FOBlockNum_l3, 0) +
           nvl(a.sm_AbiscBlockNum, 0) + nvl(a.sm_AbiscBlockNum_l3, 0)) TCHBlockFailNumIncludeHo
from  C_TPD_1X_SUM_ZX_TEMP a,c_bsc c
where a.unique_rdn = c.unique_rdn
and  c.vendor_id = 7
group by c.related_msc;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TchSuccExcludeHoRate,
CallPageSuccRate,
cs_SHORate,
ps_SHORate,
cs_LoseCallingRate,
ps_LoseCallingRate,
LoseCallingRate,
ps_CallPageSuccRate,
cs_CallPageSuccRate,
CallPageReqNum,
CallPageSuccNum,
Numfailofcall,
cs_Numfailofcall,
BadCellRatio,
TCHBlockFailRate,
TchFNumIncludeHo,
ps_TchFNumIncludeHo,
ps_TchSuccIncludeHoRate,
ps_TchSuccExcludeHoRate,
ps_CallBlockFailRateHardho,
ps_CallBlockFailRatesoftho,
ps_HandoffReqNum,
ps_HandoffSuccNum,
ps_HandoffSuccRate,
ps_HardhoSuccRate,
ps_SofthoSuccRate,
ps_SSofthoSuccRate,
HandoffSuccRate_intra,
HandoffSuccRate_Extra,
HardhoSuccRate_intra,
ShoSuccRate_intra,
SShoSuccRate_intra,
HardhoSuccRate_Extra,
ShoSuccRate_Extra,
FwdChRxRate,
TCHLoadRate,
BusyerCellratio,
BusyCellratio,
FreeCellratio,
BtsSysHardHoSuccRate,
SysSHoSuccRate,
CallInterruptRate,
TchReqNumExcludeHo,
TchSuccNumIncludeHo,
TCHSUCCINCLUDEHORATE,
ps_TchFNumExcludeHo,
TchFNumExcludeHo,
ps_CallBlockFailRate,
TchReqNumIncludeHo,
cs_TchSuccIncludeHoRate,
LoseCallingratio,
ps_LoseCallingratio,
cs_LoseCallingratio,
CallBlockFailRate,
cs_CallBlockFailRate,
HandoffReqNum,
HandoffSuccNum,
HandoffSuccRate,
cs_SofthoSuccRate,
cs_TchFNumIncludeHo,
cs_TchFNumExcludeHo,
cs_TchSuccExcludeHoRate,
SHoFactor
)
select
int_id,
v_date,
0,
101,
7,
round(100*sum(cs_TchSuccNumExcludeHo + ps_TchSuccNumExcludeHo)/
decode(sum(cs_TchReqNumExcludeHo + ps_TchReqNumExcludeHo),0,1,null,1,sum(cs_TchReqNumExcludeHo + ps_TchReqNumExcludeHo)),4) TchSuccExcludeHoRate,
round(100*sum(cs_CallPageSuccNum+ps_CallPageSuccNum)/decode(sum(cs_CallPageReqNum+ps_CallPageReqNum),0,1,null,1,sum(cs_CallPageReqNum+ps_CallPageReqNum)),4) CallPageSuccRate,
round(100*sum(cs_SHOTraffic)/decode(sum(cs_TrafficExcludeHo+cs_SHOTraffic),null,1,0,1,sum(cs_TrafficExcludeHo+cs_SHOTraffic)),4) cs_SHORate,
round(100*sum(ps_SHOTraffic)/decode(sum(ps_CallTrafficExcludeHo + ps_SHOTraffic),null,1,0,1,sum(ps_CallTrafficExcludeHo + ps_SHOTraffic)),4) ps_SHORate,
round(100*sum(cs_LoseCallingNum)/decode(sum(cs_TchSuccNumExcludeHo),null,1,0,1,sum(cs_TchSuccNumExcludeHo)),4) cs_LoseCallingRate,
round(100*sum(ps_LoseCallingNum)/decode(sum(ps_TchSuccNumExcludeHo),null,1,0,1,sum(ps_TchSuccNumExcludeHo)),4) ps_LoseCallingRate,
round(100*sum(LoseCallingNum)/decode(sum(TchSuccNumExcludeHo),0,1,null,1,sum(TchSuccNumExcludeHo)),4) LoseCallingRate,
round(100*sum(ps_CallPageSuccNum)/decode(sum(ps_CallPageReqNum),0,1,null,1,sum(ps_CallPageReqNum)),4) ps_CallPageSuccRate,
round(100*sum(cs_CallPageSuccNum)/decode(sum(cs_CallPageReqNum),0,1,null,1,sum(cs_CallPageReqNum)),4)  cs_CallPageSuccRate,
sum(cs_CallPageReqNum+ps_CallPageReqNum) CallPageReqNum,
sum(cs_CallPageSuccNum+ps_CallPageSuccNum) CallPageSuccNum,
sum(nvl(cs_CallPageReqNum,0) + nvl(ps_CallPageReqNum,0) - nvl(cs_CallPageSuccNum,0) - nvl(ps_CallPageSuccNum,0)) Numfailofcall,
sum(nvl(cs_CallPageReqNum,0) - nvl(cs_CallPageSuccNum,0)) cs_Numfailofcall,
round(100*sum(nvl(BadCellNum,0))/decode(sum(CellNum),0,1,null,1,sum(CellNum)),4) BadCellRatio,
round(100*sum(nvl(TCHBlockFailNumIncludeHo,0))/decode(sum(TchReqNumIncludeHoSms),null,1,0,1,sum(TchReqNumIncludeHoSms)),4) TCHBlockFailRate,
sum((nvl(cs_TchReqNumIncludeHo,0)-nvl(cs_TchSuccNumIncludeHo,0)+nvl(ps_TchReqNumIncludeHo,0)-nvl(ps_TchSuccNumIncludeHo,0))) TchFNumIncludeHo,
round(sum(nvl(ps_TchReqNumIncludeHo,0)-nvl(ps_TchSuccNumIncludeHo,0)),4) ps_TchFNumIncludeHo,
round(100*sum(ps_TchSuccNumIncludeHo)/decode(sum(ps_TchReqNumIncludeHo),null,1,0,1,sum(ps_TchReqNumIncludeHo)),4) ps_TchSuccIncludeHoRate,
round(100*sum(ps_TchSuccNumExcludeHo)/decode(sum(ps_TchReqNumExcludeHo),null,1,0,1,sum(ps_TchReqNumExcludeHo)),4) ps_TchSuccExcludeHoRate,
round(100*sum(nvl(ps_TchReqNumHardho,0)-nvl(ps_TchSuccNumHardho,0))/decode(sum(ps_TchReqNumHardho),null,1,0,1,sum(ps_TchReqNumHardho)),4) ps_CallBlockFailRateHardho,
round(100*sum(nvl(ps_TchReqNumsoftho,0)-nvl(ps_TchSuccNumsoftho,0))/decode(sum(ps_TchReqNumsoftho),null,1,0,1,sum(ps_TchReqNumsoftho)),4) ps_CallBlockFailRatesoftho,
sum(nvl(ps_HardhoReqNum,0)+nvl(ps_SofthoReqNum,0)+nvl(ps_SSofthoReqNum,0)) ps_HandoffReqNum,
sum(nvl(ps_HardhoSuccNum,0)+nvl(ps_SofthoSuccNum,0)+nvl(ps_SSofthoSuccNum,0)) ps_HandoffSuccNum,
round(100*sum(nvl(ps_HardhoSuccNum,0)+nvl(ps_SofthoSuccNum,0)+nvl(ps_SSofthoSuccNum,0))/decode(sum(ps_HardhoReqNum+ps_SofthoReqNum+ps_SSofthoReqNum),null,1,0,1,sum(ps_HardhoReqNum+ps_SofthoReqNum+ps_SSofthoReqNum)),4)  ps_HandoffSuccRate,
round(100*sum(ps_HardhoSuccNum) /decode(sum(ps_HardhoReqNum),null,1,0,1,sum(ps_HardhoReqNum)),4) ps_HardhoSuccRate,
round(100*sum(ps_SofthoSuccNum) /decode(sum(ps_SofthoReqNum),null,1,0,1,sum(ps_SofthoReqNum)),4) ps_SofthoSuccRate,
round(100*sum(ps_SSofthoSuccNum)/decode(sum(ps_SSofthoReqNum),null,1,0,1,sum(ps_SSofthoReqNum)),4) ps_SSofthoSuccRate,
round(100*sum(HandoffSuccNum_intra)/decode(sum(HandoffReqNum_intra),null,1,0,1,sum(HandoffReqNum_intra)),4) HandoffSuccRate_intra,
round(100*sum(HandoffSuccNum_Extra)/decode(sum(HandoffReqNum_Extra),null,1,0,1,sum(HandoffReqNum_Extra)),4) HandoffSuccRate_Extra,
round(100*sum(HardhoSuccNum_intra)/decode(sum(HardhoReqNum_intra),null,1,0,1,sum(HardhoReqNum_intra)),4)  HardhoSuccRate_intra,
round(100*sum(ShoSuccNum_intra)/decode(sum(ShoReqNum_intra),null,1,0,1,sum(ShoReqNum_intra)),4)  ShoSuccRate_intra,
round(100*sum(SShoSuccNum_intra)/decode(sum(SShoReqNum_intra),null,1,0,1,sum(SShoReqNum_intra)),4) SShoSuccRate_intra,
round(100*sum(HardhoSuccNum_Extra)/decode(sum(HardhoReqNum_Extra),null,1,0,1,sum(HardhoReqNum_Extra)),4) HardhoSuccRate_Extra,
round(100*sum(ShoSuccNum_Extra)/decode(sum(ShoReqNum_Extra),null,1,0,1,sum(ShoReqNum_Extra)),4) ShoSuccRate_Extra,
round(100*sum(FwdRxTotalFrame)/decode(sum(nvl(FwdRxTotalFrame,0)+nvl(FdwTxTotalFrameExcludeRx,0)),null,1,0,1,sum(nvl(FwdRxTotalFrame,0)+nvl(FdwTxTotalFrameExcludeRx,0))),4) FwdChRxRate,
round(100*sum(TCHLoadTrafficIncludeHo)/decode(sum(Wirecapacity),null,1,0,1,sum(Wirecapacity)),4)   TCHLoadRate,
round(100*sum(BusyerCellNum)/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4) BusyerCellratio,
round(100*sum(BusyCellNum)/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4) BusyCellratio,
round(100*sum(FreeCellNum)/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4) FreeCellratio,
round(100*sum(BtsSysHardHoSuccNum)/decode(sum(BtsSysHardHoReqNum),null,1,0,1,sum(BtsSysHardHoReqNum)),4)  BtsSysHardHoSuccRate,
round(100*sum(SysSHoSuccNum)/decode(sum(SysSHoReqNum),null,1,0,1,sum(SysSHoReqNum)),4)   SysSHoSuccRate,
round(100*sum(TCHRadioFNum)/decode(sum(cs_CallPageSuccNum),null,1,0,1,sum(cs_CallPageSuccNum)),4) CallInterruptRate,
sum(nvl(cs_TchReqNumExcludeHo,0)+nvl(ps_TchReqNumExcludeHo,0))  TchReqNumExcludeHo,
sum(nvl(cs_TchSuccNumIncludeHo,0)+nvl(ps_TchSuccNumIncludeHo,0)) TchSuccNumIncludeHo,
round(100*sum(nvl(cs_TchSuccNumIncludeHo,0)+nvl(ps_TchSuccNumIncludeHo,0))/decode(sum(nvl(cs_TchReqNumIncludeHo,0)+nvl(ps_TchReqNumIncludeHo,0)),null,1,0,1,sum(nvl(cs_TchReqNumIncludeHo,0)+nvl(ps_TchReqNumIncludeHo,0))),4) TCHSUCCINCLUDEHORATE,
sum(nvl(ps_TchReqNumExcludeHo,0)-nvl(ps_TchSuccNumExcludeHo,0)) ps_TchFNumExcludeHo,
round(sum(nvl(cs_TchReqNumExcludeHo,0)-nvl(cs_TchSuccNumExcludeHo,0)+nvl(ps_TchReqNumExcludeHo,0)-nvl(ps_TchSuccNumExcludeHo,0)),4) TchFNumExcludeHo,
round(100*sum(ps_CallBlockFailNum)/decode(sum(ps_TchReqNumIncludeHo),null,1,0,1,sum(ps_TchReqNumIncludeHo)),4)  ps_CallBlockFailRate,
sum(nvl(cs_TchReqNumIncludeHo,0)+nvl(ps_TchReqNumIncludeHo,0))  TchReqNumIncludeHo,
round(100*sum(cs_TchSuccNumIncludeHo)/decode(sum(cs_TchReqNumIncludeHo),null,1,0,1,sum(cs_TchReqNumIncludeHo)),4)  cs_TchSuccIncludeHoRate,
round(sum(TrafficExcludeHo)*60/decode(sum(LoseCallingNum),null,1,0,1,sum(LoseCallingNum)),4)           LoseCallingratio,
round(sum(ps_CallTrafficExcludeHo)*60/decode(sum(ps_LoseCallingNum),null,1,0,1,sum(ps_LoseCallingNum)),4) ps_LoseCallingratio,
case when sum(cs_LoseCallingNum) is null then 1000
     when sum(cs_LoseCallingNum) = 0     then 1000
else round(sum(cs_TrafficExcludeHo)*60/sum(cs_LoseCallingNum),4) end    cs_LoseCallingratio,
round(100*sum(CallBlockFailNum)/decode(sum(nvl(cs_TchReqNumIncludeHo,0)+nvl(ps_TchReqNumIncludeHo,0)),null,1,0,1,sum(nvl(cs_TchReqNumIncludeHo,0)+nvl(ps_TchReqNumIncludeHo,0))),4)  CallBlockFailRate,
round(100*sum(cs_CallBlockFailNum)/decode(sum(cs_TchReqNumIncludeHo),null,1,0,1,sum(cs_TchReqNumIncludeHo)),4) cs_CallBlockFailRate,
sum(nvl(HardhoReqNum_intra,0)+nvl(ShoReqNum_intra,0)+nvl(SShoReqNum_intra,0)+ nvl(HardhoReqNum_Extra,0)+nvl(ShoReqNum_Extra,0)) HandoffReqNum,
sum(nvl(HardhoSuccNum_intra,0)+nvl(ShoSuccNum_intra,0)+nvl(SShoSuccNum_intra,0) + nvl(HardhoSuccNum_Extra,0)+nvl(ShoSuccNum_Extra,0))  HandoffSuccNum,
round(100*sum(nvl(HardhoSuccNum_intra,0)+nvl(ShoSuccNum_intra,0)+nvl(SShoSuccNum_intra,0) + nvl(HardhoSuccNum_Extra,0)+nvl(ShoSuccNum_Extra,0))/
decode(sum(nvl(HardhoReqNum_intra,0)+nvl(ShoReqNum_intra,0)+nvl(SShoReqNum_intra,0)+ nvl(HardhoReqNum_Extra,0)+nvl(ShoReqNum_Extra,0)),null,1,0,1,
sum(nvl(HardhoReqNum_intra,0)+nvl(ShoReqNum_intra,0)+nvl(SShoReqNum_intra,0)+ nvl(HardhoReqNum_Extra,0)+nvl(ShoReqNum_Extra,0))),4) HandoffSuccRate,
round(100*sum(cs_SofthoSuccNum)/decode(sum(cs_SofthoReqNum),null,1,0,1,sum(cs_SofthoReqNum)),4) cs_SofthoSuccRate,
sum(nvl(cs_TchReqNumIncludeHo,0)-nvl(cs_TchSuccNumIncludeHo,0)) cs_TchFNumIncludeHo,
sum(nvl(cs_TchReqNumExcludeHo,0)-nvl(cs_TchSuccNumExcludeHo,0)) cs_TchFNumExcludeHo,
round(100*sum(cs_TchSuccNumExcludeHo)/decode(sum(cs_TchReqNumExcludeHo),null,1,0,1,sum(cs_TchReqNumExcludeHo)),4) cs_TchSuccExcludeHoRate,
round(100*sum(nvl(TCHLoadTrafficIncludeHo,0) - nvl(TCHLoadTrafficExcludeHo,0))/decode(sum(TCHLoadTrafficExcludeHo),0,1,null,1,sum(TCHLoadTrafficExcludeHo)),4) SHoFactor
from C_PERF_1X_SUM_ZX_TEMP
group by int_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
----
insert /*+ APPEND*/ into C_PERF_1X_SUM
(
int_id                         ,
scan_start_time                ,
sum_level                      ,
ne_type                        ,
vendor_id                      ,
callpagereqnum                 ,
callpagesuccnum                ,
callpagesuccrate               ,
cs_callpagereqnum              ,
cs_callpagesuccnum             ,
cs_callpagesuccrate            ,
ps_callpagereqnum              ,
ps_callpagesuccnum             ,
ps_callpagesuccrate            ,
trafficincludeho               ,
trafficexcludeho               ,
cs_trafficincludeho            ,
cs_trafficexcludeho            ,
cs_trafficbywalsh              ,
cs_shotraffic                  ,
cs_sshotraffic                 ,
cs_shorate                     ,
ps_calltrafficincludeho        ,
ps_calltrafficexcludeho        ,
ps_trafficbywalsh              ,
ps_shotraffic                  ,
ps_sshotraffic                 ,
ps_shorate                     ,
losecallingnum                 ,
losecallingrate                ,
losecallingratio               ,
cs_losecallingnum              ,
cs_losecallingrate             ,
cs_losecallingratio            ,
ps_losecallingnum              ,
ps_losecallingrate             ,
ps_losecallingratio            ,
tchreqnumincludeho             ,
tchsuccnumincludeho            ,
tchfnumincludeho               ,
tchsuccincludehorate           ,
tchreqnumexcludeho             ,
tchsuccnumexcludeho            ,
tchfnumexcludeho               ,
tchsuccexcludehorate           ,
callblockfailnum               ,
callblockfailrate              ,
cs_tchreqnumincludeho          ,
cs_tchsuccnumincludeho         ,
cs_tchfnumincludeho            ,
cs_tchsuccincludehorate        ,
cs_tchreqnumexcludeho          ,
cs_tchsuccnumexcludeho         ,
cs_tchfnumexcludeho            ,
cs_tchsuccexcludehorate        ,
cs_callblockfailnum            ,
cs_callblockfailrate           ,
cs_tchreqnumhardho             ,
cs_tchsuccnumhardho            ,
cs_callblockfailratehardho     ,
cs_tchreqnumsoftho             ,
cs_tchsuccnumsoftho            ,
cs_callblockfailratesoftho     ,
ps_tchreqnumincludeho          ,
ps_tchsuccnumincludeho         ,
ps_tchfnumincludeho            ,
ps_tchsuccincludehorate        ,
ps_tchreqnumexcludeho          ,
ps_tchsuccnumexcludeho         ,
ps_tchfnumexcludeho            ,
ps_tchsuccexcludehorate        ,
ps_callblockfailnum            ,
ps_callblockfailrate           ,
ps_tchreqnumhardho             ,
ps_tchsuccnumhardho            ,
ps_callblockfailratehardho     ,
ps_tchreqnumsoftho             ,
ps_tchsuccnumsoftho            ,
ps_callblockfailratesoftho     ,
handoffreqnum                  ,
handoffsuccnum                 ,
handoffsuccrate                ,
cs_handoffreqnum               ,
cs_handoffsuccnum              ,
cs_handoffsuccrate             ,
cs_hardhoreqnum                ,
cs_hardhosuccnum               ,
cs_hardhosuccrate              ,
cs_softhoreqnum                ,
cs_softhosuccnum               ,
cs_softhosuccrate              ,
cs_ssofthoreqnum               ,
cs_ssofthosuccnum              ,
cs_ssofthosuccrate             ,
ps_handoffreqnum               ,
ps_handoffsuccnum              ,
ps_handoffsuccrate             ,
ps_hardhoreqnum                ,
ps_hardhosuccnum               ,
ps_hardhosuccrate              ,
ps_softhoreqnum                ,
ps_softhosuccnum               ,
ps_softhosuccrate              ,
ps_ssofthoreqnum               ,
ps_ssofthosuccnum              ,
ps_ssofthosuccrate             ,
handoffreqnum_intra            ,
handoffsuccnum_intra           ,
handoffsuccrate_intra          ,
handoffreqnum_extra            ,
handoffsuccnum_extra           ,
handoffsuccrate_extra          ,
hardhoreqnum_intra             ,
hardhosuccnum_intra            ,
hardhosuccrate_intra           ,
shoreqnum_intra                ,
shosuccnum_intra               ,
shosuccrate_intra              ,
sshoreqnum_intra               ,
sshosuccnum_intra              ,
sshosuccrate_intra             ,
hardhoreqnum_extra             ,
hardhosuccnum_extra            ,
hardhosuccrate_extra           ,
shoreqnum_extra                ,
shosuccnum_extra               ,
shosuccrate_extra              ,
carrier1btsnum                 ,
carrier2btsnum                 ,
carrier3btsnum                 ,
carrier4btsnum                 ,
carriernum_1x                  ,
channelnum                     ,
channelavailnum                ,
channelmaxusenum               ,
channelmaxuserate              ,
fwdchnum                       ,
fwdchavailnum                  ,
fwdchmaxusenum                 ,
fwdchmaxuserate                ,
revchnum                       ,
revchavailnum                  ,
revchmaxusenum                 ,
revchmaxuserate                ,
fwdrxtotalframe                ,
fdwtxtotalframeexcluderx       ,
rlpfwdchsizeexcluderx          ,
rlpfwdchrxsize                 ,
rlpfwdlosesize                 ,
fwdchrxrate                    ,
revrxtotalframe                ,
revtxtotalframeexcluderx       ,
rlprevchsize                   ,
revchrxrate                    ,
btsnum                         ,
onecarrierbtsnum               ,
twocarrierbtsnum               ,
threecarrierbtsnum             ,
fourcarrierbtsnum              ,
cellnum                        ,
onecarriercellnum              ,
twocarriercellnum              ,
threecarriercellnum            ,
fourcarriercellnum             ,
cenum                          ,
wirecapacity                   ,
tchnum                         ,
tchloadrate                    ,
shofactor                      ,
ceavailrate                    ,
tchblockfailrate               ,
busyercellratio                ,
busycellratio                  ,
freecellratio                  ,
serioverflowbtsratio           ,
overflowbtsratio               ,
btssyshardhosuccrate           ,
sysshosuccrate                 ,
tchradiofrate                  ,
callinterruptrate              ,
avgradiofperiod                ,
badcellratio                   ,
ceavailnum                     ,
tchblockfailnumincludeho       ,
tchloadtrafficincludeho        ,
tchloadtrafficexcludeho        ,
loadtrafficbywalsh             ,
trafficcarrier1                ,
trafficcarrier2                ,
trafficcarrier3                ,
trafficcarrier4                ,
busyercellnum                  ,
busycellnum                    ,
freecellnum                    ,
badcellnum                     ,
serioverflowbtsnum             ,
overflowbtsnum                 ,
tchreqnumcallerexcludehosms    ,
tchsuccnumcallerexcludehosms    ,
tchreqnumcalleeexcludehosms    ,
tchsuccnumcalleeexcludehosms    ,
tchreqnumexcludehosms          ,
tchsuccnumexcludehosms         ,
tchreqnumincludehosms          ,
tchsuccnumincludehosms         ,
btssyshardhoreqnum             ,
btssyshardhosuccnum            ,
sysshoreqnum                   ,
sysshosuccnum                  ,
tchradiofnum                   ,
callpagereqtotalnum            ,
numfailofcall                  ,
ps_numfailofcall               ,
cs_numfailofcall
)
select
int_id                         ,
v_date                ,
0                      ,
101                        ,
7                      ,
sum(nvl(callpagereqnum                 ,0)),
sum(nvl(callpagesuccnum                ,0)),
sum(nvl(callpagesuccrate               ,0)),
sum(nvl(cs_callpagereqnum              ,0)),
sum(nvl(cs_callpagesuccnum             ,0)),
sum(nvl(cs_callpagesuccrate            ,0)),
sum(nvl(ps_callpagereqnum              ,0)),
sum(nvl(ps_callpagesuccnum             ,0)),
sum(nvl(ps_callpagesuccrate            ,0)),
sum(nvl(trafficincludeho               ,0)),
sum(nvl(trafficexcludeho               ,0)),
sum(nvl(cs_trafficincludeho            ,0)),
sum(nvl(cs_trafficexcludeho            ,0)),
sum(nvl(cs_trafficbywalsh              ,0)),
sum(nvl(cs_shotraffic                  ,0)),
sum(nvl(cs_sshotraffic                 ,0)),
sum(nvl(cs_shorate                     ,0)),
sum(nvl(ps_calltrafficincludeho        ,0)),
sum(nvl(ps_calltrafficexcludeho        ,0)),
sum(nvl(ps_trafficbywalsh              ,0)),
sum(nvl(ps_shotraffic                  ,0)),
sum(nvl(ps_sshotraffic                 ,0)),
sum(nvl(ps_shorate                     ,0)),
sum(nvl(losecallingnum                 ,0)),
sum(nvl(losecallingrate                ,0)),
sum(nvl(losecallingratio               ,0)),
sum(nvl(cs_losecallingnum              ,0)),
sum(nvl(cs_losecallingrate             ,0)),
sum(nvl(cs_losecallingratio            ,0)),
sum(nvl(ps_losecallingnum              ,0)),
sum(nvl(ps_losecallingrate             ,0)),
sum(nvl(ps_losecallingratio            ,0)),
sum(nvl(tchreqnumincludeho             ,0)),
sum(nvl(tchsuccnumincludeho            ,0)),
sum(nvl(tchfnumincludeho               ,0)),
sum(nvl(tchsuccincludehorate           ,0)),
sum(nvl(tchreqnumexcludeho             ,0)),
sum(nvl(tchsuccnumexcludeho            ,0)),
sum(nvl(tchfnumexcludeho               ,0)),
sum(nvl(tchsuccexcludehorate           ,0)),
sum(nvl(callblockfailnum               ,0)),
sum(nvl(callblockfailrate              ,0)),
sum(nvl(cs_tchreqnumincludeho          ,0)),
sum(nvl(cs_tchsuccnumincludeho         ,0)),
sum(nvl(cs_tchfnumincludeho            ,0)),
sum(nvl(cs_tchsuccincludehorate        ,0)),
sum(nvl(cs_tchreqnumexcludeho          ,0)),
sum(nvl(cs_tchsuccnumexcludeho         ,0)),
sum(nvl(cs_tchfnumexcludeho            ,0)),
sum(nvl(cs_tchsuccexcludehorate        ,0)),
sum(nvl(cs_callblockfailnum            ,0)),
sum(nvl(cs_callblockfailrate           ,0)),
sum(nvl(cs_tchreqnumhardho             ,0)),
sum(nvl(cs_tchsuccnumhardho            ,0)),
sum(nvl(cs_callblockfailratehardho     ,0)),
sum(nvl(cs_tchreqnumsoftho             ,0)),
sum(nvl(cs_tchsuccnumsoftho            ,0)),
sum(nvl(cs_callblockfailratesoftho     ,0)),
sum(nvl(ps_tchreqnumincludeho          ,0)),
sum(nvl(ps_tchsuccnumincludeho         ,0)),
sum(nvl(ps_tchfnumincludeho            ,0)),
sum(nvl(ps_tchsuccincludehorate        ,0)),
sum(nvl(ps_tchreqnumexcludeho          ,0)),
sum(nvl(ps_tchsuccnumexcludeho         ,0)),
sum(nvl(ps_tchfnumexcludeho            ,0)),
sum(nvl(ps_tchsuccexcludehorate        ,0)),
sum(nvl(ps_callblockfailnum            ,0)),
sum(nvl(ps_callblockfailrate           ,0)),
sum(nvl(ps_tchreqnumhardho             ,0)),
sum(nvl(ps_tchsuccnumhardho            ,0)),
sum(nvl(ps_callblockfailratehardho     ,0)),
sum(nvl(ps_tchreqnumsoftho             ,0)),
sum(nvl(ps_tchsuccnumsoftho            ,0)),
sum(nvl(ps_callblockfailratesoftho     ,0)),
sum(nvl(handoffreqnum                  ,0)),
sum(nvl(handoffsuccnum                 ,0)),
sum(nvl(handoffsuccrate                ,0)),
sum(nvl(cs_handoffreqnum               ,0)),
sum(nvl(cs_handoffsuccnum              ,0)),
sum(nvl(cs_handoffsuccrate             ,0)),
sum(nvl(cs_hardhoreqnum                ,0)),
sum(nvl(cs_hardhosuccnum               ,0)),
sum(nvl(cs_hardhosuccrate              ,0)),
sum(nvl(cs_softhoreqnum                ,0)),
sum(nvl(cs_softhosuccnum               ,0)),
sum(nvl(cs_softhosuccrate              ,0)),
sum(nvl(cs_ssofthoreqnum               ,0)),
sum(nvl(cs_ssofthosuccnum              ,0)),
sum(nvl(cs_ssofthosuccrate             ,0)),
sum(nvl(ps_handoffreqnum               ,0)),
sum(nvl(ps_handoffsuccnum              ,0)),
sum(nvl(ps_handoffsuccrate             ,0)),
sum(nvl(ps_hardhoreqnum                ,0)),
sum(nvl(ps_hardhosuccnum               ,0)),
sum(nvl(ps_hardhosuccrate              ,0)),
sum(nvl(ps_softhoreqnum                ,0)),
sum(nvl(ps_softhosuccnum               ,0)),
sum(nvl(ps_softhosuccrate              ,0)),
sum(nvl(ps_ssofthoreqnum               ,0)),
sum(nvl(ps_ssofthosuccnum              ,0)),
sum(nvl(ps_ssofthosuccrate             ,0)),
sum(nvl(handoffreqnum_intra            ,0)),
sum(nvl(handoffsuccnum_intra           ,0)),
sum(nvl(handoffsuccrate_intra          ,0)),
sum(nvl(handoffreqnum_extra            ,0)),
sum(nvl(handoffsuccnum_extra           ,0)),
sum(nvl(handoffsuccrate_extra          ,0)),
sum(nvl(hardhoreqnum_intra             ,0)),
sum(nvl(hardhosuccnum_intra            ,0)),
sum(nvl(hardhosuccrate_intra           ,0)),
sum(nvl(shoreqnum_intra                ,0)),
sum(nvl(shosuccnum_intra               ,0)),
sum(nvl(shosuccrate_intra              ,0)),
sum(nvl(sshoreqnum_intra               ,0)),
sum(nvl(sshosuccnum_intra              ,0)),
sum(nvl(sshosuccrate_intra             ,0)),
sum(nvl(hardhoreqnum_extra             ,0)),
sum(nvl(hardhosuccnum_extra            ,0)),
sum(nvl(hardhosuccrate_extra           ,0)),
sum(nvl(shoreqnum_extra                ,0)),
sum(nvl(shosuccnum_extra               ,0)),
sum(nvl(shosuccrate_extra              ,0)),
sum(nvl(carrier1btsnum                 ,0)),
sum(nvl(carrier2btsnum                 ,0)),
sum(nvl(carrier3btsnum                 ,0)),
sum(nvl(carrier4btsnum                 ,0)),
sum(nvl(carriernum_1x                  ,0)),
sum(nvl(channelnum                     ,0)),
sum(nvl(channelavailnum                ,0)),
sum(nvl(channelmaxusenum               ,0)),
sum(nvl(channelmaxuserate              ,0)),
sum(nvl(fwdchnum                       ,0)),
sum(nvl(fwdchavailnum                  ,0)),
sum(nvl(fwdchmaxusenum                 ,0)),
sum(nvl(fwdchmaxuserate                ,0)),
sum(nvl(revchnum                       ,0)),
sum(nvl(revchavailnum                  ,0)),
sum(nvl(revchmaxusenum                 ,0)),
sum(nvl(revchmaxuserate                ,0)),
sum(nvl(fwdrxtotalframe                ,0)),
sum(nvl(fdwtxtotalframeexcluderx       ,0)),
sum(nvl(rlpfwdchsizeexcluderx          ,0)),
sum(nvl(rlpfwdchrxsize                 ,0)),
sum(nvl(rlpfwdlosesize                 ,0)),
sum(nvl(fwdchrxrate                    ,0)),
sum(nvl(revrxtotalframe                ,0)),
sum(nvl(revtxtotalframeexcluderx       ,0)),
sum(nvl(rlprevchsize                   ,0)),
sum(nvl(revchrxrate                    ,0)),
sum(nvl(btsnum                         ,0)),
sum(nvl(onecarrierbtsnum               ,0)),
sum(nvl(twocarrierbtsnum               ,0)),
sum(nvl(threecarrierbtsnum             ,0)),
sum(nvl(fourcarrierbtsnum              ,0)),
sum(nvl(cellnum                        ,0)),
sum(nvl(onecarriercellnum              ,0)),
sum(nvl(twocarriercellnum              ,0)),
sum(nvl(threecarriercellnum            ,0)),
sum(nvl(fourcarriercellnum             ,0)),
sum(nvl(cenum                          ,0)),
sum(nvl(wirecapacity                   ,0)),
sum(nvl(tchnum                         ,0)),
sum(nvl(tchloadrate                    ,0)),
sum(nvl(shofactor                      ,0)),
sum(nvl(ceavailrate                    ,0)),
sum(nvl(tchblockfailrate               ,0)),
sum(nvl(busyercellratio                ,0)),
sum(nvl(busycellratio                  ,0)),
sum(nvl(freecellratio                  ,0)),
sum(nvl(serioverflowbtsratio           ,0)),
sum(nvl(overflowbtsratio               ,0)),
sum(nvl(btssyshardhosuccrate           ,0)),
sum(nvl(sysshosuccrate                 ,0)),
sum(nvl(tchradiofrate                  ,0)),
sum(nvl(callinterruptrate              ,0)),
sum(nvl(avgradiofperiod                ,0)),
sum(nvl(badcellratio                   ,0)),
sum(nvl(ceavailnum                     ,0)),
sum(nvl(tchblockfailnumincludeho       ,0)),
sum(nvl(tchloadtrafficincludeho        ,0)),
sum(nvl(tchloadtrafficexcludeho        ,0)),
sum(nvl(loadtrafficbywalsh             ,0)),
sum(nvl(trafficcarrier1                ,0)),
sum(nvl(trafficcarrier2                ,0)),
sum(nvl(trafficcarrier3                ,0)),
sum(nvl(trafficcarrier4                ,0)),
sum(nvl(busyercellnum                  ,0)),
sum(nvl(busycellnum                    ,0)),
sum(nvl(freecellnum                    ,0)),
sum(nvl(badcellnum                     ,0)),
sum(nvl(serioverflowbtsnum             ,0)),
sum(nvl(overflowbtsnum                 ,0)),
sum(nvl(tchreqnumcallerexcludehosms    ,0)),
sum(nvl(tchsuccnumcallerexcludehosms   ,0) ),
sum(nvl(tchreqnumcalleeexcludehosms    ,0)),
sum(nvl(tchsuccnumcalleeexcludehosms   ,0) ),
sum(nvl(tchreqnumexcludehosms          ,0)),
sum(nvl(tchsuccnumexcludehosms         ,0)),
sum(nvl(tchreqnumincludehosms          ,0)),
sum(nvl(tchsuccnumincludehosms         ,0)),
sum(nvl(btssyshardhoreqnum             ,0)),
sum(nvl(btssyshardhosuccnum            ,0)),
sum(nvl(sysshoreqnum                   ,0)),
sum(nvl(sysshosuccnum                  ,0)),
sum(nvl(tchradiofnum                   ,0)),
sum(nvl(callpagereqtotalnum            ,0)),
sum(nvl(numfailofcall                  ,0)),
sum(nvl(ps_CallPageReqNum,0) - nvl(ps_CallPageSuccNum,0)) ps_Numfailofcall,
sum(nvl(cs_numfailofcall               ,0))

from C_PERF_1X_SUM_ZX_TEMP
group by int_id;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');

v_sql:='truncate table C_PERF_1X_SUM_ZX_TEMP';
dbms_output.put_line(v_sql);
execute immediate v_sql;
dbms_output.put_line('Now time:'||sysdate||'-');

commit;


----------------------------------------------------------------------------------end msc
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TrafficExcludeHo,
cs_TrafficExcludeHo,
ps_CallTrafficExcludeHo,
LoseCallingNum,
cs_LoseCallingNum,
ps_LoseCallingNum,
AvgRadioFPeriod,
TCHLoadTrafficExcludeHo,
TCHRadioFNum,
cs_TchReqNumHardho,
cs_TchSuccNumHardho,
cs_CallBlockFailRateHardho,
cs_TchReqNumsoftho,
cs_TchSuccNumsoftho,
cs_CallBlockFailRatesoftho,
ps_TchReqNumHardho,
ps_TchSuccNumHardho,
ps_TchReqNumsoftho,
ps_TchSuccNumsoftho,
cs_HandoffReqNum,
cs_HandoffSuccNum,
cs_HandoffSuccRate,
cs_HardhoReqNum,
cs_HardhoSuccNum,
cs_HardhoSuccRate,
cs_SofthoReqNum,
cs_SofthoSuccNum,
cs_SSofthoReqNum,
cs_SSofthoSuccNum,
cs_SSofthoSuccRate,
ps_HardhoReqNum,
ps_HardhoSuccNum,
ps_SofthoReqNum,
ps_SofthoSuccNum,
ps_SSofthoReqNum,
ps_SSofthoSuccNum,
HandoffReqNum_intra,
HandoffSuccNum_intra,
HandoffReqNum_Extra,
HandoffSuccNum_Extra,
HardhoReqNum_intra,
HardhoSuccNum_intra,
ShoReqNum_intra,
ShoSuccNum_intra,
SShoReqNum_intra,
SShoSuccNum_intra,
HardhoReqNum_Extra,
HardhoSuccNum_Extra,
ShoReqNum_Extra,
ShoSuccNum_Extra,
BtsSysHardHoReqNum,
BtsSysHardHoSuccNum,
SysSHoReqNum,
SysSHoSuccNum,
CallBlockFailNum,
cs_CallBlockFailNum,
ps_CallBlockFailNum,
TrafficIncludeHo,
cs_TrafficIncludeHo,
cs_trafficByWalsh,
cs_SHOTraffic,
cs_SSHOTraffic,
ps_CallTrafficIncludeHo,
ps_trafficByWalsh,
ps_SHOTraffic,
ps_SSHOTraffic,
TCHLoadTrafficIncludeHo,
LoadTrafficByWalsh,
FwdRxTotalFrame,
FdwTxTotalFrameExcludeRx,
RevRxTotalFrame,
RevTxTotalFrameExcludeRx,
RevChRxRate,
TchReqNumCalleeExcludeHoSms,
TchSuccNumCalleeExcludeHoSms,
CEAvailNum,
cs_CallPageReqNum,
cs_CallPageSuccNum,
TchSuccNumExcludeHo,
ps_CallPageSuccNum,
ps_CallPageReqNum,
ChannelNum       ,
ChannelMaxUseNum ,
ChannelMaxUseRate,
FwdChNum         ,
FwdChAvailNum    ,
FwdChMaxUseNum   ,
FwdChMaxUseRate  ,
RevChNum         ,
RevChAvailNum    ,
RevChMaxUseNum   ,
RevChMaxUseRate  ,
CENum            ,
CEAvailRate ,
TchReqNumExcludeHoSms,
CallPageReqTotalNum,
TchReqNumCallerExcludeHoSms,
TchSuccNumCallerExcludeHoSms,
ChannelAvailNum,
TCHNum,
cs_TchReqNumExcludeHo,
TchRadioFRate,
ps_TchReqNumExcludeHo,
cs_TchSuccNumExcludeHo,
ps_TchSuccNumExcludeHo,
TchSuccNumExcludeHoSms,
cs_TchSuccNumIncludeHo,
ps_TchReqNumIncludeHo,
cs_TchReqNumIncludeHo,
ps_TchSuccNumIncludeHo,
TchReqNumIncludeHoSms,
TchSuccNumIncludeHoSms
)
with a as
(
select
c.city_id city_id,
sum(nvl(a.V_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.P_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0))/3600 TrafficExcludeHo,
sum(nvl(a.V_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0)) / 3600 cs_TrafficExcludeHo,
sum(nvl(a.P_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0))/3600 ps_CallTrafficExcludeHo,
sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.sm_CM_RadioLoseCallingNum,0)
+nvl(a.ConVoc_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0)
+nvl(a.p_CM_RadioFNum,0)
+nvl(a.ConData_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0)) LoseCallingNum,
sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.ConVoc_RlsFailNum    ,0)
+nvl(a.ConVocData_RlsFailNum,0)) cs_LoseCallingNum,
sum(nvl(a.p_CM_RadioFNum,0)
+nvl(a.ConData_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0)) ps_LoseCallingNum,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0))/3600*60/
decode(sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.ConVoc_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0)),0,1,null,1,sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.ConVoc_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0))) AvgRadioFPeriod,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0))/3600 TCHLoadTrafficExcludeHo,
sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.ConVoc_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0)) TCHRadioFNum,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscFO_HoFNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.v_TgtBscRC_HoFNum,0)
+nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoFNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscFO_HoFNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.v_SrcBscRC_HoFNum,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)) cs_TchReqNumHardho,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum,0)
+nvl(a.CON_HoExtInterruptNum,0)) cs_TchSuccNumHardho,
round(sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscFO_HoFNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.v_TgtBscRC_HoFNum,0)
+nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoFNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscFO_HoFNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.v_SrcBscRC_HoFNum,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)
-nvl(a.v_TgtBscFREQ_HoSNum,0)
-nvl(a.v_TgtBscFO_HoSNum,0)
-nvl(a.v_TgtBscRC_HoSNum,0)
-nvl(a.v_SrcBscFREQ_HoSNum,0)
-nvl(a.v_SrcBscFO_HoSNum,0)
-nvl(a.v_SrcBscRC_HoSNum,0)
-nvl(a.VOC_HoAddSuccessNum,0)
-nvl(a.VOC_HoExtInterruptNum,0)
-nvl(a.CON_HoAddSuccessNum,0)
-nvl(a.CON_HoExtInterruptNum,0))/
decode(sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscFO_HoFNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.v_TgtBscRC_HoFNum,0)
+nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoFNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscFO_HoFNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.v_SrcBscRC_HoFNum,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)),0,1,null,1,sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscFO_HoFNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.v_TgtBscRC_HoFNum,0)
+nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoFNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscFO_HoFNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.v_SrcBscRC_HoFNum,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)))*100,4) cs_CallBlockFailRateHardho,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_dest,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)) cs_TchReqNumsoftho,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum,0))  cs_TchSuccNumsoftho,
round(sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_dest,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
-nvl(a.v_TgtBscSoftAdd_HoSNum,0)
-nvl(a.v_TgtBscSofterAdd_HoSNum,0)
-nvl(a.v_InterBscHo_HoSNum_source,0)
-nvl(a.v_SrcBscSoftAdd_HoSNum,0)
-nvl(a.v_SrcBscSofterAdd_HoSNum,0)
-nvl(a.v_InterBscHo_HoSNum_source,0))/
decode(sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_dest,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)),0,1,null,1,sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_dest,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)))*100,4)  cs_CallBlockFailRatesoftho,
sum(nvl(a.p_TgtBscFREQ_HoSNum,0)
+nvl(a.p_TgtBscFREQ_HoFNum,0)
+nvl(a.p_TgtBscFO_HoSNum  ,0)
+nvl(a.p_TgtBscFO_HoFNum  ,0)
+nvl(a.p_TgtBscRC_HoSNum  ,0)
+nvl(a.p_TgtBscRC_HoFNum  ,0)
+nvl(a.p_SrcBscFREQ_HoSNum,0)
+nvl(a.p_SrcBscFREQ_HoFNum,0)
+nvl(a.p_SrcBscFO_HoSNum  ,0)
+nvl(a.p_SrcBscFO_HoFNum  ,0)
+nvl(a.p_SrcBscRC_HoSNum  ,0)
+nvl(a.p_SrcBscRC_HoFNum  ,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0))  ps_TchReqNumHardho,
sum(nvl(a.p_TgtBscFREQ_HoSNum  ,0)
+nvl(a.p_TgtBscFO_HoSNum    ,0)
+nvl(a.p_TgtBscRC_HoSNum    ,0)
+nvl(a.p_SrcBscFREQ_HoSNum  ,0)
+nvl(a.p_SrcBscFO_HoSNum    ,0)
+nvl(a.p_SrcBscRC_HoSNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)) ps_TchSuccNumHardho,
sum(nvl(a.p_TgtBscSoftAdd_HoSNum,0)
+nvl(a.p_TgtBscSoftAdd_HoFNum   ,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum ,0)
+nvl(a.p_TgtBscSofterAdd_HoFNum ,0)
+nvl(a.InterBscHo_HoSNum_dest   ,0)
+nvl(a.InterBscHo_HoFNum        ,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum   ,0)
+nvl(a.p_SrcBscSoftAdd_HoFNum   ,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum ,0)
+nvl(a.p_SrcBscSofterAdd_HoFNum ,0)
+nvl(a.p_InterBscHo_HoSNum      ,0)
+nvl(a.p_InterBscHo_HoFNum,0)) ps_TchReqNumsoftho,
sum(nvl(a.p_TgtBscSoftAdd_HoSNum,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.InterBscHo_HoSNum_dest,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum,0)
+nvl(a.p_InterBscHo_HoSNum,0)) ps_TchSuccNumsoftho,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum       ,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscFO_HoFNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoFNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFREQ_HoFNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscFO_HoFNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoFNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.VOC_HoBlockFailureNum     ,0)
+nvl(a.VOC_HoOtherFailureNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.CON_HoBlockFailureNum     ,0)
+nvl(a.CON_HoOtherFailureNum     ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum    ,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_InterBscHo_HoFNum_dest  ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0) ) cs_HandoffReqNum,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0))  cs_HandoffSuccNum,
round(sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0))/
decode(sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum       ,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscFO_HoFNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoFNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFREQ_HoFNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscFO_HoFNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoFNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.VOC_HoBlockFailureNum     ,0)
+nvl(a.VOC_HoOtherFailureNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.CON_HoBlockFailureNum     ,0)
+nvl(a.CON_HoOtherFailureNum     ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum    ,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_InterBscHo_HoFNum_dest  ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)),0,1,null,1,sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum       ,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscFO_HoFNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoFNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFREQ_HoFNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscFO_HoFNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoFNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.VOC_HoBlockFailureNum     ,0)
+nvl(a.VOC_HoOtherFailureNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.CON_HoBlockFailureNum     ,0)
+nvl(a.CON_HoOtherFailureNum     ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum    ,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_InterBscHo_HoFNum_dest  ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)))*100,4) cs_HandoffSuccRate,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)) cs_HardhoSuccNum,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum  ,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscFO_HoFNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoFNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFREQ_HoFNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscFO_HoFNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoFNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)) cs_HardhoReqNum,
--modify-2011-10-27
case when sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum  ,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscFO_HoFNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoFNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFREQ_HoFNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscFO_HoFNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoFNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)) is null then 100
when sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum  ,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscFO_HoFNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoFNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFREQ_HoFNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscFO_HoFNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoFNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)) = 0 then 100
else round(sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.VOC_HoAddSuccessNum,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum,0)
+nvl(a.CON_HoExtInterruptNum,0))/
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum  ,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscFO_HoFNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoFNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFREQ_HoFNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscFO_HoFNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoFNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0))*100,4)
end                                    cs_HardhoSuccRate,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum    ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_InterBscHo_HoFNum_dest  ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum    ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)) cs_SofthoReqNum,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)) cs_SofthoSuccNum,
sum(nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)) cs_SSofthoReqNum,
sum(nvl(a.v_TgtBscSofterAdd_HoSNum,0)+nvl(a.v_SrcBscSofterAdd_HoSNum,0)) cs_SSofthoSuccNum,
round(sum(nvl(a.v_TgtBscSofterAdd_HoSNum,0)+nvl(a.v_SrcBscSofterAdd_HoSNum,0))/
decode(sum(nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)),0,1,null,1,sum(nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)))*100,4) cs_SSofthoSuccRate,
sum(nvl(a.p_TgtBscFREQ_HoSNum  ,0)
+nvl(a.p_TgtBscFREQ_HoFNum  ,0)
+nvl(a.p_TgtBscFO_HoSNum    ,0)
+nvl(a.p_TgtBscFO_HoFNum    ,0)
+nvl(a.p_TgtBscRC_HoSNum    ,0)
+nvl(a.p_TgtBscRC_HoFNum    ,0)
+nvl(a.p_SrcBscFREQ_HoSNum  ,0)
+nvl(a.p_SrcBscFREQ_HoFNum  ,0)
+nvl(a.p_SrcBscFO_HoSNum    ,0)
+nvl(a.p_SrcBscFO_HoFNum    ,0)
+nvl(a.p_SrcBscRC_HoSNum    ,0)
+nvl(a.p_SrcBscRC_HoFNum    ,0)
+nvl(a.data_HoAddSuccessNum  ,0)
+nvl(a.data_HoExtInterruptNum,0)
+nvl(a.data_HoBlockFailureNum,0)
+nvl(a.data_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)) ps_HardhoReqNum,
sum(nvl(a.p_TgtBscFREQ_HoSNum,0)
+nvl(a.p_TgtBscFO_HoSNum    ,0)
+nvl(a.p_TgtBscRC_HoSNum    ,0)
+nvl(a.p_SrcBscFREQ_HoSNum  ,0)
+nvl(a.p_SrcBscFO_HoSNum    ,0)
+nvl(a.p_SrcBscRC_HoSNum    ,0)
+nvl(a.data_HoAddSuccessNum  ,0)
+nvl(a.data_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)) ps_HardhoSuccNum,
sum(nvl(a.p_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.p_TgtBscSoftAdd_HoFNum  ,0)
+nvl(a.InterBscHo_HoSNum_dest,0)
+nvl(a.InterBscHo_HoFNum       ,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum  ,0)
+nvl(a.p_SrcBscSoftAdd_HoFNum  ,0)
+nvl(a.p_InterBscHo_HoSNum     ,0)
+nvl(a.p_InterBscHo_HoFNum     ,0)) ps_SofthoReqNum,
sum(nvl(a.p_TgtBscSoftAdd_HoSNum,0)
+nvl(a.InterBscHo_HoSNum_dest,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum  ,0)
+nvl(a.p_InterBscHo_HoSNum     ,0)) ps_SofthoSuccNum,
sum(nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_TgtBscSofterAdd_HoFNum,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum,0)
+nvl(a.p_SrcBscSofterAdd_HoFNum,0)) ps_SSofthoReqNum,
sum(nvl(a.p_TgtBscSofterAdd_HoSNum,0)+nvl(a.p_SrcBscSofterAdd_HoSNum,0)) ps_SSofthoSuccNum,
sum(nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoFNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscFO_HoFNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.v_SrcBscRC_HoFNum,0)
+nvl(a.p_SrcBscFREQ_HoSNum,0)
+nvl(a.p_SrcBscFREQ_HoFNum,0)
+nvl(a.p_SrcBscFO_HoSNum,0)
+nvl(a.p_SrcBscFO_HoFNum,0)
+nvl(a.p_SrcBscRC_HoSNum,0)
+nvl(a.p_SrcBscRC_HoFNum,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum,0)
+nvl(a.p_SrcBscSoftAdd_HoFNum,0)
+nvl(a.p_InterBscHo_HoSNum,0)
+nvl(a.p_InterBscHo_HoFNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum,0)
+nvl(a.p_SrcBscSofterAdd_HoFNum,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)) HandoffReqNum_intra,
--update-2011-9-14
sum(nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFO_HoSNum,0)
+nvl(a.v_SrcBscRC_HoSNum,0)
+nvl(a.p_SrcBscFREQ_HoSNum,0)
+nvl(a.p_SrcBscFO_HoSNum,0)
+nvl(a.p_SrcBscRC_HoSNum,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum,0)
+nvl(a.p_InterBscHo_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+ nvl(a.p_SrcBscSofterAdd_HoSNum,0)) HandoffSuccNum_intra,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum     ,0)
+nvl(a.v_TgtBscFO_HoSNum       ,0)
+nvl(a.v_TgtBscFO_HoFNum       ,0)
+nvl(a.v_TgtBscRC_HoSNum       ,0)
+nvl(a.v_TgtBscRC_HoFNum       ,0)
+nvl(a.VOC_HoAddSuccessNum     ,0)
+nvl(a.VOC_HoExtInterruptNum   ,0)
+nvl(a.VOC_HoBlockFailureNum   ,0)
+nvl(a.VOC_HoOtherFailureNum   ,0)
+nvl(a.CON_HoAddSuccessNum     ,0)
+nvl(a.CON_HoExtInterruptNum   ,0)
+nvl(a.CON_HoBlockFailureNum   ,0)
+nvl(a.CON_HoOtherFailureNum   ,0)
+nvl(a.p_TgtBscFREQ_HoSNum     ,0)
+nvl(a.p_TgtBscFREQ_HoFNum     ,0)
+nvl(a.p_TgtBscFO_HoSNum       ,0)
+nvl(a.p_TgtBscFO_HoFNum       ,0)
+nvl(a.p_TgtBscRC_HoSNum       ,0)
+nvl(a.p_TgtBscRC_HoFNum       ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum     ,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.p_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.p_TgtBscSoftAdd_HoFNum  ,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_TgtBscSofterAdd_HoFNum,0)
+nvl(a.p_InterBscHo_HoSNum     ,0)
+nvl(a.p_InterBscHo_HoFNum     ,0)) HandoffReqNum_Extra,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum,0)
+nvl(a.v_TgtBscRC_HoSNum,0)
+nvl(a.VOC_HoAddSuccessNum     ,0)
+nvl(a.VOC_HoExtInterruptNum   ,0)
+nvl(a.CON_HoAddSuccessNum     ,0)
+nvl(a.CON_HoExtInterruptNum   ,0)
+nvl(a.p_TgtBscFREQ_HoSNum     ,0)
+nvl(a.p_TgtBscFO_HoSNum       ,0)
+nvl(a.p_TgtBscRC_HoSNum       ,0)
+nvl(a.VOC_HoAddSuccessNum     ,0)
+nvl(a.VOC_HoExtInterruptNum   ,0)
+nvl(a.CON_HoAddSuccessNum     ,0)
+nvl(a.CON_HoExtInterruptNum   ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum,0)
+nvl(a.p_TgtBscSoftAdd_HoSNum,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_InterBscHo_HoSNum,0)) HandoffSuccNum_Extra,
sum(nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFREQ_HoFNum,0)
+nvl(a.v_SrcBscFO_HoSNum  ,0)
+nvl(a.v_SrcBscFO_HoFNum  ,0)
+nvl(a.v_SrcBscRC_HoSNum  ,0)
+nvl(a.v_SrcBscRC_HoFNum  ,0)
+nvl(a.p_SrcBscFREQ_HoSNum,0)
+nvl(a.p_SrcBscFREQ_HoFNum,0)
+nvl(a.p_SrcBscFO_HoSNum  ,0)
+nvl(a.p_SrcBscFO_HoFNum  ,0)
+nvl(a.p_SrcBscRC_HoSNum  ,0)
+nvl(a.p_SrcBscRC_HoFNum,0)) HardhoReqNum_intra,
sum(nvl(a.v_SrcBscFREQ_HoSNum,0)
+nvl(a.v_SrcBscFO_HoSNum  ,0)
+nvl(a.v_SrcBscRC_HoSNum  ,0)
+nvl(a.p_SrcBscFREQ_HoSNum,0)
+nvl(a.p_SrcBscFO_HoSNum  ,0)
+nvl(a.p_SrcBscRC_HoSNum,0)) HardhoSuccNum_intra,
sum(nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum   ,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum,0)
+nvl(a.p_SrcBscSoftAdd_HoFNum,0)
+nvl(a.p_InterBscHo_HoSNum   ,0)
+nvl(a.p_InterBscHo_HoFNum   ,0))  ShoReqNum_intra,
sum(nvl(a.v_SrcBscSoftAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum   ,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum,0)
+nvl(a.p_InterBscHo_HoSNum   ,0)) ShoSuccNum_intra,
sum(nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum,0)
+nvl(a.p_SrcBscSofterAdd_HoFNum,0))  SShoReqNum_intra,
sum(nvl(a.v_SrcBscSofterAdd_HoSNum,0)+nvl(a.p_SrcBscSofterAdd_HoSNum,0)) SShoSuccNum_intra,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum   ,0)
+nvl(a.v_TgtBscFO_HoSNum     ,0)
+nvl(a.v_TgtBscFO_HoFNum     ,0)
+nvl(a.v_TgtBscRC_HoSNum     ,0)
+nvl(a.v_TgtBscRC_HoFNum     ,0)
+nvl(a.VOC_HoAddSuccessNum   ,0)
+nvl(a.VOC_HoExtInterruptNum ,0)
+nvl(a.VOC_HoBlockFailureNum ,0)
+nvl(a.VOC_HoOtherFailureNum ,0)
+nvl(a.DATA_HoAddSuccessNum  ,0)
+nvl(a.DATA_HoExtInterruptNum,0)
+nvl(a.DATA_HoBlockFailureNum,0)
+nvl(a.DATA_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum   ,0)
+nvl(a.CON_HoExtInterruptNum ,0)
+nvl(a.CON_HoBlockFailureNum ,0)
+nvl(a.CON_HoOtherFailureNum ,0)
+nvl(a.p_TgtBscFREQ_HoSNum   ,0)
+nvl(a.p_TgtBscFREQ_HoFNum   ,0)
+nvl(a.p_TgtBscFO_HoSNum     ,0)
+nvl(a.p_TgtBscFO_HoFNum     ,0)
+nvl(a.p_TgtBscRC_HoSNum     ,0)
+nvl(a.p_TgtBscRC_HoFNum     ,0)) HardhoReqNum_Extra,
sum(nvl(a.v_TgtBscFREQ_HoSNum  ,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.p_TgtBscFREQ_HoSNum  ,0)
+nvl(a.p_TgtBscFO_HoSNum    ,0)
+nvl(a.p_TgtBscRC_HoSNum    ,0)) HardhoSuccNum_Extra,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum,0)
+nvl(a.v_InterBscHo_HoSNum     ,0)
+nvl(a.v_InterBscHo_HoFNum_dest,0)
+nvl(a.p_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.p_TgtBscSoftAdd_HoFNum  ,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_TgtBscSofterAdd_HoFNum,0)
+nvl(a.InterBscHo_HoSNum_dest  ,0)
+nvl(a.InterBscHo_HoFNum,0)) ShoReqNum_Extra,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum     ,0)
+nvl(a.p_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_InterBscHo_HoSNum,0)) ShoSuccNum_Extra,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum  ,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscFO_HoFNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoFNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFREQ_HoFNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscFO_HoFNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoFNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.VOC_HoBlockFailureNum,0)
+nvl(a.VOC_HoOtherFailureNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)
+nvl(a.CON_HoBlockFailureNum,0)
+nvl(a.CON_HoOtherFailureNum,0)) BtsSysHardHoReqNum,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum    ,0)
+nvl(a.v_TgtBscRC_HoSNum    ,0)
+nvl(a.v_SrcBscFREQ_HoSNum  ,0)
+nvl(a.v_SrcBscFO_HoSNum    ,0)
+nvl(a.v_SrcBscRC_HoSNum    ,0)
+nvl(a.VOC_HoAddSuccessNum  ,0)
+nvl(a.VOC_HoExtInterruptNum,0)
+nvl(a.CON_HoAddSuccessNum  ,0)
+nvl(a.CON_HoExtInterruptNum,0)) BtsSysHardHoSuccNum,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_InterBscHo_HoFNum_dest  ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)) SysSHoReqNum,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum     ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)) SysSHoSuccNum,
sum(nvl(a.v_CEBlockNum_carrier,0)
+nvl(a.v_CEBlockNum_carrier      ,0)
+nvl(a.v_CHBlockNum_carrier      ,0)
+nvl(a.v_CHBlockNum_carrier      ,0)
+nvl(a.v_FPWBlockNum_carrier     ,0)
+nvl(a.v_FPWBlockNum_carrier     ,0)
+nvl(a.v_FOBlockNum_carrier      ,0)
+nvl(a.v_FOBlockNum_carrier      ,0)
+nvl(a.v_AbiscBlockNum_l3_carrier,0)
+nvl(a.v_AbiscBlockNum_carrier   ,0)
+nvl(a.p_CEBlockNum      ,0)
+nvl(a.p_CEBlockNum      ,0)
+nvl(a.p_CHBlockNum      ,0)
+nvl(a.p_CHBlockNum      ,0)
+nvl(a.p_FPWBlockNum     ,0)
+nvl(a.p_FPWBlockNum_l3  ,0)
+nvl(a.p_FOBlockNum      ,0)
+nvl(a.p_FOBlockNum_l3   ,0)
+nvl(a.p_AbiscBlockNum   ,0)
+nvl(a.p_AbiscBlockNum_l3,0)) CallBlockFailNum,
sum(nvl(a.v_CEBlockNum_carrier,0)
+nvl(a.v_CEBlockNum_l3_carrier,0)
+nvl(a.v_CHBlockNum_carrier,0)
+nvl(a.v_CHBlockNum_l3_carrier,0)
+nvl(a.v_FPWBlockNum_carrier,0)
+nvl(a.v_FPWBlockNum_l3_carrier,0)
+nvl(a.v_FOBlockNum_carrier,0)
+nvl(a.v_FOBlockNum_l3_carrier,0)
+nvl(a.v_AbiscBlockNum_carrier,0)
+nvl(a.v_AbiscBlockNum_l3_carrier,0)) cs_CallBlockFailNum,
sum(nvl(a.p_CEBlockNum,0)
+nvl(a.p_CEBlockNum_l3,0)
+nvl(a.p_CHBlockNum,0)
+nvl(a.p_CHBlockNum_l3,0)
+nvl(a.p_FPWBlockNum,0)
+nvl(a.p_FPWBlockNum_l3,0)
+nvl(a.p_FOBlockNum,0)
+nvl(a.p_FOBlockNum_l3,0)
+nvl(a.p_AbiscBlockNum,0)
+nvl(a.p_AbiscBlockNum_l3,0)) ps_CallBlockFailNum,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(a.V_SSHoDuration                ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.V_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur   ,0)
+nvl(a.V_SSHoDuration,0))/ 3600
+ sum(nvl(a.P_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur  ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur   ,0)
+nvl(a.p_SHoDuration                ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur  ,0)
+nvl(a.P_SSHoDuration,0))/ 3600 TrafficIncludeHo,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur  ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur   ,0)
+nvl(a.V_SHoDuration,0)) / 3600 cs_TrafficIncludeHo,
sum(nvl(a.V_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.V_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur  ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur   ,0)
+nvl(a.V_SHoDuration                ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.V_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur  ,0)
+nvl(a.V_SSHoDuration,0))/3600 cs_trafficByWalsh,
sum(nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.V_AvrAssCmp_AvfRlsReq_ShoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.V_SHoDuration               ,0))/3600 cs_SHOTraffic,
sum(nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.V_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur  ,0)
+nvl(a.V_SSHoDuration               ,0))/3600 cs_SSHOTraffic,
sum(nvl(a.P_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur  ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur   ,0)
+nvl(a.p_SHoDuration,0)) / 3600  ps_CallTrafficIncludeHo,
sum(nvl(a.P_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.P_SHoDuration,0)
+nvl(a.P_SSHoDuration,0))/3600 ps_trafficByWalsh,
sum(nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.P_SHoDuration,0))/3600    ps_SHOTraffic,
sum(nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.P_SSHoDuration,0))/3600   ps_SSHOTraffic,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(a.v_SHoDuration                ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.V_AvfRlsReq_KilPrc_CallDur,0)
+nvl(a.AvfRlsReq_KilPrc_CallDur,0)
+nvl(a.sm_AvfRlsReq_KilPrc_CallDur,0)
+nvl(a.V_AvfRlsReq_KilPrc_ShoDur,0)
+nvl(a.sm_AvfRlsReq_KilPrc_ShoDur,0)
+nvl(a.AvfRlsReq_KilPrc_ShoDur,0))/3600 TCHLoadTrafficIncludeHo,
sum(nvl(a.AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SShoDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_SShoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.P_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.P_SHoDuration,0)
+nvl(a.P_SSHoDuration,0)
+nvl(a.v_SSHoDuration,0))/3600 LoadTrafficByWalsh,
sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum,0)
+nvl(a.v_CMO_BlockFailureNum,0)
+nvl(a.v_CMO_OtherFailureNum,0)
+nvl(a.v_AccProbe_CallSuccessNum,0)
+nvl(a.v_AccProbe_ExtInterruptNum ,0)
+nvl(a.v_AccProbe_BlockFailureNum ,0)
+nvl(a.v_AccProbe_OtherFailureNum ,0)
+nvl(a.v_AccHo_CallSuccessNum     ,0)
+nvl(a.v_AccHo_ExtInterruptNum    ,0)
+nvl(a.v_AccHo_BlockFailureNum    ,0)
+nvl(a.v_AccHo_OtherFailureNum    ,0)
+nvl(a.v_AssignSoft_CallSuccessNum,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)
+nvl(a.v_AssignSoft_BlockFailureNum,0)
+nvl(a.v_AssignSoft_OtherFailureNum,0)
+nvl(a.v_CallSuccessNum            ,0)
+nvl(a.v_ExtInterruptNum           ,0)
+nvl(a.v_BlockFailureNum           ,0)
+nvl(a.v_OtherFailureNum,0)) TchReqNumCalleeExcludeHoSms,
sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum       ,0)
+nvl(a.v_AccProbe_CallSuccessNum   ,0)
+nvl(a.v_AccProbe_ExtInterruptNum  ,0)
+nvl(a.v_AccHo_CallSuccessNum      ,0)
+nvl(a.v_AccHo_ExtInterruptNum     ,0)
+nvl(a.v_AssignSoft_CallSuccessNum ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)
+nvl(a.v_CallSuccessNum            ,0)
+nvl(a.v_ExtInterruptNum,0)) TchSuccNumCalleeExcludeHoSms,
sum(nvl(a.v_PageResponceNum,0)
+nvl(a.v_MSOriginateNum,0)) cs_CallPageReqNum_a,
sum(nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_CallSuccessNum,0)
+nvl(a.v_ExtInterruptNum,0)) cs_CallPageSuccNum_a,
sum(nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_CallSuccessNum,0)
+nvl(a.v_ExtInterruptNum,0)
+nvl(a.p_CallSuccessNum_carrier,0)
+nvl(a.p_ExtInterruptNum_carrier,0))  TchSuccNumExcludeHo_a,
sum(nvl(a.p_CallSuccessNum_carrier,0)
+nvl(a.p_ExtInterruptNum_carrier,0)) ps_CallPageSuccNum_a,
sum(nvl(a.v_MSOriginateNum,0)) ps_CallPageReqNum_a,
sum(nvl(a.v_CMO_MSOriginateNum,0)
+nvl(a.v_AssignSoft_MSOriginateNum,0)
+nvl(a.sm_CMO_MSOrigNum           ,0)
+nvl(a.sm_AccProbe_MSOrigNum      ,0)
+nvl(a.sm_AccHo_MSOrigNum         ,0)
+nvl(a.sm_AssignSoft_MSOrigNum    ,0)) cs_CallPageReqNum_e,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c ,0)
+nvl(a.sm_CMO_CallSuccNum,0)
+nvl(a.sm_CMO_ExtInterruptNum_call,0)
+nvl(a.sm_AccProbe_CallSuccNum,0)
+nvl(a.sm_AccProbe_ExtInterruptNum_ca,0)
+nvl(a.sm_AccHo_CallSuccNum_call,0)
+nvl(a.sm_AccHo_ExtInterruptNum_call,0)
+nvl(a.sm_AssignSoft_CallSuccNum,0)
+nvl(a.sm_AssignSoft_ExtInterruptNumc,0)) cs_CallPageSuccNum_e  ,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.v_AssignSoft_BlockFailureNum_c,0)
+nvl(a.p_CMO_CallSuccessNum_call,0)
+nvl(a.p_CMO_ExtInterruptNum_call,0)
+nvl(a.p_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.p_AssignSoft_ExtInterruptNumc,0)) TchSuccNumExcludeHo_e,
sum(nvl(a.p_CMO_CallSuccessNum_call,0)
+nvl(a.p_CMO_ExtInterruptNum_call,0)
+nvl(a.p_AssignSoft_CallSuccessNum_ca ,0)
+nvl(a.p_AssignSoft_ExtInterruptNumc,0)) ps_CallPageSuccNum_e,
sum(nvl(a.p_CMO_MSOriginateNum,0)
+nvl(a.p_AssignSoft_MSOriginateNum ,0)) ps_CallPageReqNum_e,
sum(nvl(a.v_CMO_PageResponceNum,0)
+nvl(a.v_AssignSoft_PageResponceNum,0)
+nvl(a.sm_CMO_PageResponceNum,0)
+nvl(a.sm_AccProbe_PageResponceNum,0)
+nvl(a.sm_AccHo_PageResponceNum,0)
+nvl(a.sm_AssignSoft_PageResponceNum,0)) cs_CallPageReqNum_f,
sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum,0)
+nvl(a.v_AssignSoft_CallSuccessNum,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)
+nvl(a.sm_CMO_CallSuccessNum,0)
+nvl(a.sm_CMO_ExtInterruptNum,0)
+nvl(a.sm_AccProbe_CallSuccessNum,0)
+nvl(a.sm_AccProbe_ExtInterruptNum,0)
+nvl(a.sm_AccHo_CallSuccessNum,0)
+nvl(a.sm_AccHo_ExtInterruptNum,0)
+nvl(a.sm_AssignSoft_CallSuccessNum,0)
+nvl(a.sm_AssignSoft_ExtInterruptNum,0)) cs_CallPageSuccNum_f,
sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum,0)
+nvl(a.v_AssignSoft_CallSuccessNum,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)
+nvl(a.p_CMO_CallSuccessNum,0)
+nvl(a.p_CMO_ExtInterruptNum,0)
+nvl(a.p_AssignSoft_CallSuccessNum,0)
+nvl(a.p_AssignSoft_ExtInterruptNum,0)
+nvl(a.p_CallSuccessNum_pag,0)
+nvl(a.p_ExtInterruptNum_pag,0)) TchSuccNumExcludeHo_f,
sum(nvl(a.p_CMO_CallSuccessNum,0)
+nvl(a.p_CMO_ExtInterruptNum       ,0)
+nvl(a.p_AssignSoft_CallSuccessNum ,0)
+nvl(a.p_AssignSoft_ExtInterruptNum,0)
+nvl(a.p_CallSuccessNum_pag            ,0)
+nvl(a.p_ExtInterruptNum_pag           ,0)) ps_CallPageSuccNum_f,
sum(nvl(a.p_CMO_PageResponceNum,0)
+nvl(a.p_AssignSoft_PageResponceNum,0)
+nvl(a.p_PageResponceNum,0)) ps_CallPageReqNum_f,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call        ,0)
+nvl(a.v_CMO_BlockFailureNum_call        ,0)
+nvl(a.v_CMO_OtherFailureNum_call        ,0)
+nvl(a.v_AccProbe_CallSuccessNum_call    ,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal   ,0)
+nvl(a.v_AccProbe_BlockFailureNum_cal   ,0)
+nvl(a.v_AccProbe_OtherFailureNum_cal   ,0)
+nvl(a.v_AccHo_CallSuccessNum_call       ,0)
+nvl(a.v_AccHo_ExtInterruptNum_call      ,0)
+nvl(a.v_AccHo_BlockFailureNum_call      ,0)
+nvl(a.v_AccHo_OtherFailureNum_call      ,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca  ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c ,0)
+nvl(a.v_AssignSoft_BlockFailureNum_c ,0)
+nvl(a.v_AssignSoft_OtherFailureNum_c ,0)
+nvl(a.sm_CMO_CallSuccNum           ,0)
+nvl(a.sm_CMO_ExtInterruptNum_call       ,0)
+nvl(a.sm_CMO_BlockFailNum          ,0)
+nvl(a.sm_CMO_OtherFailNum          ,0)
+nvl(a.sm_AccProbe_CallSuccNum      ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum_ca  ,0)
+nvl(a.Sm_AccProbe_BlockFailureNum_ca  ,0)
+nvl(a.Sm_AccProbe_OtherFailureNum_ca  ,0)
+nvl(a.sm_AccHo_CallSuccNum_call         ,0)
+nvl(a.sm_AccHo_ExtInterruptNum_call     ,0)
+nvl(a.Sm_AccHo_BlockFailureNum_call     ,0)
+nvl(a.Sm_AccHo_OtherFailureNum_call     ,0)
+nvl(a.sm_AssignSoft_CallSuccNum    ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNumc,0)
+nvl(a.sm_AssignSoft_BlockFailNum   ,0)
+nvl(a.sm_AssignSoft_OtherFailNum   ,0)
+nvl(a.v_CallSuccessNum_orig        ,0)
+nvl(a.v_ExtInterruptNum_orig       ,0)
+nvl(a.v_BlockFailureNum_orig       ,0)
+nvl(a.v_OtherFailureNum_orig       ,0)
+nvl(a.v_CallSuccessNum             ,0)
+nvl(a.v_ExtInterruptNum            ,0)
+nvl(a.v_BlockFailureNum            ,0)
+nvl(a.v_OtherFailureNum            ,0)
+nvl(a.v_CMO_CallSuccessNum         ,0)
+nvl(a.v_CMO_ExtInterruptNum        ,0)
+nvl(a.v_CMO_BlockFailureNum        ,0)
+nvl(a.v_CMO_OtherFailureNum        ,0)
+nvl(a.v_AccProbe_CallSuccessNum    ,0)
+nvl(a.v_AccProbe_ExtInterruptNum   ,0)
+nvl(a.v_AccProbe_BlockFailureNum   ,0)
+nvl(a.v_AccProbe_OtherFailureNum   ,0)
+nvl(a.v_AccHo_CallSuccessNum       ,0)
+nvl(a.v_AccHo_ExtInterruptNum      ,0)
+nvl(a.v_AccHo_BlockFailureNum      ,0)
+nvl(a.v_AccHo_OtherFailureNum      ,0)
+nvl(a.v_AssignSoft_CallSuccessNum  ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum ,0)
+nvl(a.v_AssignSoft_BlockFailureNum ,0)
+nvl(a.v_AssignSoft_OtherFailureNum ,0)
+nvl(a.sm_CMO_CallSuccessNum        ,0)
+nvl(a.sm_CMO_ExtInterruptNum       ,0)
+nvl(a.sm_CMO_BlockFailureNum       ,0)
+nvl(a.sm_CMO_OtherFailureNum       ,0)
+nvl(a.sm_AccProbe_CallSuccessNum   ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum  ,0)
+nvl(a.sm_AccProbe_BlockFailureNum  ,0)
+nvl(a.sm_AccProbe_OtherFailureNum  ,0)
+nvl(a.sm_AccHo_CallSuccessNum      ,0)
+nvl(a.sm_AccHo_ExtInterruptNum     ,0)
+nvl(a.sm_AccHo_BlockFailureNum     ,0)
+nvl(a.sm_AccHo_OtherFailureNum     ,0)
+nvl(a.sm_AssignSoft_CallSuccessNum ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNum,0)
+nvl(a.sm_AssignSoft_BlockFailureNum,0)
+nvl(a.sm_AssignSoft_OtherFailureNum,0)) TchReqNumExcludeHoSms,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_CMO_BlockFailureNum_call,0)
+nvl(a.v_CMO_OtherFailureNum_call,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)
+nvl(a.v_AssignSoft_BlockFailureNum_c,0)
+nvl(a.v_AssignSoft_OtherFailureNum_c,0)
+nvl(a.v_AccProbe_CallSuccessNum_call,0)
+nvl(a.V_AccProbe_ExtInvalidCallNum_c,0)
+nvl(a.v_AccProbe_BlockFailureNum_cal,0)
+nvl(a.v_AccProbe_OtherFailureNum_cal,0)
+nvl(a.v_AccHo_CallSuccessNum_call,0)
+nvl(a.V_AccHo_ExtInvalidCallNum_call,0)
+nvl(a.v_AccHo_BlockFailureNum_call,0)
+nvl(a.v_AccHo_OtherFailureNum_call,0)
+nvl(a.sm_CMO_CallSuccNum,0)
+nvl(a.sm_CMO_ExtInterruptNum_call,0)
+nvl(a.sm_CMO_BlockFailNum,0)
+nvl(a.sm_CMO_OtherFailNum,0)
+nvl(a.sm_AccProbe_CallSuccNum,0)
+nvl(a.sm_AccProbe_ExtInterruptNum_ca,0)
+nvl(a.Sm_AccProbe_BlockFailureNum_ca,0)
+nvl(a.Sm_AccProbe_OtherFailureNum_ca,0)
+nvl(a.sm_AccHo_CallSuccNum_call,0)
+nvl(a.sm_AccHo_ExtInterruptNum_call,0)
+nvl(a.Sm_AccHo_BlockFailureNum_call,0)
+nvl(a.Sm_AccHo_OtherFailureNum_call,0)
+nvl(a.sm_AssignSoft_CallSuccNum,0)
+nvl(a.sm_AssignSoft_ExtInterruptNumc,0)
+nvl(a.sm_AssignSoft_BlockFailNum,0)
+nvl(a.sm_AssignSoft_OtherFailNum,0)
+nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_BlockFailureNum_orig,0)
+nvl(a.v_OtherFailureNum_orig,0)
+nvl(a.v_CallSuccessNum,0)
+nvl(a.v_ExtInterruptNum,0)
+nvl(a.v_BlockFailureNum,0)
+nvl(a.v_OtherFailureNum,0)
+nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum,0)
+nvl(a.v_CMO_BlockFailureNum,0)
+nvl(a.v_CMO_OtherFailureNum,0)
+nvl(a.v_AssignSoft_CallSuccessNum,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)
+nvl(a.v_AssignSoft_BlockFailureNum,0)
+nvl(a.v_AssignSoft_OtherFailureNum,0)
+nvl(a.V_AccProbe_CallSuccessNum,0)
+nvl(a.V_AccProbe_ExtInvalidCallNum,0)
+nvl(a.V_AccProbe_BlockFailureNum,0)
+nvl(a.V_AccProbe_OtherFailureNum,0)
+nvl(a.V_AccHo_CallSuccessNum,0)
+nvl(a.V_AccHo_ExtInterruptNum,0)
+nvl(a.V_AccHo_BlockFailureNum,0)
+nvl(a.V_AccHo_OtherFailureNum,0)
+nvl(a.sm_CMO_CallSuccessNum,0)
+nvl(a.sm_CMO_ExtInterruptNum,0)
+nvl(a.sm_CMO_BlockFailureNum,0)
+nvl(a.sm_CMO_OtherFailureNum,0)
+nvl(a.sm_AccProbe_CallSuccessNum,0)
+nvl(a.sm_AccProbe_ExtInterruptNum,0)
+nvl(a.sm_AccProbe_BlockFailureNum,0)
+nvl(a.sm_AccProbe_OtherFailureNum,0)
+nvl(a.sm_AccHo_CallSuccessNum,0)
+nvl(a.sm_AccHo_ExtInterruptNum,0)
+nvl(a.sm_AccHo_BlockFailureNum,0)
+nvl(a.sm_AccHo_OtherFailureNum,0)
+nvl(a.sm_AssignSoft_CallSuccessNum,0)
+nvl(a.sm_AssignSoft_ExtInterruptNum,0)
+nvl(a.sm_AssignSoft_BlockFailureNum,0)
+nvl(a.sm_AssignSoft_OtherFailureNum,0))  CallPageReqTotalNum,
-------------------------------------
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_CMO_BlockFailureNum_call,0)
+nvl(a.v_CMO_OtherFailureNum_call,0)
+nvl(a.v_AccProbe_CallSuccessNum_call,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal,0)
+nvl(a.v_AccProbe_BlockFailureNum_cal,0)
+nvl(a.v_AccProbe_OtherFailureNum_cal,0)
+nvl(a.v_AccHo_CallSuccessNum_call,0)
+nvl(a.v_AccHo_ExtInterruptNum_call,0)
+nvl(a.v_AccHo_BlockFailureNum_call,0)
+nvl(a.v_AccHo_OtherFailureNum_call,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)
+nvl(a.v_AssignSoft_BlockFailureNum_c,0)
+nvl(a.v_AssignSoft_OtherFailureNum_c,0)
+nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_BlockFailureNum_orig,0)
+nvl(a.v_OtherFailureNum_orig,0)) TchReqNumCallerExcludeHoSms,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_AccProbe_CallSuccessNum_call,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal,0)
+nvl(a.v_AccHo_CallSuccessNum_call,0)
+nvl(a.v_AccHo_ExtInterruptNum_call,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)
+nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum,0)) TchSuccNumCallerExcludeHoSms,
sum(nvl(a.v_MSOriginateNum,0)
+nvl(a.v_PageResponceNum,0)) cs_TchReqNumExcludeHo_a,
sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.ConVoc_RlsFailNum,0)
+nvl(a.ConVocData_RlsFailNum,0)) TchRadioFRate_up,
sum(nvl(a.v_CallSuccessNum,0)
+nvl(a.v_ExtInterruptNum,0)
+nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)) TchRadioFRate_down_a,
sum(nvl(a.p_MSOriginateNum,0)) ps_TchReqNumExcludeHo_a,
sum(nvl(a.v_CallSuccessNum,0)
+nvl(a.v_ExtInterruptNum,0)
+nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)) cs_TchSuccNumExcludeHo_a,
sum(nvl(a.p_CallSuccessNum_carrier,0)
+nvl(a.p_ExtInterruptNum_carrier,0)) ps_TchSuccNumExcludeHo_a,
sum(nvl(a.v_CallSuccessNum       ,0)
+nvl(a.v_ExtInterruptNum         ,0)
+nvl(a.v_CallSuccessNum_orig     ,0)
+nvl(a.v_ExtInterruptNum_orig    ,0)) TchSuccNumExcludeHoSms_a,
sum(nvl(a.v_CMO_MSOriginateNum,0)
+nvl(a.v_AssignSoft_MSOriginateNum,0)) cs_TchReqNumExcludeHo_e,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call       ,0)
+nvl(a.v_AccProbe_CallSuccessNum_call   ,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal  ,0)
+nvl(a.v_AccHo_CallSuccessNum_call      ,0)
+nvl(a.v_AccHo_ExtInterruptNum_call     ,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)) TchRadioFRate_down_e,
sum(nvl(a.p_CMO_MSOriginateNum,0)
+nvl(a.p_AssignSoft_MSOriginateNum ,0)) ps_TchReqNumExcludeHo_e,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_AssignSoft_BlockFailureNum_c,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)) cs_TchSuccNumExcludeHo_e,
sum(nvl(a.p_CMO_CallSuccessNum_call,0)
+nvl(a.p_CMO_ExtInterruptNum_call,0)
+nvl(a.p_AssignSoft_CallSuccessNum_ca ,0)
+nvl(a.p_AssignSoft_ExtInterruptNumc,0)) ps_TchSuccNumExcludeHo_e,
sum(nvl(a.sm_CMO_CallSuccNum         ,0)
+nvl(a.sm_CMO_ExtInterruptNum_call        ,0)
+nvl(a.sm_AccProbe_CallSuccNum       ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum_ca,0)
+nvl(a.sm_AccHo_CallSuccNum_call,0)
+nvl(a.sm_AccHo_ExtInterruptNum_call  ,0)
+nvl(a.sm_AssignSoft_CallSuccNum     ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNumc ,0)
+nvl(a.v_CMO_CallSuccessNum_ms_call       ,0)
+nvl(a.v_CMO_ExtInterruptNum_call         ,0)
+nvl(a.v_AccProbe_CallSuccessNum_call     ,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal    ,0)
+nvl(a.v_AccHo_CallSuccessNum_call        ,0)
+nvl(a.v_AccHo_ExtInterruptNum_call       ,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca   ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c  ,0)) TchSuccNumExcludeHoSms_e,
sum(nvl(a.v_CMO_PageResponceNum,0)
+nvl(a.v_AssignSoft_PageResponceNum,0)) cs_TchReqNumExcludeHo_f,
sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum,0)
+nvl(a.v_AccProbe_CallSuccessNum,0)
+nvl(a.v_AccProbe_ExtInterruptNum,0)
+nvl(a.v_AccHo_CallSuccessNum,0)
+nvl(a.v_AccHo_ExtInterruptNum,0)
+nvl(a.v_AssignSoft_CallSuccessNum,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)) TchRadioFRate_down_f,
sum(nvl(a.p_CMO_PageResponceNum,0)
+nvl(a.p_AssignSoft_PageResponceNum,0)
+nvl(a.p_PageResponceNum,0)) ps_TchReqNumExcludeHo_f,
sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum,0)
+nvl(a.v_AssignSoft_CallSuccessNum ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)) cs_TchSuccNumExcludeHo_f,
sum(nvl(a.p_CMO_CallSuccessNum,0)
+nvl(a.p_CMO_ExtInterruptNum,0)
+nvl(a.p_AssignSoft_CallSuccessNum ,0)
+nvl(a.p_AssignSoft_ExtInterruptNum,0)
+nvl(a.p_CallSuccessNum_pag,0)
+nvl(a.p_ExtInterruptNum_pag,0)) ps_TchSuccNumExcludeHo_f,
sum(nvl(a.v_CMO_CallSuccessNum        ,0)
+nvl(a.v_CMO_ExtInterruptNum          ,0)
+nvl(a.v_AccProbe_CallSuccessNum      ,0)
+nvl(a.v_AccProbe_ExtInterruptNum     ,0)
+nvl(a.v_AccHo_CallSuccessNum         ,0)
+nvl(a.v_AccHo_ExtInterruptNum        ,0)
+nvl(a.v_AssignSoft_CallSuccessNum    ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum   ,0)
+nvl(a.sm_CMO_CallSuccessNum          ,0)
+nvl(a.sm_CMO_ExtInterruptNum         ,0)
+nvl(a.sm_AccProbe_CallSuccessNum     ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum    ,0)
+nvl(a.sm_AccHo_CallSuccessNum        ,0)
+nvl(a.sm_AccHo_ExtInterruptNum       ,0)
+nvl(a.sm_AssignSoft_CallSuccessNum   ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNum  ,0)) TchSuccNumExcludeHoSms_f,
sum(nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_CallSuccessNum,0)
+nvl(a.v_ExtInterruptNum,0)) cs_TchSuccNumIncludeHo_a,
sum(nvl(a.v_MSOriginateNum,0)) ps_TchReqNumIncludeHo_a,
sum(nvl(a.v_MSOriginateNum,0)+nvl(a.v_PageResponceNum,0)) cs_TchReqNumIncludeHo_a,
sum(nvl(a.p_CallSuccessNum_carrier,0)
+nvl(a.p_ExtInterruptNum_carrier,0)) ps_TchSuccNumIncludeHo_a,
sum(nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_BlockFailureNum_orig,0)
+nvl(a.v_OtherFailureNum_orig,0)
+nvl(a.v_CallSuccessNum      ,0)
+nvl(a.v_ExtInterruptNum     ,0)
+nvl(a.v_BlockFailureNum     ,0)
+nvl(a.v_OtherFailureNum     ,0)) TchReqNumIncludeHoSms_a,
sum(nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum_orig,0)
+nvl(a.v_CallSuccessNum     ,0)
+nvl(a.v_ExtInterruptNum    ,0)) TchSuccNumIncludeHoSms_a,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum        ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum    ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)) cs_TchSuccNumIncludeHo_b,
sum(nvl(a.p_TgtBscFREQ_HoSNum,0)
+nvl(a.p_TgtBscFREQ_HoFNum     ,0)
+nvl(a.p_TgtBscFO_HoSNum       ,0)
+nvl(a.p_TgtBscFO_HoFNum       ,0)
+nvl(a.p_TgtBscRC_HoSNum       ,0)
+nvl(a.p_TgtBscRC_HoFNum       ,0)
+nvl(a.p_SrcBscFREQ_HoSNum     ,0)
+nvl(a.p_SrcBscFREQ_HoFNum     ,0)
+nvl(a.p_SrcBscFO_HoSNum       ,0)
+nvl(a.p_SrcBscFO_HoFNum       ,0)
+nvl(a.p_SrcBscRC_HoSNum       ,0)
+nvl(a.p_SrcBscRC_HoFNum       ,0)
+nvl(a.VOC_HoAddSuccessNum     ,0)
+nvl(a.VOC_HoExtInterruptNum   ,0)
+nvl(a.VOC_HoBlockFailureNum   ,0)
+nvl(a.VOC_HoOtherFailureNum   ,0)
+nvl(a.CON_HoAddSuccessNum     ,0)
+nvl(a.CON_HoExtInterruptNum   ,0)
+nvl(a.CON_HoBlockFailureNum   ,0)
+nvl(a.CON_HoOtherFailureNum   ,0)
+nvl(a.p_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.p_TgtBscSoftAdd_HoFNum  ,0)
+nvl(a.InterBscHo_HoSNum_dest,0)
+nvl(a.InterBscHo_HoFNum       ,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum  ,0)
+nvl(a.p_SrcBscSoftAdd_HoFNum  ,0)
+nvl(a.p_InterBscHo_HoSNum     ,0)
+nvl(a.p_InterBscHo_HoFNum     ,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_TgtBscSofterAdd_HoFNum,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum,0)
+nvl(a.p_SrcBscSofterAdd_HoFNum,0)) ps_TchReqNumIncludeHo_b,
sum(nvl(a.v_TgtBscFREQ_HoSNum,0)
+nvl(a.v_TgtBscFREQ_HoFNum         ,0)
+nvl(a.v_TgtBscFO_HoSNum           ,0)
+nvl(a.v_TgtBscFO_HoFNum           ,0)
+nvl(a.v_TgtBscRC_HoSNum           ,0)
+nvl(a.v_TgtBscRC_HoFNum           ,0)
+nvl(a.v_SrcBscFREQ_HoSNum         ,0)
+nvl(a.v_SrcBscFREQ_HoFNum         ,0)
+nvl(a.v_SrcBscFO_HoSNum           ,0)
+nvl(a.v_SrcBscFO_HoFNum           ,0)
+nvl(a.v_SrcBscRC_HoSNum           ,0)
+nvl(a.v_SrcBscRC_HoFNum           ,0)
+nvl(a.VOC_HoAddSuccessNum         ,0)
+nvl(a.VOC_HoExtInterruptNum       ,0)
+nvl(a.VOC_HoBlockFailureNum       ,0)
+nvl(a.VOC_HoOtherFailureNum       ,0)
+nvl(a.CON_HoAddSuccessNum         ,0)
+nvl(a.CON_HoExtInterruptNum       ,0)
+nvl(a.CON_HoBlockFailureNum       ,0)
+nvl(a.CON_HoOtherFailureNum       ,0)
+nvl(a.v_TgtBscSoftAdd_HoSNum      ,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum      ,0)
+nvl(a.v_InterBscHo_HoSNum         ,0)
+nvl(a.v_InterBscHo_HoFNum_dest    ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum      ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum      ,0)
+nvl(a.v_InterBscHo_HoSNum_source  ,0)
+nvl(a.v_InterBscHo_HoFNum_source  ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum    ,0)) cs_TchReqNumIncludeHo_b,
sum(nvl(a.p_TgtBscFREQ_HoSNum,0)
+nvl(a.p_TgtBscFO_HoSNum       ,0)
+nvl(a.p_TgtBscRC_HoSNum       ,0)
+nvl(a.p_SrcBscFREQ_HoSNum     ,0)
+nvl(a.p_SrcBscFO_HoSNum       ,0)
+nvl(a.p_SrcBscRC_HoSNum       ,0)
+nvl(a.VOC_HoAddSuccessNum     ,0)
+nvl(a.VOC_HoExtInterruptNum   ,0)
+nvl(a.CON_HoAddSuccessNum     ,0)
+nvl(a.CON_HoExtInterruptNum   ,0)
+nvl(a.p_TgtBscSoftAdd_HoSNum  ,0)
+nvl(a.InterBscHo_HoSNum_dest,0)
+nvl(a.p_SrcBscSoftAdd_HoSNum  ,0)
+nvl(a.p_InterBscHo_HoSNum     ,0)
+nvl(a.p_TgtBscSofterAdd_HoSNum,0)
+nvl(a.p_SrcBscSofterAdd_HoSNum,0))  ps_TchSuccNumIncludeHo_b,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum,0)
+nvl(a.v_TgtBscSoftAdd_HoFNum    ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_TgtBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_InterBscHo_HoFNum_source      ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum   ,0)
+nvl(a.v_SrcBscSoftAdd_HoFNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_SrcBscSofterAdd_HoFNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_InterBscHo_HoFNum_source,0)
+nvl(a.v_TgtBscFREQ_HoSNum       ,0)
+nvl(a.v_TgtBscFREQ_HoFNum       ,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscFO_HoFNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoFNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFREQ_HoFNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscFO_HoFNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoFNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.VOC_HoBlockFailureNum     ,0)
+nvl(a.VOC_HoOtherFailureNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)
+nvl(a.CON_HoBlockFailureNum     ,0)
+nvl(a.CON_HoOtherFailureNum     ,0)) TchReqNumIncludeHoSms_b,
sum(nvl(a.v_TgtBscSoftAdd_HoSNum ,0)
+nvl(a.v_TgtBscSofterAdd_HoSNum  ,0)
+nvl(a.v_InterBscHo_HoSNum       ,0)
+nvl(a.v_SrcBscSoftAdd_HoSNum    ,0)
+nvl(a.v_SrcBscSofterAdd_HoSNum  ,0)
+nvl(a.v_InterBscHo_HoSNum_source,0)
+nvl(a.v_TgtBscFREQ_HoSNum       ,0)
+nvl(a.v_TgtBscFO_HoSNum         ,0)
+nvl(a.v_TgtBscRC_HoSNum         ,0)
+nvl(a.v_SrcBscFREQ_HoSNum       ,0)
+nvl(a.v_SrcBscFO_HoSNum         ,0)
+nvl(a.v_SrcBscRC_HoSNum         ,0)
+nvl(a.VOC_HoAddSuccessNum       ,0)
+nvl(a.VOC_HoExtInterruptNum     ,0)
+nvl(a.CON_HoAddSuccessNum       ,0)
+nvl(a.CON_HoExtInterruptNum     ,0)) TchSuccNumIncludeHoSms_b,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call       ,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)) cs_TchSuccNumIncludeHo_e,
sum(nvl(a.p_CMO_MSOriginateNum,0)
+nvl(a.p_AssignSoft_MSOriginateNum,0))  ps_TchReqNumIncludeHo_e,
sum(nvl(a.v_CMO_MSOriginateNum,0)
+nvl(a.v_AssignSoft_MSOriginateNum ,0)) cs_TchReqNumIncludeHo_e,
sum(nvl(a.p_CMO_CallSuccessNum_call,0)
+nvl(a.p_CMO_ExtInterruptNum_call       ,0)
+nvl(a.p_AssignSoft_CallSuccessNum_ca ,0)
+nvl(a.p_AssignSoft_ExtInterruptNumc,0)) ps_TchSuccNumIncludeHo_e,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call,0)
+nvl(a.v_CMO_ExtInterruptNum_call,0)
+nvl(a.v_CMO_BlockFailureNum_call,0)
+nvl(a.v_CMO_OtherFailureNum_call,0)
+nvl(a.v_AccProbe_CallSuccessNum_call,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal,0)
+nvl(a.v_AccProbe_BlockFailureNum_cal,0)
+nvl(a.v_AccProbe_OtherFailureNum_cal,0)
+nvl(a.v_AccHo_CallSuccessNum_call,0)
+nvl(a.v_AccHo_ExtInterruptNum_call,0)
+nvl(a.v_AccHo_BlockFailureNum_call,0)
+nvl(a.v_AccHo_OtherFailureNum_call,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c,0)
+nvl(a.v_AssignSoft_BlockFailureNum_c,0)
+nvl(a.v_AssignSoft_OtherFailureNum_c,0)
+nvl(a.sm_CMO_CallSuccNum,0)
+nvl(a.sm_CMO_ExtInterruptNum_call,0)
+nvl(a.sm_CMO_BlockFailNum,0)
+nvl(a.sm_CMO_OtherFailNum,0)
+nvl(a.sm_AccProbe_CallSuccNum,0)
+nvl(a.sm_AccProbe_ExtInterruptNum_ca,0)
+nvl(a.Sm_AccProbe_BlockFailureNum_ca,0)
+nvl(a.Sm_AccProbe_OtherFailureNum_ca,0)
+nvl(a.sm_AccHo_CallSuccNum_call,0)
+nvl(a.sm_AccHo_ExtInterruptNum_call,0)
+nvl(a.Sm_AccHo_BlockFailureNum_call,0)
+nvl(a.Sm_AccHo_OtherFailureNum_call,0)
+nvl(a.sm_AssignSoft_CallSuccNum,0)
+nvl(a.sm_AssignSoft_ExtInterruptNumc,0)
+nvl(a.sm_AssignSoft_BlockFailNum,0)
+nvl(a.sm_AssignSoft_OtherFailNum,0)) TchReqNumIncludeHoSms_e,
sum(nvl(a.v_CMO_CallSuccessNum_ms_call   ,0)
+nvl(a.v_CMO_ExtInterruptNum_call        ,0)
+nvl(a.v_AccProbe_CallSuccessNum_call    ,0)
+nvl(a.v_AccProbe_ExtInterruptNum_cal   ,0)
+nvl(a.v_AccHo_CallSuccessNum_call       ,0)
+nvl(a.v_AccHo_ExtInterruptNum_call      ,0)
+nvl(a.v_AssignSoft_CallSuccessNum_ca  ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum_c ,0)
+nvl(a.sm_CMO_CallSuccNum           ,0)
+nvl(a.sm_CMO_ExtInterruptNum_call       ,0)
+nvl(a.sm_AccProbe_CallSuccNum      ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum_ca  ,0)
+nvl(a.sm_AccHo_CallSuccNum_call         ,0)
+nvl(a.sm_AccHo_ExtInterruptNum_call     ,0)
+nvl(a.sm_AssignSoft_CallSuccNum    ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNumc,0)) TchSuccNumIncludeHoSms_e,
sum(nvl(a.v_CMO_CallSuccessNum     ,0)
+nvl(a.v_CMO_ExtInterruptNum       ,0)
+nvl(a.v_AssignSoft_CallSuccessNum ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum,0)) cs_TchSuccNumIncludeHo_f,
sum(nvl(a.p_CMO_PageResponceNum,0)
+nvl(a.p_AssignSoft_PageResponceNum,0)
+nvl(a.p_PageResponceNum,0))            ps_TchReqNumIncludeHo_f,
sum(nvl(a.v_CMO_PageResponceNum,0)
+nvl(a.v_AssignSoft_PageResponceNum,0)) cs_TchReqNumIncludeHo_f,
sum(nvl(a.p_CMO_CallSuccessNum,0)
+nvl(a.p_CMO_ExtInterruptNum       ,0)
+nvl(a.p_AssignSoft_CallSuccessNum ,0)
+nvl(a.p_AssignSoft_ExtInterruptNum,0)
+nvl(a.p_CallSuccessNum_carrier            ,0)
+nvl(a.p_ExtInterruptNum_carrier           ,0)) ps_TchSuccNumIncludeHo_f,
sum(nvl(a.v_CMO_CallSuccessNum,0)
+nvl(a.v_CMO_ExtInterruptNum        ,0)
+nvl(a.v_CMO_BlockFailureNum        ,0)
+nvl(a.v_CMO_OtherFailureNum        ,0)
+nvl(a.v_AccProbe_CallSuccessNum    ,0)
+nvl(a.v_AccProbe_ExtInterruptNum   ,0)
+nvl(a.v_AccProbe_BlockFailureNum   ,0)
+nvl(a.v_AccProbe_OtherFailureNum   ,0)
+nvl(a.v_AccHo_CallSuccessNum       ,0)
+nvl(a.v_AccHo_ExtInterruptNum      ,0)
+nvl(a.v_AccHo_BlockFailureNum      ,0)
+nvl(a.v_AccHo_OtherFailureNum      ,0)
+nvl(a.v_AssignSoft_CallSuccessNum  ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum ,0)
+nvl(a.v_AssignSoft_BlockFailureNum ,0)
+nvl(a.v_AssignSoft_OtherFailureNum ,0)
+nvl(a.sm_CMO_CallSuccessNum        ,0)
+nvl(a.sm_CMO_ExtInterruptNum       ,0)
+nvl(a.sm_CMO_BlockFailureNum       ,0)
+nvl(a.sm_CMO_OtherFailureNum       ,0)
+nvl(a.sm_AccProbe_CallSuccessNum   ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum  ,0)
+nvl(a.sm_AccProbe_BlockFailureNum  ,0)
+nvl(a.sm_AccProbe_OtherFailureNum  ,0)
+nvl(a.sm_AccHo_CallSuccessNum      ,0)
+nvl(a.sm_AccHo_ExtInterruptNum     ,0)
+nvl(a.sm_AccHo_BlockFailureNum     ,0)
+nvl(a.sm_AccHo_OtherFailureNum     ,0)
+nvl(a.sm_AssignSoft_CallSuccessNum ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNum,0)
+nvl(a.sm_AssignSoft_BlockFailureNum,0)
+nvl(a.sm_AssignSoft_OtherFailureNum,0)) TchReqNumIncludeHoSms_f,
sum(nvl(a.v_CMO_CallSuccessNum      ,0)
+nvl(a.v_CMO_ExtInterruptNum        ,0)
+nvl(a.v_AccProbe_CallSuccessNum    ,0)
+nvl(a.v_AccProbe_ExtInterruptNum   ,0)
+nvl(a.v_AccHo_CallSuccessNum      ,0)
+nvl(a.v_AccHo_ExtInterruptNum      ,0)
+nvl(a.v_AssignSoft_CallSuccessNum  ,0)
+nvl(a.v_AssignSoft_ExtInterruptNum ,0)
+nvl(a.sm_CMO_CallSuccessNum        ,0)
+nvl(a.sm_CMO_ExtInterruptNum       ,0)
+nvl(a.sm_AccProbe_CallSuccessNum   ,0)
+nvl(a.sm_AccProbe_ExtInterruptNum  ,0)
+nvl(a.sm_AccHo_CallSuccessNum      ,0)
+nvl(a.sm_AccHo_ExtInterruptNum     ,0)
+nvl(a.sm_AssignSoft_CallSuccessNum ,0)
+nvl(a.sm_AssignSoft_ExtInterruptNum,0)) TchSuccNumIncludeHoSms_f from C_TPD_1X_SUM_ZX_TEMP a,c_carrier c
where a.int_id = c.int_id and c.vendor_id=7
and a.scan_start_time = v_date
group by c.city_id
),
b as(
select
c.city_id city_id,
sum(nvl(a.Reliable95CENum,0)+nvl(a.ReliableFCENum,0)+nvl(a.ReliableRCENum,0)) CEAvailNum,
--sum(case when c.do_bts =0 then nbrAvailCe else 0 end)   ChannelAvailNum,
sum(a.ReliableFCENum+a.ReliableRCENum) ChannelAvailNum,
sum(case when (ReliableFCENum > ReliableRCENum) then  ReliableRCENum else ReliableFCENum end) TCHNum,
sum(a.Total95CENum+a.TotalPhyFCENum+a.TotalPhyRCENum)    ChannelNum       ,
--sum(a.ReliableFCENum+a.ReliableRCENum+a.Reliable95CENum)                                                         ChannelMaxUseNum ,
sum(a.MaxBusyFCENum+a.MaxBusyRCENum) ChannelMaxUseNum,
round(sum(a.MaxBusyFCENum+a.MaxBusyRCENum)/
decode(sum(a.ReliableFCENum+a.ReliableRCENum),0,1,null,1,sum(a.ReliableFCENum+a.ReliableRCENum))*100,4)   ChannelMaxUseRate,
sum(a.TotalPhyFCENum)                                                                                            FwdChNum         ,
sum(a.ReliableFCENum)                                                                                            FwdChAvailNum    ,
sum(a.MaxBusyFCENum )                                                                                            FwdChMaxUseNum   ,
round(sum(a.MaxBusyFCENum)/
decode(sum(a.TotalPhyFCENum),0,1,null,1,sum(a.TotalPhyFCENum))*100,4) FwdChMaxUseRate,
sum(a.TotalPhyRCENum)                                                                                            RevChNum         ,
sum(a.ReliableRCENum)                                                                                            RevChAvailNum    ,
sum(a.MaxBusyRCENum )                                                                                            RevChMaxUseNum   ,
round(sum(nvl(a.MaxBusyRCENum,0))/
decode(sum(nvl(a.ReliableRCENum,0)),0,1,null,1,sum(nvl(a.ReliableRCENum,0)))*100,4) RevChMaxUseRate,
sum(a.TotalPhyFCENum+a.TotalLicRCENum)                                                                           CENum            ,
round(sum(a.Reliable95CENum+a.ReliableFCENum+a.ReliableRCENum)/
100*decode(sum(a.TotalPhyFCENum+a.TotalLicRCENum),0,1,null,1,sum(a.TotalPhyFCENum+a.TotalLicRCENum)),4)  CEAvailRate
from C_TPD_1X_SUM_ZX_TEMP a,c_bts c
where a.int_id = c.int_id
and a.scan_start_time = v_date and c.vendor_id=7
group by c.city_id
),
c as(
select
c.city_id city_id,
sum(nvl(a.dwTxRexmitFrame,0)) FwdRxTotalFrame,
sum(nvl(a.dwTxTotalFrame,0)) FdwTxTotalFrameExcludeRx,
sum(nvl(a.dwRxRexmitFrame,0)) RevRxTotalFrame,
sum(nvl(a.dwRxTotalFrame,0)) RevTxTotalFrameExcludeRx,
round(sum(nvl(a.dwRxRexmitFrame,0))/decode(sum(a.dwRxTotalFrame),0,1,null,1,sum(a.dwRxTotalFrame))*100,4) RevChRxRate
from C_TPD_1X_SUM_ZX_TEMP a,c_bsc c
where a.int_id = c.int_id
and a.scan_start_time = v_date and c.vendor_id=7
group by c.city_id
)
select
a.city_id,
v_date,
0,
10004,
7,
a.TrafficExcludeHo,
a.cs_TrafficExcludeHo,
a.ps_CallTrafficExcludeHo,
a.LoseCallingNum,
a.cs_LoseCallingNum,
a.ps_LoseCallingNum,
a.AvgRadioFPeriod,
a.TCHLoadTrafficExcludeHo,
a.TCHRadioFNum,
a.cs_TchReqNumHardho,
a.cs_TchSuccNumHardho,
a.cs_CallBlockFailRateHardho,
a.cs_TchReqNumsoftho,
a.cs_TchSuccNumsoftho,
a.cs_CallBlockFailRatesoftho,
a.ps_TchReqNumHardho,
a.ps_TchSuccNumHardho,
a.ps_TchReqNumsoftho,
a.ps_TchSuccNumsoftho,
a.cs_HandoffReqNum,
a.cs_HandoffSuccNum,
a.cs_HandoffSuccRate,
a.cs_HardhoReqNum,
a.cs_HardhoSuccNum,
a.cs_HardhoSuccRate,
a.cs_SofthoReqNum,
a.cs_SofthoSuccNum,
a.cs_SSofthoReqNum,
a.cs_SSofthoSuccNum,
a.cs_SSofthoSuccRate,
a.ps_HardhoReqNum,
a.ps_HardhoSuccNum,
a.ps_SofthoReqNum,
a.ps_SofthoSuccNum,
a.ps_SSofthoReqNum,
a.ps_SSofthoSuccNum,
a.HandoffReqNum_intra,
a.HandoffSuccNum_intra,
a.HandoffReqNum_Extra,
a.HandoffSuccNum_Extra,
a.HardhoReqNum_intra,
a.HardhoSuccNum_intra,
a.ShoReqNum_intra,
a.ShoSuccNum_intra,
a.SShoReqNum_intra,
a.SShoSuccNum_intra,
a.HardhoReqNum_Extra,
a.HardhoSuccNum_Extra,
a.ShoReqNum_Extra,
a.ShoSuccNum_Extra,
a.BtsSysHardHoReqNum,
a.BtsSysHardHoSuccNum,
a.SysSHoReqNum,
a.SysSHoSuccNum,
a.CallBlockFailNum,
a.cs_CallBlockFailNum,
a.ps_CallBlockFailNum,
a.TrafficIncludeHo,
a.cs_TrafficIncludeHo,
a.cs_trafficByWalsh,
a.cs_SHOTraffic,
a.cs_SSHOTraffic,
a.ps_CallTrafficIncludeHo,
a.ps_trafficByWalsh,
a.ps_SHOTraffic,
a.ps_SSHOTraffic,
a.TCHLoadTrafficIncludeHo,
a.LoadTrafficByWalsh,
c.FwdRxTotalFrame,
c.FdwTxTotalFrameExcludeRx,
c.RevRxTotalFrame,
c.RevTxTotalFrameExcludeRx,
c.RevChRxRate,
a.TchReqNumCalleeExcludeHoSms,
a.TchSuccNumCalleeExcludeHoSms,
b.CEAvailNum,
(cs_CallPageReqNum_a+a.cs_CallPageReqNum_e+a.cs_CallPageReqNum_f) cs_CallPageReqNum,
(cs_CallPageSuccNum_a+a.cs_CallPageSuccNum_e+a.cs_CallPageSuccNum_f) cs_CallPageSuccNum,
(TchSuccNumExcludeHo_a+TchSuccNumExcludeHo_e+TchSuccNumExcludeHo_f) TchSuccNumExcludeHo,
(ps_CallPageSuccNum_a+ps_CallPageSuccNum_e+ps_CallPageSuccNum_f) ps_CallPageSuccNum,
(ps_CallPageReqNum_a+ps_CallPageReqNum_e+ps_CallPageReqNum_f) ps_CallPageReqNum,
b.ChannelNum       ,
b.ChannelMaxUseNum ,
b.ChannelMaxUseRate,
b.FwdChNum         ,
b.FwdChAvailNum    ,
b.FwdChMaxUseNum   ,
b.FwdChMaxUseRate  ,
b.RevChNum         ,
b.RevChAvailNum    ,
b.RevChMaxUseNum   ,
b.RevChMaxUseRate  ,
b.CENum            ,
b.CEAvailRate      ,
a.TchReqNumExcludeHoSms,
a.CallPageReqTotalNum,
a.TchReqNumCallerExcludeHoSms,
a.TchSuccNumCallerExcludeHoSms,
b.ChannelAvailNum,
b.TCHNum,
(cs_TchReqNumExcludeHo_a+cs_TchReqNumExcludeHo_e+cs_TchReqNumExcludeHo_f) cs_TchReqNumExcludeHo,
round(100*(a.TchRadioFRate_up)/decode((a.TchRadioFRate_down_a+a.TchRadioFRate_down_e+a.TchRadioFRate_down_f),0,1,(a.TchRadioFRate_down_a+a.TchRadioFRate_down_e+a.TchRadioFRate_down_f)),4) TchRadioFRate,
(ps_TchReqNumExcludeHo_a+ps_TchReqNumExcludeHo_e+ps_TchReqNumExcludeHo_f) ps_TchReqNumExcludeHo,
(cs_TchSuccNumExcludeHo_a+cs_TchSuccNumExcludeHo_e+cs_TchSuccNumExcludeHo_f) cs_TchSuccNumExcludeHo,
(ps_TchSuccNumExcludeHo_a+ps_TchSuccNumExcludeHo_e+ps_TchSuccNumExcludeHo_f) ps_TchSuccNumExcludeHo,
(TchSuccNumExcludeHoSms_a+TchSuccNumExcludeHoSms_e+TchSuccNumExcludeHoSms_f) TchSuccNumExcludeHoSms,
(cs_TchSuccNumIncludeHo_a+cs_TchSuccNumIncludeHo_b+cs_TchSuccNumIncludeHo_e+cs_TchSuccNumIncludeHo_f) cs_TchSuccNumIncludeHo,
(ps_TchReqNumIncludeHo_a+ps_TchReqNumIncludeHo_b+ps_TchReqNumIncludeHo_e+ps_TchReqNumIncludeHo_f) ps_TchReqNumIncludeHo,
(cs_TchReqNumIncludeHo_a+cs_TchReqNumIncludeHo_b+cs_TchReqNumIncludeHo_e+cs_TchReqNumIncludeHo_f) cs_TchReqNumIncludeHo,
(ps_TchSuccNumIncludeHo_a+ps_TchSuccNumIncludeHo_b+ps_TchSuccNumIncludeHo_e+ps_TchSuccNumIncludeHo_f) ps_TchSuccNumIncludeHo,
(TchReqNumIncludeHoSms_a+TchReqNumIncludeHoSms_b+TchReqNumIncludeHoSms_e+TchReqNumIncludeHoSms_f) TchReqNumIncludeHoSms,
(TchSuccNumIncludeHoSms_a+TchSuccNumIncludeHoSms_b+TchSuccNumIncludeHoSms_e+TchSuccNumIncludeHoSms_f) TchSuccNumIncludeHoSms
from  a,b,c
where a.city_id=b.city_id and b.city_id=c.city_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-----------------------------------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
Carrier1BtsNum,
Carrier2BtsNum,
Carrier3BtsNum,
Carrier4BtsNum
)
with a as(
select
c.city_id city_id,
sum(case when c.cdma_freq = 283 then  1 else 0 end) Carrier1BtsNum,
sum(case when c.cdma_freq = 201 then  1 else 0 end) Carrier2BtsNum,
sum(case when c.cdma_freq = 242 then  1 else 0 end) Carrier3BtsNum,
sum(case when c.cdma_freq = 160 then  1 else 0 end) Carrier4BtsNum
from c_carrier c ,c_bts b
where c.related_bts = b.int_id  and b.do_bts = 0 and b.vendor_id=7
group by c.city_id)
select
a.city_id,
v_date,
0,
10004,
7,
a.Carrier1BtsNum,
a.Carrier2BtsNum,
a.Carrier3BtsNum,
a.Carrier4BtsNum
from a;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
----------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CARRIERNUM_1X
)
select
c.city_id city_id,
v_date,
0,
10004,
7,
count(a.int_id)  CARRIERNUM_1X
from C_tpd_cnt_carr_zx a,c_carrier c
where a.int_id = c.int_id and scan_start_time = v_date
group by c.city_id;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
----------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
OnecarrierCellNum
)
with a as
(
select related_cell int_id from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_cell having count(distinct cdma_freq)=1
)
select b.city_id,
v_date,
0,
10004,
7,
count(distinct b.int_id) OnecarrierCellNum
from a,c_cell b
where a.int_id=b.int_id
group by b.city_id;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-------------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TwocarrierCellNum
)
with a as
(
select related_cell int_id from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_cell having count(distinct cdma_freq)=2
)
select b.city_id,
v_date,
0,
10004,
7,
count(distinct b.int_id) TwocarrierCellNum
from a,c_cell b
where a.int_id=b.int_id
group by b.city_id;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
--
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
threecarrierCellNum
)
with a as
(
select related_cell int_id from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_cell having count(distinct cdma_freq)=3
)
select b.city_id,
v_date,
0,
10004,
7,
count(distinct b.int_id) threecarrierCellNum
from a,c_cell b
where a.int_id=b.int_id
group by b.city_id;

commit;
dbms_output.put_line('Now time:'||sysdate||'-');
---------------------------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
FourcarrierCellNum
)
with a as
(
select related_cell int_id from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_cell having count(distinct cdma_freq)=4
)
select b.city_id,
v_date,
0,
10004,
7,
count(distinct b.int_id) FourcarrierCellNum
from a,c_cell b
where a.int_id=b.int_id and b.city_id is not null
group by b.city_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
--------------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
btsNum
)
select
b.city_id ,
v_date,
0,
10004,
7,
count(distinct a.related_bts) btsNum
from c_carrier a,c_cell b where a.related_cell=b.int_id
and  a.cdma_freq in (283,242,201,160,119)
and a.vendor_id=7
group by b.city_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
OnecarrierBtsNum
)
select
b.city_id,
v_date,
0,
10004,
7,
count(distinct a.related_bts) OnecarrierBtsNum
from
(select related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_bts having count(distinct cdma_freq)=1 ) a,c_cell b
where a.related_bts=b.related_bts and b.vendor_id=7
group by b.city_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TwocarrierBtsNum
)
select
b.city_id,
v_date,
0,
10004,
7,
count(distinct a.related_bts) TwocarrierBtsNum
from
(select related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_bts having count(distinct cdma_freq)=2 ) a,c_cell b
where a.related_bts=b.related_bts and b.vendor_id=7
group by b.city_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
threecarrierbtsNum
)
select
b.city_id,
v_date,
0,
10004,
7,
count(distinct a.related_bts) threecarrierbtsNum
from
(select related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_bts having count(distinct cdma_freq)=3 ) a,c_cell b
where a.related_bts=b.related_bts and b.vendor_id=7
group by b.city_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
FourcarrierbtsNum
)
select
b.city_id,
v_date,
0,
10004,
7,
count(distinct a.related_bts) FourcarrierbtsNum
from
(select related_bts from
c_carrier where cdma_freq in (283,242,201,160,119) and vendor_id=7
group by related_msc,related_bts having count(distinct cdma_freq)=4 ) a,c_cell b
where a.related_bts=b.related_bts and b.vendor_id=7
group by b.city_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
BadCellNum
)
with t1 as(
select
c.related_cell related_cell,
c.city_id city_id,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)) / 3600 v1,
sum(nvl(a.v_CM_RadioFNum,0)
+nvl(a.ConVoc_RlsFailNum    ,0)
+nvl(a.ConVocData_RlsFailNum,0)) v2,
sum(nvl(a.v_CallSuccessNum_orig,0)
+nvl(a.v_ExtInterruptNum    ,0)
+nvl(a.v_CallSuccessNum     ,0)
+nvl(a.v_ExtInterruptNum    ,0)) v3_down_a
from C_tpd_cnt_carr_zx a,c_carrier c
where a.int_id = c.int_id  and c.vendor_id=7
and a.scan_start_time = v_date
group by c.related_cell,c.city_id),
t3e as(
select
c.related_cell related_cell,
c.city_id city_id,
sum(nvl(e.v_CMO_CallSuccessNum_ms,0)
+nvl(e.v_CMO_ExtInterruptNum       ,0)
+nvl(e.v_AccProbe_CallSuccessNum   ,0)
+nvl(e.v_AccProbe_ExtInterruptNum  ,0)
+nvl(e.v_AccHo_CallSuccessNum      ,0)
+nvl(e.v_AccHo_ExtInterruptNum     ,0)
+nvl(e.v_AssignSoft_CallSuccessNum ,0)
+nvl(e.v_AssignSoft_ExtInterruptNum,0)) v3_down_e
from C_tpd_cnt_carr_call_zx e,c_carrier c
where e.int_id = c.int_id  and c.vendor_id=7
and e.scan_start_time = v_date
group by c.related_cell,c.city_id),
t3f as(
select
c.related_cell related_cell,
c.city_id city_id,
sum(nvl(f.v_CMO_CallSuccessNum,0)
+nvl(f.v_CMO_ExtInterruptNum       ,0)
+nvl(f.v_AccProbe_CallSuccessNum   ,0)
+nvl(f.v_AccProbe_ExtInterruptNum  ,0)
+nvl(f.v_AccHo_CallSuccessNum     ,0)
+nvl(f.v_AccHo_ExtInterruptNum     ,0)
+nvl(f.v_AssignSoft_CallSuccessNum ,0)
+nvl(f.v_AssignSoft_ExtInterruptNum,0)) v3_down_f
from C_tpd_cnt_carr_pag_zx f,c_carrier c
where f.int_id = c.int_id  and c.vendor_id=7
and f.scan_start_time = v_date
group by c.related_cell,c.city_id)
select
t1.city_id,
v_date,
0,
10004,
7,
count(t1.related_cell) BadCellNum
from t1,t3e,t3f
where t1.v1>2.5 and t1.v2>3 and t1.v2/(t1.v3_down_a+t3e.v3_down_e+t3f.v3_down_f) > 0.025
and t1.related_cell = t3e.related_cell and t3e.related_cell = t3f.related_cell
group by t1.city_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-----
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TrafficCarrier1,
TrafficCarrier2,
TrafficCarrier3,
TrafficCarrier4
)
select
c.city_id city_id,
v_date,
0,
10004,
7,
sum(case when cdma_freq=283 then nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SHoDuration                 ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur   ,0)
+nvl(b.v_SSHoDuration                ,0)
+nvl(a.p_AvfAssReq_AvfSvcAss_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(b.p_SHoDuration                 ,0)
+nvl(b.p_SSHoDuration,0) else 0 end )/3600   TrafficCarrier1,
sum(case when cdma_freq=201 then nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SHoDuration                 ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur   ,0)
+nvl(b.v_SSHoDuration                ,0)
+nvl(a.p_AvfAssReq_AvfSvcAss_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(b.p_SHoDuration                 ,0)
+nvl(b.p_SSHoDuration,0) else 0 end )/3600   TrafficCarrier2,
sum(case when cdma_freq=242 then nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SHoDuration                 ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur   ,0)
+nvl(b.v_SSHoDuration                ,0)
+nvl(a.p_AvfAssReq_AvfSvcAss_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(b.p_SHoDuration                 ,0)
+nvl(b.p_SSHoDuration,0) else 0 end )/3600   TrafficCarrier3,
sum(case when cdma_freq=160 then nvl(a.v_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur ,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SHoDuration                 ,0)
+nvl(a.v_AvfSvcAss_AvfAssCmp_SSHoDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_SSHoDur,0)
+nvl(a.AvfSvcAss_AvfAssCmp_SSHoDur   ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_SSHoDur   ,0)
+nvl(b.v_SSHoDuration                ,0)
+nvl(a.p_AvfAssReq_AvfSvcAss_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_CallDur ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SHoDur  ,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.p_AvfSvcAss_AvfAssCmp_SSHoDur,0)
+nvl(a.p_AvrAssCmp_AvfRlsReq_SSHoDur ,0)
+nvl(b.p_SHoDuration ,0)
+nvl(b.p_SSHoDuration,0) else 0 end) / 3600  TrafficCarrier4
from C_tpd_cnt_carr_zx a,C_tpd_cnt_carr_ho_zx b,c_carrier c
where a.int_id=c.int_id and b.int_id=c.int_id and c.vendor_id=7 and a.scan_start_time=b.scan_start_time
and a.scan_start_time=v_date
group by c.city_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
Wirecapacity
)
select
c.city_id city_id,
v_date,
0,
10004,
7,
sum(nvl(d.erl02,0)) Wirecapacity
from c_tpd_cnt_bts_zx h,c_bts c,c_erl d
where h.int_id = c.int_id and h.scan_start_time = v_date
and c.vendor_id = 7 and least(h.ReliableFCENum,h.ReliableRCENum)=d.tchnum
group by c.city_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
CellNum,
BusyerCellNum,
BusyCellNum,
FreeCellNum
)
select
a.city_id,
v_date,
0,
10004,
7,
a.CellNum,b.BusyerCellNum,c.BusyCellNum,d.FreeCellNum
from
(
select b.city_id ,count(distinct a.related_cell) CellNum
from c_carrier a,c_cell b where a.related_cell=b.int_id and b.city_id is not null and  a.cdma_freq in (283,242,201,160,119)
and a.vendor_id=7 group by b.city_id ) a,
(
select a.city_id ,count(b.int_id) BusyerCellNum
from
(
select c.city_id ,c.related_bts int_id,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur ,0)+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SSHoDuration ,0)+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur,0))/3600 temp
from C_tpd_cnt_carr_zx a,C_tpd_cnt_carr_ho_zx b,c_carrier c
where c.vendor_id=7
and a.int_id=b.int_id
and a.int_id=c.int_id
and a.scan_start_time=v_date and b.scan_start_time=v_date
and c.city_id is not null
group by c.city_id,c.related_bts  ) a,c_cell b,c_tpd_sts_bts d,c_erl e
where a.int_id=d.int_id and e.tchnum=d.nbrAvailCe
and d.scan_start_time=v_date and b.vendor_id=7 and b.related_bts=d.int_id
and 100*temp/(decode(erl02,null,1,0,1,erl02)*360)>75
group by a.city_id
) b,
(
select a.city_id ,count(b.int_id) BusyCellNum
from
(
select c.city_id ,c.related_bts int_id,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur ,0)+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SSHoDuration ,0)+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur,0))/3600 temp
from C_tpd_cnt_carr_zx a,C_tpd_cnt_carr_ho_zx b,c_carrier c
where c.vendor_id=7
and a.int_id=b.int_id
and a.int_id=c.int_id
and a.scan_start_time=v_date and b.scan_start_time=v_date
and c.city_id is not null
group by c.city_id,c.related_bts  ) a,c_cell b,c_tpd_sts_bts d,c_erl e
where a.int_id=d.int_id and e.tchnum=d.nbrAvailCe
and d.scan_start_time=v_date and b.vendor_id=7 and b.related_bts=d.int_id
and 100*temp/(decode(erl02,null,1,0,1,erl02)*360)<75
and 100*temp/(decode(erl02,null,1,0,1,erl02)*360)>60
group by a.city_id
) c,
(
select a.city_id ,count(b.int_id) FreeCellNum
from
(
select c.city_id ,c.related_bts int_id,
sum(nvl(a.v_AvfAssReq_AvfSvcAss_CallDur ,0)+nvl(a.v_AvfSvcAss_AvfAssCmp_CallDur ,0)
+nvl(a.v_AvrAssCmp_AvfRlsReq_CallDur ,0)+nvl(a.v_AvrAssCmp_AvfRlsReq_ShoDur  ,0)
+nvl(a.sm_AvfAssReq_AvfSvcAss_CallDur,0)+nvl(a.sm_AvfSvcAss_AvfAssCmp_CallDur,0)
+nvl(a.sm_AvrAssCmp_AvfRlsReq_CallDur,0)+nvl(a.sm_AvrAssCmp_AvfRlsReq_ShoDur ,0)
+nvl(a.AvfSvcAss_AvfAssCmp_CallDur   ,0)+nvl(a.AvfSvcAss_AvfAssCmp_SHoDur    ,0)
+nvl(a.AvrAssCmp_AvfRlsReq_CallDur   ,0)+nvl(a.AvrAssCmp_AvfRlsReq_ShoDur    ,0)
+nvl(b.v_SSHoDuration ,0)+nvl(a.v_AvfSvcAss_AvfAssCmp_SHoDur,0)
+nvl(a.sm_AvfSvcAss_AvfAssCmp_SHoDur,0))/3600 temp
from C_tpd_cnt_carr_zx a,C_tpd_cnt_carr_ho_zx b,c_carrier c
where c.vendor_id=7
and a.int_id=b.int_id
and a.int_id=c.int_id
and a.scan_start_time=v_date and b.scan_start_time=v_date
and c.city_id is not null
group by c.city_id,c.related_bts  ) a,c_cell b,c_tpd_sts_bts d,c_erl e
where a.int_id=d.int_id and e.tchnum=d.nbrAvailCe
and d.scan_start_time=v_date and b.vendor_id=7 and b.related_bts=d.int_id
and 100*temp/(decode(erl02,null,1,0,1,erl02)*360)<10
group by a.city_id
)d
where a.city_id=b.city_id(+) and a.city_id=c.city_id(+) and a.city_id=d.city_id(+);
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
-------
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TCHBlockFailNumIncludeHo
)
select c.city_id city_id,
v_date,
0,
10004,
7,
sum(nvl(a.v_VEBlockNum, 0) + nvl(a.v_VEBlockNum_l3, 0) +
nvl(a.v_SEBlockNum, 0) + nvl(a.v_SEBlockNum_l3, 0) +
nvl(a.v_CICBlockNum, 0) + nvl(a.v_CICBlockNum_l3, 0) +
nvl(a.v_CEBlockNum_bsc, 0) + nvl(a.v_CEBlockNum_l3_bsc, 0) +
nvl(a.v_CHBlockNum_bsc, 0) + nvl(a.v_CHBlockNum_l3_bsc, 0) +
nvl(a.v_FPWBlockNum_bsc, 0) + nvl(a.v_FPWBlockNum_l3_bsc, 0) +
nvl(a.v_FOBlockNum_bsc, 0) + nvl(a.v_FOBlockNum_l3_bsc, 0) +
nvl(a.v_AbiscBlockNum_bsc, 0) + nvl(a.v_AbiscBlockNum_l3_bsc, 0))
+
sum(nvl(a.sm_VEBlockNum, 0) + nvl(a.sm_VEBlockNum_l3, 0) +
nvl(a.sm_SEBlockNum, 0) + nvl(a.sm_SEBlockNum_l3, 0) +
nvl(a.sm_CICBlockNum, 0) + nvl(a.sm_CICBlockNum_l3, 0) +
nvl(a.sm_CEBlockNum, 0) + nvl(a.sm_CEBlockNum_l3, 0) +
nvl(a.sm_CHBlockNum, 0) + nvl(a.sm_CHBlockNum_l3, 0) +
nvl(a.sm_FPWBlockNum, 0) + nvl(a.sm_FPWBlockNum_l3, 0) +
nvl(a.sm_FOBlockNum, 0) + nvl(a.sm_FOBlockNum_l3, 0) +
nvl(a.sm_AbiscBlockNum, 0) + nvl(a.sm_AbiscBlockNum_l3, 0)) TCHBlockFailNumIncludeHo
from  C_TPD_1X_SUM_ZX_TEMP a,c_bsc c
where a.unique_rdn = c.unique_rdn
and  c.vendor_id = 7
group by c.city_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
insert /*+ APPEND*/ into C_PERF_1X_SUM_ZX_TEMP
(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
TchSuccExcludeHoRate,
CallPageSuccRate,
cs_SHORate,
ps_SHORate,
cs_LoseCallingRate,
ps_LoseCallingRate,
LoseCallingRate,
ps_CallPageSuccRate,
cs_CallPageSuccRate,
CallPageReqNum,
CallPageSuccNum,
Numfailofcall,
cs_Numfailofcall,
BadCellRatio,
TCHBlockFailRate,
TchFNumIncludeHo,
ps_TchFNumIncludeHo,
ps_TchSuccIncludeHoRate,
ps_TchSuccExcludeHoRate,
ps_CallBlockFailRateHardho,
ps_CallBlockFailRatesoftho,
ps_HandoffReqNum,
ps_HandoffSuccNum,
ps_HandoffSuccRate,
ps_HardhoSuccRate,
ps_SofthoSuccRate,
ps_SSofthoSuccRate,
HandoffSuccRate_intra,
HandoffSuccRate_Extra,
HardhoSuccRate_intra,
ShoSuccRate_intra,
SShoSuccRate_intra,
HardhoSuccRate_Extra,
ShoSuccRate_Extra,
FwdChRxRate,
TCHLoadRate,
BusyerCellratio,
BusyCellratio,
FreeCellratio,
BtsSysHardHoSuccRate,
SysSHoSuccRate,
CallInterruptRate,
TchReqNumExcludeHo,
TchSuccNumIncludeHo,
TCHSUCCINCLUDEHORATE,
ps_TchFNumExcludeHo,
TchFNumExcludeHo,
ps_CallBlockFailRate,
TchReqNumIncludeHo,
cs_TchSuccIncludeHoRate,
LoseCallingratio,
ps_LoseCallingratio,
cs_LoseCallingratio,
CallBlockFailRate,
cs_CallBlockFailRate,
HandoffReqNum,
HandoffSuccNum,
HandoffSuccRate,
cs_SofthoSuccRate,
cs_TchFNumIncludeHo,
cs_TchFNumExcludeHo,
cs_TchSuccExcludeHoRate,
SHoFactor
)
select
int_id,
v_date,
0,
10004,
7,
round(100*sum(cs_TchSuccNumExcludeHo + ps_TchSuccNumExcludeHo)/
decode(sum(cs_TchReqNumExcludeHo + ps_TchReqNumExcludeHo),0,1,null,1,sum(cs_TchReqNumExcludeHo + ps_TchReqNumExcludeHo)),4) TchSuccExcludeHoRate,
round(100*sum(cs_CallPageSuccNum+ps_CallPageSuccNum)/decode(sum(cs_CallPageReqNum+ps_CallPageReqNum),0,1,null,1,sum(cs_CallPageReqNum+ps_CallPageReqNum)),4) CallPageSuccRate,
round(100*sum(cs_SHOTraffic)/decode(sum(cs_TrafficExcludeHo+cs_SHOTraffic),null,1,0,1,sum(cs_TrafficExcludeHo+cs_SHOTraffic)),4) cs_SHORate,
round(100*sum(ps_SHOTraffic)/decode(sum(ps_CallTrafficExcludeHo + ps_SHOTraffic),null,1,0,1,sum(ps_CallTrafficExcludeHo + ps_SHOTraffic)),4) ps_SHORate,
round(100*sum(cs_LoseCallingNum)/decode(sum(cs_TchSuccNumExcludeHo),null,1,0,1,sum(cs_TchSuccNumExcludeHo)),4) cs_LoseCallingRate,
round(100*sum(ps_LoseCallingNum)/decode(sum(ps_TchSuccNumExcludeHo),null,1,0,1,sum(ps_TchSuccNumExcludeHo)),4) ps_LoseCallingRate,
round(100*sum(LoseCallingNum)/decode(sum(TchSuccNumExcludeHo),0,1,null,1,sum(TchSuccNumExcludeHo)),4) LoseCallingRate,
round(100*sum(ps_CallPageSuccNum)/decode(sum(ps_CallPageReqNum),0,1,null,1,sum(ps_CallPageReqNum)),4) ps_CallPageSuccRate,
round(100*sum(cs_CallPageSuccNum)/decode(sum(cs_CallPageReqNum),0,1,null,1,sum(cs_CallPageReqNum)),4)  cs_CallPageSuccRate,
sum(cs_CallPageReqNum+ps_CallPageReqNum) CallPageReqNum,
sum(cs_CallPageSuccNum+ps_CallPageSuccNum) CallPageSuccNum,
sum(nvl(cs_CallPageReqNum,0) + nvl(ps_CallPageReqNum,0) - nvl(cs_CallPageSuccNum,0) - nvl(ps_CallPageSuccNum,0)) Numfailofcall,
sum(nvl(cs_CallPageReqNum,0) - nvl(cs_CallPageSuccNum,0)) cs_Numfailofcall,
round(100*sum(nvl(BadCellNum,0))/decode(sum(CellNum),0,1,null,1,sum(CellNum)),4) BadCellRatio,
round(100*sum(nvl(TCHBlockFailNumIncludeHo,0))/decode(sum(TchReqNumIncludeHoSms),null,1,0,1,sum(TchReqNumIncludeHoSms)),4) TCHBlockFailRate,
sum((nvl(cs_TchReqNumIncludeHo,0)-nvl(cs_TchSuccNumIncludeHo,0)+nvl(ps_TchReqNumIncludeHo,0)-nvl(ps_TchSuccNumIncludeHo,0))) TchFNumIncludeHo,
round(sum(nvl(ps_TchReqNumIncludeHo,0)-nvl(ps_TchSuccNumIncludeHo,0)),4) ps_TchFNumIncludeHo,
round(100*sum(ps_TchSuccNumIncludeHo)/decode(sum(ps_TchReqNumIncludeHo),null,1,0,1,sum(ps_TchReqNumIncludeHo)),4) ps_TchSuccIncludeHoRate,
round(100*sum(ps_TchSuccNumExcludeHo)/decode(sum(ps_TchReqNumExcludeHo),null,1,0,1,sum(ps_TchReqNumExcludeHo)),4) ps_TchSuccExcludeHoRate,
round(100*sum(nvl(ps_TchReqNumHardho,0)-nvl(ps_TchSuccNumHardho,0))/decode(sum(ps_TchReqNumHardho),null,1,0,1,sum(ps_TchReqNumHardho)),4) ps_CallBlockFailRateHardho,
round(100*sum(nvl(ps_TchReqNumsoftho,0)-nvl(ps_TchSuccNumsoftho,0))/decode(sum(ps_TchReqNumsoftho),null,1,0,1,sum(ps_TchReqNumsoftho)),4) ps_CallBlockFailRatesoftho,
sum(nvl(ps_HardhoReqNum,0)+nvl(ps_SofthoReqNum,0)+nvl(ps_SSofthoReqNum,0)) ps_HandoffReqNum,
sum(nvl(ps_HardhoSuccNum,0)+nvl(ps_SofthoSuccNum,0)+nvl(ps_SSofthoSuccNum,0)) ps_HandoffSuccNum,
round(100*sum(nvl(ps_HardhoSuccNum,0)+nvl(ps_SofthoSuccNum,0)+nvl(ps_SSofthoSuccNum,0))/decode(sum(ps_HardhoReqNum+ps_SofthoReqNum+ps_SSofthoReqNum),null,1,0,1,sum(ps_HardhoReqNum+ps_SofthoReqNum+ps_SSofthoReqNum)),4)  ps_HandoffSuccRate,
round(100*sum(ps_HardhoSuccNum) /decode(sum(ps_HardhoReqNum),null,1,0,1,sum(ps_HardhoReqNum)),4) ps_HardhoSuccRate,
round(100*sum(ps_SofthoSuccNum) /decode(sum(ps_SofthoReqNum),null,1,0,1,sum(ps_SofthoReqNum)),4) ps_SofthoSuccRate,
round(100*sum(ps_SSofthoSuccNum)/decode(sum(ps_SSofthoReqNum),null,1,0,1,sum(ps_SSofthoReqNum)),4) ps_SSofthoSuccRate,
round(100*sum(HandoffSuccNum_intra)/decode(sum(HandoffReqNum_intra),null,1,0,1,sum(HandoffReqNum_intra)),4) HandoffSuccRate_intra,
round(100*sum(HandoffSuccNum_Extra)/decode(sum(HandoffReqNum_Extra),null,1,0,1,sum(HandoffReqNum_Extra)),4) HandoffSuccRate_Extra,
round(100*sum(HardhoSuccNum_intra)/decode(sum(HardhoReqNum_intra),null,1,0,1,sum(HardhoReqNum_intra)),4)  HardhoSuccRate_intra,
round(100*sum(ShoSuccNum_intra)/decode(sum(ShoReqNum_intra),null,1,0,1,sum(ShoReqNum_intra)),4)  ShoSuccRate_intra,
round(100*sum(SShoSuccNum_intra)/decode(sum(SShoReqNum_intra),null,1,0,1,sum(SShoReqNum_intra)),4) SShoSuccRate_intra,
round(100*sum(HardhoSuccNum_Extra)/decode(sum(HardhoReqNum_Extra),null,1,0,1,sum(HardhoReqNum_Extra)),4) HardhoSuccRate_Extra,
round(100*sum(ShoSuccNum_Extra)/decode(sum(ShoReqNum_Extra),null,1,0,1,sum(ShoReqNum_Extra)),4) ShoSuccRate_Extra,
round(100*sum(FwdRxTotalFrame)/decode(sum(nvl(FwdRxTotalFrame,0)+nvl(FdwTxTotalFrameExcludeRx,0)),null,1,0,1,sum(nvl(FwdRxTotalFrame,0)+nvl(FdwTxTotalFrameExcludeRx,0))),4) FwdChRxRate,
round(100*sum(TCHLoadTrafficIncludeHo)/decode(sum(Wirecapacity),null,1,0,1,sum(Wirecapacity)),4)   TCHLoadRate,
round(100*sum(BusyerCellNum)/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4) BusyerCellratio,
round(100*sum(BusyCellNum)/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4) BusyCellratio,
round(100*sum(FreeCellNum)/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4) FreeCellratio,
round(100*sum(BtsSysHardHoSuccNum)/decode(sum(BtsSysHardHoReqNum),null,1,0,1,sum(BtsSysHardHoReqNum)),4)  BtsSysHardHoSuccRate,
round(100*sum(SysSHoSuccNum)/decode(sum(SysSHoReqNum),null,1,0,1,sum(SysSHoReqNum)),4)   SysSHoSuccRate,
round(100*sum(TCHRadioFNum)/decode(sum(cs_CallPageSuccNum),null,1,0,1,sum(cs_CallPageSuccNum)),4) CallInterruptRate,
sum(nvl(cs_TchReqNumExcludeHo,0)+nvl(ps_TchReqNumExcludeHo,0))  TchReqNumExcludeHo,
sum(nvl(cs_TchSuccNumIncludeHo,0)+nvl(ps_TchSuccNumIncludeHo,0)) TchSuccNumIncludeHo,
round(100*sum(nvl(cs_TchSuccNumIncludeHo,0)+nvl(ps_TchSuccNumIncludeHo,0))/decode(sum(nvl(cs_TchReqNumIncludeHo,0)+nvl(ps_TchReqNumIncludeHo,0)),null,1,0,1,sum(nvl(cs_TchReqNumIncludeHo,0)+nvl(ps_TchReqNumIncludeHo,0))),4) TCHSUCCINCLUDEHORATE,
sum(nvl(ps_TchReqNumExcludeHo,0)-nvl(ps_TchSuccNumExcludeHo,0)) ps_TchFNumExcludeHo,
round(sum(nvl(cs_TchReqNumExcludeHo,0)-nvl(cs_TchSuccNumExcludeHo,0)+nvl(ps_TchReqNumExcludeHo,0)-nvl(ps_TchSuccNumExcludeHo,0)),4) TchFNumExcludeHo,
round(100*sum(ps_CallBlockFailNum)/decode(sum(ps_TchReqNumIncludeHo),null,1,0,1,sum(ps_TchReqNumIncludeHo)),4)  ps_CallBlockFailRate,
sum(nvl(cs_TchReqNumIncludeHo,0)+nvl(ps_TchReqNumIncludeHo,0))  TchReqNumIncludeHo,
round(100*sum(cs_TchSuccNumIncludeHo)/decode(sum(cs_TchReqNumIncludeHo),null,1,0,1,sum(cs_TchReqNumIncludeHo)),4)  cs_TchSuccIncludeHoRate,
round(sum(TrafficExcludeHo)*60/decode(sum(LoseCallingNum),null,1,0,1,sum(LoseCallingNum)),4)           LoseCallingratio,
round(sum(ps_CallTrafficExcludeHo)*60/decode(sum(ps_LoseCallingNum),null,1,0,1,sum(ps_LoseCallingNum)),4) ps_LoseCallingratio,
case when sum(cs_LoseCallingNum) is null then 1000
     when sum(cs_LoseCallingNum) = 0     then 1000
else round(sum(cs_TrafficExcludeHo)*60/sum(cs_LoseCallingNum),4) end    cs_LoseCallingratio,
round(100*sum(CallBlockFailNum)/decode(sum(nvl(cs_TchReqNumIncludeHo,0)+nvl(ps_TchReqNumIncludeHo,0)),null,1,0,1,sum(nvl(cs_TchReqNumIncludeHo,0)+nvl(ps_TchReqNumIncludeHo,0))),4)  CallBlockFailRate,
round(100*sum(cs_CallBlockFailNum)/decode(sum(cs_TchReqNumIncludeHo),null,1,0,1,sum(cs_TchReqNumIncludeHo)),4) cs_CallBlockFailRate,
sum(nvl(HardhoReqNum_intra,0)+nvl(ShoReqNum_intra,0)+nvl(SShoReqNum_intra,0)+ nvl(HardhoReqNum_Extra,0)+nvl(ShoReqNum_Extra,0)) HandoffReqNum,
sum(nvl(HardhoSuccNum_intra,0)+nvl(ShoSuccNum_intra,0)+nvl(SShoSuccNum_intra,0) + nvl(HardhoSuccNum_Extra,0)+nvl(ShoSuccNum_Extra,0))  HandoffSuccNum,
round(100*sum(nvl(HardhoSuccNum_intra,0)+nvl(ShoSuccNum_intra,0)+nvl(SShoSuccNum_intra,0) + nvl(HardhoSuccNum_Extra,0)+nvl(ShoSuccNum_Extra,0))/
decode(sum(nvl(HardhoReqNum_intra,0)+nvl(ShoReqNum_intra,0)+nvl(SShoReqNum_intra,0)+ nvl(HardhoReqNum_Extra,0)+nvl(ShoReqNum_Extra,0)),null,1,0,1,
sum(nvl(HardhoReqNum_intra,0)+nvl(ShoReqNum_intra,0)+nvl(SShoReqNum_intra,0)+ nvl(HardhoReqNum_Extra,0)+nvl(ShoReqNum_Extra,0))),4) HandoffSuccRate,
round(100*sum(cs_SofthoSuccNum)/decode(sum(cs_SofthoReqNum),null,1,0,1,sum(cs_SofthoReqNum)),4) cs_SofthoSuccRate,
sum(nvl(cs_TchReqNumIncludeHo,0)-nvl(cs_TchSuccNumIncludeHo,0)) cs_TchFNumIncludeHo,
sum(nvl(cs_TchReqNumExcludeHo,0)-nvl(cs_TchSuccNumExcludeHo,0)) cs_TchFNumExcludeHo,
round(100*sum(cs_TchSuccNumExcludeHo)/decode(sum(cs_TchReqNumExcludeHo),null,1,0,1,sum(cs_TchReqNumExcludeHo)),4) cs_TchSuccExcludeHoRate,
round(100*sum(nvl(TCHLoadTrafficIncludeHo,0) - nvl(TCHLoadTrafficExcludeHo,0))/decode(sum(TCHLoadTrafficExcludeHo),0,1,null,1,sum(TCHLoadTrafficExcludeHo)),4) SHoFactor
from C_PERF_1X_SUM_ZX_TEMP
group by int_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');
----
insert /*+ APPEND*/ into C_PERF_1X_SUM
(
int_id                         ,
scan_start_time                ,
sum_level                      ,
ne_type                        ,
vendor_id                      ,
callpagereqnum                 ,
callpagesuccnum                ,
callpagesuccrate               ,
cs_callpagereqnum              ,
cs_callpagesuccnum             ,
cs_callpagesuccrate            ,
ps_callpagereqnum              ,
ps_callpagesuccnum             ,
ps_callpagesuccrate            ,
trafficincludeho               ,
trafficexcludeho               ,
cs_trafficincludeho            ,
cs_trafficexcludeho            ,
cs_trafficbywalsh              ,
cs_shotraffic                  ,
cs_sshotraffic                 ,
cs_shorate                     ,
ps_calltrafficincludeho        ,
ps_calltrafficexcludeho        ,
ps_trafficbywalsh              ,
ps_shotraffic                  ,
ps_sshotraffic                 ,
ps_shorate                     ,
losecallingnum                 ,
losecallingrate                ,
losecallingratio               ,
cs_losecallingnum              ,
cs_losecallingrate             ,
cs_losecallingratio            ,
ps_losecallingnum              ,
ps_losecallingrate             ,
ps_losecallingratio            ,
tchreqnumincludeho             ,
tchsuccnumincludeho            ,
tchfnumincludeho               ,
tchsuccincludehorate           ,
tchreqnumexcludeho             ,
tchsuccnumexcludeho            ,
tchfnumexcludeho               ,
tchsuccexcludehorate           ,
callblockfailnum               ,
callblockfailrate              ,
cs_tchreqnumincludeho          ,
cs_tchsuccnumincludeho         ,
cs_tchfnumincludeho            ,
cs_tchsuccincludehorate        ,
cs_tchreqnumexcludeho          ,
cs_tchsuccnumexcludeho         ,
cs_tchfnumexcludeho            ,
cs_tchsuccexcludehorate        ,
cs_callblockfailnum            ,
cs_callblockfailrate           ,
cs_tchreqnumhardho             ,
cs_tchsuccnumhardho            ,
cs_callblockfailratehardho     ,
cs_tchreqnumsoftho             ,
cs_tchsuccnumsoftho            ,
cs_callblockfailratesoftho     ,
ps_tchreqnumincludeho          ,
ps_tchsuccnumincludeho         ,
ps_tchfnumincludeho            ,
ps_tchsuccincludehorate        ,
ps_tchreqnumexcludeho          ,
ps_tchsuccnumexcludeho         ,
ps_tchfnumexcludeho            ,
ps_tchsuccexcludehorate        ,
ps_callblockfailnum            ,
ps_callblockfailrate           ,
ps_tchreqnumhardho             ,
ps_tchsuccnumhardho            ,
ps_callblockfailratehardho     ,
ps_tchreqnumsoftho             ,
ps_tchsuccnumsoftho            ,
ps_callblockfailratesoftho     ,
handoffreqnum                  ,
handoffsuccnum                 ,
handoffsuccrate                ,
cs_handoffreqnum               ,
cs_handoffsuccnum              ,
cs_handoffsuccrate             ,
cs_hardhoreqnum                ,
cs_hardhosuccnum               ,
cs_hardhosuccrate              ,
cs_softhoreqnum                ,
cs_softhosuccnum               ,
cs_softhosuccrate              ,
cs_ssofthoreqnum               ,
cs_ssofthosuccnum              ,
cs_ssofthosuccrate             ,
ps_handoffreqnum               ,
ps_handoffsuccnum              ,
ps_handoffsuccrate             ,
ps_hardhoreqnum                ,
ps_hardhosuccnum               ,
ps_hardhosuccrate              ,
ps_softhoreqnum                ,
ps_softhosuccnum               ,
ps_softhosuccrate              ,
ps_ssofthoreqnum               ,
ps_ssofthosuccnum              ,
ps_ssofthosuccrate             ,
handoffreqnum_intra            ,
handoffsuccnum_intra           ,
handoffsuccrate_intra          ,
handoffreqnum_extra            ,
handoffsuccnum_extra           ,
handoffsuccrate_extra          ,
hardhoreqnum_intra             ,
hardhosuccnum_intra            ,
hardhosuccrate_intra           ,
shoreqnum_intra                ,
shosuccnum_intra               ,
shosuccrate_intra              ,
sshoreqnum_intra               ,
sshosuccnum_intra              ,
sshosuccrate_intra             ,
hardhoreqnum_extra             ,
hardhosuccnum_extra            ,
hardhosuccrate_extra           ,
shoreqnum_extra                ,
shosuccnum_extra               ,
shosuccrate_extra              ,
carrier1btsnum                 ,
carrier2btsnum                 ,
carrier3btsnum                 ,
carrier4btsnum                 ,
carriernum_1x                  ,
channelnum                     ,
channelavailnum                ,
channelmaxusenum               ,
channelmaxuserate              ,
fwdchnum                       ,
fwdchavailnum                  ,
fwdchmaxusenum                 ,
fwdchmaxuserate                ,
revchnum                       ,
revchavailnum                  ,
revchmaxusenum                 ,
revchmaxuserate                ,
fwdrxtotalframe                ,
fdwtxtotalframeexcluderx       ,
rlpfwdchsizeexcluderx          ,
rlpfwdchrxsize                 ,
rlpfwdlosesize                 ,
fwdchrxrate                    ,
revrxtotalframe                ,
revtxtotalframeexcluderx       ,
rlprevchsize                   ,
revchrxrate                    ,
btsnum                         ,
onecarrierbtsnum               ,
twocarrierbtsnum               ,
threecarrierbtsnum             ,
fourcarrierbtsnum              ,
cellnum                        ,
onecarriercellnum              ,
twocarriercellnum              ,
threecarriercellnum            ,
fourcarriercellnum             ,
cenum                          ,
wirecapacity                   ,
tchnum                         ,
tchloadrate                    ,
shofactor                      ,
ceavailrate                    ,
tchblockfailrate               ,
busyercellratio                ,
busycellratio                  ,
freecellratio                  ,
serioverflowbtsratio           ,
overflowbtsratio               ,
btssyshardhosuccrate           ,
sysshosuccrate                 ,
tchradiofrate                  ,
callinterruptrate              ,
avgradiofperiod                ,
badcellratio                   ,
ceavailnum                     ,
tchblockfailnumincludeho       ,
tchloadtrafficincludeho        ,
tchloadtrafficexcludeho        ,
loadtrafficbywalsh             ,
trafficcarrier1                ,
trafficcarrier2                ,
trafficcarrier3                ,
trafficcarrier4                ,
busyercellnum                  ,
busycellnum                    ,
freecellnum                    ,
badcellnum                     ,
serioverflowbtsnum             ,
overflowbtsnum                 ,
tchreqnumcallerexcludehosms    ,
tchsuccnumcallerexcludehosms    ,
tchreqnumcalleeexcludehosms    ,
tchsuccnumcalleeexcludehosms    ,
tchreqnumexcludehosms          ,
tchsuccnumexcludehosms         ,
tchreqnumincludehosms          ,
tchsuccnumincludehosms         ,
btssyshardhoreqnum             ,
btssyshardhosuccnum            ,
sysshoreqnum                   ,
sysshosuccnum                  ,
tchradiofnum                   ,
callpagereqtotalnum            ,
numfailofcall                  ,
ps_numfailofcall               ,
cs_numfailofcall
)
select
int_id                         ,
v_date                ,
0                      ,
10004                        ,
7                      ,
sum(nvl(callpagereqnum                 ,0)),
sum(nvl(callpagesuccnum                ,0)),
sum(nvl(callpagesuccrate               ,0)),
sum(nvl(cs_callpagereqnum              ,0)),
sum(nvl(cs_callpagesuccnum             ,0)),
sum(nvl(cs_callpagesuccrate            ,0)),
sum(nvl(ps_callpagereqnum              ,0)),
sum(nvl(ps_callpagesuccnum             ,0)),
sum(nvl(ps_callpagesuccrate            ,0)),
sum(nvl(trafficincludeho               ,0)),
sum(nvl(trafficexcludeho               ,0)),
sum(nvl(cs_trafficincludeho            ,0)),
sum(nvl(cs_trafficexcludeho            ,0)),
sum(nvl(cs_trafficbywalsh              ,0)),
sum(nvl(cs_shotraffic                  ,0)),
sum(nvl(cs_sshotraffic                 ,0)),
sum(nvl(cs_shorate                     ,0)),
sum(nvl(ps_calltrafficincludeho        ,0)),
sum(nvl(ps_calltrafficexcludeho        ,0)),
sum(nvl(ps_trafficbywalsh              ,0)),
sum(nvl(ps_shotraffic                  ,0)),
sum(nvl(ps_sshotraffic                 ,0)),
sum(nvl(ps_shorate                     ,0)),
sum(nvl(losecallingnum                 ,0)),
sum(nvl(losecallingrate                ,0)),
sum(nvl(losecallingratio               ,0)),
sum(nvl(cs_losecallingnum              ,0)),
sum(nvl(cs_losecallingrate             ,0)),
sum(nvl(cs_losecallingratio            ,0)),
sum(nvl(ps_losecallingnum              ,0)),
sum(nvl(ps_losecallingrate             ,0)),
sum(nvl(ps_losecallingratio            ,0)),
sum(nvl(tchreqnumincludeho             ,0)),
sum(nvl(tchsuccnumincludeho            ,0)),
sum(nvl(tchfnumincludeho               ,0)),
sum(nvl(tchsuccincludehorate           ,0)),
sum(nvl(tchreqnumexcludeho             ,0)),
sum(nvl(tchsuccnumexcludeho            ,0)),
sum(nvl(tchfnumexcludeho               ,0)),
sum(nvl(tchsuccexcludehorate           ,0)),
sum(nvl(callblockfailnum               ,0)),
sum(nvl(callblockfailrate              ,0)),
sum(nvl(cs_tchreqnumincludeho          ,0)),
sum(nvl(cs_tchsuccnumincludeho         ,0)),
sum(nvl(cs_tchfnumincludeho            ,0)),
sum(nvl(cs_tchsuccincludehorate        ,0)),
sum(nvl(cs_tchreqnumexcludeho          ,0)),
sum(nvl(cs_tchsuccnumexcludeho         ,0)),
sum(nvl(cs_tchfnumexcludeho            ,0)),
sum(nvl(cs_tchsuccexcludehorate        ,0)),
sum(nvl(cs_callblockfailnum            ,0)),
sum(nvl(cs_callblockfailrate           ,0)),
sum(nvl(cs_tchreqnumhardho             ,0)),
sum(nvl(cs_tchsuccnumhardho            ,0)),
sum(nvl(cs_callblockfailratehardho     ,0)),
sum(nvl(cs_tchreqnumsoftho             ,0)),
sum(nvl(cs_tchsuccnumsoftho            ,0)),
sum(nvl(cs_callblockfailratesoftho     ,0)),
sum(nvl(ps_tchreqnumincludeho          ,0)),
sum(nvl(ps_tchsuccnumincludeho         ,0)),
sum(nvl(ps_tchfnumincludeho            ,0)),
sum(nvl(ps_tchsuccincludehorate        ,0)),
sum(nvl(ps_tchreqnumexcludeho          ,0)),
sum(nvl(ps_tchsuccnumexcludeho         ,0)),
sum(nvl(ps_tchfnumexcludeho            ,0)),
sum(nvl(ps_tchsuccexcludehorate        ,0)),
sum(nvl(ps_callblockfailnum            ,0)),
sum(nvl(ps_callblockfailrate           ,0)),
sum(nvl(ps_tchreqnumhardho             ,0)),
sum(nvl(ps_tchsuccnumhardho            ,0)),
sum(nvl(ps_callblockfailratehardho     ,0)),
sum(nvl(ps_tchreqnumsoftho             ,0)),
sum(nvl(ps_tchsuccnumsoftho            ,0)),
sum(nvl(ps_callblockfailratesoftho     ,0)),
sum(nvl(handoffreqnum                  ,0)),
sum(nvl(handoffsuccnum                 ,0)),
sum(nvl(handoffsuccrate                ,0)),
sum(nvl(cs_handoffreqnum               ,0)),
sum(nvl(cs_handoffsuccnum              ,0)),
sum(nvl(cs_handoffsuccrate             ,0)),
sum(nvl(cs_hardhoreqnum                ,0)),
sum(nvl(cs_hardhosuccnum               ,0)),
sum(nvl(cs_hardhosuccrate              ,0)),
sum(nvl(cs_softhoreqnum                ,0)),
sum(nvl(cs_softhosuccnum               ,0)),
sum(nvl(cs_softhosuccrate              ,0)),
sum(nvl(cs_ssofthoreqnum               ,0)),
sum(nvl(cs_ssofthosuccnum              ,0)),
sum(nvl(cs_ssofthosuccrate             ,0)),
sum(nvl(ps_handoffreqnum               ,0)),
sum(nvl(ps_handoffsuccnum              ,0)),
sum(nvl(ps_handoffsuccrate             ,0)),
sum(nvl(ps_hardhoreqnum                ,0)),
sum(nvl(ps_hardhosuccnum               ,0)),
sum(nvl(ps_hardhosuccrate              ,0)),
sum(nvl(ps_softhoreqnum                ,0)),
sum(nvl(ps_softhosuccnum               ,0)),
sum(nvl(ps_softhosuccrate              ,0)),
sum(nvl(ps_ssofthoreqnum               ,0)),
sum(nvl(ps_ssofthosuccnum              ,0)),
sum(nvl(ps_ssofthosuccrate             ,0)),
sum(nvl(handoffreqnum_intra            ,0)),
sum(nvl(handoffsuccnum_intra           ,0)),
sum(nvl(handoffsuccrate_intra          ,0)),
sum(nvl(handoffreqnum_extra            ,0)),
sum(nvl(handoffsuccnum_extra           ,0)),
sum(nvl(handoffsuccrate_extra          ,0)),
sum(nvl(hardhoreqnum_intra             ,0)),
sum(nvl(hardhosuccnum_intra            ,0)),
sum(nvl(hardhosuccrate_intra           ,0)),
sum(nvl(shoreqnum_intra                ,0)),
sum(nvl(shosuccnum_intra               ,0)),
sum(nvl(shosuccrate_intra              ,0)),
sum(nvl(sshoreqnum_intra               ,0)),
sum(nvl(sshosuccnum_intra              ,0)),
sum(nvl(sshosuccrate_intra             ,0)),
sum(nvl(hardhoreqnum_extra             ,0)),
sum(nvl(hardhosuccnum_extra            ,0)),
sum(nvl(hardhosuccrate_extra           ,0)),
sum(nvl(shoreqnum_extra                ,0)),
sum(nvl(shosuccnum_extra               ,0)),
sum(nvl(shosuccrate_extra              ,0)),
sum(nvl(carrier1btsnum                 ,0)),
sum(nvl(carrier2btsnum                 ,0)),
sum(nvl(carrier3btsnum                 ,0)),
sum(nvl(carrier4btsnum                 ,0)),
sum(nvl(carriernum_1x                  ,0)),
sum(nvl(channelnum                     ,0)),
sum(nvl(channelavailnum                ,0)),
sum(nvl(channelmaxusenum               ,0)),
sum(nvl(channelmaxuserate              ,0)),
sum(nvl(fwdchnum                       ,0)),
sum(nvl(fwdchavailnum                  ,0)),
sum(nvl(fwdchmaxusenum                 ,0)),
sum(nvl(fwdchmaxuserate                ,0)),
sum(nvl(revchnum                       ,0)),
sum(nvl(revchavailnum                  ,0)),
sum(nvl(revchmaxusenum                 ,0)),
sum(nvl(revchmaxuserate                ,0)),
sum(nvl(fwdrxtotalframe                ,0)),
sum(nvl(fdwtxtotalframeexcluderx       ,0)),
sum(nvl(rlpfwdchsizeexcluderx          ,0)),
sum(nvl(rlpfwdchrxsize                 ,0)),
sum(nvl(rlpfwdlosesize                 ,0)),
sum(nvl(fwdchrxrate                    ,0)),
sum(nvl(revrxtotalframe                ,0)),
sum(nvl(revtxtotalframeexcluderx       ,0)),
sum(nvl(rlprevchsize                   ,0)),
sum(nvl(revchrxrate                    ,0)),
sum(nvl(btsnum                         ,0)),
sum(nvl(onecarrierbtsnum               ,0)),
sum(nvl(twocarrierbtsnum               ,0)),
sum(nvl(threecarrierbtsnum             ,0)),
sum(nvl(fourcarrierbtsnum              ,0)),
sum(nvl(cellnum                        ,0)),
sum(nvl(onecarriercellnum              ,0)),
sum(nvl(twocarriercellnum              ,0)),
sum(nvl(threecarriercellnum            ,0)),
sum(nvl(fourcarriercellnum             ,0)),
sum(nvl(cenum                          ,0)),
sum(nvl(wirecapacity                   ,0)),
sum(nvl(tchnum                         ,0)),
sum(nvl(tchloadrate                    ,0)),
sum(nvl(shofactor                      ,0)),
sum(nvl(ceavailrate                    ,0)),
sum(nvl(tchblockfailrate               ,0)),
sum(nvl(busyercellratio                ,0)),
sum(nvl(busycellratio                  ,0)),
sum(nvl(freecellratio                  ,0)),
sum(nvl(serioverflowbtsratio           ,0)),
sum(nvl(overflowbtsratio               ,0)),
sum(nvl(btssyshardhosuccrate           ,0)),
sum(nvl(sysshosuccrate                 ,0)),
sum(nvl(tchradiofrate                  ,0)),
sum(nvl(callinterruptrate              ,0)),
sum(nvl(avgradiofperiod                ,0)),
sum(nvl(badcellratio                   ,0)),
sum(nvl(ceavailnum                     ,0)),
sum(nvl(tchblockfailnumincludeho       ,0)),
sum(nvl(tchloadtrafficincludeho        ,0)),
sum(nvl(tchloadtrafficexcludeho        ,0)),
sum(nvl(loadtrafficbywalsh             ,0)),
sum(nvl(trafficcarrier1                ,0)),
sum(nvl(trafficcarrier2                ,0)),
sum(nvl(trafficcarrier3                ,0)),
sum(nvl(trafficcarrier4                ,0)),
sum(nvl(busyercellnum                  ,0)),
sum(nvl(busycellnum                    ,0)),
sum(nvl(freecellnum                    ,0)),
sum(nvl(badcellnum                     ,0)),
sum(nvl(serioverflowbtsnum             ,0)),
sum(nvl(overflowbtsnum                 ,0)),
sum(nvl(tchreqnumcallerexcludehosms    ,0)),
sum(nvl(tchsuccnumcallerexcludehosms   ,0) ),
sum(nvl(tchreqnumcalleeexcludehosms    ,0)),
sum(nvl(tchsuccnumcalleeexcludehosms   ,0) ),
sum(nvl(tchreqnumexcludehosms          ,0)),
sum(nvl(tchsuccnumexcludehosms         ,0)),
sum(nvl(tchreqnumincludehosms          ,0)),
sum(nvl(tchsuccnumincludehosms         ,0)),
sum(nvl(btssyshardhoreqnum             ,0)),
sum(nvl(btssyshardhosuccnum            ,0)),
sum(nvl(sysshoreqnum                   ,0)),
sum(nvl(sysshosuccnum                  ,0)),
sum(nvl(tchradiofnum                   ,0)),
sum(nvl(callpagereqtotalnum            ,0)),
sum(nvl(numfailofcall                  ,0)),
sum(nvl(ps_CallPageReqNum,0) - nvl(ps_CallPageSuccNum,0)) ps_Numfailofcall,
sum(nvl(cs_numfailofcall               ,0))

from C_PERF_1X_SUM_ZX_TEMP
group by int_id;


commit;
dbms_output.put_line('Now time:'||sysdate||'-');

v_sql:='truncate table C_PERF_1X_SUM_ZX_TEMP';
dbms_output.put_line(v_sql);
execute immediate v_sql;
dbms_output.put_line('Now time:'||sysdate||'-');

v_sql:='truncate table C_TPD_1X_SUM_ZX_TEMP';
dbms_output.put_line(v_sql);
execute immediate v_sql;
dbms_output.put_line('Now time:'||sysdate||'-');
commit;

----------------------------------------------------------------------------------end city
insert /*+ APPEND*/ into C_PERF_1X_SUM
(
int_id                         ,
scan_start_time                ,
sum_level                      ,
ne_type                        ,
vendor_id                      ,
callpagereqnum                 ,
callpagesuccnum                ,
callpagesuccrate               ,
cs_callpagereqnum              ,
cs_callpagesuccnum             ,
cs_callpagesuccrate            ,
ps_callpagereqnum              ,
ps_callpagesuccnum             ,
ps_callpagesuccrate            ,
trafficincludeho               ,
trafficexcludeho               ,
cs_trafficincludeho            ,
cs_trafficexcludeho            ,
cs_trafficbywalsh              ,
cs_shotraffic                  ,
cs_sshotraffic                 ,
cs_shorate                     ,
ps_calltrafficincludeho        ,
ps_calltrafficexcludeho        ,
ps_trafficbywalsh              ,
ps_shotraffic                  ,
ps_sshotraffic                 ,
ps_shorate                     ,
losecallingnum                 ,
losecallingrate                ,
losecallingratio               ,
cs_losecallingnum              ,
cs_losecallingrate             ,
cs_losecallingratio            ,
ps_losecallingnum              ,
ps_losecallingrate             ,
ps_losecallingratio            ,
tchreqnumincludeho             ,
tchsuccnumincludeho            ,
tchfnumincludeho               ,
tchsuccincludehorate           ,
tchreqnumexcludeho             ,
tchsuccnumexcludeho            ,
tchfnumexcludeho               ,
tchsuccexcludehorate           ,
callblockfailnum               ,
callblockfailrate              ,
cs_tchreqnumincludeho          ,
cs_tchsuccnumincludeho         ,
cs_tchfnumincludeho            ,
cs_tchsuccincludehorate        ,
cs_tchreqnumexcludeho          ,
cs_tchsuccnumexcludeho         ,
cs_tchfnumexcludeho            ,
cs_tchsuccexcludehorate        ,
cs_callblockfailnum            ,
cs_callblockfailrate           ,
cs_tchreqnumhardho             ,
cs_tchsuccnumhardho            ,
cs_callblockfailratehardho     ,
cs_tchreqnumsoftho             ,
cs_tchsuccnumsoftho            ,
cs_callblockfailratesoftho     ,
ps_tchreqnumincludeho          ,
ps_tchsuccnumincludeho         ,
ps_tchfnumincludeho            ,
ps_tchsuccincludehorate        ,
ps_tchreqnumexcludeho          ,
ps_tchsuccnumexcludeho         ,
ps_tchfnumexcludeho            ,
ps_tchsuccexcludehorate        ,
ps_callblockfailnum            ,
ps_callblockfailrate           ,
ps_tchreqnumhardho             ,
ps_tchsuccnumhardho            ,
ps_callblockfailratehardho     ,
ps_tchreqnumsoftho             ,
ps_tchsuccnumsoftho            ,
ps_callblockfailratesoftho     ,
handoffreqnum                  ,
handoffsuccnum                 ,
handoffsuccrate                ,
cs_handoffreqnum               ,
cs_handoffsuccnum              ,
cs_handoffsuccrate             ,
cs_hardhoreqnum                ,
cs_hardhosuccnum               ,
cs_hardhosuccrate              ,
cs_softhoreqnum                ,
cs_softhosuccnum               ,
cs_softhosuccrate              ,
cs_ssofthoreqnum               ,
cs_ssofthosuccnum              ,
cs_ssofthosuccrate             ,
ps_handoffreqnum               ,
ps_handoffsuccnum              ,
ps_handoffsuccrate             ,
ps_hardhoreqnum                ,
ps_hardhosuccnum               ,
ps_hardhosuccrate              ,
ps_softhoreqnum                ,
ps_softhosuccnum               ,
ps_softhosuccrate              ,
ps_ssofthoreqnum               ,
ps_ssofthosuccnum              ,
ps_ssofthosuccrate             ,
handoffreqnum_intra            ,
handoffsuccnum_intra           ,
handoffsuccrate_intra          ,
handoffreqnum_extra            ,
handoffsuccnum_extra           ,
handoffsuccrate_extra          ,
hardhoreqnum_intra             ,
hardhosuccnum_intra            ,
hardhosuccrate_intra           ,
shoreqnum_intra                ,
shosuccnum_intra               ,
shosuccrate_intra              ,
sshoreqnum_intra               ,
sshosuccnum_intra              ,
sshosuccrate_intra             ,
hardhoreqnum_extra             ,
hardhosuccnum_extra            ,
hardhosuccrate_extra           ,
shoreqnum_extra                ,
shosuccnum_extra               ,
shosuccrate_extra              ,
carrier1btsnum                 ,
carrier2btsnum                 ,
carrier3btsnum                 ,
carrier4btsnum                 ,
carriernum_1x                  ,
channelnum                     ,
channelavailnum                ,
channelmaxusenum               ,
channelmaxuserate              ,
fwdchnum                       ,
fwdchavailnum                  ,
fwdchmaxusenum                 ,
fwdchmaxuserate                ,
revchnum                       ,
revchavailnum                  ,
revchmaxusenum                 ,
revchmaxuserate                ,
fwdrxtotalframe                ,
fdwtxtotalframeexcluderx       ,
rlpfwdchsizeexcluderx          ,
rlpfwdchrxsize                 ,
rlpfwdlosesize                 ,
fwdchrxrate                    ,
revrxtotalframe                ,
revtxtotalframeexcluderx       ,
rlprevchsize                   ,
revchrxrate                    ,
btsnum                         ,
onecarrierbtsnum               ,
twocarrierbtsnum               ,
threecarrierbtsnum             ,
fourcarrierbtsnum              ,
cellnum                        ,
onecarriercellnum              ,
twocarriercellnum              ,
threecarriercellnum            ,
fourcarriercellnum             ,
cenum                          ,
wirecapacity                   ,
tchnum                         ,
tchloadrate                    ,
shofactor                      ,
ceavailrate                    ,
tchblockfailrate               ,
busyercellratio                ,
busycellratio                  ,
freecellratio                  ,
serioverflowbtsratio           ,
overflowbtsratio               ,
btssyshardhosuccrate           ,
sysshosuccrate                 ,
tchradiofrate                  ,
callinterruptrate              ,
avgradiofperiod                ,
badcellratio                   ,
ceavailnum                     ,
tchblockfailnumincludeho       ,
tchloadtrafficincludeho        ,
tchloadtrafficexcludeho        ,
loadtrafficbywalsh             ,
trafficcarrier1                ,
trafficcarrier2                ,
trafficcarrier3                ,
trafficcarrier4                ,
busyercellnum                  ,
busycellnum                    ,
freecellnum                    ,
badcellnum                     ,
serioverflowbtsnum             ,
overflowbtsnum                 ,
tchreqnumcallerexcludehosms    ,
tchsuccnumcallerexcludehosms    ,
tchreqnumcalleeexcludehosms    ,
tchsuccnumcalleeexcludehosms    ,
tchreqnumexcludehosms          ,
tchsuccnumexcludehosms         ,
tchreqnumincludehosms          ,
tchsuccnumincludehosms         ,
btssyshardhoreqnum             ,
btssyshardhosuccnum            ,
sysshoreqnum                   ,
sysshosuccnum                  ,
tchradiofnum                   ,
callpagereqtotalnum            ,
numfailofcall                  ,
ps_numfailofcall               ,
cs_numfailofcall
)
with a as
(
select
r.province_id province_id,
round(100*sum(nvl(a.MaxBusyFCENum,0)+nvl(a.MaxBusyRCENum,0))/
decode(sum(nvl(a.ReliableFCENum,0)+nvl(a.ReliableRCENum,0)),0,1,sum(nvl(a.ReliableFCENum,0)+nvl(a.ReliableRCENum,0))),4)  ChannelMaxUseRate ,
round(100*sum(nvl(a.MaxBusyFCENum,0))/decode(sum(nvl(a.ReliableFCENum,0)),0,1,sum(nvl(a.ReliableFCENum,0))),4) FwdChMaxUseRate
from C_tpd_cnt_bts_zx a,c_bts c ,c_region_city r
where a.int_id = c.int_id and c.city_id=r.city_id and  a.scan_start_time = v_date
and c.vendor_id=7
group by r.province_id
),
b as(
select c.province_id province_id,
sum(cs_CallPageReqNum+ps_CallPageReqNum) CallPageReqNum              ,
sum(cs_CallPageSuccNum+ps_CallPageSuccNum) CallPageSuccNum             ,
sum(nvl(cs_CallPageReqNum,0) + nvl(ps_CallPageReqNum,0) - nvl(cs_CallPageSuccNum,0) - nvl(ps_CallPageSuccNum,0)) Numfailofcall,
sum(nvl(cs_CallPageReqNum,0) - nvl(cs_CallPageSuccNum,0)) cs_Numfailofcall,
round(100*sum(CallPageSuccNum)/decode(sum(CallPageReqNum),null,1,0,1,sum(CallPageReqNum)),4) CallPageSuccRate,
sum(cs_CallPageReqNum             ) cs_CallPageReqNum           ,
sum(cs_CallPageSuccNum            ) cs_CallPageSuccNum          ,
round(100*sum(cs_CallPageSuccNum)/decode(sum(cs_CallPageReqNum),0,1,null,1,sum(cs_CallPageReqNum)),4) cs_CallPageSuccRate         ,
sum(ps_CallPageReqNum             )                ps_CallPageReqNum           ,
sum(ps_CallPageSuccNum            )                ps_CallPageSuccNum          ,
round(100*sum(ps_CallPageSuccNum)/decode(sum(ps_CallPageReqNum),0,1,null,1,sum(ps_CallPageReqNum)),4) ps_CallPageSuccRate,
sum(TrafficIncludeHo              )                TrafficIncludeHo            ,
sum(TrafficExcludeHo              )                TrafficExcludeHo            ,
sum(cs_TrafficIncludeHo           )                cs_TrafficIncludeHo         ,
sum(cs_TrafficExcludeHo           ) cs_TrafficExcludeHo         ,
sum(cs_trafficByWalsh             )                cs_trafficByWalsh           ,
sum(cs_SHOTraffic                 )                cs_SHOTraffic               ,
sum(cs_SSHOTraffic                )                cs_SSHOTraffic              ,
round(100*sum(cs_SHOTraffic)/decode(sum(cs_TrafficExcludeHo+cs_SHOTraffic),null,1,0,1,sum(cs_TrafficExcludeHo+cs_SHOTraffic)),4) cs_SHORate,
sum(ps_CallTrafficIncludeHo       )                ps_CallTrafficIncludeHo     ,
sum(ps_CallTrafficExcludeHo       )                ps_CallTrafficExcludeHo     ,
sum(ps_trafficByWalsh             )                ps_trafficByWalsh           ,
sum(ps_SHOTraffic                 )                ps_SHOTraffic               ,
sum(ps_SSHOTraffic                )                ps_SSHOTraffic              ,
round(100*sum(ps_SHOTraffic)/decode(sum(ps_CallTrafficExcludeHo + ps_SHOTraffic),null,1,0,1,sum(ps_CallTrafficExcludeHo + ps_SHOTraffic)),4) ps_SHORate                  ,
sum(LoseCallingNum                ) LoseCallingNum              ,
round(100*sum(LoseCallingNum)/decode(sum(TchSuccNumExcludeHo),0,1,null,1,sum(TchSuccNumExcludeHo)),4) LoseCallingRate             ,
round(60*sum(nvl(TrafficExcludeHo,0))/decode(sum(nvl(LoseCallingNum ,0)),0,1,sum(nvl(LoseCallingNum ,0))),4)  LoseCallingratio,
sum(cs_LoseCallingNum             )  cs_LoseCallingNum           ,
round(100*sum(cs_LoseCallingNum)/decode(sum(cs_TchSuccNumExcludeHo),null,1,0,1,sum(cs_TchSuccNumExcludeHo)),4) cs_LoseCallingRate          ,
case when sum(cs_LoseCallingNum) is null then 1000
     when sum(cs_LoseCallingNum) = 0     then 1000
else round(sum(nvl(cs_TrafficExcludeHo,0))*60/sum(cs_LoseCallingNum),4)
end                                                           cs_LoseCallingratio,
sum(ps_LoseCallingNum             )                ps_LoseCallingNum           ,
round(100*sum(ps_LoseCallingNum)/decode(sum(ps_TchSuccNumExcludeHo),null,1,0,1,sum(ps_TchSuccNumExcludeHo)),4) ps_LoseCallingRate          ,
round(60*sum(nvl(ps_CallTrafficExcludeHo,0))/decode(sum(nvl(ps_LoseCallingNum ,0)),0,1,sum(nvl(ps_LoseCallingNum ,0))),4)  ps_LoseCallingratio,
sum(TchReqNumIncludeHo            )                TchReqNumIncludeHo          ,
sum(TchSuccNumIncludeHo           )                TchSuccNumIncludeHo         ,
sum(TchFNumIncludeHo              )                TchFNumIncludeHo            ,
round(100*sum(TchSuccNumIncludeHo)/decode(sum(TchReqNumIncludeHo),null,1,0,1,sum(TchReqNumIncludeHo)),4) TchSuccIncludeHoRate        ,
sum(TchReqNumExcludeHo            )                TchReqNumExcludeHo          ,
sum(TchSuccNumExcludeHo           ) TchSuccNumExcludeHo         ,
sum(TchFNumExcludeHo              )                TchFNumExcludeHo            ,
round(100*sum(TchSuccNumExcludeHo)/decode(sum(TchReqNumExcludeHo),null,1,0,1,sum(TchReqNumExcludeHo)),4) TchSuccExcludeHoRate        ,
sum(CallBlockFailNum              )                CallBlockFailNum            ,
round(100*sum(CallBlockFailNum)/decode(sum(TchReqNumIncludeHo),null,1,0,1,sum(TchReqNumIncludeHo)),4)  CallBlockFailRate  ,
sum(cs_TchReqNumIncludeHo         )                cs_TchReqNumIncludeHo       ,
sum(cs_TchSuccNumIncludeHo        )                cs_TchSuccNumIncludeHo      ,
sum(cs_TchFNumIncludeHo           )                cs_TchFNumIncludeHo         ,
round(100*sum(nvl(cs_TchSuccNumIncludeHo,0))/decode(sum(nvl(cs_TchReqNumIncludeHo,0)),0,1,sum(nvl(cs_TchReqNumIncludeHo,0))),4)  cs_TchSuccIncludeHoRate,
sum(cs_TchReqNumExcludeHo         )                cs_TchReqNumExcludeHo       ,
sum(cs_TchSuccNumExcludeHo        )                cs_TchSuccNumExcludeHo      ,
sum(cs_TchFNumExcludeHo           )                cs_TchFNumExcludeHo         ,
round(100*sum(cs_TchSuccNumExcludeHo)/decode(sum(cs_TchReqNumExcludeHo),null,1,0,1,sum(cs_TchReqNumExcludeHo)),4) cs_TchSuccExcludeHoRate,
sum(cs_CallBlockFailNum           )                cs_CallBlockFailNum         ,
round(100*sum(nvl(cs_CallBlockFailNum,0))/decode(sum(nvl(cs_TchReqNumIncludeHo,0)),0,1,sum(nvl(cs_TchReqNumIncludeHo,0))),4)  cs_CallBlockFailRate,
sum(cs_TchReqNumHardho            )                cs_TchReqNumHardho          ,
sum(cs_TchSuccNumHardho           )                cs_TchSuccNumHardho         ,
round(sum(cs_CallBlockFailRateHardho    ),4)                cs_CallBlockFailRateHardho  ,
sum(cs_TchReqNumsoftho            )                cs_TchReqNumsoftho          ,
sum(cs_TchSuccNumsoftho           )                cs_TchSuccNumsoftho         ,
round(sum(cs_CallBlockFailRatesoftho    ),4)                cs_CallBlockFailRatesoftho  ,
sum(ps_TchReqNumIncludeHo         )                ps_TchReqNumIncludeHo       ,
sum(ps_TchSuccNumIncludeHo        )                ps_TchSuccNumIncludeHo      ,
sum(ps_TchFNumIncludeHo           )                ps_TchFNumIncludeHo         ,
round(100*sum(nvl(ps_TchSuccNumIncludeHo,0))/decode(sum(nvl(ps_TchReqNumIncludeHo,0)),0,1,sum(nvl(ps_TchReqNumIncludeHo,0))),4)  ps_TchSuccIncludeHoRate,
sum(ps_TchReqNumExcludeHo         )                ps_TchReqNumExcludeHo       ,
sum(ps_TchSuccNumExcludeHo        )                ps_TchSuccNumExcludeHo      ,
sum(ps_TchFNumExcludeHo           )                ps_TchFNumExcludeHo         ,
round(100*sum(nvl(ps_TchSuccNumExcludeHo,0))/decode(sum(nvl(ps_TchReqNumExcludeHo,0)),0,1,sum(nvl(ps_TchReqNumExcludeHo,0))),4)  ps_TchSuccExcludeHoRate,
sum(ps_CallBlockFailNum           )                ps_CallBlockFailNum         ,
round(100*sum(ps_TchReqNumHardho-ps_TchSuccNumHardho)/decode(sum(ps_TchReqNumHardho),null,1,0,1,sum(ps_TchReqNumHardho)),4) ps_CallBlockFailRate        ,
sum(ps_TchReqNumHardho            )                ps_TchReqNumHardho          ,
sum(ps_TchSuccNumHardho           )                ps_TchSuccNumHardho         ,
round(100*sum(ps_TchReqNumHardho-ps_TchSuccNumHardho)/decode(sum(ps_TchReqNumHardho),null,1,0,1,sum(ps_TchReqNumHardho)),4) ps_CallBlockFailRateHardho,
sum(ps_TchReqNumsoftho            )                ps_TchReqNumsoftho          ,
sum(ps_TchSuccNumsoftho           )                ps_TchSuccNumsoftho         ,
round(sum(ps_CallBlockFailRatesoftho    ),4)                ps_CallBlockFailRatesoftho  ,
sum(HandoffReqNum                 )                HandoffReqNum               ,
sum(HandoffSuccNum                )                HandoffSuccNum              ,
round(100*sum(nvl(HandoffSuccNum,0))/decode(sum(nvl(HandoffReqNum,0)),0,1,sum(nvl(HandoffReqNum,0))),4)  HandoffSuccRate,
sum(cs_HandoffReqNum              )                cs_HandoffReqNum            ,
sum(cs_HandoffSuccNum             )                cs_HandoffSuccNum           ,
round(100*sum(nvl(cs_HandoffSuccNum,0))/decode(sum(nvl(cs_HandoffReqNum,0)),0,1,sum(nvl(cs_HandoffReqNum,0))),4)  cs_HandoffSuccRate,
sum(cs_HardhoReqNum               )                cs_HardhoReqNum             ,
sum(cs_HardhoSuccNum              )                cs_HardhoSuccNum            ,
case when   sum(cs_HardhoReqNum) is null  then  100
     when   sum(cs_HardhoReqNum)   =  0   then  100
else  round(100*sum(nvl(cs_HardhoSuccNum,0))/sum(cs_HardhoReqNum),4)
end                                                          cs_HardhoSuccRate,
sum(cs_SofthoReqNum               )                cs_SofthoReqNum             ,
sum(cs_SofthoSuccNum              )                cs_SofthoSuccNum            ,
round(100*sum(nvl(cs_SofthoSuccNum,0))/decode(sum(nvl(cs_SofthoReqNum,0)),0,1,sum(nvl(cs_SofthoReqNum,0))),4)  cs_SofthoSuccRate,
sum(cs_SSofthoReqNum              )                cs_SSofthoReqNum            ,
sum(cs_SSofthoSuccNum             )                cs_SSofthoSuccNum           ,
round(100*sum(nvl(cs_SSofthoSuccNum,0))/decode(sum(nvl(cs_SSofthoReqNum,0)),0,1,sum(nvl(cs_SSofthoReqNum,0))),4)  cs_SSofthoSuccRate,
sum(ps_HandoffReqNum              )                ps_HandoffReqNum            ,
sum(ps_HandoffSuccNum             )                ps_HandoffSuccNum           ,
round(100*sum(nvl(ps_HandoffSuccNum,0))/decode(sum(nvl(ps_HandoffReqNum,0)),0,1,sum(nvl(ps_HandoffReqNum,0))),4)  ps_HandoffSuccRate,
sum(ps_HardhoReqNum               )                ps_HardhoReqNum             ,
sum(ps_HardhoSuccNum              )                ps_HardhoSuccNum            ,
round(100*sum(nvl(ps_HardhoSuccNum,0))/decode(sum(nvl(ps_HardhoReqNum,0)),0,1,sum(nvl(ps_HardhoReqNum,0))),4)  ps_HardhoSuccRate,
sum(ps_SofthoReqNum               )                ps_SofthoReqNum             ,
sum(ps_SofthoSuccNum              )                ps_SofthoSuccNum            ,
round(100*sum(nvl(ps_SofthoSuccNum,0))/decode(sum(nvl(ps_SofthoReqNum,0)),0,1,sum(nvl(ps_SofthoReqNum,0))),4)  ps_SofthoSuccRate,
sum(ps_SSofthoReqNum              )                ps_SSofthoReqNum            ,
sum(ps_SSofthoSuccNum             )                ps_SSofthoSuccNum           ,
round(100*sum(nvl(ps_SSofthoSuccNum,0))/decode(sum(nvl(ps_SSofthoReqNum,0)),0,1,sum(nvl(ps_SSofthoReqNum,0))),4)  ps_SSofthoSuccRate,
sum(HandoffReqNum_intra           )                HandoffReqNum_intra         ,
sum(HandoffSuccNum_intra          )                HandoffSuccNum_intra        ,
round(100*sum(nvl(HandoffSuccNum_intra,0))/decode(sum(nvl(HandoffReqNum_intra,0)),0,1,sum(nvl(HandoffReqNum_intra,0))),4)  HandoffSuccRate_intra,
sum(HandoffReqNum_Extra           )                HandoffReqNum_Extra         ,
sum(HandoffSuccNum_Extra          )                HandoffSuccNum_Extra        ,
round(100*sum(nvl(HandoffSuccNum_Extra,0))/decode(sum(nvl(HandoffReqNum_Extra,0)),0,1,sum(nvl(HandoffReqNum_Extra,0))),4)  HandoffSuccRate_Extra,
sum(HardhoReqNum_intra            )                HardhoReqNum_intra          ,
sum(HardhoSuccNum_intra           )                HardhoSuccNum_intra         ,
round(100*sum(nvl(HardhoSuccNum_intra,0))/decode(sum(nvl(HardhoReqNum_intra,0)),0,1,sum(nvl(HardhoReqNum_intra,0))),4)  HardhoSuccRate_intra,
sum(ShoReqNum_intra               )                ShoReqNum_intra             ,
sum(ShoSuccNum_intra              )                ShoSuccNum_intra            ,
round(100*sum(nvl(ShoSuccNum_intra,0))/decode(sum(nvl(ShoReqNum_intra,0)),0,1,sum(nvl(ShoReqNum_intra,0))),4)  ShoSuccRate_intra,
sum(SShoReqNum_intra              )                SShoReqNum_intra            ,
sum(SShoSuccNum_intra             )                SShoSuccNum_intra           ,
round(100*sum(nvl(SShoSuccNum_intra,0))/decode(sum(nvl(SShoReqNum_intra,0)),0,1,sum(nvl(SShoReqNum_intra,0))),4)  SShoSuccRate_intra,
sum(HardhoReqNum_Extra            )                HardhoReqNum_Extra          ,
sum(HardhoSuccNum_Extra           )                HardhoSuccNum_Extra         ,
round(100*sum(nvl(HardhoSuccNum_Extra,0))/decode(sum(nvl(HardhoReqNum_Extra,0)),0,1,sum(nvl(HardhoReqNum_Extra,0))),4)  HardhoSuccRate_Extra,
sum(ShoReqNum_Extra               )                ShoReqNum_Extra             ,
sum(ShoSuccNum_Extra              )                ShoSuccNum_Extra            ,
round(100*sum(nvl(ShoSuccNum_Extra,0))/decode(sum(nvl(ShoReqNum_Extra,0)),0,1,sum(nvl(ShoReqNum_Extra,0))),4)  ShoSuccRate_Extra,
sum(Carrier1BtsNum                )                Carrier1BtsNum              ,
sum(Carrier2BtsNum                )                Carrier2BtsNum              ,
sum(Carrier3BtsNum                )                Carrier3BtsNum              ,
sum(Carrier4BtsNum                )                Carrier4BtsNum              ,
sum(CARRIERNUM_1X                 )                CARRIERNUM_1X               ,
sum(ChannelNum                    )                ChannelNum                  ,
sum(ChannelAvailNum               )                ChannelAvailNum             ,
sum(ChannelMaxUseNum              )                ChannelMaxUseNum            ,
sum(FwdChNum                      )                FwdChNum                    ,
sum(FwdChAvailNum                 )                FwdChAvailNum               ,
sum(FwdChMaxUseNum                )                FwdChMaxUseNum              ,
sum(RevChNum                      )                RevChNum                    ,
sum(RevChAvailNum                 )                RevChAvailNum               ,
sum(RevChMaxUseNum                )                RevChMaxUseNum              ,
round(sum(RevChMaxUseRate               )/decode(count(city_id),0,1,count(city_id)),4) RevChMaxUseRate             ,
sum(FwdRxTotalFrame               )                FwdRxTotalFrame             ,
sum(FdwTxTotalFrameExcludeRx      )                FdwTxTotalFrameExcludeRx    ,
sum(RLPFwdChSizeExcludeRx         )                RLPFwdChSizeExcludeRx       ,
sum(RLPFwdChRxSize                )                RLPFwdChRxSize              ,
sum(RLPFwdLoseSize                )                RLPFwdLoseSize              ,
round(sum(FwdChRxRate                   )/decode(count(city_id),0,1,count(city_id)),4) FwdChRxRate,
sum(RevRxTotalFrame               )                RevRxTotalFrame             ,
sum(RevTxTotalFrameExcludeRx      )                RevTxTotalFrameExcludeRx    ,
sum(RLPRevChSize                  )                RLPRevChSize                ,
round(100*sum(nvl(RevRxTotalFrame,0))/decode(sum(nvl(RevTxTotalFrameExcludeRx,0)),0,1,sum(nvl(RevTxTotalFrameExcludeRx,0))),4)  RevChRxRate,
sum(BtsNum                        )                BtsNum                      ,
sum(OnecarrierBtsNum              )                OnecarrierBtsNum            ,
sum(TwocarrierBtsNum              )                TwocarrierBtsNum            ,
sum(threecarrierBtsNum            )                threecarrierBtsNum          ,
sum(FourcarrierBtsNum             )                FourcarrierBtsNum           ,
sum(CellNum                       ) CellNum                     ,
sum(OnecarrierCellNum             )                OnecarrierCellNum           ,
sum(TwocarrierCellNum             )                TwocarrierCellNum           ,
sum(threecarrierCellNum           )                threecarrierCellNum         ,
sum(FourcarrierCellNum            )                FourcarrierCellNum          ,
sum(CENum                         )                CENum                       ,
sum(Wirecapacity                  )                Wirecapacity                ,
sum(TCHNum                        )                TCHNum                      ,
round(100*sum(nvl(TCHLoadTrafficIncludeHo,0))/decode(sum(nvl(Wirecapacity,0)),0,1,sum(nvl(Wirecapacity,0))),4)  TCHLoadRate,
round(100*sum(TCHLoadTrafficIncludeHo - TCHLoadTrafficExcludeHo)/decode(sum(TCHLoadTrafficExcludeHo),0,1,null,1,sum(TCHLoadTrafficExcludeHo)),4) SHoFactor,
round(100*sum(nvl(CEAvailNum,0))/decode(sum(nvl(CENum,0)),0,1,sum(nvl(CENum,0))),4)  CEAvailRate,
round(100*sum(nvl(TCHBlockFailNumIncludeHo,0))/decode(sum(nvl(TchReqNumIncludeHoSms,0)),0,1,sum(nvl(TchReqNumIncludeHoSms,0))),4)  TCHBlockFailRate,
round(sum(BusyerCellratio               )/count(city_id),4) BusyerCellratio             ,
round(sum(BusyCellratio                 )/count(city_id),4) BusyCellratio               ,
round(sum(FreeCellratio                 )/count(city_id),4) FreeCellratio               ,
round(sum(SeriOverflowBtsratio          )/count(city_id),4) SeriOverflowBtsratio        ,
round(sum(OverflowBtsratio              )/count(city_id),4) OverflowBtsratio            ,
round(100*sum(nvl(BtsSysHardHoSuccNum,0))/decode(sum(nvl(BtsSysHardHoReqNum,0)),0,1,sum(nvl(BtsSysHardHoReqNum,0))),4)  BtsSysHardHoSuccRate,
round(100*sum(SysSHoSuccNum)/decode(sum(SysSHoReqNum),null,1,0,1,sum(SysSHoReqNum)),4)  SysSHoSuccRate              ,
round(100*sum(nvl(TCHRadioFNum,0))/decode(sum(nvl(TchSuccNumCallerExcludeHoSms,0)+nvl(TchSuccNumCalleeExcludeHoSms,0)),0,1,sum(nvl(TchSuccNumCallerExcludeHoSms,0)+nvl(TchSuccNumCalleeExcludeHoSms,0))),4)  TchRadioFRate,
round(100*sum(nvl(TCHRadioFNum,0))/decode(sum(nvl(cs_CallPageReqNum,0)),0,1,sum(nvl(cs_CallPageReqNum,0))),4)  CallInterruptRate,
round(60*sum(TCHLoadTrafficExcludeHo)/decode(sum(TCHRadioFNum),null,1,0,1,sum(TCHRadioFNum)),4) AvgRadioFPeriod             ,
round(100*sum(nvl(BadCellNum,0))/decode(sum(CellNum),0,1,null,1,sum(CellNum)),4)  BadCellRatio,
sum(CEAvailNum                    )                CEAvailNum                  ,
sum(TCHBlockFailNumIncludeHo      )                TCHBlockFailNumIncludeHo    ,
sum(TCHLoadTrafficIncludeHo       )                TCHLoadTrafficIncludeHo     ,
sum(TCHLoadTrafficExcludeHo       )                TCHLoadTrafficExcludeHo     ,
sum(LoadTrafficByWalsh            )                LoadTrafficByWalsh          ,
sum(TrafficCarrier1               )                TrafficCarrier1             ,
sum(TrafficCarrier2               )                TrafficCarrier2             ,
sum(TrafficCarrier3               )                TrafficCarrier3             ,
sum(TrafficCarrier4               )                TrafficCarrier4             ,
sum(BusyerCellNum                 )                BusyerCellNum               ,
sum(BusyCellNum                   )                BusyCellNum                 ,
sum(FreeCellNum                   )                FreeCellNum                 ,
sum(BadCellNum                    ) BadCellNum                  ,
sum(SeriOverflowBtsNum            )                SeriOverflowBtsNum          ,
sum(OverflowBtsNum                )                OverflowBtsNum              ,
sum(TchReqNumCallerExcludeHoSms   )                TchReqNumCallerExcludeHoSms ,
sum(TchSuccNumCallerExcludeHoSms  )                TchSuccNumCallerExcludeHoSms,
sum(TchReqNumCalleeExcludeHoSms   )                TchReqNumCalleeExcludeHoSms ,
sum(TchSuccNumCalleeExcludeHoSms  )                TchSuccNumCalleeExcludeHoSms,
sum(TchReqNumExcludeHoSms         )                TchReqNumExcludeHoSms       ,
sum(TchSuccNumExcludeHoSms        )                TchSuccNumExcludeHoSms      ,
sum(TchReqNumIncludeHoSms         )                TchReqNumIncludeHoSms       ,
sum(TchSuccNumIncludeHoSms        )                TchSuccNumIncludeHoSms      ,
sum(BtsSysHardHoReqNum            )                BtsSysHardHoReqNum          ,
sum(BtsSysHardHoSuccNum           )                BtsSysHardHoSuccNum         ,
sum(SysSHoReqNum                  )                SysSHoReqNum                ,
sum(SysSHoSuccNum                 )                SysSHoSuccNum               ,
sum(TCHRadioFNum                  )                TCHRadioFNum                ,
sum(CallPageReqTotalNum           )                CallPageReqTotalNum,
sum(nvl(ps_Numfailofcall,0)) ps_Numfailofcall
from C_PERF_1X_SUM a,c_region_city c
where a.int_id = c.city_id
and a.scan_start_time = v_date
and a.ne_type = 10004
and a.sum_level = 0
and a.vendor_id = 7
group by c.province_id
)
select
a.province_id                         ,
v_date                ,
0                      ,
10000                        ,
7                      ,
nvl(callpagereqnum                ,0) ,
nvl(callpagesuccnum               ,0) ,
nvl(callpagesuccrate              ,0) ,
nvl(cs_callpagereqnum             ,0) ,
nvl(cs_callpagesuccnum            ,0) ,
nvl(cs_callpagesuccrate           ,0) ,
nvl(ps_callpagereqnum             ,0) ,
nvl(ps_callpagesuccnum            ,0) ,
nvl(ps_callpagesuccrate           ,0) ,
nvl(trafficincludeho              ,0) ,
nvl(trafficexcludeho              ,0) ,
nvl(cs_trafficincludeho           ,0) ,
nvl(cs_trafficexcludeho           ,0) ,
nvl(cs_trafficbywalsh             ,0) ,
nvl(cs_shotraffic                 ,0) ,
nvl(cs_sshotraffic                ,0) ,
nvl(cs_shorate                    ,0) ,
nvl(ps_calltrafficincludeho       ,0) ,
nvl(ps_calltrafficexcludeho       ,0) ,
nvl(ps_trafficbywalsh             ,0) ,
nvl(ps_shotraffic                 ,0) ,
nvl(ps_sshotraffic                ,0) ,
nvl(ps_shorate                    ,0) ,
nvl(losecallingnum                ,0) ,
nvl(losecallingrate               ,0) ,
nvl(losecallingratio              ,0) ,
nvl(cs_losecallingnum             ,0) ,
nvl(cs_losecallingrate            ,0) ,
nvl(cs_losecallingratio           ,0) ,
nvl(ps_losecallingnum             ,0) ,
nvl(ps_losecallingrate            ,0) ,
nvl(ps_losecallingratio           ,0) ,
nvl(tchreqnumincludeho            ,0) ,
nvl(tchsuccnumincludeho           ,0) ,
nvl(tchfnumincludeho              ,0) ,
nvl(tchsuccincludehorate          ,0) ,
nvl(tchreqnumexcludeho            ,0) ,
nvl(tchsuccnumexcludeho           ,0) ,
nvl(tchfnumexcludeho              ,0) ,
nvl(tchsuccexcludehorate          ,0) ,
nvl(callblockfailnum              ,0) ,
nvl(callblockfailrate             ,0) ,
nvl(cs_tchreqnumincludeho         ,0) ,
nvl(cs_tchsuccnumincludeho        ,0) ,
nvl(cs_tchfnumincludeho           ,0) ,
nvl(cs_tchsuccincludehorate       ,0) ,
nvl(cs_tchreqnumexcludeho         ,0) ,
nvl(cs_tchsuccnumexcludeho        ,0) ,
nvl(cs_tchfnumexcludeho           ,0) ,
nvl(cs_tchsuccexcludehorate       ,0) ,
nvl(cs_callblockfailnum           ,0) ,
nvl(cs_callblockfailrate          ,0) ,
nvl(cs_tchreqnumhardho            ,0) ,
nvl(cs_tchsuccnumhardho           ,0) ,
nvl(cs_callblockfailratehardho    ,0) ,
nvl(cs_tchreqnumsoftho            ,0) ,
nvl(cs_tchsuccnumsoftho           ,0) ,
nvl(cs_callblockfailratesoftho    ,0) ,
nvl(ps_tchreqnumincludeho         ,0) ,
nvl(ps_tchsuccnumincludeho        ,0) ,
nvl(ps_tchfnumincludeho           ,0) ,
nvl(ps_tchsuccincludehorate       ,0) ,
nvl(ps_tchreqnumexcludeho         ,0) ,
nvl(ps_tchsuccnumexcludeho        ,0) ,
nvl(ps_tchfnumexcludeho           ,0) ,
nvl(ps_tchsuccexcludehorate       ,0) ,
nvl(ps_callblockfailnum           ,0) ,
nvl(ps_callblockfailrate          ,0) ,
nvl(ps_tchreqnumhardho            ,0) ,
nvl(ps_tchsuccnumhardho           ,0) ,
nvl(ps_callblockfailratehardho    ,0) ,
nvl(ps_tchreqnumsoftho            ,0) ,
nvl(ps_tchsuccnumsoftho           ,0) ,
nvl(ps_callblockfailratesoftho    ,0) ,
nvl(handoffreqnum                 ,0) ,
nvl(handoffsuccnum                ,0) ,
nvl(handoffsuccrate               ,0) ,
nvl(cs_handoffreqnum              ,0) ,
nvl(cs_handoffsuccnum             ,0) ,
nvl(cs_handoffsuccrate            ,0) ,
nvl(cs_hardhoreqnum               ,0) ,
nvl(cs_hardhosuccnum              ,0) ,
nvl(cs_hardhosuccrate             ,0) ,
nvl(cs_softhoreqnum               ,0) ,
nvl(cs_softhosuccnum              ,0) ,
nvl(cs_softhosuccrate             ,0) ,
nvl(cs_ssofthoreqnum              ,0) ,
nvl(cs_ssofthosuccnum             ,0) ,
nvl(cs_ssofthosuccrate            ,0) ,
nvl(ps_handoffreqnum              ,0) ,
nvl(ps_handoffsuccnum             ,0) ,
nvl(ps_handoffsuccrate            ,0) ,
nvl(ps_hardhoreqnum               ,0) ,
nvl(ps_hardhosuccnum              ,0) ,
nvl(ps_hardhosuccrate             ,0) ,
nvl(ps_softhoreqnum               ,0) ,
nvl(ps_softhosuccnum              ,0) ,
nvl(ps_softhosuccrate             ,0) ,
nvl(ps_ssofthoreqnum              ,0) ,
nvl(ps_ssofthosuccnum             ,0) ,
nvl(ps_ssofthosuccrate            ,0) ,
nvl(handoffreqnum_intra           ,0) ,
nvl(handoffsuccnum_intra          ,0) ,
nvl(handoffsuccrate_intra         ,0) ,
nvl(handoffreqnum_extra           ,0) ,
nvl(handoffsuccnum_extra          ,0) ,
nvl(handoffsuccrate_extra         ,0) ,
nvl(hardhoreqnum_intra            ,0) ,
nvl(hardhosuccnum_intra           ,0) ,
nvl(hardhosuccrate_intra          ,0) ,
nvl(shoreqnum_intra               ,0) ,
nvl(shosuccnum_intra              ,0) ,
nvl(shosuccrate_intra             ,0) ,
nvl(sshoreqnum_intra              ,0) ,
nvl(sshosuccnum_intra             ,0) ,
nvl(sshosuccrate_intra            ,0) ,
nvl(hardhoreqnum_extra            ,0) ,
nvl(hardhosuccnum_extra           ,0) ,
nvl(hardhosuccrate_extra          ,0) ,
nvl(shoreqnum_extra               ,0) ,
nvl(shosuccnum_extra              ,0) ,
nvl(shosuccrate_extra             ,0) ,
nvl(carrier1btsnum                ,0) ,
nvl(carrier2btsnum                ,0) ,
nvl(carrier3btsnum                ,0) ,
nvl(carrier4btsnum                ,0) ,
nvl(carriernum_1x                 ,0) ,
nvl(channelnum                    ,0) ,
nvl(channelavailnum               ,0) ,
nvl(channelmaxusenum              ,0) ,
nvl(channelmaxuserate             ,0) ,
nvl(fwdchnum                      ,0) ,
nvl(fwdchavailnum                 ,0) ,
nvl(fwdchmaxusenum                ,0) ,
nvl(fwdchmaxuserate               ,0) ,
nvl(revchnum                      ,0) ,
nvl(revchavailnum                 ,0) ,
nvl(revchmaxusenum                ,0) ,
nvl(revchmaxuserate               ,0) ,
nvl(fwdrxtotalframe               ,0) ,
nvl(fdwtxtotalframeexcluderx      ,0) ,
nvl(rlpfwdchsizeexcluderx         ,0) ,
nvl(rlpfwdchrxsize                ,0) ,
nvl(rlpfwdlosesize                ,0) ,
nvl(fwdchrxrate                   ,0) ,
nvl(revrxtotalframe               ,0) ,
nvl(revtxtotalframeexcluderx      ,0) ,
nvl(rlprevchsize                  ,0) ,
nvl(revchrxrate                   ,0) ,
nvl(btsnum                        ,0) ,
nvl(onecarrierbtsnum              ,0) ,
nvl(twocarrierbtsnum              ,0) ,
nvl(threecarrierbtsnum            ,0) ,
nvl(fourcarrierbtsnum             ,0) ,
nvl(cellnum                       ,0) ,
nvl(onecarriercellnum             ,0) ,
nvl(twocarriercellnum             ,0) ,
nvl(threecarriercellnum           ,0) ,
nvl(fourcarriercellnum            ,0) ,
nvl(cenum                         ,0) ,
nvl(wirecapacity                  ,0) ,
nvl(tchnum                        ,0) ,
nvl(tchloadrate                   ,0) ,
nvl(shofactor                     ,0) ,
nvl(ceavailrate                   ,0) ,
nvl(tchblockfailrate              ,0) ,
nvl(busyercellratio               ,0) ,
nvl(busycellratio                 ,0) ,
nvl(freecellratio                 ,0) ,
nvl(serioverflowbtsratio          ,0) ,
nvl(overflowbtsratio              ,0) ,
nvl(btssyshardhosuccrate          ,0) ,
nvl(sysshosuccrate                ,0) ,
nvl(tchradiofrate                 ,0) ,
nvl(callinterruptrate             ,0) ,
nvl(avgradiofperiod               ,0) ,
nvl(badcellratio                  ,0) ,
nvl(ceavailnum                    ,0) ,
nvl(tchblockfailnumincludeho      ,0) ,
nvl(tchloadtrafficincludeho       ,0) ,
nvl(tchloadtrafficexcludeho       ,0) ,
nvl(loadtrafficbywalsh            ,0) ,
nvl(trafficcarrier1               ,0) ,
nvl(trafficcarrier2               ,0) ,
nvl(trafficcarrier3               ,0) ,
nvl(trafficcarrier4               ,0) ,
nvl(busyercellnum                 ,0) ,
nvl(busycellnum                   ,0) ,
nvl(freecellnum                   ,0) ,
nvl(badcellnum                    ,0) ,
nvl(serioverflowbtsnum            ,0) ,
nvl(overflowbtsnum                ,0) ,
nvl(tchreqnumcallerexcludehosms   ,0) ,
nvl(tchsuccnumcallerexcludehosms  ,0)  ,
nvl(tchreqnumcalleeexcludehosms   ,0) ,
nvl(tchsuccnumcalleeexcludehosms  ,0)  ,
nvl(tchreqnumexcludehosms         ,0) ,
nvl(tchsuccnumexcludehosms        ,0) ,
nvl(tchreqnumincludehosms         ,0) ,
nvl(tchsuccnumincludehosms        ,0) ,
nvl(btssyshardhoreqnum            ,0) ,
nvl(btssyshardhosuccnum           ,0) ,
nvl(sysshoreqnum                  ,0) ,
nvl(sysshosuccnum                 ,0) ,
nvl(tchradiofnum                  ,0) ,
nvl(callpagereqtotalnum           ,0) ,
nvl(numfailofcall                 ,0) ,
nvl(ps_numfailofcall              ,0) ,
nvl(cs_numfailofcall              ,0)
from a,b
where a.province_id=b.province_id;
commit;
dbms_output.put_line('Now time:'||sysdate||'-');

v_sql:='truncate table C_PERF_1X_SUM_ZX_TEMP';
dbms_output.put_line(v_sql);
execute immediate v_sql;
dbms_output.put_line('Now time:'||sysdate||'-');

commit;

----------------------------------------------------------------------------------end province_id
merge /*+ APPEND*/ into C_PERF_1X_SUM c_perf
using(
select
int_id,
ne_type,
sum(nvl(CallPageReqNum              ,0)) CallPageReqNum              ,
sum(nvl(CallPageSuccNum             ,0)) CallPageSuccNum             ,
sum(nvl(cs_CallPageReqNum,0) + nvl(ps_CallPageReqNum,0) - nvl(cs_CallPageSuccNum,0) - nvl(ps_CallPageSuccNum,0)) Numfailofcall,
sum(nvl(cs_CallPageReqNum,0) - nvl(cs_CallPageSuccNum,0)) cs_Numfailofcall,
sum(nvl(ps_Numfailofcall,0)) ps_Numfailofcall,
round(100*sum(CallPageSuccNum)/decode(sum(CallPageReqNum),null,1,0,1,sum(CallPageReqNum)),4) CallPageSuccRate            ,
sum(nvl(cs_CallPageReqNum           ,0)) cs_CallPageReqNum           ,
sum(nvl(cs_CallPageSuccNum          ,0)) cs_CallPageSuccNum          ,
round(100*sum(cs_CallPageSuccNum)/decode(sum(cs_CallPageReqNum),0,1,null,1,sum(cs_CallPageReqNum)),4) cs_CallPageSuccRate         ,
sum(nvl(ps_CallPageReqNum           ,0)) ps_CallPageReqNum           ,
sum(nvl(ps_CallPageSuccNum          ,0)) ps_CallPageSuccNum          ,
round(100*sum(ps_CallPageSuccNum)/decode(sum(ps_CallPageReqNum),0,1,null,1,sum(ps_CallPageReqNum)),4) ps_CallPageSuccRate         ,
sum(nvl(TrafficIncludeHo            ,0)) TrafficIncludeHo            ,
sum(nvl(TrafficExcludeHo            ,0)) TrafficExcludeHo            ,
sum(nvl(cs_TrafficIncludeHo         ,0)) cs_TrafficIncludeHo         ,
sum(nvl(cs_TrafficExcludeHo         ,0)) cs_TrafficExcludeHo         ,
sum(nvl(cs_trafficByWalsh           ,0)) cs_trafficByWalsh           ,
sum(nvl(cs_SHOTraffic               ,0)) cs_SHOTraffic               ,
sum(nvl(cs_SSHOTraffic              ,0)) cs_SSHOTraffic              ,
round(100*sum(cs_SHOTraffic)/decode(sum(cs_TrafficExcludeHo+cs_SHOTraffic),null,1,0,1,sum(cs_TrafficExcludeHo+cs_SHOTraffic)),4) cs_SHORate                  ,
sum(nvl(ps_CallTrafficIncludeHo     ,0)) ps_CallTrafficIncludeHo     ,
sum(nvl(ps_CallTrafficExcludeHo     ,0)) ps_CallTrafficExcludeHo     ,
sum(nvl(ps_trafficByWalsh           ,0)) ps_trafficByWalsh           ,
sum(nvl(ps_SHOTraffic               ,0)) ps_SHOTraffic               ,
sum(nvl(ps_SSHOTraffic              ,0)) ps_SSHOTraffic              ,
round(100*sum(ps_SHOTraffic)/decode(sum(ps_CallTrafficExcludeHo + ps_SHOTraffic),null,1,0,1,sum(ps_CallTrafficExcludeHo + ps_SHOTraffic)),4)  ps_SHORate                  ,
sum(nvl(LoseCallingNum              ,0)) LoseCallingNum              ,
round(100*sum(LoseCallingNum)/decode(sum(TchSuccNumExcludeHo),0,1,null,1,sum(TchSuccNumExcludeHo)),4) LoseCallingRate             ,
round(sum(TrafficExcludeHo)*60/decode(sum(LoseCallingNum),null,1,0,1,sum(LoseCallingNum)),4)     LoseCallingratio,
sum(nvl(cs_LoseCallingNum           ,0)) cs_LoseCallingNum           ,
round(100*sum(cs_LoseCallingNum)/decode(sum(cs_TchSuccNumExcludeHo),null,1,0,1,sum(cs_TchSuccNumExcludeHo)),4) cs_LoseCallingRate          ,

--modify-2011-10-27
--cs_TrafficExcludeHo*60/decode(cs_LoseCallingNum,null,1000,0,1000,cs_LoseCallingNum) cs_LoseCallingratio,
case when sum(cs_LoseCallingNum) is null then 1000
     when sum(cs_LoseCallingNum) = 0     then 1000
else round(sum(nvl(cs_TrafficExcludeHo,0))*60/sum(cs_LoseCallingNum),4)
end                                                           cs_LoseCallingratio,

sum(nvl(ps_LoseCallingNum           ,0)) ps_LoseCallingNum           ,
round(100*sum(ps_LoseCallingNum)/decode(sum(ps_TchSuccNumExcludeHo),null,1,0,1,sum(ps_TchSuccNumExcludeHo)),4) ps_LoseCallingRate          ,
round(sum(ps_CallTrafficExcludeHo)*60/decode(sum(ps_LoseCallingNum),null,1,0,1,sum(ps_LoseCallingNum)),4) ps_LoseCallingratio,
sum(nvl(TchReqNumIncludeHo          ,0)) TchReqNumIncludeHo          ,
sum(nvl(TchSuccNumIncludeHo         ,0)) TchSuccNumIncludeHo         ,
sum(nvl(TchFNumIncludeHo            ,0)) TchFNumIncludeHo            ,
round(100*sum(TchSuccNumIncludeHo)/decode(sum(TchReqNumIncludeHo),null,1,0,1,sum(TchReqNumIncludeHo)),4) TchSuccIncludeHoRate        ,
sum(nvl(TchReqNumExcludeHo          ,0)) TchReqNumExcludeHo          ,
sum(nvl(TchSuccNumExcludeHo         ,0)) TchSuccNumExcludeHo         ,
sum(nvl(TchFNumExcludeHo            ,0)) TchFNumExcludeHo            ,
round(100*sum(TchSuccNumExcludeHo)/decode(sum(TchReqNumExcludeHo),null,1,0,1,sum(TchReqNumExcludeHo)),4) TchSuccExcludeHoRate        ,
sum(nvl(CallBlockFailNum            ,0)) CallBlockFailNum            ,
round(100*sum(CallBlockFailNum)/decode(sum(TchReqNumIncludeHo),null,1,0,1,sum(TchReqNumIncludeHo)),4) CallBlockFailRate,
sum(nvl(cs_TchReqNumIncludeHo       ,0)) cs_TchReqNumIncludeHo       ,
sum(nvl(cs_TchSuccNumIncludeHo      ,0)) cs_TchSuccNumIncludeHo      ,
sum(nvl(cs_TchFNumIncludeHo         ,0)) cs_TchFNumIncludeHo         ,
round(100*sum(cs_TchSuccNumIncludeHo)/decode(sum(cs_TchReqNumIncludeHo),null,1,0,1,sum(cs_TchReqNumIncludeHo)),4)  cs_TchSuccIncludeHoRate,
sum(nvl(cs_TchReqNumExcludeHo       ,0)) cs_TchReqNumExcludeHo       ,
sum(nvl(cs_TchSuccNumExcludeHo      ,0)) cs_TchSuccNumExcludeHo      ,
sum(nvl(cs_TchFNumExcludeHo         ,0)) cs_TchFNumExcludeHo         ,
round(avg(nvl(cs_TchSuccExcludeHoRate     ,0)),4) cs_TchSuccExcludeHoRate     ,
sum(nvl(cs_CallBlockFailNum         ,0)) cs_CallBlockFailNum         ,
round(100*sum(cs_CallBlockFailNum)/decode(sum(cs_TchReqNumIncludeHo),null,1,0,1,sum(cs_TchReqNumIncludeHo)),4) cs_CallBlockFailRate,
sum(nvl(cs_TchReqNumHardho          ,0)) cs_TchReqNumHardho          ,
sum(nvl(cs_TchSuccNumHardho         ,0)) cs_TchSuccNumHardho         ,
round(100*sum(cs_TchReqNumHardho-cs_TchSuccNumHardho)/decode(sum(cs_TchReqNumHardho),null,1,0,1,sum(cs_TchReqNumHardho)),4) cs_CallBlockFailRateHardho  ,
sum(nvl(cs_TchReqNumsoftho          ,0)) cs_TchReqNumsoftho          ,
sum(nvl(cs_TchSuccNumsoftho         ,0)) cs_TchSuccNumsoftho         ,
round(100*sum(cs_TchReqNumsoftho-cs_TchSuccNumsoftho)/decode(sum(cs_TchReqNumsoftho),null,1,0,1,sum(cs_TchReqNumsoftho)),4) cs_CallBlockFailRatesoftho  ,
sum(nvl(ps_TchReqNumIncludeHo       ,0)) ps_TchReqNumIncludeHo       ,
sum(nvl(ps_TchSuccNumIncludeHo      ,0)) ps_TchSuccNumIncludeHo      ,
sum(nvl(ps_TchFNumIncludeHo         ,0)) ps_TchFNumIncludeHo         ,
round(100*sum(ps_TchSuccNumIncludeHo)/decode(sum(ps_TchReqNumIncludeHo),null,1,0,1,sum(ps_TchReqNumIncludeHo)),4) ps_TchSuccIncludeHoRate     ,
sum(nvl(ps_TchReqNumExcludeHo       ,0)) ps_TchReqNumExcludeHo       ,
sum(nvl(ps_TchSuccNumExcludeHo      ,0)) ps_TchSuccNumExcludeHo      ,
sum(nvl(ps_TchFNumExcludeHo         ,0)) ps_TchFNumExcludeHo         ,
round(100*sum(ps_TchSuccNumExcludeHo)/decode(sum(ps_TchReqNumExcludeHo),null,1,0,1,sum(ps_TchReqNumExcludeHo)),4) ps_TchSuccExcludeHoRate     ,
sum(nvl(ps_CallBlockFailNum         ,0)) ps_CallBlockFailNum         ,
round(100* sum(ps_CallBlockFailNum)/decode(sum(ps_TchReqNumIncludeHo),null,1,0,1,sum(ps_TchReqNumIncludeHo)),4) ps_CallBlockFailRate        ,
sum(nvl(ps_TchReqNumHardho          ,0)) ps_TchReqNumHardho          ,
sum(nvl(ps_TchSuccNumHardho         ,0)) ps_TchSuccNumHardho         ,
round(100*sum(ps_TchReqNumHardho-ps_TchSuccNumHardho)/decode(sum(ps_TchReqNumHardho),null,1,0,1,sum(ps_TchReqNumHardho)),4)  ps_CallBlockFailRateHardho  ,
sum(nvl(ps_TchReqNumsoftho          ,0)) ps_TchReqNumsoftho          ,
sum(nvl(ps_TchSuccNumsoftho         ,0)) ps_TchSuccNumsoftho         ,
round(100*sum(ps_TchReqNumsoftho-ps_TchSuccNumsoftho)/decode(sum(ps_TchReqNumsoftho),null,1,0,1,sum(ps_TchReqNumsoftho)),4) ps_CallBlockFailRatesoftho  ,
sum(nvl(HandoffReqNum               ,0)) HandoffReqNum               ,
sum(nvl(HandoffSuccNum              ,0)) HandoffSuccNum              ,
round(100*sum(HandoffSuccNum)/decode(sum(HandoffReqNum),null,1,0,1,sum(HandoffReqNum)),4) HandoffSuccRate,
sum(nvl(cs_HandoffReqNum            ,0)) cs_HandoffReqNum            ,
sum(nvl(cs_HandoffSuccNum           ,0)) cs_HandoffSuccNum           ,
round(100*sum(cs_HandoffSuccNum)/decode(sum(cs_HandoffReqNum),null,1,0,1,sum(cs_HandoffReqNum)),4) cs_HandoffSuccRate,
sum(nvl(cs_HardhoReqNum             ,0)) cs_HardhoReqNum             ,
sum(nvl(cs_HardhoSuccNum            ,0)) cs_HardhoSuccNum            ,

--update-2011-10-27
--sum(cs_HardhoSuccRate           )/decode(count(city_id),0,1,count(city_id)) cs_HardhoSuccRate           ,
case when   sum(cs_HardhoReqNum) is null  then  100
     when   sum(cs_HardhoReqNum)   =  0   then  100
else  round(100*sum(nvl(cs_HardhoSuccNum,0))/sum(cs_HardhoReqNum),4)
end                                                          cs_HardhoSuccRate,

sum(nvl(cs_SofthoReqNum             ,0)) cs_SofthoReqNum             ,
sum(nvl(cs_SofthoSuccNum            ,0)) cs_SofthoSuccNum            ,
round(100*sum(cs_SofthoSuccNum)/decode(sum(cs_SofthoReqNum),null,1,0,1,sum(cs_SofthoReqNum)),4) cs_SofthoSuccRate,
sum(nvl(cs_SSofthoReqNum            ,0)) cs_SSofthoReqNum            ,
sum(nvl(cs_SSofthoSuccNum           ,0)) cs_SSofthoSuccNum           ,
round(100*sum(cs_SSofthoSuccNum)/decode(sum(cs_SSofthoReqNum),null,1,0,1,sum(cs_SSofthoReqNum)),4) cs_SSofthoSuccRate,
sum(nvl(ps_HandoffReqNum            ,0)) ps_HandoffReqNum            ,
sum(nvl(ps_HandoffSuccNum           ,0)) ps_HandoffSuccNum           ,
round(100*sum(ps_HandoffSuccNum)/decode(sum(ps_HandoffReqNum),null,1,0,1,sum(ps_HandoffReqNum)),4) ps_HandoffSuccRate          ,
sum(nvl(ps_HardhoReqNum             ,0)) ps_HardhoReqNum             ,
sum(nvl(ps_HardhoSuccNum            ,0)) ps_HardhoSuccNum            ,
round(100*sum(ps_HardhoSuccNum)/decode(sum(ps_HardhoReqNum),null,1,0,1,sum(ps_HardhoReqNum)),4) ps_HardhoSuccRate           ,
sum(nvl(ps_SofthoReqNum             ,0)) ps_SofthoReqNum             ,
sum(nvl(ps_SofthoSuccNum            ,0)) ps_SofthoSuccNum            ,
round(100*sum(ps_SofthoSuccNum)/decode(sum(ps_SofthoReqNum),null,1,0,1,sum(ps_SofthoReqNum)),4) ps_SofthoSuccRate           ,
sum(nvl(ps_SSofthoReqNum            ,0)) ps_SSofthoReqNum            ,
sum(nvl(ps_SSofthoSuccNum           ,0)) ps_SSofthoSuccNum           ,
round(100*sum(ps_SSofthoSuccNum)/decode(sum(ps_SSofthoReqNum),null,1,0,1,sum(ps_SSofthoReqNum)),4) ps_SSofthoSuccRate          ,
sum(nvl(HandoffReqNum_intra         ,0)) HandoffReqNum_intra         ,
sum(nvl(HandoffSuccNum_intra        ,0)) HandoffSuccNum_intra        ,
round(100*sum(HandoffSuccNum_intra)/decode(sum(HandoffReqNum_intra),null,1,0,1,sum(HandoffReqNum_intra)),4) HandoffSuccRate_intra       ,
sum(nvl(HandoffReqNum_Extra         ,0)) HandoffReqNum_Extra         ,
sum(nvl(HandoffSuccNum_Extra        ,0)) HandoffSuccNum_Extra        ,
round(100*sum(HandoffSuccNum_Extra)/decode(sum(HandoffReqNum_Extra),null,1,0,1,sum(HandoffReqNum_Extra)),4) HandoffSuccRate_Extra       ,
sum(nvl(HardhoReqNum_intra          ,0)) HardhoReqNum_intra          ,
sum(nvl(HardhoSuccNum_intra         ,0)) HardhoSuccNum_intra         ,
round(100*sum(HardhoSuccNum_intra)/decode(sum(HardhoReqNum_intra),null,1,0,1,sum(HardhoReqNum_intra)),4) HardhoSuccRate_intra        ,
sum(nvl(ShoReqNum_intra             ,0)) ShoReqNum_intra             ,
sum(nvl(ShoSuccNum_intra            ,0)) ShoSuccNum_intra            ,
round(100*sum(ShoSuccNum_intra)/decode(sum(ShoReqNum_intra),null,1,0,1,sum(ShoReqNum_intra)),4) ShoSuccRate_intra           ,
sum(nvl(SShoReqNum_intra            ,0)) SShoReqNum_intra            ,
sum(nvl(SShoSuccNum_intra           ,0)) SShoSuccNum_intra           ,
round(100*sum(SShoSuccNum_intra)/decode(sum(SShoReqNum_intra),null,1,0,1,sum(SShoReqNum_intra)),4) SShoSuccRate_intra          ,
sum(nvl(HardhoReqNum_Extra          ,0)) HardhoReqNum_Extra          ,
sum(nvl(HardhoSuccNum_Extra         ,0)) HardhoSuccNum_Extra         ,
round(100*sum(HardhoSuccNum_Extra)/decode(sum(HardhoReqNum_Extra),null,1,0,1,sum(HardhoReqNum_Extra)),4) HardhoSuccRate_Extra        ,
sum(nvl(ShoReqNum_Extra             ,0)) ShoReqNum_Extra             ,
sum(nvl(ShoSuccNum_Extra            ,0)) ShoSuccNum_Extra            ,
round(100*sum(ShoSuccNum_Extra)/decode(sum(ShoReqNum_Extra),null,1,0,1,sum(ShoReqNum_Extra)),4) ShoSuccRate_Extra           ,
sum(nvl(Carrier1BtsNum              ,0)) Carrier1BtsNum              ,
sum(nvl(Carrier2BtsNum              ,0)) Carrier2BtsNum              ,
sum(nvl(Carrier3BtsNum              ,0)) Carrier3BtsNum              ,
sum(nvl(Carrier4BtsNum              ,0)) Carrier4BtsNum              ,
sum(nvl(CARRIERNUM_1X               ,0)) CARRIERNUM_1X               ,
sum(nvl(ChannelNum                  ,0)) ChannelNum                  ,
sum(nvl(ChannelAvailNum             ,0)) ChannelAvailNum             ,
sum(nvl(ChannelMaxUseNum            ,0)) ChannelMaxUseNum            ,
round(avg(nvl(ChannelMaxUseRate           ,0)),4) ChannelMaxUseRate           ,
sum(nvl(FwdChNum                    ,0)) FwdChNum                    ,
sum(nvl(FwdChAvailNum               ,0)) FwdChAvailNum               ,
sum(nvl(FwdChMaxUseNum              ,0)) FwdChMaxUseNum              ,
round(avg(nvl(FwdChMaxUseRate             ,0)),4) FwdChMaxUseRate             ,
sum(nvl(RevChNum                    ,0)) RevChNum                    ,
sum(nvl(RevChAvailNum               ,0)) RevChAvailNum               ,
sum(nvl(RevChMaxUseNum              ,0)) RevChMaxUseNum              ,
round(avg(nvl(RevChMaxUseRate             ,0)),4) RevChMaxUseRate             ,
sum(nvl(FwdRxTotalFrame             ,0)) FwdRxTotalFrame             ,
sum(nvl(FdwTxTotalFrameExcludeRx    ,0)) FdwTxTotalFrameExcludeRx    ,
sum(nvl(RLPFwdChSizeExcludeRx       ,0)) RLPFwdChSizeExcludeRx       ,
sum(nvl(RLPFwdChRxSize              ,0)) RLPFwdChRxSize              ,
sum(nvl(RLPFwdLoseSize              ,0)) RLPFwdLoseSize              ,
round(avg(nvl(FwdChRxRate                 ,0)),4) FwdChRxRate                 ,
sum(nvl(RevRxTotalFrame             ,0)) RevRxTotalFrame             ,
sum(nvl(RevTxTotalFrameExcludeRx    ,0)) RevTxTotalFrameExcludeRx    ,
sum(nvl(RLPRevChSize                ,0)) RLPRevChSize                ,
round(100*sum(RevRxTotalFrame)/decode(sum(RevTxTotalFrameExcludeRx),null,1,0,1,sum(RevTxTotalFrameExcludeRx)),4) RevChRxRate                 ,
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
round(100*sum(TCHLoadTrafficIncludeHo)/decode(sum(Wirecapacity),null,1,0,1,sum(Wirecapacity)),4) TCHLoadRate                 ,
round(100*sum(TCHLoadTrafficIncludeHo - TCHLoadTrafficExcludeHo)/decode(sum(TCHLoadTrafficExcludeHo),0,1,null,1,sum(TCHLoadTrafficExcludeHo)),4) SHoFactor                   ,
case when 100*sum(CEAvailNum)/decode(sum(CENum),null,1,0,1,sum(CENum))>=100 then 100 else 100*sum(CEAvailNum)/decode(sum(CENum),null,1,0,1,sum(CENum)) end CEAvailRate                 ,
round(100*sum(TCHBlockFailNumIncludeHo)/decode(sum(TchReqNumIncludeHoSms),null,1,0,1,sum(TchReqNumIncludeHoSms)),4) TCHBlockFailRate            ,
round(100*sum(BusyerCellNum)/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4) BusyerCellratio             ,
round(100*sum(BusyCellNum)/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4)  BusyCellratio               ,
round(100*sum(FreeCellNum)/decode(sum(CellNum),null,1,0,1,sum(CellNum)),4)  FreeCellratio               ,
round(100*sum(SeriOverflowBtsNum)/decode(sum(BtsNum),null,1,0,1,sum(BtsNum)),4) SeriOverflowBtsratio        ,
round(100*sum(OverflowBtsNum)/decode(sum(BtsNum),null,1,0,1,sum(BtsNum)),4)  OverflowBtsratio            ,
round(100*sum(BtsSysHardHoSuccNum)/decode(sum(BtsSysHardHoReqNum),null,1,0,1,sum(BtsSysHardHoReqNum)),4) BtsSysHardHoSuccRate        ,
round(100*sum(SysSHoSuccNum)/decode(sum(SysSHoReqNum),null,1,0,1,sum(SysSHoReqNum)),4)  SysSHoSuccRate              ,
round(100*sum(TCHRadioFNum)/decode(sum(TchSuccNumCallerExcludeHoSms+TchSuccNumCalleeExcludeHoSms),null,1,0,1,sum(TchSuccNumCallerExcludeHoSms+TchSuccNumCalleeExcludeHoSms)),4) TchRadioFRate               ,
round(100*sum(TCHRadioFNum)/decode(sum(cs_CallPageSuccNum),null,1,0,1,sum(cs_CallPageSuccNum)),4)  CallInterruptRate           ,
round(60*sum(TCHLoadTrafficExcludeHo)/decode(sum(TCHRadioFNum),null,1,0,1,sum(TCHRadioFNum)),4) AvgRadioFPeriod             ,
round(100*sum(nvl(BadCellNum,0))/decode(sum(CellNum),0,1,null,1,sum(CellNum)),4) BadCellRatio                ,
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
from C_PERF_1X_SUM
where scan_start_time = v_date and vendor_id in (7,10) and sum_level=0 and ne_type=10000
group by int_id,ne_type) t
on(c_perf.int_id = t.int_id and c_perf.scan_start_time = v_date and c_perf.ne_type=10000 and c_perf.sum_level=0 and c_perf.vendor_id=99)
when matched then update set
CallPageReqNum               = t.CallPageReqNum          ,
CallPageSuccNum              = t.CallPageSuccNum         ,
Numfailofcall = t.Numfailofcall,
cs_Numfailofcall = t.cs_Numfailofcall,
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
dbms_output.put_line('Now time:'||sysdate||'-');

commit;
-------
exception when others then
s_error := sqlerrm;
rollback;
insert into job_log values(sysdate,'proc_c_perf_1x_sum_zx',s_error);
commit;

end;
