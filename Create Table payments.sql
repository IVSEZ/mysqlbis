drop table payments;

/*
(dummy) clid,ID,External Reference,Entry Date,EntryDate,EntryTime,User,CASH POINT,Client Code,
ClientCode,Client,ClientName,Amount,Place,Service,Service Type,
Debt period,DebtFromOld,DebtToOld,DebtFrom,DebtTo,Comment,Client Class,PaymentType


(dummy) clid,ID,External Reference,Entry Date,EntryDate,EntryTime,User,CASH POINT,Client Code,
ClientCode,Client,ClientName,Amount,Place,Service,Service Type,
Debt period,DebtFromOld,DebtToOld,DebtFrom,DebtTo,Comment,Client Class,PaymentType,,,
*/

CREATE TABLE `payments` (
  `id` int(11) DEFAULT NULL,
  `paymentid` bigint(20),
  `paymentdate` datetime,
  -- `entrytime` time,
  
  `entryuser` varchar(255),
  `cashpoint` varchar(255),
  `clientcode` varchar(255),
  
  `clientname` varchar(255),
  `amount` decimal(12,5),
  `paymentchannel` varchar(255),
  
  `service` varchar(255),
  `servicetype` varchar(255),
  `debtfrom` date NULL,
  
  `debtto` date NULL,
  `entryusercomment` text,
  `clientclass` varchar(255),
  
  `paymenttype` varchar(255)

) ENGINE=InnoDB CHARSET UTF8;

