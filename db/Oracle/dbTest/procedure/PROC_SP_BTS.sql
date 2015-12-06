CREATE OR REPLACE PROCEDURE PROC_SP_BTS AS
BEGIN
  DECLARE
    CURSOR C_JOB IS
      SELECT BTS.INT_ID,
             CITY.PROVINCE_NAME,
             CITY.REGION_NAME,
             CITY.CITY_NAME,
             BTS.VILLAGE_NAME,
             BTS.GRID_NUM,
             BTS.OPERATE_DEPARTMENT,
             BTS.BTS_CODE BTSID,
             BTS.NAME AS BTS_NAME,
             BTS.NAME_P AS BTS_NAME_P,
             BTS.PRO_BTSID,
             GETBTSANTTYPE(BTS.INT_ID) ANTTYPE,
             BTS.BTS_GRADE,
             BTS.LONGITUDE,
             BTS.LATITUDE,
             CASE
               WHEN CDMA.VENDOR_ID = 7 THEN
                '中兴'
               ELSE
                '阿朗'
             END VENDOR_NAME,
             CDMA.VENDOR_BTSTYPE,
             BTS.BTS_TYPE,
             BTS.BTS_STATE,
             BTS.BTS_ADDR,
             CASE CDMA.BTSCLASS
               WHEN 4 THEN
                'DO'
               WHEN 5 THEN
                '1X+DO'
               WHEN 2 THEN
                '1X'
               ELSE
                ''
             END SYS_TYPE,
             (SELECT CELL.NID
                FROM CDMAUSER.C_CELL CELL
               WHERE CELL.RELATED_BTS = CDMA.INT_ID
                 AND ROWNUM = 1) NID,
             (SELECT CELL.SID
                FROM CDMAUSER.C_CELL CELL
               WHERE CELL.RELATED_BTS = CDMA.INT_ID
                 AND ROWNUM = 1) SID,
             GETMSCIDBYREGION(CITY.REGION_NAME) MSCID,
             CASE
               WHEN CDMA.VENDOR_ID = 7 THEN
                CDMA.BSC_NAME
               ELSE
                GETMSCIDBYREGION(CITY.REGION_NAME) || '.' || CDMA.DCSID
             END BSCID,
             BTS.RNC_ATTRIB,
             CASE
               WHEN CDMA.VENDOR_ID = 7 THEN
                '无'
               ELSE
                TO_CHAR(CTLC.CARRIER_LIST1_SMODULE_ID1)
             END SM_ATTRIB,
             CASE
               WHEN CDMA.VENDOR_ID = 10 THEN
                (SELECT SOFT_VERSION
                   FROM CDMAUSER.C_BSC BSC
                  WHERE BSC.INT_ID = CDMA.RELATED_BSC)
               ELSE
                BTS.BSC_SOFTVERSION
             END SOFT_VERSION,
             (SELECT COUNT(*)
                FROM C_TCO_PRO_CELL CELL
               WHERE CELL.RELATED_BTSID = BTS.INT_ID) SECTOR_NUM,
             CASE
               WHEN CDMA.VENDOR_ID = 7 THEN
                CDMA.CELL_CARRIER_NUM_1X
               ELSE
                BTS.BTS_MODEL_1X
             END CELL_CARRIER_NUM_1X,
             CASE
               WHEN CDMA.VENDOR_ID = 7 THEN
                CDMA.CELL_CARRIER_NUM_DO
               ELSE
                BTS.BTS_MODEL_DO
             END CELL_CARRIER_NUM_DO,
             CASE
               WHEN CDMA.VENDOR_ID = 7 THEN
                CDMA.NUMCE
               ELSE
                BTS.CHANNEL_NUM_1X
             END NUMCE,
             CASE
               WHEN CDMA.VENDOR_ID = 7 THEN
                CDMA.NUMCEDO
               ELSE
                BTS.CHANNEL_NUM_DO
             END NUMCEDO,
             BTS.NBR_2M_1X,
             BTS.NBR_2M_DO,
             CDMA.NBR_2M,
             (SELECT CELL.LAC
                FROM CDMAUSER.C_CELL CELL
               WHERE CELL.RELATED_BTS = CDMA.INT_ID
                 AND ROWNUM = 1) LAC,
             (SELECT CELL.LAC
                FROM CDMAUSER.C_CELL CELL
               WHERE CELL.RELATED_BTS = CDMA.INT_ID
                 AND ROWNUM = 1) REG_ZONE,
             CASE
               WHEN CDMA.VENDOR_ID = 7 THEN
                (SELECT MAX(JCELL.TOTAL_ZONES)
                   FROM (SELECT CELL.RELATED_BTS, CCELL.TOTAL_ZONES
                           FROM CDMAUSER.C_CELL CELL
                           LEFT JOIN CDMAUSER.C_TZX_PAR_CELL CCELL
                             ON CELL.INT_ID = CCELL.INT_ID) JCELL
                  WHERE JCELL.RELATED_BTS = CDMA.INT_ID)
               ELSE
                (SELECT MAX(CTLC.TOTZONES)
                   FROM CDMAUSER.C_TLC_PAR_BTS CTLC
                  WHERE CTLC.INT_ID = BTS.INT_ID)
             END TOTZONES,
             CASE
               WHEN CDMA.VENDOR_ID = 7 THEN
                (SELECT MAX(JCELL.ZONE_TIMER)
                   FROM (SELECT CELL.RELATED_BTS, CCELL.ZONE_TIMER
                           FROM CDMAUSER.C_CELL CELL
                           LEFT JOIN CDMAUSER.C_TZX_PAR_CELL CCELL
                             ON CELL.INT_ID = CCELL.INT_ID) JCELL
                  WHERE JCELL.RELATED_BTS = CDMA.INT_ID)
               ELSE
                (SELECT MAX(CTLC.ZONE_TMR)
                   FROM CDMAUSER.C_TLC_PAR_BTS CTLC
                  WHERE CTLC.INT_ID = CDMA.INT_ID)
             END ZONE_TMR,
             GETBTSBORDERSECTOR(CDMA.INT_ID) BORDER_SECTOR,
             BTS.CIRCUITROOM_SHARE,
             BTS.ROOM_PROPERTY,
             BTS.TOWER_MAST_SHARE,
             BTS.PYLON_PROPERTY,
             BTS.PYLON_TYPE,
             BTS.DATA_RENEWAL_DATE OPERATIONTIME,
             B.DISPLAY_NAME AS OPERATIONUSERNAME,
             BTS.REMARK,
             CITY.REGION_ID,
             CITY.CITY_ID
        FROM C_TCO_PRO_BTS BTS
        LEFT JOIN C_TCO_USER_V2 B
          ON BTS.OPERATIONUSERID = B.USER_ID
        LEFT JOIN CDMAUSER.C_BTS CDMA
          ON CDMA.INT_ID = BTS.INT_ID
        LEFT JOIN CDMAUSER.C_TLC_PAR_BTS CTLC
          ON CDMA.INT_ID = CTLC.INT_ID
        LEFT JOIN C_REGION_CITY CITY
          ON CITY.CITY_ID = BTS.CITY_ID;

    --定义一个游标变量v_cinfo c_emp%ROWTYPE ，该类型为游标c_emp中的一行数据类型
    C_ROW C_JOB%ROWTYPE;
  BEGIN
    FOR C_ROW IN C_JOB LOOP
      BEGIN
        INSERT INTO HD_C_PRO_BTS
          (INT_ID,
           PROVINCE_NAME,
           REGION_NAME,
           CITY_NAME,
           VILLAGE_NAME,
           GRID_NUM,
           OPERATE_DEPARTMENT,
           BTSID,
           BTS_NAME,
           BTS_NAME_P,
           PRO_BTSID,
           ANTTYPE,
           BTS_GRADE,
           LONGITUDE,
           LATITUDE,
           VENDOR_NAME,
           VENDOR_BTSTYPE,
           BTS_TYPE,
           BTS_STATE,
           BTS_ADDR,
           SYS_TYPE,
           NID,
           SID,
           MSCID,
           BSCID,
           RNC_ATTRIB,
           SM_ATTRIB,
           SOFT_VERSION,
           SECTOR_NUM,
           CELL_CARRIER_NUM_1X,
           CELL_CARRIER_NUM_DO,
           NUMCE,
           NUMCEDO,
           NBR_2M_1X,
           NBR_2M_DO,
           NBR_2M,
           LAC,
           REG_ZONE,
           TOTZONES,
           ZONE_TMR,
           BORDER_SECTOR,
           CIRCUITROOM_SHARE,
           ROOM_PROPERTY,
           TOWER_MAST_SHARE,
           PYLON_PROPERTY,
           PYLON_TYPE,
           OPERATIONTIME,
           OPERATIONUSERNAME,
           REMARK,
           REGION_ID,
           CITY_ID,
           HD_TIME)
        VALUES
          (C_ROW.INT_ID,
           C_ROW.PROVINCE_NAME,
           C_ROW.REGION_NAME,
           C_ROW.CITY_NAME,
           C_ROW.VILLAGE_NAME,
           C_ROW.GRID_NUM,
           C_ROW.OPERATE_DEPARTMENT,
           C_ROW.BTSID,
           C_ROW.BTS_NAME,
           C_ROW.BTS_NAME_P,
           C_ROW.PRO_BTSID,
           C_ROW.ANTTYPE,
           C_ROW.BTS_GRADE,
           C_ROW.LONGITUDE,
           C_ROW.LATITUDE,
           C_ROW.VENDOR_NAME,
           C_ROW.VENDOR_BTSTYPE,
           C_ROW.BTS_TYPE,
           C_ROW.BTS_STATE,
           C_ROW.BTS_ADDR,
           C_ROW.SYS_TYPE,
           C_ROW.NID,
           C_ROW.SID,
           C_ROW.MSCID,
           C_ROW.BSCID,
           C_ROW.RNC_ATTRIB,
           C_ROW.SM_ATTRIB,
           C_ROW.SOFT_VERSION,
           C_ROW.SECTOR_NUM,
           C_ROW.CELL_CARRIER_NUM_1X,
           C_ROW.CELL_CARRIER_NUM_DO,
           C_ROW.NUMCE,
           C_ROW.NUMCEDO,
           C_ROW.NBR_2M_1X,
           C_ROW.NBR_2M_DO,
           C_ROW.NBR_2M,
           C_ROW.LAC,
           C_ROW.REG_ZONE,
           C_ROW.TOTZONES,
           C_ROW.ZONE_TMR,
           C_ROW.BORDER_SECTOR,
           C_ROW.CIRCUITROOM_SHARE,
           C_ROW.ROOM_PROPERTY,
           C_ROW.TOWER_MAST_SHARE,
           C_ROW.PYLON_PROPERTY,
           C_ROW.PYLON_TYPE,
           C_ROW.OPERATIONTIME,
           C_ROW.OPERATIONUSERNAME,
           C_ROW.REMARK,
           C_ROW.REGION_ID,
           C_ROW.CITY_ID,
           SYSDATE);
        COMMIT;
      END;
    END LOOP;
  END;
END PROC_SP_BTS;
