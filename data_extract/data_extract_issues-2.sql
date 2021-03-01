set @custid1 = 'CA_I.000011750';

set @custid1='CA_I.000020941';



select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (@custid1)  order by ACCOUNTNUMBER;
select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1) order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1)  order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1);
select * from rcbill_extract.IV_SERVICEINSTANCECHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_ADDON where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );
select * from rcbill_extract.IV_ADDONCHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1) );



select * from rcbill_extract.IV_NBD where CUSTOMERACCOUNTNUMBER in (@custid1) order by BILLINGACCOUNTNUMBER;
select * from rcbill_extract.IV_DISCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1) order by BILLINGACCOUNTNUMBER;
select * from rcbill_extract.IV_BALANCE where CUSTOMERACCOUNTNUMBER in (@custid1) order by SERVICEINSTANCENUMBER desc;

select * from rcbill_extract.CUSTOMERDEBT where REV_CUSTOMERACCOUNTNUMBER in (@custid1) ;

select * from rcbill_extract.IV_CREDITNOTE where BILLINGACCOUNTNUMBER in (select BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1));
select * from rcbill_extract.IV_DEBITNOTE where BILLINGACCOUNTNUMBER in (select BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1));


select * from rcbill_extract.IV_PAYMENTHISTORY where customeraccountnumber ='NOT PRESENT';


set @sii='SII_I.000413988';
select * from rcbill_extract.IV_SERVICEINSTANCE where SERVICEINSTANCEIDENTIFIER in (@sii);



########################################

### EXTRACT FOR PAYMENT RECEIPT ID
set @custid1 = 'CA_I.000019657'; -- andy julie (tv internet)
set @custid2 = 'CA_I9695';  -- Marlene Rassool
set @custid3 = 'CA_I13647'; -- andy julie (voice)


drop table if exists rcbill_extract.IV_BILLSUMMARY_SAMPLE;
create table rcbill_extract.IV_BILLSUMMARY_SAMPLE
(
	select *, (select paymentid from rcbill.rcb_invoicesheader where ID=a.invoicesummaryid) as PAYMENTRECEIPTID 
	from rcbill_extract.IV_BILLSUMMARY a where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3) order by INVOICESUMMARYID desc
)
;

drop table if exists rcbill_extract.IV_BILLDETAIL_SAMPLE;
create table rcbill_extract.IV_BILLDETAIL_SAMPLE
(
	select * from rcbill_extract.IV_BILLDETAIL where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3) order by INVOICESUMMARYID desc
)
;

drop table if exists rcbill_extract.IV_PAYMENTHISTORY_SAMPLE;
create table rcbill_extract.IV_PAYMENTHISTORY_SAMPLE
(
	select * from rcbill_extract.IV_PAYMENTHISTORY where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2,@custid3) order by PAYMENTRECEIPTID desc
)
;


### EXPORT THE SAMPLE DATA

## BILL SUMMARY
select 'BILL SUMMARY' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_BILLSUMMARY_SAMPLE'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;


select 	"INVOICESUMMARYID",	"DEBITDOCUMENTNUMBER",	"CREATEDATE",	"SUBTOTAL",	"TAX",	"UNPAID",	"WRITEOFF",	"REMARK",	"DUEDATE",	"TOTALDUE",	"DISPUTED",	"BILLDATE",	"SURCHARGE",	"SYSCURRENCYEXCHANGERATE",	"TOTALAMOUNT",	"DISCOUNTABLE",	"DISCOUNTED",	"TAXABLE",	"FROMDATE",	"TODATE",	"DEPOSIT",	"BILLINGACCOUNTNUMBER",	"CUSTOMERACCOUNTNUMBER",	"ADJUSTEDAMOUNT",	"BILLCYCLE",	"CURRENCYALIAS",	"ORIGINALCURRENCY",	"CREATEDBY",	"PROFORMAINVOICENUMBER",	"CREDITINVOICENUMBER",	"DEBITINVOICENUMBER",	"INVOICETYPE",	"INVOICEHARD",	"INVOICE_PDF_NAME",	"PAYMENTRECEIPTID"
union all
select 	ifnull(INVOICESUMMARYID,""),	ifnull(DEBITDOCUMENTNUMBER,""),	ifnull(CREATEDATE,""),	ifnull(SUBTOTAL,""),	ifnull(TAX,""),	ifnull(UNPAID,""),	ifnull(WRITEOFF,""),	ifnull(REMARK,""),	ifnull(DUEDATE,""),	ifnull(TOTALDUE,""),	ifnull(DISPUTED,""),	ifnull(BILLDATE,""),	ifnull(SURCHARGE,""),	ifnull(SYSCURRENCYEXCHANGERATE,""),	ifnull(TOTALAMOUNT,""),	ifnull(DISCOUNTABLE,""),	ifnull(DISCOUNTED,""),	ifnull(TAXABLE,""),	ifnull(FROMDATE,""),	ifnull(TODATE,""),	ifnull(DEPOSIT,""),	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(ADJUSTEDAMOUNT,""),	ifnull(BILLCYCLE,""),	ifnull(CURRENCYALIAS,""),	ifnull(ORIGINALCURRENCY,""),	ifnull(CREATEDBY,""),	ifnull(PROFORMAINVOICENUMBER,""),	ifnull(CREDITINVOICENUMBER,""),	ifnull(DEBITINVOICENUMBER,""),	ifnull(INVOICETYPE,""),	ifnull(INVOICEHARD,""),	ifnull(INVOICE_PDF_NAME,""), ifnull(PAYMENTRECEIPTID,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_BILL_SUMMARY_SAMPLE_20201219-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_BILLSUMMARY_SAMPLE
;


## BILL DETAIL

select 'BILL DETAIL' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_BILLDETAIL_SAMPLE'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;


select 	"BILLINGACCOUNTNUMBER",	"CUSTOMERACCOUNTNUMBER",	"SERVICEINSTANCENUMBER",	"INVOICEDETAILID",	"INVOICESUMMARYID",	"SERIALNUMBER",	"DEBITDOCUMENTNUMBER",	"NAME",	"RATE",	"ITEMCOUNT",	"SUBTOTAL",	"TAX",	"DISCOUNT",	"DISCOUNTPERCENT",	"TOTALAMOUNT",	"DISCOUNTABLE",	"DISCOUNTED",	"TAXABLE",	"UNPAID",	"WRITEOFF",	"REMARK",	"FROMDATE",	"TODATE",	"BILLCYCLE",	"PRODUCTTYPEID",	"DEPOSIT",	"PRORATIONTYPE",	"ADJUSTEDAMOUNT",	"PACKAGENAME",	"BILLDATE",	"CURRENCYALIAS",	"D_DISCOUNTPCT",	"D_PCTDISCOUNT",	"D_DISCOUNTNAME",	"D_ABSDISCOUNT",	"D_SYSCURRENCYEXCHANGERATE",	"T_RATE",	"T_TAXNAME",	"T_EXEMPTIONRATE",	"T_UNPAID",	"T_WRITEOFF",	"T_TAXRATETYPE",	"T_TAXOVERRIDDEN",	"T_EXEMPTIONAMT",	"T_EXEMPTIONAPPLICABILITY",	"CLIENT_ID",	"CONTRACT_ID",	"RSID",	"ServiceID"
union all
select 	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(INVOICEDETAILID,""),	ifnull(INVOICESUMMARYID,""),	ifnull(SERIALNUMBER,""),	ifnull(DEBITDOCUMENTNUMBER,""),	ifnull(NAME,""),	ifnull(RATE,""),	ifnull(ITEMCOUNT,""),	ifnull(SUBTOTAL,""),	ifnull(TAX,""),	ifnull(DISCOUNT,""),	ifnull(DISCOUNTPERCENT,""),	ifnull(TOTALAMOUNT,""),	ifnull(DISCOUNTABLE,""),	ifnull(DISCOUNTED,""),	ifnull(TAXABLE,""),	ifnull(UNPAID,""),	ifnull(WRITEOFF,""),	ifnull(REMARK,""),	ifnull(FROMDATE,""),	ifnull(TODATE,""),	ifnull(BILLCYCLE,""),	ifnull(PRODUCTTYPEID,""),	ifnull(DEPOSIT,""),	ifnull(PRORATIONTYPE,""),	ifnull(ADJUSTEDAMOUNT,""),	ifnull(PACKAGENAME,""),	ifnull(BILLDATE,""),	ifnull(CURRENCYALIAS,""),	ifnull(D_DISCOUNTPCT,""),	ifnull(D_PCTDISCOUNT,""),	ifnull(D_DISCOUNTNAME,""),	ifnull(D_ABSDISCOUNT,""),	ifnull(D_SYSCURRENCYEXCHANGERATE,""),	ifnull(T_RATE,""),	ifnull(T_TAXNAME,""),	ifnull(T_EXEMPTIONRATE,""),	ifnull(T_UNPAID,""),	ifnull(T_WRITEOFF,""),	ifnull(T_TAXRATETYPE,""),	ifnull(T_TAXOVERRIDDEN,""),	ifnull(T_EXEMPTIONAMT,""),	ifnull(T_EXEMPTIONAPPLICABILITY,""),	ifnull(CLIENT_ID,""),	ifnull(CONTRACT_ID,""),	ifnull(RSID,""),	ifnull(ServiceID,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_BILLDETAIL_SAMPLE_20201219-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_BILLDETAIL_SAMPLE
;

## PAYMENT HISTORY
select 'PAYMENT HISTORY' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_PAYMENTHISTORY_SAMPLE'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;


select 	"PAYMENTRECEIPTID",	"BILLINGACCOUNTNUMBER",	"CUSTOMERACCOUNTNUMBER",	"SERVICEINSTANCENUMBER",	"PAYMENTDATE",	"PAYMENTPROCESSEDDATE",	"PAYMENTDESC",	"PAYMENTCURRENCYALIAS",	"PAYMENTMODE",	"PAYMENTTRANSACTIONAMOUNT",	"SERIALNUMBER",	"DEBITDOCUMENTNUMBER",	"CLIENT_ID",	"CONTRACT_ID",	"PAYMENTAMOUNT",	"PAYMENTREASON",	"EXCHANGERATE",	"DISCOUNT",	"INVOICEHARD",	"EMPLOYEEID",	"EMPLOYEENAME",	"EMPLOYEEDEPARTMENT"
union all
select 	ifnull(PAYMENTRECEIPTID,""),	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(PAYMENTDATE,""),	ifnull(PAYMENTPROCESSEDDATE,""),	ifnull(PAYMENTDESC,""),	ifnull(PAYMENTCURRENCYALIAS,""),	ifnull(PAYMENTMODE,""),	ifnull(PAYMENTTRANSACTIONAMOUNT,""),	ifnull(SERIALNUMBER,""),	ifnull(DEBITDOCUMENTNUMBER,""),	ifnull(CLIENT_ID,""),	ifnull(CONTRACT_ID,""),	ifnull(PAYMENTAMOUNT,""),	ifnull(PAYMENTREASON,""),	ifnull(EXCHANGERATE,""),	ifnull(DISCOUNT,""),	ifnull(INVOICEHARD,""),	ifnull(EMPLOYEEID,""),	ifnull(EMPLOYEENAME,""),	ifnull(EMPLOYEEDEPARTMENT,"")


INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_PAYMENT_HISTORY_SAMPLE_20201219-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_PAYMENTHISTORY_SAMPLE
;



