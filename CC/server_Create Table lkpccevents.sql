use rcbill_my;

drop table if exists lkpccevents;

CREATE TABLE `lkpccevents` (
  `CCEVENTCODE` varchar(45) DEFAULT NULL, 
  `CCEVENTNAME` varchar(45) DEFAULT NULL,
  `CCEVENTDESC` varchar(255) DEFAULT NULL
  
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
  
INSERT INTO lkpccevents (CCEVENTCODE, CCEVENTNAME, CCEVENTDESC)
VALUES ('ABANDON', 'NOT ANSWERED', 'Calls not answered.');
INSERT INTO lkpccevents (CCEVENTCODE, CCEVENTNAME, CCEVENTDESC)
VALUES ('COMPLETEAGENT', 'ANSWERED', 'Calls answered and hung up by agents after completion.');
INSERT INTO lkpccevents (CCEVENTCODE, CCEVENTNAME, CCEVENTDESC)
VALUES ('COMPLETECALLER', 'ANSWERED', 'Calls answered and hung up by caller after completion.');
INSERT INTO lkpccevents (CCEVENTCODE, CCEVENTNAME, CCEVENTDESC)
VALUES ('TRANSFER', 'ANSWERED', 'Calls answered and transferred by agents after completion.');
INSERT INTO lkpccevents (CCEVENTCODE, CCEVENTNAME, CCEVENTDESC)
VALUES ('EXITWITHTIMEOUT', 'NOT ANSWERED', 'Calls timed out by waiting.');

select * from lkpccevents;