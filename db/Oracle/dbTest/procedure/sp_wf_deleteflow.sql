CREATE OR REPLACE PROCEDURE sp_wf_deleteflow
(
       inFlowID in varchar2
)
IS
BEGIN
       --删除流程实例
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


       --删除历史流程实例
       DELETE FROM wf_flow_traceevent_hist fte
       WHERE id IN
       (
             SELECT fte.id
             FROM wf_flow_traceevent_hist fte
             INNER JOIN wf_flow_traceuser_hist ftu ON fte.flow_traceuser_id = ftu.id
             INNER JOIN wf_flow_trace_hist ft ON ftu.flow_trace_id = ft.id
             WHERE ft.flow_id = inFlowID
       );

       DELETE FROM wf_flow_traceuser_hist
       WHERE id IN
       (
             SELECT ftu.id
             FROM wf_flow_traceuser_hist ftu
             INNER JOIN wf_flow_trace_hist ft ON ftu.flow_trace_id = ft.id
             WHERE ft.flow_id = inFlowID
       );

       DELETE FROM wf_flow_trace_hist
       WHERE flow_id = inFlowID;

       DELETE FROM wf_flow_nodeusers_hist
       WHERE flow_id = inFlowID;

       DELETE FROM wf_flow_subflow_hist
       WHERE flow_id = inFlowID;

       DELETE FROM wf_flow_node_hist
       WHERE flow_id = inFlowID;

       DELETE FROM wf_flow_hist
       WHERE id = inFlowID;


       COMMIT;

END;
