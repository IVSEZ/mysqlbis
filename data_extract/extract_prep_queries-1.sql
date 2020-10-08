select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR';

select * from rcbill.rcb_casa limit 100;
select * from rcbill.rcb_invoicesheader limit 100;
select * from rcbill.rcb_invoicescontents limit 100;


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

set @custid9 = 'CA_I9991';
select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (@custid9)  order by ACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid9)  order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid9) order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid9);
select * from rcbill_extract.IV_SERVICEINSTANCECHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid9) );
select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid9) );
select * from rcbill_extract.IV_ADDON where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid9) );
select * from rcbill_extract.IV_ADDONCHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid9) );


