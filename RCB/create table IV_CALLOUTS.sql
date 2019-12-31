use rcbill;

drop table if exists iv_callouts;



CREATE TABLE `iv_callouts` (
`CALLDATETIME` datetime DEFAULT NULL ,
`CALLDATE` date DEFAULT NULL ,
`CLID` varchar(255) DEFAULT NULL ,
`CALLER` varchar(255) DEFAULT NULL ,
`CALLEE` varchar(255) DEFAULT NULL ,
`DCONTEXT` varchar(255) DEFAULT NULL ,
`CHANNEL` varchar(255) DEFAULT NULL ,
`DSTCHANNEL` varchar(255) DEFAULT NULL ,
`DURATION` decimal(12,8) DEFAULT NULL ,
`BILLSEC` decimal(12,8) DEFAULT NULL ,
`DISPOSITION` varchar(255) DEFAULT NULL ,
`DIRECTION` varchar(255) DEFAULT NULL ,
`EXTENSION` varchar(255) DEFAULT NULL ,
`OPERATOR` varchar(255) DEFAULT NULL ,
`CALLCOSTSCR` varchar(255) DEFAULT NULL ,
`CALLCOST` decimal(12,2) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	

) ENGINE=InnoDB CHARSET UTF8;



CREATE INDEX IDXivco1
ON iv_callouts (CALLER);

CREATE INDEX IDXivco2
ON iv_callouts (CALLEE);