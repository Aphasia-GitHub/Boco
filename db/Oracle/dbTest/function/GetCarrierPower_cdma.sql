create or replace function GetCarrierPower_cdma(Carrier number,
                                                CellId  string)
  RETURN number is
  carrierPower number;
  v_cellId     number(38);
begin
  v_cellId := to_number(CellId);

  SELECT SUM(DECODE(CDMA_FREQ, Carrier, CARRIERPOWER1, 0))
    INTO carrierPower

    FROM (SELECT A.INT_ID,
                 C.CDMA_FREQ,
                 CASE
                   WHEN B.CARRINFO1_CARCHAN_1 = C.CDMA_FREQ THEN
                    CARRINFO1_MAX_POWER_1 * 1000
                   WHEN B.CARRINFO1_CARCHAN_2 = C.CDMA_FREQ THEN
                    CARRINFO1_MAX_POWER_2 * 1000
                   WHEN B.CARRINFO1_CARCHAN_3 = C.CDMA_FREQ THEN
                    CARRINFO1_MAX_POWER_3 * 1000
                   WHEN B.CARRINFO1_CARCHAN_4 = C.CDMA_FREQ THEN
                    CARRINFO1_MAX_POWER_4 * 1000
                   WHEN B.CARRINFO1_CARCHAN_5 = C.CDMA_FREQ THEN
                    CARRINFO1_MAX_POWER_5 * 1000
                   WHEN B.CARRINFO1_CARCHAN_6 = C.CDMA_FREQ THEN
                    CARRINFO1_MAX_POWER_6 * 1000
                   WHEN B.CARRINFO1_CARCHAN_7 = C.CDMA_FREQ THEN
                    CARRINFO1_MAX_POWER_7 * 1000
                   WHEN B.CARRINFO1_CARCHAN_8 = C.CDMA_FREQ THEN
                    CARRINFO1_MAX_POWER_8 * 1000
                   ELSE
                    0
                 END AS CARRIERPOWER1
            FROM CDMAUSER.C_CELL          A,
                 CDMAUSER.C_TLC_PAR_BTS_1 B,
                 CDMAUSER.C_CARRIER       C
           WHERE to_char(A.RELATED_BTS) = B.RELATED_BTS
             AND A.INT_ID = C.RELATED_CELL
             AND A.VENDOR_ID = C.VENDOR_ID
             AND A.VENDOR_ID = 10
             AND A.INT_ID = v_cellId
          UNION ALL
          SELECT A.RELATED_CELL, A.CDMA_FREQ, B.CELL_PWR
            FROM CDMAUSER.C_CARRIER A, CDMAUSER.C_TZX_PAR_CARR B
           WHERE A.INT_ID = B.INT_ID
             AND A.CAR_TYPE = '1X'
             AND A.VENDOR_ID = 7
             AND A.RELATED_CELL = v_cellId
             and b.related_cell = v_cellId
          UNION
          SELECT A.RELATED_CELL, A.CDMA_FREQ, B.FORWARDTRANSMITPOWER
            FROM CDMAUSER.C_CARRIER A, CDMAUSER.C_TZX_PAR_CARR_DO B
           WHERE A.INT_ID = B.INT_ID
             AND A.CAR_TYPE = 'DO'
             AND A.VENDOR_ID = 7
             AND A.RELATED_CELL = v_cellId
             and b.related_cell = v_cellId)
   GROUP BY INT_ID;
  return carrierPower;

exception
  when others then
    return 0;
end GetCarrierPower_cdma;
