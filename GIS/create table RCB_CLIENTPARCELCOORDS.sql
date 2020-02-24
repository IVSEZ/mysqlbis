use rcbill;

drop table if exists rcb_clientparcelcoords;

CREATE TABLE `rcb_clientparcelcoords` (
`clientcode` varchar(255) DEFAULT NULL ,
`clientname` varchar(255) DEFAULT NULL ,
`clientparcel` varchar(255) DEFAULT NULL ,
`coord_x` decimal(15,15) DEFAULT NULL ,
`coord_y` decimal(15,15) DEFAULT NULL ,
`latitude` decimal(15,15) DEFAULT NULL ,
`longitude` decimal(15,15) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


create index IDXrcbcps1 on rcbill.rcb_clientparcelcoords (clientcode);

create index IDXrcbcps2 on rcbill.rcb_clientparcelcoords (INSERTEDON);

