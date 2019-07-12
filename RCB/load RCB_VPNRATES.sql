
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllVPNRates-04122016.txt'
-- REPLACE INTO TABLE `rcbill`.`rcb_vpnrates` CHARACTER SET LATIN1 FIELDS TERMINATED BY '\t' 
-- OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES ;


-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVPNRates-03092017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVPNRates-22012018.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVPNRates-08042018.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVPNRates-29052018.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVPNRates-21072018.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVPNRates-17122018.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVPNRates-27032019.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVPNRates-16052019.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_vpnrates` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES
(
@ID ,
@RatingPlanID ,
@ServiceID ,
@Name ,
@Period ,
@Price ,
@Post ,
@AvancePeriods ,
@MaxCost ,
@TraficUpSpeed ,
@TraficDownSpeed ,
@TraficSpeed ,
@TraficLimit ,
@IPPool ,
@MaxSessionDuration ,
@MultiLinkCount ,
@SubRateType ,
@ChargeUnits ,
@SplitRound ,
@InvoiceText ,
@DayPrice ,
@AllowManualPrice ,
@ExportCode ,
@BillingName ,
@AliasID ,
@AliasName ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@Description ,
@RequireSerialNo ,
@TemplateID ,
@SerialNoFilter ,
@AllowTemporaryActivation ,
@AllowHiSpeedActivation ,
@DisableTerminationOnLimit ,
@AllowUsageTransfer ,
@vCutPeriod ,
@vSplit ,
@vCutPeriodNot ,
@vSplitNot ,
@FeeID ,
@UsagePeriodics ,
@AllowOnline ,
@AllowFuturePeriodActivation 

)
set
ID=@ID ,
RatingPlanID=@RatingPlanID ,
ServiceID=@ServiceID ,
Name=upper(trim(@Name)) ,
Period=@Period ,
Price=@Price ,
Post=@Post ,
AvancePeriods=@AvancePeriods ,
MaxCost=@MaxCost ,
TraficUpSpeed=@TraficUpSpeed ,
TraficDownSpeed=@TraficDownSpeed ,
TraficSpeed=@TraficSpeed ,
TraficLimit=@TraficLimit ,
IPPool=@IPPool ,
MaxSessionDuration=@MaxSessionDuration ,
MultiLinkCount=@MultiLinkCount ,
SubRateType=@SubRateType ,
ChargeUnits=@ChargeUnits ,
SplitRound=@SplitRound ,
InvoiceText=@InvoiceText ,
DayPrice=@DayPrice ,
AllowManualPrice=@AllowManualPrice ,
ExportCode=@ExportCode ,
BillingName=@BillingName ,
AliasID=@AliasID ,
AliasName=@AliasName ,
ID_OLD=@ID_OLD ,
UpdDate=@UpdDate ,
USERID=@USERID ,
Description=@Description ,
RequireSerialNo=@RequireSerialNo ,
TemplateID=@TemplateID ,
SerialNoFilter=@SerialNoFilter ,
AllowTemporaryActivation=@AllowTemporaryActivation ,
AllowHiSpeedActivation=@AllowHiSpeedActivation ,
DisableTerminationOnLimit=@DisableTerminationOnLimit ,
AllowUsageTransfer=@AllowUsageTransfer ,
vCutPeriod=@vCutPeriod ,
vSplit=@vSplit ,
vCutPeriodNot=@vCutPeriodNot ,
vSplitNot=@vSplitNot ,
FeeID=@FeeID ,
UsagePeriodics=@UsagePeriodics ,
AllowOnline=@AllowOnline ,
AllowFuturePeriodActivation=@AllowFuturePeriodActivation 

;

-- select * from rcbill.rcb_vpnrates