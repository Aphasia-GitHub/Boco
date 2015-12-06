create or replace procedure proc_curTest(
cur_arg out sys_refcursor
)
as
begin
  open cur_arg for
    select
		'' as ID, '' as USER_ID, LAYER_ID, LAYER_NAME,
		FIELD, FIELD_TYPE, '' AS RENDERXML, SYSDATE AS UPDATE_TIME
  from tap_gis_render_setting_init;
end proc_curTest;
