use rcbill_my;

## change dates on csv 4 files

 

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\OtherImport\\DHCP-HOSTS-08012018.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\OtherImport\\DHCP-HOSTS-16012018.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\OtherImport\\DHCP-HOSTS-24092018.csv'
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\OtherImport\\DHCP-HOSTS-25092018.csv'

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\OtherImport\\CRIMSON_TO_AMBER-HOSTS-15012018.csv'

REPLACE INTO TABLE `rcbill_my`.`dhcp_hosts` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@Id ,
@Host ,
@Name ,
@IPOLD ,
@Status ,
@Expiry ,
@MAC ,
@IP ,
@MAC2 ,
@IPOLD2 ,
@TYPE 
) 
set 
ID=@Id ,
HOST=@Host ,
NAME=@Name ,
IPOLD=@IPOLD ,
STATUS=@Status ,
EXPIRY=STR_TO_DATE(@Expiry,'%Y-%m-%dT%TZ') ,
CPE_MAC=@MAC ,
RELAY_IP=@IP ,
CM_MAC=@MAC2 ,
CLIENT_IP=@IPOLD2 ,
IP_POOL=@TYPE ,

INSERTEDON=now()

;


###################################################################

select *, REPLACE(IF(LENGTH(CM_MAC)>0, CM_MAC, CPE_MAC), ":", ".") as mac3 from rcbill_my.dhcp_hosts;

select * from rcbill_my.dhcp_hosts where expiry	is null;

select * from rcbill_my.dhcp_hosts where date(INSERTEDON) in (select date(max(INSERTEDON)) from rcbill_my.dhcp_hosts);

-- SET SQL_SAFE_UPDATES = 0;
-- delete from rcbill_my.dhcp_hosts where date(INSERTEDON)='2018-01-16';

