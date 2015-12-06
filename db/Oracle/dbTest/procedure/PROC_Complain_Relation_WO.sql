create or replace procedure PROC_Complain_Relation_WO as
/* i_count integer;*/

 cursor c_records is
select id,
       max(code) code,
       max(complain_wo_isover) complain_wo_isover,
       max(is_timeout) is_timeout,
       max(complain_woatt_isupload) complain_woatt_isupload,
         decode(sign(sum(case when ta_id is not null then 1 else 0 end)),1,'是','否') as baseinfo_work_change,
      decode(sign(sum(case when ne_id is not null then 1 else 0 end)),1,'是','否') as para_work_change,
       case
         when sign(sum(case
                         when ne_id is not null then
                          1
                         else
                          0
                       end)) = 0 and sign(sum(case
                                               when ta_id is not null then
                                                1
                                               else
                                                0
                                             end)) = 0 then
         '否'
         else
           '是'
       end as work_change
  from (select distinct a.id,
                        b.code,

                        decode(b.wo_status, 4, '是', '否') as complain_wo_isover,
                        case
                          when b.wo_status in (60, 4, 2) and
                               (b.wo_dispatch_datetime + b.finish_max_days -
                               a.observate_days -
                               nvl(woe2.run_begin_time, sysdate) >= 0) then
                           '否'
                          when b.wo_status not in (60, 4, 2) and
                               (nvl(b.wo_dispatch_datetime, sysdate) +
                               b.finish_max_days - a.observate_days -
                               nvl(woe2.run_begin_time, sysdate) >= 0) then
                           '否'
                          else
                           '是'
                        end as is_timeout,
                        decode(att.id, null, '否', '是') complain_woatt_isupload,
                        ta.int_id ta_id ,
                        para.ne_id ne_id
          from tap_wo a
          left join tap_wo_baseinfo b
            on a.id = b.id
          left join tap_wo_event woe2
            on b.flow_id = woe2.flow_id
           and woe2.event_name = 'Reply'
          left join tap_attachment att
            on b.id = att.related_id
          left join tap_audit ta
            on a.handle_ne_id = ta.related_id
           and auditstatus = '通过'

           and ta.audittime >= b.wo_dispatch_datetime - 15
           and ta.audittime <= b.wo_dispatch_datetime + 15
          left join c_para_modify para
            on a.handle_ne_id = para.ne_id
           and para.new_time >= b.wo_dispatch_datetime - 15
           and para.new_time <= b.wo_dispatch_datetime + 15)
 GROUP BY id;
begin
 delete  from tap_wo_ne_change;
   commit;
 for c_row in c_records loop
    begin
    /*  select count(1)
        into i_count
        from tap_wo_ne_change
       where id = c_row.id;
        */


      /*  update tap_wo_ne_change
           set code                 = c_row.code,
               complain_wo_isover     = c_row.complain_wo_isover,
               is_timeout = c_row.is_timeout,
               complain_woatt_isupload    = c_row.complain_woatt_isupload,
                baseinfo_work_change     = c_row.baseinfo_work_change,
               para_work_change = c_row.para_work_change,
               work_change    = c_row.para_work_change
         where id = c_row.id;*/

    /*  else*/

        insert into tap_wo_ne_change
          (id,
           code,
           complain_wo_isover,
           is_timeout,
           complain_woatt_isupload,
           baseinfo_work_change,
           para_work_change,
           work_change)
        values
          (c_row.id,
           c_row.code,
           c_row.complain_wo_isover,
           c_row.is_timeout,
           c_row.complain_woatt_isupload,
           c_row.baseinfo_work_change,
           c_row.para_work_change,
           c_row.work_change);
        commit;
        /*      exception
        when others then
          dbms_output.put_line('投诉归档数据更新失败');*/
     /* end if;*/
    end;
  end loop;
end;
