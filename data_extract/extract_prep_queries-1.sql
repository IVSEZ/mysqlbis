select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR';

select * from rcbill.rcb_casa order by id desc limit 100;
select * from rcbill.rcb_invoicesheader order by id desc limit 100;
select * from rcbill.rcb_invoicescontents order by id desc  limit 100;

set @clid1 = 699807;
set @clid2 = 721746;
set @clid3 = 723711;
set @clid4 = 730174;
set @clid5 = 723959;
set @clid6 = 711581;
set @clid7 = 734460;
set @clid8 = 734440;
set @clid9 = 691038;
set @clid10 = 691038;
set @clid11 = 733908;
set @clid12 = 708755;


select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR';

set @kod1 = 'I14';
set @kod2 = 'I.000009787';
set @kod3 = 'I.000011750';
set @kod4 = 'I.000018187';
set @kod5 = 'I.000011998';
set @kod6 = 'I7';
set @kod7 = 'I.000021409';
set @kod8 = 'I.000021390';

set @kod9 = 'I9991';

set @kod10 = 'I.000021467';
set @kod11 = 'I.000020888';

select * from rcbill.rcb_tclients where kod in 
(@kod1,@kod2,@kod3,@kod4,@kod5,@kod6,@kod7,@kod8,@kod9,@kod10, @kod11)
;

select * from rcbill.rcb_tclients where fizlice in 
(2)
;

select fizlice, count(*) from rcbill.rcb_tclients
group by fizlice
;


select * from rcbill.rcb_contracts where 
clid in (select id from rcbill.rcb_tclients where 
kod in 
(@kod1,@kod2,@kod3,@kod4,@kod5,@kod6,@kod7,@kod8,@kod9,@kod10, @kod11)
)
;
select * from rcbill.clientcontractsservicepackageprice where clientcode='I9991';



set @kod9 = 'I.000011284';
set @kod9 = 'I.000020888';
set @kod9 = 'I7';


SELECT hard, count(*) from rcbill.rcb_invoicesheader group by hard;
SELECT type, count(*) from rcbill.rcb_invoicesheader group by type;


SELECT invoiceno, count(*) from rcbill.rcb_invoicesheader group by invoiceno;


-- ##cancellations =  hard not in (100, 101, 102) or hard is null
set @kod9 = 'I.000011750';
set @kod9 = 'I.000020888';

set @custid9 = 'CA_I.000020888';

select rcbill.GetClientID(@kod9) as clid;
set @clid9 = (select rcbill.GetClientID(@kod9));


select * from rcbill.rcb_casa where 
clid in (select id from rcbill.rcb_tclients where 
kod in 
(@kod9)
)
order by id desc
;

select * from rcbill.rcb_invoicesheader where 
clid in (select id from rcbill.rcb_tclients where 
kod in 
(@kod9)
)
order by id desc
;

select * from rcbill.rcb_invoicescontents where 
clid in (select id from rcbill.rcb_tclients where 
kod in 
(@kod9)
)
order by id desc
;





select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (@custid9)  order by ACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid9)  order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid9) order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid9);
select * from rcbill_extract.IV_SERVICEINSTANCECHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid9) );
select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid9) );
select * from rcbill_extract.IV_ADDON where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid9) );
select * from rcbill_extract.IV_ADDONCHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid9) );



select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where client_id in (@clid9);
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT_A1 where client_id in (@clid9);
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT2 where client_id in (@clid9);
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT3 where client_id in (@clid9);
select * from rcbill_extract.IV_PREP_BILLINGACCOUNT4 where client_id in (@clid9);

select * from rcbill_extract.IV_BILLINGACCOUNT where client_id in (@clid9);

select * from rcbill_extract.BILLINGACCOUNT_KEY where client_id in (@clid9);

/*
select 
a2.clientcode
, a2.contractcode
, a2.client_id
, a2.contract_id
, a2.BillingKey as a2_BillingKey
, a2.BillingAccountNumber_STG as a2_BillingAccountNumber_STG

, a3.BillingKey as a3_BillingKey
, a3.BillingAccountNumber_STG as a3_BillingAccountNumber_STG

, a4.BILLINGACCOUNTNUMBER as a4_BILLINGACCOUNTNUMBER
, a4.BillingAccountNumber_STG as a4_BillingAccountNumber_STG
, a4.BK4

, a.BILLINGACCOUNTNUMBER

from 
rcbill_extract.IV_PREP_BILLINGACCOUNT2 a2
inner join rcbill_extract.IV_PREP_BILLINGACCOUNT3 a3
on a2.BillingKey = a3.BillingKey


inner join rcbill_extract.IV_PREP_BILLINGACCOUNT4 a4
on a3.BillingAccountNumber_STG = a4.BillingAccountNumber_STG


inner join rcbill_extract.IV_BILLINGACCOUNT a 
on a4.BK4 = a.BK4

where a2.client_id in (@clid9);
;

*/

-- select * from rcbill.rcb_invoicesheader where AvanceUse>0;
select * 
, concat(a.BILLINGACCOUNTNUMBER,'-',a.DEBITDOCUMENTNUMBER,'-','.pdf') as INVOICE_PDF_NAME

from 
(

	select 
	-- *, 
		a.ID as INVOICESUMMARYID
		, a.INVOICENO as DEBITDOCUMENTNUMBER
		, a.DATA as CREATEDATE
		, a.SUMA as SUBTOTAL
		, a.DDS as TAX
		, a.DEBT as UNPAID
		, 0 as WRITEOFF
		, a.REASON as REMARK
		, a.DUEDATE as DUEDATE
		, a.TOTAL as TOTALDUE
		, 'N' as DISPUTED
		, a.UPDDATE as BILLDATE
		, 0 as SURCHARGE
		, a.RATE as SYSCURRENCYEXCHANGERATE
		, a.TOTAL as TOTALAMOUNT
		, a.SUMA as DISCOUNTABLE
		, a.Avance as DISCOUNTED
		, a.SUMA as TAXABLE
		, a.BEGDATE as FROMDATE
		, a.ENDDATE as TODATE
		, 0 as DEPOSIT
		-- , ifnull((select BILLINGACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID),concat('BA_', rcbill.GetClientCode(a.CLID))) as BILLINGACCOUNTNUMBER
		, ifnull((select BILLINGACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID),'NOT PRESENT') as BILLINGACCOUNTNUMBER
		, ifnull((select CUSTOMERACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID),'NOT PRESENT') as CUSTOMERACCOUNTNUMBER

		, a.TOTAL as ADJUSTEDAMOUNT 

		, ifnull((select BILLCYCLE from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID),'NOT PRESENT') as BILLCYCLE

		, a.Currency as CURRENCYALIAS
		, a.OriginalCurrency as ORIGINALCURRENCY
        , a.CREATOR as CREATEDBY
		, a.PROFORMANO as PROFORMAINVOICENUMBER
		, a.SRCNO as CREDITINVOICENUMBER
		, a.DKINO as DEBITINVOICENUMBER
		, a.TYPE as INVOICETYPE
		, a.HARD as INVOICEHARD
        , a.CLID as CLIENT_ID
        , a.CID as CONTRACT_ID
	from 

	rcbill.rcb_invoicesheader a 
	-- where clid in (select rcbill.GetClientID(CLIENTCODE) from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
	where clid in (@clid2)
    
) a 
;

-- select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid9) order by CUSTOMERACCOUNTNUMBER;
-- select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid9);

/*

discount = PRT13
subscription = PRT00
prepaid = PRT00
addon = PRT00
video on demand = PRT00
installation = PRT06
materials = PRT06
hardware = PRT06
other charges = PRT06
usage = PRT10
bundle = PRT00
convert contract = PRT99
MO BALANCE = PRT98

*/

select * from rcbill.rcb_invoicescontents a 
where InvoiceID in (select INVOICESUMMARYID from rcbill_extract.IV_BILLSUMMARY where CLIENT_ID in (@clid2)) -- ,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11))
;

select 
		a.ID as INVOICEDETAILID
        , a.InvoiceID as INVOICESUMMARYID
		, a.ID as SERIALNUMBER
		, a.INVOICENO as DEBITDOCUMENTNUMBER
        , a.TEXT as NAME
        , a.SCOST as RATE
        , a.NUMBER as ITEMCOUNT
        , a.COST as SUBTOTAL
        , a.CostVAT as TAX
        , a.DiscountCost as DISCOUNT
        , a.Discount as DISCOUNTPERCENT
        , a.CostTotal as TOTALAMOUNT
		, a.COST as DISCOUNTABLE
		, a.DiscountCost as DISCOUNTED
		, a.COST as TAXABLE
        , 0 as UNPAID
        , 0 as WRITEOFF
        , '' as REMARK
		, a.FROMDATE
        , a.TODATE
        
		/*
		, ifnull((select BILLINGACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as BILLINGACCOUNTNUMBER
		, ifnull((select CUSTOMERACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as CUSTOMERACCOUNTNUMBER
		, ifnull((select serviceinstancenumber from rcbill_extract.IV_SERVICEINSTANCE where client_id=a.CLID and contract_id=a.CID and servicerateid=a.RSID and serviceid=a.ServiceID limit 1),'NOT PRESENT') as SERVICEINSTANCENUMBER
		, ifnull((select BILLCYCLE from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as BILLCYCLE
		*/
		, case 
			   when (a.Discount <> 0 or a.DiscountCost <> 0) then 'PRT13' 
			   when a.TEXT like '%DISCOUNT%' then 'PRT13'
		       when a.TEXT like '%\%' then 'PRT13'
               when trim(a.TEXT) = 'VOUCHERS' then 'PRT13'
			   when a.TEXT like '%SUBSCRIPTION%' then 'PRT00'
			   when a.TEXT like '%PREPAID%' then 'PRT00'
			   when a.TEXT like '%ADDON%' then 'PRT00'
			   when a.TEXT like '%VIDEO ON DEMAND%' then 'PRT00'
			   when a.TEXT like 'TURQUOISE%' then 'PRT00'
               when trim(a.TEXT) = 'GVOICE' then 'PRT00'
               when trim(a.TEXT) = 'INDIAN CORPORATE' then 'PRT00'
               when trim(a.TEXT) = 'CAPPED INTERNET' then 'PRT00'
               when trim(a.TEXT) = 'ITERMIZED BILL' then 'PRT00'
			   when a.TEXT like '%INSTALLATION%' then 'PRT06'
			   when a.TEXT like '%MATERIALS%' then 'PRT06'
			   when a.TEXT like '%HARDWARE%' then 'PRT06'
			   when a.TEXT like '%OTHER CHARGES%' then 'PRT06'
			   when a.TEXT like 'RELOCATION%' then 'PRT06'
			   when a.TEXT like '%USAGE%' then 'PRT10'
			   when a.TEXT like '%BUNDLE%' then 'PRT00'
			   when trim(a.TEXT) = 'CONVERT CONTRACT' then 'PRT00'
			   when trim(a.TEXT) = 'MQ BALANCE' then 'PRT00'
               else '' end as `PRODUCTTYPEID`
		
        
        , case when a.TEXT like '%DEPOSIT%' then a.CostTotal
			else 0 end as DEPOSIT

		, case when ((a.Discount=0 and a.DiscountCost=0) and a.SCOST>a.COST) then 'Y' 
			else 'N' end as PRORATIONTYPE
		
        , a.CLID as CLIENT_ID
        , a.CID as CONTRACT_ID
        , a.RSID
        , a.ServiceID

from 
rcbill.rcb_invoicescontents a 

where a.InvoiceID in (select INVOICESUMMARYID from rcbill_extract.IV_BILLSUMMARY where CLIENT_ID in (@clid2)) -- ,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11))
-- limit 1000
-- where a.clid in (701369)
-- where clid in (select rcbill.GetClientID(CLIENTCODE) from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
-- where a.clid in (@clid1) -- ,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11)
;


-- select * from rcbill.rcb_invoicesheader where clid in (@clid9);


drop temporary table if exists tempt1;

create temporary table tempt1
(
	select id from rcbill.rcb_tclients order by id desc limit 10000
)
;

select * from rcbill.rcb_casa 
where CLID in 
-- (@clid2)
(select id from tempt1)
;


select 
		a.ID as PAYMENTRECEIPTID
		, ifnull((select BILLINGACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as BILLINGACCOUNTNUMBER
		, ifnull((select CUSTOMERACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as CUSTOMERACCOUNTNUMBER
		, ifnull((select serviceinstancenumber from rcbill_extract.IV_SERVICEINSTANCE where client_id=a.CLID and contract_id=a.CID and servicerateid=a.RSID and serviceid=(a.PAYTYPE*-1) limit 1),'NOT PRESENT') as SERVICEINSTANCENUMBER

		, a.PAYDATE as PAYMENTDATE
        , a.UPDDATE as PAYMENTPROCESSEDDATE
        , a.ZAB as PAYMENTDESC
        , 'SCR' as PAYMENTCURRENCYALIAS
        , (select name from rcbill.rcb_payobjects where id=a.PAYOBJECTID) as PAYMENTMODE
        , a.MONEY as PAYMENTTRANSACTIONAMOUNT
        , a.ID as SERIALNUMBER
        , a.INVID as DEBITDOCUMENTNUMBER
		, a.CLID as CLIENT_ID
        , a.CID as CONTRACT_ID
        , a.MONEY as PAYMENTAMOUNT
        , a.BankReference as PAYMENTREASON
        , '' as EXCHANGERATE
        , a.DiscountMoney as DISCOUNT
        , a.hard as INVOICEHARD
		, a.USERID AS EMPLOYEEID
		, (SELECT `NAME` FROM rcbill.rcb_tickettechusers where RCBUSERID=a.USERID LIMIT 1) as EMPLOYEENAME
		, (SELECT `NAME` FROM rcbill.rcb_tickettechregions where ID = (select TechRegionID from rcbill.rcb_tickettechusers where RCBUSERID=a.USERID LIMIT 1) LIMIT 1) AS EMPLOYEEDEPARTMENT

from rcbill.rcb_casa a 
where CLID in (select id from tempt1)
;


