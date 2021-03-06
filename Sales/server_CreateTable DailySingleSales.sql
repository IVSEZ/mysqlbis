use rcbill_my;

drop table if exists dailysinglesales;

CREATE TABLE `dailysinglesales` (
`SSALESID` int(11) DEFAULT NULL ,
`CLIENTID` int(11) DEFAULT NULL ,
`EXTERNALREFERENCE` varchar(255) DEFAULT NULL ,
`ENTRYDATE` datetime DEFAULT NULL ,
`USER` varchar(255) DEFAULT NULL ,
`CASHPOINT` varchar(255) DEFAULT NULL ,
`CLIENTCODE` varchar(255) DEFAULT NULL ,
`CLIENTNAME` varchar(255) DEFAULT NULL ,
`SERIALNO` varchar(255) DEFAULT NULL ,
`USERNAME` varchar(255) DEFAULT NULL ,
`AMOUNT` decimal(12,5) DEFAULT NULL ,
`PLACE` varchar(255) DEFAULT NULL ,
`SALESTYPE` varchar(255) DEFAULT NULL ,
`DEBTPERIOD` varchar(255) DEFAULT NULL ,
`SALESCOMMENT` varchar(255) DEFAULT NULL ,


`INSERTEDON` datetime DEFAULT NULL 



) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE INDEX IDXDSS1
ON dailysinglesales (user);

/*
CREATE INDEX IDXDS2
ON dailysales (Contract);
*/

SHOW INDEX FROM dailysinglesales;