use rcbill_my;

drop table if exists dailygamingusage;

/*
ID,ContractID,SERVICEID,CSID,DevTypeID,
PhoneNo,UserName,Password,Address,
IP,NATIP,DeviceName,MAC,SerNo,GKID,
ProtNo,CreditLimit,ID_OLD,UpdDate,USERID,ActivatedDate,
NoTrigger,AddressID,CustomConfig,OutVLAN
*/
CREATE TABLE `dailygamingusage` (
`DATESTART` date DEFAULT NULL ,
`DATEEND` date DEFAULT NULL ,
`GAMINGCATEGORY` varchar(255) DEFAULT NULL ,
`GAMINGNAME` varchar(255) DEFAULT NULL ,
`IP` varchar(255) DEFAULT NULL ,
`TOTALBYTES` bigint(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL 
) ENGINE=InnoDB CHARSET UTF8;


-- alter table rcbill_my.dailygamingusage modify `DATESTART` date;
-- alter table rcbill_my.dailygamingusage modify `DATEEND` date;


-- show index from rcbill_my.dailygamingusage;

create index IDXdgu1 on rcbill_my.dailygamingusage (IP);
create index IDXdgu2 on rcbill_my.dailygamingusage (datestart);
create index IDXdgu3 on rcbill_my.dailygamingusage (dateend);