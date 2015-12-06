CREATE OR REPLACE PROCEDURE sp_wf_sendflow
(
       inFlowID in varchar2,
       inWorkID in varchar2,
       inRunUserID in varchar2,
       inRunEndTime in date,
       inNextRunUsers in varchar2,
       inNextCCUsers in varchar2,
       inIsBacktrack in varchar2
)
IS
       flowTraceID varchar2(50);
       flowTraceUserID varchar2(50);
       flowRunningStatus number := 0;
       flowDraftStatus number := 1;
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

       endNode varchar2(50) := '-1';

       sourceOfFlowInput varchar2(50) := 'flow input';
       splitChar varchar2(1) := ',';

BEGIN
       SELECT id, run_node_id
       INTO flowTraceID, currentRunNodeID
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

       --·����һ����ڵ㣬�õ�nextRunNodeID
       SELECT COUNT(next_node_id)
       INTO nextRunNodeIDCount
       FROM wf_flow_node
       WHERE flow_id = inFlowID
       AND node_id = currentRunNodeID
       --AND is_return <> yes;
       AND is_return IS NULL;

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
             --AND is_return <> yes;
             AND is_return IS NULL;
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
             --AND is_return <> yes;
             AND is_return IS NULL;

             IF ruleCondtionEqualResultCount = 0 THEN
                BEGIN
                   --��·����Ψһ�ҹ��������͹������������ʱ������ʹ��is_default = 'Y'��·��
                   SELECT next_node_id
                   INTO nextRunNodeID
                   FROM wf_flow_node
                   WHERE flow_id = inFlowID
                   AND node_id = currentRunNodeID
                   AND is_default = yes
                   --AND is_return <> yes;
                   AND is_return IS NULL;
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
                   --AND is_return <> yes;
                   AND is_return IS NULL;
                END;
             END IF;
          END;
       END IF;

       --����������һ���Ĳ�����
       IF inNextRunUsers IS NOT NULL THEN
          BEGIN
             DELETE FROM wf_flow_nodeusers
             WHERE flow_id = inFlowID
             AND node_id = nextRunNodeID
             AND is_cc IS NULL;

             INSERT INTO wf_flow_nodeusers
             (
                    id,
                    flow_id,
                    node_id,
                    user_id,
                    source,
                    is_cc
             )
             SELECT SYS_GUID() AS id,
                    inFlowID AS flow_id,
                    nextRunNodeID AS node_id,
                    column_value AS user_id,
                    sourceOfFlowInput AS source,
                    NULL AS is_cc
             FROM
             (
                    SELECT column_value
                    FROM TABLE(f_wf_split(inNextRunUsers, splitChar))
             ) t;

           COMMIT; --add by maojun�������� 2014-12-13 20��55

          END;
       END IF;
       --����������һ���ĳ�����
       IF inNextCCUsers IS NOT NULL THEN
          BEGIN
             DELETE FROM wf_flow_nodeusers
             WHERE flow_id = inFlowID
             AND node_id = nextRunNodeID
             AND is_cc = yes;

             INSERT INTO wf_flow_nodeusers
             (
                    id,
                    flow_id,
                    node_id,
                    user_id,
                    source,
                    is_cc
             )
             SELECT SYS_GUID() AS id,
                    inFlowID AS flow_id,
                    nextRunNodeID AS node_id,
                    column_value AS user_id,
                    sourceOfFlowInput AS source,
                    yes AS is_cc
             FROM
             (
                    SELECT column_value
                    FROM TABLE(f_wf_split(inNextCCUsers, splitChar))
             ) t;

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
             IF nextRunNodeID <> endNode THEN
                BEGIN
                   RETURN;
                END;
             END IF;
          END;
       END IF;

       --��ɽڵ���û��߳�
       UPDATE wf_flow_traceuser
       SET run_end_time = inRunEndTime
       WHERE id = flowTraceUserID;

       --������ɱ��ʣ�ȷ���ڵ㣨Э���ͽڵ㣩�Ƿ���Է���
       SELECT node_type, finish_rate
       INTO currentNodeType, currentFinishRate
       FROM wf_node
       WHERE id = currentRunNodeID;

       IF currentNodeType <> cooperationNode THEN
          BEGIN
             canFinish := yes;
          END;
       ELSE
          BEGIN
             SELECT COUNT(work_id)
             INTO workedCount
             FROM wf_flow_traceuser
             WHERE flow_trace_id = flowTraceID
             AND run_end_time IS NOT NULL
             AND is_cc IS NULL;

             SELECT COUNT(user_id)
             INTO allNeedWorkCount
             FROM wf_flow_nodeusers
             WHERE flow_id = inFlowID
             AND node_id = currentRunNodeID
             AND is_cc IS NULL;

             IF workedCount / allNeedWorkCount >= currentFinishRate / 100 THEN
                BEGIN
                   canFinish := yes;
                END;
             ELSE
                BEGIN
                   canFinish := NULL;
                END;
             END IF;

          END;
       END IF;


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
             IF nextRunNodeID <> endNode THEN
                BEGIN
                   UPDATE wf_flow_trace
                   SET next_node_id = nextRunNodeID,
                       run_end_time = inRunEndTime
                   WHERE id = flowTraceID;


                END;
             ELSE
                BEGIN
                   --���һ���ڵ�û����һ�ڵ�
                   UPDATE wf_flow_trace
                   SET run_end_time = inRunEndTime
                   WHERE id = flowTraceID;
                END;
             END IF;

             --����
             IF nextRunNodeID <> endNode THEN
                BEGIN

                   sp_wf_initnextnode(inFlowID, nextRunNodeID, nextRunUserIDCount, inRunEndTime, inIsBacktrack);

                END;
             ELSE
                BEGIN
                   sp_wf_endflow(inFlowID, inRunEndTime);

                END;
             END IF;


          END;
       END IF;



       COMMIT;

END;
