-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllContractLastActions-12122016.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_contractslastaction` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@PK ,
@LNG ,
@TYPE ,
@ID ,
@VALUE 
) 
set 
ID=@ID ,
VALUE=upper(trim(@VALUE))  
;

-- select * from rcb_contractslastaction limit 10000;
