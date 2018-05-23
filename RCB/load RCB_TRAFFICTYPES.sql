-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTrafficTypes-30042018.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_traffictypes` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@NAME ,
@TRAFFICID ,
@ID_OLD ,
@UPDDATE ,
@USERID 

) 
set 
ID=@ID ,
NAME=@NAME ,
TRAFFICID=@TRAFFICID ,
ID_OLD=@ID_OLD ,
UPDDATE=@UPDDATE ,
USERID=@USERID ,


INSERTEDON=now()

;


select count(*) from rcb_traffictypes;

select * from rcbill.rcb_traffictypes;
