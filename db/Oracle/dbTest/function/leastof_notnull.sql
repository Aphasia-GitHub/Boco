create or replace function leastof_notnull(
a float,
b float,
c float,
d float
)
return float as
f_min float;
begin

IF a is not null and a != 0 THEN
   IF f_min is null or f_min > a THEN
      f_min := a;
   END IF;
END IF;

IF b is not null and b != 0 THEN
   IF f_min is null or f_min > b THEN
      f_min := b;
   END IF;
END IF;

IF c is not null and c != 0 THEN
   IF f_min is null or f_min > c THEN
      f_min := c;
   END IF;
END IF;

IF d is not null and d != 0 THEN
   IF f_min is null or f_min > d THEN
      f_min := d;
   END IF;
END IF;

RETURN f_min;
end;
