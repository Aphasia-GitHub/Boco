CREATE OR REPLACE PROCEDURE sp_wf_returnflow
(
       inFlowID in varchar2,
       inWorkID in varchar2,
       inRunUserID in varchar2,
       inRunEndTime in date,
       inIsBacktrack in varchar2
)
IS
       flowTraceID varchar2(50);
       flowTraceUserID varchar2(50);
       flowRunningStatus number := 0;
       currentRunNodeID varchar2(50);
       currentNodeType number;
       currentFinishRate number;
       cooperationNode number := 3;
       defaultRuleCondition varchar2(200) := '1';
       yes varchar2(1) := 'Y';
       nextRunNodeID varchar2(50);
       nextRunNodeIDCount number;
       nextRunUserIDCount number;

       ruleCondtionEqualResultCount number;

       nextFlowTraceID varchar2(50);
       nextNodeType number;

       workedCount number;
       allNeedWorkCount number;
       canFinish varchar2(1);

BEGIN
       SELECT id, run_node_id
       INTO flowTraceID, currentRunNodeID
       FROM wf_flow_trace
       WHERE flow_id = inFlowID
       AND run_status = flowRunningStatus
       AND run_end_time IS NULL;

       SELECT id
       INTO flowTraceUserID
       FROM wf_flow_traceuser
       WHERE flow_trace_id = flowTraceID
       AND work_id = inWorkID
       AND run_user_id = inRunUserID
       AND is_cc IS NULL;

       --·����һ����ڵ㣬�õ�nextRunNodeID
       SELECT COUNT(next_node_id)
       INTO nextRunNodeIDCount
       FROM wf_flow_node
       WHERE flow_id = inFlowID
       AND node_id = currentRunNodeID
       AND is_return = yes;

       IF nextRunNodeIDCount = 1 THEN
          BEGIN
             --��·��Ψһʱ������ʹ��ϵͳ�����ýڵ�
             SELECT next_node_id
             INTO nextRunNodeID
             FROM wf_flow_node
             WHERE flow_id = inFlowID
             AND node_id = currentRunNodeID
             AND rule_condition = defaultRuleCondition
             AND rule_result = defaultRuleCondition
             AND is_return = yes;
          END;
       ELSE
          BEGIN
             --��·����Ψһʱ��Ѱ�ҳ�����������͹�������ͬ������·��
             SELECT COUNT(next_node_id)
             INTO ruleCondtionEqualResultCount
             FROM wf_flow_node
             WHERE flow_id = inFlowID
             AND node_id = currentRunNodeID
             AND rule_condition = rule_result
             AND rule_condition <> defaultRuleCondition
             AND is_return = yes;

             IF ruleCondtionEqualResultCount = 0 THEN
                BEGIN
                   --��·����Ψһ�ҹ��������͹������������ʱ������ʹ��is_default = 'Y'��·��
                   SELECT next_node_id
                   INTO nextRunNodeID
                   FROM wf_flow_node
                   WHERE flow_id = inFlowID
                   AND node_id = currentRunNodeID
                   AND is_default = yes
                   AND is_return = yes;
                END;
             ELSE
                BEGIN
                   --��·����Ψһ�ҹ��������͹��������ʱ������ʹ�ù��������͹�������ͬ������·��
                   SELECT next_node_id
                   INTO nextRunNodeID
                   FROM wf_flow_node
                   WHERE flow_id = inFlowID
                   AND node_id = currentRunNodeID
                   AND rule_condition = rule_result
                   AND rule_condition <> defaultRuleCondition
                   AND is_return = yes;
                END;
             END IF;
          END;
       END IF;


       --�ж���һ�ڵ��Ƿ��д����ˣ����û��ֱ�ӷ���
       SELECT COUNT(user_id)
       INTO nextRunUserIDCount
       FROM wf_flow_nodeusers
       WHERE flow_id = inFlowID
       AND node_id = nextRunNodeID
       AND is_cc IS NULL;

       IF nextRunUserIDCount = 0 THEN
          BEGIN
             RETURN;
          END;
       END IF;


       --�˻ز���Ҫ������ɱ��ʣ�����Э���ͽڵ���һ����Ҫ�˻أ��ýڵ�������̣߳��û����Զ��˻�
       --��Ҫע�⣬Э���ͽڵ��˻�ʱ��ÿ���̣߳��û�����ҵ�������Ƿ��������
       --���鲻Ҫ��Э���ͽڵ���ִ���˻�
       canFinish := yes;


       --��ɽڵ���û��߳�
       UPDATE wf_flow_traceuser
       SET run_end_time = inRunEndTime
       WHERE id = flowTraceUserID;


       SELECT node_type, finish_rate
       INTO currentNodeType, currentFinishRate
       FROM wf_node
       WHERE id = currentRunNodeID;

       IF canFinish = yes THEN
          BEGIN
             --�����������������ɽڵ���û��߳�
             IF currentNodeType = cooperationNode THEN
                BEGIN
                   --δ������
                   UPDATE wf_flow_traceuser
                   SET run_begin_time = inRunEndTime,
                       run_end_time = inRunEndTime
                   WHERE flow_trace_id = flowTraceID
                   AND run_end_time IS NULL
                   AND run_begin_time IS NULL
                   AND is_cc IS NULL;
                   --����һ���ֵ���
                   UPDATE wf_flow_traceuser
                   SET run_end_time = inRunEndTime
                   WHERE flow_trace_id = flowTraceID
                   AND run_end_time IS NULL
                   AND is_cc IS NULL;
                END;
             END IF;

             --��ɽڵ���Ϣ
             UPDATE wf_flow_trace
             SET next_node_id = nextRunNodeID,
                 run_end_time = inRunEndTime
             WHERE id = flowTraceID;



             --update wf_flow_trace set next_node_id = null, run_end_time = null where id = 'E1B23A2FDA466848E0440021281A78D8';

             sp_wf_initnextnode(inFlowID, nextRunNodeID, nextRunUserIDCount, inRunEndTime, inIsBacktrack);


          END;
       END IF;

       COMMIT;

END;
