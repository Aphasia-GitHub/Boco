create or replace procedure proc_getGisConfig(
  user_id in varchar2,
  ref_cursor out sys_refcursor
)
as
  rownum number;
begin
  select count(1) into rownum from tap_gis_render_setting where USER_ID = user_id;
  if rownum >0 then
    open ref_cursor for
      select
      ID,
      USER_ID,
      LAYER_ID,
      LAYER_NAME,
      FIELD,
      FIELD_TYPE,
      RENDERXML,
      UPDATE_TIME
      from tap_gis_render_setting where USER_ID = user_id;
  else
    open ref_cursor for
      select
        '' as ID, '' as USER_ID, LAYER_ID, LAYER_NAME,
        FIELD, FIELD_TYPE, '' AS RENDERXML, SYSDATE AS UPDATE_TIME
      from tap_gis_render_setting_init;
  end if;
end proc_getGisConfig;
