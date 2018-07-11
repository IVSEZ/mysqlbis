#CLIENT SCRIPT
use rcbill;

#SET DATE
SET @REPORTDATE=str_to_date('2018-07-10','%Y-%m-%d');

SET @rundate='2018-07-10';

SET @COLNAME1='CLIENTDEBT_REPORTDATE';

select count(*) from rcbill.rcb_tclients;

select count(*) from rcbill_my.dailyactivenumber;