create or replace function GetPseudoFrequency(CellId   string,
                                              VendorId number)
  RETURN number is
  frequency number;
  v_cellId  number(38);
begin
  v_cellId     := to_number(CellId);

  if VendorId = 10 then
    select case
             when carrier11_pilot_type1 = 1 then
              Pilotchan1
             when carrier11_pilot_type2 = 1 then
              Pilotchan2
             when carrier11_pilot_type3 = 1 then
              Pilotchan3
             when carrier11_pilot_type4 = 1 then
              Pilotchan4
             when carrier11_pilot_type5 = 1 then
              Pilotchan5
             when carrier11_pilot_type6 = 1 then
              Pilotchan6
             when carrier11_pilot_type7 = 1 then
              Pilotchan7
             else
              0
           end as frequency1 into    frequency
      from cdmauser.c_tlc_par_cell a
     where  a.int_id = v_cellId;
  end if;
  if VendorId = 7 then
    select   cdma_freq   into frequency
      from cdmauser.c_tzx_par_carr a
     where a.related_cell = v_cellId
       and a.ISBEACON=1;
  end if;
  return frequency;

  exception
  when others then
   return 0;
end GetPseudoFrequency;
