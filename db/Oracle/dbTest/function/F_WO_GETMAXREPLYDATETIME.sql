create or replace function F_WO_GETMAXREPLYDATETIME
(
       inStartDatetime in date,
       inWeekDays in number
       --returnDate out date
)
return date
IS
       days number :=0;
       weekDay  number := 0;
       returnDate  date;
       --returnDate date:= inStartDatetime ;
---
BEGIN
returnDate:=inStartDatetime;
 WHILE(days < inWeekDays)
 LOOP
       returnDate := returnDate+1;
       SELECT to_number(to_char(returnDate,'D')) INTO weekDay FROM DUAL;

       if weekDay > 1 AND weekDay < 7 then
       days :=days+1;
       END IF;
 END LOOP;
 return returnDate;
END;
