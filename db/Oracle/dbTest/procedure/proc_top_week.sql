create or replace procedure proc_top_week(tmp_date varchar2)
as
tmp_Threshold0   float;
tmp_Threshold1   float;
tmp_Threshold2   float;
tmp_Threshold3_0 float;
tmp_Threshold3_1 float;
tmp_Threshold3_2 float;
tmp_Threshold4   float;
tmp_Threshold5   float;
tmp_Threshold6   float;
tmp_RSSI_1       float;
tmp_RSSI_2       float;
tmp_threshold9   float;
s_error varchar2(400);
v_date date;
tmpi integer;
begin
execute immediate 'alter session set nls_language="american"';
execute immediate 'truncate table tmp_www_dk_vvv_1';
execute immediate 'alter session enable parallel dml';
select decode(Threshold0  ,null,0,Threshold0  )   into tmp_Threshold0   from Threshold_define where rownum=1;      --TCHBlockFailNumIncludeHo
select decode(Threshold1  ,null,90,Threshold1  )  into tmp_Threshold1   from Threshold_define where rownum=1;      --CallPageSuccRate
select decode(Threshold2  ,null,3,Threshold2  )   into tmp_Threshold2   from Threshold_define where rownum=1;      --LoseCallingNum
select decode(Threshold3_0,null,2.5,Threshold3_0) into tmp_Threshold3_0 from Threshold_define where rownum=1;      --bad_cell_TCHLoadTrafficExcludeHo
select decode(Threshold3_1,null,3,Threshold3_1)   into tmp_Threshold3_1 from Threshold_define where rownum=1;      --bad_cell_LoseCallingNum
select decode(Threshold3_2,null,2.5,Threshold3_2) into tmp_Threshold3_2 from Threshold_define where rownum=1;      --bad_cell_LoseCallingRate
select decode(Threshold4  ,null,5,Threshold4  )   into tmp_Threshold4   from Threshold_define where rownum=1;      --CallPageReqTotalNum
select decode(Threshold5  ,null,90,Threshold5  )  into tmp_Threshold5   from Threshold_define where rownum=1;      --WireConnectSuccRate
select decode(Threshold6  ,null,70,Threshold6  )  into tmp_Threshold6   from Threshold_define where rownum=1;      --emRate
select decode(Threshold7,null,95,Threshold7)      into tmp_RSSI_1       from Threshold_define where rownum=1;      --RSS_1
select decode(Threshold8,null,5,Threshold8)       into tmp_RSSI_2       from Threshold_define where rownum=1;      --RSS_2
select decode(Threshold9,null,0,Threshold9)       into tmp_Threshold9   from Threshold_define where rownum=1;      --zerotch
select decode(tmp_date,null,trunc(sysdate-7,'dd'),trunc(to_date(tmp_date,'yyyy-mm-dd hh24:mi:ss'),'dd')) into v_date  from dual;
-----------------TCHBlockFailNumIncludeHo--------------------
tmpi:=0;
loop
if tmpi<7 then
-------------------------TCHBlockFailNumIncludeHo------------
--------------lc-----------------
insert /*+parallel(tmp_www_dk_vvv_1,2)+append*/ into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value
)
select
/*+parallel(a,2)+parallel(b,2)*/
a.int_id,
0,
v_date,
a.tp1+b.tp2
from
(select
/*+parallel(c_carrier,2)+parallel(c_tpd_cnt_bts_lc,2)*/
c.related_cell int_id,
sum(nvl(a.CS007,0)+nvl(a.CS008,0)+nvl(a.A70,0)) tp1
from c_tpd_cnt_bts_lc a,c_carrier c
where a.int_id=c.related_bts
and a.scan_start_time>=v_date and a.scan_start_time<v_date+1
group by c.related_cell) a,
(
select
/*+parallel(c_carrier,2)+parallel(c_tpd_cnt_carr_lc,2)*/
 c.related_cell int_id,
sum(nvl(b.ESC24,0)
+nvl(b.ESC25,0)+nvl(b.ESC26,0)+nvl(b.ESC27,0)+nvl(b.EC01,0)
+nvl(b.EC02,0)+nvl(b.C029,0)+nvl(b.C031,0)+nvl(b.C033,0)+nvl(b.C034,0)+nvl(b.C035,0)+nvl(b.C036,0)
) tp2
from c_tpd_cnt_carr_lc b,c_carrier c
where b.int_id=c.int_id
and  b.scan_start_time>=v_date and b.scan_start_time<v_date+1
group by c.related_cell
)b
where a.int_id=b.int_id ;
commit;
--------------zx-----------------
insert /*+parallel(tmp_www_dk_vvv_1,2)+append*/ into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value
)
select
/*+parallel(t1,2)+parallel(t2,2)+parallel(t3,2)*/
t1.int_id,
0,
v_date,
(t1.v_BlockFailureNum+t1.p_BlockFailureNum+t1.sm_BlockFailureNum+t2.v_PagingBlockFailureNum+t2.p_PagingBlockFailureNum+t2.sm_PagingBlockFailureNum
+t3.v_HOAbiscBlockNum+t3.v_HOCEBlockNum+t3.v_HOCHBlockNum+t3.v_HOFOBlockNum+t3.v_HOFPWBlockNum+t3.p_HOAbiscBlockNum+t3.p_HOCEBlockNum
+t3.p_HOCEBlockNum +t3.p_HOCHBlockNum+t3.p_HOFPWBlockNum)
from
(
select
/*+parallel(c_carrier,2)+parallel(C_tpd_cnt_carr_call_zx,2)+parallel(C_tpd_cnt_carr_zx,2)*/
c.related_cell int_id,
sum(nvl(b.v_CMO_BlockFailureNum,0)+nvl(b.v_AssignSoft_BlockFailureNum,0) + nvl(d.v_BlockFailureNum_orig,0))  v_BlockFailureNum,
sum(nvl(b.p_CMO_BlockFailureNum,0)+nvl(b.p_AssignSoft_BlockFailureNum,0) + nvl(d.p_BlockFailureNum,0))  p_BlockFailureNum,
sum(nvl(b.sm_CMO_BlockFailNum,0)+nvl(b.sm_AssignSoft_BlockFailNum,0))  sm_BlockFailureNum
from C_tpd_cnt_carr_call_zx b,C_tpd_cnt_carr_zx d,c_carrier c
where  b.int_id=c.int_id and d.int_id=c.int_id
and b.scan_start_time=d.scan_start_time and b.scan_start_time>=v_date and b.scan_start_time<v_date+1
group by c.related_cell) t1,
(
select
/*+parallel(c_carrier,2)+parallel(C_tpd_cnt_carr_pag_zx,2)+parallel(C_tpd_cnt_carr_zx,2)*/
c.related_cell int_id,
sum(nvl(a.v_CMO_BlockFailureNum,0)+nvl(a.v_AssignSoft_BlockFailureNum,0)+nvl(b.v_BlockFailureNum,0))   v_PagingBlockFailureNum,
sum(nvl(a.p_CMO_BlockFailureNum,0)+nvl(a.p_AssignSoft_BlockFailureNum,0)+nvl(a.p_BlockFailureNum,0))   p_PagingBlockFailureNum,
sum(nvl(a.sm_CMO_BlockFailureNum,0)+nvl(a.sm_AssignSoft_BlockFailureNum,0))                            sm_PagingBlockFailureNum
from C_tpd_cnt_carr_pag_zx a, C_tpd_cnt_carr_zx b,c_carrier c
where a.int_id=b.int_id and a.int_Id=c.int_id and a.scan_start_time=b.scan_start_time
and a.scan_start_time>=v_date and a.scan_start_time<v_date+1
group by c.related_cell
) t2,
(
 select
 /*+parallel(c_carrier,2)+parallel(C_tpd_cnt_carr_serv_zx,2)*/
  b.related_cell int_id,
  sum(nvl(a.v_AbiscBlockNum,0)+nvl(a.v_AbiscBlockNum_l3,0))  v_HOAbiscBlockNum,
  sum(nvl(a.v_CEBlockNum,0)   +nvl(a.v_CEBlockNum_l3,0))   v_HOCEBlockNum,
  sum(nvl(a.v_CHBlockNum,0)   +nvl(a.v_CHBlockNum_l3,0))   v_HOCHBlockNum,
  sum(nvl(a.v_FOBlockNum,0)   +nvl(a.v_FOBlockNum_l3,0))   v_HOFOBlockNum,
  sum(nvl(a.v_FPWBlockNum,0)  +nvl(a.v_FPWBlockNum_l3,0)) v_HOFPWBlockNum,
  sum(nvl(a.p_AbiscBlockNum,0)+nvl(a.p_AbiscBlockNum_l3,0)) p_HOAbiscBlockNum,
  sum(nvl(a.p_CEBlockNum,0)   +nvl(a.p_CEBlockNum_l3,0))   p_HOCEBlockNum,
  sum(nvl(a.p_CHBlockNum,0)   +nvl(a.p_CHBlockNum_l3,0))   p_HOCHBlockNum,
  sum(nvl(a.p_FPWBlockNum,0)  +nvl(a.p_FPWBlockNum_l3,0)) p_HOFPWBlockNum
  from C_tpd_cnt_carr_serv_zx a, c_carrier b
  where a.scan_start_time>=v_date and a.scan_start_time<v_date+1
  and a.unique_rdn=b.unique_rdn
  and (a.ServiceType=1 or a.ServiceType=2)
  group by b.related_cell
) t3
where t1.int_id=t2.int_id and t1.int_id=t3.int_id;
commit;
-------------------------CallPageSuccRate--------------
insert  /*+parallel(tmp_www_dk_vvv_1,2)+append*/ into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value
)
select
/*+parallel(c_cell,2)+parallel(c_tpd_sts_cell,2)*/
b.int_id,
1,
v_date,
round(sfb_divfloat_1(sum(a.succCalls),decode(sum(a.attCalls),null,1,0,1,sum(a.attCalls))),4)
from c_tpd_sts_cell a,c_cell b
where  a.int_id=b.int_id
and a.scan_start_time>=v_date and a.scan_start_time<v_date+1
group by b.int_id;
commit;
---------------------LoseCallingNum--------------
insert /*+parallel(tmp_www_dk_vvv_1,2)+append*/ into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value
)
select
/*+parallel(c_carrier,2)+parallel(c_tpd_cnt_carr_lc,2)*/
b.related_cell int_id,
2,
v_date,
sum(nvl(a.sc017,0)+nvl(a.sc018,0)+nvl(a.sc040,0)+nvl(a.sc041,0))
 from c_tpd_cnt_carr_lc a,c_carrier b
where
a.scan_start_time>=v_date and a.scan_start_time<v_date+1
and a.int_id=b.int_id
group by b.related_cell;
--having sum(a.sc017+a.sc018+a.sc040+a.sc041)>=tmp_Threshold2;
commit;
--------------------zx--------------
insert /*+parallel(tmp_www_dk_vvv_1,2)+append*/ into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value
)
select
/*+parallel(c_tpd_cnt_carr_zx,2)+parallel(c_carrier,2)*/
b.related_cell int_id,
2,
v_date,
sum(nvl(a.v_CM_RadioFNum,0)+nvl(a.sm_CM_RadioLoseCallingNum,0)+nvl(a.ConVoc_RlsFailNum,0)+nvl(a.ConVocData_RlsFailNum,0)-nvl(a.sm_CM_RadioLoseCallingNum,0))
from c_tpd_cnt_carr_zx a, c_carrier b
where a.scan_start_time>=v_date and a.scan_start_time<v_date+1
and a.int_id=b.int_id
group by b.related_cell;
commit;
----------------------------bad_cell------------
----------------------lc----------
insert /*+parallel(tmp_www_dk_vvv_1,2)+append*/ into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value
)
select
/*+parallel(c_carrier,2)*/
a.int_id,
3,
v_date,
1
from
(
select
/*+parallel(C_tpd_cnt_carr_lc,2)+parallel(c_carrier,2)*/
c.related_cell int_id,
sum(nvl(a.c006,0)
-nvl(a.c008,0)
+nvl(a.c011,0)
-nvl(a.c013,0)
+nvl(a.c012,0)
-nvl(a.c014,0)
+nvl(a.c276,0)
-nvl(a.c277,0)
+nvl(a.c278,0)
-nvl(a.c279,0))/360 v1,
sum(nvl(a.sc017,0)
+nvl(a.sc018,0)
+nvl(a.sc040,0)
+nvl(a.sc041,0)) v2,
sum(nvl(a.sc017,0)
+nvl(a.sc018,0)
+nvl(a.sc040,0)
+nvl(a.sc041,0))/
decode(sum(nvl(a.sc019,0)
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
-nvl(a.sc166,0)),0,1,null,1,sum(nvl(a.sc019,0)
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
-nvl(a.sc166,0))) v3
from C_tpd_cnt_carr_lc a,c_carrier c
where a.int_id = c.int_id and a.scan_start_time>=v_date and a.scan_start_time<v_date+1  and c.vendor_id=10
group by c.related_cell) a
where  a.v1 > tmp_Threshold3_0/100 and a.v2 >= tmp_Threshold3_1 and a.v3 > tmp_Threshold3_2/100;
commit;
-----------------zx--------------------
insert /*+parallel(tmp_www_dk_vvv_1,2)+append*/ into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value
)
select
/*+parallel(t1,2)*/
c_cell.int_id,
3,
v_date,
1
from
(
select
/*+parallel(C_tpd_cnt_carr_zx,2)+parallel(c_carrier,2)*/
c.related_cell int_id,
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
and a.scan_start_time>=v_date and a.scan_start_time<v_date+1
group by c.related_cell
)t1,
(select
/*+parallel(c_carrier,2)+parallel(C_tpd_cnt_carr_call_zx,2)*/
c.related_cell int_id,
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
and e.scan_start_time>=v_date and e.scan_start_time<v_date+1
group by c.related_cell)t3e,
(select
/*+parallel(c_carrier,2)+parallel(C_tpd_cnt_carr_pag_zx,2)*/
c.related_cell int_id,
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
and f.scan_start_time>=v_date and f.scan_start_time<v_date+1
group by c.related_cell)t3f, c_cell
where t1.v1>tmp_Threshold3_0/100
and t1.v2>tmp_Threshold3_1 and
 t1.v2/decode((t1.v3_down_a+t3e.v3_down_e+t3f.v3_down_f),null,1,0,1,(t1.v3_down_a+t3e.v3_down_e+t3f.v3_down_f)) > tmp_Threshold3_2/100
and t1.int_id = t3e.int_id and t3e.int_id = t3f.int_id and t3f.int_id=c_cell.int_id;
commit;
-----------------------------WireConnectSuccRate-----
-------------lc--------------
insert /*+parallel(tmp_www_dk_vvv_1,2)+append*/ into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value
)
select
/*+parallel(c_carrier,2)+parallel(c_tpd_carr_do_ag_lc,2)*/
b.related_cell,
4,
v_date,
round(sfb_divfloat_1(sum(a.Hdr293+a.Hdr292),decode(sum(a.Hdr225+a.Hdr226),null,1,0,1,sum(a.Hdr225+a.Hdr226))),4)*100
from c_tpd_carr_do_ag_lc a,c_carrier b
where  a.scan_start_time>=v_date and a.scan_start_time<v_date+1
and a.int_id=b.int_id
group by b.related_cell
having sfb_divfloat_1(sum(a.Hdr293+a.Hdr292),decode(sum(a.Hdr225+a.Hdr226),null,1,0,1,sum(a.Hdr225+a.Hdr226)))*100<tmp_Threshold5;
commit;
-----zx--------------------
insert /*+parallel(tmp_www_dk_vvv_1,2)+append*/ into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value
)
select
/*+parallel(a,2)*/
a.int_id,
4,
v_date,
a.tp1/decode(a.tp2,null,1,0,1,a.tp2)*100
from(
select
/*+parallel(c_carrier,2)*/
b.related_cell int_id,
sum(
  nvl(a.CMO_CallSNum,0)+
  nvl(a.soft_CMO_CallSuccessNum,0)+
  nvl(a.CMO_ExtInterruptNum,0)+
  nvl(a.soft_CMO_ExtInterruptNum,0)+
  nvl(a.CMO_ExtInterruptNum_bssapfail,0)+
  nvl(a.CMT_CallSNum,0)+
  nvl(a.soft_CMT_CallSuccessNum,0)+
  nvl(a.CMT_ExtInterruptNum,0)+
  nvl(a.soft_CMT_ExtInterruptNum,0)+
  nvl(a.CMT_ExtInterruptNum_bssapfail,0)+
  nvl(a.FMT_CallSNum,0)+
  nvl(a.soft_FMT_CallSuccessNum,0)+
  nvl(a.FMT_ExtInterruptNum,0)+
  nvl(a.soft_FMT_ExtInterruptNum,0)+
  nvl(a.FMT_ExtInterruptNum_bssapfail,0) ) tp1,
 sum(nvl(a.CMO_CallSNum,0)+
  nvl(a.CMO_ExtInterruptNum,0)+
  nvl(a.CMO_BlockFNum,0)+
  nvl(a.CMO_OtherFNum,0)+
  nvl(a.CMO_InvalidReqNum,0)+
  nvl(a.CMO_RFAccessFailureNum,0)+
  nvl(a.soft_CMO_CallSuccessNum,0)+
  nvl(a.soft_CMO_ExtInterruptNum,0)+
  nvl(a.soft_CMO_BlockFailureNum,0)+
  nvl(a.soft_CMO_OtherFailureNum,0)+
  nvl(a.soft_CMO_InvalidReqNum,0)+
  nvl(a.soft_CMO_RFAccessFailureNum,0)+
  nvl(a.CMO_ExtInterruptNum_bssapfail,0)+
  nvl(a.CMO_BlockFailureNum_bssapfail,0)+
  nvl(a.CMO_OtherFailureNum_bssapfail,0)+
  nvl(a.CMT_CallSNum,0)+
  nvl(a.CMT_ExtInterruptNum,0)+
  nvl(a.CMT_BlockFNum,0)+
  nvl(a.CMT_OtherFNum,0)+
  nvl(a.CMT_InvalidReqNum,0)+
  nvl(a.CMT_RFAccessFailureNum,0)+
  nvl(a.Soft_CMT_CallSuccessNum,0)+
  nvl(a.Soft_CMT_ExtInterruptNum,0)+
  nvl(a.Soft_CMT_BlockFailureNum,0)+
  nvl(a.Soft_CMT_OtherFailureNum,0)+
  nvl(a.Soft_CMT_InvalidReqNum,0)+
  nvl(a.Soft_CMT_RFAccessFailureNum,0)+
  nvl(a.CMT_ExtInterruptNum_bssapfail,0)+
  nvl(a.CMT_BlockFailureNum_bssapfail,0)+
  nvl(a.CMT_OtherFailureNum_bssapfail,0)+
  nvl(a.FMT_CallSNum,0)+
  nvl(a.FMT_ExtInterruptNum,0)+
  nvl(a.FMT_BlockFNum,0)+
  nvl(a.FMT_OtherFNum,0)+
  nvl(a.FMT_InvalidReqNum,0)+
  nvl(a.FMT_RFAccessFailureNum,0)+
  nvl(a.Soft_FMT_CallSuccessNum,0)+
  nvl(a.soft_FMT_ExtInterruptNum,0)+
  nvl(a.soft_FMT_BlockFailureNum,0)+
  nvl(a.soft_FMT_OtherFailureNum,0)+
  nvl(a.soft_FMT_InvalidReqNum,0)+
  nvl(a.soft_FMT_RFAccessFailureNum,0)+
  nvl(a.FMT_ExtInterruptNum_bssapfail,0)+
  nvl(a.FMT_BlockFailureNum_bssapfail,0)+
  nvl(a.FMT_OtherFailureNum_bssapfail,0)) tp2
from
C_tpd_cnt_carr_do_zx a,c_carrier b
where a.int_id=b.int_id
and a.scan_start_time>=v_date and a.scan_start_time<v_date+1
group by b.related_cell
 )  a;
commit;
-----------------emRate--------
--------------lc--------------
insert /*+parallel(tmp_www_dk_vvv_1,2)+append*/ into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value
)
select
/*+parallel(c_carrier,2)+parallel(c_tpd_carr_do_lc,2)*/
b.related_cell int_id,
5,
v_date,
round(sfb_divfloat_1(sum(nvl(a.EVMTOTALBUSYSLOTSBE,0)+nvl(a.EVMTOTALBUSYSLOTSEF,0)),decode(sum(a.TIMESLOTSINPEGGINGINTERVAL),0,1,null,1,sum(a.TIMESLOTSINPEGGINGINTERVAL))),4)*100
from c_tpd_carr_do_lc a,c_carrier b
where  a.scan_start_time>=v_date and a.scan_start_time<v_date+1
and a.int_id=b.int_id
group by b.related_cell;
commit;
--------------zx--------------
insert /*+parallel(tmp_www_dk_vvv_1,2)+append*/ into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value
)
select
/*+parallel(c_carrier,2)+parallel(c_tpd_cnt_carr_do_zx,2)*/
b.related_cell int_id,
5,
v_date,
round(sfb_divfloat_1(sum(RevAFwdTCHSendSlotNum+Rls0FwdTCHSendSlotNum)*1667,3600000000),4)
from c_tpd_cnt_carr_do_zx a,c_carrier b
where a.scan_start_time>=v_date and a.scan_start_time<v_date+1
and a.int_id=b.int_id
group by b.related_cell;
commit;
---------------RSS---------------------
------------------lc------------------
insert /*+parallel(tmp_www_dk_vvv_1,2)+append*/ into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value
)
select
/*+parallel(c_carrier,2)+parallel(C_tpd_cnt_carr_lc,2)*/
b.related_cell int_id,
6,
v_date,
round(avg(a.c074),4)
from C_tpd_cnt_carr_lc a,c_carrier b
where a.int_id=b.int_id
and a.scan_start_time>=v_date and a.scan_start_time<v_date+1
group by b.related_cell
having avg(a.c074)>tmp_RSSI_2;
commit;
--------------zx----------------------
insert /*+parallel(tmp_www_dk_vvv_1,2)+append*/ into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value,
value1
)
select
/*+parallel(c_carrier,2)+parallel(C_tpd_cnt_carr_unit_zx,2)*/
b.related_cell int_id,
6,
v_date,
avg(AvgRSSIInstant_M),
avg(AvgRSSIInstant_D)
--greatest(avg(AvgRSSIInstant_M),avg(AvgRSSIInstant_D))
from C_tpd_cnt_carr_unit_zx a ,c_carrier b
where a.int_id =b.int_id
and a.scan_start_time>=v_date and a.scan_start_time<v_date+1
group by b.related_cell
having (avg(AvgRSSIInstant_M)>-tmp_RSSI_1 or avg(AvgRSSIInstant_D)>-tmp_RSSI_1);
commit;
--------------------------CallPageReqTotalNum-------
insert /*+parallel(tmp_www_dk_vvv_1,2)+append*/  into tmp_www_dk_vvv_1
(
int_id,
flag,
scan_start_time,
value
)
select
/*+parallel(c_cell,2)+parallel(c_tpd_sts_cell,2)*/
b.int_id,
7,
v_date,
sum(a.trafficExcludeHoCs)
from c_tpd_sts_cell a,c_cell b
where a.scan_start_time>=v_date and a.scan_start_time<v_date+1
and a.int_id=b.int_id
group by b.int_id;
-------------------------------------------
commit;
tmpi :=tmpi+1;
v_date :=v_date+1;
else
exit;
end if;
end loop;
-----------------------------------
v_date :=v_date-1;
----------------calculate------------
delete from top_check where scan_start_time=v_date;
insert  into top_check
(
int_id ,
index_type,
index_kval ,
scan_start_time,
city_name ,
bts_id ,
bts_name ,
index_count,
worst_value1
)
select
b.city_id,
a.flag,
c.index_value,
v_date,
c.city_name,
b.btsid,
d.name,
count(*),
max(value)
from tmp_www_dk_vvv_1 a, c_cell b,c_tco_pro_cell c,c_tco_pro_bts d
where a.flag=0 and a.int_id=b.int_id
and b.int_id=c.int_id and b.related_bts=d.int_id
and b.city_id is not null
and a.value>tmp_Threshold0
group by a.flag,b.city_id,c.index_value,c.city_name,b.btsid,d.name;
commit;
----------------------------------
insert  into top_check
(
int_id ,
index_type,
index_kval ,
scan_start_time,
city_name ,
bts_id ,
bts_name ,
index_count,
worst_value1
)
select
b.city_id,
a.flag,
c.index_value,
v_date,
c.city_name,
b.btsid,
d.name,
count(*),
min(value)
from tmp_www_dk_vvv_1 a, c_cell b,c_tco_pro_cell c,c_tco_pro_bts d
where a.flag=1 and a.int_id=b.int_id
and b.int_id=c.int_id and b.related_bts=d.int_id
and b.city_id is not null
and a.value<tmp_Threshold1
group by a.flag,b.city_id,c.index_value,c.city_name,b.btsid,d.name;
commit;
-----------------------------------
insert  into top_check
(
int_id ,
index_type,
index_kval ,
scan_start_time,
city_name ,
bts_id ,
bts_name ,
index_count,
worst_value1
)
select
b.city_id,
a.flag,
c.index_value,
v_date,
c.city_name,
b.btsid,
d.name,
count(*),
max(value)
from tmp_www_dk_vvv_1 a, c_cell b,c_tco_pro_cell c,c_tco_pro_bts d
where a.flag=2 and a.int_id=b.int_id
and b.int_id=c.int_id and b.related_bts=d.int_id
and b.city_id is not null
and a.value>=tmp_Threshold2
group by a.flag,b.city_id,c.index_value,c.city_name,b.btsid,d.name;
commit;
-------------------------------------
insert  into top_check
(
int_id ,
index_type,
index_kval ,
scan_start_time,
city_name ,
bts_id ,
bts_name ,
index_count
)
select
b.city_id,
a.flag,
c.index_value,
v_date,
c.city_name,
b.btsid,
d.name,
count(*)
from tmp_www_dk_vvv_1 a, c_cell b,c_tco_pro_cell c,c_tco_pro_bts d
where a.flag=3 and a.int_id=b.int_id
and b.int_id=c.int_id and b.related_bts=d.int_id
and b.city_id is not null
group by a.flag,b.city_id,c.index_value,c.city_name,b.btsid,d.name;
commit;
-------------------------------------
insert  into top_check
(
int_id ,
index_type,
index_kval ,
scan_start_time,
city_name ,
bts_id ,
bts_name ,
index_count,
worst_value1
)
select
b.city_id,
a.flag,
c.index_value,
v_date,
c.city_name,
b.btsid,
d.name,
count(*),
min(value)
from tmp_www_dk_vvv_1 a, c_cell b,c_tco_pro_cell c,c_tco_pro_bts d
where a.flag=4 and a.int_id=b.int_id
and b.int_id=c.int_id and b.related_bts=d.int_id
and b.city_id is not null
and a.value<tmp_Threshold5
group by a.flag,b.city_id,c.index_value,c.city_name,b.btsid,d.name;
commit;
-------------------------------------
insert  into top_check
(
int_id ,
index_type,
index_kval ,
scan_start_time,
city_name ,
bts_id ,
bts_name ,
index_count,
worst_value1
)
select
b.city_id,
a.flag,
c.index_value,
v_date,
c.city_name,
b.btsid,
d.name,
count(*),
max(value)
from tmp_www_dk_vvv_1 a, c_cell b,c_tco_pro_cell c,c_tco_pro_bts d
where a.flag=5 and a.int_id=b.int_id
and b.int_id=c.int_id and b.related_bts=d.int_id
and b.city_id is not null
and a.value>tmp_Threshold6
group by a.flag,b.city_id,c.index_value,c.city_name,b.btsid,d.name;
commit;
-------------------------------------
insert  into top_check
(
int_id ,
index_type,
index_kval ,
scan_start_time,
city_name ,
bts_id ,
bts_name ,
index_count,
worst_value1,
worst_value2
)
select
b.city_id,
a.flag,
c.index_value,
v_date,
c.city_name,
b.btsid,
d.name,
count(*),
max(value),
max(value1)
from tmp_www_dk_vvv_1 a, c_cell b,c_tco_pro_cell c,c_tco_pro_bts d
where a.flag=6 and a.int_id=b.int_id
and b.int_id=c.int_id and b.related_bts=d.int_id
and b.city_id is not null
group by a.flag,b.city_id,c.index_value,c.city_name,b.btsid,d.name;
commit;
-------------------------------------
insert  into top_check
(
int_id ,
index_type,
index_kval ,
scan_start_time,
city_name ,
bts_id ,
bts_name ,
index_count
)
select
b.city_id,
a.flag,
c.index_value,
v_date,
c.city_name,
b.btsid,
d.name,
count(*)
from tmp_www_dk_vvv_1 a, c_cell b,c_tco_pro_cell c,c_tco_pro_bts d
where a.flag=7 and a.int_id=b.int_id
and b.int_id=c.int_id and b.related_bts=d.int_id
and b.city_id is not null
and a.value=tmp_Threshold9
group by a.flag,b.city_id,c.index_value,c.city_name,b.btsid,d.name;
commit;
-------------------------------------
exception when others then
s_error := sqlerrm;
rollback;
insert into job_log values(sysdate,'proc_top_week',s_error);
commit;
end;
-----------------------------------------------------------------------
