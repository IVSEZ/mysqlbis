use rcbill_extract;


select * from rcbill_extract.IV_SERVICEINSTANCE where SUBFROM is null;
select * from rcbill_extract.IV_SERVICEINSTANCE where SUBTO is null;

select * from rcbill_extract.IV_SERVICEINSTANCE where SUBTO is null and servicestatus='Not Active';

select * from rcbill_extract.IV_BILLINGACCOUNT where CREDITCLASSNAME like '%VOICE%';

select * from rcbill_extract.IV_BILLSUMMARY where BILLINGACCOUNTNUMBER in ('BA_I15882_I102544.1_2');

select * from rcbill_extract.IV_BILLDETAIL where BILLINGACCOUNTNUMBER in ('BA_I15882_I102544.1_2');


set @ddno='1001481';
select * from rcbill_extract.IV_BILLSUMMARY where DEBITDOCUMENTNUMBER in (@ddno);

select * from rcbill_extract.IV_BILLDETAIL where DEBITDOCUMENTNUMBER in (@ddno);

select * from rcbill_extract.IV_BILLSUMMARY where BILLINGACCOUNTNUMBER is null;

select * from rcbill_extract.IV_BILLDETAIL where SUBTOTAL<0;


select * from rcbill.rcb_invoicesheader where INVOICENO=@ddno;
select * from rcbill.rcb_invoicescontents where INVOICENO=@ddno;


select * from rcbill.rcb_invoicesheader where year(BEGDATE)=3000;
select * from rcbill.rcb_invoicescontents where INVOICENO in (select INVOICENO from rcbill.rcb_invoicesheader where year(BEGDATE)=3000);

select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in ('CA_I.000000082');


select * from rcbill_extract.IV_SERVICEINSTANCE where PACKAGENAME in ('STANDARD');

select * from rcbill_extract.IV_SERVICEINSTANCE where PACKAGENAME in ('CORPORATE POSTPAID');

select * from rcbill_extract.IV_INVENTORY where INVENTORYNUMBER='cc.d3.e2.8d.be.23';

select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCENUMBER='SIN_4180297_8713';

select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where clientcode='I9661'; 


select * from rcbill.clientcontractsservicepackageprice where clientcode in ('I9661');
select * from rcbill_my.rep_clientcontractdevices where CLIENT_CODE in ('I9661');
select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where clientcode in ('I9661') order by contractenddate desc;

select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where clientcode in ('I9928') order by contractenddate desc;
select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where DEVICE_NAME in ('Decoder') order by contractenddate desc;
select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where UID is not null order by contractenddate desc;
select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where UID<>USERNAME; 
select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where SERVICE_TYPE is not null;
select * from rcbill_extract.IV_INVENTORY where INVENTORYNUMBER <> SERIALNUMBER;

###### 9 feb issues
-- BA WITHOUT INVOICES
set @clid=734869; set @custid1='CA_I.000021801';

set @clid=733961;

select * from rcbill.rcb_invoicesheader where CLID=@clid;
select * from rcbill.rcb_invoicescontents where CLID=@clid;
select * from rcbill.rcb_casa where CLID=@clid;


select * from rcbill.rcb_invoicesheader where INVOICENO=173798;
select * from rcbill.rcb_invoicescontents where INVOICENO=173798;


select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCEIDENTIFIER in ('SII_I.000412914');
select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCEIDENTIFIER in ('SII_I.000415082');

select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCEIDENTIFIER in ('SII_I.000404599');
select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where CLIENT_ID=@clid;

select * from rcbill_extract.IV_CUSTOMERACCOUNT where CLIENT_ID=@clid;

select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (@custid1)  order by ACCOUNTNUMBER;
select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1) order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1)  order by CUSTOMERACCOUNTNUMBER;

select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where CLIENT_ID in (@clid) order by contractenddate desc;
select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where CLIENT_ID in (@clid) ; 

select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1);
select * from rcbill_extract.IV_SERVICEINSTANCECHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_ADDON where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_ADDONCHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );


select * from rcbill_extract.IV_BILLSUMMARY where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_BILLDETAIL where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;

select * from rcbill_extract.IV_BILLSUMMARY where BILLINGACCOUNTNUMBER = 'NOT PRESENT';
select * from rcbill_extract.IV_BILLDETAIL where BILLINGACCOUNTNUMBER is null;


select * from rcbill_extract.IV_BILLSUMMARY where DEBITDOCUMENTNUMBER in (2885686);
select * from rcbill_extract.IV_BILLDETAIL where DEBITDOCUMENTNUMBER in (2885686);


select * from rcbill_extract.IV_BILLSUMMARY where DEBITDOCUMENTNUMBER in (981301);
select * from rcbill_extract.IV_BILLDETAIL where DEBITDOCUMENTNUMBER in (981301);

select DEBITDOCUMENTNUMBER, count(*) from rcbill_extract.IV_BILLSUMMARY group by DEBITDOCUMENTNUMBER order by 2 desc;

select * from rcbill_extract.IV_INVENTORY;
select * from rcbill_extract.IV_ADDON where SUBFROM<='2020-12-18' and SUBTO>='2020-12-18';

select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_ADDON where SUBFROM<='2020-12-18' and SUBTO>='2020-12-18');


select a.*, b.*
from 
rcbill_extract.IV_ADDON a 
inner join 
rcbill_extract.IV_INVENTORY b 
on a.SERVICEINSTANCENUMBER=b.SERVICEINSTANCENUMBER

-- where a.SUBFROM<='2020-12-18' and a.SUBTO>='2020-12-18'
;


-- to update bill summary BILLINGACCOUNT with bill details BILLINGACCOUNT
select a.DEBITDOCUMENTNUMBER, a.BILLINGACCOUNTNUMBER as BS_BILLINGACCOUNTNUMBER, a.CUSTOMERACCOUNTNUMBER as BS_CUSTOMERACCOUNTNUMBER, a.BILLDATE as BS_BILLDATE
, a.INVOICETYPE as BS_INVOICETYPE, a.INVOICEHARD as BS_INVOICEHARD, a.REMARK as BS_REMARK
, a.client_id as BS_client_id, a.contract_id as BS_contract_id
, rcbill.GetClientCode(a.client_id) as BS_CLIENTCODE, rcbill.GetContractCode(a.contract_id) as BS_CONTRACTCODE
, b.client_id as BD_client_id, b.contract_id as BD_contract_id
, rcbill.GetClientCode(b.client_id) as BD_CLIENTCODE, rcbill.GetContractCode(b.contract_id) as BD_CONTRACTCODE
, b.BILLDATE as BD_BILLDATE, b.BILLINGACCOUNTNUMBER as BD_BILLINGACCOUNTNUMBER, b.NAME as BD_NAME
from 
rcbill_extract.IV_BILLSUMMARY a 
inner join 
rcbill_extract.IV_BILLDETAIL b 
on 
a.DEBITDOCUMENTNUMBER=b.DEBITDOCUMENTNUMBER

where a.BILLINGACCOUNTNUMBER<>b.BILLINGACCOUNTNUMBER
and b.BILLINGACCOUNTNUMBER<>'NOT PRESENT'
-- and a.billdate<>b.billdate
;

-- to update bill detail BILLINGACCOUNT with bill summary BILLINGACCOUNT
select a.DEBITDOCUMENTNUMBER, a.BILLINGACCOUNTNUMBER as BS_BILLINGACCOUNTNUMBER, a.CUSTOMERACCOUNTNUMBER as BS_CUSTOMERACCOUNTNUMBER, a.BILLDATE as BS_BILLDATE
, a.INVOICETYPE as BS_INVOICETYPE, a.INVOICEHARD as BS_INVOICEHARD, a.REMARK as BS_REMARK
, a.client_id as BS_client_id, a.contract_id as BS_contract_id
, rcbill.GetClientCode(a.client_id) as BS_CLIENTCODE, rcbill.GetContractCode(a.contract_id) as BS_CONTRACTCODE
, b.client_id as BD_client_id, b.contract_id as BD_contract_id
, rcbill.GetClientCode(b.client_id) as BD_CLIENTCODE, rcbill.GetContractCode(b.contract_id) as BD_CONTRACTCODE
, b.BILLDATE as BD_BILLDATE, b.BILLINGACCOUNTNUMBER as BD_BILLINGACCOUNTNUMBER, b.NAME as BD_NAME
from 
rcbill_extract.IV_BILLSUMMARY a 
inner join 
rcbill_extract.IV_BILLDETAIL b 
on 
a.DEBITDOCUMENTNUMBER=b.DEBITDOCUMENTNUMBER

where a.BILLINGACCOUNTNUMBER<>b.BILLINGACCOUNTNUMBER
and a.BILLINGACCOUNTNUMBER<>'NOT PRESENT' and b.BILLINGACCOUNTNUMBER='NOT PRESENT'
-- and a.billdate<>b.billdate
;




select a.DEBITDOCUMENTNUMBER, a.BILLINGACCOUNTNUMBER, a.CUSTOMERACCOUNTNUMBER, a.BILLDATE
, a.INVOICETYPE, a.INVOICEHARD, a.REMARK
, a.client_id, a.contract_id
, rcbill.GetClientCode(a.client_id), rcbill.GetContractCode(a.contract_id)
, b.client_id, b.contract_id
, rcbill.GetClientCode(b.client_id), rcbill.GetContractCode(b.contract_id)
, b.BILLDATE, b.BILLINGACCOUNTNUMBER, b.NAME
from 
rcbill_extract.IV_BILLSUMMARY a 
inner join 
rcbill_extract.IV_BILLDETAIL b 
on 
a.DEBITDOCUMENTNUMBER=b.DEBITDOCUMENTNUMBER

where a.BILLINGACCOUNTNUMBER='NOT PRESENT'
;

select a.DEBITDOCUMENTNUMBER, a.BILLINGACCOUNTNUMBER, a.CUSTOMERACCOUNTNUMBER, a.BILLDATE
, a.INVOICETYPE, a.INVOICEHARD, a.REMARK
, a.client_id, a.contract_id
, rcbill.GetClientCode(a.client_id), rcbill.GetContractCode(a.contract_id)
, b.client_id, b.contract_id
, rcbill.GetClientCode(b.client_id), rcbill.GetContractCode(b.contract_id)
, b.BILLDATE, b.BILLINGACCOUNTNUMBER, b.NAME
from 
rcbill_extract.IV_BILLSUMMARY a 
inner join 
rcbill_extract.IV_BILLDETAIL b 
on 
a.DEBITDOCUMENTNUMBER=b.DEBITDOCUMENTNUMBER

where b.BILLINGACCOUNTNUMBER='NOT PRESENT'
;

select a.DEBITDOCUMENTNUMBER, a.BILLINGACCOUNTNUMBER, a.CUSTOMERACCOUNTNUMBER, a.BILLDATE
, a.INVOICETYPE, a.INVOICEHARD, a.REMARK
, a.client_id, a.contract_id
, rcbill.GetClientCode(a.client_id), rcbill.GetContractCode(a.contract_id)
, b.client_id, b.contract_id
, rcbill.GetClientCode(b.client_id), rcbill.GetContractCode(b.contract_id)
, b.BILLDATE, b.BILLINGACCOUNTNUMBER, b.NAME
from 
rcbill_extract.IV_BILLSUMMARY a 
inner join 
rcbill_extract.IV_BILLDETAIL b 
on 
a.DEBITDOCUMENTNUMBER=b.DEBITDOCUMENTNUMBER

where a.BILLINGACCOUNTNUMBER='NOT PRESENT' and b.BILLINGACCOUNTNUMBER='NOT PRESENT'
;


select a.DEBITDOCUMENTNUMBER, a.BILLINGACCOUNTNUMBER, a.CUSTOMERACCOUNTNUMBER, a.BILLDATE
, a.INVOICETYPE, a.INVOICEHARD, a.REMARK
, a.client_id, a.contract_id
, rcbill.GetClientCode(a.client_id), rcbill.GetContractCode(a.contract_id)
, b.client_id, b.contract_id
, rcbill.GetClientCode(b.client_id), rcbill.GetContractCode(b.contract_id)
, b.BILLDATE, b.BILLINGACCOUNTNUMBER, b.NAME
from 
rcbill_extract.IV_BILLSUMMARY a 
inner join 
rcbill_extract.IV_BILLDETAIL b 
on 
a.DEBITDOCUMENTNUMBER=b.DEBITDOCUMENTNUMBER

where a.BILLINGACCOUNTNUMBER='NOT PRESENT' and b.BILLINGACCOUNTNUMBER<>'NOT PRESENT'
;

select a.DEBITDOCUMENTNUMBER, a.BILLINGACCOUNTNUMBER, a.CUSTOMERACCOUNTNUMBER, a.BILLDATE
, a.INVOICETYPE, a.INVOICEHARD, a.REMARK
, a.client_id, a.contract_id
, rcbill.GetClientCode(a.client_id), rcbill.GetContractCode(a.contract_id)
, b.client_id, b.contract_id
, rcbill.GetClientCode(b.client_id), rcbill.GetContractCode(b.contract_id)
, b.BILLDATE, b.BILLINGACCOUNTNUMBER, b.NAME
from 
rcbill_extract.IV_BILLSUMMARY a 
inner join 
rcbill_extract.IV_BILLDETAIL b 
on 
a.DEBITDOCUMENTNUMBER=b.DEBITDOCUMENTNUMBER

where a.BILLINGACCOUNTNUMBER<>'NOT PRESENT' and b.BILLINGACCOUNTNUMBER='NOT PRESENT'
;

select a.DEBITDOCUMENTNUMBER, a.BILLINGACCOUNTNUMBER, a.CUSTOMERACCOUNTNUMBER, a.BILLDATE
, a.INVOICETYPE, a.INVOICEHARD, a.REMARK
, a.client_id, a.contract_id
, rcbill.GetClientCode(a.client_id), rcbill.GetContractCode(a.contract_id)
, b.client_id, b.contract_id
, rcbill.GetClientCode(b.client_id), rcbill.GetContractCode(b.contract_id)
, b.BILLDATE, b.BILLINGACCOUNTNUMBER, b.NAME
from 
rcbill_extract.IV_BILLSUMMARY a 
inner join 
rcbill_extract.IV_BILLDETAIL b 
on 
a.DEBITDOCUMENTNUMBER=b.DEBITDOCUMENTNUMBER

where 0=0 
-- and a.BILLINGACCOUNTNUMBER<>b.BILLINGACCOUNTNUMBER
-- and b.BILLINGACCOUNTNUMBER<>'NOT PRESENT'
and a.billdate=b.billdate
;



select * from rcbill_extract.IV_BILLSUMMARY where DEBITDOCUMENTNUMBER in (3106714) order by INVOICESUMMARYID desc;

select * from rcbill_extract.IV_BILLDETAIL where DEBITDOCUMENTNUMBER in (3106714) order by INVOICESUMMARYID desc;

select * from rcbill_extract.IV_BILLDETAIL where NAME like ('%STATIC%') order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_BILLDETAIL where NAME like ('%VPN%') order by INVOICESUMMARYID desc;


select * from rcbill_extract.IV_DISCOUNT where CUSTOMERACCOUNTNUMBER in ('CA_I51') order by BILLINGACCOUNTNUMBER;
