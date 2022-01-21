
call rcbill_my.sp_filllastdates('2016-05-31',DATE_SUB(date(NOW()), INTERVAL 1 DAY));
call rcbill_my.sp_fillalldates('2016-05-01',DATE_SUB(date(NOW()), INTERVAL 1 DAY));
-- select * from rcbill_my.month_last_date order by 1 desc;
-- select * from rcbill_my.month_all_date order by 1 desc;

#CLIENT SCRIPT
use rcbill;

set @lastdate = (select max(month_all_date) from rcbill_my.month_all_date);

#SET DATE
SET @REPORTDATE=str_to_date('2022-01-20','%Y-%m-%d');


SET @rundate='2022-01-20';

SET @COLNAME1='CLIENTDEBT_REPORTDATE';

set @periodstart='2022-01-20';
set @periodend='2022-01-20';	


SET @rundate='2022-01-20';

#FOR Daily calls script
SET @date1='2022-01-20';
SET @date2='2022-01-21';  ### to be one day later


## FOR BUDGET ACTUAL ANALYSIS SCRIPT
## change the @m# date for the relevant date
set @revenue=1;
set @m1='2022-01-20';

set @m2='2022-02-28';
set @m3='2022-03-31';
set @m4='2022-04-30';
set @m5='2022-05-31';
set @m6='2022-06-30';
set @m7='2022-07-31';
set @m8='2022-08-31';
set @m9='2022-09-30';
set @m10='2022-10-31';
set @m11='2022-11-30';
set @m12='2022-12-31';
