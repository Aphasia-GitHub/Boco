create or replace procedure get_value_lc
is
ce1 number;
ce2 number;
cell_id1 number;
cell_id2 number;
cell_hwl1 float;
cell_hwl2 float;
related_bts1 number;
related_bsc1 number;
related_msc1 number;
related_omc1 number;
related_bts2 number;
related_bsc2 number;
related_msc2 number;
related_omc2 number;
city_id1 number;
city_id2 number;

cursor c1 is select
tt.bts_id related_bts,
tt.ce ce,
tt.cell_hwl cell_hwl,
tt.cell_num cell_num,
c.int_id cell_id,
c.related_bsc related_bsc,
c.related_msc related_msc,
c.related_omc related_omc,
c.city_id city_id
from (select u.int_id bts_id,ceil(t.ce/t.cell_num) ce,erlangb cell_hwl,t.cell_num cell_num
from tia_erlangb_info,
(select (c_tpd_cnt_bts_lc.l2/360) ce,c_tpd_cnt_bts_lc.int_id bts_id,count(c_cell.related_bts) cell_num
from c_tpd_cnt_bts_lc,c_cell,c_bts
where c_tpd_cnt_bts_lc.int_id = c_cell.related_bts
and c_cell.related_bts = c_bts.int_id
and c_tpd_cnt_bts_lc.scan_start_time = to_date(to_char(trunc(sysdate-1,'hh'),'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss')
group by c_tpd_cnt_bts_lc.l2,c_tpd_cnt_bts_lc.int_id) t,c_tpa_cnt_bts_lc u
where u.int_id = t.bts_id
and gos = 0.02
and tia_erlangb_info.ch = ceil(t.ce / t.cell_num)
and u.scan_start_time = to_date(to_char(trunc(sysdate-1,'hh'),'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss')) tt,c_cell c
where tt.bts_id = c.related_bts;


cursor c2 is select
c.related_bts related_bts,
tt.ce ce,
tt.cell_hwl cell_hwl,
tt.cell_num cell_num,
c.int_id cell_id,
c.related_bsc related_bsc,
c.related_msc related_msc,
c.related_omc related_omc,
c.city_id city_id
from
(select u.int_id bts_id,
count(c.int_id) ce,
c_dic_bts_capacity.cell_hwl_plus cell_hwl,
count(c.int_id) cell_num
from c_tco_pro_bts,c_dic_bts_capacity,c_bts,c_tpa_cnt_bts_lc u,c_cell c
where c_tco_pro_bts.int_id = c.related_bts
and c_tco_pro_bts.do_bts = '·ñ'
and u.int_id = c.related_bts
and c.related_bts = c_bts.int_id and u.scan_start_time = to_date(to_char(trunc(sysdate-1,'hh'),'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss')
group by u.int_id,c_dic_bts_capacity.cell_hwl_plus) tt,c_cell c
where tt.bts_id=c.related_bts and tt.ce <=3;

begin
for r1 in c1 loop
  for r2 in c2 loop
  cell_hwl1 := r1.cell_hwl;
  cell_hwl2 := r2.cell_hwl;

  if (cell_hwl1 > cell_hwl2) then
  ce2 := r2.ce;
  cell_id2 :=r2.cell_id;
  related_bts2 := r2.related_bts;
  related_bsc2 := r2.related_bsc;
  related_msc2 := r2.related_msc;
  related_omc2 := r2.related_omc;
  city_id2 := r2.city_id;

  update c_tpa_sts_cell set
  related_bts = related_bts2,
  related_bsc = related_bsc2,
  related_msc = related_msc2,
  related_omc = related_omc2,
  ce = ce2,
  wx_vol = cell_hwl2,
  city_id = city_id2
  where c_tpa_sts_cell.int_id = cell_id2 and scan_start_time = to_date(to_char(trunc(sysdate-1,'hh'),'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss');

  else
  ce1 := r1.ce;
  cell_id1 := r1.cell_id;
  related_bts1 := r1.related_bts;
  related_bsc1 := r1.related_bsc;
  related_msc1 := r1.related_msc;
  related_omc1 := r1.related_omc;
  city_id1 := r1.city_id;

  update c_tpa_sts_cell set
  related_bts = related_bts1,
  related_bsc = related_bsc1,
  related_msc = related_msc1,
  related_omc = related_omc1,
  ce = ce1,
  wx_vol = cell_hwl1,
  city_id = city_id1
  where c_tpa_sts_cell.int_id = cell_id1 and scan_start_time = to_date(to_char(trunc(sysdate-1,'hh'),'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss');
  end if;
  end loop;
end loop;
commit;
end;
