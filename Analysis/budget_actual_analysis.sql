

-- =================================== 
set @revenue=1;
set @m1='2018-01-31';set @m2='2018-02-28';set @m3='2018-03-31';set @m4='2018-04-30';set @m5='2018-05-31';
set @m6='2018-06-30';set @m7='2018-07-31';set @m8='2018-08-31';set @m9='2018-09-30';set @m10='2018-10-31';set @m11='2018-11-30';set @m12='2018-12-31';
    
    
    (
	select 'BUDGET' as C_TYPE, b_month as MTH, b_year as YR, b_region as REGION, b_service as CATEGORY, B_PACKAGE as PACKAGE, sum(B_count) as ACTIVE from rcbill_my.iv_budget
	where 
	-- B_REGION in (@region)
	-- and
	B_CATEGORY='Active Numbers'
	-- and
	-- B_PACKAGE=@package
	-- and 
	-- B_REVENUEGENERATING=@revenue

	-- and b_month in (1,2)
	group by b_month, b_year, b_region, b_service, B_PACKAGE
	order by B_REGION, b_service, B_PACKAGE, B_MONTH
    )
union 
	(
	select 'ACTUAL' as C_TYPE,
	periodmth as MTH, periodyear as YR, region as REGION, servicecategory as CATEGORY
	, servicetype as PACKAGE
	-- , active
	 , sum(active) as ACTIVE
	from 
	(
	select periodmth, periodyear, region, servicecategory
	,clientclass
	,clienttype
	, servicetype, sum(open) as active from rcbill_my.activenumber
	where period in (@m1,@m2,@m3,@m4,@m5,@m6,@m7,@m8,@m9,@m10,@m11,@m12)
	-- and 
	-- region in (@region)
	-- and 
	-- servicetype= @package
	and reported='Y'
	group by periodmth, periodyear, region, servicecategory, clientclass, clienttype, servicetype
	) a 
	where a.active <> 0


	 group by periodmth, periodyear, region, servicecategory, servicetype

	order by a.region,a.servicecategory, a.servicetype, a.periodmth 
    )
;


select a.*, (a.ACTUAL-a.BUDGET) as ACHIEVEMENT
,
case 
when  (a.ACTUAL-a.BUDGET) = 0 then 'MET'
when  (a.ACTUAL-a.BUDGET) < 0 then 'BELOW'
when  (a.ACTUAL-a.BUDGET) > 0 then 'EXCEED'
end as `TARGET_CATEGORY`

from 
(

		(
		   select a.*
           -- , b.region as REGION2, b.category as CATEGORY2, b.package as PACKAGE2
			-- ifnull(b.MTH,a.MTH) as MTH, ifnull(b.YR, a.YR) as YR, ifnull(a.REGION, b.REGION) as REGION, ifnull(a.CATEGORY,b.CATEGORY) as CATEGORY, ifnull(a.PACKAGE,b.PACKAGE) as PACKAGE
           -- , ifnull(a.BUDGET,0) as BUDGET
           
           , ifnull(b.ACTUAL,0) as ACTUAL
           
           from
		   (
				select 
				-- 'BUDGET' as C_TYPE, 
				b_month as MTH, b_year as YR, b_region as REGION, b_service as CATEGORY, B_PACKAGE as PACKAGE, sum(B_count) as BUDGET from rcbill_my.iv_budget
				where 
				-- B_REGION in (@region)
				-- and
				B_CATEGORY='Active Numbers'
				-- and
				-- B_PACKAGE=@package
				-- and 
				-- B_REVENUEGENERATING=@revenue

				-- and b_month in (1,2)
				group by b_month, b_year, b_region, b_service, B_PACKAGE
				order by B_REGION, b_service, B_PACKAGE, B_MONTH
			) a
			left join 
			(
				select -- 'ACTUAL' as C_TYPE,
				periodmth as MTH, periodyear as YR, region as REGION, servicecategory as CATEGORY
				, servicetype as PACKAGE
				-- , active
				 , sum(active) as ACTUAL
				from 
				(
					select periodmth, periodyear, region, servicecategory
					,clientclass
					,clienttype
					, servicetype, sum(open) as active from rcbill_my.activenumber
					where period in (@m1,@m2,@m3,@m4,@m5,@m6,@m7,@m8,@m9,@m10,@m11,@m12)
					-- and 
					-- region in (@region)
					-- and 
					-- servicetype= @package
					and reported='Y'
					group by periodmth, periodyear, region, servicecategory, clientclass, clienttype, servicetype
				) a 
				where a.active <> 0
				group by periodmth, periodyear, region, servicecategory, servicetype

				order by a.region,a.servicecategory, a.servicetype, a.periodmth 
			) b
            on a.mth=b.mth and a.yr=b.yr and a.region=b.region and a.category=b.category and a.package=b.package
		)
        UNION
        (
		   select 
           -- a.*
           -- , 
           ifnull(a.MTH,b.MTH) as MTH, ifnull(a.YR, b.YR) as YR, ifnull(a.REGION, b.REGION) as REGION, ifnull(a.CATEGORY,b.CATEGORY) as CATEGORY, ifnull(a.PACKAGE,b.PACKAGE) as PACKAGE
           , ifnull(a.BUDGET,0) as BUDGET
           -- , b.region as REGION2, b.category as CATEGORY2, b.package as PACKAGE2
           , ifnull(b.ACTUAL,0) as ACTUAL
           from
		   (
				select 
				-- 'BUDGET' as C_TYPE, 
				b_month as MTH, b_year as YR, b_region as REGION, b_service as CATEGORY, B_PACKAGE as PACKAGE, sum(B_count) as BUDGET from rcbill_my.iv_budget
				where 
				-- B_REGION in (@region)
				-- and
				B_CATEGORY='Active Numbers'
				-- and
				-- B_PACKAGE=@package
				-- and 
				-- B_REVENUEGENERATING=@revenue

				-- and b_month in (1,2)
				group by b_month, b_year, b_region, b_service, B_PACKAGE
				order by B_REGION, b_service, B_PACKAGE, B_MONTH
			) a
		right join 
			(
				select -- 'ACTUAL' as C_TYPE,
				periodmth as MTH, periodyear as YR, region as REGION, servicecategory as CATEGORY
				, servicetype as PACKAGE
				-- , active
				 , sum(active) as ACTUAL
				from 
				(
					select periodmth, periodyear, region, servicecategory
					,clientclass
					,clienttype
					, servicetype, sum(open) as active from rcbill_my.activenumber
					where period in (@m1,@m2,@m3,@m4,@m5,@m6,@m7,@m8,@m9,@m10,@m11,@m12)
					-- and 
					-- region in (@region)
					-- and 
					-- servicetype= @package
					and reported='Y'
					group by periodmth, periodyear, region, servicecategory, clientclass, clienttype, servicetype
				) a 
				where a.active <> 0
				group by periodmth, periodyear, region, servicecategory, servicetype

				order by a.region,a.servicecategory, a.servicetype, a.periodmth 
			) b
            on a.mth=b.mth and a.yr=b.yr and a.region=b.region and a.category=b.category and a.package=b.package
        )
) a
;



/*


select * from rcbill_my.iv_budget
where B_CATEGORY='Active Numbers'
and B_PACKAGE='Extravagance'
and B_REGION='Praslin'
;

select B_REGION, B_REVENUEGENERATING , B_Month, B_PACKAGE, sum(B_COUNT)
from rcbill_my.iv_budget
where B_CATEGORY='Active Numbers'
and B_PACKAGE='Extravagance'
and B_REGION='Mahe'
group by B_REGION, B_REVENUEGENERATING, B_Month, B_PACKAGE
; 

 
set @package='Crimson';
set @region1='Mahe';
set @region2='Praslin';
-- set @region=concat(@region1,',',@region2);
set @region=@region1;

 
select b_month, b_year, b_region, b_service, B_CLIENTCLASS, B_PACKAGE, B_count as active from rcbill_my.iv_budget
where 
B_REGION in (@region)
and
B_CATEGORY='Active Numbers'
and
B_PACKAGE=@package

and b_month in (1,2)
order by B_CLIENTCLASS, B_PACKAGE
;

select 
periodmth, periodyear, region, servicecategory, 

-- case when (clientclass='Employee' or clientclass='VIP' or clientclass='Intelvision Office' or clientclass='Prepaid' or clientclass=) then 'ADDON'
-- 	else clientclass
-- end as `clientclass`

	case 
	 when clienttype='Corporate'  then clientclass
		
        -- case when clientclass='Corporate Bulk' then clientclass 
		-- 	 when clientclass='Corporate Bundle' then 'Corporate Bulk'
        --      else clientclass
		 -- end
         
	 when clienttype='Corporate Bundle' then 'Corporate Bulk'
     when clienttype='Employee' then 'Other'
     when clienttype='VIP' then 'Other'
     when clienttype='Intelvision Office' then 'Other'
else clienttype
end as cc
-- , clientclass
-- , clienttype

, servicetype
-- , active
 , sum(active) as active
from 
(
select periodmth, periodyear, region, servicecategory
,clientclass
,clienttype
, servicetype, sum(open) as active from rcbill_my.activenumber
where period in ('2018-01-31','2018-02-28','2018-03-31','2018-04-30','2018-05-31','2018-06-30','2018-07-31','2018-08-31','2018-09-30','2018-10-31','2018-11-30','2018-12-31')
and 
region in (@region)
and 
servicetype= @package
and reported='Y'
group by periodmth, periodyear, region, servicecategory, clientclass, clienttype, servicetype
) a 
where a.active <> 0


 group by periodmth, periodyear, region, servicecategory, cc, servicetype

order by a.clientclass, a.clienttype, a.servicetype, a.periodmth  
;


-- ===============================================


 
set @package='Crimson';
set @region1='Mahe';
set @region2='Praslin';
-- set @region=concat(@region1,',',@region2);
set @region=@region1;
set @revenue=1;
 
select b_month, b_year, b_region, b_service, B_PACKAGE, sum(B_count) as active from rcbill_my.iv_budget
where 
B_REGION in (@region)
and
B_CATEGORY='Active Numbers'
and
B_PACKAGE=@package
and 
B_REVENUEGENERATING=@revenue

and b_month in (1,2)
group by b_month, b_year, b_region, b_service, B_PACKAGE
order by B_PACKAGE
;

select 
periodmth, periodyear, region, servicecategory

, servicetype
-- , active
 , sum(active) as active
from 
(
select periodmth, periodyear, region, servicecategory
,clientclass
,clienttype
, servicetype, sum(open) as active from rcbill_my.activenumber
where period in ('2018-01-31','2018-02-28','2018-03-31','2018-04-30','2018-05-31','2018-06-30','2018-07-31','2018-08-31','2018-09-30','2018-10-31','2018-11-30','2018-12-31')
and 
region in (@region)
and 
servicetype= @package
and reported='Y'
group by periodmth, periodyear, region, servicecategory, clientclass, clienttype, servicetype
) a 
where a.active <> 0


 group by periodmth, periodyear, region, servicecategory, servicetype

order by a.servicetype, a.periodmth  
;


-- ===================================


select 'BUDGET' as C_TYPE, b_month as MTH, b_year as YR, b_region as REGION, b_service as CATEGORY, B_PACKAGE as PACKAGE, B_REVENUEGENERATING as REV, sum(B_count) as ACTIVE from rcbill_my.iv_budget
where 
-- B_REGION in (@region)
-- and
B_CATEGORY='Active Numbers'
-- and
-- B_PACKAGE=@package
-- and 
-- B_REVENUEGENERATING=@revenue

-- and b_month in (1,2)
group by b_month, b_year, b_region, b_service, B_PACKAGE, B_REVENUEGENERATING
order by B_REGION, b_service, B_PACKAGE, B_MONTH
;


select 'Actual' as C_TYPE,
periodmth as MTH, periodyear as YR, region as REGION, servicecategory as CATEGORY
, servicetype as PACKAGE
-- , active
 , sum(active) as ACTIVE
from 
(
select periodmth, periodyear, region, servicecategory
,clientclass
,clienttype
, servicetype, sum(open) as active from rcbill_my.activenumber
where period in ('2018-01-31','2018-02-28','2018-03-31','2018-04-30','2018-05-31','2018-06-30','2018-07-31','2018-08-31','2018-09-30','2018-10-31','2018-11-30','2018-12-31')
-- and 
-- region in (@region)
-- and 
-- servicetype= @package
and reported='Y'
group by periodmth, periodyear, region, servicecategory, clientclass, clienttype, servicetype
) a 
where a.active <> 0


 group by periodmth, periodyear, region, servicecategory, servicetype

order by a.region,a.servicecategory, a.servicetype, a.periodmth  
;

*/