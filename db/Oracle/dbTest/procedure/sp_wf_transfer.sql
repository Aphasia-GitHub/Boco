CREATE OR REPLACE PROCEDURE sp_wf_transfer
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
       flowDraftStatus number := 1;

BEGIN
       SELECT id
       INTO flowTraceID
       FROM wf_flow_trace
       WHERE flow_id = inFlowID
       AND run_status IN(flowRunningStatus, flowDraftStatus)
       AND run_end_time IS NULL;

       SELECT id
       INTO flowTraceUserID
       FROM wf_flow_traceuser
       WHERE flow_trace_id = flowTraceID
       AND work_id = inWorkID
       AND run_user_id = inRunUserID
       AND is_cc IS NULL;

       IF inEventValue IS NOT NULL THEN
          BEGIN
              --移交前，将移交用户放入已办理列表
              --这个逻辑会在退回时影响退回人的获得
              --工作移交了，可以理解为和自己无关了
              /*INSERT INTO wf_flow_traceuser
              (
                     id,
                     flow_trace_id,
                     work_id,
                     run_user_id,
                     is_cc,
                     run_begin_time,
                     run_end_time
              )
              SELECT
                     SYS_GUID() AS id,
                     flow_trace_id,
                     SYS_GUID() AS work_id,
                     run_user_id,
                     is_cc,
                     run_begin_time,
                     inRunTime AS run_end_time
              FROM wf_flow_traceuser
              WHERE id = flowTraceUserID;*/

              --移交，将当前操作用户修改为移交人（通过inEventValue传入）
              UPDATE wf_flow_traceuser
              SET run_user_id = inEventValue
              WHERE id = flowTraceUserID;

              --将原用户记录到跟踪事件的event_value中，以备查询、统计使用
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
                    inRunUserID AS event_value,
                    inRunTime AS run_begin_time,
                    inRunTime AS run_end_time
              FROM dual;

          END;
       END IF;


       COMMIT;

END;
