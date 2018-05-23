use rcbill;

drop table if exists rcb_ipusageold;


CREATE TABLE `rcb_ipusageold` (
`USAGEID` int(11) DEFAULT NULL ,
`DEVICEID` int(11) DEFAULT NULL ,
`USAGEDATE` datetime DEFAULT NULL ,
`TRAFFICTYPE` int(11) DEFAULT NULL ,
`CLIENTIP` bigint(25) DEFAULT NULL ,
`USAGEDIRECTION` varchar(255) DEFAULT NULL ,
`ZONEID` int(11) DEFAULT NULL ,
`TIMEZONEID` int(11) DEFAULT NULL ,
`INVNO` int(11) DEFAULT NULL ,
`OCTETS` bigint(25) DEFAULT NULL ,
`COST` decimal(12,5) DEFAULT NULL ,
`CURRENCY` varchar(255) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`CSID` int(11) DEFAULT NULL ,
`SERVICEID` int(11) DEFAULT NULL ,
`COSTOLD` decimal(12,5) DEFAULT NULL ,

`INSERTEDON` datetime DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;




-- drop index IDXinvoiceheader on rcb_ticketcomments;

