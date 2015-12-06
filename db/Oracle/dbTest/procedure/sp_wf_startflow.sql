CREATE OR REPLACE PROCEDURE sp_wf_startflow
(
       inFlowDefineID in varchar2,
       inName in varchar2,
       inIsManual in varchar2,
       inParentFlowID in varchar2,
       inRunUserID in varchar2,
       inRunBeginTime in date
)
IS
       flowCanUseStatus number := 1;
       flowRunningStatus number := 0;
       flowID varchar2(50);
       flowTraceID varchar2(50);
       ownerTypeOfUser number := 1;
       ownerTypeOfRole number := 2;
       ownerTypeOfDepartment number := 3;
       startNode varchar2(50) := '0';
       endNode varchar2(50) := '-1';
       sourceOfFlowConfig varchar2(50) := 'flow config';
       workID varchar2(50);
       defaultRuleCondition varchar2(200) := '1';

       sourceOfFlowInput varchar2(50) := 'flow input';
       firstNode varchar2(50);
       flowNodeUserID varchar2(50);
BEGIN
       SELECT SYS_GUID()
       INTO flowID
       FROM dual;

       --1、将流程的定义信息写入流程实例中；
       INSERT INTO wf_flow
       (
              id,
              flowdefine_id,
              flowcategory_id,
              name,
              graph_xml,
              run_status,
              operate_time,
              is_manual,
              parent_flow_id,
              run_user_id,
              run_begin_time,
              run_end_time
       )
       SELECT
              flowID AS id,
              id AS flowdefine_id,
              flowcategory_id,
              inName,
              graph_xml,
              flowRunningStatus,
              operate_time,
              inIsManual,
              inParentFlowID,
              inRunUserID,
              inRunBeginTime,
              null AS run_end_time
       FROM wf_flowdefine
       WHERE id = inFlowDefineID
       AND status = flowCanUseStatus;

       INSERT INTO wf_flow_node
       (
              id,
              flow_id,
              node_id,
              next_node_id,
              rule_condition,
              rule_result,
              is_default,
              is_return
       )
       SELECT
              SYS_GUID() AS id,
              flowID AS flow_id,
              fdn.node_id,
              fdn.next_node_id,
              fdn.rule_condition,
              NULL AS rule_result,
              fdn.is_default,
              fdn.is_return
       FROM wf_flowdefine_node fdn
       INNER JOIN wf_flowdefine fd ON fdn.flowdefine_id = fd.id
       WHERE fd.id = inFlowDefineID
       AND fd.status = flowCanUseStatus;

       UPDATE wf_flow_node
       SET rule_result = rule_condition
       WHERE flow_id = flowID
       AND rule_condition = defaultRuleCondition;


       INSERT INTO wf_flow_subflow
       (
              id,
              flow_id,
              node_id,
              subflow_id
       )
       SELECT
              SYS_GUID() AS id,
              flowID AS flow_id,
              fdsf.node_id,
              fdsf.subflow_id
       FROM wf_flowdefine_subflow fdsf
       INNER JOIN wf_flowdefine fd ON fdsf.flowdefine_id = fd.id
       WHERE fd.id = inFlowDefineID
       AND fd.status = flowCanUseStatus;


       --2、为流程实例寻找节点的操作用户；
       INSERT INTO wf_flow_nodeusers
       (
              id,
              flow_id,
              node_id,
              user_id,
              source,
              is_cc
       )
       SELECT
              SYS_GUID() AS id,
              flowID AS flow_id,
              node_id,
              user_id,
              sourceOfFlowConfig,
              is_cc
       FROM
       (
              --owner_type = 1，用户
              SELECT
                    no.node_id,
                    no.owner_value AS user_id,
                    no.is_cc
              FROM wf_node_owner no
              WHERE no.owner_type = ownerTypeOfUser
              AND no.node_id IN
              (
                 SELECT node_id
                 FROM wf_flow_node
                 WHERE flow_id = flowID
                 AND node_id <> startNode
                 UNION
                 SELECT next_node_id
                 FROM wf_flow_node
                 WHERE flow_id = flowID
                 AND next_node_id <> endNode
              )
              UNION
              --owner_type = 2，角色
              SELECT
                    no.node_id,
                    ur.user_id,
                    no.is_cc
              FROM wf_node_owner no
              INNER JOIN c_tco_user_roles ur ON no.owner_value = ur.role_id
              WHERE no.owner_type = ownerTypeOfRole
              AND no.node_id IN
              (
                 SELECT node_id
                 FROM wf_flow_node
                 WHERE flow_id = flowID
                 AND node_id <> startNode
                 UNION
                 SELECT next_node_id
                 FROM wf_flow_node
                 WHERE flow_id = flowID
                 AND next_node_id <> endNode
              )
              --UNION
              --owner_type = 3，部门（TODO：后续网优平台增加department表后再完善）
       ) t;

       --更新发起用户，因为有的流程可能不会配置第一个节点的操作用户或者发起用户可能与第一个节点的配置用户不同
       SELECT fd.next_node_id
       INTO firstNode
       FROM wf_flow f
       INNER JOIN wf_flow_node fd ON f.id = fd.flow_id
       WHERE f.id = flowID
       AND fd.node_id = startNode;

       DELETE FROM wf_flow_nodeusers
       WHERE flow_id = flowID
       AND node_id = firstNode
       AND is_cc IS NULL;

       /*INSERT INTO wf_flow_nodeusers
       (
              id,
              flow_id,
              node_id,
              user_id,
              source,
              is_cc
       )
       SELECT
              SYS_GUID() AS id,
              flowID AS flow_id,
              fd.next_node_id AS node_id,
              inRunUserID AS user_id,
              sourceOfFlowInput AS source,
              NULL AS is_cc
       FROM wf_flow f
       INNER JOIN wf_flow_node fd ON f.id = fd.flow_id
       WHERE f.id = flowID
       AND fd.node_id = startNode;*/

       SELECT SYS_GUID()
       INTO flowNodeUserID
       FROM dual;

       INSERT INTO wf_flow_nodeusers
       (
              id,
              flow_id,
              node_id,
              user_id,
              source,
              is_cc
       )
       VALUES
       (
              flowNodeUserID,
              flowID,
              firstNode,
              inRunUserID,
              sourceOfFlowInput,
              NULL
       );

       --3、向trace表中插入第一个节点的预处理信息；
       SELECT SYS_GUID()
       INTO flowTraceID
       FROM dual;

       INSERT INTO wf_flow_trace
       (
              id,
              flow_id,
              run_status,
              run_node_id,
              next_node_id,
              is_need_confirmaccept,
              run_begin_time,
              run_end_time
       )
       SELECT
              flowTraceID AS id,
              flowID AS flow_id,
              f.run_status,
              fd.next_node_id AS run_node_id,
              NULL AS next_node_id,
              NULL AS is_need_confirmaccept,
              f.run_begin_time,
              NULL AS run_end_time
       FROM wf_flow f
       INNER JOIN wf_flow_node fd ON f.id = fd.flow_id
       WHERE f.id = flowID
       AND fd.node_id = startNode;

       SELECT SYS_GUID()
       INTO workID
       FROM dual;

       --4、向traceuser表中插入第一个节点的处理用户；
       INSERT INTO wf_flow_traceuser
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
              flowTraceID AS flow_trace_id,
              workID AS work_id,
              inRunUserID,
              NULL AS is_cc,
              NULL AS run_begin_time,
              NULL AS run_end_time
       FROM dual;

       UPDATE wf_flow_trace
       SET is_need_confirmaccept = 'N'
       WHERE id = flowTraceID;

       COMMIT;

END;
