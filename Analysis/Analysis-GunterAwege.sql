/*
select * from rcbill.rcb_contracts limit 1000;
select * from rcbill.clientcontractdevices where mac='3c.1e.04.f3.8f.2c';

select distinct contracttype from rcbill.clientcontractdevices order by contracttype;

select * from rcbill.clientcontractdevices where ContractType='INTERNET, VOICE';

BUNDLE (CI)
BUNDLE (GPON)
CAPPED GNET
CAPPED INTERNET
GNET
INTERNET
*/



select tickettype, openreason, closereason, OpenRegion, StageRegion, date(opendate) as opendate, count(*) as tktcount 
from rcbill_my.clientticketsnapshot_irs 
where 
-- tickettype='Installation' 
-- and 
CloseReason is not null 
group by tickettype, openreason, closereason, OpenRegion, StageRegion, 6
order by 6 desc	;

select * from rcbill.clientcontractinvpmt;

select * from rcbill.rcb_invoicesheader where CLID=713492 ;
select * from rcbill.rcb_casa where clid=713492;

select * from rcbill.rcb_users where id=325226;

/*
select a.cl_clientname as clientname, a.cl_clientcode as clientcode, a.clientclass, a.clienttype, a.servicesubcategory, a.package, a.con_contractcode as contractcode
, a.enterdate as paymentdate, date(begdate) as substartdate, date(enddate) as subenddate
, count(distinct period) as activedaysfromsubstarttillnow , sum( distinct a.money) as amountpaid , a.zab as usercomments
from 
*/

select a.cl_clientname as clientname, a.cl_clientcode as clientcode, a.clientclass, a.clienttype, a.servicesubcategory, a.package, a.con_contractcode as contractcode
, a.enterdate as paymentdate, date(begdate) as substartdate, date(enddate) as subenddate
, a.zab as usercomments, a.user, a.invid, a.invoiceno
-- , count(distinct period) as activedaysfromsubstarttillnow 
, sum( distinct a.money) as amountpaid 
from 
(
	select a.cl_clientname, a.cl_clientcode, a.enterdate, a.begdate, a.enddate, a.con_contractcode, a.money, a.zab,a.invid, a.invoiceno, a.user, b.clientcode, b.clienttype, b.clientclass, b.contractcode, b.servicesubcategory, b.package, b.period
	from
	(
		select a.*,b.*, (select `INVOICENO` from rcbill.rcb_invoicesheader where id=b.invid ) as InvoiceNo, (select `name` from rcbill.rcb_users where id=b.userid ) as User , datediff(b.enddate,b.begdate) as period 
		from 
		rcbill.clientcontractinvpmt a  
		inner join 
		rcbill.rcb_casa b
		on 
		a.CL_CLIENTID=b.CLID
		and
		a.CON_CONTRACTID=b.CID
		where 
		(date(b.paydate)>='2017-09-29') -- and date(b.paydate)<='2017-11-17') 
		-- and date(begdate)>='2017-09-29' and datediff(b.enddate,b.begdate)>80 -- and b.clid=716653
		and
		cl_clientcode in ('I.000001680','I.000009645','I6033')
		order by cl_clientcode, con_contractcode, enterdate
	) a 
	inner join 
	rcbill_my.customercontractactivity b
	on 
	a.cl_clientcode=b.clientcode
	and
	a.con_contractcode=b.contractcode
	and 
	b.period>=a.begdate
	-- and b.clientclass in ('Residential')
	-- and b.clientclass not in ('Employee','Prepaid','Intelvision Office')
	order by b.period
) a 
where clientcode in ('I.000001680','I.000009645','I6033','')
group by 1,2,3,4,5,6,7,8,9,10, 11, 12, 13, 14
;
-- desc, period desc