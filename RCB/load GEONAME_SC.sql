use rcbill;

SET @date1='2017-07-23';
SET @date2='2017-07-24';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\geoname\\seygeonames1.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\geoname\\seygeonames_06012020.csv' 
REPLACE INTO TABLE `rcbill`.`geoname_sc` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(
@geonameid,
@geoname,
@geoasciiname,
@geoaltname,
@latitude,
@longitude,
@featureclass,
@featurecode,
@countrycode,
@altcountrycode,
@admincode1,
@admincode2,
@admincode3,
@admincode4,
@population,
@elevation,
@dem,
@timezone,
@modificationdate

) 
set 

GEONAMEID=@geonameid, 
GEONAME=upper(trim(@geoname)),
GEOASCIINAME=upper(trim(@geoasciiname)),
GEOALTNAME=upper(trim(@geoaltname)), 
LATITUDE=@latitude,
LONGITUDE=@longitude,
FEATURECLASS=@featureclass,
FEATURECODE=@featurecode,
COUNTRYCODE=@countrycode,
ALTCOUNTRYCODE=@altcountrycode,
ADMINCODE1=@admincode1, 
ADMINCODE2=@admincode2,
ADMINCODE3=@admincode3,
ADMINCODE4=@admincode4,
POPULATION=@population,
ELEVATION=@elevation,
DEM=@dem, 
TIMEZONE=upper(trim(@timezone)),
MODIFICATIONDATE=str_to_date(@modificationdate,'%d-%m-%y')

;

select * from rcbill.geoname_sc;

select distinct featureclass, count(*) from rcbill.geoname_sc group by FEATURECLASS;
-- select * from rcbill.geoname_sc where featureclass='A' order by GEONAME asc;


/*
SET SQL_SAFE_UPDATES = 0;
update rcbill.geoname_sc
set geoname='PROVIDENCE ISLAND' where geonameid=241208
set geoname='ST. LOUIS' where geonameid=241181

set geoname='LA MISERE' where geoname='MISERE'

delete from rcbill.geoname_sc where geonameid in (1,2,3,4,5,6);

insert into rcbill.geoname_sc
(GEONAMEID, GEONAME, GEOASCIINAME, GEOALTNAME, LATITUDE, LONGITUDE, FEATURECLASS, FEATURECODE, COUNTRYCODE
,TIMEZONE, MODIFICATIONDATE
)
values
(
1,'PERSEVERANCE','PERSEVERANCE','PERSEVERANCE',-4.60455,55.46431,'P','PPL','SC','INDIAN/MAHE',now()
),
(
2,'PROVIDENCE','PROVIDENCE','PROVIDENCE',-4.65564,55.48798,'P','PPL','SC','INDIAN/MAHE',now()
)
,
(
3,'BAIE ST-ANNE','BAIE ST-ANNE','BAIE SAINT ANNE, BAIE STE ANNE, BAIE SAINTE ANNE,SAINT ANNE BAY,SAINT ANNS BAY',-4.33333,55.76667,'A','ADM1','SC','INDIAN/MAHE',now()
)
,
(
4,'BAIE ST-ANNE COTE DOR','BAIE ST-ANNE COTE DOR','BAIE ST-ANNE COTE DOR, BAIE SAINT ANNE, BAIE STE ANNE, BAIE SAINTE ANNE,SAINT ANNE BAY,SAINT ANNS BAY',-4.33333,55.76667,'A','ADM1','SC','INDIAN/MAHE',now()
)
,
(
5,'BARBARON ESTATE','BARBARON ESTATE','BARBARON ESTATE,BARBARONs ESTATE',-4.68333,55.45000,'P','PPL','SC','INDIAN/MAHE',now()
)
,
(
6,'BARBARONS','BARBARONS','BARBARONS',-4.68333,55.45833,'P','PPL','SC','INDIAN/MAHE',now()
)
;

insert into rcbill.geoname_sc
(GEONAMEID, GEONAME, GEOASCIINAME, GEOALTNAME, LATITUDE, LONGITUDE, FEATURECLASS, FEATURECODE, COUNTRYCODE
,TIMEZONE, MODIFICATIONDATE
)
values
(
7,'GRAND-ANSE MAHE','GRAND-ANSE MAHE','GRAND-ANSE MAHE',-4.68333,55.45833,'P','PPL','SC','INDIAN/MAHE',now()
),
(
8,'GRAND-ANSE PRASLIN','GRAND-ANSE PRASLIN','GRAND-ANSE PRASLIN',-4.31667,55.71667,'P','PPL','SC','INDIAN/MAHE',now()
)
;

insert into rcbill.geoname_sc
(GEONAMEID, GEONAME, GEOASCIINAME, GEOALTNAME, LATITUDE, LONGITUDE, FEATURECLASS, FEATURECODE, COUNTRYCODE
,TIMEZONE, MODIFICATIONDATE
)
values
(
9,'BAIE STE ANNE','BAIE STE ANNE','BAIE STE ANNE',-4.31667,55.73333,'A','ADM1','SC','INDIAN/MAHE',now()
)
;


SET SQL_SAFE_UPDATES = 0;
update rcbill.geoname_sc
set 
latitude=-4.31667,
longitude=55.73333
where geonameid in (3,4);


SET SQL_SAFE_UPDATES = 0;
update rcbill.geoname_sc
set 
latitude=-4.33109,
longitude=55.72206
where geonameid in (241331,8);


SET SQL_SAFE_UPDATES = 0;
update rcbill.geoname_sc
set 
latitude=-4.676749,
longitude=55.448246
where geonameid in (241330,7);

//change les mamelles coordinates
SET SQL_SAFE_UPDATES=0;
update rcbill.geoname_sc
set 
latitude=-4.65316,
longitude=55.47053
where geonameid in (448408);

-- grand anse mahe

*/