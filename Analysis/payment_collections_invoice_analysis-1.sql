select * from rcbill_my.customers_contracts_collection_pivot;



select * from rcbill_my.cust_cont_payment_cmts_mxk;

select * from rcbill_my.customers_collection where clientcode='I.000016472';

select * from rcbill_my.customers_collection where clientcode='I.000011750';


select * from rcbill_my.customers_collection where ContractCode='I.000294517';

set @clid=723711;
set @clid=728457;
set @clid=711857;


select *, substring_index(activenumberid,'&CSID=',-1) from rcbill_my.dailyactivenumber where period='2021-02-10' and REPORTED='Y' and clientid=@clid;


select * from rcbill.rcb_invoicesheader where clid=@clid;
select * from rcbill.rcb_invoicescontents where clid=@clid;
select * from rcbill.rcb_casa where clid=@clid;
select a.ID as CASA_ID,
a.PAYOBJECTID as CASA_PAYOBJECTID,
a.PAYTYPE as CASA_PAYTYPE,
a.CashPointID as CASA_CashPointID,
a.CLID as CASA_CLID,
a.PAYDATE as CASA_PAYDATE,
a.MONEY as CASA_MONEY,
a.BankReference as CASA_BankReference,
a.ZAB as CASA_ZAB,
a.INVID as CASA_INVID,
a.ENTERDATE as CASA_ENTERDATE,
a.UPDDATE as CASA_UPDDATE,
a.USERID as CASA_USERID,
a.CID as CASA_CID,
a.BegDate as CASA_BegDate,
a.EndDate as CASA_EndDate,
a.RSID as CASA_RSID,
a.DiscountMoney as CASA_DiscountMoney,
a.REPORTDATE as CASA_REPORTDATE

from rcbill.rcb_casa where clid=@clid
group by 
;


select 
a.ID as CASA_ID,
a.PAYOBJECTID as CASA_PAYOBJECTID,
a.PAYTYPE as CASA_PAYTYPE,
a.CashPointID as CASA_CashPointID,
a.CLID as CASA_CLID,
a.PAYDATE as CASA_PAYDATE,
a.MONEY as CASA_MONEY,
a.BankReference as CASA_BankReference,
a.ZAB as CASA_ZAB,
a.INVID as CASA_INVID,
a.ENTERDATE as CASA_ENTERDATE,
a.UPDDATE as CASA_UPDDATE,
a.USERID as CASA_USERID,
a.CID as CASA_CID,
a.BegDate as CASA_BegDate,
a.EndDate as CASA_EndDate,
a.RSID as CASA_RSID,
a.DiscountMoney as CASA_DiscountMoney,
a.REPORTDATE as CASA_REPORTDATE
from rcbill.rcb_casa a 
where 
-- a.cid=2128300
a.clid=@clid

and year(a.PAYDATE)=2021
;

select 
b.ID as INVH_ID,
b.TYPE as INVH_TYPE,
b.HARD as INVH_HARD,
b.CLID as INVH_CLID,
b.CID as INVH_CID,
b.INVOICENO as INVH_INVOICENO,
b.ProformaNO as INVH_ProformaNO,
b.SRCNO as INVH_SRCNO,
b.DKINO as INVH_DKINO,
b.DATA as INVH_DATA,
b.REASON as INVH_REASON,
b.SUMA as INVH_SUMA,
b.DDS as INVH_DDS,
b.TOTAL as INVH_TOTAL,
b.DEBT as INVH_DEBT,
b.Avance as INVH_Avance,
b.AvanceUse as INVH_AvanceUse,
b.VATPercent as INVH_VATPercent,
b.CREATOR as INVH_CREATOR,
b.BEGDATE as INVH_BEGDATE,
b.ENDDATE as INVH_ENDDATE,
b.PaymentID as INVH_PaymentID,
b.Currency as INVH_Currency,
b.OriginalCurrency as INVH_OriginalCurrency,
b.Rate as INVH_Rate,
b.UPDDATE as INVH_UPDDATE,
b.USERID as INVH_USERID,
b.DueDate as INVH_DueDate,
b.REPORTDATE as INVH_REPORTDATE
from rcbill.rcb_invoicesheader b 
where 
-- b.cid=2128300
b.clid=@clid

and year(b.DATA)=2021
;


select  
c.ID as INVC_ID,
c.INVOICENO as INVC_INVOICENO,
c.CLID as INVC_CLID,
c.CID as INVC_CID,
c.CSID as INVC_CSID,
c.RID as INVC_RID,
c.RSID as INVC_RSID,
c.ServiceID as INVC_ServiceID,
c.RPDiscountID as INVC_RPDiscountID,
c.Discount as INVC_Discount,
c.NUMBER as INVC_NUMBER,
c.SCOST as INVC_SCOST,
c.COST as INVC_COST,
c.sumCost as INVC_sumCost,
c.FROMDATE as INVC_FROMDATE,
c.TODATE as INVC_TODATE,
c.ValidTill as INVC_ValidTill,
c.TEXT as INVC_TEXT,
c.ParentID as INVC_ParentID,
c.InvNo as INVC_InvNo,
c.CDRCOUNT as INVC_CDRCOUNT,
c.ID_OLD as INVC_ID_OLD,
c.UPDDATE as INVC_UPDDATE,
c.USERID as INVC_USERID,
c.InvoiceID as INVC_InvoiceID,
c.VAT as INVC_VAT,
c.CostVAT as INVC_CostVAT,
c.CostTotal as INVC_CostTotal,
c.DiscountCost as INVC_DiscountCost,
c.REPORTDATE as INVC_REPORTDATE

from rcbill.rcb_invoicescontents c 
where 
-- c.cid=2128300
c.clid=@clid
and year(c.UPDDATE)=2021
;


-- HARD= 101, 9999 (ANNULED)
-- HARD = 0 (CREDITED)
-- HARD = 1 (DEBIT)
-- TYPE = 11,21 (CREDIT OR DEBIT)
-- HARD NOT IN (100, 101, 102, 201, 999, 9999)

-- select * from rcbill_my.dailyactivenumber where CONTRACTID=2128300;

select 

	b.ID as INVH_ID,
	b.TYPE as INVH_TYPE,
	b.HARD as INVH_HARD,
	b.CLID as INVH_CLID,
	b.CID as INVH_CID,
	b.INVOICENO as INVH_INVOICENO,
	b.ProformaNO as INVH_ProformaNO,
	b.SRCNO as INVH_SRCNO,
	b.DKINO as INVH_DKINO,
	b.DATA as INVH_DATA,
	b.REASON as INVH_REASON,
	b.SUMA as INVH_SUMA,
	b.DDS as INVH_DDS,
	b.TOTAL as INVH_TOTAL,
	b.DEBT as INVH_DEBT,
	b.Avance as INVH_Avance,
	b.AvanceUse as INVH_AvanceUse,
	b.VATPercent as INVH_VATPercent,
	b.CREATOR as INVH_CREATOR,
	b.BEGDATE as INVH_BEGDATE,
	b.ENDDATE as INVH_ENDDATE,
	b.PaymentID as INVH_PaymentID,
	b.Currency as INVH_Currency,
	b.OriginalCurrency as INVH_OriginalCurrency,
	b.Rate as INVH_Rate,
	b.UPDDATE as INVH_UPDDATE,
	b.USERID as INVH_USERID,
	b.DueDate as INVH_DueDate,
	b.REPORTDATE as INVH_REPORTDATE


, 

	c.ID as INVC_ID,
	c.INVOICENO as INVC_INVOICENO,
	c.CLID as INVC_CLID,
	c.CID as INVC_CID,
	c.CSID as INVC_CSID,
	c.RID as INVC_RID,
	c.RSID as INVC_RSID,
	c.ServiceID as INVC_ServiceID,
	c.RPDiscountID as INVC_RPDiscountID,
	c.Discount as INVC_Discount,
	c.NUMBER as INVC_NUMBER,
	c.SCOST as INVC_SCOST,
	c.COST as INVC_COST,
	c.sumCost as INVC_sumCost,
	c.FROMDATE as INVC_FROMDATE,
	c.TODATE as INVC_TODATE,
	c.ValidTill as INVC_ValidTill,
	c.TEXT as INVC_TEXT,
	c.ParentID as INVC_ParentID,
	c.InvNo as INVC_InvNo,
	c.CDRCOUNT as INVC_CDRCOUNT,
	c.ID_OLD as INVC_ID_OLD,
	c.UPDDATE as INVC_UPDDATE,
	c.USERID as INVC_USERID,
	c.InvoiceID as INVC_InvoiceID,
	c.VAT as INVC_VAT,
	c.CostVAT as INVC_CostVAT,
	c.CostTotal as INVC_CostTotal,
	c.DiscountCost as INVC_DiscountCost,
	c.REPORTDATE as INVC_REPORTDATE

,
	a.ID as CASA_ID,
	a.PAYOBJECTID as CASA_PAYOBJECTID,
	a.PAYTYPE as CASA_PAYTYPE,
	a.CashPointID as CASA_CashPointID,
	a.CLID as CASA_CLID,
	a.PAYDATE as CASA_PAYDATE,
	a.MONEY as CASA_MONEY,
	a.BankReference as CASA_BankReference,
	a.ZAB as CASA_ZAB,
	a.INVID as CASA_INVID,
	a.ENTERDATE as CASA_ENTERDATE,
	a.UPDDATE as CASA_UPDDATE,
	a.USERID as CASA_USERID,
	a.CID as CASA_CID,
	a.BegDate as CASA_BegDate,
	a.EndDate as CASA_EndDate,
	a.RSID as CASA_RSID,
	a.DiscountMoney as CASA_DiscountMoney,
	a.REPORTDATE as CASA_REPORTDATE


from 
rcbill.rcb_invoicesheader b 
 left join 
 rcbill.rcb_invoicescontents c 
 on 
 b.ID=c.InvoiceID and b.clid=c.clid and b.cid=c.cid

 left join 
 rcbill.rcb_casa a 

on a.clid=c.clid and a.cid=c.cid and a.rsid=c.rsid and a.begdate=c.fromdate and a.enddate=c.todate
-- on 
-- b.PaymentID=a.id
--  b.ID=a.INVID

/*
rcbill.rcb_casa a 
left join 
rcbill.rcb_invoicescontents c 
on 
a.clid=c.clid and a.cid=c.cid and a.rsid=c.rsid

left join 
rcbill.rcb_invoicesheader b
on c.InvoiceId=b.Id
*/



-- where a.cid=2128300
-- where a.clid=728457
where b.clid=@clid

order by b.id desc
;


select * from rcbill_my.customers_collection where clientcode='I.000011750';

set @clid=723711;
set @cid=2124054; -- perf
set @cid=2021585; -- tv
set @cid=2089984; -- amber


set @clid=728457;
set @cid=2128298; -- for bu package
set @cid=2128300; -- for remote control


set @clid=700468; -- coreen belise


select * from rcbill.rcb_invoicesheader where clid=@clid 
-- and cid=@cid 
order by id desc;
select * from rcbill.rcb_invoicescontents where clid=@clid
-- and cid=@cid 
order by id desc;
select * from rcbill.rcb_casa where clid=@clid 
-- and cid=@cid 
order by id desc;


select a.*, b.*
from 
rcbill.rcb_invoicesheader a 
inner join 
rcbill.rcb_invoicescontents b 
on 
a.INVOICENO=b.INVOICENO
where a.clid=@clid
and a.HARD not in (100, 101, 102, 201, 999, 9999)
and (a.SRCNO=0 and a.DKINO=0)
order by a.id desc
;

select *, substring_index(activenumberid,'&CSID=',-1) as CSID from rcbill_my.dailyactivenumber where period='2021-02-10' and REPORTED='Y' and clientid=@clid;

select a.*
, b.*
, c.*
from 
(
	select *, substring_index(activenumberid,'&CSID=',-1) as CSID 
    from rcbill_my.dailyactivenumber where period='2021-02-10' and REPORTED='Y' and clientid=@clid
) a 
left join 
(
	select * from rcbill.rcb_invoicescontents where clid=@clid order by id desc
) b 
on a.clientid=b.clid and a.contractid=b.cid and a.CSID=b.csid and a.period>=b.FROMDate and a.period<=b.TODATE

left join 
(
	select * from rcbill.rcb_casa where clid=@clid
) c
on b.clid=c.clid and b.cid=c.cid and b.rsid=c.rsid and b.FROMDATE=c.BegDate and b.TODATE=c.EndDate
;


select a.*
, b.*
, c.*
from 
(
	select period, CLIENTID, CONTRACTID, CLIENTCODE, CONTRACTCODE, CONTRACTSTARTDATE, CONTRACTENDDATE, CONTRACTSTATE, LASTACTION
    , LASTCHANGE, ACTIVECOUNT, DEVICESCOUNT
    , CLIENTNAME, CLIENTCLASS, CLIENTTYPE
    , SERVICE, SERVICECATEGORY, SERVICESUBCATEGORY, SERVICETYPE
    , PRICE, REGION, REPORTED     
    , substring_index(activenumberid,'&CSID=',-1) as CSID 
    from rcbill_my.dailyactivenumber where 
    -- period='2021-02-10' and 
    REPORTED='Y' and clientid=@clid
) a 
left join 
(
	select 
	b.ID as INVH_ID,
	b.TYPE as INVH_TYPE,
	b.HARD as INVH_HARD,
	b.CLID as INVH_CLID,
	b.CID as INVH_CID,
	b.INVOICENO as INVH_INVOICENO,
	b.ProformaNO as INVH_ProformaNO,
	b.SRCNO as INVH_SRCNO,
	b.DKINO as INVH_DKINO,
	b.DATA as INVH_DATA,
	b.REASON as INVH_REASON,
	b.SUMA as INVH_SUMA,
	b.DDS as INVH_DDS,
	b.TOTAL as INVH_TOTAL,
	b.DEBT as INVH_DEBT,
	b.Avance as INVH_Avance,
	b.AvanceUse as INVH_AvanceUse,
	b.VATPercent as INVH_VATPercent,
	b.CREATOR as INVH_CREATOR,
	b.BEGDATE as INVH_BEGDATE,
	b.ENDDATE as INVH_ENDDATE,
	b.PaymentID as INVH_PaymentID,
	b.Currency as INVH_Currency,
	b.OriginalCurrency as INVH_OriginalCurrency,
	b.Rate as INVH_Rate,
	b.UPDDATE as INVH_UPDDATE,
	b.USERID as INVH_USERID,
	b.DueDate as INVH_DueDate,
	b.REPORTDATE as INVH_REPORTDATE
    
    , 
	c.ID as INVC_ID,
	c.INVOICENO as INVC_INVOICENO,
	c.CLID as INVC_CLID,
	c.CID as INVC_CID,
	c.CSID as INVC_CSID,
	c.RID as INVC_RID,
	c.RSID as INVC_RSID,
	c.ServiceID as INVC_ServiceID,
	c.RPDiscountID as INVC_RPDiscountID,
	c.Discount as INVC_Discount,
	c.NUMBER as INVC_NUMBER,
	c.SCOST as INVC_SCOST,
	c.COST as INVC_COST,
	c.sumCost as INVC_sumCost,
	c.FROMDATE as INVC_FROMDATE,
	c.TODATE as INVC_TODATE,
	c.ValidTill as INVC_ValidTill,
	c.TEXT as INVC_TEXT,
	c.ParentID as INVC_ParentID,
	c.InvNo as INVC_InvNo,
	c.CDRCOUNT as INVC_CDRCOUNT,
	c.ID_OLD as INVC_ID_OLD,
	c.UPDDATE as INVC_UPDDATE,
	c.USERID as INVC_USERID,
	c.InvoiceID as INVC_InvoiceID,
	c.VAT as INVC_VAT,
	c.CostVAT as INVC_CostVAT,
	c.CostTotal as INVC_CostTotal,
	c.DiscountCost as INVC_DiscountCost,
	c.REPORTDATE as INVC_REPORTDATE
	
    from 
	rcbill.rcb_invoicesheader b 
	inner join 
	rcbill.rcb_invoicescontents c 
	on 
	b.INVOICENO=c.INVOICENO
	where b.clid=@clid
	and b.HARD not in (100, 101, 102, 201, 999, 9999)
	-- and (b.SRCNO=0 and b.DKINO=0)
	order by b.id desc
) b 
on a.clientid=b.INVC_CLID and a.contractid=b.INVC_CID and a.CSID=b.INVC_CSID and a.period>=b.INVC_FROMDATE and a.period<=b.INVC_TODATE

left join 
(
	select 
	a.ID as CASA_ID,
	a.PAYOBJECTID as CASA_PAYOBJECTID,
	a.PAYTYPE as CASA_PAYTYPE,
	a.CashPointID as CASA_CashPointID,
	a.CLID as CASA_CLID,
	a.PAYDATE as CASA_PAYDATE,
	a.MONEY as CASA_MONEY,
	a.BankReference as CASA_BankReference,
	a.ZAB as CASA_ZAB,
	a.INVID as CASA_INVID,
	a.ENTERDATE as CASA_ENTERDATE,
	a.UPDDATE as CASA_UPDDATE,
	a.USERID as CASA_USERID,
	a.CID as CASA_CID,
	a.BegDate as CASA_BegDate,
	a.EndDate as CASA_EndDate,
	a.RSID as CASA_RSID,
	a.DiscountMoney as CASA_DiscountMoney,
	a.REPORTDATE as CASA_REPORTDATE 
    
    from rcbill.rcb_casa a where clid=@clid
) c
on b.INVC_CLID=c.CASA_CLID and b.INVC_CID=c.CASA_CID and b.INVC_RSID=c.CASA_RSID and b.INVC_FROMDATE=c.CASA_BegDate 
and b.INVC_TODATE=c.CASA_EndDate
;


-- HARD= 101, 9999 (ANNULED)
-- HARD = 0 (CREDITED)
-- HARD = 1 (DEBIT)
-- TYPE = 11,21 (CREDIT OR DEBIT)
-- HARD NOT IN (100, 101, 102, 201, 999, 9999)





select clid, cid, rsid, userid, paydate, begdate, enddate,  sum(money) from rcbill.rcb_casa where clid=@clid and cid=@cid and hard is null group by clid, cid, rsid, userid, paydate, begdate, enddate order by id desc;

select hard, sum(money) from rcbill.rcb_casa where clid=@clid and cid=@cid group by hard order by id desc;

select a.*, b.*
from 
rcbill.rcb_invoicescontents a 
left join 
-- rcbill.rcb_casa b 
(
	select clid, cid, rsid, userid, paydate, begdate, enddate,  sum(money) from rcbill.rcb_casa where clid=@clid and cid=@cid and hard is null group by clid, cid, rsid, userid, paydate, begdate, enddate order by id desc
) b
 on 
 a.clid=b.clid and a.cid=b.cid -- and a.rsid=b.rsid
 -- and b.id=a.id_old
 and a.fromdate=b.begdate and a.todate=b.enddate
 where a.clid=@clid and a.cid=@cid 
 
 order by a.id desc;
 ;



select 

	b.ID as INVH_ID,
	b.TYPE as INVH_TYPE,
	b.HARD as INVH_HARD,
	b.CLID as INVH_CLID,
	b.CID as INVH_CID,
	b.INVOICENO as INVH_INVOICENO,
	b.ProformaNO as INVH_ProformaNO,
	b.SRCNO as INVH_SRCNO,
	b.DKINO as INVH_DKINO,
	b.DATA as INVH_DATA,
	b.REASON as INVH_REASON,
	b.SUMA as INVH_SUMA,
	b.DDS as INVH_DDS,
	b.TOTAL as INVH_TOTAL,
	b.DEBT as INVH_DEBT,
	b.Avance as INVH_Avance,
	b.AvanceUse as INVH_AvanceUse,
	b.VATPercent as INVH_VATPercent,
	b.CREATOR as INVH_CREATOR,
	b.BEGDATE as INVH_BEGDATE,
	b.ENDDATE as INVH_ENDDATE,
	b.PaymentID as INVH_PaymentID,
	b.Currency as INVH_Currency,
	b.OriginalCurrency as INVH_OriginalCurrency,
	b.Rate as INVH_Rate,
	b.UPDDATE as INVH_UPDDATE,
	b.USERID as INVH_USERID,
	b.DueDate as INVH_DueDate,
	b.REPORTDATE as INVH_REPORTDATE


, 

	c.ID as INVC_ID,
	c.INVOICENO as INVC_INVOICENO,
	c.CLID as INVC_CLID,
	c.CID as INVC_CID,
	c.CSID as INVC_CSID,
	c.RID as INVC_RID,
	c.RSID as INVC_RSID,
	c.ServiceID as INVC_ServiceID,
	c.RPDiscountID as INVC_RPDiscountID,
	c.Discount as INVC_Discount,
	c.NUMBER as INVC_NUMBER,
	c.SCOST as INVC_SCOST,
	c.COST as INVC_COST,
	c.sumCost as INVC_sumCost,
	c.FROMDATE as INVC_FROMDATE,
	c.TODATE as INVC_TODATE,
	c.ValidTill as INVC_ValidTill,
	c.TEXT as INVC_TEXT,
	c.ParentID as INVC_ParentID,
	c.InvNo as INVC_InvNo,
	c.CDRCOUNT as INVC_CDRCOUNT,
	c.ID_OLD as INVC_ID_OLD,
	c.UPDDATE as INVC_UPDDATE,
	c.USERID as INVC_USERID,
	c.InvoiceID as INVC_InvoiceID,
	c.VAT as INVC_VAT,
	c.CostVAT as INVC_CostVAT,
	c.CostTotal as INVC_CostTotal,
	c.DiscountCost as INVC_DiscountCost,
	c.REPORTDATE as INVC_REPORTDATE

,
	a.ID as CASA_ID,
	a.PAYOBJECTID as CASA_PAYOBJECTID,
	a.PAYTYPE as CASA_PAYTYPE,
	a.CashPointID as CASA_CashPointID,
	a.CLID as CASA_CLID,
	a.PAYDATE as CASA_PAYDATE,
	a.MONEY as CASA_MONEY,
	a.BankReference as CASA_BankReference,
	a.ZAB as CASA_ZAB,
	a.INVID as CASA_INVID,
	a.ENTERDATE as CASA_ENTERDATE,
	a.UPDDATE as CASA_UPDDATE,
	a.USERID as CASA_USERID,
	a.CID as CASA_CID,
	a.BegDate as CASA_BegDate,
	a.EndDate as CASA_EndDate,
	a.RSID as CASA_RSID,
	a.DiscountMoney as CASA_DiscountMoney,
	a.REPORTDATE as CASA_REPORTDATE


from 
rcbill.rcb_invoicesheader b 
 left join 
 rcbill.rcb_invoicescontents c 
 on 
 b.ID=c.InvoiceID and b.clid=c.clid and b.cid=c.cid

 left join 
 rcbill.rcb_casa a 

on a.clid=c.clid and a.cid=c.cid and a.rsid=c.rsid and a.begdate=c.fromdate and a.enddate=c.todate

where 
-- b.DATA>(select max(INVH_REPORTDATE) from rcbill_my.payments_invoices_details)

a.clid=@clid and c.cid=@cid

order by b.ID desc
;




select * from rcbill_my.payments_invoices_details where CASA_CLID=@clid and CASA_CID=@cid order by CASA_PAYDATE desc;
select * from rcbill_my.dailyactivenumber where clientid=@clid and CONTRACTID=@cid order by period desc;


select 

a.*
, b.* 

from 
rcbill_my.dailyactivenumber a 

left join 

rcbill_my.payments_invoices_details b

on a.clientid=b.CASA_CLID and a.CONTRACTID=b.CASA_CID
and a.period>=b.CASA_BEGDATE and a.period<=b.CASA_ENDDATE
-- and trim(concat(upper(a.SERVICE),'-',upper(a.SERVICETYPE)))=trim(upper(b.INVC_TEXT))
-- and b.INVC_TEXT not like ()

where a.clientid=@clid and a.contractid=@cid

order by a.period desc
;
 
 
 