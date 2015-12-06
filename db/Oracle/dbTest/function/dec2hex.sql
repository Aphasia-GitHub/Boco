create or replace function dec2hex(in_num NUMBER)
  RETURN VARCHAR2
  as
   TYPE vc2tab_type IS TABLE OF VARCHAR2(1) INDEX BY BINARY_INTEGER;
   hextab vc2tab_type;
   v_num NUMBER;
   v_hex VARCHAR2(200);

    BEGIN
    IF in_num IS NULL THEN RETURN NULL; END IF;

       hextab(0) := '0';
       hextab(1) := '1';
       hextab(2) := '2';
       hextab(3) := '3';
       hextab(4) := '4';
       hextab(5) := '5';
       hextab(6) := '6';
       hextab(7) := '7';
       hextab(8) := '8';
       hextab(9) := '9';
       hextab(10) := 'A';
       hextab(11) := 'B';
       hextab(12) := 'C';
       hextab(13) := 'D';
       hextab(14) := 'E';
       hextab(15) := 'F';
       v_num := in_num;

       WHILE v_num >= 16
       LOOP
         v_hex := hextab (MOD (v_num, 16)) || v_hex;
         v_num := TRUNC (v_num / 16);
       END LOOP;

      v_hex := hextab (MOD (v_num, 16)) || v_hex;

      return(v_hex);
      end dec2hex;
