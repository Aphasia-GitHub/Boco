create or replace procedure gather_hour
as

v_date varchar2(20);
v_date_yesterday varchar2(20);
v_hour varchar2(2);
v_str varchar2(1000);
v_partname varchar2(30);
v_tabname varchar2(30);

v_number integer;

begin

select to_char(sysdate,'yyyymmdd') into v_date from dual;

select to_char(sysdate-1,'yyyymmdd') into v_date_yesterday from dual;

select to_number(to_char(sysdate,'yyyymmdd'))-1 into v_number from dual;

select to_char(sysdate-3/24,'hh24') into v_hour from dual;

--city_id belongs to ZX

for c_cur in (select distinct abs(city_id) city_id from c_region_city where vendor is not null and vendor=7) loop

      DBMS_OUTPUT.PUT_LINE('cityid is '||c_cur.city_id);

      if v_hour = '00' then

      v_tabname := 'CDL_ZX_'||c_cur.city_id||'_'||v_date_yesterday;
      v_partname := 'ZX_'||c_cur.city_id||'_'||v_number||24;

      DBMS_OUTPUT.PUT_LINE('time1 is '||v_partname);

      else

      v_tabname := 'CDL_ZX_'||c_cur.city_id||'_'||v_date;
      v_partname := 'ZX_'||c_cur.city_id||'_'||v_date||v_hour;

      DBMS_OUTPUT.PUT_LINE('time2 is '||v_partname);

      end if;

      v_str :=
      'begin DBMS_STATS.GATHER_TABLE_STATS('||
      'ownname => '||'''CDMAUSER'''||','||
      'tabname => '||''''||v_tabname||''''||','||
      'partname => '||''''||v_partname||''''||','||
      'method_opt => '||''''||'for all indexed columns'||''''||','||
      'degree => 4 '||','||
      'cascade=> true); end;';

      DBMS_OUTPUT.PUT_LINE('sql is '||v_str);

      execute immediate v_str;
end loop;

--end of city_id belongs to ZX



--city_id belongs to LC

for c_cur in (select distinct abs(city_id) city_id from c_region_city where vendor is not null and vendor=10) loop

      DBMS_OUTPUT.PUT_LINE('cityid is '||c_cur.city_id);

      if v_hour = '00' then

      v_tabname := 'CDL_LC_'||c_cur.city_id||'_'||v_date_yesterday;
      v_partname := 'LC_'||c_cur.city_id||'_'||v_number||24;

      DBMS_OUTPUT.PUT_LINE('time1 is '||v_partname);

      else

      v_tabname := 'CDL_LC_'||c_cur.city_id||'_'||v_date;
      v_partname := 'LC_'||c_cur.city_id||'_'||v_date||v_hour;

      DBMS_OUTPUT.PUT_LINE('time2 is '||v_partname);

      end if;

      v_str :=
      'begin DBMS_STATS.GATHER_TABLE_STATS('||
      'ownname => '||'''CDMAUSER'''||','||
      'tabname => '||''''||v_tabname||''''||','||
      'partname => '||''''||v_partname||''''||','||
      'method_opt => '||''''||'for all indexed columns'||''''||','||
      'degree => 4 '||','||
      'cascade=> true); end;';

      DBMS_OUTPUT.PUT_LINE('sql is '||v_str);

      execute immediate v_str;

end loop;

--end of city_id belongs to LC

end ;
