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


INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_CUSTOMER_ACCOUNT_20201026-1.csv'
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

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_BILLING_ACCOUNT_20201026-1.csv'
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



select 	"FIRSTNAME",	"LASTNAME",	"ADDRESSONE",	"ADDRESSTWO",	"ADDRESSTHREE",	"CITY",	"DISTRICT",	"SUBDISTRICT",	"STATE",	"COUNTRY",	"ZIPCODE",	"EMAILID",	"BUSINESSEMAILID",	"MOBILENUMBER",	"PHONEHOME",	"PHONEOFFICE",	"FAXNUMBER",	"CUSTOMERACCOUNTNUMBER",	"SERVICEACCOUNTNUMBER",	"ACCOUNTSTATUS",	"CREATEDDATE",	"ACTIVATIONDATE",	"STATUSCHANGEDATE",	"TECHNOLOGY",	"BUILDINGNAME",	"BUILDINGTYPE",	"STREETNAME",	"CHANNELPARTNERID",	"PROPERTYTYPE",	"PARCELNUMBER",	"LANDMARK",	"LATITUDE",	"LONGITUDE",	"FLOOR",	"EMPLOYEEID",	"EMPLOYEENAME",	"EMPLOYEEDEPARTMENT",	"MXKCODE",	"MXKNAME",	"CARDNO",	"PORTNO",	"SPLITTER",	"NETWORKACCESSPOINT",	"NETWORKSVLAN",	"VLANID",	"SERVICECATEGORY",	"ACTIVESERVICE",	"CUSTOMERSUBCATEGORY",	"XCOORDINATE",	"YCOORDINATE",	"HFCNODE",	"HFCNODENAME"

union all

select 	ifnull(FIRSTNAME,""),	ifnull(LASTNAME,""),	ifnull(ADDRESSONE,""),	ifnull(ADDRESSTWO,""),	ifnull(ADDRESSTHREE,""),	ifnull(CITY,""),	ifnull(DISTRICT,""),	ifnull(SUBDISTRICT,""),	ifnull(STATE,""),	ifnull(COUNTRY,""),	ifnull(ZIPCODE,""),	ifnull(EMAILID,""),	ifnull(BUSINESSEMAILID,""),	ifnull(MOBILENUMBER,""),	ifnull(PHONEHOME,""),	ifnull(PHONEOFFICE,""),	ifnull(FAXNUMBER,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(SERVICEACCOUNTNUMBER,""),	ifnull(ACCOUNTSTATUS,""),	ifnull(CREATEDDATE,""),	ifnull(ACTIVATIONDATE,""),	ifnull(STATUSCHANGEDATE,""),	ifnull(TECHNOLOGY,""),	ifnull(BUILDINGNAME,""),	ifnull(BUILDINGTYPE,""),	ifnull(STREETNAME,""),	ifnull(CHANNELPARTNERID,""),	ifnull(PROPERTYTYPE,""),	ifnull(PARCELNUMBER,""),	ifnull(LANDMARK,""),	ifnull(LATITUDE,""),	ifnull(LONGITUDE,""),	ifnull(FLOOR,""),	ifnull(EMPLOYEEID,""),	ifnull(EMPLOYEENAME,""),	ifnull(EMPLOYEEDEPARTMENT,""),	ifnull(MXKCODE,""),	ifnull(MXKNAME,""),	ifnull(CARDNO,""),	ifnull(PORTNO,""),	ifnull(SPLITTER,""),	ifnull(NETWORKACCESSPOINT,""),	ifnull(NETWORKSVLAN,""),	ifnull(VLANID,""),	ifnull(SERVICECATEGORY,""),	ifnull(ACTIVESERVICE,""),	ifnull(CUSTOMERSUBCATEGORY,""),	ifnull(XCOORDINATE,""),	ifnull(YCOORDINATE,""),	ifnull(HFCNODE,""),	ifnull(HFCNODENAME,"")


INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_SERVICE_ACCOUNT_20201026-1.csv'
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



select 	"CUSTOMERACCOUNTNUMBER",	"BILLINGACCOUNTNUMBER",	"SERVICEACCOUNTNUMBER",	"SERVICEINSTANCEIDENTIFIER",	"SERVICEINSTANCENUMBER",	"PACKAGENAME",	"SERVICESTATUS",	"USERNAME",	"CREATEDDATE",	"ACTIVATIONDATE",	"STATUSCHANGEDDATE",	"LASTACTION",	"PACKAGEAMOUNT",	"CPE_TYPE",	"CPE_ID",	"CONTRACTSTARTDATE",	"CONTRACTENDDATE",	"SERVICEREMARKS",	"EXPIRYDATE",	"OVERRIDDEN",	"FSAN",	"ServiceID",	"ServiceRateID",	"SERVICESTARTDATE",	"SERVICEENDDATE",	"clientcode",	"contractcode",	"serviceinstancestatus"

union all

select 	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(SERVICEACCOUNTNUMBER,""),	ifnull(SERVICEINSTANCEIDENTIFIER,""),	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(PACKAGENAME,""),	ifnull(SERVICESTATUS,""),	ifnull(USERNAME,""),	ifnull(CREATEDDATE,""),	ifnull(ACTIVATIONDATE,""),	ifnull(STATUSCHANGEDDATE,""),	ifnull(LASTACTION,""),	ifnull(PACKAGEAMOUNT,""),	ifnull(CPE_TYPE,""),	ifnull(CPE_ID,""),	ifnull(CONTRACTSTARTDATE,""),	ifnull(CONTRACTENDDATE,""),	ifnull(SERVICEREMARKS,""),	ifnull(EXPIRYDATE,""),	ifnull(OVERRIDDEN,""),	ifnull(FSAN,""),	ifnull(ServiceID,""),	ifnull(ServiceRateID,""),	ifnull(SERVICESTARTDATE,""),	ifnull(SERVICEENDDATE,""),	ifnull(clientcode,""),	ifnull(contractcode,""),	ifnull(serviceinstancestatus,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_SERVICE_INSTANCE_20201026-1.csv'
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

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_SERVICE_INSTANCE_CHARGE_20201026-1.csv'
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



select 	"SERVICEINSTANCENUMBER",	"INVENTORYNUMBER",	"SERIALNUMBER",	"INVENTORYSUBTYPE",	"REMARK",	"STAFFNAME",	"SERVICESTARTDATE",	"SERVICEENDDATE",	"SERVICESTATUS",	"SERVICEINSTANCESTATUS",	"SOURCECHANNEL"

union all

select 	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(INVENTORYNUMBER,""),	ifnull(SERIALNUMBER,""),	ifnull(INVENTORYSUBTYPE,""),	ifnull(REMARK,""),	ifnull(STAFFNAME,""),	ifnull(SERVICESTARTDATE,""),	ifnull(SERVICEENDDATE,""),	ifnull(SERVICESTATUS,""),	ifnull(SERVICEINSTANCESTATUS,""),	ifnull(SOURCECHANNEL,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_INVENTORY_20201026-1.csv'
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

select 	"SERVICEINSTANCENUMBER",	"PACKAGENAME",	"SERVICESTARTDATE",	"SERVICEENDDATE",	"OVERRIDDEN"

union all

select 	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(PACKAGENAME,""),	ifnull(SERVICESTARTDATE,""),	ifnull(SERVICEENDDATE,""),	ifnull(OVERRIDDEN,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_ADDON_20201026-1.csv'
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

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_ADDON_CHARGE_20201026-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_ADDONCHARGE
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


select 	"INVOICESUMMARYID",	"DEBITDOCUMENTNUMBER",	"CREATEDATE",	"SUBTOTAL",	"TAX",	"UNPAID",	"WRITEOFF",	"REMARK",	"DUEDATE",	"TOTALDUE",	"DISPUTED",	"BILLDATE",	"SURCHARGE",	"SYSCURRENCYEXCHANGERATE",	"TOTALAMOUNT",	"DISCOUNTABLE",	"DISCOUNTED",	"TAXABLE",	"FROMDATE",	"TODATE",	"DEPOSIT",	"BILLINGACCOUNTNUMBER",	"CUSTOMERACCOUNTNUMBER",	"ADJUSTEDAMOUNT",	"BILLCYCLE",	"CURRENCYALIAS",	"ORIGINALCURRENCY",	"CREATEDBY",	"PROFORMAINVOICENUMBER",	"CREDITINVOICENUMBER",	"DEBITINVOICENUMBER",	"INVOICETYPE",	"INVOICEHARD",	"INVOICE_PDF_NAME"
union all
select 	ifnull(INVOICESUMMARYID,""),	ifnull(DEBITDOCUMENTNUMBER,""),	ifnull(CREATEDATE,""),	ifnull(SUBTOTAL,""),	ifnull(TAX,""),	ifnull(UNPAID,""),	ifnull(WRITEOFF,""),	ifnull(REMARK,""),	ifnull(DUEDATE,""),	ifnull(TOTALDUE,""),	ifnull(DISPUTED,""),	ifnull(BILLDATE,""),	ifnull(SURCHARGE,""),	ifnull(SYSCURRENCYEXCHANGERATE,""),	ifnull(TOTALAMOUNT,""),	ifnull(DISCOUNTABLE,""),	ifnull(DISCOUNTED,""),	ifnull(TAXABLE,""),	ifnull(FROMDATE,""),	ifnull(TODATE,""),	ifnull(DEPOSIT,""),	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(ADJUSTEDAMOUNT,""),	ifnull(BILLCYCLE,""),	ifnull(CURRENCYALIAS,""),	ifnull(ORIGINALCURRENCY,""),	ifnull(CREATEDBY,""),	ifnull(PROFORMAINVOICENUMBER,""),	ifnull(CREDITINVOICENUMBER,""),	ifnull(DEBITINVOICENUMBER,""),	ifnull(INVOICETYPE,""),	ifnull(INVOICEHARD,""),	ifnull(INVOICE_PDF_NAME,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_BILL_SUMMARY_20201026-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_BILLSUMMARY
;


