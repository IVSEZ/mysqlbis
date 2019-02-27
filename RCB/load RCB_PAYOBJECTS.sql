-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllPayObjects-09042017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_payobjects` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@KOD ,
@NAME ,
@ID_OLD ,
@UPDDATE ,
@USERID ,
@RequireFiscPrint ,
@RequireReference ,
@MaxDaysBefore ,
@SimpleMode 
) 
set 
ID=@ID ,
KOD=@KOD ,
NAME=upper(trim(@NAME)) ,
ID_OLD=@ID_OLD ,
UPDDATE=@UPDDATE ,
USERID=@USERID ,
RequireFiscPrint=@RequireFiscPrint ,
RequireReference=@RequireReference ,
MaxDaysBefore=@MaxDaysBefore ,
SimpleMode=@SimpleMode 
;

-- select * from rcb_payobjects;