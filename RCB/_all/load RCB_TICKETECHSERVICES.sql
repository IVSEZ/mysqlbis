LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTechServices-21112017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_tickettechservices` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@KOD ,
@Name ,
@BillingServiceIDList ,
@OwnerID ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@GlobalTicket 
) 
set
ID=@ID ,
KOD=@KOD ,
NAME=@Name ,
BILLINGSERVICEIDLIST=@BillingServiceIDList ,
OWNERID=@OwnerID ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
USERID=@USERID ,
GLOBALTICKET=@GlobalTicket ,


INSERTEDON=now()
-- ,
-- REPORTDATE=@REPORTDATE

;



select * from rcbill.rcb_tickettechservices;

