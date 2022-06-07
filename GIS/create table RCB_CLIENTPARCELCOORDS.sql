use rcbill;

drop table if exists rcb_clientparcelcoords;

CREATE TABLE `rcb_clientparcelcoords` (
`clientcode` varchar(255) DEFAULT NULL ,
`clientname` varchar(255) DEFAULT NULL ,
`clientparcel` varchar(255) DEFAULT NULL ,
`coord_x` varchar(255) DEFAULT NULL ,
`coord_y` varchar(255) DEFAULT NULL ,
`latitude` varchar(255) DEFAULT NULL ,
`longitude` varchar(255) DEFAULT NULL ,
`INSERTEDON` timestamp DEFAULT current_timestamp
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


create index IDXrcbcps1 on rcbill.rcb_clientparcelcoords (clientcode);

create index IDXrcbcps2 on rcbill.rcb_clientparcelcoords (INSERTEDON);

-- select * from rcbill.rcb_clientparcelcoords where latitude <> 0 and date(insertedon)=(select max(date(insertedon)) from rcbill.rcb_clientparcelcoords);


select * from rcbill.rcb_clientparcelcoords where latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords));
-- 

/*
set sql_safe_updates=0;
delete from rcbill.rcb_clientparcelcoords where date(insertedon)='2020-03-22';
*/


/*

ALTER TABLE rcbill.rcb_clientparcelcoords
ADD COLUMN geo_district VARCHAR(255) NOT NULL AFTER longitude,
ADD COLUMN geo_address VARCHAR(255) NOT NULL AFTER geo_district;

*/

describe  rcbill.rcb_clientparcelcoords ;
show create rcbill.rcb_clientparcelcoords ;

SHOW COLUMNS FROM rcbill.rcb_clientparcelcoords;


ALTER TABLE rcbill.rcb_clientparcelcoords MODIFY COLUMN INSERTEDON date not null DEFAULT CURRENT_DATE;
use rcbill;

DELIMITER ;;
CREATE TRIGGER `inserted_date` BEFORE INSERT ON `rcb_clientparcelcoords` FOR EACH ROW
BEGIN
    SET NEW.INSERTEDON = date(NOW());
END;;
DELIMITER ;