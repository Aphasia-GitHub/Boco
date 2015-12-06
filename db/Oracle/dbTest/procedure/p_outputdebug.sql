create or replace procedure p_outputdebug(d varchar2)
is
vFileName             varchar2(100);
OutputFile            UTL_FILE.FILE_TYPE;
v_sql   varchar2(4000);
v_stat varchar2(30);
v_date  date;
begin

v_sql:='alter session set nls_date_format=''YYYY-MM-DD HH24:MI:SS''' ;
--dbms_output.put_line(v_sql);
execute immediate v_sql;

select to_char(trunc(sysdate,'d'),'yyyy-mm-dd') into v_date from dual;
 dbms_output.put_line(v_date);
--v_sql:='create or replace directory "pcj" as ''D:\×ÀÃæÎÄ¼þ\||v_date||''';
--execute immediate v_sql;
dbms_output.put_line(v_sql);



select substr(sysdate,0,4)||substr(sysdate,6,2)||substr(sysdate,9,2) into v_stat from dual;
select d||v_stat||'.log' into vFileName from dual  ;

v_sql := 'merge into c_perf_1x_sum_cell c_perf
using(
with a as(
select
e.lac lac_id,
sum(nvl(d.c02,0))  c02,
sum(nvl(d.c05,0))  c05
from C_tpd_cnt_carr_rc_lc d,c_cell e
where  d.unique_rdn = e.unique_rdn
and d.scan_start_time = v_date
and e.vendor_id=10
group by e.lac
),
b as(
select
e.lac lac_id,
sum(nvl(a.c006,0))  c006,
sum(nvl(a.c276,0))  c276,
sum(nvl(a.c278,0))  c278
from c_tpd_cnt_carr_lc a,c_carrier c,c_cell e
where  a.int_id = c.int_id
and c.related_cell = e.int_id
and a.scan_start_time = v_date
and e.vendor_id=10
group by e.lac
)
select
a.lac_id lac_id,
sum(nvl(a.c02,0)+nvl(a.c05,0))/360-sum(nvl(b.c006,0)+nvl(b.c276,0)+nvl(b.c278,0))/360  cs_SSHOTraffic
from a,b
where a.lac_id=b.lac_id and a.lac_id is not null
group by a.lac_id) t
on(c_perf.int_id = t.lac_id and c_perf.scan_start_time = v_date and c_perf.ne_type=100 and c_perf.sum_level=0 and c_perf.vendor_id=10)
when matched then update set
cs_SSHOTraffic       =    t.cs_SSHOTraffic
when not matched then insert(
int_id,
scan_start_time,
sum_level,
ne_type,
vendor_id,
cs_SSHOTraffic   )
values(
t.lac_id,
v_date,
0,
100,
10,
t.cs_SSHOTraffic );
commit;';


OutputFile := utl_file.fopen('pcj',vFileName,'a');
utl_file.putf(OutputFile,v_sql);
UTL_FILE.NEW_LINE (OutputFile);
utl_file.putf(OutputFile,'This is time:'||sysdate||' end;-------------------------------------------------------------------');
UTL_FILE.NEW_LINE (OutputFile);
utl_file.putf(OutputFile,v_sql);
utl_file.fflush(OutputFile);
utl_file.fclose(OutputFile);
end ;
