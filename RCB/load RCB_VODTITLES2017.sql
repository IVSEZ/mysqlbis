-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTITLES-03092017.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_vodtitles` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@﻿ID ,
@Native_LNG ,
@OriginalTitle ,
@OriginalTitle_LNG ,
@ReleaseDate ,
@GroupID ,
@SeasonID ,
@Episode ,
@Duration ,
@AspectRatioID ,
@MinimumViewerAge ,
@IMDBTitleRef ,
@Enabled ,
@Browsable ,
@RatingID ,
@ADI_AMS_Asset_Name ,
@ADI_AMS_Provider ,
@ADI_AMS_Product ,
@ADI_AMS_Version_Minor ,
@ADI_AMS_Version_Major ,
@ADI_AMS_Description ,
@ADI_AMS_Creation_Date ,
@ADI_AMS_Provider_ID ,
@ADI_AMS_Asset_ID ,
@ADI_Studio ,
@ADI_Billing_ID ,
@ADI_Publish_ID ,
@ADI_Provider_QA_Contact ,
@LicensingWindowStart ,
@LicensingWindowEnd ,
@ParentID ,
@TitleType ,
@NumSeasons ,
@NumEpisodes ,
@Season ,
@Testing 
) 
set 

﻿ID=@﻿ID ,
NATIVE_LNG=upper(trim(@Native_LNG)) ,
ORIGINALTITLE=upper(trim(@OriginalTitle)) ,
ORIGINALTITLE_LNG=upper(trim(@OriginalTitle_LNG)) ,
RELEASEDATE=@ReleaseDate ,
GROUPID=@GroupID ,
SEASONID=@SeasonID ,
EPISODE=@Episode ,
DURATION=DATE_FORMAT(@Duration,'%H:%i:%s')  ,
ASPECTRATIOID=@AspectRatioID ,
MINIMUMVIEWERAGE=@MinimumViewerAge ,
IMDBTITLEREF=upper(trim(@IMDBTitleRef)) ,
ENABLED=@Enabled ,
BROWSABLE=@Browsable ,
RATINGID=@RatingID ,
ADI_AMS_ASSET_NAME=@ADI_AMS_Asset_Name ,
ADI_AMS_PROVIDER=@ADI_AMS_Provider ,
ADI_AMS_PRODUCT=@ADI_AMS_Product ,
ADI_AMS_VERSION_MINOR=@ADI_AMS_Version_Minor ,
ADI_AMS_VERSION_MAJOR=@ADI_AMS_Version_Major ,
ADI_AMS_DESCRIPTION=@ADI_AMS_Description ,
ADI_AMS_CREATION_DATE=@ADI_AMS_Creation_Date ,
ADI_AMS_PROVIDER_ID=@ADI_AMS_Provider_ID ,
ADI_AMS_ASSET_ID=@ADI_AMS_Asset_ID ,
ADI_STUDIO=@ADI_Studio ,
ADI_BILLING_ID=@ADI_Billing_ID ,
ADI_PUBLISH_ID=@ADI_Publish_ID ,
ADI_PROVIDER_QA_CONTACT=@ADI_Provider_QA_Contact ,
LICENSINGWINDOWSTART=@LicensingWindowStart ,
LICENSINGWINDOWEND=@LicensingWindowEnd ,
PARENTID=@ParentID ,
TITLETYPE=@TitleType ,
NUMSEASONS=@NumSeasons ,
NUMEPISODES=@NumEpisodes ,
SEASON=@Season ,
TESTING=@Testing ,
INSERTEDON=now()



;

select * from rcbill.rcb_vodtitles;
select * from rcbill.rcb_vodtitles where testing=0;