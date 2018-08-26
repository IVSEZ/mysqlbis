/*

select * from rcbill_my.rep_anreport_t;

select * from rcbill_my.anreport;

select * from rcbill_my.customercontractactivity WHERE CLIENTCODE='I9658'; limit 100;





*/
use rcbill_my;


#FIND DATES WHEN THE NUMBER OF ACTIVE EXTRAVAGANCE CUSTOMERS PEAKED
select period
-- , package
, sum(open_s) as activeno
from rcbill_my.anreport
where reported='Y' and decommissioned='N'
and package in ('Extravagance','Extravagance Corporate')
group by 
period
-- , package
order by 2 desc
;



#CREATE TEMP TABLE WITH THE PEAK DATE
drop table if exists tempperiod;

create table tempperiod as 
(
	select period from 
    (
		select period
		-- , package
		, sum(open_s) as activeno
		from rcbill_my.anreport
		where reported='Y' and decommissioned='N'
		and package in ('Extravagance','Extravagance Corporate')
		group by 
		period
		-- , package
		order by 2 desc
	) a limit 1
)    
;

SET @peakperiod = (select period from tempperiod);




### JOIN THE TWO TABLES

drop table if exists rcbill_my.rep_extravagance_peakcustomer_activity;


drop table if exists tempextract1;
create table tempextract1 as 
(
		select clientcode, clientname, clientclass, network, package as peak_package
		-- , contractcode
		, activecount, region from rcbill_my.customercontractactivity where period in 
		(
		-- '2018-07-06'
			@peakperiod 
        )

		and package in ('Extravagance','Extravagance Corporate')
		and REPORTED='Y'
		order by  activecount desc, clientcode asc
);


-- select * from tempextract1;

create table rcbill_my.rep_extravagance_peakcustomer_activity
as
(

	select a.*, b.*
	from 
	/*(
		
		select clientcode, clientname, clientclass, network
		-- , contractcode
		, activecount, region from rcbill_my.customercontractactivity where period in 
		(
		-- '2018-07-06'
			@peakperiod 
        )

		and package in ('Extravagance','Extravagance Corporate')
		and REPORTED='Y'
		order by  activecount desc, clientcode asc
        
        
	)*/
    tempextract1 a 
	left join 
	(

		select clientcode as client_code, package, servicesubcategory,
		ifnull(sum(`201601`),0) as `201601`,
		ifnull(sum(`201602`),0) as `201602`,
		ifnull(sum(`201603`),0) as `201603`,
		ifnull(sum(`201604`),0) as `201604`,
		ifnull(sum(`201605`),0) as `201605`,
		ifnull(sum(`201606`),0) as `201606`,
		ifnull(sum(`201607`),0) as `201607`,
		ifnull(sum(`201608`),0) as `201608`,
		ifnull(sum(`201609`),0) as `201609`,
		ifnull(sum(`201610`),0) as `201610`,
		ifnull(sum(`201611`),0) as `201611`,
		ifnull(sum(`201612`),0) as `201612`,
        
		ifnull(sum(`201701`),0) as `201701`,
		ifnull(sum(`201702`),0) as `201702`,
		ifnull(sum(`201703`),0) as `201703`,
		ifnull(sum(`201704`),0) as `201704`,
		ifnull(sum(`201705`),0) as `201705`,
		ifnull(sum(`201706`),0) as `201706`,
		ifnull(sum(`201707`),0) as `201707`,
		ifnull(sum(`201708`),0) as `201708`,
		ifnull(sum(`201709`),0) as `201709`,
		ifnull(sum(`201710`),0) as `201710`,
		ifnull(sum(`201711`),0) as `201711`,
		ifnull(sum(`201712`),0) as `201712`,
        
		ifnull(sum(`201801`),0) as `201801`,
		ifnull(sum(`201802`),0) as `201802`,
		ifnull(sum(`201803`),0) as `201803`,
		ifnull(sum(`201804`),0) as `201804`,
		ifnull(sum(`201805`),0) as `201805`,
		ifnull(sum(`201806`),0) as `201806`,
		ifnull(sum(`201807`),0) as `201807`,
		ifnull(sum(`201808`),0) as `201808`,
		ifnull(sum(`201809`),0) as `201809`,
		ifnull(sum(`201810`),0) as `201810`,
		ifnull(sum(`201811`),0) as `201811`,
		ifnull(sum(`201812`),0) as `201812`
        /*
        ,
        
		ifnull(sum(`201901`),0) as `201901`,
		ifnull(sum(`201902`),0) as `201902`,
		ifnull(sum(`201903`),0) as `201903`,
		ifnull(sum(`201904`),0) as `201904`,
		ifnull(sum(`201905`),0) as `201905`,
		ifnull(sum(`201906`),0) as `201906`,
		ifnull(sum(`201907`),0) as `201907`,
		ifnull(sum(`201908`),0) as `201908`,
		ifnull(sum(`201909`),0) as `201909`,
		ifnull(sum(`201910`),0) as `201910`,
		ifnull(sum(`201911`),0) as `201911`,
		ifnull(sum(`201912`),0) as `201912`
		*/

		from 
		(
			select clientcode, package, servicesubcategory,
			case when periodmth = 1 and periodyear=2016 then activecount end as `201601`,
			case when periodmth = 2 and periodyear=2016 then activecount end as `201602`,
			case when periodmth = 3 and periodyear=2016 then activecount end as `201603`,
			case when periodmth = 4 and periodyear=2016 then activecount end as `201604`,
			case when periodmth = 5 and periodyear=2016 then activecount end as `201605`,
			case when periodmth = 6 and periodyear=2016 then activecount end as `201606`,
			case when periodmth = 7 and periodyear=2016 then activecount end as `201607`,
			case when periodmth = 8 and periodyear=2016 then activecount end as `201608`,
			case when periodmth = 9 and periodyear=2016 then activecount end as `201609`,
			case when periodmth = 10 and periodyear=2016 then activecount end as `201610`,
			case when periodmth = 11 and periodyear=2016 then activecount end as `201611`,
			case when periodmth = 12 and periodyear=2016 then activecount end as `201612`,

			case when periodmth = 1 and periodyear=2017 then activecount end as `201701`,
			case when periodmth = 2 and periodyear=2017 then activecount end as `201702`,
			case when periodmth = 3 and periodyear=2017 then activecount end as `201703`,
			case when periodmth = 4 and periodyear=2017 then activecount end as `201704`,
			case when periodmth = 5 and periodyear=2017 then activecount end as `201705`,
			case when periodmth = 6 and periodyear=2017 then activecount end as `201706`,
			case when periodmth = 7 and periodyear=2017 then activecount end as `201707`,
			case when periodmth = 8 and periodyear=2017 then activecount end as `201708`,
			case when periodmth = 9 and periodyear=2017 then activecount end as `201709`,
			case when periodmth = 10 and periodyear=2017 then activecount end as `201710`,
			case when periodmth = 11 and periodyear=2017 then activecount end as `201711`,
			case when periodmth = 12 and periodyear=2017 then activecount end as `201712`,

			case when periodmth = 1 and periodyear=2018 then activecount end as `201801`,
			case when periodmth = 2 and periodyear=2018 then activecount end as `201802`,
			case when periodmth = 3 and periodyear=2018 then activecount end as `201803`,
			case when periodmth = 4 and periodyear=2018 then activecount end as `201804`,
			case when periodmth = 5 and periodyear=2018 then activecount end as `201805`,
			case when periodmth = 6 and periodyear=2018 then activecount end as `201806`,
			case when periodmth = 7 and periodyear=2018 then activecount end as `201807`,
			case when periodmth = 8 and periodyear=2018 then activecount end as `201808`,
			case when periodmth = 9 and periodyear=2018 then activecount end as `201809`,
			case when periodmth = 10 and periodyear=2018 then activecount end as `201810`,
			case when periodmth = 11 and periodyear=2018 then activecount end as `201811`,
			case when periodmth = 12 and periodyear=2018 then activecount end as `201812`
            /*
            ,
            case when periodmth = 1 and periodyear=2019 then activecount end as `201901`,
			case when periodmth = 2 and periodyear=2019 then activecount end as `201902`,
			case when periodmth = 3 and periodyear=2019 then activecount end as `201903`,
			case when periodmth = 4 and periodyear=2019 then activecount end as `201904`,
			case when periodmth = 5 and periodyear=2019 then activecount end as `201905`,
			case when periodmth = 6 and periodyear=2019 then activecount end as `201906`,
			case when periodmth = 7 and periodyear=2019 then activecount end as `201907`,
			case when periodmth = 8 and periodyear=2019 then activecount end as `201908`,
			case when periodmth = 9 and periodyear=2019 then activecount end as `201909`,
			case when periodmth = 10 and periodyear=2019 then activecount end as `201910`,
			case when periodmth = 11 and periodyear=2019 then activecount end as `201911`,
			case when periodmth = 12 and periodyear=2019 then activecount end as `201912`
			*/
            
            
			from 
			(
				select periodmth, periodyear, clientcode, package, servicesubcategory, count(*) as activecount, sum(ACTIVECOUNT) as activecount2 
				from
				rcbill_my.customercontractactivity
				where
				clientcode in 
				(
					
					select clientcode from rcbill_my.customercontractactivity where period in 
					(
					-- '2018-07-06'
					-- 	select period from tempperiod
						@peakperiod 
                    )

					and package in ('Extravagance','Extravagance Corporate')
					and REPORTED='Y'
					order by  activecount desc, clientcode asc
                    
                    -- select clientcode from tempextract1
				)
				-- and package in ('Extravagance','Extravagance Corporate')
				and servicecategory in ('TV')
                and REPORTED='Y'
				group by periodmth, periodyear, clientcode, package, servicesubcategory
				order by periodmth, periodyear
			) a

			
		) a    
		group by clientcode, package
		-- , 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38
		
		
	) b 
	on a.clientcode = b.client_code
    -- and a.peak_package
)
;

select * from rcbill_my.rep_extravagance_peakcustomer_activity;


-- select * from rcbill_my.rep_extravagance_activity;

drop table if exists tempperiod;
drop table if exists tempextract1;