use rcbill_my;


drop table if exists lkpcontracttypenetwork;

CREATE TABLE `lkpcontracttypenetwork` (
  `CONTRACTTYPE` varchar(255) DEFAULT NULL, 
  `NETWORK` varchar(255) DEFAULT NULL
  
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;



LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/rcbill_my/contracttype_network.csv'
INTO TABLE rcbill_my.lkpcontracttypenetwork 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@contracttype,
@network
) 

set 
CONTRACTTYPE=trim(@contracttype),
NETWORK=trim(@network)
;


select * from rcbill_my.lkpcontracttypenetwork;


-- truncate table lkpservicetype;
