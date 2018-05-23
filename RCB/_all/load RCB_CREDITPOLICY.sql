-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCreditPolicy-25072017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_creditpolicy` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@KOD ,
@NAME ,
@UseNonInvoiced ,
@UseNonInvoicedVAT ,
@UseSaldo ,
@BillingPeriod ,
@OwnerID ,
@PriorityServiceID ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@MON ,
@TUE ,
@WED ,
@THU ,
@FRI ,
@SAT ,
@SUN ,
@InvoicingAvanceDays ,
@MinLimit ,
@MaxLimit ,
@MinInvDate ,
@MaxInvDate ,
@AdjustInvoicingDate 
) 
set 
ID=@ID ,
KOD=@KOD ,
NAME=upper(trim(@NAME)) ,
UseNonInvoiced=@UseNonInvoiced ,
UseNonInvoicedVAT=@UseNonInvoicedVAT ,
UseSaldo=@UseSaldo ,
BillingPeriod=@BillingPeriod ,
OwnerID=@OwnerID ,
PriorityServiceID=@PriorityServiceID ,
ID_OLD=@ID_OLD ,
UpdDate=@UpdDate ,
USERID=@USERID ,
MON=@MON ,
TUE=@TUE ,
WED=@WED ,
THU=@THU ,
FRI=@FRI ,
SAT=@SAT ,
SUN=@SUN ,
InvoicingAvanceDays=@InvoicingAvanceDays ,
MinLimit=@MinLimit ,
MaxLimit=@MaxLimit ,
MinInvDate=@MinInvDate ,
MaxInvDate=@MaxInvDate ,
AdjustInvoicingDate=@AdjustInvoicingDate 


;

-- select * from rcb_creditpolicy;