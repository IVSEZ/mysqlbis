-- SET SESSION sql_mode = '';

use rcbill;

-- REMOVE OLD TITLES FROM 2018
SET SQL_SAFE_UPDATES = 0;
delete from rcbill.rcb_vodtitles where id>1000;


-- UPLOAD LATEST TITLES

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\ALLVOD2TITLES-14122020.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_vodtitles` CHARACTER SET UTF8 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
(
@id ,
@Title ,
@TitleType ,
@IMDBTitleRef ,
@ResourceCode ,
@Duration ,
@DurationSec ,
@ReleaseDate ,
@RatingID ,
@Series ,
@Season ,
@Episode ,
@UploadDate 
) 
set 

ID=@id ,
TITLE=trim(upper(@Title)) ,
TITLETYPE=trim(upper(@TitleType)) ,
IMDBTITLEREF=trim(upper(@IMDBTitleRef)) ,
RESOURCECODE=@ResourceCode ,
RESOURCEORIG=@ResourceCode ,
DURATION=DATE_FORMAT(time(@Duration),'%H:%i:%s') ,
DURATIONSEC=@DurationSec ,
RELEASEDATE=date(@ReleaseDate) ,
RATINGID=@RatingID ,
SERIES=trim(upper(@Series)) ,
SEASON=@Season ,
EPISODE=@Episode ,
UPLOADDATE=@UploadDate ,
INSERTEDON=now()

;

SET SQL_SAFE_UPDATES = 0;
delete from rcbill.rcb_vodtitles where id=0 or title is null;

SELECT COUNT(*) AS VODTITLES FROM rcbill.rcb_vodtitles;
-- select * from rcbill.rcb_vodtitles where id>1000 and titletype='T';
-- select * from rcbill_my.rep_vodranking2018;


select titletype, count(*) as typecount
from rcbill.rcb_vodtitles
where id>1000
group by titletype
with rollup;

-- 
/*
CREATE INDEX IDXRCBVODTITLE1
ON rcbill.rcb_vodtitles (RESOURCEORIG);
*/
-- show index from rcbill.rcb_vodtitles;