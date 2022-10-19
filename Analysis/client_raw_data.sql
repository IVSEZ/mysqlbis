set @clcode='I.000006351'; -- Yannick
set @clcode='I.000011750'; -- Rahul
set @clcode='I21695';
set @clcode='I.000024581';
set @clcode='I.000020021';
set @clcode='I.000014455';
set @clcode='I.000024537';
set @clcode='I10006';
set @clcode='I15881';

set @clid = (select rcbill.GetClientID(@clcode));
set @clname = (select rcbill.GetClientName(@clcode));

select concat(@clcode,'|', @clid,'|', @clname) as CLIENT;

SELECT * FROM rcbill.rcb_paid_subscriptions where ClientCode=@clcode;
SELECT * FROM rcbill_my.rep_custconsolidated where clientcode=@clcode;

SELECT * FROM rcbill.clientcontractsservicepackageprice where clientcode=@clcode;




SELECT * FROM rcbill.rcb_tclients where ID=@clid;
SELECT * FROM rcbill.rcb_contracts where CLID=@clid;
SELECT * from rcbill.clientcontracts where CL_CLIENTCODE=@clcode;
SELECT * FROM rcbill.rcb_contractservices where CID=(2120059);
SELECT * FROM rcbill.rcb_contractslastaction;

SELECT * FROM rcbill_my.customercontractsnapshot where clientcode=@clcode;
SELECT * FROM rcbill.clientcontractssummary where CL_CLIENTCODE=@clcode;
SELECT * FROM rcbill.clientcontractssubs where cl_clientcode=@clcode;
SELECT * FROM rcbill.clientcontracthistory where CL_CLIENTCODE=@clcode;
SELECT * FROM rcbill.rcb_paid_subscriptions where ClientCode=@clcode order by CASA_ID desc;



SELECT * FROM rcbill.rcb_casa where CLID=@clid order by id desc;
SELECT * FROM rcbill.rcb_invoicesheader where CLID=@clid order by id desc;
SELECT * FROM rcbill.rcb_invoicescontents where CLID=@clid order by id desc;
SELECT * FROM rcbill.clientpayments where CLIENT_ID=@clid order by CASA_ID desc;
-- SELECT * FROM rcbill.rcb_contractservices where CID=2245531;


-- SELECT * FROM rcbill.clientcontractinvpmt where CL_CLIENTCODE=@clcode order by LastPaymentDate desc; 

select * from rcbill_my.customercontractactivity a where a.period='2022-10-06'; -- and a.clientcode=@clcode;

select a.* , b.*
from 
rcbill_my.customercontractactivity a 
left join 
rcbill.clientpayments b
on a.clientcode=b.clientcode and a.contractcode=b.contractcode and a.service=b.SUB_TYPE
and 
(
(a.period>=b.SUB_START_DATE_FPA and a.period<=SUB_END_DATE_FPA)

or

(a.period>=b.SUB_START_DATE and a.period<=SUB_END_DATE)

)
where a.period='2022-10-12'

and a.clientcode=@clcode
;



-- SELECT * FROM rcbill.rcb_contractservices limit 100;

-- select distinct type, hard from rcbill.rcb_invoicesheader where clid=@clid;

select a.contractcode,  a.servicecategory, a.servicecategory2, a.package
, b.SUB_START_DATE, b.SUB_END_DATE
, c.RATINGPLANNAME, c.CREDITPOLICYNAME, c.InvoicingDate

, date(d.BEGDATE) as SUB_START_DATE_FPA, date(d.ENDDATE) as SUB_END_DATE_FPA, d.ID_OLD, d.ORDERID, d.SRCNO, d.DKINO

from rcbill_my.customercontractsnapshot a 
left join
rcbill.rcb_paid_subscriptions b
on a.contractcode=b.ContractCode

left join 
rcbill_my.rep_cust_cont_creditpol c
on a.contractcode=c.CONTRACTCODE
and a.package=c.package


left join 
rcbill.rcb_invoicesheader d 
on b.CASA_ID=d.PaymentID and b.CONTRACT_ID=d.CID
and d.SRCNO=0 and d.DKINO=0


where a.clientcode=@clcode  
order by a.lastcontractdate desc, b.SUB_END_DATE desc, d.ENDDATE desc;




select a.*, b.* 
, date(d.BEGDATE) as SUB_START_DATE_FPA, date(d.ENDDATE) as SUB_END_DATE_FPA, d.ID_OLD, d.ORDERID, d.SRCNO, d.DKINO
from 
rcbill.clientcontractsservicepackageprice a 
left join 
rcbill.rcb_paid_subscriptions b 
on a.clientcode=b.clientcode
and a.contractcode=b.contractcode
and a.service=b.SUB_TYPE

left join 
rcbill.rcb_invoicesheader d 
on b.CASA_ID=d.PaymentID and b.CONTRACT_ID=d.CID
and d.SRCNO=0 and d.DKINO=0

where 0=0
and a.clientcode=@clcode
-- and a.contractstatus=1
-- and a.LASTACTION='OPEN'
and a.service like 'SUBSCRIPTION%'
-- and d.ENDDATE>=now()
order by b.PAYMENT_DATE desc
;


/*

SELECT * FROM rcbill.rcb_paid_subscriptions where ClientCode=@clcode order by CASA_ID desc;
SELECT * FROM rcbill.rcb_invoicesheader where CLID=@clid order by id desc;
SELECT a.* ,
date(b.BEGDATE) as SUB_START_DATE_FPA, date(b.ENDDATE) as SUB_END_DATE_FPA, b.ID_OLD, b.ORDERID, b.SRCNO, b.DKINO
FROM rcbill.rcb_paid_subscriptions a 
left join 
rcbill.rcb_invoicesheader b
on a.CASA_ID=b.PaymentID and a.CONTRACT_ID=b.CID
 where 0=0
 and a.ClientCode=@clcode 
 and b.SRCNO=0 and b.DKINO=0
 order by a.CASA_ID desc, b.ID desc;



select a.contractcode,  a.servicecategory, a.servicecategory2, a.package
, b.SUB_START_DATE, b.SUB_END_DATE
, c.RATINGPLANNAME, c.CREDITPOLICYNAME, c.InvoicingDate

from rcbill_my.customercontractsnapshot a 
left join
rcbill.rcb_paid_subscriptions b
on a.contractcode=b.ContractCode

left join 
rcbill_my.rep_cust_cont_creditpol c
on a.contractcode=c.CONTRACTCODE
and a.package=c.package

where a.clientcode=@clcode   
order by a.contractcode desc, a.lastcontractdate desc, b.SUB_END_DATE desc
;


select a.contractcode,  a.servicecategory, a.servicecategory2, a.package
, b.SUB_START_DATE, b.SUB_END_DATE
, c.RATINGPLANNAME, c.CREDITPOLICYNAME, c.InvoicingDate

, date(d.BEGDATE) as SUB_START_DATE_FPA, date(d.ENDDATE) as SUB_END_DATE_FPA, d.ID_OLD, d.ORDERID, d.SRCNO, d.DKINO

from rcbill_my.customercontractsnapshot a 
left join
rcbill.rcb_paid_subscriptions b
on a.contractcode=b.ContractCode

left join 
rcbill_my.rep_cust_cont_creditpol c
on a.contractcode=c.CONTRACTCODE
and a.package=c.package

left join 
rcbill.rcb_invoicesheader d 
on b.CASA_ID=d.PaymentID and b.CONTRACT_ID=d.CID
and d.SRCNO=0 and d.DKINO=0
where a.clientcode=@clcode   
order by a.contractcode desc, a.lastcontractdate desc, b.SUB_END_DATE desc
;


*/

