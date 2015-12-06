create or replace function max_diff(
a float,
b float,
c float,
d float
)
return float as
f_max float;
f_min float;
begin

IF a is not null and a != 0 THEN
   IF f_min is null or f_min > a THEN
      f_min := a;
   END IF;
   IF f_max is null or f_max < a THEN
      f_max := a;
   END IF;
END IF;

IF b is not null and b != 0 THEN
   IF f_min is null or f_min > b THEN
      f_min := b;
   END IF;
   IF f_max is null or f_max < b THEN
      f_max := b;
   END IF;
END IF;

IF c is not null and c != 0 THEN
   IF f_min is null or f_min > c THEN
      f_min := c;
   END IF;
   IF f_max is null or f_max < c THEN
      f_max := c;
   END IF;
END IF;

IF d is not null and d != 0 THEN
   IF f_min is null or f_min > d THEN
      f_min := d;
   END IF;
   IF f_max is null or f_max < d THEN
      f_max := d;
   END IF;
END IF;

IF f_max is not null and f_max != 0 and f_min is not null and f_min != 0 THEN
   RETURN round((f_max - f_min) * 100 / f_min, 3);
ELSE
   RETURN NULL;
END IF;

end;
