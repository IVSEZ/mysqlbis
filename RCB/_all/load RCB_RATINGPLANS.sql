-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllRatingPlans-09042017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_ratingplans` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@KOD ,
@name ,
@Type ,
@PrePaid ,
@StartDate ,
@EndDate ,
@NStartTime ,
@NEndTime ,
@NextRatingPlanID ,
@DefCreditLimit ,
@DefCreditPolicyID ,
@DefaultRP ,
@OwnerID ,
@PromoText ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@AllowBulkInvoicing ,
@rCurrency 
) 
set 
ID=@ID ,
KOD=@KOD ,
name=upper(trim(@name)) ,
Type=@Type ,
PrePaid=@PrePaid ,
StartDate=@StartDate ,
EndDate=@EndDate ,
NStartTime=@NStartTime ,
NEndTime=@NEndTime ,
NextRatingPlanID=@NextRatingPlanID ,
DefCreditLimit=@DefCreditLimit ,
DefCreditPolicyID=@DefCreditPolicyID ,
DefaultRP=@DefaultRP ,
OwnerID=@OwnerID ,
PromoText=@PromoText ,
ID_OLD=@ID_OLD ,
UpdDate=@UpdDate ,
USERID=@USERID ,
AllowBulkInvoicing=@AllowBulkInvoicing ,
rCurrency=@rCurrency 


;

-- select * from rcb_ratingplans;