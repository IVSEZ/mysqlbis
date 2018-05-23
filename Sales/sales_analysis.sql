-- GET SALES ANALYIS
use rcbill_my;

select a.ORDERID, a.orderdate, a.ordertype, a.state,
a.clientcode, a.clientclass, a.contract, a.contracttype, a.servicetype, a.SERVICE,
a.cost, a.price, 
a.CLEANORIGCOST, a.CLEANORIGPRICE,
a.ORIGINALSERVICETYPE, a.ORIGINALSERVICE, a.ORIGINALCONTRACT,
a.SALESCENTER, a.SALESCHANNEL, a.CREATEDBY
,
b.cl_clientname

from rcbill_my.dailysales a
left join
rcbill.clientextendedreport b
on
a.CLIENTCODE=b.cl_clientcode

left join
rcbill_my.dailyactivenumber c 
on 
a.CONTRACT=c.CONTRACTCODE

where 
-- state in ('Completed::10','Open::0')
-- and 
-- a.CLIENTCODE='I.000015235'
a.CLIENTCODE='I.000015475'
order by orderdate, clientcode
;

select clientcode,contractcode,period,periodday,periodmth,periodyear,ACTIVECOUNT from rcbill_my.dailyactivenumber 
where 
-- CLIENTCODE='I.000015235' and CONTRACTCODE='I.000268181';
CLIENTCODE='I.000015475';

select * from rcbill_my.dailysales
where
state in ('Completed::10','Open::0')
and
servicetype='prepaid data 10'
order by orderdate desc, clientcode
;

select * from rcbill_my.dailysales
where
state in ('Completed::10','Open::0')
and
clientcode in ('I.000015063')
order by orderdate desc, clientcode
;

select * from rcbill_my.dailysales
where
state in ('Completed::10','Open::0')
and
servicetype='Intelenovela'
order by orderdate desc, clientcode
;

select * from rcbill_my.dailysales
where
state in ('Completed::10','Open::0')
and
clientcode in ('I21939')
order by orderdate desc, clientcode
;


select distinct date(orderdate) as orderdate, rcbill_my.GetCleanString(CREATEDBY) as createdby, rcbill_my.GetCleanString(ordertype) as ordertype, 
rcbill_my.GetCleanString(state) as state, count(*) as orders from rcbill_my.dailysales
where state in ('Completed::10','Open::0')
group by 1, CREATEDBY, ordertype, state 
order by 1 desc, CREATEDBY, ordertype, state;


select 
distinct date(orderdate) as orderdate, region, rcbill_my.GetCleanString(SALESCENTER) as SalesCenter, rcbill_my.GetCleanString(ordertype) as ordertype, 
rcbill_my.GetCleanString(state) as state, count(*) as orders from rcbill_my.dailysales
where state in ('Completed::10','Open::0')
group by 1, region, SALESCENTER, ordertype, state 
order by 1 desc, region, SALESCENTER, ordertype, state;


		select period
		, periodday
		, periodmth
		, periodyear
		, sum(open_s) as activecount  
		, sum(case when servicesubcategory = 'HFC' then open_s else 0 end) as HFC
		, sum(case when servicesubcategory = 'GPON' then open_s else 0 end) as GPON
        , sum(case when servicesubcategory = 'ADDON' then open_s else 0 end) as ADDON
		from 
		rcbill_my.anreport
		where reported='Y' and decommissioned='N';