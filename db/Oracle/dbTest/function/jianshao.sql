create or replace function jianshao(
a DECIMAL ,
b DECIMAL
)
return DECIMAL  as
res DECIMAL(16,6);
begin
IF b IS NULL OR a IS NULL THEN
RETURN NULL;
END IF;
IF b = 0 AND a = 0  THEN
RETURN 0.00;
END IF;
IF b = 0 AND a <> 0  THEN
RETURN NULL;
END IF;
 res  := a-b;
RETURN res;
end;
