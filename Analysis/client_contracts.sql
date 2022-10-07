set @clcode='I.000006351'; -- Yannick
set @clcode='I.000011750'; -- Rahul
set @clcode='I10670';
set @clcode='I.000020021';
set @clcode='I18761';
set @clid = (select rcbill.GetClientID(@clcode));

select concat(@clcode,'|', @clid) as CLIENT;

-- ==========================================================

#First get the active contract subs
SELECT * FROM rcbill.clientcontractssubs where cl_clientcode=@clcode;
select * from rcbill.clientcontractsservicepackageprice a where clientcode=@clcode;

SELECT * FROM rcbill.rcb_paid_subscriptions where ClientCode=@clcode and ( (SUB_START_DATE<=date(now()) and SUB_END_DATE>=date(now())) or (SUB_START_DATE>=date(now()) and SUB_END_DATE>=date(now())) );









	select a.ID as CASA_ID
	,a.ENTERDATE as PAYMENT_DATE
	, a.clid as CLIENT_ID, a.cid as CONTRACT_ID
    , rcbill.GetClientCode(a.clid) as ClientCode, rcbill.GetContractCode(a.cid) as ContractCode
	, a.MONEY as PAYMENT_AMOUNT
	, a.PAYTYPE
	, rcbill.GetPayType(a.PAYTYPE*-1) as SUB_TYPE
	, date(a.BegDate) as SUB_START_DATE
	, date(a.EndDate) as SUB_END_DATE
    
    , date(d.BEGDATE) as SUB_START_DATE_FPA, date(d.ENDDATE) as SUB_END_DATE_FPA, d.ID_OLD, d.ORDERID, d.SRCNO, d.DKINO
    
	from rcbill.rcb_casa a 
    
    left join 
	rcbill.rcb_invoicesheader d 
	on a.ID=d.PaymentID and a.CID=d.CID
    
	where 0=0 
    -- and a.CLID=718302
    -- and a.id>(select max(CASA_ID) from rcbill.rcb_paid_subscriptions)
	and (a.hard not in (100, 101, 102) or a.hard is null)
	and d.SRCNO=0 and d.DKINO=0

	order by a.ENTERDATE desc, a.clid asc
    ;




















#For the contract subs get the dates
select a.*, b.CASA_ID, b.PAYMENT_DATE, b.PAYMENT_AMOUNT, b.PAYTYPE, b.SUB_TYPE, b.SUB_START_DATE, b.SUB_END_DATE
-- , d.*
, date(d.BEGDATE) as SUB_START_DATE_FPA, date(d.ENDDATE) as SUB_END_DATE_FPA, d.ID_OLD, d.ORDERID, d.SRCNO, d.DKINO

, e.currency, e.RatingPlanName, e.CreditPolicyName, e.MaxInvDate, e.MinInvDate, e.LASTACTION, e.InvoicingDate, e.serviceinstancenumber, e.price
from 
rcbill.clientcontractssubs a 
left join 
rcbill.rcb_paid_subscriptions b 
on a.cl_clientcode=b.ClientCode and a.CON_CONTRACTCODE=b.ContractCode and a.S_SERVICENAME=b.SUB_TYPE


left join 
rcbill.rcb_invoicesheader d 
on b.CASA_ID=d.PaymentID and b.CONTRACT_ID=d.CID
and d.SRCNO=0 and d.DKINO=0

left join 
rcbill.clientcontractsservicepackageprice e
on a.cl_clientcode=e.clientcode and a.CON_CONTRACTCODE=e.contractcode and a.S_SERVICENAME=e.service


where a.cl_clientcode=@clcode
and ( (b.SUB_START_DATE<=date(now()) and b.SUB_END_DATE>=date(now())) or (b.SUB_START_DATE>=date(now()) and b.SUB_END_DATE>=date(now())) )

;






SELECT * FROM rcbill.clientcontractsservicepackageprice where clientcode=@clcode order by CONTRACT_ID desc;










SELECT * FROM rcbill.rcb_casa where CLID=@clid order by id desc;
SELECT * FROM rcbill.rcb_paid_subscriptions where ClientCode=@clcode;
-- SELECT * FROM rcbill_my.rep_custconsolidated where clientcode=@clcode;


select * from rcbill.rcb_contractservices where CID in (select ID from rcbill.rcb_contracts where CLID=@clid);

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
-- and a.clientcode=@clcode
-- and a.contractstatus=1
and a.LASTACTION='OPEN'
and a.service like 'SUBSCRIPTION%'
and d.ENDDATE>=now()
order by b.PAYMENT_DATE desc
;