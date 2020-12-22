use rcbill_maps;

-- select * from rcbill_maps.IV_CUSTOMERACCOUNT;

-- override GROUP_CONCAT limit of 1024 characters to avoid a truncated result
set session group_concat_max_len = 1000000;

#####################################################################
## PARCELFORMAP
select 'IV_PARCELFORMAP' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_PARCELFORMAP'
    and table_schema = 'rcbill_maps'
    order by ordinal_position
    ;


select 	"lat",	"lon",	"title",	"description",	"icon",	"iconSize",	"iconOffset"

union all

select 	ifnull(lat,""),	ifnull(lon,""),	ifnull(title,""),	ifnull(description,""),	ifnull(icon,""),	ifnull(iconSize,""),	ifnull(iconOffset,"")

INTO OUTFILE '/var/www/html/maptest/data/all.txt'
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_maps.IV_PARCELFORMAP
;


#####################################################################
## PARCELFORMAP_GPON

select 'IV_PARCELFORMAP_GPON' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_PARCELFORMAP_GPON'
    and table_schema = 'rcbill_maps'
    order by ordinal_position
    ;



select 	"lat",	"lon",	"title",	"description",	"icon",	"iconSize",	"iconOffset"

union all

select 	ifnull(lat,""),	ifnull(lon,""),	ifnull(title,""),	ifnull(description,""),	ifnull(icon,""),	ifnull(iconSize,""),	ifnull(iconOffset,"")

INTO OUTFILE '/var/www/html/maptest/data/gpon.txt'
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_maps.IV_PARCELFORMAP_GPON
;


#####################################################################
## IV_PARCELFORMAP_HFC

select 'IV_PARCELFORMAP_HFC' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_PARCELFORMAP_HFC'
    and table_schema = 'rcbill_maps'
    order by ordinal_position
    ;



select 	"lat",	"lon",	"title",	"description",	"icon",	"iconSize",	"iconOffset"

union all

select 	ifnull(lat,""),	ifnull(lon,""),	ifnull(title,""),	ifnull(description,""),	ifnull(icon,""),	ifnull(iconSize,""),	ifnull(iconOffset,"")

INTO OUTFILE '/var/www/html/maptest/data/hfc.txt'
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_maps.IV_PARCELFORMAP_HFC
;

#####################################################################
## IV_PARCELFORMAP_MIX

select 'IV_PARCELFORMAP_MIX' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_PARCELFORMAP_MIX'
    and table_schema = 'rcbill_maps'
    order by ordinal_position
    ;

select 	"lat",	"lon",	"title",	"description",	"icon",	"iconSize",	"iconOffset"

union all

select 	ifnull(lat,""),	ifnull(lon,""),	ifnull(title,""),	ifnull(description,""),	ifnull(icon,""),	ifnull(iconSize,""),	ifnull(iconOffset,"")

INTO OUTFILE '/var/www/html/maptest/data/mix.txt'
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_maps.IV_PARCELFORMAP_MIX
;

#####################################################################
## IV_PARCELFORMAP_Inactive_2

select 'IV_PARCELFORMAP_Inactive_2' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_PARCELFORMAP_Inactive_2'
    and table_schema = 'rcbill_maps'
    order by ordinal_position
    ;

select 	"lat",	"lon",	"title",	"description",	"icon",	"iconSize",	"iconOffset"

union all

select 	ifnull(lat,""),	ifnull(lon,""),	ifnull(title,""),	ifnull(description,""),	ifnull(icon,""),	ifnull(iconSize,""),	ifnull(iconOffset,"")

INTO OUTFILE '/var/www/html/maptest/data/inactive_2.txt'
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_maps.IV_PARCELFORMAP_Inactive_2
;

#####################################################################
## IV_PARCELFORMAP_Inactive_3

select 'IV_PARCELFORMAP_Inactive_3' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_PARCELFORMAP_Inactive_3'
    and table_schema = 'rcbill_maps'
    order by ordinal_position
    ;


select 	"lat",	"lon",	"title",	"description",	"icon",	"iconSize",	"iconOffset"

union all

select 	ifnull(lat,""),	ifnull(lon,""),	ifnull(title,""),	ifnull(description,""),	ifnull(icon,""),	ifnull(iconSize,""),	ifnull(iconOffset,"")

INTO OUTFILE '/var/www/html/maptest/data/inactive_3.txt'
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_maps.IV_PARCELFORMAP_Inactive_3
;


#####################################################################
## IV_PARCELFORMAP_Inactive_4 

select 'IV_PARCELFORMAP_Inactive_4' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_PARCELFORMAP_Inactive_4'
    and table_schema = 'rcbill_maps'
    order by ordinal_position
    ;

select 	"lat",	"lon",	"title",	"description",	"icon",	"iconSize",	"iconOffset"

union all

select 	ifnull(lat,""),	ifnull(lon,""),	ifnull(title,""),	ifnull(description,""),	ifnull(icon,""),	ifnull(iconSize,""),	ifnull(iconOffset,"")

INTO OUTFILE '/var/www/html/maptest/data/inactive_4.txt'
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_maps.IV_PARCELFORMAP_Inactive_4
;

#####################################################################
## IV_PARCELFORMAP_Inactive_5

select 'IV_PARCELFORMAP_Inactive_5' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_PARCELFORMAP_Inactive_5'
    and table_schema = 'rcbill_maps'
    order by ordinal_position
    ;

select 	"lat",	"lon",	"title",	"description",	"icon",	"iconSize",	"iconOffset"

union all

select 	ifnull(lat,""),	ifnull(lon,""),	ifnull(title,""),	ifnull(description,""),	ifnull(icon,""),	ifnull(iconSize,""),	ifnull(iconOffset,"")

INTO OUTFILE '/var/www/html/maptest/data/inactive_5.txt'
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_maps.IV_PARCELFORMAP_Inactive_5
;


#####################################################################