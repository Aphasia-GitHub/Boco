create or replace procedure Proc_GetRealaitonMod3 is
v_count int;
v_count_mn int;
begin
  execute immediate ' truncate table tmp_eutrancell_realation ';
  declare cursor cur_realation is select m_int_id,n_int_id from eutranrelation;
  cur_row cur_realation%rowtype;
  begin
    for cur_row in cur_realation
      loop
        begin
          select count(1) into v_count from tmp_eutrancell_realation where m_intid = cur_row.m_int_id;
          if(v_count=0) then
            insert into tmp_eutrancell_realation (m_intId,n_intId) values (cur_row.m_int_id,cur_row.n_int_id);
            commit;
          else
            select count(1) into v_count_mn from tmp_eutrancell_realation where m_intId = cur_row.n_int_id and n_intId = cur_row.m_int_id;
            if(v_count_mn=0) then
              insert into tmp_eutrancell_realation (m_intId,n_intId) values (cur_row.m_int_id,cur_row.n_int_id);
              commit;
            else
               dbms_output.put_line('');
            end if;
          end if;
        end;
      end loop;
  end;
end Proc_GetRealaitonMod3;
