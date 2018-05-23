drop table allpayments;

CREATE TABLE `allpayments` (
  `paymentid` bigint(20) DEFAULT NULL,
  `paymentdate` datetime,
  `paymentamount` decimal(12,5),


  `debtfrom` date NULL,
  `debtto` date NULL,
  `contractid` varchar(255),
  `service` varchar(255),
  `servicetype` varchar(255),

  `clientname` varchar(255),
  `clientcode` varchar(255)
 

) ENGINE=InnoDB CHARSET UTF8;

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