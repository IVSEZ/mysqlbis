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
`DATESTART` datetime DEFAULT NULL ,
`DATEEND` datetime DEFAULT NULL ,
`CATEGORY` varchar(255) DEFAULT NULL ,
`IP` varchar(255) DEFAULT NULL ,
`TOTALBYTES` bigint(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL 
) ENGINE=InnoDB CHARSET UTF8;



