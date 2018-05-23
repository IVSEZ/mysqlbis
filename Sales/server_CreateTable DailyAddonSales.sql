use rcbill_my;

drop table if exists dailyaddonsales;

CREATE TABLE `dailyaddonsales` (
`SALESID` int(11) DEFAULT NULL ,
`EXTERNALREF` varchar(255) DEFAULT NULL ,
`PAYMENTDATE` datetime DEFAULT NULL ,
`CLIENTID` int(11) DEFAULT NULL ,
`CLIENTCODE` varchar(255) DEFAULT NULL ,
`CLIENTNAME` varchar(255) DEFAULT NULL ,
`PAYMENTAMOUNT` decimal(12,5) DEFAULT NULL ,
`SALESTYPE` varchar(255) DEFAULT NULL ,
`DEBTPERIOD` varchar(255) DEFAULT NULL ,
`PLACE` varchar(255) DEFAULT NULL ,
`CASHPOINT` varchar(255) DEFAULT NULL ,
`CONFIRMSTATUS` int(11) DEFAULT NULL ,
`SALESCOMMENT` varchar(255) DEFAULT NULL ,
`CONTRACTCODE` varchar(255) DEFAULT NULL ,
`CANCELLATIONREASON` varchar(255) DEFAULT NULL ,
`RECEIPTID` int(11) DEFAULT NULL ,



`INSERTEDON` datetime DEFAULT NULL 



) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE INDEX IDXDADS1
ON dailyaddonsales (clientcode);

/*
CREATE INDEX IDXDS2
ON dailysales (Contract);
*/

SHOW INDEX FROM dailyaddonsales;