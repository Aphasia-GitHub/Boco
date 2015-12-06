create or replace function GetCarrierPower(Carrier number,
                                           CellId string,
                                           VendorId number)
  RETURN number is
  carrierPower number;
  v_cellId number(38);
  CarrierId number(6);
  CarType varchar2(32);
begin
  v_cellId:=to_number(CellId);
  CarType:='';

  case Carrier
    when 283 then CarrierId:=0;
    when 201 then CarrierId:=1;
    when 37 then CarrierId:=2;
    when 78 then CarrierId:=3;
    when 242 then CarrierId:=4;
    when 119 then CarrierId:=5;
    when 1019 then CarrierId:=6;
    else CarrierId:=8;
  end case;
  if VendorId = 10 then
   select case
         when carrinfo1_carchan_1 = Carrier then
          carrinfo1_max_power_1*1000
         when carrinfo1_carchan_2 = Carrier then
          carrinfo1_max_power_2*1000
         when carrinfo1_carchan_3 = Carrier then
          carrinfo1_max_power_3*1000
         when carrinfo1_carchan_4 = Carrier then
         carrinfo1_max_power_4*1000
         when carrinfo1_carchan_5 = Carrier then
          carrinfo1_max_power_5*1000
         when carrinfo1_carchan_6 = Carrier then
          carrinfo1_max_power_6*1000
         when carrinfo1_carchan_7 = Carrier then
          carrinfo1_max_power_7*1000
         when carrinfo1_carchan_8 = Carrier then
          carrinfo1_max_power_8*1000
         else
          0
       end as carrierPower1 into carrierPower
  from cdmauser.c_cell a,
       cdmauser.c_tlc_par_bts_1 b
     where  a.related_bts=b.int_id
        and a.int_id=v_cellId;
  end if;
  if VendorId = 7 then
    select carr.car_type into CarType from cdmauser.c_carrier carr where carr.related_cell=v_cellId and carr.cdma_freq=Carrier;
    if CarType is null then
       carrierPower:=0;
    end if;
    if CarType='1X' then
       select a.CELL_PWR into carrierPower from cdmauser.c_tzx_par_carr a where a.related_cell = v_cellId and a.cdma_freq = Carrier;
    end if;
    if CarType='DO'then
       select a.ForwardTransmitPower into carrierPower from cdmauser.c_tzx_par_carr_do a where a.related_cell=v_cellId and a.carrierid=CarrierId;
   end if;
  end if;
 return carrierPower;

   exception
  when others then
   return 0;
end GetCarrierPower;
