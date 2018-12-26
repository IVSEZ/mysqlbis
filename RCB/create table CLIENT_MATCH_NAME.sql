use rcbill;

drop table if exists client_match_name;

CREATE TABLE `client_match_name` (
`CLIENT_CODE` varchar(255) DEFAULT NULL ,
`CLIENT_NAME` varchar(255) DEFAULT NULL ,
`M_CLIENT_CODE` varchar(255) DEFAULT NULL ,
`M_CLIENT_NAME` varchar(255) DEFAULT NULL ,
`M_SCORE` INT(3) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


create index IDXcmm1 on rcbill.client_match_name (CLIENT_CODE);

create index IDXcmm2 on rcbill.client_match_name (M_CLIENT_CODE);

