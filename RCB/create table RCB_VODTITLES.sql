use rcbill;

drop table if exists rcb_vodtitles;

CREATE TABLE `rcb_vodtitles` (
`ID` int(11) DEFAULT NULL ,
`TITLE` varchar(255) DEFAULT NULL ,
`TITLETYPE` varchar(255) DEFAULT NULL ,
`IMDBTITLEREF` varchar(255) DEFAULT NULL ,
`RESOURCECODE` varchar(255) DEFAULT NULL ,
`RESOURCEORIG` varchar(20) DEFAULT NULL ,
`DURATION` time DEFAULT NULL ,
`DURATIONSEC` int(11) DEFAULT NULL ,
`RELEASEDATE` date DEFAULT NULL ,
`RATINGID` int(11) DEFAULT NULL ,
`SERIES` varchar(255) DEFAULT NULL ,
`SEASON` int(11) DEFAULT NULL ,
`EPISODE` int(11) DEFAULT NULL ,
`UPLOADDATE` datetime DEFAULT NULL ,

`INSERTEDON` datetime DEFAULT NULL	

) ENGINE=InnoDB DEFAULT CHARSET=latin1;



## GET ALL OLD VOD TITLES
insert into rcbill.rcb_vodtitles
(
	select ﻿ID, ORIGINALTITLE as TITLE, titletype, IMDBTITLEREF, NULL as ResourceCode, NULL as RESOURCEORIG
	, DURATION , NULL as DURATIONSEC
	, RELEASEDATE, RATINGID 
	, NULL as SERIES, SEASON, EPISODE
	, NULL as UPLOADDATE, INSERTEDON
	from rcbill.rcb_vodtitles2017
)
;

select * from rcbill.rcb_vodtitles;
/*
use rcbill;
rename table rcbill.rcb_vodtitles to rcbill.rcb_vodtitles2017;

show columns from rcbill.rcb_vodtitles;
alter table rcbill.rcb_vodtitles MODIFY RESOURCEORIG varchar(20);
*/
