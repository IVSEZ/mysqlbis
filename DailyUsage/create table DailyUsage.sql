use rcbill_my;

drop table if exists dailyusage;

/*
ID,ContractID,SERVICEID,CSID,DevTypeID,
PhoneNo,UserName,Password,Address,
IP,NATIP,DeviceName,MAC,SerNo,GKID,
ProtNo,CreditLimit,ID_OLD,UpdDate,USERID,ActivatedDate,
NoTrigger,AddressID,CustomConfig,OutVLAN
*/
CREATE TABLE `dailyusage` (
`DATESTART` date DEFAULT NULL ,
`DATEEND` date DEFAULT NULL ,
`CATEGORY` varchar(255) DEFAULT NULL ,
`SERVICE` varchar(255) DEFAULT NULL ,
`CLIENT` varchar(255) DEFAULT NULL ,
`CLIENTNAME` varchar(255) DEFAULT NULL ,
`CLIENTID` int(11) DEFAULT NULL ,
`CLIENTCODE` varchar(255) DEFAULT NULL ,
`DEVICE` varchar(255) DEFAULT NULL ,
`TRAFFICTYPE` varchar(255) DEFAULT NULL ,
`TIMEZONE` varchar(255) DEFAULT NULL ,
`DESTINATION` varchar(255) DEFAULT NULL ,
`TRAFFIC_MB` decimal(12,5) DEFAULT NULL ,
`BILLABLE_DURATION_MIN` decimal(12,5) DEFAULT NULL ,
`ACTUAL_DURATION_MIN` decimal(12,5) DEFAULT NULL ,
`PRICE` decimal(12,5) DEFAULT NULL ,
`PRICE_VAT` decimal(12,5) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL 
) ENGINE=InnoDB CHARSET UTF8;


show index from rcbill_my.dailyusage;

create index IDXdu1 on rcbill_my.dailyusage (clientcode);
create index IDXdu2 on rcbill_my.dailyusage (datestart);
create index IDXdu3 on rcbill_my.dailyusage (dateend);


