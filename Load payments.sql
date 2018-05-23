
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\PaymentsReportDailyList-AllCombined-01012016-31102016.csv' 
REPLACE INTO TABLE `rcbill_my`.`payments` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 


/*
(dummy) clid,ID,External Reference,Entry Date,EntryDate,EntryTime,User,CASH POINT,Client Code,
ClientCode,Client,ClientName,Amount,Place,Service,Service Type,
Debt period,DebtFromOld,DebtToOld,DebtFrom,DebtTo,Comment,Client Class,PaymentType


(dummy) clid,ID,External Reference,Entry Date,EntryDate,EntryTime,User,CASH POINT,Client Code,
ClientCode,Client,ClientName,Amount,Place,Service,Service Type,
Debt period,DebtFromOld,DebtToOld,DebtFrom,DebtTo,Comment,Client Class,PaymentType,,,


(dummy) clid	ID	External Reference	
Entry Date	EntryDate	EntryTime	
User	CASH POINT	Client Code	
ClientCode	Client	ClientName	
Amount	Place	Service	
Service Type	Debt period	DebtFromOld	
DebtToOld	DebtFrom	DebtTo	
Comment	Client Class	PaymentType

*/

(
@dummy1,
@paymentid,
@dummy3,

@dummy4,
@entrydate,
@entrytime,

@entryuser,
@cashpoint,
@dummy5,

@clientcode,
@dummy6,
@clientname,

@amount,
@paymentchannel,
@service,

@servicetype,
@dummy7,
@dummy8,

@dummy9,
@debtfrom,
@debtto,

@entryusercomment,
@clientclass,
@paymenttype
) 
set 
id=@dummy1,
paymentid=@paymentid,
paymentdate=STR_TO_DATE(CONCAT(@entrydate, ' ', @entrytime), '%d-%m-%y %l:%i %p'),
-- entrytime=STR_TO_DATE(@entrytime,'%h:%i %p');, 

entryuser=@entryuser,
cashpoint=@cashpoint,
clientcode=@clientcode,

clientname=@clientname,
amount=@amount,
paymentchannel=@paymentchannel,

service=@service,
servicetype=@servicetype,
debtfrom=@debtfrom,

debtto=@debtto,
entryusercomment=@entryusercomment,
clientclass=@clientclass,
paymenttype=@paymenttype
;

