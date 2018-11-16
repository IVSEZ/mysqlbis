set @dates='2018-01-01';
set @datee='2018-09-30';
SET @clientcode='I10769';  -- clet laporte
SET @clientcode='I20633';  -- green palm
-- SET @clientcode='I1738'; -- MV
SET @clientcode='I.000012913';

/*
Residential
Corporate
Intelvision Office
Employee
VIP
Corporate Bundle
*/


select *
from rcbill_my.customercontractsnapshot
where servicecategory IN ('TV' , 'OTT')
and clientcode = @clientcode
order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
;

 select * from rcbill_my.customercontractactivity where clientcode=@clientcode;


	drop table if exists rcbill_my.tempcustbehc1;
	drop table if exists rcbill_my.tempcustbehc2;


    create table rcbill_my.tempcustbehc1 as 
    (
		SELECT 
			period,
				periodday,
				periodmth,
				periodyear,
				clientcode,
				package,
				case when servicesubcategory='ADDON' then 'ADDON'
					else 'STANDALONE'
				end as `PackageType`  
			
				,COUNT(*) AS count
		FROM
			rcbill_my.customercontractactivity
		WHERE
			servicecategory IN ('TV' , 'OTT')
			-- and clientcode=@clientcode
			/*
				AND clientcode IN (SELECT 
											clientcode
										FROM
											rcbill_my.customercontractsnapshot
										WHERE
										package IN ('DUALVIEW'))
				*/
				and (period>=@dates and period<=@datee)
				-- and upper(clientclass) in ('RESIDENTIAL')
				and upper(clienttype) in ('CORPORATE','CORPORATE BUNDLE')
                -- and upper(clienttype) in ('RESIDENTIAL')
				
		GROUP BY period , periodday , periodmth , periodyear , clientcode , package, 7
		order by period , periodday , periodmth , periodyear , clientcode , package
	)
    ;
    

    create table rcbill_my.tempcustbehc2 as 
    (
		 select period, periodday, periodmth, periodyear, clientcode
		 , ifnull(sum(`STANDALONE`),0) as `STANDALONE`
		 , ifnull(sum(`ADDON`),0) as `ADDON`
		 , coalesce(group_concat((package) order by package separator '|')) as packages
		 from 
		 (
			
				 select period, periodday, periodmth, periodyear, clientcode, package
				 ,case when packagetype='STANDALONE' then ifnull(count,0) end as `STANDALONE`
				 ,case when packagetype='ADDON' then ifnull(count,0) end as `ADDON`
				 
				 from 
					rcbill_my.tempcustbehc1 a 
				 group by period, periodday, periodmth, periodyear, clientcode, package
				 order by period, periodday, periodmth, periodyear, clientcode, package
			) a 
			group by period, periodday, periodmth, periodyear, clientcode
	)	
	;
    
    select * from rcbill_my.tempcustbehc1;
    
    select * from rcbill_my.tempcustbehc2 
    ;
    -- where standalone>1;
	-- where packages like '%DUAL%';	
 
    -- SET @clientcode='I.000007073' -- 'I22063'; -- 'I.000015664'; -- 'I9107';
    -- select * from rcbill_my.tempcustbeh1 where clientcode=@clientcode;
    -- select * from rcbill_my.tempcustbeh2 where clientcode=@clientcode;


### PIVOT
select standalone, addon, periodyear, periodmth
, count(distinct clientcode) as dcl
from 
rcbill_my.tempcustbehc2 
group by standalone, addon, periodyear, periodmth
order by standalone, addon, periodyear, periodmth
;  