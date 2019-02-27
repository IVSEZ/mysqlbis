-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketTechDepts-17092017.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketTechDepts-19022019.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_tickettechdepts` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID,
@KOD,
@NAME,
@TECHLEVELID,
@OWNERID,
@ID_OLD,
@UPDDATE,
@USERID

) 
set 
ID=@ID ,
KOD=@KOD,
NAME=@NAME ,
TECHLEVELID=@TECHLEVELID ,
OWNERID=@OWNERID ,
ID_OLD=@ID_OLD ,
UPDDATE=@UPDDATE ,
USERID=@USERID ,


INSERTEDON=now()

;


select count(*) from rcb_tickettechdepts;

select * from rcbill.rcb_tickettechdepts;
