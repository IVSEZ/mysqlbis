use rcbill_my;

drop table if exists dhcp_hosts;

/*
ID,ContractID,SERVICEID,CSID,DevTypeID,
PhoneNo,UserName,Password,Address,
IP,NATIP,DeviceName,MAC,SerNo,GKID,
ProtNo,CreditLimit,ID_OLD,UpdDate,USERID,ActivatedDate,
NoTrigger,AddressID,CustomConfig,OutVLAN
*/
CREATE TABLE `dhcp_hosts` (
`ID` varchar(255) DEFAULT NULL ,
`HOST` varchar(255) DEFAULT NULL ,
`NAME` varchar(255) DEFAULT NULL ,
`IPOLD` varchar(255) DEFAULT NULL ,
`STATUS` varchar(255) DEFAULT NULL ,
`EXPIRY` datetime DEFAULT NULL ,
`CPE_MAC` varchar(255) DEFAULT NULL ,
`CM_MAC` varchar(255) DEFAULT NULL ,
`RELAY_IP` varchar(255) DEFAULT NULL ,
`CLIENT_IP` varchar(255) DEFAULT NULL ,
`IP_POOL` varchar(255) DEFAULT NULL ,

`INSERTEDON` datetime DEFAULT NULL 
) ENGINE=InnoDB CHARSET UTF8;



