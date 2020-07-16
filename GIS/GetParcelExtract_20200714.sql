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


