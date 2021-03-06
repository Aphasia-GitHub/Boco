CREATE OR REPLACE PACKAGE LONG_HELP AUTHID CURRENT_USERASFUNCTION SUBSTR_OF(P_QUERY IN VARCHAR2, P_FROM IN NUMBER, P_FOR IN NUMBER, P_NAME1 IN VARCHAR2 DEFAULT NULL, P_BIND1 IN VARCHAR2 DEFAULT NULL, P_NAME2 IN VARCHAR2 DEFAULT NULL, P_BIND2 IN VARCHAR2 DEFAULT NULL, P_NAME3 IN VARCHAR2 DEFAULT NULL, P_BIND3 IN VARCHAR2 DEFAULT NULL, P_NAME4 IN VARCHAR2 DEFAULT NULL, P_BIND4 IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;
END; CREATE OR REPLACE PACKAGE BODY LONG_HELP AS
  G_CURSOR NUMBER := DBMS_SQL.OPEN_CURSOR;
  G_QUERY  VARCHAR2(32765);
  PROCEDURE BIND_VARIABLE(P_NAME IN VARCHAR2, P_VALUE IN VARCHAR2) ISBEGIN IF (P_NAME IS
    NOT NULL) THEN DBMS_SQL.BIND_VARIABLE(G_CURSOR, P_NAME, P_VALUE);
  END IF;
END; FUNCTION SUBSTR_OF(P_QUERY IN VARCHAR2, P_FROM IN NUMBER, P_FOR IN NUMBER, P_NAME1 IN VARCHAR2 DEFAULT NULL, P_BIND1 IN VARCHAR2 DEFAULT NULL, P_NAME2 IN VARCHAR2 DEFAULT NULL, P_BIND2 IN VARCHAR2 DEFAULT NULL, P_NAME3 IN VARCHAR2 DEFAULT NULL, P_BIND3 IN VARCHAR2 DEFAULT NULL, P_NAME4 IN VARCHAR2 DEFAULT NULL, P_BIND4 IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2 AS
L_BUFFER VARCHAR2(4000); L_BUFFER_LEN NUMBER;
BEGIN
IF (NVL(P_FROM, 0) <= 0) THEN RAISE_APPLICATION_ERROR(-20002, 'From must be >= 1 (positive numbers)');
END IF; IF (NVL(P_FOR, 0) NOT BETWEEN 1 AND 4000) THEN RAISE_APPLICATION_ERROR(-20003, 'For must be between 1 and 4000');
END IF; IF (P_QUERY <> G_QUERY OR G_QUERY IS
NULL) THEN IF (UPPER(TRIM(NVL(P_QUERY, 'x'))) NOT LIKE 'SELECT%') THEN RAISE_APPLICATION_ERROR(-20001, 'This must be a select only');
END IF; DBMS_SQL.PARSE(G_CURSOR, P_QUERY, DBMS_SQL.NATIVE); G_QUERY := P_QUERY;
END IF; BIND_VARIABLE(P_NAME1, P_BIND1); BIND_VARIABLE(P_NAME2, P_BIND2); BIND_VARIABLE(P_NAME3, P_BIND3); BIND_VARIABLE(P_NAME4, P_BIND4); DBMS_SQL.DEFINE_COLUMN_LONG(G_CURSOR, 1); IF (DBMS_SQL.EXECUTE_AND_FETCH(G_CURSOR) > 0) THEN DBMS_SQL.COLUMN_VALUE_LONG(G_CURSOR, 1, P_FOR, P_FROM - 1, L_BUFFER, L_BUFFER_LEN);
END IF; RETURN L_BUFFER;
END SUBSTR_OF;
END;
