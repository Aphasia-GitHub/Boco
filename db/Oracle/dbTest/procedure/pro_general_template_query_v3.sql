create or replace procedure pro_general_template_query_v3 --ͨ��ģ���ѯ
( -- ����Ϊ������������
   tResultName in varchar2,   -- �������
   NEFilterSQLStr in varchar2, --��Ԫ����
   TimeFilterSQLStr1 in varchar2, --ʱ�����
   TimeFilterSQLStr2 in varchar2, --ʱ�����
   NEAndTimeFilterSQLStr in varchar2, -- ��Ԫ��ʱ�����Ͻű�
   NEAndTimeFilterSQLStr1 in varchar2, -- ��Ԫ��ʱ�����Ͻű�
   SQLFlutterStr in varchar2, -- �������޲�ѯ added by Ҷ��
   SimpleQueryScene in integer, --�Ƿ�򵥲�ѯ
   HistoryNEQuery in integer,   -- �Ƿ���ʷ��Ԫ��ѯ
   TimePointCount integer,     -- ʱ������
   SQLColumns1 in varchar2, -- ��ѯ�Ľ����
   SQLColumns2 in varchar2, -- ��ѯ�Ľ����
   SQLColumns3 in varchar2, -- ��ѯ�Ľ����
   SQLColumns4 in varchar2, -- ��ѯ�Ľ����
   SQLColumns5 in varchar2, -- ��ѯ�Ľ����
   SQLColumns6 in varchar2, -- ��ѯ�Ľ����
   SQLColumns7 in varchar2, -- ��ѯ�Ľ����
   SQLColumns8 in varchar2, -- ��ѯ�Ľ����
   SQLColumns9 in varchar2, -- ��ѯ�Ľ����
   SQLColumns10 in varchar2, -- ��ѯ�Ľ����
   SQLFromStr in varchar2, -- ��ѯ��Դ��
   SQLFromStr1 in varchar2, -- ��ѯ��Դ��
   SQLFromStr2 in varchar2, -- ��ѯ��Դ��
   SQLFromStr3 in varchar2, -- ��ѯ��Դ��
   SQLFromStr4 in varchar2, -- ��ѯ��Դ��
   SQLFromStr5 in varchar2, -- ��ѯ��Դ��
   SQLFromStr6 in varchar2, -- ��ѯ��Դ��
   SQLFromStr7 in varchar2, -- ��ѯ��Դ��
   SQLFromStr8 in varchar2, -- ��ѯ��Դ��
   SQLFromStr9 in varchar2, -- ��ѯ��Դ��
   SQLFromStr10 in varchar2, -- ��ѯ��Դ��
   SQLWhereStr1 in varchar2, -- ��ѯ����SQL
   SQLWhereStr2 in varchar2, -- ��ѯ����SQL
   SQLWhereStr3 in varchar2, -- ��ѯ����SQL
   SQLWhereStr4 in varchar2, -- ��ѯ����SQL
   SQLWhereStr5 in varchar2, -- ��ѯ����SQL
   SQLWhereStr6 in varchar2, -- ��ѯ����SQL
   SQLWhereStr7 in varchar2, -- ��ѯ����SQL
   SQLWhereStr8 in varchar2, -- ��ѯ����SQL
   SQLWhereStr9 in varchar2, -- ��ѯ����SQL
   SQLWhereStr10 in varchar2, -- ��ѯ����SQL
   SQLWhereStr11 in varchar2, -- ��ѯ����SQL
   SQLWhereStr12 in varchar2, -- ��ѯ����SQL
   SQLWhereStr13 in varchar2, -- ��ѯ����SQL
   SQLWhereStr14 in varchar2, -- ��ѯ����SQL
   SQLWhereStr15 in varchar2, -- ��ѯ����SQL
   SQLOrderStr in varchar2, -- ����SQL
   pageSize          in integer, -- һҳ�ļ�¼��
   curPageIndex      in integer, -- Ҫ��ѯ��ҳ�룬������ڵ���0
   totalRowsCount    in out integer, -- ���������Ϊ0��ʾ��Ҫͳ�ƣ���Ϊ0����Ҫͳ��
   totalPagesCount   in out integer,  -- ���ҳ����Ϊ0��ʾ��Ҫͳ�ƣ���Ϊ0����Ҫͳ��
   p_cursor          out SYS_REFCURSOR -- �α귵�ؽ����
 ) is
   v_tResultRecordCount number:=0;

   --��ҳ��ʼ��¼���
   v_startRowNum NUMBER:= (curPageIndex - 1) * pageSize + 1;
   --��ҳ������¼���
   v_endRowNum NUMBER:= v_startRowNum + pageSize;

   v_exists NUMBER:=0;

   v_errmsg varchar2(4000);
BEGIN
  --�洢����ִ����
  execute immediate 'alter session set NLS_DATE_FORMAT=''YYYY-MM-DD HH24:MI:SS''';

  --ͳ������
  if totalRowsCount = -1 then
     if SQLFromStr is not null and curPageIndex <> -1 then
        if SQLFlutterStr is not null then
             execute immediate 'CREATE GLOBAL TEMPORARY TABLE '|| tResultName ||' ON COMMIT PRESERVE ROWS as select * from (' ||
             ' with ' ||  Replace(tResultName,'TMPR','TIDT')  || ' as ' ||
             '(select scan_start_time, int_id from(' ||
             NEAndTimeFilterSQLStr || ')) ' || ' select ' ||
             SQLColumns1 || SQLColumns2 || SQLColumns3|| SQLColumns4 || SQLColumns5|| SQLColumns6 ||
             SQLColumns7 || SQLColumns8 || SQLColumns9|| SQLColumns10 ||
             ' from ' || SQLFromStr1 ||SQLFromStr2||SQLFromStr3||SQLFromStr4||SQLFromStr5||SQLFromStr6||SQLFromStr7||SQLFromStr8||SQLFromStr9||SQLFromStr10 || ' ' ||
             SQLWhereStr1 || SQLWhereStr2 || SQLWhereStr3 || SQLWhereStr4 || SQLWhereStr5 || SQLWhereStr6 ||
             SQLWhereStr7 || SQLWhereStr8 || SQLWhereStr9 || SQLWhereStr10 || SQLWhereStr11 || SQLWhereStr12 || SQLWhereStr13 || SQLWhereStr14 || SQLWhereStr15 || ' ' || SQLOrderStr || ')';
             execute immediate 'select count(*) from (' ||SQLFlutterStr || ') a '  into totalRowsCount;
        else
          if SimpleQueryScene = 8 then
           --dbms_output.PUT_LINE('select count(*) from ' || SQLFromStr || ' ' || SQLWhereStr);
           --execute immediate NEFilterSQLStr into totalRowsCount;

              execute immediate 'with ' || Replace(tResultName,'TMPR','TIDT') || ' as' ||
              '(select scan_start_time, int_id from(' ||
               NEAndTimeFilterSQLStr || ')) ' ||
              'select count(*) from ( select count(*) from ' || SQLFromStr1 ||SQLFromStr2||SQLFromStr3||SQLFromStr4||SQLFromStr5||SQLFromStr6||SQLFromStr7||SQLFromStr8||SQLFromStr9||SQLFromStr10 ||  ' ' ||
              SQLWhereStr1 || SQLWhereStr2 || SQLWhereStr3 || SQLWhereStr4 ||
              SQLWhereStr5 || SQLWhereStr6 || SQLWhereStr7 || SQLWhereStr8 || SQLWhereStr9 || SQLWhereStr10 || SQLWhereStr11 || SQLWhereStr12 || SQLWhereStr13 ||
              SQLWhereStr14 || SQLWhereStr15 || ' ) a ' into totalRowsCount;

          else
              execute immediate  'with ' || Replace(tResultName,'TMPR','TIDT') || ' as' ||
              '(select scan_start_time, int_id from(' ||
              NEAndTimeFilterSQLStr || ')) ' ||
              'select count(*) from ' || SQLFromStr1 ||SQLFromStr2||SQLFromStr3||SQLFromStr4||SQLFromStr5||SQLFromStr6||SQLFromStr7||SQLFromStr8||SQLFromStr9||SQLFromStr10 || ' ' ||
              SQLWhereStr1 || SQLWhereStr2 || SQLWhereStr3 || SQLWhereStr4 || SQLWhereStr5 ||
              SQLWhereStr6 || SQLWhereStr7 || SQLWhereStr8 || SQLWhereStr9 || SQLWhereStr10 || SQLWhereStr11 || SQLWhereStr12 || SQLWhereStr13 || SQLWhereStr14 || SQLWhereStr15 into totalRowsCount;

          end if;
      end if;
        --����ҳ��
        totalPagesCount:=totalRowsCount/pageSize;
        return;

     end if;
  end if;

  --��2����ȡ����
  if SQLFromStr is not null then
       --dbms_output.PUT_LINE('with ' || Replace(tResultName,'TMPR','TIDT') || ' as' ||

       if curPageIndex <> -1 then
           if SQLFlutterStr is not null then
               /* execute immediate 'select count(*) from user_tables  where table_name = '|| tResultName  into v_exists;
                if v_exists > 0 then
                  execute immediate 'drop table '|| tResultName;
                end if; */
                  execute immediate 'CREATE GLOBAL TEMPORARY TABLE '|| tResultName ||' ON COMMIT PRESERVE ROWS as select * from (' ||
                  ' with ' ||  Replace(tResultName,'TMPR','TIDT')  || ' as ' ||
                  '(select scan_start_time, int_id from(' ||
                  NEAndTimeFilterSQLStr || ')) ' || ' select ' ||
                  SQLColumns1 || SQLColumns2 || SQLColumns3|| SQLColumns4 || SQLColumns5|| SQLColumns6 ||
                  SQLColumns7 || SQLColumns8 || SQLColumns9|| SQLColumns10 ||
                  ' from ' || SQLFromStr1 ||SQLFromStr2||SQLFromStr3||SQLFromStr4||SQLFromStr5||SQLFromStr6||SQLFromStr7||SQLFromStr8||SQLFromStr9||SQLFromStr10 || ' ' ||
                   SQLWhereStr1 || SQLWhereStr2 || SQLWhereStr3 || SQLWhereStr4 || SQLWhereStr5 || SQLWhereStr6 ||
                  SQLWhereStr7 || SQLWhereStr8 || SQLWhereStr9 || SQLWhereStr10 || SQLWhereStr11 || SQLWhereStr12 || SQLWhereStr13 || SQLWhereStr14 || SQLWhereStr15 || ' ' || SQLOrderStr || ')';

                  open p_cursor for
                  'select * from ( select A.*, ROWNUM RN from  (' ||SQLFlutterStr || ')A where ROWNUM < ' ||
                  v_endRowNum  || ' ) where rn >=' || v_startRowNum;

           else
                open p_cursor for

                'with ' || Replace(tResultName,'TMPR','TIDT') || ' as' ||
                '(select scan_start_time, int_id from(' ||
                NEAndTimeFilterSQLStr || ')) ' ||
                'select * from ( select A.*, ROWNUM RN from ( select ' ||
                SQLColumns1 || SQLColumns2 || SQLColumns3|| SQLColumns4 || SQLColumns5|| SQLColumns6 ||
                SQLColumns7 || SQLColumns8 || SQLColumns9|| SQLColumns10 ||
                ' from ' || SQLFromStr1 ||SQLFromStr2||SQLFromStr3||SQLFromStr4||SQLFromStr5||SQLFromStr6||SQLFromStr7||SQLFromStr8||SQLFromStr9||SQLFromStr10 || ' ' ||
                 SQLWhereStr1 || SQLWhereStr2 || SQLWhereStr3 || SQLWhereStr4 || SQLWhereStr5 || SQLWhereStr6 || SQLWhereStr7 || SQLWhereStr8 || SQLWhereStr9 || SQLWhereStr10 || SQLWhereStr11 || SQLWhereStr12 || SQLWhereStr13 || SQLWhereStr14 || SQLWhereStr15 || ' ' || SQLOrderStr || ') A where ROWNUM < ' ||
                v_endRowNum  || ' ) where rn >=' || v_startRowNum;


          end if;
       else
         --dbms_output.PUT_LINE( 'with ' || Replace(tResultName,'TMPR','TIDT') || ' as' ||

        if SQLFlutterStr is not null then
               execute immediate 'CREATE GLOBAL TEMPORARY TABLE '|| tResultName ||' ON COMMIT PRESERVE ROWS as select * from (' ||
                ' with ' ||  Replace(tResultName,'TMPR','TIDT')  || ' as ' ||
                '(select scan_start_time, int_id from(' ||
                NEAndTimeFilterSQLStr || ')) ' || ' select ' ||
                SQLColumns1 || SQLColumns2 || SQLColumns3|| SQLColumns4 || SQLColumns5|| SQLColumns6 ||
                SQLColumns7 || SQLColumns8 || SQLColumns9|| SQLColumns10 ||
                ' from ' || SQLFromStr1 ||SQLFromStr2||SQLFromStr3||SQLFromStr4||SQLFromStr5||SQLFromStr6||SQLFromStr7||SQLFromStr8||SQLFromStr9||SQLFromStr10 || ' ' ||
                 SQLWhereStr1 || SQLWhereStr2 || SQLWhereStr3 || SQLWhereStr4 || SQLWhereStr5 || SQLWhereStr6 || SQLWhereStr7 || SQLWhereStr8 || SQLWhereStr9 || SQLWhereStr10 || SQLWhereStr11 || SQLWhereStr12 || SQLWhereStr13 || SQLWhereStr14 || SQLWhereStr15 || ' ' || SQLOrderStr || ')';
                open p_cursor for
                'select * from (' ||SQLFlutterStr || ')';
          else
               open p_cursor for
               'with ' || Replace(tResultName,'TMPR','TIDT') || ' as ' ||
               '(select scan_start_time, int_id from(' ||
               NEAndTimeFilterSQLStr || ')) ' || 'select ' ||
               SQLColumns1 || SQLColumns2 || SQLColumns3|| SQLColumns4 || SQLColumns5|| SQLColumns6 ||
               SQLColumns7 || SQLColumns8 || SQLColumns9|| SQLColumns10 ||
               ' from ' || SQLFromStr1 ||SQLFromStr2||SQLFromStr3||SQLFromStr4||SQLFromStr5||SQLFromStr6||SQLFromStr7||SQLFromStr8||SQLFromStr9||SQLFromStr10 || ' ' ||
               SQLWhereStr1 || SQLWhereStr2 || SQLWhereStr3 || SQLWhereStr4 || SQLWhereStr5 || SQLWhereStr6 || SQLWhereStr7 || SQLWhereStr8 ||
               SQLWhereStr9 || SQLWhereStr10 || SQLWhereStr11 || SQLWhereStr12 || SQLWhereStr13 || SQLWhereStr14 || SQLWhereStr15 || ' ' || SQLOrderStr;

          end if;
       end if;
  end if;

exception

when others then
v_errmsg:=to_char(SQLCODE)||' '||sqlerrm||' '||
'CREATE GLOBAL TEMPORARY TABLE '|| tResultName ||' ON COMMIT PRESERVE ROWS as select * from (' ||
             ' with ' ||  Replace(tResultName,'TMPR','TIDT')  || ' as ' ||
             '(select scan_start_time, int_id from(' ||
             NEAndTimeFilterSQLStr || ')) ' || ' select ' ||
             SQLColumns1 || SQLColumns2 || SQLColumns3|| SQLColumns4 || SQLColumns5|| SQLColumns6 ||
             SQLColumns7 || SQLColumns8 || SQLColumns9|| SQLColumns10 ||
             ' from ' || SQLFromStr1 ||SQLFromStr2||SQLFromStr3||SQLFromStr4||SQLFromStr5||SQLFromStr6||SQLFromStr7||SQLFromStr8||SQLFromStr9||SQLFromStr10 || ' ' ||
             SQLWhereStr1 || SQLWhereStr2 || SQLWhereStr3 || SQLWhereStr4 || SQLWhereStr5 || SQLWhereStr6 ||
             SQLWhereStr7 || SQLWhereStr8 || SQLWhereStr9 || SQLWhereStr10 || SQLWhereStr11 || SQLWhereStr12 || SQLWhereStr13 || SQLWhereStr14 || SQLWhereStr15 || ' ' || SQLOrderStr || ')'
;
--insert into t_log (log_seq,log_dt,log_msg) values (seq_t_log.nextval,sysdate,v_errmsg);
  open p_cursor for 'select 1,2,''DRAWCHART'' from dual';
END;
