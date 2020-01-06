-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCashPoints-25072017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCashPoints-09112018.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCashPoints-04012020.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_cashpoints` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@KOD ,
@Name ,
@IPAddress ,
@MachineName ,
@RequireSSL ,
@StartInvoiceNo ,
@EndInvoiceNo ,
@OwnerID ,
@CashPrinterID ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@RegionID ,
@SetupUserID ,
@SetupDate ,
@SetupAllow ,
@AllowPayObjects ,
@InvoiceRangeID ,
@DistributorID ,
@StornoPermissionPaymentCount ,
@StornoPermissionMonthCount 
) 
set 
ID=@ID ,
KOD=@KOD ,
Name=upper(trim(@Name)) ,
IPAddress=@IPAddress ,
MachineName=@MachineName ,
RequireSSL=@RequireSSL ,
StartInvoiceNo=@StartInvoiceNo ,
EndInvoiceNo=@EndInvoiceNo ,
OwnerID=@OwnerID ,
CashPrinterID=@CashPrinterID ,
ID_OLD=@ID_OLD ,
UpdDate=@UpdDate ,
USERID=@USERID ,
RegionID=@RegionID ,
SetupUserID=@SetupUserID ,
SetupDate=@SetupDate ,
SetupAllow=@SetupAllow ,
AllowPayObjects=@AllowPayObjects ,
InvoiceRangeID=@InvoiceRangeID ,
DistributorID=@DistributorID ,
StornoPermissionPaymentCount=@StornoPermissionPaymentCount ,
StornoPermissionMonthCount=@StornoPermissionMonthCount 
;

-- select * from rcbill.rcb_cashpoints;