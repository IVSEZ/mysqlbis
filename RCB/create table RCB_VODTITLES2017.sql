use rcbill;

drop table if exists rcb_vodtitles;

CREATE TABLE `rcb_vodtitles` (
`﻿ID` int(11) DEFAULT NULL ,
`NATIVE_LNG` varchar(255) DEFAULT NULL ,
`ORIGINALTITLE` varchar(255) DEFAULT NULL ,
`ORIGINALTITLE_LNG` varchar(255) DEFAULT NULL ,
`RELEASEDATE` datetime DEFAULT NULL ,
`GROUPID` varchar(255) DEFAULT NULL ,
`SEASONID` varchar(255) DEFAULT NULL ,
`EPISODE` varchar(255) DEFAULT NULL ,
`DURATION` time DEFAULT NULL ,
`ASPECTRATIOID` int(11) DEFAULT NULL ,
`MINIMUMVIEWERAGE` varchar(255) DEFAULT NULL ,
`IMDBTITLEREF` varchar(255) DEFAULT NULL ,
`ENABLED` int(11) DEFAULT NULL ,
`BROWSABLE` int(11) DEFAULT NULL ,
`RATINGID` int(11) DEFAULT NULL ,
`ADI_AMS_ASSET_NAME` varchar(255) DEFAULT NULL ,
`ADI_AMS_PROVIDER` varchar(255) DEFAULT NULL ,
`ADI_AMS_PRODUCT` varchar(255) DEFAULT NULL ,
`ADI_AMS_VERSION_MINOR` varchar(255) DEFAULT NULL ,
`ADI_AMS_VERSION_MAJOR` varchar(255) DEFAULT NULL ,
`ADI_AMS_DESCRIPTION` varchar(255) DEFAULT NULL ,
`ADI_AMS_CREATION_DATE` varchar(255) DEFAULT NULL ,
`ADI_AMS_PROVIDER_ID` varchar(255) DEFAULT NULL ,
`ADI_AMS_ASSET_ID` varchar(255) DEFAULT NULL ,
`ADI_STUDIO` varchar(255) DEFAULT NULL ,
`ADI_BILLING_ID` varchar(255) DEFAULT NULL ,
`ADI_PUBLISH_ID` varchar(255) DEFAULT NULL ,
`ADI_PROVIDER_QA_CONTACT` varchar(255) DEFAULT NULL ,
`LICENSINGWINDOWSTART` varchar(255) DEFAULT NULL ,
`LICENSINGWINDOWEND` varchar(255) DEFAULT NULL ,
`PARENTID` varchar(255) DEFAULT NULL ,
`TITLETYPE` varchar(255) DEFAULT NULL ,
`NUMSEASONS` varchar(255) DEFAULT NULL ,
`NUMEPISODES` varchar(255) DEFAULT NULL ,
`SEASON` varchar(255) DEFAULT NULL ,
`TESTING` int(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	

) ENGINE=InnoDB DEFAULT CHARSET=latin1;
