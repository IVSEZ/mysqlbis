#SET DATE
SET @REPORTDATE=str_to_date('2017-11-13','%Y-%m-%d');
SET @rundate='2017-11-13';

use rcbill_my;

/*
select period, periodday, periodmth, periodyear,clientcode,clientname,clientclass, servicecategory, servicecategory2, package from rcbill_my.customercontractactivity 
where 
reported='Y' and
clientclass in ('Corporate Bundle','Corporate Bulk')
and period='2017-08-01';
-- and period>='2017-08-01' and period<='2017-08-31';
*/


select * from rcbill_my.clientstats where 
(
clientclass in ('Corporate Bulk','Corporate Bundle')
or
 `Extravagance Corporate` >0
or
 `Crimson Corporate` >0 
or clientname like '%staff%'
)    
-- and clientclass not in ('Employee')
;

select a.*,b.services,b.Intelenovela from rcbill_my.customercontractactivity a 
inner join 
rcbill_my.clientstats b
on 
a.clientcode=b.clientcode
where a.clientcode in 
(
	select clientcode from rcbill_my.clientstats where 
    (
	clientclass in ('Corporate Bulk','Corporate Bundle')
	or
	 `Extravagance Corporate` >0
	or
	 `Crimson Corporate` >0 
	or clientname like '%staff%'
    )
--     and clientclass not in ('Employee')
)
and a.period=@rundate;
