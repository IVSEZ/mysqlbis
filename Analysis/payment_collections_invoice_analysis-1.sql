select * from rcbill_my.customers_contracts_collection_pivot;


select * from rcbill_my.dailyactivenumber where period='2020-12-31' and REPORTED='Y';

select * from rcbill_my.cust_cont_payment_cmts_mxk;

select * from rcbill_my.customers_collection where clientcode='I.000016472';

select * from rcbill_my.customers_collection where clientcode='I.000011750';


select * from rcbill_my.customers_collection where ContractCode='I.000294517';

set @clid=723711;
set @clid=728457;

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

/*
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
*/
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
-- left join 
-- rcbill.rcb_invoicescontents c 
-- on 
-- b.ID=c.InvoiceID

left join 
rcbill.rcb_casa a 

on 
-- b.PaymentID=a.id
 b.ID=a.INVID


-- where a.cid=2128300
-- where a.clid=728457
where b.clid=@clid


;


select * from rcbill_my.customers_collection where clientcode='I.000011750';