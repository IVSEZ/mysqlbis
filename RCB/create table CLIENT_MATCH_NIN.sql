use rcbill;

drop table if exists client_match_nin;

CREATE TABLE `client_match_nin` (
`CLIENT_CODE` varchar(255) DEFAULT NULL ,
`CLIENT_NAME` varchar(255) DEFAULT NULL ,
`CLIENT_NIN` varchar(255) DEFAULT NULL ,
`M_CLIENT_CODE` varchar(255) DEFAULT NULL ,
`M_CLIENT_NAME` varchar(255) DEFAULT NULL ,
`M_CLIENT_NIN` varchar(255) DEFAULT NULL ,
`M_SCORE` INT(3) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


create index IDXcmn1 on rcbill.client_match_nin (CLIENT_CODE);

create index IDXcmn2 on rcbill.client_match_nin (M_CLIENT_CODE);

