
call rcbill_my.sp_filllastdates('2016-05-31',DATE_SUB(date(NOW()), INTERVAL 1 DAY));
call rcbill_my.sp_fillalldates('2016-05-01',DATE_SUB(date(NOW()), INTERVAL 1 DAY));
-- select * from rcbill_my.month_last_date order by 1 desc;
-- select * from rcbill_my.month_all_date order by 1 desc;

#CLIENT SCRIPT
use rcbill;

set @lastdate = (select max(month_all_date) from rcbill_my.month_all_date);

#SET DATE
SET @REPORTDATE=str_to_date('2021-07-07','%Y-%m-%d');

SET @rundate='2021-07-07';

SET @COLNAME1='CLIENTDEBT_REPORTDATE';

set @periodstart='2021-07-07';
set @periodend='2021-07-07';	


SET @rundate='2021-07-07';

#FOR Daily calls script
SET @date1='2021-07-07';
SET @date2='2021-07-08';


## FOR BUDGET ACTUAL ANALYSIS SCRIPT
## change the @m# date for the relevant date
set @revenue=1;
set @m1='2021-01-31';
set @m2='2021-02-28';
set @m3='2021-03-31';
set @m4='2021-04-30';
set @m5='2021-05-31';
set @m6='2021-06-30';

set @m7='2021-07-07';

set @m8='2021-08-31';
set @m9='2021-09-30';
set @m10='2021-10-31';
set @m11='2021-11-30';
set @m12='2021-12-31';