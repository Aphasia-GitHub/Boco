create or replace function GetAntOpening(cellIntId NUMBER)
  RETURN Number
  as
    v_vendorid number;
    v_cellid number;
    v_btsId number;
    antOping number;
    BEGIN
      select vendor_id,cellid,related_bts into v_vendorid,v_cellid,v_btsId
        from c_cell
         where int_id= cellIntId;

      if v_vendorid=7 then
           if v_cellid=0 then
                 select   case
                          when cell2=0 or cell3=0 then 180
                          else abs(cell1-cell2)/2+abs(cell1-cell3)/2
                          end  into antOping
                     From
                     (
                    select sum(decode(m.cellid, 0, n.dir,0)) cell1,
                           sum(decode(m.cellid, 1, n.dir,0)) cell2,
                           sum(decode(m.cellid, 2, n.dir,0)) cell3
                    from c_cell m, c_tco_pro_cell n
                     where m.int_id = n.int_id
                      and m.related_bts =v_btsId
                      );
              elsif  v_cellid=1 then
                  select  case
                          when cell2=0 or cell3=0 then 180
                          else abs(cell2-cell1)/2+abs(cell2-cell3)/2
                          end  into antOping
                     From
                     (
                    select sum(decode(m.cellid, 0, n.dir,0)) cell1,
                           sum(decode(m.cellid, 1, n.dir,0)) cell2,
                           sum(decode(m.cellid, 2, n.dir,0)) cell3
                    from c_cell m, c_tco_pro_cell n
                     where m.int_id = n.int_id
                      and m.related_bts =v_btsId
                      );
              elsif v_cellid=2 then
                  select  case
                          when cell2=0 or cell3=0 then 180
                          else abs(cell3-cell1)/2+abs(cell3-cell2)/2
                          end  into antOping
                     From
                     (
                    select sum(decode(m.cellid, 0, n.dir,0)) cell1,
                           sum(decode(m.cellid, 1, n.dir,0)) cell2,
                           sum(decode(m.cellid, 2, n.dir,0)) cell3
                    from c_cell m, c_tco_pro_cell n
                     where m.int_id = n.int_id
                      and m.related_bts =v_btsId
                     );
              else
                antOping:=360;
             end if;
             else
                 if v_cellid=1 then
                 select   case
                          when cell2=0 or cell3=0 then 180
                          else abs(cell1-cell2)/2+abs(cell1-cell3)/2
                          end  into antOping
                     From
                     (
                    select sum(decode(m.cellid, 1, n.dir,0)) cell1,
                           sum(decode(m.cellid, 2, n.dir,0)) cell2,
                           sum(decode(m.cellid, 3, n.dir,0)) cell3
                    from c_cell m, c_tco_pro_cell n
                     where m.int_id = n.int_id
                      and m.related_bts =v_btsId
                      );
              elsif  v_cellid=2 then
                  select  case
                          when cell2=0 or cell3=0 then 180
                          else abs(cell2-cell1)/2+abs(cell2-cell3)/2
                          end  into antOping
                     From
                     (
                    select sum(decode(m.cellid, 1, n.dir,0)) cell1,
                           sum(decode(m.cellid, 2, n.dir,0)) cell2,
                           sum(decode(m.cellid, 3, n.dir,0)) cell3
                    from c_cell m, c_tco_pro_cell n
                     where m.int_id = n.int_id
                      and m.related_bts =v_btsId
                      );
              elsif v_cellid=3 then
                  select  case
                          when cell2=0 or cell3=0 then 180
                          else abs(cell3-cell1)/2+abs(cell3-cell2)/2
                          end  into antOping
                     From
                     (
                    select sum(decode(m.cellid, 1, n.dir,0)) cell1,
                           sum(decode(m.cellid, 2, n.dir,0)) cell2,
                           sum(decode(m.cellid, 3, n.dir,0)) cell3
                    from c_cell m, c_tco_pro_cell n
                     where m.int_id = n.int_id
                      and m.related_bts =v_btsId
                     );
              else
                antOping:=360;
             end if;

         end if;

      return(greatest(antOping, 120));
  end GetAntOpening;
