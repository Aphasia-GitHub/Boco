CREATE OR REPLACE PROCEDURE sp_wf_saveasdraft
(
       inFlowID in varchar2,
       inWorkID in varchar2,
       inRunUserID in varchar2,
       inRunBeginTime in date
)
IS
       flowTraceID varchar2(50);
       flowTraceUserID varchar2(50);
       flowDraftStatus number := 1;
BEGIN
       SELECT id
       INTO flowTraceID
       FROM wf_flow_trace
       WHERE flow_id = inFlowID
       AND run_end_time IS NULL;

       SELECT id
       INTO flowTraceUserID
       FROM wf_flow_traceuser
       WHERE flow_trace_id = flowTraceID
       AND work_id = inWorkID
       AND run_user_id = inRunUserID;

       --修改流程状态为流程草稿
       UPDATE wf_flow
       SET run_status = flowDraftStatus
       WHERE id = inFlowID;

       --修改流程跟踪的运行节点状态为流程草稿
       UPDATE wf_flow_trace
       SET run_status = flowDraftStatus
       WHERE id = flowTraceID;

       --更新流程处理人的开始处理时间
       UPDATE wf_flow_traceuser
       SET run_begin_time = inRunBeginTime
       WHERE id = flowTraceUserID
       AND run_begin_time IS NULL;

       COMMIT;

END;
