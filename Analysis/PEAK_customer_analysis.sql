##### INTERNET CUSTOMERS ANALYSIS


#############################################
/*
TO FIND CUSTOMERS WHO WERE ON INTERNET AND 
THEIR CURRENT BEHAVIOUR

*/
#############################################

/*
select * from rcbill_my.rep_anreport_i;

select * from rcbill_my.anreport;

select * from rcbill_my.customercontractactivity WHERE CLIENTCODE='I9658'; limit 100;
-- select * from rcbill_my.rep_anreport_all;
*/




#CREATE TEMP TABLE WITH THE PEAK DATE



 SET @servicecategory='Internet';
-- SET @servicecategory='TV';

## CHANGE THE TABLE NAME
drop table if exists tempperiod;

create table tempperiod as 
(
	select period from 
    (
		select period
		-- , package
		, sum(activecount) as activeno
        
        ### comment one depending on the report 
		 from rcbill_my.rep_anreport_i
		-- from rcbill_my.rep_anreport_t
        
        where 0=0
        and periodyear>=year(now())
		group by 
		period
		-- , package
		order by 2 desc
	) a limit 1
)    
;


SET @peakdate = (select period from tempperiod);
SET @enddate = (select max(month_all_date) from rcbill_my.month_all_date);





### JOIN THE TWO TABLES
drop table if exists tempextract1;
create table tempextract1(index idxt1(clientcode)) as 
(
		select @peakdate as `PEAK_DATE`, clientcode AS CLIENTCODE, clientname as PEAK_CLIENTNAME, clientclass as PEAK_CLIENTCLASS, network as PEAK_NETWORK, package as PEAK_PACKAGE
		, contractcode as PEAK_CONTRACTCODE, service as PEAK_SERVICE
		, activecount AS PEAK_ACTIVECOUNT, region AS PEAK_REGION, cl_location AS PEAK_LOCATION
        from rcbill_my.customercontractactivity where period in 
		(
			@peakdate 
        )

		and servicecategory in (@servicecategory)
        -- and clientclass in ('Residential','Corporate','Corporate Bulk')
		and REPORTED='Y'
		order by  activecount desc, clientcode asc
);

-- select * from tempextract1

drop table if exists tempextract2;
create table tempextract2(index idxt1(clientcode)) as 
(
		select @enddate as `LAST_DATE`, clientcode AS CLIENTCODE, clientname AS LAST_CLIENTNAME, clientclass AS LAST_CLIENTCLASS, network AS LAST_NETWORK, package as LAST_PACKAGE
		, contractcode as LAST_CONTRACTCODE, service as LAST_SERVICE
		, activecount AS LAST_ACTIVECOUNT, region AS LAST_REGION, cl_location AS LAST_LOCATION from rcbill_my.customercontractactivity where period in 
		(
			@enddate 
        )

		and servicecategory in (@servicecategory)
        -- and clientclass in ('Residential','Corporate','Corporate Bulk')
		and REPORTED='Y'
		order by  activecount desc, clientcode asc
);

-- select * from tempextract2


### GET FULL OUTER JOIN OF CUSTOMERS TO SEE NET GROWTH OR LOSS

select a.clientcode, t1.PEAK_DATE, t1.PEAK_CLIENTNAME, t1.PEAK_CLIENTCLASS, t1.PEAK_NETWORK, t1.PEAK_CONTRACTCODE, t1.PEAK_SERVICE, t1.PEAK_PACKAGE, t1.PEAK_ACTIVECOUNT, t1.PEAK_REGION, t1.PEAK_LOCATION
				,t2.LAST_DATE, t2.LAST_CLIENTNAME, t2.LAST_CLIENTCLASS, t2.LAST_NETWORK, t2.LAST_CONTRACTCODE, t2.LAST_SERVICE, t2.LAST_PACKAGE, t2.LAST_ACTIVECOUNT, t2.LAST_REGION, t2.LAST_LOCATION
-- , (select min(period) from rcbill_my.customercontractactivity b where b.clientcode=a.clientcode and servicecategory=@servicecategory and reported='Y') as FIRST_ACTIVE_DATE
-- , (select max(period) from rcbill_my.customercontractactivity b where b.clientcode=a.clientcode and servicecategory=@servicecategory and reported='Y') as LAST_ACTIVE_DATE

, (select min(b.firstcontractdate) from rcbill_my.customercontractsnapshot  b where b.clientcode=a.clientcode and b.servicecategory=@servicecategory) as FIRST_ACTIVE_DATE
, (select max(b.lastcontractdate) from rcbill_my.customercontractsnapshot b where b.clientcode=a.clientcode and b.servicecategory=@servicecategory) as LAST_ACTIVE_DATE

-- , (select min(b.firstcontractdate) from rcbill_my.customercontractsnapshot  b where b.clientcode=a.clientcode and b.contractcode=t1.PEAK_CONTRACTCODE) as FIRST_ACTIVE_DATE
-- , (select max(b.lastcontractdate) from rcbill_my.customercontractsnapshot b where b.clientcode=a.clientcode and b.contractcode=t2.LAST_CONTRACTCODE) as LAST_ACTIVE_DATE
                
from (
    select CLIENTCODE -- , PEAK_PACKAGE AS PACKAGE 
    from tempextract1
    union 
    select CLIENTCODE -- , LAST_PACKAGE AS PACKAGE 
    from tempextract2
	) a
	left outer join tempextract1 t1 on a.CLIENTCODE = t1.CLIENTCODE
	left outer join tempextract2 t2 on a.CLIENTCODE = t2.CLIENTCODE
	-- left outer join tempextract1 t1 on a.CLIENTCODE = t1.CLIENTCODE and a.PACKAGE=t1.PEAK_PACKAGE
	-- left outer join tempextract2 t2 on a.CLIENTCODE = t2.CLIENTCODE and a.PACKAGE=t2.LAST_PACKAGE
	;



-- peak customer status
select reportdate, clientcode, currentdebt, IsAccountActive, AccountActivityStage, clientname, clientclass, activenetwork, activeservices, activecontracts, activesubscriptions, clientaddress, clientlocation
, firstactivedate, lastactivedate, dayssincelastactive
, firstcontractdate, firstinvoicedate, firstpaymentdate, lastinvoicedate, lastpaidamount, lastpaymentdate, totalpayments, totalpaymentamount
, clientarea, subdistrict, clientparcel, coord_x, coord_y, latitude, longitude, clientemail, clientnin, clientpassport, clientphone

from rcbill_my.rep_custconsolidated where clientcode in (select clientcode from tempextract1);