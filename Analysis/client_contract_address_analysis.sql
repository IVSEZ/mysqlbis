-- I.000013539
-- I.000011750

select * from rcbill.rcb_clientaddress where clientaddress like '%maca%' or clientaddress like '%mach%'; -- ='I.000013539';

select * from rcbill.rcb_contractaddress where clientcode='I.000013539';


select *
 from rcbill_my.salestoactive 
 where date(o_orderdate) = '2017-11-08'
order by o_orderday, o_clientcode, firstactivedateforcontract;


select a.*,b.ClientAddress,c.ContractAddress from 
(
select *
 from rcbill_my.salestoactive 
 where date(o_orderdate) >= '2017-09-01'
) a 
inner join 
rcbill.rcb_clientaddress  b 
on 
a.o_clientcode=b.clientcode

inner join 
rcbill.rcb_contractaddress c
on
a.o_contractcode=c.ContractCode
order by a.o_orderdate
;

