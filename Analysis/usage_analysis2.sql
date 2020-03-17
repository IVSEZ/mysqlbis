


## HOW MANY PEOPLE WITH CAPPED INTERNET
select CLIENTCODE, CONTRACTCODE, SERVICETYPE as PACKAGE from rcbill_my.dailyactivenumber where period>='2020-01-01' and SERVICECATEGORY='Internet' and service like '%Capped%'
group by CLIENTCODE, CONTRACTCODE, SERVICETYPE
;

## HOW MANY PEOPLE FINISHED THEIR QUOTA
select CLIENTCODE, CONTRACTCODE, SERVICETYPE as PACKAGE from rcbill_my.dailyactivenumber where period>='2020-01-01' and SERVICECATEGORY='Internet' and service like '%Capped%' and LASTACTION='Deactivated for Traffic Limit'
group by CLIENTCODE, CONTRACTCODE, SERVICETYPE
;

## HOW MANY PEOPLE BOUGHT ADDONS
select CLIENT_CODE, CONTRACT_CODE, rcbill_my.GetPackageFromSnapshot(CLIENT_CODE, CONTRACT_CODE) as package, count(*) as ADDON_BOUGHT, sum(PAYMENT_AMOUNT) as TOTAL_PAID
, (sum(PAYMENT_AMOUNT)/57.5) as GB_BOUGHT
from 
rcbill_my.rep_addon where PAYMENT_DATE>='2020-01-01' and PAYMENT_AMOUNT>0
group by CLIENT_CODE, CONTRACT_CODE, 3
order by 4 desc
;

## HOTSPOT USAGE
select CLIENTCODE, DEVICE, TRAFFICTYPE, sum(TRAFFIC_MB) from rcbill_my.dailyusage where DATESTART>='2020-01-01' 
and CATEGORY in ('HOTSPOT','PREPAID')
group by CLIENTCODE, DEVICE, TRAFFICTYPE
;

select * from rcbill_my.rep_clientcontractdevices limit 100;

select a.*, b.*
from 
(
	select CLIENTCODE, DEVICE, TRAFFICTYPE, sum(TRAFFIC_MB) from rcbill_my.dailyusage where DATESTART>='2020-01-01' 
	and CATEGORY in ('HOTSPOT','PREPAID')
	group by CLIENTCODE, DEVICE, TRAFFICTYPE

) a 
inner join
(
	select uid, username, CLIENT_CODE, CONTRACT_CODE, service_type, rcbill_my.GetPackageFromSnapshot(CLIENT_CODE, CONTRACT_CODE) as package
    from rcbill_my.rep_clientcontractdevices
    group by uid, username, CLIENT_CODE, CONTRACT_CODE, service_type

) b 
on a.device=b.uid and a.CLIENTCODE=b.client_code
;

select rcbill_my.GetPackageFromSnapshot('I12076', 'I.000292304');

select * from rcbill_my.customercontractsnapshot where clientcode='I12076';

select package from rcbill_my.customercontractsnapshot where 
					clientcode='I12076'
					and
					contractcode='I.000292304'
                    order by lastcontractdate desc
					limit 1;
/*

select * from rcbill_my.dailyactivenumber order by PERIOD desc limit 100;

show index from rcbill_my.dailyactivenumber ;

select * from rcbill_my.dailyactivenumber where period='2020-03-10' and SERVICECATEGORY='Internet';

select * from rcbill_my.dailyactivenumber where period='2020-03-11' and SERVICECATEGORY='Internet' and LASTACTION='Deactivated for Traffic Limit';

select * from rcbill_my.dailyactivenumber where PERIODMTH=3 and PERIODYEAR=2020 and SERVICECATEGORY='Internet' and LASTACTION='Deactivated for Traffic Limit';

select period, lastaction, count(*) from 
rcbill_my.dailyactivenumber where  period>='2020-03-01' and SERVICECATEGORY='Internet'
group by period, lastaction
;



select * from rcbill_my.dailyactivenumber where period>='2020-03-01' and SERVICECATEGORY='Internet' and service like '%Capped%';
select * from rcbill_my.dailyactivenumber where period>='2020-01-01' and SERVICECATEGORY='Internet' and LASTACTION='Deactivated for Traffic Limit';
select * from rcbill_my.rep_addon where PAYMENT_DATE>='2020-01-01';
select * from rcbill_my.dailyusage where clientcode='I.000008582' limit 100 where DATESTART>='2020-01-01';
select * from rcbill_my.customercontractsnapshot limit 100 order by ;
select * from rcbill_my.customercontractsnapshot where lastcontractdate>='2020-01-01' and servicecategory2='Internet - Capped';

select a.*, b.*
from 
(
select * from rcbill_my.dailyactivenumber where period>='2020-03-01' and SERVICECATEGORY='Internet' and service like '%Capped%'
) a 
left join
(
select * from rcbill_my.dailyusage where DATESTART>='2020-03-01' and traffictype='Default' and CLIENTCODE in 
	(
	select distinct clientcode from rcbill_my.dailyactivenumber where period>='2020-03-01' and SERVICECATEGORY='Internet' and service like '%Capped%'
	)
) b
on a.clientcode=b.clientcode
and a.period=b.datestart
;


*/



