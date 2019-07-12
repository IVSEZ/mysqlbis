use rcbill_my;

/*
select period, clientcode, clientname, contractcode,sum(activecount) as activecount,
		case when periodmth=8 then package end as `package_aug`,
		case when periodmth=9 then package end as `package_sep`     
        
from 
rcbill_my.customercontractactivity where (period in ('2017-08-15','2017-09-15') and reported='Y' and servicecategory='Internet')
group by period, clientcode, clientname, contractcode
order by clientcode, clientname, contractcode, period
;

-- select * from rcbill_my.customercontractactivity where period in ('2017-09-18') and reported='Y' and servicecategory='Internet';


select period, clientcode, clientname 
-- , clientclass
 , count(*) as contracts, sum(ACTIVECOUNT) as activecount,
-- 		case when period='2017-08-15' then period end as `period_start`,
		case when period='2017-08-15' then package end as `package_start`,
-- 		case when period='2017-08-15' then count(contractcode) end as `contracts_start`,
 		case when period='2017-08-15' then clientclass end as `cclass_start`,
-- 		case when period='2017-09-15' then period end as `period_end`,
		case when period='2017-09-15' then package end as `package_end`,
-- 		case when period='2017-09-15' then count(contractcode) end as `contracts_end`,   
 		case when period='2017-09-15' then clientclass end as `cclass_end`   


from 
rcbill_my.customercontractactivity where (period in ('2017-08-15','2017-09-15') and reported='Y' and servicecategory='Internet')
group by period, clientcode, clientname, contractcode, package_start, package_end, cclass_start, cclass_end
-- , period_start, period_end
-- , contracts_start, contracts_end
order by clientcode, clientname, period
;


select period, clientcode, clientname
, package_start, cclass_start
, case when package_start is not null then sum(contracts) end as contracts_start

, package_end, cclass_end
, case when package_end is not null then sum(contracts) end as contracts_end

from 
(
	select period, clientcode, clientname 
	-- , clientclass
	 , count(*) as contracts,
	-- 		case when period='2017-08-15' then period end as `period_start`,
			case when period='2017-08-14' then package end as `package_start`,
	-- 		case when period='2017-08-15' then count(contractcode) end as `contracts_start`,
			case when period='2017-08-14' then clientclass end as `cclass_start`,
	-- 		case when period='2017-09-15' then period end as `period_end`,
			case when period='2017-09-14' then package end as `package_end`,
	-- 		case when period='2017-09-15' then count(contractcode) end as `contracts_end`,   
			case when period='2017-09-14' then clientclass end as `cclass_end`   


	from 
	rcbill_my.customercontractactivity where (period in ('2017-08-14','2017-09-14') and reported='Y' and servicecategory='Internet')
	group by period, clientcode, clientname, contractcode, package_start, package_end, cclass_start, cclass_end
	-- , period_start, period_end
	-- , contracts_start, contracts_end
	order by clientcode, clientname, period
) a 
group by period, clientcode, clientname, package_start, cclass_start, package_end, cclass_end
order by clientcode, period
;

*/

set @date1='2019-03-31';
set @date2='2019-06-11';
-- set @date2='2017-09-30';
-- set @date2='2017-10-12';

##1
drop table if exists t1;
create table t1 as
(	
	select period as period_start, clientcode as clientcode_start, clientname as clientname_start, sum(activecount) as activecount_start
	, package_start, cclass_start, servicecategory2_start
	, case when package_start is not null then sum(contracts) end as contracts_start

	from 
	(
		select period, clientcode, clientname , sum(activecount) as activecount
		-- , clientclass
		 , count(*) as contracts,
				case when period=@date1 then package end as `package_start`,
				case when period=@date1 then clientclass end as `cclass_start`,
                case when period=@date1 then servicecategory2 end as `servicecategory2_start`
		from 
		rcbill_my.customercontractactivity where (period in (@date1) and reported='Y' and servicecategory='Internet' 
        and clientclass in ('Residential','Corporate Bulk','Corporate Bundle')
        )
		group by period, clientcode, clientname, contractcode, package_start, cclass_start, servicecategory2_start
		-- , period_start, period_end
		-- , contracts_start, contracts_end
		order by clientcode, clientname, period
	) a 
	group by period, clientcode, clientname, package_start, cclass_start, servicecategory2_start
	order by clientcode, period
)
;

##2
drop table if exists t2;
create table t2 as 
(
	select period as period_end, clientcode as clientcode_end, clientname as clientname_end, sum(activecount) as activecount_end
	, package_end, cclass_end, servicecategory2_end
	, case when package_end is not null then sum(contracts) end as contracts_end

	from 
	(
		select period, clientcode, clientname , sum(activecount) as activecount
		-- , clientclass
		 , count(*) as contracts,
				case when period=@date2 then package end as `package_end`,
				case when period=@date2 then clientclass end as `cclass_end`,
				case when period=@date2 then servicecategory2 end as `servicecategory2_end`

		from 
		rcbill_my.customercontractactivity where (period in (@date2) and reported='Y' and servicecategory='Internet' 
        and clientclass in ('Residential','Corporate Bulk','Corporate Bundle')
        )
		group by period, clientcode, clientname, contractcode, package_end, cclass_end, servicecategory2_end
		-- , period_start, period_end
		-- , contracts_start, contracts_end
		order by clientcode, clientname, period
	) a 
	group by period, clientcode, clientname, package_end, cclass_end, servicecategory2_end
	order by clientcode, period
)
;

select * from t1;
select * from t2;

/*
select
t1.*, t2.*

from 
t1
left join
t2 
on 
t1.clientcode=t2.clientcode;
*/

drop  table if exists t3;
create  table t3 as 
(
	select * , ifnull(clientcode_start, clientcode_end) as `clientcode`
    , 
    case 
		when clientcode_start is null then 'Activated'
		when clientcode_end is null then 'Deactivated'
        when package_start <> package_end then 'Changed Package'
        -- when cclass_start <> cclass_end then 'Changed Client Class'
        when package_start = package_end then 'Same Package'
	end as `MovementResult`
    , (ifnull(activecount_end,0)-ifnull(activecount_start,0)) as activecount_diff
    , (ifnull(contracts_end,0)-ifnull(contracts_start,0)) as contracts_diff  
    from 
	(
		SELECT * FROM t1
		LEFT JOIN t2 ON t1.clientcode_start = t2.clientcode_end
		UNION 
		SELECT * FROM t1
		RIGHT JOIN t2 ON t1.clientcode_start = t2.clientcode_end
        where t1.clientcode_start is null
	) t3
)
;
 
select * from t3; 

select a.*, b.IsAccountActive, b.AccountActivityStage, b.activeservices, b.activecontracts, b.activesubscriptions, b.firstactivedate, b.lastactivedate
from 
t3 a
left join 
rcbill_my.rep_custconsolidated b 
on 
a.clientcode=b.clientcode;
 
select * from rcbill_my.rep_custconsolidated where clientcode='I.000019951'; 
 select * from rcbill_my.customercontractactivity where clientcode='I.000019951';
 select * from rcbill_my.clientstats where clientcode='I.000019951';
 select * from rcbill_my.rep_allcust where clientcode='I.000019951';
 select * from rcbill_my.rep_cust_cont_payment_cmts_mxk where clientcode='I.000019951';
 
/*
t1.period as t1_period, t1.clientcode as t1_clientcode, t1.clientname as t1_clientname, t1.activecount_start as t1_activecount_start, t1.package_start as t1_package_start, t1.cclass_start as t1_cclass_start, t1.contracts_start as t1_contracts_start
, t2.period as t2_period, t2.clientcode as t2_clientcode, t2.clientname as t2_clientname, t2.activecount_end as t2_activecount_end, t2.package_end as t2_package_end, t2.cclass_end as t2_cclass_end, t2.contracts_end as t2_contracts_end
*/
		
/*
select a.period as period_start, a.clientcode as ccode_start, a.clientname as cname_start, a.package_start, a.cclass_start, a.contracts_start
, b.period as period_end, b.clientcode as ccode_end, b.clientname as cname_end, b.package_end, b.cclass_end, b.contracts_end
 from t1 as a
   left outer join t2 as b on a.clientcode = b.clientcode 
   -- and a.package_start=o.package_end
union all
select a.period as period_start, a.clientcode as ccode_start, a.clientname as cname_start, a.package_start, a.cclass_start, a.contracts_start
, b.period as period_end, b.clientcode as ccode_end, b.clientname as cname_end, b.package_end, b.cclass_end, b.contracts_end
 from t1 as a
   right outer join t2 as b on a.clientcode = b.clientcode
-- ;
where a.clientcode is null;
*/
/*
	select a.period as period_start, a.clientcode as ccode_start, a.clientname as cname_start, a.package_start, a.cclass_start, a.contracts_start, a.activecount_start
	, b.period as period_end, b.clientcode as ccode_end, b.clientname as cname_end, b.package_end, b.cclass_end, b.contracts_end, b.activecount_end
	 from t1 as a
	   left outer join t2 as b on a.clientcode = b.clientcode 
	   -- and a.package_start=o.package_end
	union all
	select a.period as period_start, a.clientcode as ccode_start, a.clientname as cname_start, a.package_start, a.cclass_start, a.contracts_start, a.activecount_start
	, b.period as period_end, b.clientcode as ccode_end, b.clientname as cname_end, b.package_end, b.cclass_end, b.contracts_end, b.activecount_end
	 from t1 as a
	   right outer join t2 as b on a.clientcode = b.clientcode
	-- ;
	where a.clientcode is null;
*/
/*
select distinct period_start, ccode_start, cname_start, package_start, cclass_start, sum(contracts_start) 
, period_end, ccode_end, cname_end, package_end, cclass_end, sum(contracts_end)
from 
(
	select a.period as period_start, a.clientcode as ccode_start, a.clientname as cname_start, a.package_start, a.cclass_start, a.contracts_start
	, b.period as period_end, b.clientcode as ccode_end, b.clientname as cname_end, b.package_end, b.cclass_end, b.contracts_end
	 from t1 as a
	   left outer join t2 as b on a.clientcode = b.clientcode 
	   -- and a.package_start=o.package_end
	union all
	select a.period as period_start, a.clientcode as ccode_start, a.clientname as cname_start, a.package_start, a.cclass_start, a.contracts_start
	, b.period as period_end, b.clientcode as ccode_end, b.clientname as cname_end, b.package_end, b.cclass_end, b.contracts_end
	 from t1 as a
	   right outer join t2 as b on a.clientcode = b.clientcode
	-- ;
	where a.clientcode is null
) a     
-- where
-- ( (cclass_end != 'Employee' and cclass_start != 'Employee'))

group by 
period_start, ccode_start, cname_start, package_start, cclass_start 
, period_end, ccode_end, cname_end, package_end, cclass_end

    
;
*/

##SUMMARY
/*
select distinct package_start
-- , cclass_start
, count(ccode_start) as ccode_start, sum(contracts_start), sum(activecount_start)
, package_end, count(ccode_end) as ccode_end, sum(contracts_end), sum(activecount_end)
-- , cclass_end

from 
(
	select a.period as period_start, a.clientcode as ccode_start, a.clientname as cname_start, a.package_start, a.cclass_start, a.contracts_start, a.activecount_start
	, b.period as period_end, b.clientcode as ccode_end, b.clientname as cname_end, b.package_end, b.cclass_end, b.contracts_end, b.activecount_end
	 from t1 as a
	   left outer join t2 as b on a.clientcode = b.clientcode 
	   -- and a.package_start=o.package_end
	union all
	select a.period as period_start, a.clientcode as ccode_start, a.clientname as cname_start, a.package_start, a.cclass_start, a.contracts_start, a.activecount_start
	, b.period as period_end, b.clientcode as ccode_end, b.clientname as cname_end, b.package_end, b.cclass_end, b.contracts_end, b.activecount_end
	 from t1 as a
	   right outer join t2 as b on a.clientcode = b.clientcode
	-- ;
	where a.clientcode is null
) a     
-- where
-- ( (cclass_end != 'Employee' and cclass_start != 'Employee'))

group by 
package_start
-- , cclass_start 
, package_end
-- , cclass_end

    
;


select package_start, count(distinct clientcode), sum(contracts_start), sum(activecount_start) from 
t1
group by package_start;

select package_end, count(distinct clientcode), sum(contracts_end), sum(activecount_end) from 
t2
group by package_end;




*/

























/*
drop table if exists rcbill_my.t1;

create table rcbill_my.t1 as
(
select period, clientcode, clientname, clientclass, count(contractcode) as contracts,
		case when period='2017-08-15' then period end as `period_start`,
		case when period='2017-08-15' then package end as `package_start`,
		case when period='2017-08-15' then count(contractcode) end as `contracts_start`,
		case when period='2017-08-15' then clientclass end as `cclass_start`
 /*       
		case when period='2017-09-15' then period end as `period_end`,
		case when period='2017-09-15' then package end as `package_end`,
		case when period='2017-09-15' then count(contractcode) end as `contracts_end`,   
		case when period='2017-09-15' then clientclass end as `cclass_end`   
*/
/*
from 
rcbill_my.customercontractactivity where (period in ('2017-08-15') and reported='Y' and servicecategory='Internet')
group by clientcode, clientname, period, clientclass, package_start
order by clientcode, clientname
)
;
select * from rcbill_my.t1;

drop table if exists rcbill_my.t2;

create table rcbill_my.t2 as
(
select period, clientcode, clientname, clientclass, count(contractcode) as contracts,
/*
		case when period='2017-08-15' then period end as `period_start`,
		case when period='2017-08-15' then package end as `package_start`,
		case when period='2017-08-15' then count(contractcode) end as `contracts_start`,
		case when period='2017-08-15' then clientclass end as `cclass_start`,
 */   
 /*
		case when period='2017-09-15' then period end as `period_end`,
		case when period='2017-09-15' then package end as `package_end`,
		case when period='2017-09-15' then count(contractcode) end as `contracts_end`,   
		case when period='2017-09-15' then clientclass end as `cclass_end`   
from 
rcbill_my.customercontractactivity where (period in ('2017-09-15') and reported='Y' and servicecategory='Internet')
group by clientcode, clientname, period, clientclass, package_end
order by clientcode, clientname
)
;


select * from rcbill_my.t2;
select * from rcbill_my.t1;

/*
select * from rcbill_my.tempclientmovement;

select clientcode, clientname, clientclass, sum(contracts) as contracts
-- , period_start
, sum(package_start)
-- , contracts_start, cclass_start, period_end
, sum(package_end)
-- , contracts_end, cclass_end
from 
rcbill_my.tempclientmovement

group by clientcode, clientname, clientclass
-- ,period_start
, package_start
-- , contracts_start, cclass_start, period_end
, package_end
-- , contracts_end, cclass_end
;
*/

/*
select a.clientcode, a.clientname, a.clientclass, a.package_start, b.package_end, a.contracts,b.contracts
from 
rcbill_my.t1 a 
left join
rcbill_my.t2 b 
on
a.clientcode=b.clientcode
and
a.package_start=b.package_end
;


SELECT a.clientclass, a.package_start,b.package_end,count(*) FROM rcbill_my.t1 a
LEFT JOIN rcbill_my.t2 b ON 
a.package_start=b.package_end
group by a.clientclass, a.package_start,b.package_end

-- a.clientcode = b.clientcode
UNION
SELECT a.clientclass, a.package_start,b.package_end, count(*) FROM rcbill_my.t1 a
RIGHT JOIN rcbill_my.t2 b ON 
a.package_start=b.package_end
-- a.clientcode = b.clientcode

group by a.package_start, b.package_end
;
*/
/*
select a.clientcode, a.clientname, (a.contracts + b.contracts) as contracts, a.package_start, b.package_end
from 
rcbill_my.tempclientmovement1 a
join 
rcbill_my.tempclientmovement2 b 
on 
a.clientcode=b.clientcode
where a.package_start is not null and b.package_end is not null
;
*/
