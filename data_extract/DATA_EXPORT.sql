use rcbill_extract;

-- select * from rcbill_extract.IV_CUSTOMERACCOUNT;

-- override GROUP_CONCAT limit of 1024 characters to avoid a truncated result
set session group_concat_max_len = 1000000;

#####################################################################
## CUSTOMER ACCOUNT
select 'CUSTOMER ACCOUNT' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_CUSTOMERACCOUNT'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;


select "FIRSTNAME",	"LASTNAME",	"CITY",	"STATE",	"COUNTRY",	"DISTRICT",	"SUBDISTRICT",	"ZIPCODE",	"EMAILID",	"BUSINESSEMAILID",	"MOBILENUMBER",	"PHONEHOME",	"PHONEOFFICE",	"FAXNUMBER",	"PARENTACCOUNTNUMBER",	"ACCOUNTNUMBER",	"ACCOUNTSTATUS",	"USERNAME",	"CREATEDDATE",	"ACTIVATIONDATE",	"STATUSCHANGEDATE",	"PRIMARY_ID_TYPE",	"PRIMARY_ID_VALUE",	"SECONDARY_ID_TYPE",	"SECONDARY_ID_VALUE",	"TAXNUMBERINDICATOR",	"BUILDINGNAME",	"BIRTHDATE",	"STREETNAME",	"PREFERREDLANGUAGE",	"PROPERTYTYPE",	"PARCELNUMBER",	"LANDMARK",	"LATITUDE",	"LONGITUDE",	"FLOOR",	"XCOORDINATE",	"YCOORDINATE"
-- select 	"FIRSTNAME",	"LASTNAME",	"CITY",	"STATE",	"COUNTRY",	"DISTRICT",	"SUBDISTRICT",	"ZIPCODE",	"EMAILID",	"BUSINESSEMAILID",	"MOBILENUMBER",	"PHONEHOME",	"PHONEOFFICE",	"FAXNUMBER",	"PARENTACCOUNTNUMBER",	"ACCOUNTNUMBER",	"ACCOUNTSTATUS",	"USERNAME",	"CREATEDDATE",	"ACTIVATIONDATE",	"STATUSCHANGEDATE",	"PRIMARY_ID_TYPE",	"PRIMARY_ID_VALUE",	"SECONDARY_ID_TYPE",	"SECONDARY_ID_VALUE",	"TAXNUMBERINDICATOR",	"BUILDINGNAME",	"BIRTHDATE",	"STREETNAME",	"PREFERREDLANGUAGE",	"PROPERTYTYPE",	"PARCELNUMBER",	"LANDMARK",	"LATITUDE",	"LONGITUDE",	"FLOOR",	"XCOORDINATE",	"YCOORDINATE",	"CLCLASS",	"FIZLICE",	"CLIENT_ID"
union all
select 	ifnull(FIRSTNAME,""),	ifnull(LASTNAME,""),	ifnull(CITY,""),	ifnull(STATE,""),	ifnull(COUNTRY,""),	ifnull(DISTRICT,""),	ifnull(SUBDISTRICT,""),	ifnull(ZIPCODE,""),	ifnull(EMAILID,""),	ifnull(BUSINESSEMAILID,""),	ifnull(MOBILENUMBER,""),	ifnull(PHONEHOME,""),	ifnull(PHONEOFFICE,""),	ifnull(FAXNUMBER,""),	ifnull(PARENTACCOUNTNUMBER,""),	ifnull(ACCOUNTNUMBER,""),	ifnull(ACCOUNTSTATUS,""),	ifnull(USERNAME,""),	ifnull(CREATEDDATE,""),	ifnull(ACTIVATIONDATE,""),	ifnull(STATUSCHANGEDATE,""),	ifnull(PRIMARY_ID_TYPE,""),	ifnull(PRIMARY_ID_VALUE,""),	ifnull(SECONDARY_ID_TYPE,""),	ifnull(SECONDARY_ID_VALUE,""),	ifnull(TAXNUMBERINDICATOR,""),	ifnull(BUILDINGNAME,""),	ifnull(BIRTHDATE,""),	ifnull(STREETNAME,""),	ifnull(PREFERREDLANGUAGE,""),	ifnull(PROPERTYTYPE,""),	ifnull(PARCELNUMBER,""),	ifnull(LANDMARK,""),	ifnull(LATITUDE,""),	ifnull(LONGITUDE,""),	ifnull(FLOOR,""),	ifnull(XCOORDINATE,""),	ifnull(YCOORDINATE,"")
-- select 	ifnull(FIRSTNAME,""),	ifnull(LASTNAME,""),	ifnull(CITY,""),	ifnull(STATE,""),	ifnull(COUNTRY,""),	ifnull(DISTRICT,""),	ifnull(SUBDISTRICT,""),	ifnull(ZIPCODE,""),	ifnull(EMAILID,""),	ifnull(BUSINESSEMAILID,""),	ifnull(MOBILENUMBER,""),	ifnull(PHONEHOME,""),	ifnull(PHONEOFFICE,""),	ifnull(FAXNUMBER,""),	ifnull(PARENTACCOUNTNUMBER,""),	ifnull(ACCOUNTNUMBER,""),	ifnull(ACCOUNTSTATUS,""),	ifnull(USERNAME,""),	ifnull(CREATEDDATE,""),	ifnull(ACTIVATIONDATE,""),	ifnull(STATUSCHANGEDATE,""),	ifnull(PRIMARY_ID_TYPE,""),	ifnull(PRIMARY_ID_VALUE,""),	ifnull(SECONDARY_ID_TYPE,""),	ifnull(SECONDARY_ID_VALUE,""),	ifnull(TAXNUMBERINDICATOR,""),	ifnull(BUILDINGNAME,""),	ifnull(BIRTHDATE,""),	ifnull(STREETNAME,""),	ifnull(PREFERREDLANGUAGE,""),	ifnull(PROPERTYTYPE,""),	ifnull(PARCELNUMBER,""),	ifnull(LANDMARK,""),	ifnull(LATITUDE,""),	ifnull(LONGITUDE,""),	ifnull(FLOOR,""),	ifnull(XCOORDINATE,""),	ifnull(YCOORDINATE,""),	ifnull(CLCLASS,""),	ifnull(FIZLICE,""),	ifnull(CLIENT_ID,"")


INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_CUSTOMER_ACCOUNT_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_CUSTOMERACCOUNT
;


#####################################################################
## BILLING ACCOUNT

select 'BILLING ACCOUNT' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_BILLINGACCOUNT'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;



select 	"FIRSTNAME",	"LASTNAME",	"BILLCYCLE",	"BILLDELIVERYMODE",	"CURRENCY",	"CITY",	"DISTRICT",	"SUBDISTRICT",	"STATE",	"COUNTRY",	"ZIPCODE",	"EMAILID",	"BUSINESSEMAILID",	"MOBILENUMBER",	"PHONEHOME",	"PHONEOFFICE",	"FAXNUMBER",	"CUSTOMERACCOUNTNUMBER",	"BILLINGACCOUNTNUMBER",	"ACCOUNTSTATUS",	"CREATEDDATE",	"ACTIVATIONDATE",	"STATUSCHANGEDATE",	"LASTACTION",	"BILLFORMATTYPE",	"BUILDINGNAME",	"BUILDINGTYPE",	"STREETNAME",	"PROPERTYTYPE",	"PARCELNUMBER",	"LANDMARK",	"LATITUDE",	"LONGITUDE",	"FLOOR",	"CHARGINGPATTERN",	"XCOORDINATE",	"YCOORDINATE",	"RATINGPLAN",	"CREDITCLASSNAME"

union all

select 	ifnull(FIRSTNAME,""),	ifnull(LASTNAME,""),	ifnull(BILLCYCLE,""),	ifnull(BILLDELIVERYMODE,""),	ifnull(CURRENCY,""),	ifnull(CITY,""),	ifnull(DISTRICT,""),	ifnull(SUBDISTRICT,""),	ifnull(STATE,""),	ifnull(COUNTRY,""),	ifnull(ZIPCODE,""),	ifnull(EMAILID,""),	ifnull(BUSINESSEMAILID,""),	ifnull(MOBILENUMBER,""),	ifnull(PHONEHOME,""),	ifnull(PHONEOFFICE,""),	ifnull(FAXNUMBER,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(ACCOUNTSTATUS,""),	ifnull(CREATEDDATE,""),	ifnull(ACTIVATIONDATE,""),	ifnull(STATUSCHANGEDATE,""),	ifnull(LASTACTION,""),	ifnull(BILLFORMATTYPE,""),	ifnull(BUILDINGNAME,""),	ifnull(BUILDINGTYPE,""),	ifnull(STREETNAME,""),	ifnull(PROPERTYTYPE,""),	ifnull(PARCELNUMBER,""),	ifnull(LANDMARK,""),	ifnull(LATITUDE,""),	ifnull(LONGITUDE,""),	ifnull(FLOOR,""),	ifnull(CHARGINGPATTERN,""),	ifnull(XCOORDINATE,""),	ifnull(YCOORDINATE,""),	ifnull(RATINGPLAN,""),	ifnull(CREDITCLASSNAME,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_BILLING_ACCOUNT_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_BILLINGACCOUNT
;


#####################################################################
## SERVICE ACCOUNT

select 'SERVICE ACCOUNT' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_SERVICEACCOUNT'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;



select 	"FIRSTNAME",	"LASTNAME",	"ADDRESSONE",	"ADDRESSTWO",	"ADDRESSTHREE",	"CITY",	"DISTRICT",	"SUBDISTRICT",	"STATE",	"COUNTRY",	"ZIPCODE",	"EMAILID",	"BUSINESSEMAILID",	"MOBILENUMBER",	"PHONEHOME",	"PHONEOFFICE",	"FAXNUMBER",	"CUSTOMERACCOUNTNUMBER",	"SERVICEACCOUNTNUMBER",	"ACCOUNTSTATUS",	"CREATEDDATE",	"ACTIVATIONDATE",	"STATUSCHANGEDATE",	"TECHNOLOGY",	"BUILDINGNAME",	"BUILDINGTYPE",	"STREETNAME",	"CHANNELPARTNERID",	"PROPERTYTYPE",	"PARCELNUMBER",	"LANDMARK",	"LATITUDE",	"LONGITUDE",	"FLOOR",	"EMPLOYEEID",	"EMPLOYEENAME",	"EMPLOYEEDEPARTMENT",	"MXKCODE",	"MXKNAME",	"CARDNO",	"PORTNO",	"SPLITTER",	"NETWORKACCESSPOINT",	"NETWORKSVLAN",	"VLANID",	"SERVICECATEGORY",	"ACTIVESERVICE",	"CUSTOMERSUBCATEGORY",	"XCOORDINATE",	"YCOORDINATE",	"HFCNODE",	"HFCNODENAME", "VENDOR"

union all

select 	ifnull(FIRSTNAME,""),	ifnull(LASTNAME,""),	ifnull(ADDRESSONE,""),	ifnull(ADDRESSTWO,""),	ifnull(ADDRESSTHREE,""),	ifnull(CITY,""),	ifnull(DISTRICT,""),	ifnull(SUBDISTRICT,""),	ifnull(STATE,""),	ifnull(COUNTRY,""),	ifnull(ZIPCODE,""),	ifnull(EMAILID,""),	ifnull(BUSINESSEMAILID,""),	ifnull(MOBILENUMBER,""),	ifnull(PHONEHOME,""),	ifnull(PHONEOFFICE,""),	ifnull(FAXNUMBER,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(SERVICEACCOUNTNUMBER,""),	ifnull(ACCOUNTSTATUS,""),	ifnull(CREATEDDATE,""),	ifnull(ACTIVATIONDATE,""),	ifnull(STATUSCHANGEDATE,""),	ifnull(TECHNOLOGY,""),	ifnull(BUILDINGNAME,""),	ifnull(BUILDINGTYPE,""),	ifnull(STREETNAME,""),	ifnull(CHANNELPARTNERID,""),	ifnull(PROPERTYTYPE,""),	ifnull(PARCELNUMBER,""),	ifnull(LANDMARK,""),	ifnull(LATITUDE,""),	ifnull(LONGITUDE,""),	ifnull(FLOOR,""),	ifnull(EMPLOYEEID,""),	ifnull(EMPLOYEENAME,""),	ifnull(EMPLOYEEDEPARTMENT,""),	ifnull(MXKCODE,""),	ifnull(MXKNAME,""),	ifnull(CARDNO,""),	ifnull(PORTNO,""),	ifnull(SPLITTER,""),	ifnull(NETWORKACCESSPOINT,""),	ifnull(NETWORKSVLAN,""),	ifnull(VLANID,""),	ifnull(SERVICECATEGORY,""),	ifnull(ACTIVESERVICE,""),	ifnull(CUSTOMERSUBCATEGORY,""),	ifnull(XCOORDINATE,""),	ifnull(YCOORDINATE,""),	ifnull(HFCNODE,""),	ifnull(HFCNODENAME,""),	ifnull(VENDOR,"")


INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_SERVICE_ACCOUNT_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_SERVICEACCOUNT
;

#####################################################################
## SERVICE INSTANCE

select 'SERVICE INSTANCE' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_SERVICEINSTANCE'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;



-- select 	"CUSTOMERACCOUNTNUMBER",	"BILLINGACCOUNTNUMBER",	"SERVICEACCOUNTNUMBER",	"SERVICEINSTANCEIDENTIFIER",	"SERVICEINSTANCENUMBER",	"PACKAGENAME",	"SERVICESTATUS",	"USERNAME",	"CREATEDDATE",	"ACTIVATIONDATE",	"STATUSCHANGEDDATE",	"LASTACTION",	"PACKAGEAMOUNT",	"CPE_TYPE",	"CPE_ID",	"CONTRACTSTARTDATE",	"CONTRACTENDDATE",	"SERVICEREMARKS",	"EXPIRYDATE",	"OVERRIDDEN",	"FSAN",	"ServiceID",	"ServiceRateID",	"SERVICESTARTDATE",	"SERVICEENDDATE",	"clientcode",	"contractcode",	"serviceinstancestatus",	"CLIENT_ID",	"CONTRACT_ID",	"LASTSUBSTARTDATE",	"LASTSUBENDDATE",	"LASTSUBPAYDATE",	"LASTINVFROMDATE",	"LASTINVTODATE",	"CURSUBSTARTDATE",	"CURSUBENDDATE",	"CURSUBPAYDATE",	"CURINVFROMDATE",	"CURINVTODATE",	"SUBFROM",	"SUBTO",	"SUBPERIOD"
select 	"CUSTOMERACCOUNTNUMBER",	"BILLINGACCOUNTNUMBER",	"SERVICEACCOUNTNUMBER",	"SERVICEINSTANCEIDENTIFIER",	"SERVICEINSTANCENUMBER",	"PACKAGENAME",	"SERVICESTATUS",	"USERNAME",	"CREATEDDATE",	"ACTIVATIONDATE",	"STATUSCHANGEDDATE",	"LASTACTION",	"PACKAGEAMOUNT",	"CPE_TYPE",	"CPE_ID",	"CONTRACTSTARTDATE",	"CONTRACTENDDATE",	"SERVICEREMARKS",	"EXPIRYDATE",	"OVERRIDDEN",	"FSAN",	"ServiceID",	"ServiceRateID",	"SERVICESTARTDATE",	"SERVICEENDDATE",	"clientcode",	"contractcode",	"serviceinstancestatus",	"CLIENT_ID",	"CONTRACT_ID",	"DEVICE_ID",	"DEVICE_TYPE_ID",	"DEVICE_NAME",	"GATEKEEPER_ID",	"GATEKEEPER_NAME",	"LASTSUBSTARTDATE",	"LASTSUBENDDATE",	"LASTSUBPAYDATE",	"LASTINVFROMDATE",	"LASTINVTODATE",	"CURSUBSTARTDATE",	"CURSUBENDDATE",	"CURSUBPAYDATE",	"CURINVFROMDATE",	"CURINVTODATE",	"SUBFROM",	"SUBTO",	"SUBPERIOD", "PARENTBILLINGACCOUNTNUMBER"

union all

select 	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(SERVICEACCOUNTNUMBER,""),	ifnull(SERVICEINSTANCEIDENTIFIER,""),	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(PACKAGENAME,""),	ifnull(SERVICESTATUS,""),	ifnull(USERNAME,""),	ifnull(CREATEDDATE,""),	ifnull(ACTIVATIONDATE,""),	ifnull(STATUSCHANGEDDATE,""),	ifnull(LASTACTION,""),	ifnull(PACKAGEAMOUNT,""),	ifnull(CPE_TYPE,""),	ifnull(CPE_ID,""),	ifnull(CONTRACTSTARTDATE,""),	ifnull(CONTRACTENDDATE,""),	ifnull(SERVICEREMARKS,""),	ifnull(EXPIRYDATE,""),	ifnull(OVERRIDDEN,""),	ifnull(FSAN,""),	ifnull(ServiceID,""),	ifnull(ServiceRateID,""),	ifnull(SERVICESTARTDATE,""),	ifnull(SERVICEENDDATE,""),	ifnull(clientcode,""),	ifnull(contractcode,""),	ifnull(serviceinstancestatus,""),	ifnull(CLIENT_ID,""),	ifnull(CONTRACT_ID,""),	ifnull(DEVICE_ID,""),	ifnull(DEVICE_TYPE_ID,""),	ifnull(DEVICE_NAME,""),	ifnull(GATEKEEPER_ID,""),	ifnull(GATEKEEPER_NAME,""),	ifnull(LASTSUBSTARTDATE,""),	ifnull(LASTSUBENDDATE,""),	ifnull(LASTSUBPAYDATE,""),	ifnull(LASTINVFROMDATE,""),	ifnull(LASTINVTODATE,""),	ifnull(CURSUBSTARTDATE,""),	ifnull(CURSUBENDDATE,""),	ifnull(CURSUBPAYDATE,""),	ifnull(CURINVFROMDATE,""),	ifnull(CURINVTODATE,""),	ifnull(SUBFROM,""),	ifnull(SUBTO,""),	ifnull(SUBPERIOD,""),	ifnull(PARENTBILLINGACCOUNTNUMBER,"")


INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_SERVICE_INSTANCE_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_SERVICEINSTANCE
;

#####################################################################
## SERVICE INSTANCE CHARGE

select 'SERVICE INSTANCE CHARGE' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_SERVICEINSTANCECHARGE'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;

select 	"SERVICEINSTANCENUMBER",	"CHARGENAME ",	"CHARGEPRICE"

union all

select 	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(CHARGENAME ,""),	ifnull(CHARGEPRICE,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_SERVICE_INSTANCE_CHARGE_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_SERVICEINSTANCECHARGE
;

#####################################################################
## INVENTORY

select 'INVENTORY' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_INVENTORY'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;



select 	"SERVICEINSTANCENUMBER",	"INVENTORYNUMBER",	"SERIALNUMBER",	"CPE_TYPE", "INVENTORYSUBTYPE",	"REMARK",	"STAFFNAME",	"SERVICESTARTDATE",	"SERVICEENDDATE",	"SERVICESTATUS",	"SERVICEINSTANCESTATUS",	"SOURCECHANNEL", "DEVICE_NAME", "GATEKEEPER_NAME"

union all

select 	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(INVENTORYNUMBER,""),	ifnull(SERIALNUMBER,""), ifnull(CPE_TYPE,""),	ifnull(INVENTORYSUBTYPE,""),	ifnull(REMARK,""),	ifnull(STAFFNAME,""),	ifnull(SERVICESTARTDATE,""),	ifnull(SERVICEENDDATE,""),	ifnull(SERVICESTATUS,""),	ifnull(SERVICEINSTANCESTATUS,""),	ifnull(SOURCECHANNEL,""),	ifnull(DEVICE_NAME,""),	ifnull(GATEKEEPER_NAME,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_INVENTORY_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_INVENTORY
;


#####################################################################
## ADDON 

select 'ADDON' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_ADDON'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;

select 	"SERVICEINSTANCENUMBER",	"PACKAGENAME",	"SERVICESTARTDATE",	"SERVICEENDDATE",	"LASTSUBSTARTDATE",	"LASTSUBENDDATE",	"LASTINVFROMDATE",	"LASTINVTODATE",	"CURSUBSTARTDATE",	"CURSUBENDDATE",	"CURSUBPAYDATE",	"CURINVFROMDATE",	"CURINVTODATE",	"SUBFROM",	"SUBTO",	"SUBPERIOD",	"OVERRIDDEN"

union all

select 	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(PACKAGENAME,""),	ifnull(SERVICESTARTDATE,""),	ifnull(SERVICEENDDATE,""),	ifnull(LASTSUBSTARTDATE,""),	ifnull(LASTSUBENDDATE,""),	ifnull(LASTINVFROMDATE,""),	ifnull(LASTINVTODATE,""),	ifnull(CURSUBSTARTDATE,""),	ifnull(CURSUBENDDATE,""),	ifnull(CURSUBPAYDATE,""),	ifnull(CURINVFROMDATE,""),	ifnull(CURINVTODATE,""),	ifnull(SUBFROM,""),	ifnull(SUBTO,""),	ifnull(SUBPERIOD,""),	ifnull(OVERRIDDEN,"")




INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_ADDON_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_ADDON
;

#####################################################################
## ADDON CHARGE

select 'ADDON CHARGE' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_ADDONCHARGE'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;

select 	"SERVICEINSTANCENUMBER",	"CHARGENAME",	"CHARGEPRICE"

union all

select 	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(CHARGENAME,""),	ifnull(CHARGEPRICE,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_ADDON_CHARGE_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_ADDONCHARGE
;

#####################################################################
## PAYMENT HISTORY

select 'PAYMENT HISTORY' AS TABLENAME;

select column_name
    from information_schema.columns
    where table_name = 'IV_PAYMENTHISTORY'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;


select 	"PAYMENTRECEIPTID",	"BILLINGACCOUNTNUMBER",	"CUSTOMERACCOUNTNUMBER",	"SERVICEINSTANCENUMBER",	"PAYMENTDATE",	"PAYMENTPROCESSEDDATE",	"PAYMENTDESC",	"PAYMENTCURRENCYALIAS",	"PAYMENTMODE",	"PAYMENTTRANSACTIONAMOUNT",	"SERIALNUMBER",	"DEBITDOCUMENTNUMBER",	"CLIENT_ID",	"CONTRACT_ID",	"PAYMENTAMOUNT",	"PAYMENTREASON",	"EXCHANGERATE",	"DISCOUNT",	"INVOICEHARD",	"EMPLOYEEID",	"EMPLOYEENAME",	"EMPLOYEEDEPARTMENT", "ADJUSTEDPAYMENTAMOUNT"
union all
select 	ifnull(PAYMENTRECEIPTID,""),	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(PAYMENTDATE,""),	ifnull(PAYMENTPROCESSEDDATE,""),	ifnull(PAYMENTDESC,""),	ifnull(PAYMENTCURRENCYALIAS,""),	ifnull(PAYMENTMODE,""),	ifnull(PAYMENTTRANSACTIONAMOUNT,""),	ifnull(SERIALNUMBER,""),	ifnull(DEBITDOCUMENTNUMBER,""),	ifnull(CLIENT_ID,""),	ifnull(CONTRACT_ID,""),	ifnull(PAYMENTAMOUNT,""),	ifnull(PAYMENTREASON,""),	ifnull(EXCHANGERATE,""),	ifnull(DISCOUNT,""),	ifnull(INVOICEHARD,""),	ifnull(EMPLOYEEID,""),	ifnull(EMPLOYEENAME,""),	ifnull(EMPLOYEEDEPARTMENT,""),	ifnull(ADJUSTEDPAYMENTAMOUNT,"")


INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_PAYMENT_HISTORY_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_PAYMENTHISTORY
;

#####################################################################
## BILL SUMMARY

select 'BILL SUMMARY' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_BILLSUMMARY'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;


select 	"INVOICESUMMARYID",	"DEBITDOCUMENTNUMBER",	"CREATEDATE",	"SUBTOTAL",	"TAX",	"UNPAID",	"WRITEOFF",	"REMARK",	"DUEDATE",	"TOTALDUE",	"DISPUTED",	"BILLDATE",	"SURCHARGE",	"SYSCURRENCYEXCHANGERATE",	"TOTALAMOUNT",	"DISCOUNTABLE",	"DISCOUNTED",	"TAXABLE",	"FROMDATE",	"TODATE",	"DEPOSIT",	"BILLINGACCOUNTNUMBER",	"CUSTOMERACCOUNTNUMBER",	"ADJUSTEDAMOUNT",	"BILLCYCLE",	"CURRENCYALIAS",	"ORIGINALCURRENCY",	"CREATEDBY",	"PROFORMAINVOICENUMBER",	"CREDITINVOICENUMBER",	"DEBITINVOICENUMBER",	"INVOICETYPE",	"INVOICEHARD",	"INVOICE_PDF_NAME",	"PAYMENTRECEIPTID", "DEBITDOCUMENTNUMBEROLD"
union all
select 	ifnull(INVOICESUMMARYID,""),	ifnull(DEBITDOCUMENTNUMBER,""),	ifnull(CREATEDATE,""),	ifnull(SUBTOTAL,""),	ifnull(TAX,""),	ifnull(UNPAID,""),	ifnull(WRITEOFF,""),	ifnull(REMARK,""),	ifnull(DUEDATE,""),	ifnull(TOTALDUE,""),	ifnull(DISPUTED,""),	ifnull(BILLDATE,""),	ifnull(SURCHARGE,""),	ifnull(SYSCURRENCYEXCHANGERATE,""),	ifnull(TOTALAMOUNT,""),	ifnull(DISCOUNTABLE,""),	ifnull(DISCOUNTED,""),	ifnull(TAXABLE,""),	ifnull(FROMDATE,""),	ifnull(TODATE,""),	ifnull(DEPOSIT,""),	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(ADJUSTEDAMOUNT,""),	ifnull(BILLCYCLE,""),	ifnull(CURRENCYALIAS,""),	ifnull(ORIGINALCURRENCY,""),	ifnull(CREATEDBY,""),	ifnull(PROFORMAINVOICENUMBER,""),	ifnull(CREDITINVOICENUMBER,""),	ifnull(DEBITINVOICENUMBER,""),	ifnull(INVOICETYPE,""),	ifnull(INVOICEHARD,""),	ifnull(INVOICE_PDF_NAME,""), ifnull(PAYMENTRECEIPTID,""), ifnull(DEBITDOCUMENTNUMBEROLD,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_BILL_SUMMARY_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_BILLSUMMARY
;

#####################################################################
## BILL DETAIL

select 'BILL DETAIL' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_BILLDETAIL'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;


select 	"BILLINGACCOUNTNUMBER",	"CUSTOMERACCOUNTNUMBER",	"SERVICEINSTANCENUMBER",	"INVOICEDETAILID",	"INVOICESUMMARYID",	"SERIALNUMBER",	"DEBITDOCUMENTNUMBER",	"NAME",	"RATE",	"ITEMCOUNT",	"SUBTOTAL",	"TAX",	"DISCOUNT",	"DISCOUNTPERCENT",	"TOTALAMOUNT",	"DISCOUNTABLE",	"DISCOUNTED",	"TAXABLE",	"UNPAID",	"WRITEOFF",	"REMARK",	"FROMDATE",	"TODATE",	"BILLCYCLE",	"PRODUCTTYPEID",	"DEPOSIT",	"PRORATIONTYPE",	"ADJUSTEDAMOUNT",	"PACKAGENAME",	"BILLDATE",	"CURRENCYALIAS",	"D_DISCOUNTPCT",	"D_PCTDISCOUNT",	"D_DISCOUNTNAME",	"D_ABSDISCOUNT",	"D_SYSCURRENCYEXCHANGERATE",	"T_RATE",	"T_TAXNAME",	"T_EXEMPTIONRATE",	"T_UNPAID",	"T_WRITEOFF",	"T_TAXRATETYPE",	"T_TAXOVERRIDDEN",	"T_EXEMPTIONAMT",	"T_EXEMPTIONAPPLICABILITY",	"CLIENT_ID",	"CONTRACT_ID",	"RSID",	"ServiceID","DEBITDOCUMENTNUMBEROLD"
union all
select 	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(INVOICEDETAILID,""),	ifnull(INVOICESUMMARYID,""),	ifnull(SERIALNUMBER,""),	ifnull(DEBITDOCUMENTNUMBER,""),	ifnull(NAME,""),	ifnull(RATE,""),	ifnull(ITEMCOUNT,""),	ifnull(SUBTOTAL,""),	ifnull(TAX,""),	ifnull(DISCOUNT,""),	ifnull(DISCOUNTPERCENT,""),	ifnull(TOTALAMOUNT,""),	ifnull(DISCOUNTABLE,""),	ifnull(DISCOUNTED,""),	ifnull(TAXABLE,""),	ifnull(UNPAID,""),	ifnull(WRITEOFF,""),	ifnull(REMARK,""),	ifnull(FROMDATE,""),	ifnull(TODATE,""),	ifnull(BILLCYCLE,""),	ifnull(PRODUCTTYPEID,""),	ifnull(DEPOSIT,""),	ifnull(PRORATIONTYPE,""),	ifnull(ADJUSTEDAMOUNT,""),	ifnull(PACKAGENAME,""),	ifnull(BILLDATE,""),	ifnull(CURRENCYALIAS,""),	ifnull(D_DISCOUNTPCT,""),	ifnull(D_PCTDISCOUNT,""),	ifnull(D_DISCOUNTNAME,""),	ifnull(D_ABSDISCOUNT,""),	ifnull(D_SYSCURRENCYEXCHANGERATE,""),	ifnull(T_RATE,""),	ifnull(T_TAXNAME,""),	ifnull(T_EXEMPTIONRATE,""),	ifnull(T_UNPAID,""),	ifnull(T_WRITEOFF,""),	ifnull(T_TAXRATETYPE,""),	ifnull(T_TAXOVERRIDDEN,""),	ifnull(T_EXEMPTIONAMT,""),	ifnull(T_EXEMPTIONAPPLICABILITY,""),	ifnull(CLIENT_ID,""),	ifnull(CONTRACT_ID,""),	ifnull(RSID,""),	ifnull(ServiceID,""),	ifnull(DEBITDOCUMENTNUMBEROLD,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_BILL_DETAIL_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_BILLDETAIL
;

#####################################################################
## NBD

select 'NBD' AS TABLENAME;

select column_name
    from information_schema.columns
    where table_name = 'IV_NBD'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;

select 	"CUSTOMERACCOUNTNUMBER",	"BILLINGACCOUNTNUMBER",	"LASTBILLINGDATE",	"NEXTBILLINGDATE",	"BILLCYCLE",	"ACCOUNTSTATUS",	"BILLINGDAY"
union all
select 	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(LASTBILLINGDATE,""),	ifnull(NEXTBILLINGDATE,""),	ifnull(BILLCYCLE,""),	ifnull(ACCOUNTSTATUS,""),	ifnull(BILLINGDAY,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_NBD_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_NBD
;

#####################################################################
## DISCOUNT

select 'DISCOUNT' AS TABLENAME;

select column_name
    from information_schema.columns
    where table_name = 'IV_DISCOUNT'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;
    
    
select 	"BILLINGACCOUNTNUMBER",	"CUSTOMERACCOUNTNUMBER",	"BILLCYCLE",	"ACCOUNTSTATUS",	"SERVICENAME",	"DISCOUNTPERCENT",	"DISCOUNTAMOUNT",	"APPROVEDSTATUS",	"APPROVALREASON",	"CYCLECOUNT",	"client_id",	"contract_id",	"SERVICEINSTANCENUMBER"
union all
select 	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(BILLCYCLE,""),	ifnull(ACCOUNTSTATUS,""),	ifnull(SERVICENAME,""),	ifnull(DISCOUNTPERCENT,""),	ifnull(DISCOUNTAMOUNT,""),	ifnull(APPROVEDSTATUS,""),	ifnull(APPROVALREASON,""),	ifnull(CYCLECOUNT,""),	ifnull(client_id,""),	ifnull(contract_id,""),	ifnull(SERVICEINSTANCENUMBER,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_DISCOUNT_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_DISCOUNT
;

#####################################################################
## BALANCE

select 'BALANCE' AS TABLENAME;

select column_name
    from information_schema.columns
    where table_name = 'IV_BALANCE'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;
    
    
select 	"SERVICEINSTANCENUMBER",	"PACKAGENAME",	"PACKAGEQUOTA_GB",	"SUBFROM",	"SUBTO",	"SUBPERIOD",	"CUSTOMERACCOUNTNUMBER",	"BILLINGACCOUNTNUMBER",	"SERVICEACCOUNTNUMBER",	"SERVICEINSTANCEIDENTIFIER",	"SERVICESTATUS",	"CPE_TYPE",	"PACKAGEAMOUNT",	"LASTACTION",	"client_id",	"contract_id",	"LASTUSAGEDATE",	"TOTAL_USAGE_PREADDON_MB",	"LAST_ADD_ON_DATE",	"ADD_ON_TOTAL_MB",	"TOTAL_USAGE_MB",	"TOTAL_USAGE_GB",	"REMAININGSUBPERIOD",	"TOTAL_PACKAGEQUOTA_GB",	"BALANCE_GB"

union all

select 	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(PACKAGENAME,""),	ifnull(PACKAGEQUOTA_GB,""),	ifnull(SUBFROM,""),	ifnull(SUBTO,""),	ifnull(SUBPERIOD,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(SERVICEACCOUNTNUMBER,""),	ifnull(SERVICEINSTANCEIDENTIFIER,""),	ifnull(SERVICESTATUS,""),	ifnull(CPE_TYPE,""),	ifnull(PACKAGEAMOUNT,""),	ifnull(LASTACTION,""),	ifnull(client_id,""),	ifnull(contract_id,""),	ifnull(LASTUSAGEDATE,""),	ifnull(TOTAL_USAGE_PREADDON_MB,""),	ifnull(LAST_ADD_ON_DATE,""),	ifnull(ADD_ON_TOTAL_MB,""),	ifnull(TOTAL_USAGE_MB,""),	ifnull(TOTAL_USAGE_GB,""),	ifnull(REMAININGSUBPERIOD,""),	ifnull(TOTAL_PACKAGEQUOTA_GB,""),	ifnull(BALANCE_GB,"")


INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_BALANCE_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_BALANCE
;

#####################################################################
## CREDIT NOTE

select 'CREDIT NOTE' AS TABLENAME;

select column_name
    from information_schema.columns
    where table_name = 'IV_CREDITNOTE'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;

    
select 	"BILLINGACCOUNTNUMBER",	"CREDITAMOUNT"

union all

select 	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(CREDITAMOUNT,"")


INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_CREDITNOTE_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_CREDITNOTE
;

#####################################################################
## DEBIT NOTE

select 'DEBIT NOTE' AS TABLENAME;

select column_name
    from information_schema.columns
    where table_name = 'IV_DEBITNOTE'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;

    
select 	"BILLINGACCOUNTNUMBER",	"DEBITAMOUNT"

union all

select 	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(DEBITAMOUNT,"")


INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_DEBITNOTE_20210418-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_DEBITNOTE
;

#####################################################################