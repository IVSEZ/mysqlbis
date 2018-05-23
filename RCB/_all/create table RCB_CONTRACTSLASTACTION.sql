use rcbill;

drop table rcb_contractslastaction;


CREATE TABLE `rcb_contractslastaction` (
  `ID` int(11) DEFAULT NULL,
  `Value` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
