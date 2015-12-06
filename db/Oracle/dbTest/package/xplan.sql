CREATE OR REPLACE PACKAGE xplan AS

   FUNCTION display( p_table_name   IN VARCHAR2 DEFAULT 'PLAN_TABLE',
                     p_statement_id IN VARCHAR2 DEFAULT NULL,
                     p_format       IN VARCHAR2 DEFAULT 'TYPICAL' )
      RETURN xplan_ntt PIPELINED;

   FUNCTION display_cursor( p_sql_id          IN VARCHAR2 DEFAULT NULL,
                            p_cursor_child_no IN INTEGER  DEFAULT 0,
                            p_format          IN VARCHAR2 DEFAULT 'TYPICAL' )
      RETURN xplan_ntt PIPELINED;

/*
   FUNCTION display_awr( p_sql_id          IN VARCHAR2,
                         p_plan_hash_value IN INTEGER  DEFAULT NULL,
                         p_db_id           IN INTEGER  DEFAULT NULL,
                         p_format          IN VARCHAR2 DEFAULT 'TYPICAL' )
      RETURN xplan_ntt PIPELINED;
*/

END xplan;
