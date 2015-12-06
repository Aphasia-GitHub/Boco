create or replace function sfb_divfloat_2(
a DECIMAL,
b DECIMAL
)
return DECIMAL  as
res DECIMAL(16,6);
begin
IF b = 0   THEN
RETURN 0.00;
END IF;
 res  := round(a/b,4);
RETURN res;
end;
