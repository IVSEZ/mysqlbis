
/*

select * from rcbill_my.iv_budget;

-- =================================== 
set @revenue=1;
set @m1='2019-01-31';set @m2='2019-02-19';set @m3='2019-03-31';set @m4='2019-04-30';set @m5='2019-05-31';
set @m6='2019-06-30';set @m7='2019-07-31';set @m8='2019-08-31';set @m9='2019-09-30';set @m10='2019-10-31';
set @m11='2019-11-30';set @m12='2019-12-31';

SET @rundate='2019-05-31';
 */   
 
 /*
    (
	select 'BUDGET' as C_TYPE, b_month as MTH, b_year as YR, b_region as REGION, b_service as CATEGORY, B_PACKAGE as PACKAGE
    , sum(B_count) as ACTIVE 
    from rcbill_my.iv_budget
	where 
	0=0
	and date(INSERTEDON) = (select date(max(INSERTEDON)) from rcbill_my.iv_budget)	
    -- B_REGION in (@region)
	-- and
	and B_CATEGORY='Active Numbers'
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
	periodmth as MTH, periodyear as YR
    -- , region as REGION
    , 'All' as REGION
    , servicecategory as CATEGORY
	, servicetype as PACKAGE
	-- , active
	 , sum(active) as ACTIVE
	from 
	(
	select periodmth, periodyear
    -- , region as REGION
    , 'All' as REGION
    , servicecategory
	-- ,clientclass
	-- ,clienttype
	, servicetype, sum(open) as active from rcbill_my.activenumber
	where period in (@m1,@m2,@m3,@m4,@m5,@m6,@m7,@m8,@m9,@m10,@m11,@m12)
	-- and 
	-- region in (@region)
	-- and 
	-- servicetype= @package
	and reported='Y'
	group by periodmth, periodyear
    , region
    , servicecategory
    -- , clientclass, clienttype
    , servicetype
	) a 
	where a.active <> 0


	 group by periodmth, periodyear, region, servicecategory, servicetype

	order by a.region,a.servicecategory, a.servicetype, a.periodmth 
    )
;
*/

drop table if exists rcbill_my.budget_actual_2019;

create table rcbill_my.budget_actual_2019 as 
(
		select @rundate as RUNDATE, a.*, (a.ACTUAL-a.BUDGET) as ACHIEVEMENT
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
						b_month as MTH, b_year as YR, b_region as REGION, b_service as CATEGORY, B_PACKAGE as PACKAGE, sum(B_count) as BUDGET 
						from rcbill_my.iv_budget
						where 
						0=0
						and date(INSERTEDON) = (select date(max(INSERTEDON)) from rcbill_my.iv_budget)	
						-- B_REGION in (@region)
						-- and
						and B_CATEGORY='Active Numbers'
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
						periodmth as MTH, periodyear as YR
						-- , region as REGION
						, 'All' as REGION
						, servicecategory as CATEGORY
						, servicetype as PACKAGE
						-- , active
						 , sum(active) as ACTUAL
						from 
						(
								select periodmth, periodyear
								-- , region as REGION
								, 'All' as REGION
								, servicecategory
								-- ,clientclass
								-- ,clienttype
								, servicetype, sum(open) as active from rcbill_my.activenumber
								where period in (@m1,@m2,@m3,@m4,@m5,@m6,@m7,@m8,@m9,@m10,@m11,@m12)
								-- and 
								-- region in (@region)
								-- and 
								-- servicetype= @package
								and reported='Y'
								group by periodmth, periodyear
								, region
								, servicecategory
								-- , clientclass, clienttype
								, servicetype
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
								select periodmth, periodyear
								-- , region as REGION
								, 'All' as REGION
								, servicecategory
								-- ,clientclass
								-- ,clienttype
								, servicetype, sum(open) as active from rcbill_my.activenumber
								where period in (@m1,@m2,@m3,@m4,@m5,@m6,@m7,@m8,@m9,@m10,@m11,@m12)
								-- and 
								-- region in (@region)
								-- and 
								-- servicetype= @package
								and reported='Y'
								group by periodmth, periodyear
								, region
								, servicecategory
								-- , clientclass, clienttype
								, servicetype
						) a 
						where a.active <> 0
						group by periodmth, periodyear, region, servicecategory, servicetype

						order by a.region,a.servicecategory, a.servicetype, a.periodmth 
					) b
					on a.mth=b.mth and a.yr=b.yr and a.region=b.region and a.category=b.category and a.package=b.package
				)
		) a
)
;


select count(*) as budget_actual_2019 from rcbill_my.budget_actual_2019;

/*
	select RUNDATE, CATEGORY, PACKAGE
		,CASE MTH WHEN 1 THEN SUM(BUDGET) END AS `1_B`
		,CASE MTH WHEN 1 THEN SUM(ACTUAL) END AS `1_A`
		,CASE MTH WHEN 1 THEN SUM(ACHIEVEMENT) END AS `1_D`
		,CASE MTH WHEN 1 THEN TARGET_CATEGORY END AS `1_RESULT`
		,CASE MTH WHEN 2 THEN SUM(BUDGET) END AS `2_B`
		,CASE MTH WHEN 2 THEN SUM(ACTUAL) END AS `2_A`
		,CASE MTH WHEN 2 THEN SUM(ACHIEVEMENT) END AS `2_D`
		,CASE MTH WHEN 2 THEN TARGET_CATEGORY END AS `2_RESULT`
		,CASE MTH WHEN 3 THEN SUM(BUDGET) END AS `3_B`
		,CASE MTH WHEN 3 THEN SUM(ACTUAL) END AS `3_A`
		,CASE MTH WHEN 3 THEN SUM(ACHIEVEMENT) END AS `3_D`
		,CASE MTH WHEN 3 THEN TARGET_CATEGORY END AS `3_RESULT`
		,CASE MTH WHEN 4 THEN SUM(BUDGET) END AS `4_B`
		,CASE MTH WHEN 4 THEN SUM(ACTUAL) END AS `4_A`
		,CASE MTH WHEN 4 THEN SUM(ACHIEVEMENT) END AS `4_D`
		,CASE MTH WHEN 4 THEN TARGET_CATEGORY END AS `4_RESULT`
		,CASE MTH WHEN 5 THEN SUM(BUDGET) END AS `5_B`
		,CASE MTH WHEN 5 THEN SUM(ACTUAL) END AS `5_A`
		,CASE MTH WHEN 5 THEN SUM(ACHIEVEMENT) END AS `5_D`
		,CASE MTH WHEN 5 THEN TARGET_CATEGORY END AS `5_RESULT`
		,CASE MTH WHEN 6 THEN SUM(BUDGET) END AS `6_B`
		,CASE MTH WHEN 6 THEN SUM(ACTUAL) END AS `6_A`
		,CASE MTH WHEN 6 THEN SUM(ACHIEVEMENT) END AS `6_D`
		,CASE MTH WHEN 6 THEN TARGET_CATEGORY END AS `6_RESULT`
		,CASE MTH WHEN 7 THEN SUM(BUDGET) END AS `7_B`
		,CASE MTH WHEN 7 THEN SUM(ACTUAL) END AS `7_A`
		,CASE MTH WHEN 7 THEN SUM(ACHIEVEMENT) END AS `7_D`
		,CASE MTH WHEN 7 THEN TARGET_CATEGORY END AS `7_RESULT`
		,CASE MTH WHEN 8 THEN SUM(BUDGET) END AS `8_B`
		,CASE MTH WHEN 8 THEN SUM(ACTUAL) END AS `8_A`
		,CASE MTH WHEN 8 THEN SUM(ACHIEVEMENT) END AS `8_D`
		,CASE MTH WHEN 8 THEN TARGET_CATEGORY END AS `8_RESULT`
		,CASE MTH WHEN 9 THEN SUM(BUDGET) END AS `9_B`
		,CASE MTH WHEN 9 THEN SUM(ACTUAL) END AS `9_A`
		,CASE MTH WHEN 9 THEN SUM(ACHIEVEMENT) END AS `9_D`
		,CASE MTH WHEN 9 THEN TARGET_CATEGORY END AS `9_RESULT`
		,CASE MTH WHEN 10 THEN SUM(BUDGET) END AS `10_B`
		,CASE MTH WHEN 10 THEN SUM(ACTUAL) END AS `10_A`
		,CASE MTH WHEN 10 THEN SUM(ACHIEVEMENT) END AS `10_D`
		,CASE MTH WHEN 10 THEN TARGET_CATEGORY END AS `10_RESULT`
		,CASE MTH WHEN 11 THEN SUM(BUDGET) END AS `11_B`
		,CASE MTH WHEN 11 THEN SUM(ACTUAL) END AS `11_A`
		,CASE MTH WHEN 11 THEN SUM(ACHIEVEMENT) END AS `11_D`
		,CASE MTH WHEN 11 THEN TARGET_CATEGORY END AS `11_RESULT`
		,CASE MTH WHEN 12 THEN SUM(BUDGET) END AS `12_B`
		,CASE MTH WHEN 12 THEN SUM(ACTUAL) END AS `12_A`
		,CASE MTH WHEN 12 THEN SUM(ACHIEVEMENT) END AS `12_D`
		,CASE MTH WHEN 12 THEN TARGET_CATEGORY END AS `12_RESULT`



		from 
		rcbill_my.budget_actual_2019
		group by RUNDATE, CATEGORY, PACKAGE, MTH
        ;
*/

drop table if exists rcbill_my.rep_budget_actual_2019_pv;

create table rcbill_my.rep_budget_actual_2019_pv as 
(

	select RUNDATE, CATEGORY, PACKAGE
	, ifnull(sum(`1_B`),0) as `JAN_B`
	, ifnull(sum(`1_A`),0) as `JAN_A`
	, ifnull(sum(`1_D`),0) as `JAN_D`
	, coalesce(max(`1_RESULT`)) as `JAN_RESULT`
	, ifnull(sum(`2_B`),0) as `FEB_B`
	, ifnull(sum(`2_A`),0) as `FEB_A`
	, ifnull(sum(`2_D`),0) as `FEB_D`
	, coalesce(max(`2_RESULT`)) as `FEB_RESULT`
	, ifnull(sum(`3_B`),0) as `MAR_B`
	, ifnull(sum(`3_A`),0) as `MAR_A`
	, ifnull(sum(`3_D`),0) as `MAR_D`
	, coalesce(max(`3_RESULT`)) as `MAR_RESULT`
	, ifnull(sum(`4_B`),0) as `APR_B`
	, ifnull(sum(`4_A`),0) as `APR_A`
	, ifnull(sum(`4_D`),0) as `APR_D`
	, coalesce(max(`4_RESULT`)) as `APR_RESULT`
	, ifnull(sum(`5_B`),0) as `MAY_B`
	, ifnull(sum(`5_A`),0) as `MAY_A`
	, ifnull(sum(`5_D`),0) as `MAY_D`
	, coalesce(max(`5_RESULT`)) as `MAY_RESULT`
	, ifnull(sum(`6_B`),0) as `JUN_B`
	, ifnull(sum(`6_A`),0) as `JUN_A`
	, ifnull(sum(`6_D`),0) as `JUN_D`
	, coalesce(max(`6_RESULT`)) as `JUN_RESULT`
	, ifnull(sum(`7_B`),0) as `JUL_B`
	, ifnull(sum(`7_A`),0) as `JUL_A`
	, ifnull(sum(`7_D`),0) as `JUL_D`
	, coalesce(max(`7_RESULT`)) as `JUL_RESULT`
	, ifnull(sum(`8_B`),0) as `AUG_B`
	, ifnull(sum(`8_A`),0) as `AUG_A`
	, ifnull(sum(`8_D`),0) as `AUG_D`
	, coalesce(max(`8_RESULT`)) as `AUG_RESULT`
	, ifnull(sum(`9_B`),0) as `SEP_B`
	, ifnull(sum(`9_A`),0) as `SEP_A`
	, ifnull(sum(`9_D`),0) as `SEP_D`
	, coalesce(max(`9_RESULT`)) as `SEP_RESULT`
	, ifnull(sum(`10_B`),0) as `OCT_B`
	, ifnull(sum(`10_A`),0) as `OCT_A`
	, ifnull(sum(`10_D`),0) as `OCT_D`
	, coalesce(max(`10_RESULT`)) as `OCT_RESULT`
	, ifnull(sum(`11_B`),0) as `NOV_B`
	, ifnull(sum(`11_A`),0) as `NOV_A`
	, ifnull(sum(`11_D`),0) as `NOV_D`
	, coalesce(max(`11_RESULT`)) as `NOV_RESULT`
	, ifnull(sum(`12_B`),0) as `DEC_B`
	, ifnull(sum(`12_A`),0) as `DEC_A`
	, ifnull(sum(`12_D`),0) as `DEC_D`
	, coalesce(max(`12_RESULT`)) as `DEC_RESULT`



	FROM
	(
			select RUNDATE, CATEGORY, PACKAGE
			,CASE MTH WHEN 1 THEN SUM(BUDGET) END AS `1_B`
			,CASE MTH WHEN 1 THEN SUM(ACTUAL) END AS `1_A`
			,CASE MTH WHEN 1 THEN SUM(ACHIEVEMENT) END AS `1_D`
			,CASE MTH WHEN 1 THEN TARGET_CATEGORY END AS `1_RESULT`
			,CASE MTH WHEN 2 THEN SUM(BUDGET) END AS `2_B`
			,CASE MTH WHEN 2 THEN SUM(ACTUAL) END AS `2_A`
			,CASE MTH WHEN 2 THEN SUM(ACHIEVEMENT) END AS `2_D`
			,CASE MTH WHEN 2 THEN TARGET_CATEGORY END AS `2_RESULT`
			,CASE MTH WHEN 3 THEN SUM(BUDGET) END AS `3_B`
			,CASE MTH WHEN 3 THEN SUM(ACTUAL) END AS `3_A`
			,CASE MTH WHEN 3 THEN SUM(ACHIEVEMENT) END AS `3_D`
			,CASE MTH WHEN 3 THEN TARGET_CATEGORY END AS `3_RESULT`
			,CASE MTH WHEN 4 THEN SUM(BUDGET) END AS `4_B`
			,CASE MTH WHEN 4 THEN SUM(ACTUAL) END AS `4_A`
			,CASE MTH WHEN 4 THEN SUM(ACHIEVEMENT) END AS `4_D`
			,CASE MTH WHEN 4 THEN TARGET_CATEGORY END AS `4_RESULT`
			,CASE MTH WHEN 5 THEN SUM(BUDGET) END AS `5_B`
			,CASE MTH WHEN 5 THEN SUM(ACTUAL) END AS `5_A`
			,CASE MTH WHEN 5 THEN SUM(ACHIEVEMENT) END AS `5_D`
			,CASE MTH WHEN 5 THEN TARGET_CATEGORY END AS `5_RESULT`
			,CASE MTH WHEN 6 THEN SUM(BUDGET) END AS `6_B`
			,CASE MTH WHEN 6 THEN SUM(ACTUAL) END AS `6_A`
			,CASE MTH WHEN 6 THEN SUM(ACHIEVEMENT) END AS `6_D`
			,CASE MTH WHEN 6 THEN TARGET_CATEGORY END AS `6_RESULT`
			,CASE MTH WHEN 7 THEN SUM(BUDGET) END AS `7_B`
			,CASE MTH WHEN 7 THEN SUM(ACTUAL) END AS `7_A`
			,CASE MTH WHEN 7 THEN SUM(ACHIEVEMENT) END AS `7_D`
			,CASE MTH WHEN 7 THEN TARGET_CATEGORY END AS `7_RESULT`
			,CASE MTH WHEN 8 THEN SUM(BUDGET) END AS `8_B`
			,CASE MTH WHEN 8 THEN SUM(ACTUAL) END AS `8_A`
			,CASE MTH WHEN 8 THEN SUM(ACHIEVEMENT) END AS `8_D`
			,CASE MTH WHEN 8 THEN TARGET_CATEGORY END AS `8_RESULT`
			,CASE MTH WHEN 9 THEN SUM(BUDGET) END AS `9_B`
			,CASE MTH WHEN 9 THEN SUM(ACTUAL) END AS `9_A`
			,CASE MTH WHEN 9 THEN SUM(ACHIEVEMENT) END AS `9_D`
			,CASE MTH WHEN 9 THEN TARGET_CATEGORY END AS `9_RESULT`
			,CASE MTH WHEN 10 THEN SUM(BUDGET) END AS `10_B`
			,CASE MTH WHEN 10 THEN SUM(ACTUAL) END AS `10_A`
			,CASE MTH WHEN 10 THEN SUM(ACHIEVEMENT) END AS `10_D`
			,CASE MTH WHEN 10 THEN TARGET_CATEGORY END AS `10_RESULT`
			,CASE MTH WHEN 11 THEN SUM(BUDGET) END AS `11_B`
			,CASE MTH WHEN 11 THEN SUM(ACTUAL) END AS `11_A`
			,CASE MTH WHEN 11 THEN SUM(ACHIEVEMENT) END AS `11_D`
			,CASE MTH WHEN 11 THEN TARGET_CATEGORY END AS `11_RESULT`
			,CASE MTH WHEN 12 THEN SUM(BUDGET) END AS `12_B`
			,CASE MTH WHEN 12 THEN SUM(ACTUAL) END AS `12_A`
			,CASE MTH WHEN 12 THEN SUM(ACHIEVEMENT) END AS `12_D`
			,CASE MTH WHEN 12 THEN TARGET_CATEGORY END AS `12_RESULT`



			from 
			rcbill_my.budget_actual_2019
			group by RUNDATE, CATEGORY, PACKAGE, MTH
	) A 
	GROUP BY RUNDATE, CATEGORY, PACKAGE
)
; 

select count(*) as rep_budget_actual_2019_pv from rcbill_my.rep_budget_actual_2019_pv;


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