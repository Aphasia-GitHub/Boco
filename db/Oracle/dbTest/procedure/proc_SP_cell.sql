create or replace procedure proc_SP_cell as
begin
  declare
       cursor c_job  is
                     select
      a.int_id,
      r.province_name,
      r.region_name,
      r.City_Name,
      pro_bts.village_name,
      a.grid_id grid_num,
      grid.dep_name Operate_Department,
      GetMscidByregion(r.region_name) mscid,
      case
      when c_bts.vendor_id = 7 then
      c_bts.bsc_name
      else
      GetMscidByregion(r.region_name) || '.' || c_bts.dcsid
      end as bscid,
      c_bts.btsid as btsid,
      pro_bts.name as bts_name,
      c_cell.ci,
      a.cell_no cellid,
      a.name as Cell_name,
      a.Longitude,
      a.Latitude,
      a.Cell_address,
      case c_bts.vendor_id
      when 7 then to_char(c_cell.ci)
      else  to_char(c_bts.bssid)||'-'||to_char(c_bts.btsid)||'-'||to_char(a.cell_no)
      end as Cell_index,
      c_cell.pn,
      c_cell.lac,
      case
      when c_bts.vendor_id = 7 THEN
      '中兴'
      else
      '阿朗'
      end vendor_name,
      c_bts.vendor_btstype,
      c_cell.rru_cell，
      case
      when c_bts.numrru>0
      then '是'
      else '否'
      end as MRru_Cell,
      a.status,
      a.Cover_earatype,
      a.Cover_way_type,
      a.Cover_hot_type,
      a.Ant_Vendor,
      a.Ant_Model,
      a.ANTENNA_TYPE AntType,
      a.Polar_Type,
      a.Ant_Gain,
      a.Level_Wave,
      a.Plumb_Wave,
      a.DIR Ant_Dir,
      a.downtilt_electr_prepare,
      a.downtilt_electr1,
      a.ANT_DOWNTILT_ELECT,
      a.DOWNTILT_MECH Ant_Downtilt_Mech,
      nvl(a.ANT_DOWNTILT_ELECT,0)+ nvl(a.DOWNTILT_MECH,0) as Ant_Downtilt,
      a.Adjust_elect,
      a.ANT_plat,
      a.HEIGHT Ant_Height,
      a.power_dividers_cell Cell_split,
      a.power_dividers_cell_id Cell_split_id,
      a.Decorative_antenna,
      a.Decorative_antenna_type,
      c_cell.numfa as Carrier_1X,
      case c_cell.do_cell
      when 0 then '否'
      else '是'
      end as Sector_do,
      c_cell.numfa_do as carrier_DO,
      getcarrierpower(283,to_char(c_cell.int_id),c_cell.vendor_id) as carrier283_power,
      getcarrierpower(201,to_char(c_cell.int_id),c_cell.vendor_id) as carrier201_power,
      getcarrierpower(242,to_char(c_cell.int_id),c_cell.vendor_id) as carrier242_power,
      getcarrierpower(160,to_char(c_cell.int_id),c_cell.vendor_id) as carrier160_power,
      getcarrierpower(37,to_char(c_cell.int_id),c_cell.vendor_id) as carrier37_power,
      getcarrierpower(78,to_char(c_cell.int_id),c_cell.vendor_id) as carrier78_power,
      getcarrierpower(119,to_char(c_cell.int_id),c_cell.vendor_id) as carrier119_power,
      case GetPseudoFrequency(to_char(c_cell.int_id),c_cell.vendor_id)
      when 0 then '否'
      else '是'
      end as pseudo_frequency,
      GetPseudoFrequency(to_char(c_cell.int_id),c_cell.vendor_id) as Freq_fake,
      case
      when instr(a.Border_cell,'B')>0 then '是'
      else '否'
      end as border_sector,
      a.Border_cell,
      a.sector_border_type,
      a.adj_province_name,
      a.adj_city_name,
      a.Diff_Fre_sleep,
      a.border_cell_service_type,
      a.border_type,
      (select count(*)
      FROM tco_pro_repeater b
      WHERE  b.related_cell = a.int_id) as repeater_num,
      (select count(*)
      FROM tco_pro_indoors b
      WHERE  b.related_cell = a.int_id) as indoors_num,
      a.bts_amplifier_model,
      a.Ita_amplifier_model,
      case
      when pro_bts.bts_type='专用室分源' then 0.1
      when a.Cover_earatype='市区' then 0.2
      when a.Cover_earatype='县城' then 0.3
      when a.Cover_earatype='郊区' then 0.3
      else 0.5
      end as Cell_radius,
      case
      when a.Cover_earatype='市区' then 0.8
      when a.Cover_earatype='市区' and c_bts.vendor_id=7 and c_bts.vendor_btstype='CBTS I2' then 0.7
      when (a.Cover_earatype='县城' or a.Cover_earatype='郊区') and c_bts.vendor_id=7 then 0.8
      when (a.Cover_earatype='县城' or a.Cover_earatype='郊区') and c_bts.vendor_id=10 then 1
      when a.Cover_earatype='平原农村' then 1.1
      when a.Cover_earatype='丘陵农村' then 0.7
      when a.Cover_earatype='水域农村' then 0.7344
      else 0.7839
      end as border_dalay_type,
      case a.Cover_earatype
      when '市区' then 700
      when '县城' then 1000
      when '郊区' then 2000
      else 3500
      end as Position_M,
      a.Ant_elevation,
      a.data_renewal_date operationtime,
      user1.display_name as OperationUserName,
      a.note Remark,
      r.region_id,
      r.city_id,
      a.related_cellid related_cell,
      a.related_btsid related_bts
      from cdmauser.c_cell c_cell,c_tco_pro_cell a
      left join c_tco_pro_bts pro_bts on a.related_btsid = pro_bts.int_id
      left join cdmauser.c_bts c_bts on a.related_btsid = c_bts.int_id
      left join c_region_city r on r.city_id = a.city_id
      left join c_tco_user_v2 user1 on a.OperationUserID = user1.user_id
      LEFT JOIN tco_pro_grid grid ON a.grid_id = grid.grid_no
      where a.int_id = c_cell.int_id or a.related_cellid = c_cell.int_id;
     --定义一个游标变量v_cinfo c_emp%ROWTYPE ，该类型为游标c_emp中的一行数据类型
      c_row c_job%rowtype;
      begin
        for c_row in c_job loop
          begin
            insert into hd_c_pro_cell(
              INT_ID,
              province_name,
              region_name,
              city_name,
              village_name,
              grid_num,
              operate_department,
              mscid,
              bscid,
              btsid,
              bts_name,
              CI,
              CellID,
              Cell_name ,
              longitude,
              Latitude,
              Cell_address,
              Cell_index,
              pn,
              LAC,
              vendor_name,
              vendor_btstype,
              RRU_cell,
              Mrru_Cell,
              Status,
              Cover_earatype,
              Cover_way_type,
              Cover_hot_type,
              Ant_Vendor,
              Ant_Model,
              anttype,
              polar_type,
              ant_gain,
              level_wave,
              plumb_wave,
              Ant_Dir,
              downtilt_electr_prepare,
              downtilt_electr1,
              ANT_DOWNTILT_ELECT,
              Ant_Downtilt_Mech,
              Ant_Downtilt,
              adjust_elect,
              ANT_plat,
              Ant_Height,
              Cell_split,
              Cell_split_id,
              Decorative_antenna,
              Decorative_antenna_type,
              Carrier_1X,
              Sector_do,
              Carrier_DO,
              Carrier283_power,
              Carrier201_power,
              Carrier242_power,
              Carrier160_power,
              Carrier37_power,
              Carrier78_power,
              Carrier119_power,
              pseudo_frequency,
              Freq_fake,
              Border_sector,
              Border_cell,
              sector_border_type,
              Adj_province_name,
              Adj_city_name,
              Diff_Fre_sleep,
              Border_cell_service_type,
              Border_type,
              Repeater_num,
              Indoors_num,
              bts_amplifier_model,
              Ita_amplifier_model,
              Cell_radius,
              Border_dalay_type,
              Position_M,
              Ant_elevation,
              operationtime,
              OperationUserName,
              Remark,
              region_id,
              city_id,
              hd_time,
              related_cell,
              related_bts
            )
            values(
              c_row.INT_ID,
              c_row.province_name,
              c_row.region_name,
              c_row.city_name,
              c_row.village_name,
              c_row.grid_num,
              c_row.operate_department,
              c_row.mscid,
              c_row.bscid,
              c_row.btsid,
              c_row.bts_name,
              c_row.CI,
              c_row.CellID,
              c_row.Cell_name ,
              c_row.longitude,
              c_row.Latitude,
              c_row.Cell_address,
              c_row.Cell_index,
              c_row.pn,
              c_row.LAC,
              c_row.vendor_name,
              c_row.vendor_btstype,
              c_row.RRU_cell,
              c_row.Mrru_Cell,
              c_row.Status,
              c_row.Cover_earatype,
              c_row.Cover_way_type,
              c_row.Cover_hot_type,
              c_row.Ant_Vendor,
              c_row.Ant_Model,
              c_row.anttype,
              c_row.polar_type,
              c_row.ant_gain,
              c_row.level_wave,
              c_row.plumb_wave,
              c_row.Ant_Dir,
              c_row.downtilt_electr_prepare,
              c_row.downtilt_electr1,
              c_row.ANT_DOWNTILT_ELECT,
              c_row.Ant_Downtilt_Mech,
              c_row.Ant_Downtilt,
              c_row.adjust_elect,
              c_row.ANT_plat,
              c_row.Ant_Height,
              c_row.Cell_split,
              c_row.Cell_split_id,
              c_row.Decorative_antenna,
              c_row.Decorative_antenna_type,
              c_row.Carrier_1X,
              c_row.Sector_do,
              c_row.Carrier_DO,
              c_row.Carrier283_power,
              c_row.Carrier201_power,
              c_row.Carrier242_power,
              c_row.Carrier160_power,
              c_row.Carrier37_power,
              c_row.Carrier78_power,
              c_row.Carrier119_power,
              c_row.pseudo_frequency,
              c_row.Freq_fake,
              c_row.Border_sector,
              c_row.Border_cell,
              c_row.sector_border_type,
              c_row.Adj_province_name,
              c_row.Adj_city_name,
              c_row.Diff_Fre_sleep,
              c_row.Border_cell_service_type,
              c_row.Border_type,
              c_row.Repeater_num,
              c_row.Indoors_num,
              c_row.bts_amplifier_model,
              c_row.Ita_amplifier_model,
              c_row.Cell_radius,
              c_row.Border_dalay_type,
              c_row.Position_M,
              c_row.Ant_elevation,
              c_row.operationtime,
              c_row.OperationUserName,
              c_row.Remark,
              c_row.region_id,
              c_row.city_id,
              sysdate,
              c_row.related_cell,
              c_row.related_bts
            );
            commit;
          end;
        end loop;
      end;
end proc_SP_cell;
