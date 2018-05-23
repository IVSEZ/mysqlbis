-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllClientClasses-09042017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_clientclasses` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@Name ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@ACTIVE 
) 
set 
ID=@ID ,
Name=upper(trim(@Name)) ,
ID_OLD=@ID_OLD ,
UpdDate=@UpdDate ,
USERID=@USERID ,
ACTIVE=@ACTIVE 
;

-- select * from rcb_clientclasses;