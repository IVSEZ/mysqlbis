use practicedb;

drop table if exists test1;

CREATE TABLE `test1` (
`MAC_ADDRESS` varchar(255) DEFAULT NULL ,
`MAC_ADDRESS_CLEAN1` varchar(255) DEFAULT NULL ,
`MAC_ADDRESS_CLEAN2` varchar(255) DEFAULT NULL ,
`IP_ADDRESS` varchar(255) DEFAULT NULL ,
`HFC_NODE` varchar(255) DEFAULT NULL ,
`MAC_STATE` varchar(255) DEFAULT NULL ,
`PRIM_SID` varchar(255) DEFAULT NULL ,
`RXPWR_DBMV` decimal(11,2) DEFAULT NULL ,
`TIMING_OFFSET` int(11) DEFAULT NULL ,
`NUM_CPE` int(11) DEFAULT NULL ,
`DIP` varchar(255) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


create index IDXrcbcmts1 on practicedb.test1 (MAC_ADDRESS_CLEAN2);
create index IDXrcbcmts2 on practicedb.test1 (INSERTEDON);
