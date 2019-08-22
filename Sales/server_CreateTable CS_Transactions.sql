use rcbill_my;

drop table if exists cs_transactions;


CREATE TABLE `cs_transactions` (
  `CYBERSOURCEMERCHANTID` varchar(255),
  `DATEANDTIME` datetime DEFAULT NULL,
  `REQUESTID` varchar(255) DEFAULT NULL,
  `MERCHANTREFNO` varchar(255),
  `CLIENTCODE` varchar(255),
  `PAYMENTDATE` datetime ,
  `LASTNAME` varchar(255),
  `FIRSTNAME` varchar(255),
  `EMAILADDRESS` varchar(255),
  `PAYMENTAMOUNT` decimal(20,5) DEFAULT NULL,
  `PAYMENTCURRENCY` varchar(255),
  `ACCOUNTSUFFIX` varchar(255),
  `APPLICATIONS` varchar(255),
  `ACCOUNTTYPE` varchar(255),
  `DIGITALPAYMENTMETHOD` varchar(255),
  `TRANSREFNO` varchar(255) DEFAULT NULL,
  `AUTHIND` varchar(255),
  `PARTORIGTRANID` varchar(255),
  `DEVICEID` varchar(255),
  `TERMINALSERIALNO` varchar(255),
  `PROCESSOR` varchar(255),
  `TOKENID` varchar(255),
  `BUSAPPLICATIONID` varchar(255),
  `TERMINALID` varchar(255),
  `PATRANID` varchar(255),
  `XID` varchar(255),
  `MerchantDefinedData1` varchar(255),
  `MerchantDefinedData2` varchar(255),
  `MerchantDefinedData3` varchar(255),
  `MerchantDefinedData4` varchar(255),
  `CLIENTUSER` varchar(255),
  `SALESSLIPNO` varchar(255),
  `AUTHCODE` varchar(255) DEFAULT NULL,
  `ACQMERCHANTID` varchar(255),
  `JCCATERMINALID` varchar(255),
  `BILLINGADDRESS1` varchar(255),
  `BILLINGCITY` varchar(255),
  `BILLINGSTATE` varchar(255),
  `BILLINGPOSTALCODE` varchar(255),
  `BILLINGPHONENO` varchar(255),
  `IPADDRESS` varchar(255),
  `BILLINGCOUNTRY` varchar(255),
  `SHIPFIRSTNAME` varchar(255),
  `SHIPLASTNAME` varchar(255),
  `SHIPADDRESS1` varchar(255),
  `SHIPCITY` varchar(255),
  `SHIPSTATE` varchar(255),
  `SHIPCOUNTRY` varchar(255),
  `SHIPPOSTALCODE` varchar(255),
  `SHIPPHONENO` varchar(255),
  `CUSTOMERID` varchar(255),
  `CLIENTAPPLICATION` varchar(255),
  `INSERTEDON` datetime DEFAULT NULL
 ) ENGINE=InnoDB CHARSET utf8;

-- drop index IDXcst1 on rcbill_my.onlinepayments;

CREATE INDEX IDXcst1
ON rcbill_my.cs_transactions (CLIENTCODE);

/*
CREATE INDEX IDXcst2
ON rcbill_my.onlinepayments (CLIENTCODE);

CREATE INDEX IDXcst3
ON rcbill_my.onlinepayments (CONTRACTCODE);

CREATE INDEX IDXcst4
ON rcbill_my.onlinepayments (CLIENTNAME);
*/
/*
@paymentid,
@paymentdate,
@paymentamount
@debtfrom,
@debtto
@contractid,
@service,
@servicetype,
@clientname,
@clientcode,


*/