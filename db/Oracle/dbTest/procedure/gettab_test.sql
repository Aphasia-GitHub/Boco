create or replace procedure gettab_test
as

v_date varchar2(20);
v_str varchar2(1000);
v_par varchar2(1000);

begin

  select to_char(sysdate-1,'yyyymmdd') into v_date from dual;
  for c_cur in (select table_name from user_tables where table_name like 'CDL_ZX_%'||v_date or table_name like 'CDL_LC_%'||v_date) loop
  v_par := substr(c_cur.table_name,5,length(c_cur.table_name))||'09';
  v_str := 'tabname => '||c_cur.table_name||','||'partname => '||v_par;
  DBMS_OUTPUT.PUT_LINE('sql is '||v_str);
  end loop;

end ;
