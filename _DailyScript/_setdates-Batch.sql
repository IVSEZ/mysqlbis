
call rcbill_my.sp_filllastdates('2016-05-31',DATE_SUB(date(NOW()), INTERVAL 1 DAY));
call rcbill_my.sp_fillalldates('2016-05-31',DATE_SUB(date(NOW()), INTERVAL 1 DAY));
-- select * from rcbill_my.month_last_date order by 1 desc;
-- select * from rcbill_my.month_all_date order by 1 desc;

#CLIENT SCRIPT
use rcbill;

set @lastdate = (select max(month_all_date) from rcbill_my.month_all_date);

#SET DATE
SET @REPORTDATE=str_to_date('2023-01-08','%Y-%m-%d');


SET @rundate='2023-01-08';

SET @COLNAME1='CLIENTDEBT_REPORTDATE';

set @periodstart='2023-01-08';
set @periodend='2023-01-08';	


SET @rundate='2023-01-08';

#FOR Daily calls script
SET @date1='2023-01-08';
SET @date2='2023-01-09';  ### to be one day later


## FOR BUDGET ACTUAL ANALYSIS SCRIPT
## change the @m# date for the relevant date
set @revenue=1;
set @m1='2023-01-08';

set @m2='2023-02-28';
set @m3='2023-03-31';
set @m4='2023-04-30';
set @m5='2023-05-31';
set @m6='2023-06-31';
set @m7='2023-07-31';
set @m8='2023-08-31';
set @m9='2023-09-30';
set @m10='2023-10-31';
set @m11='2023-11-30';
set @m12='2023-12-31';
