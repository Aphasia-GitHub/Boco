CREATE OR REPLACE PROCEDURE sp_wf_endflow
(
       inFlowID in varchar2,
       inRunEndTime in date
)
IS
       flowEndStatus number := 4;
BEGIN
       UPDATE wf_flow_trace
       SET run_status = flowEndStatus
       WHERE flow_id = inFlowID;

       UPDATE wf_flow
       SET run_end_time = inRunEndTime,
           run_status = flowEndStatus
       WHERE id = inFlowID;

       --当前表 to 历史表
       INSERT INTO wf_flow_hist
       (
              id,
              flowdefine_id,
              flowcategory_id,
              name,
              graph_xml,
              run_status,
              operate_time,
              is_manual,
              parent_flow_id,
              run_user_id,
              run_begin_time,
              run_end_time
       )
       SELECT id,
              flowdefine_id,
              flowcategory_id,
              name,
              graph_xml,
              run_status,
              operate_time,
              is_manual,
              parent_flow_id,
              run_user_id,
              run_begin_time,
              run_end_time
       FROM wf_flow
       WHERE id = inFlowID;

       INSERT INTO wf_flow_node_hist
       (
              id,
              flow_id,
              node_id,
              next_node_id,
              rule_condition,
              rule_result,
              is_default,
              is_return
       )
       SELECT id,
              flow_id,
              node_id,
              next_node_id,
              rule_condition,
              rule_result,
              is_default,
              is_return
       FROM wf_flow_node
       WHERE flow_id = inFlowID;

       INSERT INTO wf_flow_subflow_hist
       (
              id,
              flow_id,
              node_id,
              subflow_id
       )
       SELECT id,
              flow_id,
              node_id,
              subflow_id
       FROM wf_flow_subflow
       WHERE flow_id = inFlowID;

       INSERT INTO wf_flow_nodeusers_hist
       (
              id,
              flow_id,
              node_id,
              user_id,
              source,
              is_cc
       )
       SELECT id,
              flow_id,
              node_id,
              user_id,
              source,
              is_cc
       FROM wf_flow_nodeusers
       WHERE flow_id = inFlowID;

       INSERT INTO wf_flow_trace_hist
       (
              id,
              flow_id,
              run_status,
              run_node_id,
              next_node_id,
              is_need_confirmaccept,
              run_begin_time,
              run_end_time
       )
       SELECT id,
              flow_id,
              run_status,
              run_node_id,
              next_node_id,
              is_need_confirmaccept,
              run_begin_time,
              run_end_time
       FROM wf_flow_trace
       WHERE flow_id = inFlowID;

       INSERT INTO wf_flow_traceuser_hist
       (
              id,
              flow_trace_id,
              work_id,
              run_user_id,
              is_cc,
              run_begin_time,
              run_end_time
       )
       SELECT ftu.id,
              ftu.flow_trace_id,
              ftu.work_id,
              ftu.run_user_id,
              ftu.is_cc,
              ftu.run_begin_time,
              ftu.run_end_time
       FROM wf_flow_traceuser ftu
       INNER JOIN wf_flow_trace ft ON ftu.flow_trace_id = ft.id
       WHERE ft.flow_id = inFlowID;

       INSERT INTO wf_flow_traceevent_hist
       (
              id,
              flow_traceuser_id,
              event_name,
              event_value,
              run_begin_time,
              run_end_time
       )
       SELECT fte.id,
              fte.flow_traceuser_id,
              fte.event_name,
              fte.event_value,
              fte.run_begin_time,
              fte.run_end_time
       FROM wf_flow_traceevent fte
       INNER JOIN wf_flow_traceuser ftu ON fte.flow_traceuser_id = ftu.id
       INNER JOIN wf_flow_trace ft ON ftu.flow_trace_id = ft.id
       WHERE ft.flow_id = inFlowID;

       --删除当前表
       DELETE FROM wf_flow_traceevent fte
       WHERE id IN
       (
             SELECT fte.id
             FROM wf_flow_traceevent fte
             INNER JOIN wf_flow_traceuser ftu ON fte.flow_traceuser_id = ftu.id
             INNER JOIN wf_flow_trace ft ON ftu.flow_trace_id = ft.id
             WHERE ft.flow_id = inFlowID
       );

       DELETE FROM wf_flow_traceuser
       WHERE id IN
       (
             SELECT ftu.id
             FROM wf_flow_traceuser ftu
             INNER JOIN wf_flow_trace ft ON ftu.flow_trace_id = ft.id
             WHERE ft.flow_id = inFlowID
       );

       DELETE FROM wf_flow_trace
       WHERE flow_id = inFlowID;

       DELETE FROM wf_flow_nodeusers
       WHERE flow_id = inFlowID;

       DELETE FROM wf_flow_subflow
       WHERE flow_id = inFlowID;

       DELETE FROM wf_flow_node
       WHERE flow_id = inFlowID;

       DELETE FROM wf_flow
       WHERE id = inFlowID;


       COMMIT;

END;
