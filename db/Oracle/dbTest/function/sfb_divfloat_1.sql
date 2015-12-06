create or replace function sfb_divfloat_1(
a float,
b float,ret0 float default 0.00,ret1 float default 1.00
)
return float as
res float;
begin
IF b = 0 AND a = 0  THEN
RETURN ret0;
END IF;
IF b = 0 AND a<>0 THEN
RETURN null;
END IF;
 res  := round(a/b,4);
RETURN res;
end;
