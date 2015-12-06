create or replace procedure sp_kpi_template_operate(p_operate_flag   number,
                                                    p_template_id    number,
                                                    p_temlate_name   varchar2,
                                                    p_kpi_id_array   varchar2,
                                                    p_user_id        varchar2,
                                                    p_remark         varchar2) is
  v_template_id    number;
  v_kpi_name_array varchar2(5000);
  cursor cur_kpi_name_array is
    select chinesename
      from gen_kpi
     where kpiid in
           (select regexp_substr(p_kpi_id_array, '[^,]+', 1, rownum) as kpiid_array
              from dual
            connect by rownum <= length(p_kpi_id_array) -
                       length(replace(p_kpi_id_array, ',')) + 1);
begin
  --插入操作
  if p_operate_flag = 1
  then
    select max(id) + 1 into v_template_id from c_bts_kpi_template;
    for c_kpi_names in cur_kpi_name_array
    loop
      v_kpi_name_array := v_kpi_name_array || c_kpi_names.chinesename || ',';
    end loop;
    v_kpi_name_array := RTRIM(v_kpi_name_array, ',');
    insert into c_bts_kpi_template
      select v_template_id,
             p_temlate_name,
             p_kpi_id_array,
             v_kpi_name_array,
             p_user_id,
             sysdate,
             p_remark,
             p_user_id,
             sysdate
        from dual;
    commit;
    --更新操作
  elsif p_operate_flag = 2
  then
    for c_kpi_names in cur_kpi_name_array
    loop
      v_kpi_name_array := v_kpi_name_array || c_kpi_names.chinesename || ',';
    end loop;
    v_kpi_name_array := RTRIM(v_kpi_name_array, ',');
    update c_bts_kpi_template
       set name           = p_temlate_name,
           kpi_id_array   = p_kpi_id_array,
           kpi_name_array = v_kpi_name_array,
           remark         = p_remark,
           modify_user_id = p_user_id,
           modify_date_time = sysdate
     where id = p_template_id;
    commit;
  end if;
end;
