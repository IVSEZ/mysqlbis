DROP TABLE `rcbill_my`.`datatest`;


CREATE TABLE `datatest` (
  `TestId` bigint(8) NOT NULL AUTO_INCREMENT,
  `PeriodOrig` varchar(45) default null,
  `Period` date default null,
  `Name` text,
  `Age` int(11) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `PeriodDay` int(2) default null,
  `PeriodMth` int(2) default null,
  `PeriodYear` int(4) default null,
  `DayName` varchar(10) default null,
  
  PRIMARY KEY (`TestId`),
  UNIQUE KEY `TestId_UNIQUE` (`TestId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/datatest.csv'
INTO TABLE datatest 
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@periodorig,
Name,
@age,
@dob
) 
Set 
TestId=null,
PeriodOrig = @periodorig,
Period = (select substring_index(@periodorig,';',1)),
Age = (SELECT TIMESTAMPDIFF(YEAR, @dob, CURDATE())),
DOB = @dob,
PeriodDay = (select extract(day from Period)),
PeriodMth = (select extract(month from Period)),
PeriodYear = (select extract(year from Period)),
DayName = (select dayname(Period))
;

