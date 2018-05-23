use rcbill;

drop table if exists rcb_techregions;


CREATE TABLE `rcb_techregions` (
  `NO` int(11) DEFAULT NULL,
  `INTERFACENAME` VARCHAR(255) DEFAULT NULL,
  `NODENAME` VARCHAR(255) DEFAULT NULL,
  `LATITUDE` VARCHAR(255) DEFAULT NULL,
  `LONGITUDE` VARCHAR(255) DEFAULT NULL,
  `DECIMALLAT` DECIMAL(24,12) DEFAULT NULL,
  `DECIMALLONG` decimal(24,12) DEFAULT NULL,
  `DISTRICT` VARCHAR(255) DEFAULT NULL,
  `SUBDISTRICT` VARCHAR(255) DEFAULT NULL,
  `TYPE` VARCHAR(55) DEFAULT NULL,
  `INSERTEDON` DATETIME DEFAULT NULL
  
  
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
