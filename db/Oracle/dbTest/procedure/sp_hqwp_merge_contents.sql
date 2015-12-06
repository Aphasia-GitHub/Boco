CREATE OR REPLACE PROCEDURE sp_hqwp_merge_contents(v_workPlanID in varchar2,v_exsit_workPlanID in varchar2)
 IS
/*  v_workPlanID    NUMBER(30) := -1; --作业计划的ID
  v_exsit_workPlanID    NUMBER(30) := -1; --已存在的作业计划的ID*/
  v_need_merge_contents varchar2(400);
  v_merge_sql           varchar2(500);

BEGIN

/*  select min(a.id) into v_workPlanID
    from tap_wp a
   where a.code = workPlanCode;

  select min(a.id) into v_exsit_workPlanID
    from tap_wp a
   where a.code = workPlanCode_old;*/

  if v_exsit_workPlanID <> -1 and v_exsit_workPlanID is not null then
    select to_char(wm_concat(id))
      into v_need_merge_contents
      from (select a.id, name
              from tap_wp_content a, tap_wp_stage b
             where a.wp_stage_id = b.id
               and b.wp_id = v_workPlanID) new
     where not exists (select a.id, name
              from tap_wp_content a, tap_wp_stage b
             where a.wp_stage_id = b.id
               and a.name = new.name
               and b.wp_id = (select min(a.id)
                                from tap_wp a, tap_wp b
                               where a.name = b.name
                                 and b.id = v_workPlanID
                                 and a.id <> b.id)); --打开游标变量

    --老作业计划的作业内容列表
    if length(v_need_merge_contents) > 1 then
       v_merge_sql :=  'update tap_wp_content m set wp_stage_id =(
                     select min(id) from TAP_WP_STAGE
                     where wp_id ='|| v_exsit_workPlanID ||')
                     where  id  in('||v_need_merge_contents ||')';
      execute immediate v_merge_sql;

      commit;
    end if;
  end if;
END;
