use rcbill;


-- SET SESSION sql_mode = '';
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\callouts\\iv_callouts_26122019.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\callouts\\iv_callouts_27122019.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_useractions` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`iv_callouts` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 1 LINES 
(
@CALLDATETIME ,
@CLID ,
@CALLER ,
@CALLEE ,
@DCONTEXT ,
@CHANNEL ,
@DSTCHANNEL ,
@DURATION ,
@BILLSEC ,
@DISPOSITION ,
@DIRECTION ,
@EXTENSION ,
@OPERATOR ,
@CALLCOSTSCR  
) 
set 
CALLDATETIME=@CALLDATETIME ,
CALLDATE=date(@CALLDATETIME) ,
CLID=@CLID ,
CALLER=@CALLER ,
CALLEE=@CALLEE ,
DCONTEXT=@DCONTEXT ,
CHANNEL=@CHANNEL ,
DSTCHANNEL=@DSTCHANNEL ,
DURATION=@DURATION ,
BILLSEC=@BILLSEC ,
DISPOSITION=@DISPOSITION ,
DIRECTION=@DIRECTION ,
EXTENSION=@EXTENSION ,
OPERATOR=@OPERATOR ,
CALLCOSTSCR=@CALLCOSTSCR ,
CALLCOST=substring(@CALLCOSTSCR,5) ,

INSERTEDON=now()

;


-- select * from rcbill.iv_callouts where clid=717788;
select count(*) from rcbill.iv_callouts;

/*
select * from rcbill.iv_callouts where caller='266';
select * from rcbill.iv_callouts where operator='International';

select * from rcbill.iv_callouts order by callcost desc;



*/

select calldate
-- , hour(calldatetime) as call_hour
, caller, count(callee) as calls
from rcbill.iv_callouts 
where calldate>='2019-12-16'
group by 1,2
-- ,3
;
