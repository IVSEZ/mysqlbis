use rcbill_my;

drop table if exists rcbill_my.payments_invoices_details;

create table rcbill_my.payments_invoices_details
(


/*
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
*/

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
-- where b.clid=@clid

-- order by b.id desc


select b.*, c.*
from

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
	-- where b.clid=@clid
	-- and b.HARD not in (100, 101, 102, 201, 999, 9999)
	-- and (b.SRCNO=0 and b.DKINO=0)
	order by b.id desc
) b 
-- on a.clientid=b.INVC_CLID and a.contractid=b.INVC_CID and a.CSID=b.INVC_CSID and a.period>=b.INVC_FROMDATE and a.period<=b.INVC_TODATE

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
    
    from rcbill.rcb_casa a -- where clid=@clid
) c
on b.INVC_CLID=c.CASA_CLID and b.INVC_CID=c.CASA_CID and b.INVC_RSID=c.CASA_RSID and b.INVC_FROMDATE=c.CASA_BegDate 
and b.INVC_TODATE=c.CASA_EndDate



)
;


-- select * from rcbill_my.payments_invoices_details order by INVH_REPORTDATE desc limit 1000;

CREATE INDEX IDXPID1
ON rcbill_my.payments_invoices_details (CASA_CID);

CREATE INDEX IDXCASA2
ON rcbill_my.payments_invoices_details (CASA_CLID);

CREATE INDEX IDXCASA3
ON rcbill_my.payments_invoices_details (INVC_CID);

CREATE INDEX IDXCASA4
ON rcbill_my.payments_invoices_details (INVC_CLID);

CREATE INDEX IDXCASA5
ON rcbill_my.payments_invoices_details (INVH_CID);

CREATE INDEX IDXCASA6
ON rcbill_my.payments_invoices_details (INVH_CLID);

CREATE INDEX IDXPID7
ON rcbill_my.payments_invoices_details (CASA_BEGDATE);

CREATE INDEX IDXCASA8
ON rcbill_my.payments_invoices_details (CASA_ENDDATE);

CREATE INDEX IDXPID9
ON rcbill_my.payments_invoices_details (CASA_RSID);




-- select * from rcbill.rcb_invoicesheader order by id desc;
-- select * from rcbill.rcb_invoicesheader order by id desc;
-- select * from rcbill_my.payments_invoices_details order by INVH_ID desc limit 10000;


select b.*, c.*
from

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
    b.PAYMENTID as INVH_PAYMENTID
    
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
	-- where b.clid=@clid
	-- and b.HARD not in (100, 101, 102, 201, 999, 9999)
	-- and (b.SRCNO=0 and b.DKINO=0)
	order by b.id desc
) b 
-- on a.clientid=b.INVC_CLID and a.contractid=b.INVC_CID and a.CSID=b.INVC_CSID and a.period>=b.INVC_FROMDATE and a.period<=b.INVC_TODATE

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
    
    from rcbill.rcb_casa a -- where clid=@clid
) c
on b.INVC_CLID=c.CASA_CLID and b.INVC_CID=c.CASA_CID and b.INVC_RSID=c.CASA_RSID and b.INVC_FROMDATE=c.CASA_BegDate 
and b.INVC_TODATE=c.CASA_EndDate

where 
date(b.INVH_DATA)>(select date(max(INVH_REPORTDATE)) from rcbill_my.payments_invoices_details)

;


/*
insert into rcbill_my.payments_invoices_details 
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

on c.clid=a.clid and c.cid=a.cid and c.rsid=a.rsid and c.fromdate=a.begdate and c.todate=a.enddate

where 
date(b.DATA)>(select date(max(INVH_REPORTDATE)) from rcbill_my.payments_invoices_details)

-- a.clid=@clid and c.cid=@cid

order by b.ID desc
)
;

*/