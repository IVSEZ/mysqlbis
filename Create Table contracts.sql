drop table contracts;

-- (dummy) cid	(dummy) dummy1	(dummy) clid	Code	Contract Type	Contract Date	
-- Last Action	Client Code	ClientCode	Client	ClientName	Phones	Usage Address

CREATE TABLE `contracts` (
  `id` int(11) DEFAULT NULL,
  `contractid` varchar(255),
  `contracttype` varchar(255),
  `contractdate` datetime,
  `lastaction` varchar(255),
  `clientcode` varchar(255),
  `clientname` varchar(255),
  `phone` varchar(255),
  `usageaddress` varchar(255)


) ENGINE=InnoDB CHARSET UTF8;

