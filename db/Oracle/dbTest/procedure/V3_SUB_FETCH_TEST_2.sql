CREATE OR REPLACE PROCEDURE V3_SUB_FETCH_TEST_2
AS
  --游标定义
  type ref_cursor_type is REF CURSOR;
  cursor_select   ref_cursor_type;
  select_cname    varchar2(1000);

  v_file_handle   utl_file.file_type;

  v_filepath Varchar2(500);
  v_filename Varchar2(500);
  --缓冲区
  v_results Varchar2(500);

  v_cityid varchar2(1000);
  v_regionid Varchar2(500);

  begin
      v_filepath := '/opt/BOCO.SUM/rnop/cover';
      --v_filename:='free_'|| substr(to_char(sysdate,'YYYYMMDDHH24MI'),1,10) ||'.all' ;
      --游标开始
      select_cname:='select inforspot_num,whetherpushed from rnop1.tco_pro_cover_benchmark where whetherpushed='''||'是''';
      --dbms_output.put_line(select_cname);
      --打开一个文件句柄 ,同时fopen的第一个参数必须是大写
      v_file_handle:=utl_file.fopen('BBB','test.txt','W');
      dbms_output.put_line(v_filepath);
      Open cursor_select For select_cname;
      Fetch  cursor_select into v_cityid,v_regionid;
      While  cursor_select%Found
      Loop
      v_results := v_cityid||'|'||v_regionid;
      --将v_results写入文件
      utl_file.put_line(v_file_handle,v_results);
      Fetch  cursor_select into v_cityid,v_regionid;
      End Loop;

      Close cursor_select;--关闭游标
      utl_file.fClose(v_file_handle);--关闭句柄
  end V3_SUB_FETCH_TEST_2;
