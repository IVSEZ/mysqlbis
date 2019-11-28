use rcbill_my;

drop table if exists dailystreamingusage;

/*
ID,ContractID,SERVICEID,CSID,DevTypeID,
PhoneNo,UserName,Password,Address,
IP,NATIP,DeviceName,MAC,SerNo,GKID,
ProtNo,CreditLimit,ID_OLD,UpdDate,USERID,ActivatedDate,
NoTrigger,AddressID,CustomConfig,OutVLAN
*/
CREATE TABLE `dailystreamingusage` (
`DATESTART` date DEFAULT NULL ,
`DATEEND` date DEFAULT NULL ,
`STREAMINGCATEGORY` varchar(255) DEFAULT NULL ,
`STREAMINGNAME` varchar(255) DEFAULT NULL ,
`IP` varchar(255) DEFAULT NULL ,
`INCOMINGBYTES` bigint(11) DEFAULT NULL ,
`OUTGOINGBYTES` bigint(11) DEFAULT NULL ,
`TOTALBYTES` bigint(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL 
) ENGINE=InnoDB CHARSET UTF8;


-- alter table rcbill_my.dailystreamingusage modify `DATESTART` date;
-- alter table rcbill_my.dailystreamingusage modify `DATEEND` date;


-- show index from rcbill_my.dailystreamingusage;

create index IDXdsu1 on rcbill_my.dailystreamingusage (IP);
create index IDXdsu2 on rcbill_my.dailystreamingusage (datestart);
create index IDXdsu3 on rcbill_my.dailystreamingusage (dateend);

-- SELECT * FROM rcbill_my.dailystreamingusage ;