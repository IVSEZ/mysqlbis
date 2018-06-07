use rcbill_my;

drop table if exists ccrota;

CREATE TABLE `ccrota` (
<<<<<<< HEAD
`CCROTAID` int NOT NULL auto_increment,
=======
`CCROTAID` int not null auto_increment,
>>>>>>> 3abc54fa668796f09c0373b88ec58b577e2a6650
`CCDATE` date DEFAULT NULL ,
`CCSHIFT` varchar(255) DEFAULT NULL ,
`CCNUMBER` varchar(255) DEFAULT NULL ,
`CCAGENT` varchar(255) DEFAULT NULL ,
`COMMENT` varchar(255) DEFAULT NULL ,
-- ,
<<<<<<< HEAD
-- `INSERTEDON` datetime DEFAULT NULL 
primary key (`CCROTAID`)
=======
-- `INSERTEDON` datetime DEFAULT NULL
primary key (`CCROTAID`) 
>>>>>>> 3abc54fa668796f09c0373b88ec58b577e2a6650
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

