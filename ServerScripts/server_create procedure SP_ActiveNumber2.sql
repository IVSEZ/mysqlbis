DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActiveNumber2`()
BEGIN
drop table if exists rcbill_my.anreport;

create table rcbill_my.anreport as
(
SELECT 
    period,
    periodday,
    periodmth,
    periodyear,
    weekday,
    mthname,
    service,
    servicecategory,
    GetServiceCategory2(service) as servicecategory2,
    servicesubcategory,
    servicetype,
    getcleanstring(servicetypeold) as package,
    clientclass,
    clienttype,
    region,
    decommissioned,
    reported,
    SUM(open) AS open_s,
    SUM(new) AS new_s,
    SUM(newconverted) AS newc_s,
    SUM(renew) AS renew_s,
    SUM(closed) AS closed_s,
    SUM(closednonpayment) AS closednon_s,
    SUM(suspended) AS suspended_s,
    SUM(closedconverted) AS closedcon_s,
    SUM(closedother) AS closedoth_s,
    SUM(totalopened) AS totopn_s,
    SUM(totalclosed) AS totcld_s,
    SUM(difference) AS diff_s
FROM
    rcbill_my.activenumber
/*
where 
periodday = pdday
and
periodmth = pdmth
and
periodyear = pdyr
*/
/*
and 
decommissioned in (decom) 
and 
reported in (rpt)
*/

GROUP BY period , periodday , periodmth , periodyear , weekday , mthname , 
service , servicecategory , servicecategory2, servicesubcategory , servicetype , package,
clientclass, clienttype , region , decommissioned , reported
ORDER BY periodyear , periodmth , periodday
)
;

CREATE INDEX IDXan1
ON rcbill_my.anreport (period);

CREATE INDEX IDXan2
ON rcbill_my.anreport (servicetype);

CREATE INDEX IDXan3
ON rcbill_my.anreport (package);

CREATE INDEX IDXan4
ON rcbill_my.anreport (clienttype);

CREATE INDEX IDXan5
ON rcbill_my.anreport (clientclass);


drop table if exists rcbill_my.rep_anreport_all;

create table rcbill_my.rep_anreport_all as 
(
select period, periodday, periodmth, periodyear, sum(open_s) as activecount 
, sum(totopn_s) as openedcount
, sum(totcld_s) as closedcount
from rcbill_my.anreport 
where reported='Y' and decommissioned='N'
group by period, periodday, periodmth, periodyear
order by period, periodday, periodmth, periodyear
)
;

drop table if exists rcbill_my.rep_anreport_i;

create table rcbill_my.rep_anreport_i as 
(
select period, periodday, periodmth, periodyear, sum(open_s) as activecount 
, sum(totopn_s) as openedcount
, sum(totcld_s) as closedcount
from rcbill_my.anreport 
where upper(servicecategory)='INTERNET' and reported='Y' and decommissioned='N'
group by period, periodday, periodmth, periodyear
order by period, periodday, periodmth, periodyear
)
;

drop table if exists rcbill_my.rep_anreport_t;

create table rcbill_my.rep_anreport_t as 
(
select period, periodday, periodmth, periodyear, sum(open_s) as activecount 
, sum(totopn_s) as openedcount
, sum(totcld_s) as closedcount
from rcbill_my.anreport 
where upper(servicecategory)='TV' and reported='Y' and decommissioned='N'
group by period, periodday, periodmth, periodyear
order by period, periodday, periodmth, periodyear
)
;

drop table if exists rcbill_my.rep_anreport_v;

create table rcbill_my.rep_anreport_v as 
(
select period, periodday, periodmth, periodyear, sum(open_s) as activecount 
, sum(totopn_s) as openedcount
, sum(totcld_s) as closedcount
from rcbill_my.anreport 
where upper(servicecategory)='VOICE' and reported='Y' and decommissioned='N'
group by period, periodday, periodmth, periodyear
order by period, periodday, periodmth, periodyear
)
;

drop table if exists rcbill_my.rep_anreport_o;

create table rcbill_my.rep_anreport_o as 
(
select period, periodday, periodmth, periodyear, sum(open_s) as activecount 
, sum(totopn_s) as openedcount
, sum(totcld_s) as closedcount
from rcbill_my.anreport 
where upper(servicecategory)='OTT' and reported='Y' and decommissioned='N'
group by period, periodday, periodmth, periodyear
order by period, periodday, periodmth, periodyear
)
;

/*
drop table if exists rcbill_my.rep_anreport_all;

create table rcbill_my.rep_anreport_all as 
(
select period, periodday, periodmth, periodyear, sum(open_s) as activecount from rcbill_my.anreport 
where reported='Y' and decommissioned='N'
group by period, periodday, periodmth, periodyear
order by period, periodday, periodmth, periodyear
)
;

drop table if exists rcbill_my.rep_anreport_i;

create table rcbill_my.rep_anreport_i as 
(
select period, periodday, periodmth, periodyear, sum(open_s) as activecount from rcbill_my.anreport 
where upper(servicecategory)='INTERNET' and reported='Y' and decommissioned='N'
group by period, periodday, periodmth, periodyear
order by period, periodday, periodmth, periodyear
)
;

drop table if exists rcbill_my.rep_anreport_t;

create table rcbill_my.rep_anreport_t as 
(
select period, periodday, periodmth, periodyear, sum(open_s) as activecount from rcbill_my.anreport 
where upper(servicecategory)='TV' and reported='Y' and decommissioned='N'
group by period, periodday, periodmth, periodyear
order by period, periodday, periodmth, periodyear
)
;

drop table if exists rcbill_my.rep_anreport_v;

create table rcbill_my.rep_anreport_v as 
(
select period, periodday, periodmth, periodyear, sum(open_s) as activecount from rcbill_my.anreport 
where upper(servicecategory)='VOICE' and reported='Y' and decommissioned='N'
group by period, periodday, periodmth, periodyear
order by period, periodday, periodmth, periodyear
)
;

drop table if exists rcbill_my.rep_anreport_o;

create table rcbill_my.rep_anreport_o as 
(
select period, periodday, periodmth, periodyear, sum(open_s) as activecount from rcbill_my.anreport 
where upper(servicecategory)='OTT' and reported='Y' and decommissioned='N'
group by period, periodday, periodmth, periodyear
order by period, periodday, periodmth, periodyear
)

;
*/


drop table if exists rcbill_my.rep_activenumberlastday;
create table rcbill_my.rep_activenumberlastday as
(
					select period, periodyear, periodmth, periodday, servicecategory, package, sum(open_s) as activecount
					from 
					(
						select a.* from rcbill_my.anreport a 
						inner join 
						( select max(`period`) period from rcbill_my.anreport group by date_format(period, '%Y-%m') ) b
						on 
						a.period=b.period
					) a
                    where reported='Y' and decommissioned='N'
					group by period,periodyear, periodmth, periodday, servicecategory, package                

);


set session group_concat_max_len = 10000;
SET @sql_dynamic = (
	SELECT
		GROUP_CONCAT( DISTINCT
			CONCAT(
				'  sum(IF(period = '''
				, period
				, ''', activecount,0))  AS `'
				, replace(period,'-','') , '`'
			)
		)
	FROM rcbill_my.rep_activenumberlastday
);

-- select @sql_dynamic;

drop table if exists rcbill_my.rep_activenumberlastday_pv; 

SET @sql = CONCAT('create table rcbill_my.rep_activenumberlastday_pv as (SELECT servicecategory, package, ', 
			  @sql_dynamic, ' 
		   FROM 
				rcbill_my.rep_activenumberlastday
		   GROUP BY servicecategory, package)'
	   );

-- select @sql;
	 
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

set session group_concat_max_len = 1024;

-- select * from rcbill_my.rep_activenumberlastday;
-- select * from rcbill_my.rep_activenumberlastday_pv;



drop table if exists rcbill_my.rep_ott;

create table rcbill_my.rep_ott as 
(
	select period,
	ifnull(sum(`DUALVIEW`),0) as `DUALVIEW`,
	ifnull(sum(`MULTIVIEW`),0) as `MULTIVIEW`,
	ifnull(sum(`IGO`),0) as `IGO`,
	ifnull(sum(`VOD`),0) as `VOD`,
	ifnull(sum(`MOBILE INDIAN`),0) as `MOBILE INDIAN`
	from
	(
		select period
		,case when upper(package)='DUALVIEW' then sum(open_s) end as `DUALVIEW`
		,case when upper(package)='MULTIVIEW' then sum(open_s) end as `MULTIVIEW`
		,case when upper(package)='IGO' then sum(open_s) end as `IGO`
		,case when upper(package)='VOD' then sum(open_s) end as `VOD`
		,case when upper(package)='MOBILE INDIAN' then sum(open_s) end as `MOBILE INDIAN`
        
		from
		rcbill_my.anreport
		where upper(servicecategory)='OTT' and reported='Y' and decommissioned='N'
		and year(period)=2019
		group by period, package  
	) a
	group by period
)
;





END$$
DELIMITER ;
