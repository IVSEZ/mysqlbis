use rcbill_extract;

-- select * from rcbill_extract.IV_CUSTOMERACCOUNT;

-- override GROUP_CONCAT limit of 1024 characters to avoid a truncated result
set session group_concat_max_len = 1000000;

#####################################################################
## CUSTOMER ACCOUNT

select column_name
    from information_schema.columns
    where table_name = 'IV_CUSTOMERACCOUNT'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;


select "FIRSTNAME",	"LASTNAME",	"CITY",	"STATE",	"COUNTRY",	"DISTRICT",	"SUBDISTRICT",	"ZIPCODE",	"EMAILID",	"BUSINESSEMAILID",	"MOBILENUMBER",	"PHONEHOME",	"PHONEOFFICE",	"FAXNUMBER",	"PARENTACCOUNTNUMBER",	"ACCOUNTNUMBER",	"ACCOUNTSTATUS",	"USERNAME",	"CREATEDDATE",	"ACTIVATIONDATE",	"STATUSCHANGEDATE",	"PRIMARY_ID_TYPE",	"PRIMARY_ID_VALUE",	"SECONDARY_ID_TYPE",	"SECONDARY_ID_VALUE",	"TAXNUMBERINDICATOR",	"BUILDINGNAME",	"BIRTHDATE",	"STREETNAME",	"PREFERREDLANGUAGE",	"PROPERTYTYPE",	"PARCELNUMBER",	"LANDMARK",	"LATITUDE",	"LONGITUDE",	"FLOOR",	"XCOORDINATE",	"YCOORDINATE"
union all
select 	ifnull(FIRSTNAME,""),	ifnull(LASTNAME,""),	ifnull(CITY,""),	ifnull(STATE,""),	ifnull(COUNTRY,""),	ifnull(DISTRICT,""),	ifnull(SUBDISTRICT,""),	ifnull(ZIPCODE,""),	ifnull(EMAILID,""),	ifnull(BUSINESSEMAILID,""),	ifnull(MOBILENUMBER,""),	ifnull(PHONEHOME,""),	ifnull(PHONEOFFICE,""),	ifnull(FAXNUMBER,""),	ifnull(PARENTACCOUNTNUMBER,""),	ifnull(ACCOUNTNUMBER,""),	ifnull(ACCOUNTSTATUS,""),	ifnull(USERNAME,""),	ifnull(CREATEDDATE,""),	ifnull(ACTIVATIONDATE,""),	ifnull(STATUSCHANGEDATE,""),	ifnull(PRIMARY_ID_TYPE,""),	ifnull(PRIMARY_ID_VALUE,""),	ifnull(SECONDARY_ID_TYPE,""),	ifnull(SECONDARY_ID_VALUE,""),	ifnull(TAXNUMBERINDICATOR,""),	ifnull(BUILDINGNAME,""),	ifnull(BIRTHDATE,""),	ifnull(STREETNAME,""),	ifnull(PREFERREDLANGUAGE,""),	ifnull(PROPERTYTYPE,""),	ifnull(PARCELNUMBER,""),	ifnull(LANDMARK,""),	ifnull(LATITUDE,""),	ifnull(LONGITUDE,""),	ifnull(FLOOR,""),	ifnull(XCOORDINATE,""),	ifnull(YCOORDINATE,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_CUSTOMER_ACCOUNT_20200811-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_CUSTOMERACCOUNT
;


#####################################################################
## BILLING ACCOUNT

select column_name
    from information_schema.columns
    where table_name = 'IV_BILLINGACCOUNT'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;



select 	"FIRSTNAME",	"LASTNAME",	"BILLCYCLE",	"BILLDELIVERYMODE",	"CURRENCY",	"CITY",	"DISTRICT",	"SUBDISTRICT",	"STATE",	"COUNTRY",	"ZIPCODE",	"EMAILID",	"BUSINESSEMAILID",	"MOBILENUMBER",	"PHONEHOME",	"PHONEOFFICE",	"FAXNUMBER",	"CUSTOMERACCOUNTNUMBER",	"BILLINGACCOUNTNUMBER",	"ACCOUNTSTATUS",	"CREATEDDATE",	"ACTIVATIONDATE",	"STATUSCHANGEDATE",	"LASTACTION",	"BILLFORMATTYPE",	"BUILDINGNAME",	"BUILDINGTYPE",	"STREETNAME",	"PROPERTYTYPE",	"PARCELNUMBER",	"LANDMARK",	"LATITUDE",	"LONGITUDE",	"FLOOR",	"CHARGINGPATTERN",	"XCOORDINATE",	"YCOORDINATE",	"RATINGPLAN",	"CREDITCLASSNAME"

union all

select 	ifnull(FIRSTNAME,""),	ifnull(LASTNAME,""),	ifnull(BILLCYCLE,""),	ifnull(BILLDELIVERYMODE,""),	ifnull(CURRENCY,""),	ifnull(CITY,""),	ifnull(DISTRICT,""),	ifnull(SUBDISTRICT,""),	ifnull(STATE,""),	ifnull(COUNTRY,""),	ifnull(ZIPCODE,""),	ifnull(EMAILID,""),	ifnull(BUSINESSEMAILID,""),	ifnull(MOBILENUMBER,""),	ifnull(PHONEHOME,""),	ifnull(PHONEOFFICE,""),	ifnull(FAXNUMBER,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(ACCOUNTSTATUS,""),	ifnull(CREATEDDATE,""),	ifnull(ACTIVATIONDATE,""),	ifnull(STATUSCHANGEDATE,""),	ifnull(LASTACTION,""),	ifnull(BILLFORMATTYPE,""),	ifnull(BUILDINGNAME,""),	ifnull(BUILDINGTYPE,""),	ifnull(STREETNAME,""),	ifnull(PROPERTYTYPE,""),	ifnull(PARCELNUMBER,""),	ifnull(LANDMARK,""),	ifnull(LATITUDE,""),	ifnull(LONGITUDE,""),	ifnull(FLOOR,""),	ifnull(CHARGINGPATTERN,""),	ifnull(XCOORDINATE,""),	ifnull(YCOORDINATE,""),	ifnull(RATINGPLAN,""),	ifnull(CREDITCLASSNAME,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_BILLING_ACCOUNT_20200811-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_BILLINGACCOUNT
;


#####################################################################
## SERVICE ACCOUNT

select column_name
    from information_schema.columns
    where table_name = 'IV_SERVICEACCOUNT'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;



select 	"FIRSTNAME",	"LASTNAME",	"ADDRESSONE",	"ADDRESSTWO",	"ADDRESSTHREE",	"CITY",	"DISTRICT",	"SUBDISTRICT",	"STATE",	"COUNTRY",	"ZIPCODE",	"EMAILID",	"BUSINESSEMAILID",	"MOBILENUMBER",	"PHONEHOME",	"PHONEOFFICE",	"FAXNUMBER",	"CUSTOMERACCOUNTNUMBER",	"SERVICEACCOUNTNUMBER",	"ACCOUNTSTATUS",	"CREATEDDATE",	"ACTIVATIONDATE",	"STATUSCHANGEDATE",	"TECHNOLOGY",	"BUILDINGNAME",	"BUILDINGTYPE",	"STREETNAME",	"CHANNELPARTNERID",	"PROPERTYTYPE",	"PARCELNUMBER",	"LANDMARK",	"LATITUDE",	"LONGITUDE",	"FLOOR",	"EMPLOYEEID",	"EMPLOYEENAME",	"EMPLOYEEDEPARTMENT",	"MXKCODE",	"MXKNAME",	"CARDNO",	"PORTNO",	"SPLITTER",	"NETWORKACCESSPOINT",	"NETWORKSVLAN",	"VLANID",	"SERVICECATEGORY",	"ACTIVESERVICE",	"CUSTOMERSUBCATEGORY",	"XCOORDINATE",	"YCOORDINATE",	"HFCNODE",	"HFCNODENAME"

union all

select 	ifnull(FIRSTNAME,""),	ifnull(LASTNAME,""),	ifnull(ADDRESSONE,""),	ifnull(ADDRESSTWO,""),	ifnull(ADDRESSTHREE,""),	ifnull(CITY,""),	ifnull(DISTRICT,""),	ifnull(SUBDISTRICT,""),	ifnull(STATE,""),	ifnull(COUNTRY,""),	ifnull(ZIPCODE,""),	ifnull(EMAILID,""),	ifnull(BUSINESSEMAILID,""),	ifnull(MOBILENUMBER,""),	ifnull(PHONEHOME,""),	ifnull(PHONEOFFICE,""),	ifnull(FAXNUMBER,""),	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(SERVICEACCOUNTNUMBER,""),	ifnull(ACCOUNTSTATUS,""),	ifnull(CREATEDDATE,""),	ifnull(ACTIVATIONDATE,""),	ifnull(STATUSCHANGEDATE,""),	ifnull(TECHNOLOGY,""),	ifnull(BUILDINGNAME,""),	ifnull(BUILDINGTYPE,""),	ifnull(STREETNAME,""),	ifnull(CHANNELPARTNERID,""),	ifnull(PROPERTYTYPE,""),	ifnull(PARCELNUMBER,""),	ifnull(LANDMARK,""),	ifnull(LATITUDE,""),	ifnull(LONGITUDE,""),	ifnull(FLOOR,""),	ifnull(EMPLOYEEID,""),	ifnull(EMPLOYEENAME,""),	ifnull(EMPLOYEEDEPARTMENT,""),	ifnull(MXKCODE,""),	ifnull(MXKNAME,""),	ifnull(CARDNO,""),	ifnull(PORTNO,""),	ifnull(SPLITTER,""),	ifnull(NETWORKACCESSPOINT,""),	ifnull(NETWORKSVLAN,""),	ifnull(VLANID,""),	ifnull(SERVICECATEGORY,""),	ifnull(ACTIVESERVICE,""),	ifnull(CUSTOMERSUBCATEGORY,""),	ifnull(XCOORDINATE,""),	ifnull(YCOORDINATE,""),	ifnull(HFCNODE,""),	ifnull(HFCNODENAME,"")


INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_SERVICE_ACCOUNT_20200811-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_SERVICEACCOUNT
;

#####################################################################
## SERVICE INSTANCE

select column_name
    from information_schema.columns
    where table_name = 'IV_SERVICEINSTANCE'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;



select 	"CUSTOMERACCOUNTNUMBER",	"BILLINGACCOUNTNUMBER",	"SERVICEACCOUNTNUMBER",	"SERVICEINSTANCEIDENTIFIER",	"SERVICEINSTANCENUMBER",	"PACKAGENAME",	"SERVICESTATUS",	"USERNAME",	"CREATEDDATE",	"ACTIVATIONDATE",	"STATUSCHANGEDDATE",	"LASTACTION",	"PACKAGEAMOUNT",	"CPE_TYPE",	"CPE_ID",	"CONTRACTSTARTDATE",	"CONTRACTENDDATE",	"SERVICEREMARKS",	"EXPIRYDATE",	"OVERRIDDEN",	"FSAN",	"ServiceID",	"ServiceRateID",	"SERVICESTARTDATE",	"SERVICEENDDATE",	"clientcode",	"contractcode",	"serviceinstancestatus"

union all

select 	ifnull(CUSTOMERACCOUNTNUMBER,""),	ifnull(BILLINGACCOUNTNUMBER,""),	ifnull(SERVICEACCOUNTNUMBER,""),	ifnull(SERVICEINSTANCEIDENTIFIER,""),	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(PACKAGENAME,""),	ifnull(SERVICESTATUS,""),	ifnull(USERNAME,""),	ifnull(CREATEDDATE,""),	ifnull(ACTIVATIONDATE,""),	ifnull(STATUSCHANGEDDATE,""),	ifnull(LASTACTION,""),	ifnull(PACKAGEAMOUNT,""),	ifnull(CPE_TYPE,""),	ifnull(CPE_ID,""),	ifnull(CONTRACTSTARTDATE,""),	ifnull(CONTRACTENDDATE,""),	ifnull(SERVICEREMARKS,""),	ifnull(EXPIRYDATE,""),	ifnull(OVERRIDDEN,""),	ifnull(FSAN,""),	ifnull(ServiceID,""),	ifnull(ServiceRateID,""),	ifnull(SERVICESTARTDATE,""),	ifnull(SERVICEENDDATE,""),	ifnull(clientcode,""),	ifnull(contractcode,""),	ifnull(serviceinstancestatus,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_SERVICE_INSTANCE_20200811-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_SERVICEINSTANCE
;

#####################################################################
## INVENTORY

select column_name
    from information_schema.columns
    where table_name = 'IV_INVENTORY'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;



select 	"SERVICEINSTANCENUMBER",	"INVENTORYNUMBER",	"SERIALNUMBER",	"INVENTORYSUBTYPE",	"REMARK",	"STAFFNAME",	"SERVICESTARTDATE",	"SERVICEENDDATE",	"SERVICESTATUS",	"SERVICEINSTANCESTATUS",	"SOURCECHANNEL"

union all

select 	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(INVENTORYNUMBER,""),	ifnull(SERIALNUMBER,""),	ifnull(INVENTORYSUBTYPE,""),	ifnull(REMARK,""),	ifnull(STAFFNAME,""),	ifnull(SERVICESTARTDATE,""),	ifnull(SERVICEENDDATE,""),	ifnull(SERVICESTATUS,""),	ifnull(SERVICEINSTANCESTATUS,""),	ifnull(SOURCECHANNEL,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_INVENTORY_20200811-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_INVENTORY
;


#####################################################################
## ADDON 

select column_name
    from information_schema.columns
    where table_name = 'IV_ADDON'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;

select 	"SERVICEINSTANCENUMBER",	"PACKAGENAME",	"SERVICESTARTDATE",	"SERVICEENDDATE",	"OVERRIDDEN"

union all

select 	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(PACKAGENAME,""),	ifnull(SERVICESTARTDATE,""),	ifnull(SERVICEENDDATE,""),	ifnull(OVERRIDDEN,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_ADDON_20200811-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_ADDON
;

#####################################################################
## ADDON CHARGE

select column_name
    from information_schema.columns
    where table_name = 'IV_ADDONCHARGE'
    and table_schema = 'rcbill_extract'
    order by ordinal_position
    ;

select 	"SERVICEINSTANCENUMBER",	"CHARGENAME",	"CHARGEPRICE"

union all

select 	ifnull(SERVICEINSTANCENUMBER,""),	ifnull(CHARGENAME,""),	ifnull(CHARGEPRICE,"")

INTO OUTFILE '/var/www/html/STL_EXTRACT/IV_ADDON_CHARGE_20200811-1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_extract.IV_ADDONCHARGE
;
