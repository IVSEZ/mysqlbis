-- SET SESSION sql_mode = '';
use rcbill_my;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\bestcas_inactive_22062017.csv'
REPLACE INTO TABLE `rcbill_my`.`bc_inactdevices` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@BESTCASID ,
@BESTCASC ,
@LASTACTIVEDATE  
) 
set 
BESTCASID=trim(@BESTCASID) ,
LASTACTIVEDATE=str_to_date(@LASTACTIVEDATE,'%Y-%m-%d %H:%i:%s') ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE 

;


CREATE INDEX IDXbcinact1
ON bc_inactdevices (BESTCASID);

select * from rcbill_my.bc_inactdevices;




