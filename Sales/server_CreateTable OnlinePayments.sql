use rcbill_my;

drop table if exists onlinepayments;


CREATE TABLE `onlinepayments` (
`CLIENTID` int(11) DEFAULT NULL ,
`PAYMENTID` int(11) DEFAULT NULL ,
`EXTERNALREF` varchar(255) DEFAULT NULL ,
`PAYMENTDATE` datetime DEFAULT NULL ,
`USER` varchar(255) DEFAULT NULL ,
`CASHPOINT` varchar(255) DEFAULT NULL ,
`CLIENTCODE` varchar(255) DEFAULT NULL ,
`CLIENTNAME` varchar(255) DEFAULT NULL ,
`PAYMENTAMOUNT` decimal(12,5) DEFAULT NULL ,
`PAYMENTPLACE` varchar(255) DEFAULT NULL ,
`SERVICE` varchar(255) DEFAULT NULL ,
`PACKAGE` varchar(255) DEFAULT NULL ,
`DEBTPERIOD` varchar(255) DEFAULT NULL ,
`DEBTPERIODFROM` date DEFAULT NULL ,
`DEBTPERIODTO` date DEFAULT NULL ,

`PAYMENTCOMMENT` varchar(255) DEFAULT NULL ,
`CLIENTCLASS` varchar(255) DEFAULT NULL ,
`CONTRACTCODE` varchar(255) DEFAULT NULL ,
`CANCELLATIONREASON` varchar(255) DEFAULT NULL ,
`RECEIPTID` int(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL
 

) ENGINE=InnoDB CHARSET UTF8;

CREATE INDEX IDXop1
ON rcbill_my.onlinepayments (CLIENTID);

CREATE INDEX IDXop2
ON rcbill_my.onlinepayments (CLIENTCODE);

CREATE INDEX IDXop3
ON rcbill_my.onlinepayments (CONTRACTCODE);

CREATE INDEX IDXop4
ON rcbill_my.onlinepayments (CLIENTNAME);
/*
@paymentid,
@paymentdate,
@paymentamount
@debtfrom,
@debtto
@contractid,
@service,
@servicetype,
@clientname,
@clientcode,


*/