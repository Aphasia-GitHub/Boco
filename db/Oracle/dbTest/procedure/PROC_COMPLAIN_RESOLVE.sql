create or replace procedure PROC_COMPLAIN_RESOLVE AUTHID CURRENT_USER as
  --TYPE t_emp_dept IS REF CURSOR; --�����α��������
  --c_region_records t_emp_dept; --�����α����
  i_count integer;
  --c_row            c_region_records%RowType;
  --����һ���α����v_cinfo c_emp%ROWTYPE ��������Ϊ�α�c_emp�е�һ����������
  cursor c_region_records is
    select trunc(add_months(sysdate, -1), 'MM') record_time,
           a.*,
           b.complain_count_without_wifi,
           b.complain_count
      from (select nvL(region_id, -1) region_id,
                   nvl(region_name, 'ȫʡ') region_name,
                  /* count(1) complain_count_without_wifi,*/ --�ֹ�˾����Ͷ����������wifi�� ͳ�������������»��ǣ�����
                 /*  sum(decode(instr(complain_result, '�ѽ��'), 0, 1, 0)) resolve_count_without_wifi,*/
                   sum(decode(instr(complain_result, '�ѽ��'), 0, 0, 1)) resolve_count_without_wifi,
                 /*  sum(decode(complain_result, '�ѽ��_������', 1, 0)) opt_resolve_count_without_wifi,*/
                   sum( case when complain_result =  '�ѽ��_������'and work_change = '��'  and code  is not null then 1 else 0 end ) opt_resolve_count_without_wifi
              from (select a.* from (
                      select GetRegionIdByOrgName(regexp_substr(wangyou_orgname, '[^���ŷֹ�˾��(]+')) region_id,
                           regexp_substr(wangyou_orgname, '[^���ŷֹ�˾��(]+') region_name,
                           nvl(b.complain_result,GetComplainResult(b.complain_result,a.oper_result)) complain_result1,
                            lat.resultscategories as complain_result,
                           --getcomplaindealcategory(nvl(b.complain_result, a.oper_result)) complain_result,
                           decode(instr(nvl(b.complaint_type, a.consult_type), 'WiFi'), 0, 'N', 'Y') isWiFi,
                           wo.code,
                           u.work_change
                      from tpd_cnt_complaint a,
                           c_tco_pro_complain  b,
                           c_consult_type    c,
                           c_latest_results    lat,
                             tap_complain_wo_relation wo,
                      tap_wo_ne_change u
                     where a.record_id = b.work_serial_number(+)
                       and a.consult_type = c.consult_type
                       and getcomplainresult(b.complain_result, a.oper_result) =
                       lat.complain_result
                       and a.record_id = wo.work_serial_number(+)
                       and wo.code = u.code(+)
                   --and u.work_change = '��'
                      -- and wo.code is not null
                       and (b.IsAvailable != 0 or b.IsAvailable is null)
                       and a.wangyou_orgname is not null
                       and a.handle_time >= add_months(trunc(sysdate, 'MM'), -2) + 24
                       and a.handle_time < add_months(trunc(sysdate, 'MM'), -1) + 24) a

                       ) k
             where isWiFi = 'N'
             group by rollup(region_id, region_name)
            having grouping(region_id) - grouping(region_name) = 0) a,

           (select nvL(region_id, -1) region_id,
                   nvl(region_name, 'ȫʡ') region_name,
                   count(1) complain_count,
                    sum(decode(isWiFi,'N',1,0)) complain_count_without_wifi
              from (select a.* from (
                      select GetRegionIdByOrgName(nvl(regexp_substr(wangyou_orgname, '[^���ŷֹ�˾��(]+'), localnet)) region_id,
                           nvl(regexp_substr(wangyou_orgname, '[^���ŷֹ�˾��(]+'), localnet) region_name,
                           nvl(b.complain_result,GetComplainResult(b.complain_result,a.oper_result)) complain_result1,
                           lat.RESULTSCATEGORIES  as complain_result,
                           --getcomplaindealcategory(nvl(b.complain_result,a.oper_result)) complain_result,--�˺�������
                           decode(instr(nvl(b.complaint_type, a.consult_type),'WiFi'), 0, 'N', 'Y') isWiFi
                      from tpd_cnt_complaint a,
                           c_tco_pro_complain  b,
                           c_consult_type    c,
                           c_latest_results    lat
                     where a.record_id = b.work_serial_number(+)
                       and a.consult_type = c.consult_type
                       and getcomplainresult(b.complain_result, a.oper_result) =
                       lat.complain_result
                       and (b.IsAvailable != 0 or b.IsAvailable is null)
                       and a.wangyou_orgname is not null
                       and a.handle_time >= add_months(trunc(sysdate, 'MM'), -1)
                       and a.handle_time < trunc(sysdate, 'MM')) a
                      ) m
             group by rollup(region_id, region_name)
            having grouping(region_id) - grouping(region_name) = 0) b
     where a.region_id = b.region_id; --���α����
begin
  --grant
  --  select , update, delete, insert on rnop1.tco_pro_complain to cdmauser;
  --execute immediate 'select , update, delete, insert on rnop1.tco_pro_complain to cdmauser';
  --OPEN c_region_records FOR

  for c_row in c_region_records loop
    begin
      select count(1)
        into i_count
        from tco_pro_complain_resolve_his
       where record_time = c_row.record_time
         and region_id = c_row.region_id;

      if i_count > 0 then
        update tco_pro_complain_resolve_his
           set complain_count                 = c_row.complain_count,
               resolve_count_without_wifi     = c_row.resolve_count_without_wifi,
               opt_resolve_count_without_wifi = c_row.opt_resolve_count_without_wifi,
               complain_count_without_wifi    = c_row.complain_count_without_wifi
         where record_time = c_row.record_time
           and region_id = c_row.region_id;
        commit;
      else
        insert into tco_pro_complain_resolve_his
          (record_time,
           region_id,
           region_name,
           complain_count,
           resolve_count_without_wifi,
           opt_resolve_count_without_wifi,
           complain_count_without_wifi)
        values
          (c_row.record_time,
           c_row.region_id,
           c_row.region_name,
           c_row.complain_count,
           c_row.resolve_count_without_wifi,
           c_row.opt_resolve_count_without_wifi,
           c_row.complain_count_without_wifi);
        commit;
        /*      exception
        when others then
          dbms_output.put_line('Ͷ�߹鵵���ݸ���ʧ��');*/
      end if;
    end;
  end loop;
end;
