use rcbill_extract;


select * from rcbill_extract.IV_SERVICEINSTANCE where SUBFROM is null;
select * from rcbill_extract.IV_SERVICEINSTANCE where SUBTO is null;


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