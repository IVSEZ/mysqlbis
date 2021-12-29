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

/*
-- add new column


ALTER TABLE rcbill.rcb_mxk
ADD COLUMN MXK_IP varchar(100) after MXK_NAME;


ALTER TABLE rcbill.rcb_mxk
ADD COLUMN ME_PROFILE varchar(100) after VENDOR_ID;


ALTER TABLE rcbill.rcb_mxk
ADD COLUMN MXK_CARD smallint(4) after MXK_IP;

ALTER TABLE rcbill.rcb_mxk
ADD COLUMN MXK_CARDNAME varchar(255) after MXK_CARD;


ALTER TABLE rcbill.rcb_mxk
ADD COLUMN ONU_ADDED varchar(255) after ME_PROFILE;

ALTER TABLE rcbill.rcb_mxk
ADD COLUMN OP_STATUS varchar(50) after ONT_DISTANCE;

*/