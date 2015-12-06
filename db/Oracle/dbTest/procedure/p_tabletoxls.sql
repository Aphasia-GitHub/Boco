CREATE OR REPLACE PROCEDURE p_tabletoxls IS
   v_file utl_file.file_type;
   CURSOR cur_emp IS
      SELECT imsi, scan_start_time, related_cell  FROM CDL_ZX_1069156405_20150601 where rownum<2;
BEGIN
   IF utl_file.is_open(v_file) THEN
      utl_file.fclose(v_file);
   END IF;
   v_file := utl_file.fopen('text_dir', '0601.txt', 'w');
   FOR i IN cur_emp LOOP
      utl_file.put_line(v_file, i.imsi || chr(9) || i.scan_start_time || chr(9) || i.related_cell);
   END LOOP;
   utl_file.fclose(v_file);
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(SQLERRM); --Ð´ÈëÊý¾Ý
      IF utl_file.is_open(v_file) THEN
         utl_file.fclose(v_file);
      END IF;
END p_tabletoxls;
