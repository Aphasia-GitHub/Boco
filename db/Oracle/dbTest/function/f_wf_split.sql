CREATE OR REPLACE FUNCTION f_wf_split
(
       inSource varchar2,
       inSplit varchar2
)
RETURN
       t_wf_split
PIPELINED IS
          i pls_integer;
          s varchar2(1000) := inSource;
BEGIN
   LOOP
      i := INSTR(s, inSplit);

      IF i > 0 THEN
         PIPE ROW(SUBSTR(s, 1, i - 1));
         s := SUBSTR(s, i + LENGTH(inSplit));
      ELSE
         PIPE ROW(s);
         EXIT;
      END IF;

   END LOOP;

   RETURN;
END;
