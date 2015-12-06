CREATE OR REPLACE PROCEDURE sp_wf_initnextnode
(
       inFlowID in varchar2,
       inNextRunNodeID in varchar2,
       inNextRunUserIDCount in integer,
       inRunEndTime in date,
       inIsBacktrack in varchar2
)
IS
       nextFlowTraceID varchar2(50);
       nextRunNodeID varchar2(50);
       nextNodeType number;
       cooperationNode number := 3;
       nextRunUserIDCount number;
       yes varchar2(1) := 'Y';
BEGIN
       nextRunNodeID := inNextRunNodeID;
       nextRunUserIDCount := inNextRunUserIDCount;

       --初始化下一节点
       SELECT SYS_GUID()
       INTO nextFlowTraceID
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
              nextFlowTraceID AS id,
              inFlowID AS flow_id,
              f.run_status,
              nextRunNodeID AS run_node_id,
              NULL AS next_node_id,
              NULL AS is_need_confirmaccept,
              inRunEndTime AS run_begin_time,
              NULL AS run_end_time
       FROM wf_flow f
       WHERE f.id = inFlowID;


       COMMIT;--add by maojun;调试用

       --初始化下一节点的用户线程
       IF inIsBacktrack <> yes THEN
          BEGIN
             --正常路径，发送人 + 抄送人
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
                    nextFlowTraceID AS flow_trace_id,
                    SYS_GUID() AS work_id,
                    user_id AS run_user_id,
                    is_cc,
                    NULL AS run_begin_time,
                    NULL AS run_end_time
             FROM wf_flow_nodeusers
             WHERE flow_id = inFlowID
             AND node_id = nextRunNodeID;

             SELECT node_type
             INTO nextNodeType
             FROM wf_node
             WHERE id = nextRunNodeID;

             IF nextNodeType <> cooperationNode THEN
                BEGIN
                   IF nextRunUserIDCount > 1 THEN
                      BEGIN
                         UPDATE wf_flow_trace
                         SET is_need_confirmaccept = 'Y'
                         WHERE id = nextFlowTraceID;
                      END;
                   ELSE
                      --nextRunUserIDCount = 1，nextRunUserIDCount = 0的时候算法已退出
                      BEGIN
                         UPDATE wf_flow_trace
                         SET is_need_confirmaccept = 'N'
                         WHERE id = nextFlowTraceID;
                      END;
                   END IF;
                END;
             ELSE
                BEGIN
                   UPDATE wf_flow_trace
                   SET is_need_confirmaccept = 'N'
                   WHERE id = nextFlowTraceID;
                END;
             END IF;

          END;
       ELSE
          BEGIN
             --退回后原路返回发送人，且退回不再给抄送人
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
             SELECT SYS_GUID() AS id,
                    nextFlowTraceID AS flow_trace_id,
                    SYS_GUID() AS work_id,
                    ftu.run_user_id,
                    ftu.is_cc,
                    NULL AS run_begin_time,
                    NULL AS run_end_time
             FROM wf_flow_traceuser ftu
             WHERE ftu.flow_trace_id =
             (
                   SELECT id
                   FROM
                   (
                          SELECT ft.id
                          FROM wf_flow_trace ft
                          WHERE ft.flow_id = inFlowID
                          AND ft.run_node_id = nextRunNodeID
                          AND ft.run_end_time IS NOT NULL
                          AND rownum = 1
                          ORDER BY ft.run_begin_time DESC
                   ) t
             )
             AND ftu.is_cc IS NULL;

             UPDATE wf_flow_trace
             SET is_need_confirmaccept = 'N'
             WHERE id = nextFlowTraceID;

          END;
       END IF;


       COMMIT;

END;
