-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Cleaned-Clients-08112016.txt' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\Cleaned-Clients-23112016.txt' 
REPLACE INTO TABLE `rcbill_my`.`clients` CHARACTER SET LATIN1 FIELDS TERMINATED BY '\t' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
-- (`id`, `clientfull`, `ssn`,  `address`, `clientaddress`, `phone`, `clientcode`, `clientname`  );

(
@id,
@clientfull,
@ssn,
@address,
@clientaddress,
@phone,
@clientcode,
@clientname

) 
set 
id=@id,
clientcode=@clientcode,
clientname=@clientname,
clientfull=@clientfull,
ssn=@ssn,
-- address=@address,
clientaddress=@clientaddress,
phone=@phone
;
