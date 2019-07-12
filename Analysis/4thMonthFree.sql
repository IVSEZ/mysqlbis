/*
select count(*) as contractdiscounts from rcbill.rcb_contractdiscounts;
select count(*) as clientcontractdiscounts from rcbill.clientcontractdiscounts;
select count(*) as clientcontractlastdiscount from rcbill.clientcontractlastdiscount;


select * from rcbill.rcb_contractdiscounts;

select * from rcbill.rcb_tclients where kod='I.000004707';
select * from rcbill.clientcontracts where CONTRACTCURRENTSTATUS='ACTIVE' and S_SERVICENAME like 'SUBSCRIPTION%' and cl_clientcode='I.000004707';
select * from rcbill.clientcontractssubs where cl_clientcode='I.000004707';

select *, datediff(enddate,begdate) as period  from rcbill.rcb_casa where date(paydate)>='2017-09-29' and clid=716653;

select * from rcbill.clientcontractinvpmt ;  

select *, datediff(b.enddate,b.begdate) as period from rcbill.rcb_casa b where date(b.paydate)>='2017-09-29' and datediff(b.enddate,b.begdate)>60;
 
*/

drop table if exists rcbill_my.fourmonthcustomers;
create table rcbill_my.fourmonthcustomers as 
(

select a.*,b.* , datediff(b.enddate,b.begdate) as period 
from 
rcbill.clientcontractinvpmt a  
inner join 
rcbill.rcb_casa b
on 
a.CL_CLIENTID=b.CLID
and
a.CON_CONTRACTID=b.CID
where 
 (date(b.paydate)>='2017-09-29' and date(b.paydate)<='2017-11-17')and date(begdate)>='2017-09-29' and datediff(b.enddate,b.begdate)>80 -- and b.clid=716653
order by money desc, period desc
)
;



select distinct cl_clientcode, con_contractcode from rcbill_my.fourmonthcustomers;


select b.reportdate, b.clientcode, b.currentdebt, b.IsAccountActive, b.AccountActivityStage
, b.clientname, b.clientclass, b.activenetwork, b.activeservices
, b.clientemail, b.clientphone
, b.firstactivedate, b.lastactivedate, b.dayssincelastactive
, b.totalpaymentamount, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018
from 
(
select distinct cl_clientcode from rcbill_my.fourmonthcustomers
) a
left join 
rcbill_my.rep_custconsolidated b
on 
a.cl_clientcode=b.clientcode
;

select * from rcbill_my.fourmonthcustomers
where cl_clientcode in ('I.000001680','I.000009645','I6033')
 order by cl_clientname;



select a.cl_clientname as clientname, a.cl_clientcode as clientcode, a.clientclass, a.clienttype, a.servicesubcategory, a.package, a.con_contractcode as contractcode
, a.enterdate as paymentdate, date(begdate) as substartdate, date(enddate) as subenddate
, count(distinct period) as activedaysfromsubstarttillnow , sum( distinct a.money) as amountpaid , a.zab as usercomments
from 
(
select a.cl_clientname, a.cl_clientcode, a.enterdate, a.begdate, a.enddate, a.con_contractcode, a.money, a.zab, b.clientcode, b.clienttype, b.clientclass, b.contractcode, b.servicesubcategory, b.package, b.period
from 
rcbill_my.fourmonthcustomers a
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
where clientcode in ('I.000001680','I.000009645','I6033')
group by 1,2,3,4,5,6,7,8,9,10
;


select b.clientname, b.clientcode, b.clienttype, b.clientclass, b.contractcode, b.servicesubcategory, b.package, count(distinct b.period) as activedays
from rcbill_my.customercontractactivity b
where 
b.period>='2017-10-01' and b.period<='2017-12-31'
-- and b.clientclass not in ('Employee','Prepaid','Intelvision Office')
and b.clientclass in ('Residential')
group by b.clientname, b.clientcode, b.clienttype, b.clientclass, b.contractcode, b.servicesubcategory, b.package
order by b.clientname
-- order by 8 desc
;

select * from 
(

select b.clientname, b.clientcode, b.clienttype, b.clientclass, b.contractcode, b.servicesubcategory, b.package, count(distinct b.period) as activedays
from rcbill_my.customercontractactivity b
where 
b.period>='2017-10-01' and b.period<='2017-12-31'
-- and b.clientclass not in ('Employee','Prepaid','Intelvision Office')
and b.clientclass in ('Residential')
group by b.clientname, b.clientcode, b.clienttype, b.clientclass, b.contractcode, b.servicesubcategory, b.package
order by b.clientname
-- order by 8 desc

) a
where a.activedays=92
;





-- TESTING

select * from
rcbill.clientcontractinvpmt 
where clientcode

select b.clientname, b.clientcode, b.clienttype, b.clientclass, b.contractcode, b.servicesubcategory, b.package, b.period
from rcbill_my.customercontractactivity b
where 
b.period>='2017-10-01' and b.period<='2017-12-31'
and clientname like 'Reza%'
-- group by b.clientname, b.clientcode, b.clienttype, b.clientclass, b.contractcode, b.servicesubcategory, b.package
-- order by 8 desc
;


select b.clientname, b.clientcode, b.clienttype, b.clientclass, b.contractcode, b.servicesubcategory, b.package, count(distinct b.period) as activedays
from rcbill_my.customercontractactivity b
where 
b.period>='2017-10-01' and b.period<='2017-12-31'
and
-- clientcode='I748'
-- clientcode='I.000004707'
clientcode='I.000011750' 
group by b.clientname, b.clientcode, b.clienttype, b.clientclass, b.contractcode, b.servicesubcategory, b.package
order by 8 desc
;

select * from rcbill_my.customercontractactivity where clientcode='I748' and period='2017-10-01';


select b.* from rcbill_my.clientstats b  where clientcode in (select CL_CLIENTCODE from rcbill_my.fourmonthcustomers);

select * from rcbill.rcb_tclients;
select * from rcbill_my.customercontractactivity where clientcode in ('I.000004707') and period>='2017-10-01 00:00:00';

select * from rcbill_my.customercontractactivity where clientcode in ('I.000001680') and period>='2017-11-11 00:00:00';

select clientcode, clienttype, clientclass,contractcode, servicesubcategory, package, count(*) as activedays from rcbill_my.customercontractactivity 
where clientcode in ('I.000001680') and period>='2017-11-11 00:00:00'
group by clientcode, clienttype, clientclass,contractcode, servicesubcategory, package
;
select b.* from rcbill_my.clientstats b  where clientcode in (select CL_CLIENTCODE from rcbill_my.fourmonthcustomers);

select * from rcbill.rcb_tclients;
select * from rcbill_my.customercontractactivity where clientcode in ('I.000004707') and period>='2017-10-01 00:00:00';

select * from rcbill_my.customercontractactivity where clientcode in ('I.000001680') and period>='2017-11-11 00:00:00';

select clientcode, clienttype, clientclass,contractcode, servicesubcategory, package, count(*) as activedays from rcbill_my.customercontractactivity 
where clientcode in ('I.000001680') and period>='2017-11-11 00:00:00'
group by clientcode, clienttype, clientclass,contractcode, servicesubcategory, package
;