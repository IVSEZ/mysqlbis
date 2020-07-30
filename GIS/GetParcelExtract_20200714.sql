use rcbill_extract;


create table rcbill_extract.IV_PARCELEXTRACTStaging_20200714 as
(
	SELECT * FROM rcbill_extract.IV_PARCELEXTRACTStaging

)
;

create table rcbill_extract.IV_PARCELFORMAP_20200714 as
(
	SELECT * FROM rcbill_extract.IV_PARCELFORMAP

)
;
create table rcbill_extract.IV_PARCELFORMAP_Inactive_20200714 as
(
	SELECT * FROM rcbill_extract.IV_PARCELFORMAP_Inactive

)
;
create table rcbill_extract.IV_PARCELFORMAP_HFC_20200714 as
(
	SELECT * FROM rcbill_extract.IV_PARCELFORMAP_HFC

)
;
create table rcbill_extract.IV_PARCELFORMAP_GPON_20200714 as
(
	SELECT * FROM rcbill_extract.IV_PARCELFORMAP_GPON

)
;
create table rcbill_extract.IV_PARCELFORMAP_MIX_20200714 as
(
	SELECT * FROM rcbill_extract.IV_PARCELFORMAP_MIX

)
;


select * from rcbill_extract.IV_PARCELEXTRACTStaging_20200714;
select * from rcbill_extract.IV_PARCELFORMAP_20200714;
select * from rcbill_extract.IV_PARCELFORMAP_Inactive_20200714;
select * from rcbill_extract.IV_PARCELFORMAP_HFC_20200714;
select * from rcbill_extract.IV_PARCELFORMAP_GPON_20200714;
select * from rcbill_extract.IV_PARCELFORMAP_MIX_20200714;
select *, concat('icon/',icon) as updated_icon from rcbill_extract.IV_PARCELFORMAP_MIX_20200714;

SET SQL_SAFE_UPDATES=0;

ALTER TABLE rcbill_extract.IV_PARCELFORMAP_MIX_20200714 MODIFY icon VARCHAR(255) ;
ALTER TABLE rcbill_extract.IV_PARCELEXTRACTStaging_20200714 MODIFY icon VARCHAR(255) ;
ALTER TABLE rcbill_extract.IV_PARCELFORMAP_20200714 MODIFY icon VARCHAR(255) ;
ALTER TABLE rcbill_extract.IV_PARCELFORMAP_Inactive_20200714 MODIFY icon VARCHAR(255) ;
ALTER TABLE rcbill_extract.IV_PARCELFORMAP_HFC_20200714 MODIFY icon VARCHAR(255) ;
ALTER TABLE rcbill_extract.IV_PARCELFORMAP_GPON_20200714 MODIFY icon VARCHAR(255) ;
 
 /*
update rcbill_extract.IV_PARCELFORMAP_MIX_20200714
set icon='icon/blu-blank-lv.png'
;

update rcbill_extract.IV_PARCELEXTRACTStaging_20200714
set icon=concat('icon/',icon)
;
update rcbill_extract.IV_PARCELFORMAP_20200714
set icon=concat('icon/',icon)
;
update rcbill_extract.IV_PARCELFORMAP_Inactive_20200714
set icon=concat('icon/',icon)
;
update rcbill_extract.IV_PARCELFORMAP_HFC_20200714
set icon=concat('icon/',icon)
;
update rcbill_extract.IV_PARCELFORMAP_GPON_20200714
set icon=concat('icon/',icon)
;

*/

