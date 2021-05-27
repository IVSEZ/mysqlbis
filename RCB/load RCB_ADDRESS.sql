use rcbill;

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\RCBill\\AllAreaSettlementDistrictStreet-31082018.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\RCBill\\AllAreaSettlementDistrictStreet-06012020.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\RCBill\\AllAreaSettlementDistrictStreet-22052020.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\RCBill\\AllAreaSettlementDistrictStreet-04052021-2.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_address` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@AreaName ,
@SettlementName ,
@DistrictName ,
@Streetname 
) 
set 

AREANAME=trim(upper(@AreaName)) ,
SETTLEMENTNAME=trim(upper(@SettlementName)) ,
DISTRICTNAME=trim(upper(@DistrictName)) ,
STREETNAME=trim(upper(@Streetname)) ,
INSERTEDON=now()
;


-- insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,INSERTEDON) values('MAHE','PROVIDENCE',now());
-- insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME, INSERTEDON) values('MAHE','EDEN ISLAND', 'EDEN ISLAND',now());

-- insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,INSERTEDON) values('MAHE','BARBARON ESTATE',now());
-- insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,INSERTEDON) values('MAHE','BARBARONS',now());
-- insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,INSERTEDON) values('SILHOUETTE ISLAND','SILHOUETTE ISLAND',now());
-- delete from rcbill.rcb_address where AREANAME='SILHOUETTE';
-- select * from rcbill.rcb_address;

-- select distinct settlementname from rcb_address;
-- select * from rcb_address where districtname is null;


/*
select * from rcbill.rcb_address where SETTLEMENTNAME='BAIE STE ANNE';



select distinct areaname, settlementname, districtname from rcb_address
where AreaName not in ('M','SEYCHELLES')
group by areaname, settlementname, districtname
;


select distinct areaname, settlementname from rcb_address
where AreaName not in ('M','SEYCHELLES')
group by areaname, settlementname
;

SET SQL_SAFE_UPDATES = 0;
update rcbill.rcb_address
set SETTLEMENTNAME='ANSE AUX PINS' where SETTLEMENTNAME='ANSE AUX PIN';


delete from rcbill.rcb_address where AREANAME='M';
delete from rcbill.rcb_address where AREANAME='SEYCHELLES';
delete from rcbill.rcb_address where AREANAME='SANS SOUCI ROAD';

delete from rcbill.rcb_address where AREANAME='MAHE' and SETTLEMENTNAME='BAIE STE ANNE';
delete from rcbill.rcb_address where AREANAME='MAHE' and SETTLEMENTNAME='GRAND ANSE';
delete from rcbill.rcb_address where AREANAME='MAHE' and SETTLEMENTNAME='LA DIGUE';



insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','ANSE AUX PINS','ANSE AUX PINS',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','ANSE BOILEAU','ANSE BOILEAU',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','ANSE ETOILE','ANSE ETOILE',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','ANSE ROYALE','ANSE ROYALE',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','AU CAP','AU CAP',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','BAIE LAZARE','BAIE LAZARE',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','BARBARON ESTATE','BARBARON ESTATE',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','BARBARONS','BARBARONS',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','BEAU VALLON','BEAU VALLON',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','BEL AIR','BEL AIR',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','BEL OMBRE','BEL OMBRE',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','CASCADE','CASCADE',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','EDEN ISLAND','EDEN ISLAND',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','ENGLISH RIVER','ENGLISH RIVER',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','GLACIS','GLACIS',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','LA MISERE','LA MISERE',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','LES MAMELLES','LES MAMELLES',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','MONT BUXTON','MONT BUXTON',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','MONT FLEURI','MONT FLEURI',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','PERSEVERANCE','PERSEVERANCE',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','PLAISANCE','PLAISANCE',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','POINTE LARUE','POINTE LARUE',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','PORT GLAUD','PORT GLAUD',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','PROVIDENCE','PROVIDENCE',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','ROCHE CAIMAN','ROCHE CAIMAN',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','ST LOUIS','ST LOUIS',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','TAKAMAKA','TAKAMAKA',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('MAHE','VICTORIA','VICTORIA',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('PRASLIN','BAIE ST-ANNE','BAIE ST-ANNE',NOW());
insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,DISTRICTNAME,INSERTEDON) values('PRASLIN','GRAND ANSE','GRAND ANSE',NOW());


*/

