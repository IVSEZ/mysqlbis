#change the dates below and save the two tables as CSV and send to Israel in Finance 

## AVERAGE ACTIVE NUMBER REPORT
select * from rcbill_my.rep_activenumberavg3 where lastday <> '2023-01-03';

## run and save this table (click on the save next to Export) to C:\ProgramData\MySQL\MySQL Server 5.7\Export as "export-Avg-May2016-MONYYYY-1.csv" e.g. export-Avg-May2016-Nov2022-1.csv


## MONTH ACTIVE NUMBER REPORT
use rcbill_my;
call sp_GetActiveNumberFromTo('2022-12-01','2022-12-31');

## run and save this table (click on the save next to Export) to C:\ProgramData\MySQL\MySQL Server 5.7\Export as "activenumberreport-DDMMYYYY-DDMMYYYY-1.csv" e.g. activenumberreport-01112022-31112022-1.csv
