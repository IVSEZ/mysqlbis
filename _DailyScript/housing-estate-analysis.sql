/*
HOUSING ESTATES TO TRACK
LAST UPDATE: 23/04/2018 - email from Lynsey

Perseverance Phase 5
Remis 
Anse Francois 
Dan Fatak (Ex-Gondwana)
La Gogue Upper Residential Area
Ex Teachers - P Glaud
Onezime 
Les Mamelles 
Brilliant
D'Offay Landbank - Upper au cap
Upper Casuarina
Anse Louis Upper
Cap Bomzan - Upper Au Sel
Dominic Savio
Ex Cachuguy
Perseverance Phase 6


*/

use rcbill_my;

select a.*, 
case 
when a.clientaddress like '%remis%' or a.clientaddress like '%remiz%' then 'REMIS'
when a.clientaddress like '%eden island%' then 'EDEN ISLAND'
when a.clientaddress like '%perseverance%' then 'PERSEVERANCE'
when a.clientaddress like '%lagogue flat%' or a.clientaddress like '%la gogue flats%' then 'LA GOGUE FLATS'
when a.clientaddress like '%gondwana%' or a.clientaddress like '%x gondwana%' or a.clientaddress like '%x-gondwana%' then 'GONDWANA'
when a.clientaddress like '%fatak%' or a.clientaddress like '%dan fatak%' then 'DAN FATAK'
when a.clientaddress like '%La Gogue Upper Residential Area%' or a.clientaddress like '%La Gogue Upper%' then 'LA GOGUE UPPER'
when a.clientaddress like '%teachers%' or a.clientaddress like '%teacher%' then 'EX TEACHERS'
when a.clientaddress like '%onezime%' or a.clientaddress like '%one zime%' then 'ONEZIME'
when a.clientaddress like '%les mamelles%' or a.clientaddress like '%les mameles%' or a.clientaddress like '%les mam%' then 'LES MAMELLES'
when a.clientaddress like '%brilliant%' or a.clientaddress like '%briliant%' then 'BRILLIANT'
when a.clientaddress like '%offay estate%' or a.clientaddress like '%offay land%' or a.clientaddress like '%dofay%' then 'D\'OFFAY LAND BANK'
when a.clientaddress like '%casua%' or a.clientaddress like '%Casuarina%' then 'UPPER CASUARINA'
when a.clientaddress like '%anse louis upper%' then 'ANSE LOUIS UPPER'
when a.clientaddress like '%Cap Bomzan%' or a.clientaddress like '%Bomzan%' then 'CAP BOMZAN'
when a.clientaddress like '%dominic savio%' or a.clientaddress like '%savio%' then 'DOMINIC SAVIO'
when a.clientaddress like '%cachu%' or a.clientaddress like '%excasu%' then 'EX CACHUGUY'
when a.clientaddress like '%anse francois%' or a.clientaddress like '%anse francoise%' then 'ANSE FRANCOIS'
when a.clientaddress like '%union vale%' or a.clientaddress like '%unionvale%' then 'UNION VALE'
when a.clientaddress like '%corail dor%' or a.clientaddress like '%corail d\'or%' or a.clientaddress like '%corail%' then 'CORAIL D\'OR'
when a.clientaddress like '%st ange%' or a.clientaddress like '%st. ange%' or a.clientaddress like '%sainte ange%' or a.clientaddress like '%saint ange%' or a.clientaddress like '%ste ange%' or a.clientaddress like '%ste. ange%'  then 'SAINT ANGE'
when a.clientaddress like '%x-desaubin%' or a.clientaddress like '%x desaubin%' then 'DESAUBIN'

end as 'HOUSING_ESTATE'

from 

(
	select a.ClientCode, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation 
	from 
	rcbill.rcb_clientaddress a

	where 
	a.clientaddress like '%remis%' or a.clientaddress like '%remiz%'
	or
	a.clientaddress like '%eden island%' 
	or
	a.clientaddress like '%perseverance%' 
	or
	a.clientaddress like '%lagogue flat%' or a.clientaddress like '%la gogue flats%'
	or
	a.clientaddress like '%gondwana%' or a.clientaddress like '%x gondwana%' or a.clientaddress like '%x-gondwana%'
	or 
	a.clientaddress like '%fatak%' or a.clientaddress like '%dan fatak%'
	or 
	a.clientaddress like '%La Gogue Upper Residential Area%' or a.clientaddress like '%La Gogue Upper%'
	or 
	a.clientaddress like '%teachers%' or a.clientaddress like '%teacher%'
	or 
	a.clientaddress like '%onezime%' or a.clientaddress like '%one zime%'
	or
	a.clientaddress like '%les mamelles%' or a.clientaddress like '%les mameles%' or a.clientaddress like '%les mam%'
	or 
	a.clientaddress like '%brilliant%' or a.clientaddress like '%briliant%'
	or
	a.clientaddress like '%offay estate%' or a.clientaddress like '%offay land%' or a.clientaddress like '%dofay%'
	or
	a.clientaddress like '%casua%' or a.clientaddress like '%Casuarina%'
	or
	a.clientaddress like '%anse louis upper%'
	or 
	a.clientaddress like '%Cap Bomzan%' or a.clientaddress like '%Bomzan%'
	or 
	a.clientaddress like '%dominic savio%' or a.clientaddress like '%savio%'
	or
	a.clientaddress like '%cachu%' or a.clientaddress like '%excasu%'


	or 
	a.clientaddress like '%anse francois%' or a.clientaddress like '%anse francoise%'
	or 
	a.clientaddress like '%union vale%' or a.clientaddress like '%unionvale%'
	or 
	a.clientaddress like '%corail dor%' or a.clientaddress like '%corail d\'or%' or a.clientaddress like '%corail%'
	-- or 
	-- a.clientaddress like '%anse francois%' or a.clientaddress like '%anse francoise%'
	or 
	a.clientaddress like '%st ange%' or a.clientaddress like '%st. ange%' or a.clientaddress like '%sainte ange%' or a.clientaddress like '%saint ange%' or	a.clientaddress like '%ste ange%' or a.clientaddress like '%ste. ange%' 

	or 
	a.clientaddress like '%x-desaubin%' or a.clientaddress like '%x desaubin%'

	order by a.clientcode
) a

;

-- SET @rundate='2018-06-08';

drop table if exists rcbill_my.rep_housingestates;

create table rcbill_my.rep_housingestates as
(

	select date(@rundate) as REPORT_DATE
 
 	,
    case 
	when a.clientaddress like '%remis%' or a.clientaddress like '%remiz%' then 'REMIS'
	when a.clientaddress like '%eden island%' then 'EDEN ISLAND'
	when a.clientaddress like '%perseverance%' then 'PERSEVERANCE'
	when a.clientaddress like '%lagogue flat%' or a.clientaddress like '%la gogue flats%' then 'LA GOGUE FLATS'
	when a.clientaddress like '%gondwana%' or a.clientaddress like '%x gondwana%' or a.clientaddress like '%x-gondwana%' then 'GONDWANA'
	when a.clientaddress like '%fatak%' or a.clientaddress like '%dan fatak%' then 'DAN FATAK'
	when a.clientaddress like '%La Gogue Upper Residential Area%' or a.clientaddress like '%La Gogue Upper%' then 'LA GOGUE UPPER'
	when a.clientaddress like '%teachers%' or a.clientaddress like '%teacher%' then 'EX TEACHERS'
	when a.clientaddress like '%onezime%' or a.clientaddress like '%one zime%' then 'ONEZIME'
	when a.clientaddress like '%brilliant%' or a.clientaddress like '%briliant%' or a.clientaddress like '%brilliant' or a.clientaddress like '%briliant' or a.clientaddress like 'brilliant%' or a.clientaddress like 'briliant%'  or a.clientaddress like '%brillant%' then 'BRILLIANT'
	when a.clientaddress like '%les mamelles%' or a.clientaddress like '%les mameles%' or a.clientaddress like '%les mam%' then 'LES MAMELLES'
	when a.clientaddress like '%offay estate%' or a.clientaddress like '%offay land%' or a.clientaddress like '%dofay%' then 'D\'OFFAY LAND BANK'
	when a.clientaddress like '%casua%' or a.clientaddress like '%Casuarina%' then 'UPPER CASUARINA'
	when a.clientaddress like '%anse louis upper%' then 'ANSE LOUIS UPPER'
	when a.clientaddress like '%Cap Bomzan%' or a.clientaddress like '%Bomzan%' then 'CAP BOMZAN'
	when a.clientaddress like '%dominic savio%' or a.clientaddress like '%savio%' then 'DOMINIC SAVIO'
	when a.clientaddress like '%cachu%' or a.clientaddress like '%excasu%' then 'EX CACHUGUY'
	when a.clientaddress like '%anse francois%' or a.clientaddress like '%anse francoise%' then 'ANSE FRANCOIS'
	when a.clientaddress like '%union vale%' or a.clientaddress like '%unionvale%' then 'UNION VALE'
	when a.clientaddress like '%corail dor%' or a.clientaddress like '%corail d\'or%' or a.clientaddress like '%corail%' then 'CORAIL D\'OR'
	when a.clientaddress like '%st ange%' or a.clientaddress like '%st. ange%' or a.clientaddress like '%sainte ange%' or a.clientaddress like '%saint ange%' or a.clientaddress like '%ste ange%' or a.clientaddress like '%ste. ange%'  then 'SAINT ANGE'
	when a.clientaddress like '%x-desaubin%' or a.clientaddress like '%x desaubin%' then 'DESAUBIN'

	end as 'HOUSING_ESTATE'
    
    
    , a.ClientCode as CLIENT_CODE
    , upper(a.ClientName) as CLIENT_NAME
    ,upper(trim(a.ClientAddress)) as CLIENT_ADDRESS
    ,a.ClientArea as CLIENT_AREA
    , a.ClientLocation as CLIENT_SUBAREA
    , ifnull(b.firstactivedate,'') as FIRST_ACTIVE_DATE, ifnull(b.lastactivedate,'') as LAST_ACTIVE_DATE



	from 
	(
		select clientcode, min(period) as firstactivedate, max(period) as lastactivedate
		from 
		rcbill_my.customercontractactivity 
		where clientcode in 
		(
			select a.ClientCode 
			from 
			rcbill.rcb_clientaddress a

			where 
			a.clientaddress like '%remis%' or a.clientaddress like '%remiz%'
			or
			a.clientaddress like '%eden island%' 
			or
			a.clientaddress like '%perseverance%' 
			or
			a.clientaddress like '%lagogue flat%' or a.clientaddress like '%la gogue flats%'
			or
			a.clientaddress like '%gondwana%' or a.clientaddress like '%x gondwana%' or a.clientaddress like '%x-gondwana%'
			or 
			a.clientaddress like '%fatak%' or a.clientaddress like '%dan fatak%'
			or 
			a.clientaddress like '%La Gogue Upper Residential Area%' or a.clientaddress like '%La Gogue Upper%'
			or 
			a.clientaddress like '%teachers%' or a.clientaddress like '%teacher%'
			or 
			a.clientaddress like '%onezime%' or a.clientaddress like '%one zime%'
			or
			a.clientaddress like '%les mamelles%' or a.clientaddress like '%les mameles%' or a.clientaddress like '%les mam%'
			or 
			a.clientaddress like '%brilliant%' or a.clientaddress like '%briliant%' or a.clientaddress like '%brilliant' or a.clientaddress like '%briliant' or a.clientaddress like 'brilliant%' or a.clientaddress like 'briliant%'  or a.clientaddress like '%brillant%'
			or
			a.clientaddress like '%offay estate%' or a.clientaddress like '%offay land%' or a.clientaddress like '%dofay%'
			or
			a.clientaddress like '%casua%' or a.clientaddress like '%Casuarina%'
			or
			a.clientaddress like '%anse louis upper%'
			or 
			a.clientaddress like '%Cap Bomzan%' or a.clientaddress like '%Bomzan%'
			or 
			a.clientaddress like '%dominic savio%' or a.clientaddress like '%savio%'
			or
			a.clientaddress like '%cachu%' or a.clientaddress like '%excasu%'


			or 
			a.clientaddress like '%anse francois%' or a.clientaddress like '%anse francoise%'
			or 
			a.clientaddress like '%union vale%' or a.clientaddress like '%unionvale%'
			or 
			a.clientaddress like '%corail dor%' or a.clientaddress like '%corail d\'or%' or a.clientaddress like '%corail%'
			-- or 
			-- a.clientaddress like '%anse francois%' or a.clientaddress like '%anse francoise%'
			or 
			a.clientaddress like '%st ange%' or a.clientaddress like '%st. ange%' or a.clientaddress like '%sainte ange%' or a.clientaddress like '%saint ange%' or	a.clientaddress like '%ste ange%' or a.clientaddress like '%ste. ange%' 

			or 
			a.clientaddress like '%x-desaubin%' or a.clientaddress like '%x desaubin%'

		)
		group by clientcode
	) b
	right join
	(
		select a.ClientCode, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation 
		from 
		rcbill.rcb_clientaddress a
		where 
		a.clientaddress like '%remis%' or a.clientaddress like '%remiz%'
		or
		a.clientaddress like '%eden island%' 
		or
		a.clientaddress like '%perseverance%' 
		or
		a.clientaddress like '%lagogue flat%' or a.clientaddress like '%la gogue flats%'
		or
		a.clientaddress like '%gondwana%' or a.clientaddress like '%x gondwana%' or a.clientaddress like '%x-gondwana%'
		or 
		a.clientaddress like '%fatak%' or a.clientaddress like '%dan fatak%'
		or 
		a.clientaddress like '%La Gogue Upper Residential Area%' or a.clientaddress like '%La Gogue Upper%'
		or 
		a.clientaddress like '%teachers%' or a.clientaddress like '%teacher%'
		or 
		a.clientaddress like '%onezime%' or a.clientaddress like '%one zime%'
		or
		a.clientaddress like '%les mamelles%' or a.clientaddress like '%les mameles%' or a.clientaddress like '%les mam%'
		or 
		a.clientaddress like '%brilliant%' or a.clientaddress like '%briliant%' or a.clientaddress like '%brilliant' or a.clientaddress like '%briliant' or a.clientaddress like 'brilliant%' or a.clientaddress like 'briliant%' or a.clientaddress like '%brillant%'
		or
		a.clientaddress like '%offay estate%' or a.clientaddress like '%offay land%' or a.clientaddress like '%dofay%'
		or
		a.clientaddress like '%casua%' or a.clientaddress like '%Casuarina%'
		or
		a.clientaddress like '%anse louis upper%'
		or 
		a.clientaddress like '%Cap Bomzan%' or a.clientaddress like '%Bomzan%'
		or 
		a.clientaddress like '%dominic savio%' or a.clientaddress like '%savio%'
		or
		a.clientaddress like '%cachu%' or a.clientaddress like '%excasu%'


		or 
		a.clientaddress like '%anse francois%' or a.clientaddress like '%anse francoise%'
		or 
		a.clientaddress like '%union vale%' or a.clientaddress like '%unionvale%'
		or 
		a.clientaddress like '%corail dor%' or a.clientaddress like '%corail d\'or%' or a.clientaddress like '%corail%'
		-- or 
		-- a.clientaddress like '%anse francois%' or a.clientaddress like '%anse francoise%'
		or 
		a.clientaddress like '%st ange%' or a.clientaddress like '%st. ange%' or a.clientaddress like '%sainte ange%' or a.clientaddress like '%saint ange%' or	a.clientaddress like '%ste ange%' or a.clientaddress like '%ste. ange%' 

		or 
		a.clientaddress like '%x-desaubin%' or a.clientaddress like '%x desaubin%'
	) a
	on 
	b.clientcode=a.clientcode

order by 9 desc
)
;

SELECT * from rcbill_my.rep_housingestates;

/*

select a.ClientCode, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation 
from 
rcbill.rcb_clientaddress a

where 
a.clientaddress like '%x-desaubin%' or a.clientaddress like '%x desaubin%'
-- a.clientaddress like '%offay estate%' or 
-- a.clientaddress like '%eden%' or
a.clientaddress like '%casu%'
;

-- BEL OMBRE
select distinct date(now()) as reportdate, a.ClientCode, b.network, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation, b.lastactivedate
from 
(
select clientcode, network, max(period) as lastactivedate
from 
rcbill_my.customercontractactivity 
where clientcode in 
(
	select a.ClientCode 
	from 
	rcbill.rcb_clientaddress a

	where 
a.clientaddress like '%belombre%' or a.clientaddress like '%bel ombre%'
)
and network is not null
group by clientcode, network
) b
right join
(
	select a.ClientCode, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation 
	from 
	rcbill.rcb_clientaddress a
	where 
	a.clientaddress like '%belombre%' or a.clientaddress like '%bel ombre%'
) a
on 
b.clientcode=a.clientcode
;


-- Beau Vallon
select distinct date(now()) as reportdate, a.ClientCode, b.network, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation, b.lastactivedate
from 
(
select clientcode, network, max(period) as lastactivedate
from 
rcbill_my.customercontractactivity 
where clientcode in 
(
	select a.ClientCode 
	from 
	rcbill.rcb_clientaddress a

	where 
a.clientaddress like '%beau vallon%' or a.clientaddress like '%beauvallon%' or a.clientaddress like '%beauvalon%' or a.clientaddress like '%beauvalon%' or a.clientaddress like '%beau  vallon%' or a.clientaddress like '%beau-vallon%'
)
and network is not null
group by clientcode, network
) b
right join
(
	select a.ClientCode, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation 
	from 
	rcbill.rcb_clientaddress a
	where 
	a.clientaddress like '%beau vallon%' or a.clientaddress like '%beauvallon%' or a.clientaddress like '%beauvalon%' or a.clientaddress like '%beauvalon%' or a.clientaddress like '%beau  vallon%' or a.clientaddress like '%beau-vallon%'
) a
on 
b.clientcode=a.clientcode
;


-- Glacis
select distinct date(now()) as reportdate, a.ClientCode, b.network, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation, b.lastactivedate
from 
(
select clientcode, network, max(period) as lastactivedate
from 
rcbill_my.customercontractactivity 
where clientcode in 
(
	select a.ClientCode 
	from 
	rcbill.rcb_clientaddress a

	where 
	a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%'
)
and network is not null
group by clientcode, network
) b
right join
(
	select a.ClientCode, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation 
	from 
	rcbill.rcb_clientaddress a
	where 
	a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%'
) a
on 
b.clientcode=a.clientcode
;
*/


/*
select a.ClientCode, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation, max(b.period) as lastactivedate 
from 
rcbill.rcb_clientaddress a
left join 
rcbill_my.customercontractactivity b 
on a.clientcode=b.clientcode
where 
a.clientaddress like '%remis%' or a.clientaddress like '%remiz%'
or
a.clientaddress like '%eden island%'
or
a.clientaddress like '%perseverance%' 
or
a.clientaddress like '%lagogue flat%' or a.clientaddress like '%la gogue flats%'
or
a.clientaddress like '%gondwana%' 
or 
a.clientaddress like '%anse francois%' or a.clientaddress like '%anse francoise%'

group by a.ClientCode, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation
;
*/
