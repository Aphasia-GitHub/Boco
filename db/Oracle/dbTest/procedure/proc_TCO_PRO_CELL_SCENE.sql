CREATE OR REPLACE PROCEDURE proc_TCO_PRO_CELL_SCENE AS
begin
  DECLARE
    CURSOR CUR_B IS
      select a.rowid ROW_ID
        from c_tco_group_detail a
       where a.group_id in
             (select distinct group_id
                from c_tco_group_cell b
               where b.group_type like 'Ê¡ÍøÓÅ_HQ%')
         and a.int_id in
             (select distinct cell_int_id from C_TCO_PRO_CELL_SCENES c);
    V_COUNTER NUMBER;
  BEGIN
    V_COUNTER := 0;
    FOR ROW_B IN CUR_B LOOP
      DELETE FROM c_tco_group_detail WHERE ROWID = ROW_B.ROW_ID;
      V_COUNTER := V_COUNTER + 1;
      IF (V_COUNTER >= 1000) THEN
        COMMIT;
        V_COUNTER := 0;
      END IF;
    END LOOP;
    INSERT INTO c_tco_group_detail
      (group_id, int_id)
      select related_scene, cell_int_id from C_TCO_PRO_CELL_SCENES;
    COMMIT;
  END;
end;
