 set @mxkname='MXK-BEAUVALLON';

select reportdate
-- , network
, clean_connection_type
-- , clean_hfc_nodename
, clientlocation
, clean_mxk_name, count(distinct clientcode) as distinctclients 
, sum(activecontracts) as activecontracts
from 
rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2
where 
firstactivedate is not null and lastactivedate is not null
 and
 (clean_mxk_name = @mxkname or clean_mxk_name is null)

and lastactivedate=reportdate
group by 1,2,3, 4 -- , 5
order by reportdate desc
;

select reportdate, clientcode, clientname, clientclass, activecontracts, clientlocation, connection_type, clean_mxk_name, clean_connection_type
from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2 
where  (clean_mxk_name = @mxkname or clean_mxk_name is null)
and clean_connection_type not in ('HFC')
;


-- select * from rcbill_my.customercontractactivity where clientcode='I.000000095';
-- select * from rcbill_my.customercontractsnapshot where clientcode='I.000000095';

select period, clientcode, group_concat( distinct servicecategory order by servicecategory asc separator '|') as services
from rcbill_my.customercontractactivity where clientcode='I.000000095'
group by 1,2
;

-- set session group_concat_max_len = 30000;

--         , group_concat( distinct VPNR_SERVICETYPE order by S_SERVICENAME asc separator '~') as packageinfo

drop table if exists rcbill_my.a;

create table rcbill_my.a (index idxa1(period), index idxa2(clientcode)) as 
(
select * from 
rcbill_my.customercontractactivity 
where 
clientcode in (select distinct clientcode 	from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2 
where  (clean_mxk_name = @mxkname or clean_mxk_name is null)
and clean_connection_type not in ('HFC'))

and period in ('2019-02-03','2019-06-02','2019-06-25','2019-09-30')

)
;

drop table if exists rcbill_my.b;
create table rcbill_my.b (index idxb1(reportdate(20)), index idxb2(clientcode)) as 
(
	select reportdate, clientcode, clientname, clientclass, activecontracts, clientlocation, connection_type, clean_mxk_name, clean_connection_type
	from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2 
	where  (clean_mxk_name = @mxkname or clean_mxk_name is null)
	and clean_connection_type not in ('HFC')
);


select a.*, b.servicecategory
-- , group_concat( distinct b.servicecategory order by b.servicecategory asc separator '|') as services
from 
 rcbill_my.b as a 
inner join 

 rcbill_my.a as b

on 
a.reportdate=b.period
and a.clientcode=b.clientcode
;

select a.reportdate, a.clientlocation, a.connection_type, a.clean_mxk_name, a.clean_connection_type
, count(a.clientcode) as clients
, group_concat( distinct a.servicecategory order by a.servicecategory asc separator '|') as services
from
(
	select a.*, b.servicecategory
	-- , group_concat( distinct b.servicecategory order by b.servicecategory asc separator '|') as services
	from 
	 rcbill_my.b as a 
	inner join 

	 rcbill_my.a as b

	on 
	a.reportdate=b.period
	and a.clientcode=b.clientcode

) a 

group by 1,2,3,4,5
;


select distinct clientcode 	from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2 
where  (clean_mxk_name = @mxkname or clean_mxk_name is null)
and clean_connection_type not in ('HFC');

select distinct reportdate 
from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2 
where  (clean_mxk_name = @mxkname or clean_mxk_name is null)
and clean_connection_type not in ('HFC')
;

/*
(
select period, clientcode, group_concat( distinct servicecategory order by servicecategory asc separator '|') as services
from rcbill_my.customercontractactivity 
-- where clientcode='I.000000095'
group by 1,2

)
*/
 