use rcbill_my;

drop table if exists activenumberna;

CREATE TABLE `activenumberna` (
  `activenumberid` bigint(8) NOT NULL AUTO_INCREMENT,
  `periodorig` varchar(45) NOT NULL, 
  `period` date NOT NULL,
  `periodday` int DEFAULT NULL,
  `periodmth` int DEFAULT NULL,
  `periodyear` int DEFAULT NULL,
  `weekday` varchar(45) DEFAULT NULL,
  `mthname` varchar(45) DEFAULT NULL,
  `baseservice` varchar(45) DEFAULT NULL,
  `service` varchar(45) DEFAULT NULL,
  `servicecategory` varchar(45) DEFAULT NULL,
  `servicesubcategory` varchar(45) DEFAULT NULL,
  `servicetypeold` varchar(100) DEFAULT NULL,
  `servicetypeold1` varchar(45) DEFAULT NULL,
  `servicetype` varchar(45) DEFAULT NULL,
  `clientclassold` varchar(45) DEFAULT NULL,
  `clientclass` varchar(45) DEFAULT NULL,
  `clienttype` varchar(45) DEFAULT NULL,
  `regionallevel1` varchar(45) DEFAULT NULL,
  `regionallevel2` varchar(45) DEFAULT NULL,
  `regionallevel3` varchar(45) DEFAULT NULL,
  `regionold` varchar(45) DEFAULT NULL,
  `region` varchar(45) DEFAULT NULL,
  `distributor` varchar(45) DEFAULT NULL,
  `promotion` varchar(255) DEFAULT NULL,
  `validity` varchar(255) DEFAULT NULL,
  `open` int(11) DEFAULT NULL,
  `new` int(11) DEFAULT NULL,
  `newconverted` int(11) DEFAULT NULL,
  `renew` int(11) DEFAULT NULL,
  `closed` int(11) DEFAULT NULL,
  `closednonpayment` int(11) DEFAULT NULL,
  `suspended` int(11) DEFAULT NULL,
  `closedconverted` int(11) DEFAULT NULL,
  `closedother` int(11) DEFAULT NULL,
  `disconnected` int(11) DEFAULT NULL,
  `disconnectedtotal` int(11) DEFAULT NULL,
  `disconnectedall` int(11) DEFAULT NULL,
  `connected` int(11) DEFAULT NULL,
  `connectedtotal` int(11) DEFAULT NULL,
  `pendingorders` int(11) DEFAULT NULL,
  `totalopened` int(11) DEFAULT NULL,
  `totalclosed` int(11) DEFAULT NULL,
  `difference` int(11) DEFAULT NULL,
  `totalcheck` int(11) DEFAULT NULL,
  `decommissioned` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `reported` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`activenumberid`),
  UNIQUE KEY `activenumberid_UNIQUE` (`activenumberid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



CREATE INDEX IDXan1
ON activenumberna (period);

CREATE INDEX IDXan2
ON activenumberna (servicecategory);

CREATE INDEX IDXan3
ON activenumberna (servicesubcategory);

CREATE INDEX IDXan4
ON activenumberna (servicetype);

CREATE INDEX IDXan5
ON activenumberna (clientclass);

CREATE INDEX IDXan6
ON activenumberna (clienttype);

CREATE INDEX IDXan7
ON activenumberna (decommissioned);

CREATE INDEX IDXan8
ON activenumberna (reported);
