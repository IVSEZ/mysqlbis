-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketTechUsers-17092017.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketTechLevels-12062018.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_tickettechlevels` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@KOD ,
@Name ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@AUTH_GROUP_ID 

) 
set 
ID=@ID ,
KOD=@KOD ,
NAME=@Name ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
USERID=@USERID ,
AUTH_GROUP_ID=@AUTH_GROUP_ID ,



INSERTEDON=now()

;


select count(*) from rcb_tickettechlevels;

select * from rcbill.rcb_tickettechlevels;


