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
              --�ƽ�ǰ�����ƽ��û������Ѱ����б�
              --����߼������˻�ʱӰ���˻��˵Ļ��
              --�����ƽ��ˣ��������Ϊ���Լ��޹���
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

              --�ƽ�������ǰ�����û��޸�Ϊ�ƽ��ˣ�ͨ��inEventValue���룩
              UPDATE wf_flow_traceuser
              SET run_user_id = inEventValue
              WHERE id = flowTraceUserID;

              --��ԭ�û���¼�������¼���event_value�У��Ա���ѯ��ͳ��ʹ��
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
