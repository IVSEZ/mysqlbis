use rcbill_my;

-- DURATION 13.438 sec / 22818.187 sec

set @period = '2018-05-28';

drop temporary table if exists a;
create temporary table a (INDEX idxa1 (CL_CLIENTCODE), INDEX idxa2 (CON_CONTRACTCODE), INDEX idxa3 (S_SERVICENAME), INDEX idxa4 (VPNR_SERVICETYPE)) as 
(
	select a.*,b.name as CREDITPOLICYNAME, c.name as RATINGPLANNAME
	from 
	rcbill.clientcontracts a
	left join
	rcbill.rcb_creditpolicy b
	on a.con_creditpolicyid=b.id
	left join
	rcbill.rcb_ratingplans c 
	on a.con_ratingplanid=c.id
);

drop temporary table if exists b;
create temporary table b (INDEX idxb1 (clientcode), INDEX idxb2 (contractcode), INDEX idxb3 (service), INDEX idxb4 (package) ) as 
(
	select * from rcbill_my.customercontractactivity where period=@period and REPORTED='Y'
);



select a.*, b.*
from 
 b
left join 
 a
on 
upper(a.CL_CLIENTCODE)=upper(b.clientcode)
and 
upper(a.CON_CONTRACTCODE)=upper(b.contractcode)
and
upper(a.S_SERVICENAME)=upper(b.SERVICE)
and 
upper(a.VPNR_SERVICETYPE)=upper(b.package)

;