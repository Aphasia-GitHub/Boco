CREATE OR REPLACE PROCEDURE sp_wf_urge
(
       inFlowID in varchar2,
       inLastNodeRunUserID in varchar2,
       inEventName in varchar2,
       inRunTime in date
)
IS
       lastFlowTraceID varchar2(50);
       lastFlowTraceUserID varchar2(50);

       eventNameOfUrge varchar2(50) := 'Urge';
       urged number;
       once number := 1;

       flowRunningStatus number := 0;

BEGIN
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

       SELECT COUNT(id)
       INTO urged
       FROM wf_flow_traceevent
       WHERE flow_traceuser_id = lastFlowTraceUserID
       AND event_name = eventNameOfUrge;

       IF urged = 0 THEN
          BEGIN
             --之前没有催办过
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
                    once AS event_value,
                    inRunTime AS run_begin_time,
                    inRunTime AS run_end_time
             FROM dual;
          END;
       ELSE
          BEGIN
             --之前执行过催办
             UPDATE wf_flow_traceevent
             SET event_value = event_value + once
             WHERE flow_traceuser_id = lastFlowTraceUserID
             AND event_name = eventNameOfUrge;
          END;
       END IF;


       COMMIT;

END;
