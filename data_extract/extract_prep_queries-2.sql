use rcbill_extract;


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
set @clid11 = 708755;



select * from rcbill.rcb_contracts where clid in (@clid1,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11) order by id desc;
select * from rcbill.rcb_invoicesheader where CLID in (@clid1,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11) order by id desc;


drop temporary table if exists tempt1;

create temporary table tempt1 (index idx1(id))
(
	select id, invoicingdate from rcbill.rcb_contracts 
)
;

drop temporary table if exists tempt2;

create temporary table tempt2 (index idx1(cid))
(
	select id, cid, data as INVOICEDATE from rcbill.rcb_invoicesheader 
)
;

select 
a.BILLINGACCOUNTNUMBER
, a.LASTBILLINGDATE
, case when a.ACCOUNTSTATUS=1 and a.BILLCYCLE<>'DEFAULT' then date_add(LASTBILLINGDATE, interval 1 month) end as NEXTBILLINGDATE
, a.BILLCYCLE
, a.ACCOUNTSTATUS
, a.BILLINGDAY
from 
(
	select 
    a.BILLINGACCOUNTNUMBER
    , a.BILLCYCLE, a.ACCOUNTSTATUS
	-- , (select InvoicingDate from rcbill.rcb_contracts where id=a.contract_id order by id desc limit 1) as BILLINGDAY
    , (select InvoicingDate from tempt1 where id=a.contract_id order by id desc limit 1) as BILLINGDAY
	-- , (select data from rcbill.rcb_invoicesheader where cid=a.contract_id order by id desc limit 1) as LASTBILLINGDATE
    , (select INVOICEDATE from tempt2 where cid=a.contract_id order by id desc limit 1) as LASTBILLINGDATE
	  

	from rcbill_extract.IV_BILLINGACCOUNT a 
	-- where client_id in (@clid1,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11)
) a 
;

select count(*) as contractdiscounts from rcbill.rcb_contractdiscounts;
select count(*) as clientcontractdiscounts from rcbill.clientcontractdiscounts;
select count(*) as clientcontractlastdiscount from rcbill.clientcontractlastdiscount;


select * from rcbill.rcb_contractdiscounts;
select * from rcbill.clientcontractdiscounts;
select * from rcbill.clientcontractlastdiscount;


set @kod1 = 'I.000021721';
set @kod1 = 'I.000011750';

set @custid1='CA_I.000021721';
set @custid1='CA_I.000011750';
select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1);
select * from rcbill_extract.BILLINGACCOUNT_KEY where CUSTOMERACCOUNTNUMBER in (@custid1);
select * from rcbill_extract.IV_NBD where CUSTOMERACCOUNTNUMBER in (@custid1);
select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1);
select * from rcbill_extract.IV_SERVICEINSTANCECHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_ADDON where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_ADDONCHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_BILLSUMMARY where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID;
select * from rcbill_extract.IV_PAYMENTHISTORY where CUSTOMERACCOUNTNUMBER in (@custid1) order by PAYMENTRECEIPTID;
select * from rcbill_extract.IV_DISCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1) order by BILLINGACCOUNTNUMBER;

	select
    -- a.*,
    a.BILLINGACCOUNTNUMBER
    , a.CUSTOMERACCOUNTNUMBER
    -- , d.SERVICEINSTANCENUMBER
    , a.BILLCYCLE, a.ACCOUNTSTATUS
	, b.servicename as SERVICENAME, b.percent as DISCOUNTPERCENT, b.amount as DISCOUNTAMOUNT, b.approved as APPROVEDSTATUS, b.approvalreason as APPROVALREASON
    , 0 as CYCLECOUNT
    , c.client_id, c.contract_id
	from rcbill_extract.IV_BILLINGACCOUNT a 
	-- where client_id in (@clid1,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11)
    inner join rcbill_extract.BILLINGACCOUNT_KEY c 
    on a.BILLINGACCOUNTNUMBER=c.BILLINGACCOUNTNUMBER
    inner join
    rcbill.clientcontractdiscounts b 
    on c.client_id=b.clientid and c.contract_id=b.contractid
    
    where a.CUSTOMERACCOUNTNUMBER in (@custid1)
    ;
    
select a.*
, d.SERVICEINSTANCENUMBER
from 
(
	select
    -- a.*,
    a.BILLINGACCOUNTNUMBER
    , a.CUSTOMERACCOUNTNUMBER
    -- , d.SERVICEINSTANCENUMBER
    , a.BILLCYCLE, a.ACCOUNTSTATUS
	, b.servicename as SERVICENAME, b.percent as DISCOUNTPERCENT, b.amount as DISCOUNTAMOUNT, b.approved as APPROVEDSTATUS, b.approvalreason as APPROVALREASON
    , 0 as CYCLECOUNT
    , c.client_id, c.contract_id
	from rcbill_extract.IV_BILLINGACCOUNT a 
	-- where client_id in (@clid1,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11)
    inner join rcbill_extract.BILLINGACCOUNT_KEY c 
    on a.BILLINGACCOUNTNUMBER=c.BILLINGACCOUNTNUMBER
    inner join
    rcbill.clientcontractdiscounts b 
    on c.client_id=b.clientid and c.contract_id=b.contractid
    
    where a.CUSTOMERACCOUNTNUMBER in (@custid1)
) a 
inner join 
 rcbill_extract.IV_SERVICEINSTANCE d
    on a.client_id=d.CLIENT_ID and a.contract_id=d.CONTRACT_ID
    and a.SERVICENAME=d.CPE_TYPE
;
    


select 
a.* 
from rcbill_extract.IV_ADDON a 


where a.SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) )

;
-- select * from rcbill.clientcontractdevices limit 100; 

select * from rcbill_my.dailyusage where datestart is null;
select * from rcbill.rcb_ipusage 
where CLIENTCODE in (@kod1)
;


select a.*, rcbill.GetContractID(a.contractcode) as CONTRACT_ID
from 
(
						select b.datestart, b.dateend, b.category, b.traffictype, b.device
						, (select a.contractcode from rcbill.clientcontractdevices a where a.phoneno=b.device and a.clientcode=b.clientcode) as contractcode, b.traffic_mb
						, b.billable_duration_min, b.actual_duration_min, b.price, b.price_vat 
						, b.clientid as CLIENT_ID
						from rcbill_my.dailyusage b 	
						where b.clientcode in (@kod1)
						order by b.dateend desc
) a 
;