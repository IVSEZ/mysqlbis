use rcbill;

drop table if exists rcb_mxk;

CREATE TABLE `rcb_mxk` (
`MXK_NAME` varchar(255) DEFAULT NULL ,
`MXK_INTERFACE` varchar(255) DEFAULT NULL ,
`SERIAL_NUM` varchar(255) DEFAULT NULL ,
`VENDOR_ID` varchar(255) DEFAULT NULL ,
`MODEL_ID` varchar(255) DEFAULT NULL ,
`ONT_VERSION` varchar(255) DEFAULT NULL ,
`SWARE_VERSION` varchar(255) DEFAULT NULL ,
`ONT_RXPWR` decimal(12,5) DEFAULT NULL ,
`OLT_RXPWR` decimal(12,5) DEFAULT NULL ,
`ONT_DISTANCE` decimal(12,5) DEFAULT NULL ,

`INSERTEDON` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


create index IDXrcbmxk1 on rcbill.rcb_mxk (SERIAL_NUM);

create index IDXrcbmxk2 on rcbill.rcb_mxk (INSERTEDON);

