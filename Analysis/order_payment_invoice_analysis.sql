select * from rcbill_my.customercontractsnapshot where clientcode='I.000007447';

select * from rcbill_my.customercontractactivity where clientcode='I.000007447';

show index from rcbill.rcb_casa;
show index from rcbill.rcb_tclients;
show index from rcbill.rcb_invoicesheader;
show index from rcbill.rcb_invoicescontents;


select rcbill.GetClientID('I12119');
explain select rcbill.GetClientID('I.000005791');
explain select id from rcbill.rcb_tclients where kod ='I.000005791';



select * from rcbill.rcb_casa where clid=717742;

-- explain
select * , rcbill.GetPayType(paytype*-1) 
from rcbill.rcb_casa where CLID=717742 order by paydate desc limit 100;

-- explain
select * , rcbill.GetPayType(paytype*-1) 
from rcbill.rcb_casa where CLID=rcbill.GetClientID('I.000005791') order by paydate desc limit 100;

-- explain

select * from rcbill_my.sales where clientcode='I.000005791' order by orderdate desc;

select * from rcbill.rcb_invoicesheader 
where ORDERID in (select orderid from rcbill_my.sales where clientcode='I.000005791') order by id desc;
-- where clid=(select id from rcbill.rcb_tclients where kod ='I.000005791') order by id desc;

select * from rcbill.rcb_invoicescontents 
where INVOICENO in (select INVOICENO from rcbill.rcb_invoicesheader where ORDERID in (select orderid from rcbill_my.sales where clientcode='I.000005791'));
-- where clid=(select id from rcbill.rcb_tclients where kod ='I.000005791') order by id desc;

select * 
, rcbill.GetPayType(paytype*-1) as PayType_Name
, rcbill.GetPayObject(payobjectid) as PayObject_Name
, rcbill.GetCashPoint(cashpointID) as CashPoint_Name
from rcbill.rcb_casa where CLID=(select id from rcbill.rcb_tclients where kod ='I.000005791') order by paydate desc limit 100;


