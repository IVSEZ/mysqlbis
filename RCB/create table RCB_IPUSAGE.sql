use rcbill;

drop table if exists rcb_ipusage;


CREATE TABLE `rcb_ipusage` (
`USAGEID` int(11) DEFAULT NULL ,
`DEVICEID` int(11) DEFAULT NULL ,
`USAGEDATE` date DEFAULT NULL ,
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



show index from rcbill.rcb_ipusage;
-- select * from rcbill.rcb_ipusage limit 100


	CREATE INDEX idxrcbipu1
	ON rcbill.rcb_ipusage (deviceid);

	CREATE INDEX idxrcbipu2
	ON rcbill.rcb_ipusage (cid);

	CREATE INDEX idxrcbipu3
	ON rcbill.rcb_ipusage (csid);

	CREATE INDEX idxrcbipu4
	ON rcbill.rcb_ipusage (usagedate);
    
    

-- drop index IDXinvoiceheader on rcb_ticketcomments;



