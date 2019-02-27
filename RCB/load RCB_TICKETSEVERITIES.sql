LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketSeverities-21112017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_ticketseverities` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@KOD ,
@Name ,
@ID_OLD ,
@UpdDate ,
@USERID 
) 
set
ID=@ID ,
KOD=@KOD ,
NAME=@Name ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
USERID=@USERID ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;



select * from rcbill.rcb_ticketseverities;

