create or replace procedure pro_general_template_query_v3 --通用模板查询
( -- 以下为参数声明部分
   tResultName in varchar2,   -- 结果表名
   NEFilterSQLStr in varchar2, --网元过滤
   TimeFilterSQLStr1 in varchar2, --时间过滤
   TimeFilterSQLStr2 in varchar2, --时间过滤
   NEAndTimeFilterSQLStr in varchar2, -- 网元和时间的组合脚本
   NEAndTimeFilterSQLStr1 in varchar2, -- 网元和时间的组合脚本
   SQLFlutterStr in varchar2, -- 波动门限查询 added by 叶刚
   SimpleQueryScene in integer, --是否简单查询
   HistoryNEQuery in integer,   -- 是否历史网元查询
   TimePointCount integer,     -- 时间点个数
   SQLColumns1 in varchar2, -- 查询的结果列
   SQLColumns2 in varchar2, -- 查询的结果列
   SQLColumns3 in varchar2, -- 查询的结果列
   SQLColumns4 in varchar2, -- 查询的结果列
   SQLColumns5 in varchar2, -- 查询的结果列
   SQLColumns6 in varchar2, -- 查询的结果列
   SQLColumns7 in varchar2, -- 查询的结果列
   SQLColumns8 in varchar2, -- 查询的结果列
   SQLColumns9 in varchar2, -- 查询的结果列
   SQLColumns10 in varchar2, -- 查询的结果列
   SQLFromStr in varchar2, -- 查询来源表
   SQLFromStr1 in varchar2, -- 查询来源表
   SQLFromStr2 in varchar2, -- 查询来源表
   SQLFromStr3 in varchar2, -- 查询来源表
   SQLFromStr4 in varchar2, -- 查询来源表
   SQLFromStr5 in varchar2, -- 查询来源表
   SQLFromStr6 in varchar2, -- 查询来源表
   SQLFromStr7 in varchar2, -- 查询来源表
   SQLFromStr8 in varchar2, -- 查询来源表
   SQLFromStr9 in varchar2, -- 查询来源表
   SQLFromStr10 in varchar2, -- 查询来源表
   SQLWhereStr1 in varchar2, -- 查询过滤SQL
   SQLWhereStr2 in varchar2, -- 查询过滤SQL
   SQLWhereStr3 in varchar2, -- 查询过滤SQL
   SQLWhereStr4 in varchar2, -- 查询过滤SQL
   SQLWhereStr5 in varchar2, -- 查询过滤SQL
   SQLWhereStr6 in varchar2, -- 查询过滤SQL
   SQLWhereStr7 in varchar2, -- 查询过滤SQL
   SQLWhereStr8 in varchar2, -- 查询过滤SQL
   SQLWhereStr9 in varchar2, -- 查询过滤SQL
   SQLWhereStr10 in varchar2, -- 查询过滤SQL
   SQLWhereStr11 in varchar2, -- 查询过滤SQL
   SQLWhereStr12 in varchar2, -- 查询过滤SQL
   SQLWhereStr13 in varchar2, -- 查询过滤SQL
   SQLWhereStr14 in varchar2, -- 查询过滤SQL
   SQLWhereStr15 in varchar2, -- 查询过滤SQL
   SQLOrderStr in varchar2, -- 排序SQL
   pageSize          in integer, -- 一页的记录数
   curPageIndex      in integer, -- 要查询的页码，必须大于等于0
   totalRowsCount    in out integer, -- 结果行数，为0表示需要统计，不为0不需要统计
   totalPagesCount   in out integer,  -- 结果页数，为0表示需要统计，不为0不需要统计
   p_cursor          out SYS_REFCURSOR -- 游标返回结果集
 ) is
   v_tResultRecordCount number:=0;

   --分页起始记录编号
   v_startRowNum NUMBER:= (curPageIndex - 1) * pageSize + 1;
   --分页结束记录编号
   v_endRowNum NUMBER:= v_startRowNum + pageSize;

   v_exists NUMBER:=0;

   v_errmsg varchar2(4000);
BEGIN
  --存储过程执行体
  execute immediate 'alter session set NLS_DATE_FORMAT=''YYYY-MM-DD HH24:MI:SS''';

  --统计行数
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
        --计算页数
        totalPagesCount:=totalRowsCount/pageSize;
        return;

     end if;
  end if;

  --第2步：取数据
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
