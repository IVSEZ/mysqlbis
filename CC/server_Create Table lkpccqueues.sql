use rcbill_my;

drop table if exists lkpccqueues;

CREATE TABLE `lkpccqueues` (
  `CCQUEUECODE` varchar(45) DEFAULT NULL, 
  `CCQUEUENAME` varchar(45) DEFAULT NULL,
  `CCQUEUEDESC` varchar(255) DEFAULT NULL
  
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
  
INSERT INTO lkpccqueues (CCQUEUECODE, CCQUEUENAME, CCQUEUEDESC)
VALUES ('ccq-ah', 'CC-Evening', 'Mahe - CC - After hours - 5pm to 11pm - 4414243');
INSERT INTO lkpccqueues (CCQUEUECODE, CCQUEUENAME, CCQUEUEDESC)
VALUES ('ccq-no-callcenter', 'CC-NOC', 'Mahe - NOC - 11pm to 6 am - Redirected to 267');
INSERT INTO lkpccqueues (CCQUEUECODE, CCQUEUENAME, CCQUEUEDESC)
VALUES ('ccq-no-callcenter2', 'CC-RemoteAgent', 'Mahe - Remote Agent - 6am to 8am');
INSERT INTO lkpccqueues (CCQUEUECODE, CCQUEUENAME, CCQUEUEDESC)
VALUES ('ccq-oh', 'CC-Day', 'Mahe - CC - Normal office hours - 8am to 5pm - 4414243');
INSERT INTO lkpccqueues (CCQUEUECODE, CCQUEUENAME, CCQUEUEDESC)
VALUES ('pccq-oh', 'CC-Praslin-Day', 'Praslin - CC - Normal office hours - 8am to 5pm - 4414300 - Redirected to 306');

select * from lkpccqueues;