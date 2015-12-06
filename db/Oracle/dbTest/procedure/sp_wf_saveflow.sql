CREATE OR REPLACE PROCEDURE sp_wf_saveflow
(
       inFlowID in varchar2,
       inWorkID in varchar2,
       inRunUserID in varchar2,
       inRunBeginTime in date,
       inForwardRuleResult in varchar2,
       inBackwardRuleResult in varchar2
)
IS
       flowTraceID varchar2(50);
       flowTraceUserID varchar2(50);
       flowRunningStatus number := 0;
       flowDraftStatus number := 1;
       flowPendingStatus number :=2;--add by maojun ������Ҳ������ָ���Ϣ
       currentRunNodeID varchar2(50);
       defaultRuleCondition varchar2(200) := '1';
       yes varchar2(1) := 'Y';
BEGIN
       SELECT id, run_node_id
       INTO flowTraceID, currentRunNodeID
       FROM wf_flow_trace
       WHERE flow_id = inFlowID
       AND run_status IN(flowRunningStatus, flowDraftStatus,flowPendingStatus)--modify by maojun
       AND run_end_time IS NULL;

       SELECT id
       INTO flowTraceUserID
       FROM wf_flow_traceuser
       WHERE flow_trace_id = flowTraceID
       AND work_id = inWorkID
       AND run_user_id = inRunUserID;

       --�޸�����״̬Ϊ��������
       UPDATE wf_flow
       SET run_status = flowRunningStatus
       WHERE id = inFlowID;

       --�޸����̸��ٵ����нڵ�״̬Ϊ��������
       UPDATE wf_flow_trace
       SET run_status = flowRunningStatus
       WHERE id = flowTraceID;

       --�������̴����˵Ŀ�ʼ����ʱ��
       UPDATE wf_flow_traceuser
       SET run_begin_time = inRunBeginTime
       WHERE id = flowTraceUserID
       AND run_begin_time IS NULL;

       --����ǰ���ڵ�Ĺ�����
       IF inForwardRuleResult IS NOT NULL THEN
          BEGIN
             UPDATE wf_flow_node
             SET rule_result = inForwardRuleResult
             WHERE flow_id = inFlowID
             AND node_id = currentRunNodeID
             AND rule_condition <> defaultRuleCondition
             --AND is_return <> yes;
             AND is_return IS NULL;
          END;
       END IF;

       --���º��˽ڵ�Ĺ�����
       IF inBackwardRuleResult IS NOT NULL THEN
          BEGIN
             UPDATE wf_flow_node
             SET rule_result = inBackwardRuleResult
             WHERE flow_id = inFlowID
             AND node_id = currentRunNodeID
             AND rule_condition <> defaultRuleCondition
             AND is_return = yes;
          END;
       END IF;


       COMMIT;

END;
