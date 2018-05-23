use rcbill_my;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:/Workspace/IV/Work/RCB/Tables/lkpservicetype.csv'
INTO TABLE rcbill_my.lkpservicetype 
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@servicetype,
@servicenewtype
) 

set 
servicetype=trim(@servicetype),
servicenewtype=trim(@servicenewtype)
;


select * from lkpservicetype;


-- truncate table lkpservicetype;
