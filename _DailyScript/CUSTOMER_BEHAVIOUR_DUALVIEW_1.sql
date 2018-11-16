#####################
# DUAL VIEW CUSTOMERS
#####################
SET @clientcode='I10769';  -- clet laporte
SET @clientcode='I20633';  -- green palm




SELECT 
    clientcode,
    periodmth,
    periodyear,
    package,
    (SUM(count) / COUNT(*)) AS avg_package
FROM
    (SELECT 
        period,
            periodday,
            periodmth,
            periodyear,
            clientcode,
            package,
            COUNT(*) AS count
    FROM
        rcbill_my.customercontractactivity
    WHERE
        servicecategory IN ('TV' , 'OTT')
            AND clientcode IN (SELECT 
										clientcode
									FROM
										rcbill_my.customercontractsnapshot
									WHERE
									package IN ('DUALVIEW'))
    GROUP BY period , periodday , periodmth , periodyear , clientcode , package) a
GROUP BY clientcode , periodmth , periodyear , package
ORDER BY clientcode , periodyear , periodmth
;


SELECT 
    *
FROM
    rcbill_my.customercontractsnapshot
WHERE
    servicecategory IN ('TV' , 'OTT')
        AND clientcode IN (SELECT 
            clientcode
        FROM
            rcbill_my.customercontractsnapshot
        WHERE
            package IN ('DUALVIEW'))
ORDER BY clientcode , lastcontractdate , contractcode , servicecategory , packagetype
;



select clientcode, firstcontractdate, lastcontractdate, packagetype,  
count(PackageType) as packagetypecount
from rcbill_my.customercontractsnapshot
where 
 servicecategory in ('TV','OTT') 
and 
-- clientcode=@clientcode
clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('DUALVIEW'))
group by clientcode,  firstcontractdate, lastcontractdate, packagetype;


set @dates='2018-01-01';
set @datee='2018-03-31';

select clientcode, firstcontractdate, lastcontractdate, packagetype,  
count(PackageType) as packagetypecount
from rcbill_my.customercontractsnapshot
where 
 servicecategory in ('TV','OTT') 
-- and 
-- firstcontractdate>=@dates and firstcontractdate<=

-- clientcode=@clientcode
-- clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('DUALVIEW'))
group by clientcode,  firstcontractdate, lastcontractdate, packagetype;










select 
*
-- , min(firstcontractdate) as contractstart, max(lastcontractdate) as contractend
-- distinct clientcode
from rcbill_my.customercontractsnapshot
where 
 servicecategory in ('TV','OTT') 
-- and PackageType='ADDON'
-- and package in ('Indian','Indian Corporate')
-- and CurrentStatus='Active'
-- and clientclass not in ('Employee','Intelvision Office')
-- and clientclass not in ('Employee','Intelvision Office')
 and 
-- clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('DUALVIEW'))

clientcode=@clientcode
order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
;


select clientcode, contractcode, firstcontractdate, lastcontractdate, packagetype,  
count(PackageType) as packagetypecount
from rcbill_my.customercontractsnapshot
where 
 servicecategory in ('TV','OTT') 
and 
clientcode=@clientcode
-- clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('DUALVIEW'))
group by clientcode, contractcode, firstcontractdate, lastcontractdate, packagetype;

select clientcode, firstcontractdate, lastcontractdate, packagetype,  
count(PackageType) as packagetypecount
from rcbill_my.customercontractsnapshot
where 
 servicecategory in ('TV','OTT') 
and 
clientcode=@clientcode
-- clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('DUALVIEW'))
group by clientcode,  firstcontractdate, lastcontractdate, packagetype;


-- select * from rcbill_my.customercontractactivity where clientcode=@clientcode;

select period, periodday, periodmth, periodyear, clientcode, package, count(*) as count
from rcbill_my.customercontractactivity 
-- where clientcode=@clientcode
where 
 servicecategory in ('TV','OTT') 
and 
clientcode=@clientcode
-- clientcode in (select clientcode from rcbill_my.customercontractsnapshot where  package in ('DUALVIEW'))
group by period, periodday, periodmth, periodyear, clientcode, package
order by period
;


select * from rcbill_my.customers_collection where ClientCode=@clientcode;


select * from rcbill_my.rep_customers_collection2018 where clientcode=@clientcode;


-- select * from rcbill_my.customers_collection_pivot2018 where clientcode=@clientcode;
/*
select * from rcbill_my.rep_cust_cont_payment_cmts_mxk where clientcode=@clientcode;
select * from rcbill_my.rep_allcust where clientcode=@clientcode;
select * from rcbill_my.cust_cont_payment_cmts_mxk where CL_CLIENTCODE=@clientcode;
*/
