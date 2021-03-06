use rcbill_my;

drop table if exists ccrota;

CREATE TABLE `ccrota` (
`CCROTAID` int not null auto_increment,
`CCDATE` date DEFAULT NULL ,
`CCSHIFT` varchar(255) DEFAULT NULL ,
`CCNUMBER` varchar(255) DEFAULT NULL ,
`CCAGENT` varchar(255) DEFAULT NULL ,
`COMMENT` varchar(255) DEFAULT NULL ,
-- ,
-- `INSERTEDON` datetime DEFAULT NULL
primary key (`CCROTAID`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop index IDXCD1 on ccrota;

CREATE INDEX IDXCD1
ON ccrota (CCDATE, CCSHIFT, CCNUMBER);