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

       --1��ɾ��wf_flow_traceuser�е������û���ʵ����һ�˰��������˲����룩��
       DELETE FROM wf_flow_traceuser
       WHERE flow_trace_id = flowTraceID
       AND id <> flowTraceUserID
       AND is_cc IS NULL;

       --�޸�wf_flow_traceuser�е������û�״̬��ʵ����һ�˰��������˿��Բ鿴��
       --����߼������˻�ʱӰ���˻��˵Ļ��
       --����߼�����ͨ��Э���ڵ�ʵ��
       /*UPDATE wf_flow_traceuser
       SET run_begin_time = inRunBeginTime,
           run_end_time = inRunBeginTime
       WHERE flow_trace_id = flowTraceID
       AND id <> flowTraceUserID
       AND is_cc IS NULL;*/

       --2������wf_flow_traceuser�еĿ�ʼ����ʱ�䣻
       UPDATE wf_flow_traceuser
       SET run_begin_time = inRunBeginTime
       WHERE id = flowTraceUserID
       AND is_cc IS NULL;

       --3������wf_flow_trace�е�is_need_confirmacceptΪ'N'��
       UPDATE wf_flow_trace
       SET is_need_confirmaccept = 'N'
       WHERE id = flowTraceID;


       COMMIT;

END;
