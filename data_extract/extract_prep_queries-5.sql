use rcbill;

-- I.000022100 as bestcas nas
-- I.000003064 | I.000202203 | 2026815 has conax card

select * from rcbill.rcb_gatekeepers;
select * from rcbill.rcb_devicetypes;
select * from rcbill.rcb_services;
select * from rcbill.clientcontractdevices where ContractId=2260608;
select * from rcbill.rcb_devices where ContractID=2260608;
select * from rcbill.rcb_contractservices where CID=2260608;

select * from rcbill.clientcontractsservicepackageprice where CONTRACT_ID=2260608;


set @clientcode='I.000003064';
set @contractid=2026815;

select * from rcbill.clientcontractdevices where ClientCode=@clientcode;
select * from rcbill.rcb_devices where ContractID=@contractid;
select * from rcbill.rcb_contractservices where CID=@contractid;
select * from rcbill.clientcontractsservicepackageprice where CONTRACT_ID=@contractid;

select * from rcbill.rcb_vpnrates;
select * from rcbill.rcb_gatekeepers;
select * from rcbill.rcb_devicetypes;
select * from rcbill.rcb_services;


select * from rcbill_extract.IV_PREP_clientcontractsservicepackagepricedevice where clientcode='I.000022100';

select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCENUMBER='SIN_2753704_328387';

select * from rcbill_extract.IV_BILLSUMMARY where DEBITDOCUMENTNUMBER is null;

select * from rcbill_extract.IV_BILLDETAIL where DEBITDOCUMENTNUMBER is null;


set @custid1 = 'CA_I14';
set @custid1 = 'CA_I.000009787';
set @custid1 = 'CA_I.000011750';
set @custid4 = 'CA_I.000018187';
set @custid5 = 'CA_I.000011998';
set @custid6 = 'CA_I7';
set @custid7 = 'CA_I.000021409';
set @custid8 = 'CA_I.000021390';
set @custid9 = 'CA_I9991';
set @custid10 = 'CA_I.000021467';
set @custid11 = 'CA_I.000020888';
set @custid1 = 'CA_I16192';
set @custid1='CA_I.000021721'; -- divina sabino
set @custid1='CA_I.000010761'; -- lynsey talma


set @custid1 = 'CA_I.000021854';
set @custid1 = 'CA_I.000008363';
set @custid1 = 'CA_I9979';
set @custid1 = 'CA_I.000009596';
set @custid1 = 'CA_I.000017595';
set @custid1 = 'CA_I9452';
set @custid1 = 'CA_I9589';
set @custid1 = 'CA_I.000003551'; -- russian embassy
set @custid11 = 'CA_I7571'; -- maxwell philoe

set @custid1 = 'CA_I19819'; 
set @custid1 = 'CA_I6415'; -- Farouk Jean Baptiste
set @custid1 = 'CA_I.000000852'; -- Julianne Monique Marie

set @custid1 = 'CA_I23018'; -- amazon betting

set @custid1 = 'CA_I9695';  -- Marlene Rassool
select * from rcbill_extract.IV_BILLSUMMARY where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_BILLDETAIL where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_PAYMENTHISTORY where CUSTOMERACCOUNTNUMBER in (@custid1) order by PAYMENTRECEIPTID desc;


select * from  rcbill_extract.IV_BILLDETAIL where DEBITDOCUMENTNUMBER in (select DEBITDOCUMENTNUMBER from rcbill_extract.IV_BILLSUMMARY where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc);


-- (hard not in (100, 101, 102, 201, 999, 9999) or hard is null)
select * from rcbill_extract.IV_BILLSUMMARY where CUSTOMERACCOUNTNUMBER in (@custid1) and (INVOICEHARD not in (100, 101, 102, 201, 999, 9999) or INVOICEHARD is null) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_BILLDETAIL where DEBITDOCUMENTNUMBER in (select DEBITDOCUMENTNUMBER from rcbill_extract.IV_BILLSUMMARY where CUSTOMERACCOUNTNUMBER in (@custid1) and (INVOICEHARD not in (100, 101, 102, 201, 999, 9999) or INVOICEHARD is null) order by INVOICESUMMARYID desc) ;
select * from rcbill_extract.IV_PAYMENTHISTORY where CUSTOMERACCOUNTNUMBER in (@custid1) and (INVOICEHARD not in (100, 101, 102, 201, 999, 9999) or INVOICEHARD is null) order by PAYMENTRECEIPTID desc;



set @custid1 = 'CA_I8883';  -- Vipul Kanumale- C/O Sri Lankan Airlines
set @custid1 = 'CA_I.000010002'; -- Avani Seychelles Barbarons Resort and SPA (IPTV)

set @custid1='CA_I9732';
set @clientcode1='I9732';

set @custid1='CA_I.000005331';
set @clientcode1='I.000005331';

set @custid1='CA_I2100';
set @custid1='CA_I15086';

select * from rcbill_extract.IV_PREP_SERVICEINSTANCE1 where CUSTOMERACCOUNTNUMBER in (@custid1);
select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1);
select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) and SERVICESTATUS='Active' and serviceinstancestatus='Active';
select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) and (CPE_TYPE like '%SUBSCRIPTION%') and SERVICESTATUS='Active' and serviceinstancestatus='Active';
select * from rcbill_extract.temp1              where CUSTOMERACCOUNTNUMBER in (@custid1) and (CPE_TYPE like '%SUBSCRIPTION%') and SERVICESTATUS='Active' and serviceinstancestatus='Active';



select CUSTOMERACCOUNTNUMBER, BILLINGACCOUNTNUMBER, SERVICEACCOUNTNUMBER, SERVICEINSTANCEIDENTIFIER, SERVICEINSTANCENUMBER
, SUBFROM, SUBTO
from rcbill_extract.IV_SERVICEINSTANCE
where SUBFROM is not null and SUBTO is not null
;

select * from rcbill_extract.IV_SERVICEINSTANCE where 
(SUBFROM is null or SUBTO is null) 
and (CPE_TYPE like '%SUBSCRIPTION%') and SERVICESTATUS='Active' and serviceinstancestatus='Active'
and 
SERVICEINSTANCEIDENTIFIER in 
(
select SERVICEINSTANCEIDENTIFIER
from rcbill_extract.IV_SERVICEINSTANCE
where SUBFROM is not null and SUBTO is not null
)
;


SELECT * FROM rcbill_my.customercontractsnapshot where clientcode in (@clientcode1);


select * from rcbill.rcb_invoicesheader where clid=721961 and cid=1445532;
select * from rcbill.rcb_invoicesheader where clid=721961 and cid=1438010;
select * from rcbill.rcb_invoicescontents where clid=721961 and cid=1445532;
select * from rcbill.rcb_invoicescontents where clid=721961 and cid=1438010;

select * from rcbill_extract.IV_SERVICEINSTANCE where (SUBFROM is null or SUBTO is null) and SERVICESTATUS ='Active' and serviceinstancestatus='Active';

select * from rcbill_extract.IV_SERVICEINSTANCE where (CPE_TYPE like '%SUBSCRIPTION%') and (SUBFROM is null or SUBTO is null); -- and SERVICESTATUS ='Active' and serviceinstancestatus='Active';

select * from rcbill_extract.IV_SERVICEINSTANCE where (CPE_TYPE like '%SUBSCRIPTION%') and (SUBFROM is null or SUBTO is null) and SERVICESTATUS ='Active' and serviceinstancestatus='Active';
select * from rcbill_extract.temp1 where (CPE_TYPE like '%SUBSCRIPTION%') and (SUBFROM is null or SUBTO is null) and SERVICESTATUS ='Active' and serviceinstancestatus='Active';


SELECT * FROM rcbill_my.customercontractsnapshot where clientcode='I.000010002';

SELECT * FROM rcbill_my.dailyactivenumber where clientcode='I.000011750' and CONTRACTCODE='I.000290470';


SELECT * FROM rcbill.clientcontractssubs where cl_clientcode='I8883';

select * from rcbill_extract.IV_SERVICEINSTANCE where (SUBFROM is null and SUBTO is not null);

