set @custid1 = 'CA_I.000012204'; -- intelvision tech support
set @custid1 = 'CA_I.000009758'; -- six senses


<<<<<<< HEAD
set @custid1 = 'CA_I22308'; -- 
set @custid2 = 'CA_I13400';
=======
set @custid1 = 'CA_I11081'; -- 
set @custid2 = 'CA_I11081';
>>>>>>> b6bb470ded8d16f2f8da8ab8452bba698b27c394

select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (@custid1,@custid2)  order by ACCOUNTNUMBER;
select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2) order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2)  order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2);

select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2) and (SERVICEENDDATE is null or date(SERVICEENDDATE)>=now());


select * from rcbill_extract.IV_SERVICEINSTANCECHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2) );
select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2) );
select * from rcbill_extract.IV_ADDON where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2) );
select * from rcbill_extract.IV_ADDONCHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2) );


select * from rcbill_extract.IV_BILLSUMMARY where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_BILLDETAIL where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_PAYMENTHISTORY where CUSTOMERACCOUNTNUMBER in (@custid1) order by PAYMENTRECEIPTID desc;


select * from rcbill_extract.IV_NBD where CUSTOMERACCOUNTNUMBER in (@custid1) order by BILLINGACCOUNTNUMBER;
select * from rcbill_extract.IV_DISCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1) order by BILLINGACCOUNTNUMBER;
select * from rcbill_extract.IV_BALANCE where CUSTOMERACCOUNTNUMBER in (@custid1) order by SERVICEINSTANCENUMBER desc;

select * from rcbill_extract.CUSTOMERDEBT where REV_CUSTOMERACCOUNTNUMBER in (@custid1) ;

select * from rcbill_extract.IV_CREDITNOTE where BILLINGACCOUNTNUMBER in (select BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1));
select * from rcbill_extract.IV_DEBITNOTE where BILLINGACCOUNTNUMBER in (select BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1));


select * from rcbill_extract.IV_SERVICEINSTANCE where (SERVICEENDDATE is null or date(SERVICEENDDATE)>=now());

select * from rcbill_extract.IV_INVENTORY where SERIALNUMBER='znts038e5867'
-- and (SERVICESTATUS='Active' or serviceinstancestatus='Active')
;


select DEVICE_ID, count(*) from rcbill_extract.IV_SERVICEINSTANCE where USERNAME is null
group by DEVICE_ID
order by 2 desc
;