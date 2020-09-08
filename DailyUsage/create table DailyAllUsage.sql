use rcbill_my;

drop table if exists dailyallusage_l7;

/*
ID,ContractID,SERVICEID,CSID,DevTypeID,
PhoneNo,UserName,Password,Address,
IP,NATIP,DeviceName,MAC,SerNo,GKID,
ProtNo,CreditLimit,ID_OLD,UpdDate,USERID,ActivatedDate,
NoTrigger,AddressID,CustomConfig,OutVLAN
*/
CREATE TABLE `dailyallusage_l7` (
`DATESTART` date DEFAULT NULL ,
`DATEEND` date DEFAULT NULL ,
`USAGECATEGORY` varchar(255) DEFAULT NULL ,
`USAGENAME` varchar(255) DEFAULT NULL ,
`IP` varchar(255) DEFAULT NULL ,
`INCOMINGBYTES` bigint(11) DEFAULT NULL ,
`OUTGOINGBYTES` bigint(11) DEFAULT NULL ,
`TOTALBYTES` bigint(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL 
) ENGINE=InnoDB CHARSET UTF8;


-- alter table rcbill_my.dailyallusage_l7 modify `DATESTART` date;
-- alter table rcbill_my.dailyallusage_l7 modify `DATEEND` date;


-- show index from rcbill_my.dailyallusage_l7;

create index IDXdsu1 on rcbill_my.dailyallusage_l7 (IP);
create index IDXdsu2 on rcbill_my.dailyallusage_l7 (datestart);
create index IDXdsu3 on rcbill_my.dailyallusage_l7 (dateend);

-- SELECT * FROM rcbill_my.dailyallusage_l7 ;