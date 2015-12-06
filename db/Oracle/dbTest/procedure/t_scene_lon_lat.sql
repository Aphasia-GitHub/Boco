create or replace procedure t_scene_lon_lat is
  t_int_id    varchar2(32);
  t_bts_id    varchar2(32);
  t_longitude varchar2(32);
  t_latitude  varchar2(32);
  v_count     int(3) := 0;
begin

  for r in (select scene_id from c_tco_pro_scene) loop
    begin
    select t.int_id
      into t_int_id
      from c_tco_group_detail t
     where t.group_id = r.scene_id and rownum<2;

    select related_bts
      into t_bts_id
      from c_cell a
     where a.int_id = t_int_id;

    select longitude, latitude
      into t_longitude, t_latitude
      from c_tco_pro_bts b
     where b.int_id = t_bts_id;
    update c_tco_pro_scene t
       set t.scene_lon = t_longitude, t.scene_lat = t_latitude where t.scene_id=r.scene_id;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
  update c_tco_pro_scene t
       set t.scene_lon = (select round((v.bl_longitude + v.tr_longitude) / 2) from c_region_city v where replace(v.city_name,'ÊÐ','')=t.city_name and v.region_name='\');
    update c_tco_pro_scene t set t.scene_lat =(select  round((v.bl_latitude + v.tr_latitude) / 2) from c_region_city v where replace(v.city_name,'ÊÐ','')=t.city_name and v.region_name='\');
    goto hao;
    end;
    <<hao>>
    v_count := v_count + 1;
    if v_count = 10 then
      commit;
      v_count := 0;
    end if;

  end loop;

  commit;

end t_scene_lon_lat;
