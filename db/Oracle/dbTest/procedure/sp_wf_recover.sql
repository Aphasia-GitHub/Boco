CREATE OR REPLACE PROCEDURE sp_wf_recover
(
       inFlowID in varchar2,
       inLastNodeRunUserID in varchar2,
       inEventName in varchar2,
       inEventValue in varchar2,
       inRunTime in date
)
IS
       flowTraceID varchar2(50);
       doneUserCount number;

       lastFlowTraceID varchar2(50);
       lastFlowTraceUserID varchar2(50);

       flowRunningStatus number := 0;

BEGIN
       SELECT id
       INTO flowTraceID
       FROM wf_flow_trace
       WHERE flow_id = inFlowID
       AND run_status = flowRunningStatus
       AND run_end_time IS NULL;

       SELECT COUNT(id)
       INTO doneUserCount
       FROM wf_flow_traceuser
       WHERE flow_trace_id = flowTraceID
       AND run_begin_time IS NOT NULL
       AND is_cc IS NULL;

       IF doneUserCount > 0 THEN
          BEGIN
             RETURN;
          END;
       END IF;

       --寻找上一运行节点的lastFlowTraceUserID和lastFlowTraceID
       SELECT ftu.id, ftu.flow_trace_id
       INTO lastFlowTraceUserID, lastFlowTraceID
       FROM wf_flow_traceuser ftu
       INNER JOIN wf_flow_trace ft ON ftu.flow_trace_id = ft.id
       WHERE ft.flow_id = inFlowID
       AND ft.run_status = flowRunningStatus
       AND ft.run_end_time IS NOT NULL
       AND ftu.run_user_id = inLastNodeRunUserID
       AND ftu.run_end_time IS NOT NULL
       AND ftu.is_cc IS NULL
       AND rownum = 1
       ORDER BY ftu.run_end_time DESC;


       DELETE FROM wf_flow_traceuser
       WHERE flow_trace_id = flowTraceID;

       DELETE FROM wf_flow_trace
       WHERE id = flowTraceID;

       UPDATE wf_flow_traceuser
       SET run_end_time = NULL
       WHERE id = lastFlowTraceUserID;

       UPDATE wf_flow_trace
       SET run_end_time = NULL
       WHERE id = lastFlowTraceID;


       INSERT INTO wf_flow_traceevent
       (
              id,
              flow_traceuser_id,
              event_name,
              event_value,
              run_begin_time,
              run_end_time
       )
       SELECT SYS_GUID() AS id,
              lastFlowTraceUserID AS flow_traceuser_id,
              inEventName AS event_name,
              inEventValue AS event_value,
              inRunTime AS run_begin_time,
              inRunTime AS run_end_time
       FROM dual;


       COMMIT;

END;
