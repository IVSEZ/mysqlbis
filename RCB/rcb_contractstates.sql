use rcbill;

SELECT * FROM rcbill.rcb_ContractStates_view_LNG where LNG='en';

drop table if exists rcbill.rcb_ContractStates;
create table rcbill.rcb_ContractStates as 
(
select * from rcbill.rcb_ContractStates_view_LNG where LNG='en'
)
;

select id from rcbill.rcb_ContractStates;


drop table if exists rcbill.rcb_ContractStates;


CREATE TABLE `rcb_ContractStates` ( `ID` int(11) DEFAULT NULL,
  `LABEL` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO rcbill.rcb_ContractStates VALUES (1,'Open');
INSERT INTO rcbill.rcb_ContractStates VALUES (2,'Deactivated on debit');
INSERT INTO rcbill.rcb_ContractStates VALUES (3,'Closed Total');
INSERT INTO rcbill.rcb_ContractStates VALUES (30,'Closed');
INSERT INTO rcbill.rcb_ContractStates VALUES (31,'Closed not payed');
INSERT INTO rcbill.rcb_ContractStates VALUES (39,'Refused');
INSERT INTO rcbill.rcb_ContractStates VALUES (4,'Active');
INSERT INTO rcbill.rcb_ContractStates VALUES (5,'Deactivated');
INSERT INTO rcbill.rcb_ContractStates VALUES (6,'Expired');
INSERT INTO rcbill.rcb_ContractStates VALUES (7,'New');
INSERT INTO rcbill.rcb_ContractStates VALUES (8,'Renew');



select * from rcbill.rcb_ContractStates_view_LNG where LNG='en'   