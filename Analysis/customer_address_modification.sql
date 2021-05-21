






select distinct a.id as ClientId, a.firm as ClientName, a.kod as ClientCode, a.MOLADDRESS as ClientAddress

, b.district, b.island, b.subdistrict

-- , min(ifnull(b.SettlementName,'SILHOUETTE ISLAND')) as ClientLocation
-- , min(ifnull(b.areaname,'UNKNOWN')) as ClientArea
-- , min(ifnull(b.districtname,'UNKNOWN')) as ClientSubDistrict

, (ifnull(b.district,'SILHOUETTE ISLAND')) as ClientLocation
, (ifnull(b.island,'TBU')) as ClientArea
, (ifnull(b.subdistrict,'TBU')) as ClientSubDistrict

from 
-- rcbill.rcb_tclients a
(
	select *
		, case when moladdress regexp ('MAHE') then 'MAHE'
				when moladdress regexp ('PRASLIN') then 'PRASLIN'
                else 'OTHER' end as clientisland
	from rcbill.rcb_tclients
) a

left join
(
/*
select distinct settlementname from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD')
group by settlementname
*/

/*
select distinct settlementname, areaname from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD') 
-- and settlementname not in ('VICTORIA')
group by settlementname, areaname
order by SETTLEMENTNAME, areaname
*/

select distinct settlementname as district, areaname as island, districtname as subdistrict from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD') 
-- and settlementname not in ('VICTORIA')
group by settlementname, areaname, districtname
order by SETTLEMENTNAME, areaname, districtname


) b
-- on
-- (a.moladdress like concat('%', b.SETTLEMENTNAME , '%') and a.moladdress like concat('%', b.areaname , '%') and a.moladdress like concat('%', b.districtname , '%'))
-- group by clientid, clientname, clientcode, clientaddress
on

(
	a.clientisland = b.island

	and

	(
		(
			a.MOLADDRESS regexp b.district 
			and a.MOLADDRESS regexp b.subdistrict
		)
        
		/*
		or
		(
			a.MOLADDRESS regexp b.district 
			or a.MOLADDRESS regexp b.subdistrict

		)
        */
        
	 )
	 
 )


-- where a.kod in ('I.000016164','I.000016166','I.000016162')

group by clientid, clientname, clientcode, clientaddress
;






    /*
	(
	a.MOLADDRESS regexp b.island and 
	a.MOLADDRESS regexp b.subdistrict 
	) 

	or 
	(
	a.MOLADDRESS regexp b.district and 
	a.MOLADDRESS regexp b.subdistrict 
	) 

	or 
	(
	a.MOLADDRESS regexp b.island and 
	a.MOLADDRESS regexp b.district 
	) 



	or 
	(
	a.MOLADDRESS regexp b.island and 
	a.MOLADDRESS regexp b.district 
	and a.MOLADDRESS regexp b.subdistrict
	)
	*/

/*
or 
(
a.MOLADDRESS regexp b.island  
) 

or 
(
a.MOLADDRESS regexp b.district 
) 

or 
(
a.MOLADDRESS regexp b.subdistrict 
) 


or 
(
a.MOLADDRESS regexp b.district and 
a.MOLADDRESS regexp b.subdistrict 
) 


*/



/*
or 
(
a.MOLADDRESS regexp b.island and 
a.MOLADDRESS regexp b.district 
) 

or 
(
a.MOLADDRESS regexp b.district and 
a.MOLADDRESS regexp b.subdistrict 
) 
or 
(
a.MOLADDRESS regexp b.district
) 
or 
(
a.MOLADDRESS regexp b.subdistrict 
) 

*/


###### original code - 21 May 2021


select distinct a.id as ClientId, a.firm as ClientName, a.kod as ClientCode, a.MOLADDRESS as ClientAddress
-- , min(ifnull(b.SettlementName,'SILHOUETTE ISLAND')) as ClientLocation
-- , min(ifnull(b.areaname,'UNKNOWN')) as ClientArea
-- , min(ifnull(b.districtname,'UNKNOWN')) as ClientSubDistrict

, (ifnull(b.district,'SILHOUETTE ISLAND')) as ClientLocation
, (ifnull(b.island,'TBU')) as ClientArea
, (ifnull(b.subdistrict,'TBU')) as ClientSubDistrict

from 
rcbill.rcb_tclients a
left join
(
/*
select distinct settlementname from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD')
group by settlementname
*/

/*
select distinct settlementname, areaname from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD') 
-- and settlementname not in ('VICTORIA')
group by settlementname, areaname
order by SETTLEMENTNAME, areaname
*/

select distinct settlementname as district, areaname as island, districtname as subdistrict from rcbill.rcb_address
where AreaName not in ('M','SEYCHELLES','SANS SOUCI ROAD') 
-- and settlementname not in ('VICTORIA')
group by settlementname, areaname, districtname
order by SETTLEMENTNAME, areaname, districtname


) b
-- on
-- (a.moladdress like concat('%', b.SETTLEMENTNAME , '%') and a.moladdress like concat('%', b.areaname , '%') and a.moladdress like concat('%', b.districtname , '%'))
-- group by clientid, clientname, clientcode, clientaddress
on
/*
(a.moladdress like concat('%', b.district , '%') -- or a.moladdress like concat('%', b.areaname , '%') 
and a.moladdress like concat('%', b.subdistrict , '%'))
*/
(a.moladdress like concat('%', b.district , '%') -- or a.moladdress like concat('%', b.areaname , '%') 
and a.moladdress like concat('%', b.subdistrict , '%'))
or 
(a.moladdress like concat('%', b.district , '%')) 


group by clientid, clientname, clientcode, clientaddress
;

