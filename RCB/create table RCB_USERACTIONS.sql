use rcbill;

drop table if exists rcb_useractions;



CREATE TABLE `rcb_useractions` (
`ID` bigint(25) DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`STARTTIME` datetime DEFAULT NULL ,
`NUMBER` int(11) DEFAULT NULL ,
`ENDTIME` datetime DEFAULT NULL ,
`COMMENT` varchar(255) DEFAULT NULL ,
`LABEL` varchar(255) DEFAULT NULL ,
`URL` varchar(255) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`PAYMENTID` int(11) DEFAULT NULL ,
`AMOUNT` decimal(12,5) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	

) ENGINE=InnoDB CHARSET UTF8;



