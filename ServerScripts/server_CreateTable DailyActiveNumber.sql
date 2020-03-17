use rcbill_my;

drop table if exists dailyactivenumber;

CREATE TABLE `dailyactivenumber` (
  `ACTIVENUMBERID` varchar(255) NULL,
  `PERIOD` date NOT NULL,
  `PERIODDAY` int DEFAULT NULL,
  `PERIODMTH` int DEFAULT NULL,
  `PERIODYEAR` int DEFAULT NULL,
  `WEEKDAY` varchar(45) DEFAULT NULL,
  `MTHNAME` varchar(45) DEFAULT NULL,
  `CLIENTID` int(11) DEFAULT NULL,
  `CONTRACTID` int(11) DEFAULT NULL,
  `CLIENTCODE` varchar(255) NULL,
  `CONTRACTCODE` varchar(255) NULL,
  `CONTRACTDATE` datetime DEFAULT NULL,
  `VALIDITY` varchar(255) NULL,
  `CONTRACTSTARTDATE` datetime DEFAULT NULL,
  `CONTRACTENDDATE` datetime DEFAULT NULL,
  `CONTRACTSTATE` varchar(255) NULL,
  `LASTACTION` varchar(255) NULL,
  `LASTCHANGE` datetime DEFAULT NULL,
  `ACTIVECOUNT` int(2) NULL,
  `DEVICESCOUNT` int(2) NULL,
  `PROMOTION` varchar(255) NULL,
  `CLIENTNAME` varchar(255) NULL,
  `CLIENTCLASSOLD` varchar(100) NULL,
  `CLIENTCLASS` varchar(100) NULL,
  `CLIENTTYPE` varchar(100) NULL,
  `REPRESENTATIVE` varchar(255) NULL,
  `PHONE` varchar(100) NULL,
  `ADDRESS` varchar(255) NULL,
  `SERVICE` varchar(100) NULL,
  `SERVICECATEGORY` varchar(100) NULL,
  `SERVICESUBCATEGORY` varchar(100) NULL,
  `SERVICETYPE` varchar(100) NULL,
  `PREVIOUSSERVICETYPE` varchar(100) NULL,
  `PRICE` decimal(12,5) NULL,
  `REGIONALLEVEL1` varchar(45) DEFAULT NULL,
  `REGIONALLEVEL2` varchar(45) DEFAULT NULL,
  `REGIONALLEVEL3` varchar(45) DEFAULT NULL,
  `REGION` varchar(45) DEFAULT NULL,
  `REPORTED` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL


) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop index IDXdan1 on dailyactivenumber;
drop index IDXdan2 on dailyactivenumber;
drop index IDXdan3 on dailyactivenumber;
drop index IDXdan4 on dailyactivenumber;
drop index IDXdan5 on dailyactivenumber;
drop index IDXdan6 on dailyactivenumber;

SHOW INDEX FROM dailyactivenumber;

/*

CREATE INDEX IDXdan1
ON dailyactivenumber (PERIOD);

CREATE INDEX IDXdan2
ON dailyactivenumber (SERVICECATEGORY);

CREATE INDEX IDXdan3
ON dailyactivenumber (SERVICESUBCATEGORY);

CREATE INDEX IDXdan4
ON dailyactivenumber (SERVICETYPE);

CREATE INDEX IDXdan5
ON dailyactivenumber (CLIENTCLASS);

CREATE INDEX IDXdan6
ON dailyactivenumber (CLIENTTYPE);
*/

CREATE INDEX IDXdan7
ON dailyactivenumber (CLIENTID);

CREATE INDEX IDXdan8
ON dailyactivenumber (CONTRACTID);

CREATE INDEX IDXdan9
ON dailyactivenumber (CLIENTCODE);

CREATE INDEX IDXdan10
ON dailyactivenumber (CONTRACTCODE);

CREATE INDEX IDXdan11
ON dailyactivenumber (PERIODMTH, PERIODYEAR);


CREATE INDEX IDXdan11
ON dailyactivenumber (CLIENTNAME);



