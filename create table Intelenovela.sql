CREATE TABLE `intelenovela` (
  `clientcode` varchar(255),
  `clientname` varchar(255),
  `servicetype` varchar(255),
  `paydate` date DEFAULT NULL,
  `paymentamt` decimal(12,5) DEFAULT NULL,
  `substart` date DEFAULT NULL,
  `subend` date DEFAULT NULL,
  `isdup` int(11) DEFAULT NULL,
  `iscontinuous` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
