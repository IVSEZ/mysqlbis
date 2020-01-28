use rcbill;

drop table if exists rcb_companygroups;

CREATE TABLE `rcb_companygroups` (
  `ID` int(11) DEFAULT NULL,
  `Name` text,
  `ID_OLD` text,
  `UPDDATE` datetime DEFAULT NULL,
  `USERID` text,
  `RestrictionsLevel` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

