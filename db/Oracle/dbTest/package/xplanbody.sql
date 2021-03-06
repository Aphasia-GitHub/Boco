CREATE OR REPLACE PACKAGE BODY xplan AS

   TYPE ntt_order_map_binds IS TABLE OF VARCHAR2(100);

   TYPE aat_order_map IS TABLE OF PLS_INTEGER
      INDEX BY PLS_INTEGER;

   g_map  aat_order_map;
   g_hdrs PLS_INTEGER;
   g_len  PLS_INTEGER;
   g_pad  VARCHAR2(300);

   ----------------------------------------------------------------------------
   PROCEDURE reset_state IS
   BEGIN
      g_hdrs := 0;
      g_len  := 0;
      g_pad  := NULL;
      g_map.DELETE;
   END reset_state;

   ----------------------------------------------------------------------------
   PROCEDURE build_order_map( p_sql   IN VARCHAR2,
                              p_binds IN ntt_order_map_binds ) IS

      TYPE rt_id_data IS RECORD
      ( id  PLS_INTEGER
      , ord PLS_INTEGER );

      TYPE aat_id_data IS TABLE OF rt_id_data
         INDEX BY PLS_INTEGER;

      aa_ids   aat_id_data;
      v_cursor SYS_REFCURSOR;
      v_sql    VARCHAR2(32767);

   BEGIN

      -- Build SQL template...
      -- ---------------------
      v_sql := 'WITH sql_plan_data AS ( ' ||
                        p_sql || '
                        )
                ,    hierarchical_sql_plan_data AS (
                        SELECT id
                        FROM   sql_plan_data
                        START WITH id = 0
                        CONNECT BY PRIOR id = parent_id
                        ORDER SIBLINGS BY id DESC
                        )
                SELECT id
                ,      ROW_NUMBER() OVER (ORDER BY ROWNUM DESC) AS ord
                FROM   hierarchical_sql_plan_data';

      -- Binds will differ according to plan type...
      -- -------------------------------------------
      CASE p_binds.COUNT
         WHEN 0
         THEN
            OPEN v_cursor FOR v_sql;
         WHEN 1
         THEN
            OPEN v_cursor FOR v_sql USING p_binds(1);
         WHEN 2
         THEN
            OPEN v_cursor FOR v_sql USING p_binds(1),
                                          TO_NUMBER(p_binds(2));
         WHEN 3
         THEN
            OPEN v_cursor FOR v_sql USING p_binds(1),
                                          TO_NUMBER(p_binds(2)),
                                          TO_NUMBER(p_binds(3));
      END CASE;

      -- Fetch the ID and order data...
      -- ------------------------------
      FETCH v_cursor BULK COLLECT INTO aa_ids;
      CLOSE v_cursor;

      -- Populate the order map...
      -- -------------------------
      FOR i IN 1 .. aa_ids.COUNT LOOP
         g_map(aa_ids(i).id) := aa_ids(i).ord;
      END LOOP;

      -- Use the map to determine padding needed to slot in our order column...
      -- ----------------------------------------------------------------------
      IF g_map.COUNT > 0 THEN
         g_len := LEAST(LENGTH(g_map.LAST) + 7, 8);
         g_pad := LPAD('-', g_len, '-');
      END IF;

   END build_order_map;

   ----------------------------------------------------------------------------
   FUNCTION prepare_row( p_curr IN VARCHAR2,
                         p_next IN VARCHAR2 ) RETURN xplan_ot IS

      v_id  PLS_INTEGER;
      v_row VARCHAR2(4000);
      v_hdr VARCHAR2(64) := '%|%Id%|%Operation%|%';

   BEGIN

      -- Intercept the plan section to include a new column for the
      -- the operation order that we mapped earlier. The plan output
      -- itself will be bound by the 2nd, 3rd and 4th dashed lines.
      -- We need to add in additional dashes, the order column heading
      -- and the order value itself...
      -- -------------------------------------------------------------

      IF p_curr LIKE '---%' THEN

         IF p_next LIKE v_hdr THEN
            g_hdrs := 1;
            v_row := g_pad || p_curr;
         ELSIF g_hdrs BETWEEN 1 AND 3 THEN
            g_hdrs := g_hdrs + 1;
            v_row := g_pad || p_curr;
         ELSE
            v_row := p_curr;
         END IF;

      ELSIF p_curr LIKE v_hdr THEN

         v_row := REGEXP_REPLACE(
                     p_curr, '\|',
                     RPAD('|', GREATEST(g_len-7, 2)) || 'Order |',
                     1, 2
                     );

      ELSIF REGEXP_LIKE(p_curr, '^\|[\* 0-9]+\|') THEN

         v_id := REGEXP_SUBSTR(p_curr, '[0-9]+');
         v_row := REGEXP_REPLACE(
                     p_curr, '\|',
                     '|' || LPAD(g_map(v_id), GREATEST(g_len-8, 6)) || ' |',
                     1, 2
                     );
      ELSE
         v_row := p_curr;
      END IF;

      RETURN xplan_ot(v_row);

   END prepare_row;

   ----------------------------------------------------------------------------
   FUNCTION display( p_table_name   IN VARCHAR2 DEFAULT 'PLAN_TABLE',
                     p_statement_id IN VARCHAR2 DEFAULT NULL,
                     p_format       IN VARCHAR2 DEFAULT 'TYPICAL' )
      RETURN xplan_ntt PIPELINED IS

      v_plan_table   VARCHAR2(128) := NVL(p_table_name, 'PLAN_TABLE');
      v_sql          VARCHAR2(512);
      v_binds        ntt_order_map_binds := ntt_order_map_binds();

   BEGIN

      reset_state();

      -- Prepare the inputs for the order map...
      -- ---------------------------------------
      v_sql := 'SELECT id, parent_id
                FROM   ' || v_plan_table || '
                WHERE  plan_id = (SELECT MAX(plan_id)
                                  FROM   ' || v_plan_table || '
                                  WHERE  id = 0 %bind%)
                ORDER  BY id';

      IF p_statement_id IS NULL THEN
         v_sql := REPLACE(v_sql, '%bind%');
      ELSE
         v_sql := REPLACE(v_sql, '%bind%', 'AND statement_id = :bv_statement_id');
         v_binds := ntt_order_map_binds(p_statement_id);
      END IF;

      -- Build the order map...
      -- --------------------------------------------------
      build_order_map(v_sql, v_binds);

      -- Now we can call DBMS_XPLAN to output the plan...
      -- ------------------------------------------------
      FOR r_plan IN ( SELECT plan_table_output AS p
                      ,      LEAD(plan_table_output) OVER (ORDER BY ROWNUM) AS np
                      FROM   TABLE(
                                DBMS_XPLAN.DISPLAY(
                                   v_plan_table, p_statement_id, p_format
                                   ))
                      ORDER  BY
                             ROWNUM)
      LOOP
         IF g_map.COUNT > 0 THEN
            PIPE ROW (prepare_row(r_plan.p, r_plan.np));
         ELSE
            PIPE ROW (xplan_ot(r_plan.p));
         END IF;
      END LOOP;

      reset_state();
      RETURN;

   END display;

   ----------------------------------------------------------------------------
   FUNCTION display_cursor( p_sql_id          IN VARCHAR2 DEFAULT NULL,
                            p_cursor_child_no IN INTEGER  DEFAULT 0,
                            p_format          IN VARCHAR2 DEFAULT 'TYPICAL' )
      RETURN xplan_ntt PIPELINED IS

      v_sql_id   v$sql_plan.sql_id%TYPE;
      v_child_no v$sql_plan.child_number%TYPE;
      v_sql      VARCHAR2(256);
      v_binds    ntt_order_map_binds := ntt_order_map_binds();

   BEGIN

      reset_state();

      -- Set a SQL_ID if default parameters passed...
      -- --------------------------------------------
      IF p_sql_id IS NULL THEN
         SELECT prev_sql_id, prev_child_number
         INTO   v_sql_id, v_child_no
         FROM   v$session
         WHERE  sid = (SELECT m.sid FROM v$mystat m WHERE ROWNUM = 1)
         AND    username IS NOT NULL
         AND    prev_hash_value <> 0;
      ELSE
         v_sql_id := p_sql_id;
         v_child_no := p_cursor_child_no;
      END IF;

      -- Prepare the inputs for the order mapping...
      -- -------------------------------------------
      v_sql := 'SELECT id, parent_id
                FROM   v$sql_plan
                WHERE  sql_id = :bv_sql_id
                AND    child_number = :bv_child_no';

      v_binds := ntt_order_map_binds(v_sql_id, v_child_no);

      -- Build the plan order map from the SQL...
      -- ----------------------------------------
      build_order_map(v_sql, v_binds);

      -- Now we can call DBMS_XPLAN to output the plan...
      -- ------------------------------------------------
      FOR r_plan IN ( SELECT plan_table_output AS p
                      ,      LEAD(plan_table_output) OVER (ORDER BY ROWNUM) AS np
                      FROM   TABLE(
                                DBMS_XPLAN.DISPLAY_CURSOR(
                                   v_sql_id, v_child_no, p_format
                                   ))
                      ORDER  BY
                             ROWNUM)
      LOOP
         IF g_map.COUNT > 0 THEN
            PIPE ROW (prepare_row(r_plan.p, r_plan.np));
         ELSE
            PIPE ROW (xplan_ot(r_plan.p));
         END IF;
      END LOOP;

      reset_state();
      RETURN;

   END display_cursor;


   ----------------------------------------------------------------------------
   FUNCTION display_awr( p_sql_id          IN VARCHAR2,
                         p_plan_hash_value IN INTEGER  DEFAULT NULL,
                         p_db_id           IN INTEGER  DEFAULT NULL,
                         p_format          IN VARCHAR2 DEFAULT 'TYPICAL' )
      RETURN xplan_ntt PIPELINED IS

      v_sql      VARCHAR2(256);
      v_binds    ntt_order_map_binds := ntt_order_map_binds();

   BEGIN

      reset_state();

      -- Prepare the SQL for the order mapping...
      -- ----------------------------------------
      v_sql := 'SELECT id, parent_id
                FROM   dba_hist_sql_plan
                WHERE  sql_id = :bv_sql_id
                AND    plan_hash_value = :bv_plan_hash_value
                AND    dbid = :bv_dbid';

      -- Determine all plans for the sql_id...
      -- -------------------------------------
      FOR r_awr IN (SELECT DISTINCT
                           sql_id
                    ,      plan_hash_value
                    ,      dbid
                    FROM   dba_hist_sql_plan
                    WHERE  sql_id = p_sql_id
                    AND    plan_hash_value = NVL(p_plan_hash_value, plan_hash_value)
                    AND    dbid = NVL(p_db_id, (SELECT dbid FROM v$database))
                    ORDER  BY
                           plan_hash_value)
      LOOP

         -- Prepare the binds and build the order map...
         -- --------------------------------------------
         v_binds := ntt_order_map_binds(r_awr.sql_id,
                                        r_awr.plan_hash_value,
                                        r_awr.dbid);

         -- Build the plan order map from the SQL...
         -- ----------------------------------------
         build_order_map(v_sql, v_binds);

         -- Now we can call DBMS_XPLAN to output the plan...
         -- ------------------------------------------------
         FOR r_plan IN ( SELECT plan_table_output AS p
                         ,      LEAD(plan_table_output) OVER (ORDER BY ROWNUM) AS np
                         FROM   TABLE(
                                   DBMS_XPLAN.DISPLAY_AWR(
                                      r_awr.sql_id, r_awr.plan_hash_value,
                                      r_awr.dbid, p_format
                                      ))
                         ORDER  BY
                                ROWNUM)
         LOOP
            IF g_map.COUNT > 0 THEN
               PIPE ROW (prepare_row(r_plan.p, r_plan.np));
            ELSE
               PIPE ROW (xplan_ot(r_plan.p));
            END IF;
         END LOOP;

      END LOOP;

      reset_state();
      RETURN;

   END display_awr;


END xplan;
