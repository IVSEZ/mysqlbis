-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllServices-03092017.csv' 

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllServices-22012018.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllServices-08042018.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllServices-21072018.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllServices-27032019.csv'
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllServices-16052019.csv'
REPLACE INTO TABLE `rcbill`.`rcb_services` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@Name ,
@SysName ,
@KOD ,
@AcctCode ,
@System ,
@ServiceTypeID ,
@ParentID ,
@SessionName ,
@BillingName ,
@AllowDevices ,
@InStatistics ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@FiscalPrintName ,
@VATPercentT ,
@ServiceClassID ,
@AutoNumber ,
@DisablePeriodConsolidation 
) 
set 
ID=@ID ,
Name=upper(trim(@Name)) ,
SysName=@SysName ,
KOD=@KOD ,
AcctCode=@AcctCode ,
System=@System ,
ServiceTypeID=@ServiceTypeID ,
ParentID=@ParentID ,
SessionName=upper(trim(@SessionName)) ,
BillingName=upper(trim(@BillingName)) ,
AllowDevices=@AllowDevices ,
InStatistics=@InStatistics ,
ID_OLD=@ID_OLD ,
UpdDate=@UpdDate ,
USERID=@USERID ,
FiscalPrintName=@FiscalPrintName ,
VATPercentT=@VATPercentT ,
ServiceClassID=@ServiceClassID ,
AutoNumber=@AutoNumber ,
DisablePeriodConsolidation=@DisablePeriodConsolidation 

;

-- select * from rcbill.rcb_services;