
                    
                    
select * from 
(

					select ifnull(TITLE,rcbill.GetVODTitleFromResource(RESOURCE)) as TITLE
                    , (select titletype from rcbill.rcb_vodtitles where resourceorig=RESOURCE) as TITLETYPE
                    , (select id from rcbill.rcb_vodtitles where resourceorig=RESOURCE) as ID
                    , RESOURCE
                    , JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, `DEC`, TOTAL_DURATION
					from rcbill_my.rep_vodpivot2018 order by total_duration desc

) a 
where id>1000
and 
TITLETYPE='T'
order by TOTAL_DURATION desc
;
                    
                    