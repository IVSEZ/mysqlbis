
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\ContractsList_08112016.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\ContractsList_23112016.csv' 
REPLACE INTO TABLE `rcbill_my`.`contracts` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
/*
 `id` int(11) DEFAULT NULL,
  `contractid` varchar(255),
  `contracttype` varchar(255),
  `contractdate` datetime,
  `lastaction` varchar(255),
  `clientcode` varchar(255),
  `clientname` varchar(255),
  `phone` varchar(255),
  `usageaddress` varchar(255)

-- (dummy) cid	(dummy) dummy1	(dummy) clid	Code	Contract Type	Contract Date	
-- Last Action	Client Code	ClientCode	Client	ClientName	Phones	Usage Address
*/

(
@dummy1,
@dummy2,
@dummy3,
@contractid,
@contracttype,
@contractdate,
@lastaction,
@dummy4,
@clientcode,
@dummy5,
@clientname,
@phone,
@usageaddress

) 
set 
id=@dummy1,
contractid=@contractid,
contracttype=@contracttype,
contractdate=STR_TO_DATE(@contractdate,'%d-%m-%y %k:%i'),
lastaction=@lastaction,
clientcode=@clientcode,
clientname=@clientname,
phone=@phone,
usageaddress=@usageaddress
;

