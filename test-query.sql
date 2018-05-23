SELECT * FROM CLIENTS;

SELECT * FROM CLIENTS where clientname like 'rahul%';

truncate table clients;

select * from contracts;
select count(*) from contracts;
truncate table contracts;

select * from payments;

show warnings;

describe clients;

select distinct lastaction from contracts order by 1;

select * from contracts where 
lastaction like 'Open%';

select * from contracts where 
clientcode='I.000011750';

select * from payments where 
clientcode='I.000011750';

select a.clientcode, a.clientname, a.clientaddress, b.contractid,b.contracttype,b.contractdate,b.lastaction 
from 
clients a 
inner join 
contracts b 
on 
a.clientcode=b.clientcode


where 
-- a.clientcode='I.000011750'
 a.clientname like 'darrel%' 
 and 
 (b.lastaction like 'Open%' or b.lastaction = '' )
-- group by a.clientcode 
order by a.clientcode, b.contractdate asc;



select * from contracts where lastaction like 'Open%'
order by
--clientcode asc, 
contractdate desc;


select a.clientcode, a.clientname, b.contractid,b.contracttype,b.contractdate,b.lastaction,
c.paymentid,c.paymentdate,c.amount,c.paymentchannel,c.service,c.servicetype,c.debtfrom,c.debtto,c.clientclass,c.paymenttype 
from 
clients a 
inner join 
	contracts b 
	on 
	a.clientcode=b.clientcode

left join
	payments c 
	on 
	a.clientcode=c.clientcode

where 
 (b.lastaction like 'Open%' or b.lastaction = '' )
 
-- a.clientcode='I.000011750'
and 
 a.clientname like 'jim man%'
-- group by a.clientcode 
order by a.clientcode asc, b.contractid asc, b.contractdate desc;