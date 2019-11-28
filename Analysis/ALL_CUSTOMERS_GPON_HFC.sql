-- select * from rcbill_my.rep_custconsolidated;

select 
clientcode, IsAccountActive, AccountActivityStage, clientname, clientclass, activenetwork, activeservices, clientaddress
, clientlocation, clean_connection_type, clean_mxk_name, clean_hfc_nodename, hfc_district
, totalpaymentamount, TotalPaymentAmount2019, AvgMonthlyPayment2019
, TotalPaymentAmount2018,  AvgMonthlyPayment2018
, clientarea as clientisland

from rcbill_my.rep_custconsolidated a 
/*
where
	 
	a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%'  or a.clientaddress like '%glaci%'
	or
	a.clientaddress like '%SIMPSON%'
	or 
	a.clientaddress like '%beau belle%' or a.clientaddress like '%beau bel%'  or a.clientaddress like '%beaubel%'
	or
	a.clientaddress like '%beau vallon%' or a.clientaddress like '%beauvallon%' or a.clientaddress like '%beauvalon%' 
	or a.clientaddress like '%beauvalon%' or a.clientaddress like '%beau  vallon%' or a.clientaddress like '%beau-vallon%'
	or a.clientaddress like '%beau  valon%'
	or
	a.clientaddress like '%belombre%' or a.clientaddress like '%bel ombre%' or a.clientaddress like '%belom%'  or a.clientaddress like '%belomb%'  or a.clientaddress like '%belomber%'
	or
	a.clientaddress like '%maca%' or a.clientaddress like '%mach%'
	or
	a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%' or a.clientaddress like '%la gogue%'  
    or a.clientaddress like '%lagog%' or a.clientaddress like '%anse etole%' or a.clientaddress like '%anse etoile%'
    or a.clientaddress like '%la retraite%' or a.clientaddress like '%maldive%' or a.clientaddress like '%maldives%'
    or a.clientaddress like '%english river%' or a.clientaddress like '%union vale%' or a.clientaddress like '%unionvale%'

	or clientlocation in ('BEAU VALLON','BELOMBRE','BEL OMBRE','GLACIS','ANSE ETOILE','ENGLISH RIVER')

	or hfc_district in ('BEAU VALLON','BEL OMBRE','GLACIS','ANSE ETOILE')
	or clean_mxk_name in ('MXK-BEAUVALLON','MXK-ANSEETOILE')
*/
;

-- select * from rcbill_my.rep_servicetickets_2019;

/*
select
clientcode, IsAccountActive, AccountActivityStage
, clientname, clientclass, activenetwork, activeservices, clientaddress
, clientlocation, clean_connection_type, clean_mxk_name, clean_hfc_nodename, hfc_district
, totalpaymentamount, TotalPaymentAmount2019, AvgMonthlyPayment2019
, TotalPaymentAmount2018,  AvgMonthlyPayment2018
, clientarea as clientisland
, tickettype as tkt_type, openreason as tkt_reason, month(opendate) as tkt_month, count(distinct ticketid) as tkt_count

from rcbill_my.rep_servicetickets_2019
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
-- ,20,21,22
;
*/

select clientcode, clientname, tickettype as tkt_type, openreason as tkt_reason, month(opendate) as tkt_month, count(distinct ticketid) as tkt_count
from rcbill_my.rep_servicetickets_2019
group by 1,2,3,4, 5
;

select clientcode, clientname
, ifnull(sum(`201901`),0) as `tkt_201901` 
, ifnull(sum(`201902`),0) as `tkt_201902` 
, ifnull(sum(`201903`),0) as `tkt_201903` 
, ifnull(sum(`201904`),0) as `tkt_201904` 
, ifnull(sum(`201905`),0) as `tkt_201905` 
, ifnull(sum(`201906`),0) as `tkt_201906` 
, ifnull(sum(`201907`),0) as `tkt_201907` 
, ifnull(sum(`201908`),0) as `tkt_201908` 
, ifnull(sum(`201909`),0) as `tkt_201909` 
, ifnull(sum(`201910`),0) as `tkt_201910` 
, ifnull(sum(`201911`),0) as `tkt_201911` 
, ifnull(sum(`201912`),0) as `tkt_201912` 
, sum(total_tkt_count) as total_tkt_count
, group_concat( distinct tkt_type order by tkt_type asc separator '|') as tkt_type
, group_concat( distinct tkt_reason order by tkt_reason asc separator '|') as tkt_reason
from
(
	select clientcode, clientname 
	, case when tkt_month=1 then ifnull(sum(tkt_count),0)  end as `201901`
	, case when tkt_month=2 then ifnull(sum(tkt_count),0)  end as `201902`
	, case when tkt_month=3 then ifnull(sum(tkt_count),0)  end as `201903`
	, case when tkt_month=4 then ifnull(sum(tkt_count),0)  end as `201904`
	, case when tkt_month=5 then ifnull(sum(tkt_count),0)  end as `201905`
	, case when tkt_month=6 then ifnull(sum(tkt_count),0)  end as `201906`
	, case when tkt_month=7 then ifnull(sum(tkt_count),0)  end as `201907`
	, case when tkt_month=8 then ifnull(sum(tkt_count),0)  end as `201908`
	, case when tkt_month=9 then ifnull(sum(tkt_count),0)  end as `201909`
	, case when tkt_month=10 then ifnull(sum(tkt_count),0)  end as `201910`
	, case when tkt_month=11 then ifnull(sum(tkt_count),0)  end as `201911`
	, case when tkt_month=12 then ifnull(sum(tkt_count),0)  end as `201912`
    , sum(tkt_count) as total_tkt_count
    , tkt_type
    , tkt_reason
	from 
	( 
		select clientcode, clientname, tickettype as tkt_type, openreason as tkt_reason, month(opendate) as tkt_month, count(distinct ticketid) as tkt_count
		from rcbill_my.rep_servicetickets_2019
		group by 1,2,3,4,5
	) a 
	group by 1,2, tkt_month
) a 
group by 1,2
;


### JOIN BOTH
SELECT A.*,B.*
FROM 
(
	select 
	clientcode, clientname, clientphone
    , (select CONCAT_WS( "|", a1_parcel,a2_parcel,a3_parcel) from rcbill.rcb_clientparcels x where x.clientcode=a.clientcode) as client_parcels
    , clientaddress
    , IsAccountActive, AccountActivityStage, clientclass, activenetwork, activeservices
	, clientlocation, clean_connection_type, clean_mxk_name, clean_hfc_nodename, hfc_district
	, totalpaymentamount, TotalPaymentAmount2019, AvgMonthlyPayment2019
	, TotalPaymentAmount2018,  AvgMonthlyPayment2018
	, clientarea as clientisland

	from rcbill_my.rep_custconsolidated a 
) A
LEFT JOIN 
(
	select clientcode, clientname
	, ifnull(sum(`201901`),0) as `tkt_201901` 
	, ifnull(sum(`201902`),0) as `tkt_201902` 
	, ifnull(sum(`201903`),0) as `tkt_201903` 
	, ifnull(sum(`201904`),0) as `tkt_201904` 
	, ifnull(sum(`201905`),0) as `tkt_201905` 
	, ifnull(sum(`201906`),0) as `tkt_201906` 
	, ifnull(sum(`201907`),0) as `tkt_201907` 
	, ifnull(sum(`201908`),0) as `tkt_201908` 
	, ifnull(sum(`201909`),0) as `tkt_201909` 
	, ifnull(sum(`201910`),0) as `tkt_201910` 
	, ifnull(sum(`201911`),0) as `tkt_201911` 
	, ifnull(sum(`201912`),0) as `tkt_201912` 
	, sum(total_tkt_count) as total_tkt_count
	, group_concat( distinct tkt_type order by tkt_type asc separator '|') as tkt_type
	, group_concat( distinct tkt_reason order by tkt_reason asc separator '|') as tkt_reason
	from
	(
		select clientcode, clientname 
		, case when tkt_month=1 then ifnull(sum(tkt_count),0)  end as `201901`
		, case when tkt_month=2 then ifnull(sum(tkt_count),0)  end as `201902`
		, case when tkt_month=3 then ifnull(sum(tkt_count),0)  end as `201903`
		, case when tkt_month=4 then ifnull(sum(tkt_count),0)  end as `201904`
		, case when tkt_month=5 then ifnull(sum(tkt_count),0)  end as `201905`
		, case when tkt_month=6 then ifnull(sum(tkt_count),0)  end as `201906`
		, case when tkt_month=7 then ifnull(sum(tkt_count),0)  end as `201907`
		, case when tkt_month=8 then ifnull(sum(tkt_count),0)  end as `201908`
		, case when tkt_month=9 then ifnull(sum(tkt_count),0)  end as `201909`
		, case when tkt_month=10 then ifnull(sum(tkt_count),0)  end as `201910`
		, case when tkt_month=11 then ifnull(sum(tkt_count),0)  end as `201911`
		, case when tkt_month=12 then ifnull(sum(tkt_count),0)  end as `201912`
		, sum(tkt_count) as total_tkt_count
		, tkt_type
		, tkt_reason
		from 
		( 
			select clientcode, clientname, tickettype as tkt_type, openreason as tkt_reason, month(opendate) as tkt_month, count(distinct ticketid) as tkt_count
			from rcbill_my.rep_servicetickets_2019
			group by 1,2,3,4,5
		) a 
		group by 1,2, tkt_month
	) a 
	group by 1,2

) B
ON 
A.clientcode = B.clientcode
;
