CREATE OR REPLACE PROCEDURE sp_wf_confirmaccept
(
       inFlowID in varchar2,
       inWorkID in varchar2,
       inRunUserID in varchar2,
       inRunBeginTime in date
)
IS
       flowTraceID varchar2(50);
       flowTraceUserID varchar2(50);
       flowRunningStatus number := 0;
BEGIN
       SELECT id
       INTO flowTraceID
       FROM wf_flow_trace
       WHERE flow_id = inFlowID
       AND run_status = flowRunningStatus
       AND run_end_time IS NULL;

       SELECT id
       INTO flowTraceUserID
       FROM wf_flow_traceuser
       WHERE flow_trace_id = flowTraceID
       AND work_id = inWorkID
       AND run_user_id = inRunUserID;

       --1、删除wf_flow_traceuser中的其他用户（实现了一人办理，其他人不参与）；
       DELETE FROM wf_flow_traceuser
       WHERE flow_trace_id = flowTraceID
       AND id <> flowTraceUserID
       AND is_cc IS NULL;

       --修改wf_flow_traceuser中的其他用户状态（实现了一人办理，其他人可以查看）
       --这个逻辑会在退回时影响退回人的获得
       --这个逻辑可以通过协作节点实现
       /*UPDATE wf_flow_traceuser
       SET run_begin_time = inRunBeginTime,
           run_end_time = inRunBeginTime
       WHERE flow_trace_id = flowTraceID
       AND id <> flowTraceUserID
       AND is_cc IS NULL;*/

       --2、更新wf_flow_traceuser中的开始运行时间；
       UPDATE wf_flow_traceuser
       SET run_begin_time = inRunBeginTime
       WHERE id = flowTraceUserID
       AND is_cc IS NULL;

       --3、更新wf_flow_trace中的is_need_confirmaccept为'N'；
       UPDATE wf_flow_trace
       SET is_need_confirmaccept = 'N'
       WHERE id = flowTraceID;


       COMMIT;

END;
