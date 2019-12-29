CREATE TABLE `intern_rcbwork` (
  `URL` text,
  `CLIENTID` int(11) DEFAULT NULL,
  `CONTRACTID` int(11) DEFAULT NULL,
  `PAYMENTID` int(11) DEFAULT NULL,
  `CLIENTNAME` text,
  `EVENT` text,
  `ACTION` text,
  `USER` text,
  `STARTTIME` datetime DEFAULT NULL,
  `RTR` int(11) DEFAULT NULL,
  `ENDTIME` datetime DEFAULT NULL,
  `AMOUNT` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SELECT * FROM rcbill_my.intern_rcbwork;