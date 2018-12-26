use rcbill;

drop table if exists client_match_phone;

CREATE TABLE `client_match_phone` (
`CLIENT_CODE` varchar(255) DEFAULT NULL ,
`CLIENT_NAME` varchar(255) DEFAULT NULL ,
`CLIENT_PHONE` varchar(255) DEFAULT NULL ,
`M_CLIENT_CODE` varchar(255) DEFAULT NULL ,
`M_CLIENT_NAME` varchar(255) DEFAULT NULL ,
`M_CLIENT_PHONE` varchar(255) DEFAULT NULL ,
`M_SCORE` INT(3) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


create index IDXcmp1 on rcbill.client_match_phone (CLIENT_CODE);

create index IDXcmp2 on rcbill.client_match_phone (M_CLIENT_CODE);

