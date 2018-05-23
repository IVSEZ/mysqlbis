
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllPayments-upto30112016.csv' 
-- REPLACE INTO TABLE `rcbill_my`.`allpayments` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
-- OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllPaymentsJim-04122016.txt' 
REPLACE INTO TABLE `rcbill_my`.`allpayments` CHARACTER SET LATIN1 FIELDS TERMINATED BY '\t' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 


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
@clientcode,

@clientname,

@contractid,

@service,

@servicetype,

@paymentid,

@paymentdate,

@paymentamount,

@debtfrom,

@debtto
) 

/*
@paymentid,
@paymentdate,
@paymentamount
@debtfrom,
@debtto
@contractid,
@service,
@servicetype,
@clientname,
@clientcode,


*/

set 
paymentid=@paymentid,

-- paymentdate=STR_TO_DATE(@paymentdate,'%d-%m-%y %k:%i'),
paymentdate=@paymentdate,
paymentamount=@paymentamount,


-- debtfrom=STR_TO_DATE(@debtfrom,'%d-%m-%y %k:%i'),
-- debtto=STR_TO_DATE(@debtto,'%d-%m-%y %k:%i'),

debtfrom=@debtfrom,
debtto=@debtto,

contractid=upper(trim(@contractid)),
service=upper(trim(@service)),
servicetype=upper(trim(@servicetype)),
clientname=upper(trim(@clientname)),
clientcode=upper(trim(@clientcode))
;

