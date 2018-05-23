drop table clients;

CREATE TABLE `clients` (
  `id` int(11) DEFAULT NULL,
  `clientfull` varchar(255),
  `ssn` varchar(255),
--  `address` varchar(255),
  `clientaddress` varchar(255),
  `phone` varchar(255),
  `clientcode` varchar(255),
  `clientname` varchar(255)


) ENGINE=InnoDB CHARSET UTF8;

/*
@id,
@clientfull,
@ssn,
@address,
@clientaddress,
@phone,
@clientcode,
@clientname
*/