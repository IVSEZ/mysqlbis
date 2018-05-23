use rcbill;

drop table if exists rcb_traffictypes;


CREATE TABLE `rcb_traffictypes` (
`ID` int(11) DEFAULT NULL ,
`NAME` varchar(255) DEFAULT NULL ,
`TRAFFICID` int(11) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,

`INSERTEDON` datetime DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;




-- drop index IDXinvoiceheader on rcb_traffictypes;

