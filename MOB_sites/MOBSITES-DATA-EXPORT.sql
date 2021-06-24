use rcbill_maps;

-- select * from rcbill_maps.IV_CUSTOMERACCOUNT;

-- override GROUP_CONCAT limit of 1024 characters to avoid a truncated result
set session group_concat_max_len = 1000000;

#####################################################################


#####################################################################
## IV_MOBILESITES

select 'IV_MOBILESITES' AS TABLENAME;
select column_name
    from information_schema.columns
    where table_name = 'IV_MOBILESITES'
    and table_schema = 'rcbill_maps'
    order by ordinal_position
    ;


select 	"lat",	"lon",	"title",	"description",	"icon",	"iconSize",	"iconOffset"

union all

-- select 	ifnull(lat,""),	ifnull(lon,""),	ifnull(title,""),	ifnull(description,""),	ifnull(icon,""),	ifnull(iconSize,""),	ifnull(iconOffset,"")

select ifnull(mobsitelat,"") as lat, ifnull(mobsitelong,"") as lon, concat("<font face=verdana size=2>", ifnull(mobsitename,""),"</font><hr>") as title, concat("<font face=verdana size=1>", concat_ws("<BR>",ifnull(MOBSITENO,""),ifnull(MOBSITENAME,""),ifnull(MOBSITETYPE,""),ifnull(MOBSITEHEIGHT,""),ifnull(MOBSITEISLAND,""),ifnull(MOBSITEOWNER,""),ifnull(MOBSITEPARCEL,""),ifnull(MOBSITELAT,""),ifnull(MOBSITELONG,""), ifnull(MOBSITECOORDX,""),ifnull(MOBSITECOORDY,""),ifnull(MOBSITESTATUS,""),ifnull(COMMENT,"")),"</font>") as description ,	ifnull(MOBSITEICON,"") as icon,	ifnull(MOBSITEICONSIZE,"") as iconSize,	ifnull(MOBSITEICONOFFSET,"") as iconOffset


INTO OUTFILE '/var/www/html/maptest/data/iv_mobilesites.txt'
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
FROM rcbill_maps.IV_MOBILESITES
;


#####################################################################