select * from rcbill_extract.IV_CUSTOMERACCOUNT where PARENTACCOUNTNUMBER is not null;

select * from rcbill_extract.parentaccount;

select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (select accountnumber from rcbill_extract.parentaccount) order by CUSTOMERACCOUNTNUMBER;

set @custid1 = 'CA_I17313';
set @custid1 = 'CA_I.000015739';

select parentaccountnumber from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (@custid1);

select BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (select parentaccountnumber from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (@custid1));

select PARENTBILLINGACCOUNTNUMBER, count(*) from rcbill_extract.IV_SERVICEINSTANCE group by 1; 

select * from rcbill_extract.IV_SERVICEINSTANCE where PARENTBILLINGACCOUNTNUMBER is not null;

set @custid1 = 'CA_I.000022305';

select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (@custid1)  order by ACCOUNTNUMBER;
select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1) order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1)  order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1);
select * from rcbill_extract.IV_SERVICEINSTANCECHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_ADDON where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_ADDONCHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );





select * from rcbill_extract.IV_BILLSUMMARY where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_BILLDETAIL where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_PAYMENTHISTORY where CUSTOMERACCOUNTNUMBER in (@custid1) order by PAYMENTRECEIPTID desc;


select * from rcbill_extract.IV_NBD where CUSTOMERACCOUNTNUMBER in (@custid1) order by BILLINGACCOUNTNUMBER;
select * from rcbill_extract.IV_DISCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1) order by BILLINGACCOUNTNUMBER;
select * from rcbill_extract.IV_BALANCE where CUSTOMERACCOUNTNUMBER in (@custid1) order by SERVICEINSTANCENUMBER desc;

select * from rcbill_extract.CUSTOMERDEBT where REV_CUSTOMERACCOUNTNUMBER in (@custid1) ;

select * from rcbill_extract.IV_CREDITNOTE where BILLINGACCOUNTNUMBER in (select BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1));
select * from rcbill_extract.IV_DEBITNOTE where BILLINGACCOUNTNUMBER in (select BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1));