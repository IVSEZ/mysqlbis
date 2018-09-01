
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\RCBill\\AllAreaSettlementDistrictStreet-31082018.csv' 
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
-- insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,INSERTEDON) values('MAHE','BARBARON ESTATE',now());
-- insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,INSERTEDON) values('MAHE','BARBARONS',now());
-- insert into rcbill.rcb_address(AREANAME,SETTLEMENTNAME,INSERTEDON) values('SILHOUETTE ISLAND','SILHOUETTE ISLAND',now());
-- delete from rcbill.rcb_address where AREANAME='SILHOUETTE';
-- select * from rcbill.rcb_address;

-- select distinct settlementname from rcb_address;
-- select * from rcb_address where districtname is null;
/*
select distinct areaname, settlementname, districtname from rcb_address
where AreaName not in ('M','SEYCHELLES')
group by areaname, settlementname, districtname
;
*/

