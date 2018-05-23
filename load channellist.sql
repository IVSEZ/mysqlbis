use rcbill_my;


LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill_my\\channellist08032017.csv'
REPLACE INTO TABLE `rcbill_my`.`channellist` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@id ,
@channelno ,
@origname ,
@channelsource ,
@channelname ,
@def ,
@timeshift,
@category ,
@country ,
@isp 
) 
set 
/*
  `channelid` int(8) NOT NULL AUTO_INCREMENT,
  `isp` varchar(45) DEFAULT NULL, 
  `channelno` int(4) DEFAULT NULL,
  `origname` varchar(100) DEFAULT NULL,
  `channelname` varchar(100) DEFAULT NULL,
  `channelsource` varchar(50) DEFAULT NULL,
  `def` varchar(10) DEFAULT NULL,
  `timeshift` varchar(10) DEFAULT NULL,
  `channelcategory` varchar(100) DEFAULT NULL,
  `channelcountry` varchar(100) DEFAULT NULL,
*/
isp=upper(trim(@ISP)) ,
channelno=@channelno,
origname=@origname,
channelname=upper(trim(@channelname)),
channelsource=upper(trim(@channelsource)),
def=upper(trim(@def)),
timeshift=upper(trim(@timeshift)),
channelcategory=upper(trim(@category)),
channelcountry=upper(trim(@country))
;



-- select * from channellist;
select isp, channelno, channelname, channelsource, def, timeshift, channelcategory, channelcountry 
from channellist
order by isp desc, channelno asc, channelname asc
;

select channelid, channelname, isp
from channellist
;