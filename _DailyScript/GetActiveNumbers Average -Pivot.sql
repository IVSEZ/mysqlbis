use rcbill_my;

-- SET @today ='2018-12-01';
-- select @today := current_date();
select @today := subdate(current_date(),1);
select @lastdayofmonth := last_day(@today);


drop table if exists rcbill_my.activenumberavg;

create table rcbill_my.activenumberavg as
(

		SELECT 
		-- periodday, 
        -- if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period)) as lastday
		max(period) as period,
        -- if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,max(period)) as period,
		servicecategory, 
		servicesubcategory,
		baseservice,
		service,
		GetServiceCategory2(service) as servicecategory2, 
		-- getcleanstring(servicetypeold) as package,
		servicetype as package,
		reported,
		decommissioned,
		periodmth,
		mthname,
		periodyear,
		clientclass,
		clienttype,
		region,
		sum(open) as open_s,
		-- (sum(open) / day(LAST_DAY(period)) ) as open_a,
        (sum(open) / day(if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period))) ) as open_a,

		sum(new) as new_s,
		-- (sum(new) / day(LAST_DAY(period)) ) as new_a,
		(sum(new) / day(if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period))) ) as new_a,

		sum(newconverted) as newc_s,
		-- (sum(newconverted) / day(LAST_DAY(period)) ) as newc_a,
		(sum(newconverted) / day(if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period))) ) as newc_a,

		sum(renew) as renew_s,
		-- (sum(renew) / day(LAST_DAY(period)) ) as renew_a,
		(sum(renew) / day(if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period))) ) as renew_a,

		sum(closed) as closed_s,
		-- (sum(closed) / day(LAST_DAY(period)) ) as closed_a,
		(sum(closed) / day(if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period))) ) as closed_a,

		sum(closednonpayment) as closednon_s,
		-- (sum(closednonpayment) / day(LAST_DAY(period)) ) as closednon_a,
		(sum(closednonpayment) / day(if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period))) ) as closednon_a,

		sum(suspended) as suspended_s,
		-- (sum(suspended) / day(LAST_DAY(period)) ) as suspended_a,
		(sum(suspended) / day(if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period))) ) as suspended_a,

		sum(closedconverted) as closedcon_s,
		-- (sum(closedconverted) / day(LAST_DAY(period)) ) as closedcon_a,
		(sum(closedconverted) / day(if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period))) ) as closedcon_a,

		sum(closedother) as closedoth_s,
		-- (sum(closedother) / day(LAST_DAY(period)) ) as closedoth_a,
		(sum(closedother) / day(if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period))) ) as closedoth_a,

		sum(totalopened) as totopn_s,
		-- (sum(totalopened) / day(LAST_DAY(period)) ) as totopn_a,
		(sum(totalopened) / day(if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period))) ) as totopn_a,

		sum(totalclosed) as totcld_s,
		-- (sum(totalclosed) / day(LAST_DAY(period)) ) as totcld_a,
		(sum(totalclosed) / day(if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period))) ) as totcld_a,

		sum(difference) as diff_s,
		-- (sum(difference) / day(LAST_DAY(period)) ) as diff_a
		(sum(difference) / day(if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period))) ) as diff_a



		FROM rcbill_my.activenumber
		 -- where period not in ('2017-07-03','2017-07-02','2017-07-01')
		--  where (mthname <> 'July' and periodyear <> '2017')
		-- and
		-- reported = 'Y' and decommissioned = 'N'
		group by
		-- periodday, servicecategory, servicesubcategory,
		reported,
		decommissioned,
		servicecategory,
		servicesubcategory,
		baseservice,
		service,
		GetServiceCategory2(service),
		-- package,
		servicetype,
		periodmth,
		mthname,
		periodyear,
		clientclass,
		clienttype,
		region

		order by
		periodyear,
		periodmth
)
;


CREATE INDEX IDXanavg1
ON rcbill_my.activenumberavg (periodmth);

CREATE INDEX IDXanavg2
ON rcbill_my.activenumberavg (package);

CREATE INDEX IDXanavg3
ON rcbill_my.activenumberavg (reported);

-- DROP INDEX `IDXanavg3` ON rcbill_my.activenumberavg ;

-- select * from rcbill_my.activenumberavg;
-- select * from rcbill_my.activenumberavg where reported='Y' and decommissioned='N';

select count(*) as activenumberavg from rcbill_my.activenumberavg;

drop table if exists rcbill_my.rep_activenumberavg;

create table rcbill_my.rep_activenumberavg as 
(
	select servicecategory, servicesubcategory, servicecategory2, package, clientclass, clienttype, region, reported, decommissioned
	, ifnull(sum(`202001`),0) as `202001`
	, ifnull(sum(`201912`),0) as `201912`
	, ifnull(sum(`201911`),0) as `201911`
	, ifnull(sum(`201910`),0) as `201910`
	, ifnull(sum(`201909`),0) as `201909`
	, ifnull(sum(`201908`),0) as `201908`
	, ifnull(sum(`201907`),0) as `201907`
	, ifnull(sum(`201906`),0) as `201906`
	, ifnull(sum(`201905`),0) as `201905`
	, ifnull(sum(`201904`),0) as `201904`
	, ifnull(sum(`201903`),0) as `201903`
	, ifnull(sum(`201902`),0) as `201902`
	, ifnull(sum(`201901`),0) as `201901`
	, ifnull(sum(`201812`),0) as `201812`
	, ifnull(sum(`201811`),0) as `201811`
	, ifnull(sum(`201810`),0) as `201810`
	, ifnull(sum(`201809`),0) as `201809`
	, ifnull(sum(`201808`),0) as `201808`
	, ifnull(sum(`201807`),0) as `201807`
	, ifnull(sum(`201806`),0) as `201806`
	, ifnull(sum(`201805`),0) as `201805`
	, ifnull(sum(`201804`),0) as `201804`
	, ifnull(sum(`201803`),0) as `201803`
	, ifnull(sum(`201802`),0) as `201802`
	, ifnull(sum(`201801`),0) as `201801`
	, ifnull(sum(`201712`),0) as `201712`
	, ifnull(sum(`201711`),0) as `201711`
	, ifnull(sum(`201710`),0) as `201710`
	, ifnull(sum(`201709`),0) as `201709`
	, ifnull(sum(`201708`),0) as `201708`
	, ifnull(sum(`201707`),0) as `201707`
	, ifnull(sum(`201706`),0) as `201706`
	, ifnull(sum(`201705`),0) as `201705`
	, ifnull(sum(`201704`),0) as `201704`
	, ifnull(sum(`201703`),0) as `201703`
	, ifnull(sum(`201702`),0) as `201702`
	, ifnull(sum(`201701`),0) as `201701`
	, ifnull(sum(`201612`),0) as `201612`
	, ifnull(sum(`201611`),0) as `201611`
	, ifnull(sum(`201610`),0) as `201610`
	, ifnull(sum(`201609`),0) as `201609`
	, ifnull(sum(`201608`),0) as `201608`
	, ifnull(sum(`201607`),0) as `201607`
	, ifnull(sum(`201606`),0) as `201606`
	, ifnull(sum(`201605`),0) as `201605`
	, ifnull(sum(`201604`),0) as `201604`
	, ifnull(sum(`201603`),0) as `201603`
	, ifnull(sum(`201602`),0) as `201602`
	, ifnull(sum(`201601`),0) as `201601`



	from 
	(
		select 
		servicecategory, servicesubcategory, servicecategory2, package, clientclass, clienttype, region, reported, decommissioned 
			, case when periodyear=2020 and periodmth=01 then open_a end as `202001`
			, case when periodyear=2019 and periodmth=12 then open_a end as `201912`
			, case when periodyear=2019 and periodmth=11 then open_a end as `201911`
			, case when periodyear=2019 and periodmth=10 then open_a end as `201910`
			, case when periodyear=2019 and periodmth=09 then open_a end as `201909`
			, case when periodyear=2019 and periodmth=08 then open_a end as `201908`
			, case when periodyear=2019 and periodmth=07 then open_a end as `201907`
			, case when periodyear=2019 and periodmth=06 then open_a end as `201906`
			, case when periodyear=2019 and periodmth=05 then open_a end as `201905`
			, case when periodyear=2019 and periodmth=04 then open_a end as `201904`
			, case when periodyear=2019 and periodmth=03 then open_a end as `201903`
			, case when periodyear=2019 and periodmth=02 then open_a end as `201902`
			, case when periodyear=2019 and periodmth=01 then open_a end as `201901`
			, case when periodyear=2018 and periodmth=12 then open_a end as `201812`
			, case when periodyear=2018 and periodmth=11 then open_a end as `201811`
			, case when periodyear=2018 and periodmth=10 then open_a end as `201810`
			, case when periodyear=2018 and periodmth=09 then open_a end as `201809`
			, case when periodyear=2018 and periodmth=08 then open_a end as `201808`
			, case when periodyear=2018 and periodmth=07 then open_a end as `201807`
			, case when periodyear=2018 and periodmth=06 then open_a end as `201806`
			, case when periodyear=2018 and periodmth=05 then open_a end as `201805`
			, case when periodyear=2018 and periodmth=04 then open_a end as `201804`
			, case when periodyear=2018 and periodmth=03 then open_a end as `201803`
			, case when periodyear=2018 and periodmth=02 then open_a end as `201802`
			, case when periodyear=2018 and periodmth=01 then open_a end as `201801`
			, case when periodyear=2017 and periodmth=12 then open_a end as `201712`
			, case when periodyear=2017 and periodmth=11 then open_a end as `201711`
			, case when periodyear=2017 and periodmth=10 then open_a end as `201710`
			, case when periodyear=2017 and periodmth=09 then open_a end as `201709`
			, case when periodyear=2017 and periodmth=08 then open_a end as `201708`
			, case when periodyear=2017 and periodmth=07 then open_a end as `201707`
			, case when periodyear=2017 and periodmth=06 then open_a end as `201706`
			, case when periodyear=2017 and periodmth=05 then open_a end as `201705`
			, case when periodyear=2017 and periodmth=04 then open_a end as `201704`
			, case when periodyear=2017 and periodmth=03 then open_a end as `201703`
			, case when periodyear=2017 and periodmth=02 then open_a end as `201702`
			, case when periodyear=2017 and periodmth=01 then open_a end as `201701`
			, case when periodyear=2016 and periodmth=12 then open_a end as `201612`
			, case when periodyear=2016 and periodmth=11 then open_a end as `201611`
			, case when periodyear=2016 and periodmth=10 then open_a end as `201610`
			, case when periodyear=2016 and periodmth=09 then open_a end as `201609`
			, case when periodyear=2016 and periodmth=08 then open_a end as `201608`
			, case when periodyear=2016 and periodmth=07 then open_a end as `201607`
			, case when periodyear=2016 and periodmth=06 then open_a end as `201606`
			, case when periodyear=2016 and periodmth=05 then open_a end as `201605`
			, case when periodyear=2016 and periodmth=04 then open_a end as `201604`
			, case when periodyear=2016 and periodmth=03 then open_a end as `201603`
			, case when periodyear=2016 and periodmth=02 then open_a end as `201602`
			, case when periodyear=2016 and periodmth=01 then open_a end as `201601`


		from rcbill_my.activenumberavg
		-- where reported='Y' and decommissioned='N'
) a 
group by servicecategory, servicesubcategory, servicecategory2, package, clientclass, clienttype, region, reported, decommissioned
)
;

-- select * from rcbill_my.rep_activenumberavg where reported='Y' and decommissioned='N' and package='Corporate';
select count(*) as rep_activenumberavg from rcbill_my.rep_activenumberavg;
select count(*) as rep_activenumberavg1 from rcbill_my.rep_activenumberavg where reported='Y' and decommissioned='N';

drop table if exists rcbill_my.rep_activenumberavg2;
create table rcbill_my.rep_activenumberavg2 as
(
					select 
                    -- max(period) as maxperiod, 
                    if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period)) as lastday
                    , periodyear, periodmth, servicecategory, package, sum(open_a) as activecount
					from 
					rcbill_my.activenumberavg
                    where reported='Y' and decommissioned='N'
					group by periodyear, periodmth, servicecategory, package             

);


drop table if exists rcbill_my.rep_activenumberavg3;
create table rcbill_my.rep_activenumberavg3 as
(
					select 
                    -- max(period) as maxperiod, 
                    if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period)) as lastday
                    , periodyear, periodmth, servicecategory, package
                    , clienttype, region
                    , sum(open_a) as activecount
					from 
					rcbill_my.activenumberavg
                    where reported='Y' and decommissioned='N'
					group by periodyear, periodmth, servicecategory, package, clienttype, region             

);


-- select * from rcbill_my.rep_activenumberavg2;

set session group_concat_max_len = 50000;
SET @sql_dynamic = (
	SELECT
		GROUP_CONCAT( DISTINCT
			CONCAT(
				'  sum(IF(lastday = '''
				, lastday
				, ''', activecount,0))  AS `'
				, replace(lastday,'-','') , '`'
			)
		)
	FROM rcbill_my.rep_activenumberavg2
);

-- select @sql_dynamic;

drop table if exists rcbill_my.rep_activenumberavg_pv; 

SET @sql = CONCAT('create table rcbill_my.rep_activenumberavg_pv as (SELECT servicecategory, package, ', 
			  @sql_dynamic, ' 
		   FROM 
				rcbill_my.rep_activenumberavg2
		   GROUP BY servicecategory, package)'
	   );

-- select @sql;
	 
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

set session group_concat_max_len = 1024;

-- select * from rcbill_my.rep_activenumberavg2;
-- select * from rcbill_my.rep_activenumberavg_pv;

select count(*) as rep_activenumberavg2 from rcbill_my.rep_activenumberavg2;
select count(*) as rep_activenumberavg_pv from rcbill_my.rep_activenumberavg_pv;


-- MAHE PIVOT

drop table if exists rcbill_my.rep_activenumberavgMahe;
create table rcbill_my.rep_activenumberavgMahe as
(
					select 
                    -- max(period) as maxperiod, 
                    if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period)) as lastday
                    , periodyear, periodmth, servicecategory, package, sum(open_a) as activecount
					from 
					rcbill_my.activenumberavg
                    where reported='Y' and decommissioned='N'
                    and upper(region)='MAHE'
					group by periodyear, periodmth, servicecategory, package             

);
-- select * from rcbill_my.rep_activenumberavgMahe;

set session group_concat_max_len = 50000;
SET @sql_dynamic = (
	SELECT
		GROUP_CONCAT( DISTINCT
			CONCAT(
				'  sum(IF(lastday = '''
				, lastday
				, ''', activecount,0))  AS `'
				, replace(lastday,'-','') , '`'
			)
		)
	FROM rcbill_my.rep_activenumberavgMahe
);

-- select @sql_dynamic;

drop table if exists rcbill_my.rep_activenumberavgMahe_pv; 

SET @sql = CONCAT('create table rcbill_my.rep_activenumberavgMahe_pv as (SELECT servicecategory, package, ', 
			  @sql_dynamic, ' 
		   FROM 
				rcbill_my.rep_activenumberavgMahe
		   GROUP BY servicecategory, package)'
	   );

-- select @sql;
	 
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

set session group_concat_max_len = 1024;

select count(*) as rep_activenumberavgMahe from rcbill_my.rep_activenumberavgMahe;
select count(*) as rep_activenumberavgMahe_pv from rcbill_my.rep_activenumberavgMahe_pv;

-- PRASLIN


drop table if exists rcbill_my.rep_activenumberavgPraslin;
create table rcbill_my.rep_activenumberavgPraslin as
(
					select 
                    -- max(period) as maxperiod, 
                    if(month(@today)=month(period) and year(@today)=year(period) and @today<>@lastdayofmonth,@today,last_day(period)) as lastday
                    , periodyear, periodmth, servicecategory, package, sum(open_a) as activecount
					from 
					rcbill_my.activenumberavg
                    where reported='Y' and decommissioned='N'
                    and upper(region)='PRASLIN'
					group by periodyear, periodmth, servicecategory, package             

);
-- select * from rcbill_my.rep_activenumberavgMahe;

set session group_concat_max_len = 50000;
SET @sql_dynamic = (
	SELECT
		GROUP_CONCAT( DISTINCT
			CONCAT(
				'  sum(IF(lastday = '''
				, lastday
				, ''', activecount,0))  AS `'
				, replace(lastday,'-','') , '`'
			)
		)
	FROM rcbill_my.rep_activenumberavgPraslin
);

-- select @sql_dynamic;

drop table if exists rcbill_my.rep_activenumberavgPraslin_pv; 

SET @sql = CONCAT('create table rcbill_my.rep_activenumberavgPraslin_pv as (SELECT servicecategory, package, ', 
			  @sql_dynamic, ' 
		   FROM 
				rcbill_my.rep_activenumberavgPraslin
		   GROUP BY servicecategory, package)'
	   );

-- select @sql;
	 
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

set session group_concat_max_len = 1024;

select count(*) as rep_activenumberavgPraslin from rcbill_my.rep_activenumberavgPraslin;
select count(*) as rep_activenumberavgPraslin_pv from rcbill_my.rep_activenumberavgPraslin_pv;