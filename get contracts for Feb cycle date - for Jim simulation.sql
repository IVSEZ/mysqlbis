#Contracts for Jim


#All customers whose contract end date is after 27 Jan 2017
select * from clientcontracts
where 
-- CONTRACTCURRENTSTATUS='ACTIVE'

-- and
CON_ENDDATE > str_to_date('2017-01-27','%Y-%m-%d')


;

#All customers whose contract end date is null but payment is made till after 27 Jan 2017
select a.*,b.*
from 
rcb_casa b
inner join
(
select * from clientcontracts
where 

CON_ENDDATE is null
) a

on b.CID=a.CON_CONTRACTID
and
b.enddate  > str_to_date('2017-01-27','%Y-%m-%d');
;