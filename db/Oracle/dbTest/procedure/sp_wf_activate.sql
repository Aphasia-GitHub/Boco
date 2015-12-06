CREATE OR REPLACE PROCEDURE sp_wf_activate
(
       inFlowID in varchar2,
       inWorkID in varchar2,
       inRunUserID in varchar2,
       inEventName in varchar2,
       inEventValue in varchar2,
       inRunTime in date
)
IS
       flowTraceID varchar2(50);
       flowTraceUserID varchar2(50);

       flowRunningStatus number := 0;
       flowPendingStatus number := 2;
       flowCancelStatus number := 3;

BEGIN
       SELECT id
       INTO flowTraceID
       FROM wf_flow_trace
       WHERE flow_id = inFlowID
       AND run_status IN(flowPendingStatus, flowCancelStatus,flowPendingStatus)
       AND run_end_time IS NULL;

       SELECT id
       INTO flowTraceUserID
       FROM wf_flow_traceuser
       WHERE flow_trace_id = flowTraceID
       AND work_id = inWorkID
       AND run_user_id = inRunUserID
       AND is_cc IS NULL;

       --¼¤»î
       UPDATE wf_flow
       SET run_status = flowRunningStatus
       WHERE id = inFlowID;

       UPDATE wf_flow_trace
       SET run_status = flowRunningStatus
       WHERE flow_id = inFlowID;

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
              flowTraceUserID AS flow_traceuser_id,
              inEventName AS event_name,
              inEventValue AS event_value,
              inRunTime AS run_begin_time,
              inRunTime AS run_end_time
       FROM dual;


       COMMIT;

END;
