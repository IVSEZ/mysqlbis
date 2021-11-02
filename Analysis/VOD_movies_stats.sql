select * from rcbill_my.rep_vodpivot2019;
select * from rcbill_my.rep_vodpivot2018;  
select rcbill.GetVODTitleFromResource('20180605.141400.043.')
;

SELECT 
    IFNULL(TITLE,
            rcbill.GetVODTitleFromResource(RESOURCE)) AS TITLE,
    RESOURCE,
    JAN,
    FEB,
    MAR,
    APR,
    MAY,
    JUN,
    JUL,
    AUG,
    SEP,
    OCT,
    NOV,
    `DEC`,
    TOTAL_DURATION
FROM
    rcbill_my.rep_vodpivot2018
ORDER BY total_duration DESC;

SELECT 
    IFNULL(TITLE,
            rcbill.GetVODTitleFromResource(RESOURCE)) AS TITLE,
    RESOURCE,
    JAN,
    FEB,
    MAR,
    APR,
    MAY,
    JUN,
    JUL,
    AUG,
    SEP,
    OCT,
    NOV,
    `DEC`,
    TOTAL_DURATION
FROM
    rcbill_my.rep_vodpivot2019
ORDER BY total_duration DESC;

SELECT 
    IFNULL(TITLE,
            rcbill.GetVODTitleFromResource(RESOURCE)) AS TITLE,
    RESOURCE,
    JAN,
    FEB,
    MAR,
    APR,
    MAY,
    JUN,
    JUL,
    AUG,
    SEP,
    OCT,
    NOV,
    `DEC`,
    OVERALL
FROM
    rcbill_my.rep_vodranking2019
ORDER BY OVERALL ASC;

select * from rcbill_my.rep_vodpivot2019 limit 1000;

select ifnull(TITLE,rcbill.GetVODTitleFromResource(RESOURCE)) as TITLE, RESOURCE
, rcbill.GetVODTypeFromResource(RESOURCE) as TYPE
, JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, `DEC`, TOTAL_DURATION
from rcbill_my.rep_vodpivot2019 order by total_duration desc
;



select RESOURCE, JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, `DEC`, TOTAL_DURATION
					from rcbill_my.rep_vodpivot2019 order by total_duration desc
                    ;
                  
                    
select * from 
(

					select ifnull(TITLE,rcbill.GetVODTitleFromResource(RESOURCE)) as TITLE
                    , ifnull(TITLE,rcbill.GetVODSeriesNameFromResource(RESOURCE)) as SERIESNAME
                    , (select titletype from rcbill.rcb_vodtitles where resourceorig=RESOURCE) as TITLETYPE
                    , (select id from rcbill.rcb_vodtitles where resourceorig=RESOURCE) as ID
                    , RESOURCE
                    , JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, `DEC`, TOTAL_DURATION
					from 
                    -- rcbill_my.rep_vodpivot2018 
                    rcbill_my.rep_vodpivot2019
                    order by total_duration desc

) a 
where id>1000
and 
TITLETYPE='T'
order by TOTAL_DURATION desc
;
   
select * from 
(

					select ifnull(TITLE,rcbill.GetVODTitleFromResource(RESOURCE)) as TITLE
                    , ifnull(TITLE,rcbill.GetVODSeriesNameFromResource(RESOURCE)) as SERIESNAME
                    , (select titletype from rcbill.rcb_vodtitles where resourceorig=RESOURCE) as TITLETYPE
                    , (select id from rcbill.rcb_vodtitles where resourceorig=RESOURCE) as ID
                    , RESOURCE
                    , JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, `DEC`, TOTAL_DURATION
					from 
                    -- rcbill_my.rep_vodpivot2018 
                    rcbill_my.rep_vodpivot2019
                    order by total_duration desc

) a 
where id>1000
and 
TITLETYPE='E'
order by TOTAL_DURATION desc
;
    
   
         
select titletype, count(*) as typecount
from rcbill.rcb_vodtitles
where id>1000
group by titletype
with rollup;

-- select * from rcbill.rcb_vodtitles where id>1000;

select *, rcbill.GetVODTitleFromResource(RESOURCEORIG) from rcbill.rcb_vodtitles where id>1000 and IMDBTITLEREF is not null;