use rcbill_my;


-- select * from rcbill_my.clientstats;
-- select * from rcbill_my.rep_custconsolidated;
-- clientclass, clienttype, services, ActiveCount, contractcount, period, clientcode, clientname, region, network, 10GB, 20GB, 40GB, Amber, Amber Corporate, Basic, Business Unlimited-1, Business Unlimited-2, Business Unlimited-6, Business Unlimited-8, Business Unlimited-8-daytime, Crimson, Crimson Corporate, Dedicated Custom, Dedicated Plus, DualView, MultiView, VOD, IGO, Mobile Indian, Elite, Executive, Extravagance, Extravagance Corporate, Extreme, Extreme Plus, French, Hotels/Channels, Hotels/Decoder, Indian, Indian Corporate, Intel Data 10, Intel Voice 10, Intel Voice 20, Intelenovela, PBX, Performance, Performance Plus, Prepaid, Prepaid Data, Prestige, Starter, Turquoise High Tide, Turquoise Low Tide, TurquoiseTV, Value, Voice Plus, VPN

##################################
-- current VOD customers snapshot

select a.*, b.activeservices
, b.totalpaymentamount, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.firstpaymentdate
, b.clientarea as island, b.clientlocation as district, b.subdistrict
, b.clientparcel, b.latitude, b.longitude
, case when b.clientparcel is null then 'Not Present'
		else 'Present' end as `ParcelStatus`

from 
(
	select reportdate, clientcode, clientname, clientclass, clienttype, region, network, sum(price) as price
	-- , coalesce(TV_PACAKGE,'') as `TV_PACAKGE`
	-- , coalesce(INT_PACAKGE,'')   as `INT_PACAKGE`
	, max(TV_PACKAGE) as  `TV_PACKAGE`
	, max(INT_PACKAGE) as `INT_PACKAGE`
	from 
	(

		select reportdate, clientcode, clientname, clientclass, clienttype, region, network
        , price
		, case when servicecategory='TV' and PackageType='STANDALONE' then package end as `TV_PACKAGE`
		, case when servicecategory='INTERNET' then package  end as `INT_PACKAGE`

		from 
		(
			select * from rcbill_my.customercontractsnapshot 
				where clientcode in 
				(
					select clientcode from rcbill_my.clientstats a 
					where
					a.`VOD`>0
					and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')
				)
				and CurrentStatus='Active'
		) a 
		-- where a.packagetype='STANDALONE'
		-- group by 1,2,3,4,5,6,7
	) a 
	group by 1,2,3,4,5,6,7
	-- ,8,9
) a 
left join 
rcbill_my.rep_custconsolidated b 
on a.CLIENTCODE=b.clientcode
;


##################################
-- current NON-VOD customers snapshot

select a.*, b.activeservices
, b.totalpaymentamount, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.firstpaymentdate
, b.clientarea as island, b.clientlocation as district, b.subdistrict
, b.clientparcel, b.latitude, b.longitude
, case when b.clientparcel is null then 'Not Present'
		else 'Present' end as `ParcelStatus`

from 
(
	select reportdate, clientcode, clientname, clientclass, clienttype, region, network, sum(price) as price
	-- , coalesce(TV_PACAKGE,'') as `TV_PACAKGE`
	-- , coalesce(INT_PACAKGE,'')   as `INT_PACAKGE`
	, max(TV_PACKAGE) as  `TV_PACKAGE`
	, max(INT_PACKAGE) as `INT_PACKAGE`
	from 
	(

		select reportdate, clientcode, clientname, clientclass, clienttype, region, network
        , price
		, case when servicecategory='TV' and PackageType='STANDALONE' then package end as `TV_PACKAGE`
		, case when servicecategory='INTERNET' then package  end as `INT_PACKAGE`

		from 
		(
			select * from rcbill_my.customercontractsnapshot 
				where clientcode in 
				(
					select clientcode from rcbill_my.clientstats a 
					where
					a.`VOD`=0
					and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')
				)
				and CurrentStatus='Active'
		) a 
		-- where a.packagetype='STANDALONE'
		-- group by 1,2,3,4,5,6,7
	) a 
	group by 1,2,3,4,5,6,7
	-- ,8,9
) a 
left join 
rcbill_my.rep_custconsolidated b 
on a.CLIENTCODE=b.clientcode
;


-- current VOD customers

select 'current VOD customers' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
, b.clientphone, b.clientemail
, c.clientparcel, c.latitude, c.longitude
, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.TotalPaymentAmount2020, b.AvgMonthlyPayment2020
, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019
, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018
, `Amber`, `Amber Corporate`
, `Crimson`, `Crimson Corporate`
, `Intel Data 10`
, `Starter`, `Value`
, `Elite`, `Extreme`, `Extreme Plus`
, `Performance`, `Performance Plus`
, `Basic`, `Executive`, `Extravagance`, `Extravagance Corporate`
, `French`, `Indian`, `Indian Corporate`
, `Intelenovela`
, `DualView`, `MultiView`, `VOD`, `IGO`, `Mobile Indian`
, `Turquoise High Tide`, `Turquoise Low Tide`, `TurquoiseTV`
, `Intel Voice 10`, `Intel Voice 20`
, `Voice Plus`

, `PBX`
, `Prepaid`
, `Prepaid Data`
, `Business Unlimited-1`, `Business Unlimited-2`, `Business Unlimited-6`, `Business Unlimited-8`, `Business Unlimited-8-daytime`
, `Dedicated Custom`, `Dedicated Plus`
, `Hotels/Channels`, `Hotels/Decoder`
, `VPN`

from rcbill_my.clientstats a

inner join 

rcbill_my.rep_custconsolidated b
on a.clientcode=b.clientcode


left join 
(
	select * from rcbill.rcb_clientparcelcoords where date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel
) c

ON a.clientcode=c.clientcode
where 
a.`VOD`>0
and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')
;

-- select * from rcbill_my.rep_custconsolidated;

select 'current VOD customers on HFC network, but in GPON areas' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname
, b.clientphone, b.clientemail
, c.clientparcel, c.latitude, c.longitude
, a.region, a.network
, b.clean_connection_type
, b.clean_hfc_node, b.clean_hfc_nodename, b.hfc_district, b.hfc_subdistrict
, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.TotalPaymentAmount2020, b.AvgMonthlyPayment2020
, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019
, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018
, `Amber`, `Amber Corporate`
, `Crimson`, `Crimson Corporate`
, `Intel Data 10`
, `Starter`, `Value`
, `Elite`, `Extreme`, `Extreme Plus`
, `Performance`, `Performance Plus`
, `Basic`, `Executive`, `Extravagance`, `Extravagance Corporate`
, `French`, `Indian`, `Indian Corporate`
, `Intelenovela`
, `DualView`, `MultiView`, `VOD`, `IGO`, `Mobile Indian`
, `Turquoise High Tide`, `Turquoise Low Tide`, `TurquoiseTV`
, `Intel Voice 10`, `Intel Voice 20`
, `Voice Plus`

, `PBX`
, `Prepaid`
, `Prepaid Data`
, `Business Unlimited-1`, `Business Unlimited-2`, `Business Unlimited-6`, `Business Unlimited-8`, `Business Unlimited-8-daytime`
, `Dedicated Custom`, `Dedicated Plus`
, `Hotels/Channels`, `Hotels/Decoder`
, `VPN`

from rcbill_my.clientstats a

inner join 

rcbill_my.rep_custconsolidated b
on a.clientcode=b.clientcode

left join 
(
	select * from rcbill.rcb_clientparcelcoords where date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel
) c

ON a.clientcode=c.clientcode

where 
`VOD`>0

and 
network='HFC'
and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')
-- and clientclass not in ('Intelvision Office','Employee')
;


##################################

-- NON VOD CUSTOMERS


-- Number of customers on Elite, Extreme, Extreme+, Crimson + Any TV package (excluding indian and french)
select 'customers on Elite, Extreme, Extreme+, Crimson + Any TV package (excluding indian and french)' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
, b.clientphone, b.clientemail
, c.clientparcel, c.latitude, c.longitude
, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.TotalPaymentAmount2020, b.AvgMonthlyPayment2020
, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019
, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018
, `Amber`, `Amber Corporate`
, `Crimson`, `Crimson Corporate`
, `Intel Data 10`
, `Starter`, `Value`
, `Elite`, `Extreme`, `Extreme Plus`
, `Performance`, `Performance Plus`
, `Basic`, `Executive`, `Extravagance`, `Extravagance Corporate`
, `French`, `Indian`, `Indian Corporate`
, `Intelenovela`
, `DualView`, `MultiView`, `VOD`, `IGO`, `Mobile Indian`
, `Turquoise High Tide`, `Turquoise Low Tide`, `TurquoiseTV`
, `Intel Voice 10`, `Intel Voice 20`
, `Voice Plus`

, `PBX`
, `Prepaid`
, `Prepaid Data`
, `Business Unlimited-1`, `Business Unlimited-2`, `Business Unlimited-6`, `Business Unlimited-8`, `Business Unlimited-8-daytime`
, `Dedicated Custom`, `Dedicated Plus`
, `Hotels/Channels`, `Hotels/Decoder`
, `VPN`

from rcbill_my.clientstats a

inner join 

rcbill_my.rep_custconsolidated b
on a.clientcode=b.clientcode

left join 
(
	select * from rcbill.rcb_clientparcelcoords where date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel
) c

ON a.clientcode=c.clientcode

where 
(`Elite`>0 or `Extreme`>0 or `Extreme Plus`>0 or `Crimson`>0 or `Crimson Corporate`>0) 
and 
(`Basic`>0 or `Executive`>0 or `Extravagance`>0 or `Extravagance Corporate`>0)

and a.`VOD`=0

and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')

;


-- Number of customers on Elite, Extreme, Extreme+, Crimson + (Basic or Executive)
select 'customers on Elite, Extreme, Extreme+, Crimson + (Basic or Executive)' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
, b.clientphone, b.clientemail
, c.clientparcel, c.latitude, c.longitude
, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.TotalPaymentAmount2020, b.AvgMonthlyPayment2020
, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019
, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018
, `Amber`, `Amber Corporate`
, `Crimson`, `Crimson Corporate`
, `Intel Data 10`
, `Starter`, `Value`
, `Elite`, `Extreme`, `Extreme Plus`
, `Performance`, `Performance Plus`
, `Basic`, `Executive`, `Extravagance`, `Extravagance Corporate`
, `French`, `Indian`, `Indian Corporate`
, `Intelenovela`
, `DualView`, `MultiView`, `VOD`, `IGO`, `Mobile Indian`
, `Turquoise High Tide`, `Turquoise Low Tide`, `TurquoiseTV`
, `Intel Voice 10`, `Intel Voice 20`
, `Voice Plus`

, `PBX`
, `Prepaid`
, `Prepaid Data`
, `Business Unlimited-1`, `Business Unlimited-2`, `Business Unlimited-6`, `Business Unlimited-8`, `Business Unlimited-8-daytime`
, `Dedicated Custom`, `Dedicated Plus`
, `Hotels/Channels`, `Hotels/Decoder`
, `VPN`

from rcbill_my.clientstats a
inner join 
rcbill_my.rep_custconsolidated b
on a.clientcode=b.clientcode

left join 
(
	select * from rcbill.rcb_clientparcelcoords where date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel
) c

ON a.clientcode=c.clientcode

where 
(`Elite`>0 or `Extreme`>0 or `Extreme Plus`>0 or `Crimson`>0 or `Crimson Corporate`>0) 
and 
(`Basic`>0 or `Executive`>0) -- or `Extravagance`>0 or `Extravagance Corporate`>0)

and a.`VOD`=0

and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')
;

-- Number of customers on Elite, Extreme, Extreme+, Crimson + (Extravagance)
select 'customers on Elite, Extreme, Extreme+, Crimson + (Extravagance)' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
, b.clientphone, b.clientemail
, c.clientparcel, c.latitude, c.longitude
, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.TotalPaymentAmount2020, b.AvgMonthlyPayment2020
, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019
, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018
, `Amber`, `Amber Corporate`
, `Crimson`, `Crimson Corporate`
, `Intel Data 10`
, `Starter`, `Value`
, `Elite`, `Extreme`, `Extreme Plus`
, `Performance`, `Performance Plus`
, `Basic`, `Executive`, `Extravagance`, `Extravagance Corporate`
, `French`, `Indian`, `Indian Corporate`
, `Intelenovela`
, `DualView`, `MultiView`, `VOD`, `IGO`, `Mobile Indian`
, `Turquoise High Tide`, `Turquoise Low Tide`, `TurquoiseTV`
, `Intel Voice 10`, `Intel Voice 20`
, `Voice Plus`

, `PBX`
, `Prepaid`
, `Prepaid Data`
, `Business Unlimited-1`, `Business Unlimited-2`, `Business Unlimited-6`, `Business Unlimited-8`, `Business Unlimited-8-daytime`
, `Dedicated Custom`, `Dedicated Plus`
, `Hotels/Channels`, `Hotels/Decoder`
, `VPN`

from rcbill_my.clientstats a
inner join 
rcbill_my.rep_custconsolidated b
on a.clientcode=b.clientcode

left join 
(
	select * from rcbill.rcb_clientparcelcoords where date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel
) c

ON a.clientcode=c.clientcode

where 
(`Elite`>0 or `Extreme`>0 or `Extreme Plus`>0 or `Crimson`>0 or `Crimson Corporate`>0) 
and 
-- (`Basic`>0 or `Executive`>0 or
 (`Extravagance`>0 or `Extravagance Corporate`>0)

and a.`VOD`=0

and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')
;


##################################
-- Number of customers on Performance, Performance+ & Amber + Basic or Executive
select 'customers on Performance, Performance+ & Amber + Basic or Executive' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
, b.clientphone, b.clientemail
, c.clientparcel, c.latitude, c.longitude
, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.TotalPaymentAmount2020, b.AvgMonthlyPayment2020
, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019
, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018
, `Amber`, `Amber Corporate`
, `Crimson`, `Crimson Corporate`
, `Intel Data 10`
, `Starter`, `Value`
, `Elite`, `Extreme`, `Extreme Plus`
, `Performance`, `Performance Plus`
, `Basic`, `Executive`, `Extravagance`, `Extravagance Corporate`
, `French`, `Indian`, `Indian Corporate`
, `Intelenovela`
, `DualView`, `MultiView`, `VOD`, `IGO`, `Mobile Indian`
, `Turquoise High Tide`, `Turquoise Low Tide`, `TurquoiseTV`
, `Intel Voice 10`, `Intel Voice 20`
, `Voice Plus`, `PBX`
, `Prepaid`
, `Prepaid Data`
, `Business Unlimited-1`, `Business Unlimited-2`, `Business Unlimited-6`, `Business Unlimited-8`, `Business Unlimited-8-daytime`
, `Dedicated Custom`, `Dedicated Plus`
, `Hotels/Channels`, `Hotels/Decoder`
, `VPN`

from rcbill_my.clientstats a
inner join 
rcbill_my.rep_custconsolidated b
on a.clientcode=b.clientcode

left join 
(
	select * from rcbill.rcb_clientparcelcoords where date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel
) c

ON a.clientcode=c.clientcode

where 
(`Performance`>0 or `Performance Plus`>0 or `Amber`>0 or `Amber Corporate`>0) 
and 
(`Basic`>0 or `Executive`>0)

and a.`VOD`=0

and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')

;

##################################
-- Number of customers on Performance, Performance+ & Amber + Extravagance
select 'customers on Performance, Performance+ & Amber + Extravagance' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
, b.clientphone, b.clientemail
, c.clientparcel, c.latitude, c.longitude
, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.TotalPaymentAmount2020, b.AvgMonthlyPayment2020
, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019
, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018
, `Amber`, `Amber Corporate`
, `Crimson`, `Crimson Corporate`
, `Intel Data 10`
, `Starter`, `Value`
, `Elite`, `Extreme`, `Extreme Plus`
, `Performance`, `Performance Plus`
, `Basic`, `Executive`, `Extravagance`, `Extravagance Corporate`
, `French`, `Indian`, `Indian Corporate`
, `Intelenovela`
, `DualView`, `MultiView`, `VOD`, `IGO`, `Mobile Indian`
, `Turquoise High Tide`, `Turquoise Low Tide`, `TurquoiseTV`
, `Intel Voice 10`, `Intel Voice 20`
, `Voice Plus`, `PBX`
, `Prepaid`
, `Prepaid Data`
, `Business Unlimited-1`, `Business Unlimited-2`, `Business Unlimited-6`, `Business Unlimited-8`, `Business Unlimited-8-daytime`
, `Dedicated Custom`, `Dedicated Plus`
, `Hotels/Channels`, `Hotels/Decoder`
, `VPN`

from rcbill_my.clientstats a
inner join 
rcbill_my.rep_custconsolidated b
on a.clientcode=b.clientcode

left join 
(
	select * from rcbill.rcb_clientparcelcoords where date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel
) c

ON a.clientcode=c.clientcode

where 
(`Performance`>0 or `Performance Plus`>0 or `Amber`>0 or `Amber Corporate`>0) 
and 
(`Extravagance`>0 or `Extravagance Corporate`>0)

and a.`VOD`=0

and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')
;

##################################
-- Number of customers on Starter & Value + Any TV Package
select 'customers on Starter & Value + Any TV Package' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
, b.clientphone, b.clientemail
, c.clientparcel, c.latitude, c.longitude
, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.TotalPaymentAmount2020, b.AvgMonthlyPayment2020
, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019
, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018
, `Amber`, `Amber Corporate`
, `Crimson`, `Crimson Corporate`
, `Intel Data 10`
, `Starter`, `Value`
, `Elite`, `Extreme`, `Extreme Plus`
, `Performance`, `Performance Plus`
, `Basic`, `Executive`, `Extravagance`, `Extravagance Corporate`
, `French`, `Indian`, `Indian Corporate`
, `Intelenovela`
, `DualView`, `MultiView`, `VOD`, `IGO`, `Mobile Indian`
, `Turquoise High Tide`, `Turquoise Low Tide`, `TurquoiseTV`
, `Intel Voice 10`, `Intel Voice 20`
, `Voice Plus`, `PBX`
, `Prepaid`
, `Prepaid Data`
, `Business Unlimited-1`, `Business Unlimited-2`, `Business Unlimited-6`, `Business Unlimited-8`, `Business Unlimited-8-daytime`
, `Dedicated Custom`, `Dedicated Plus`
, `Hotels/Channels`, `Hotels/Decoder`
, `VPN`

from rcbill_my.clientstats a
inner join 
rcbill_my.rep_custconsolidated b
on a.clientcode=b.clientcode

left join 
(
	select * from rcbill.rcb_clientparcelcoords where date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel
) c

ON a.clientcode=c.clientcode

where 
(`Starter`>0 or `Value`>0) 
and 
(`Basic`>0 or `Executive`>0 or `Extravagance`>0 or `Extravagance Corporate`>0 or `Indian`>0 or `Indian Corporate`>0 or `French`>0)

and a.`VOD`=0

and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')
;

##################################
-- select * from rcbill_my.clientstats 

-- Number of customers on Any Internet + Any TV Package
select 'customers on Any Internet  + Any TV Package' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
, b.clientphone, b.clientemail
, c.clientparcel, c.latitude, c.longitude
, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.TotalPaymentAmount2020, b.AvgMonthlyPayment2020
, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019
, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018
, `Amber`, `Amber Corporate`
, `Crimson`, `Crimson Corporate`
, `Intel Data 10`
, `Starter`, `Value`
, `Elite`, `Extreme`, `Extreme Plus`
, `Performance`, `Performance Plus`
, `Basic`, `Executive`, `Extravagance`, `Extravagance Corporate`
, `French`, `Indian`, `Indian Corporate`
, `Intelenovela`
, `DualView`, `MultiView`, `VOD`, `IGO`, `Mobile Indian`
, `Turquoise High Tide`, `Turquoise Low Tide`, `TurquoiseTV`
, `Intel Voice 10`, `Intel Voice 20`
, `Voice Plus`, `PBX`
, `Prepaid`
, `Prepaid Data`
, `Business Unlimited-1`, `Business Unlimited-2`, `Business Unlimited-6`, `Business Unlimited-8`, `Business Unlimited-8-daytime`
, `Dedicated Custom`, `Dedicated Plus`
, `Hotels/Channels`, `Hotels/Decoder`
, `VPN`

from rcbill_my.clientstats a
inner join 
rcbill_my.rep_custconsolidated b
on a.clientcode=b.clientcode

left join 
(
	select * from rcbill.rcb_clientparcelcoords where date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel
) c

ON a.clientcode=c.clientcode

where 
(`Starter`>0 or `Value`>0 or `Elite`>0 or `Extreme`>0 or `Extreme Plus`>0 or `Crimson`>0 or `Crimson Corporate`>0 or  `Performance`>0 or `Performance Plus`>0 or `Amber`>0 or `Amber Corporate`>0) 
and 
(`Basic`>0 or `Executive`>0 or `Extravagance`>0 or `Extravagance Corporate`>0 or `Indian`>0 or `Indian Corporate`>0 or `French`>0)

and a.`VOD`=0

and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')
;

##################################
### 14 Jan 2022
-- Number of only GPON customers on Any Internet + Any TV Package
select 'GPON customers on Any Internet  + Any TV Package' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
, b.clientphone, b.clientemail
, c.clientparcel, c.latitude, c.longitude
, b.TotalPaymentAmount2022, b.AvgMonthlyPayment2022
, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.TotalPaymentAmount2020, b.AvgMonthlyPayment2020
, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019
, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018
, `Amber`, `Amber Corporate`
, `Crimson`, `Crimson Corporate`
, `Intel Data 10`
, `Starter`, `Value`
, `Elite`, `Extreme`, `Extreme Plus`
, `Performance`, `Performance Plus`
, `Basic`, `Executive`, `Extravagance`, `Extravagance Corporate`
, `French`, `Indian`, `Indian Corporate`
, `Intelenovela`
, `DualView`, `MultiView`, `VOD`, `IGO`, `Mobile Indian`
-- , `Turquoise High Tide`, `Turquoise Low Tide`, `TurquoiseTV`
, `Intel Voice 10`, `Intel Voice 20`
, `Voice Plus`, `PBX`
-- , `Prepaid`
-- , `Prepaid Data`
-- , `Business Unlimited-1`, `Business Unlimited-2`, `Business Unlimited-6`, `Business Unlimited-8`, `Business Unlimited-8-daytime`
-- , `Dedicated Custom`, `Dedicated Plus`
-- , `Hotels/Channels`, `Hotels/Decoder`
-- , `VPN`

from rcbill_my.clientstats a
inner join 
rcbill_my.rep_custconsolidated b
on a.clientcode=b.clientcode

left join 
(
	select * from rcbill.rcb_clientparcelcoords where date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel
) c

ON a.clientcode=c.clientcode

where 
(`Starter`>0 or `Value`>0 or `Elite`>0 or `Extreme`>0 or `Extreme Plus`>0 or `Crimson`>0 or `Crimson Corporate`>0 or  `Performance`>0 or `Performance Plus`>0 or `Amber`>0 or `Amber Corporate`>0) 
and 
(`Basic`>0 or `Executive`>0 or `Extravagance`>0 or `Extravagance Corporate`>0 or `Indian`>0 or `Indian Corporate`>0 or `French`>0)

and a.`VOD`=0

and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')

and a.network='GPON'
;

##################################
### 28 July 2022
-- Number of all customers on Any Internet + Any TV Package (with or without VOD)
select 'ALL customers on Any Internet  + Any TV Package' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
, b.clientphone, b.clientemail
, c.clientparcel, c.latitude, c.longitude
, b.TotalPaymentAmount2022, b.AvgMonthlyPayment2022
, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.TotalPaymentAmount2020, b.AvgMonthlyPayment2020
, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019
, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018
, `Amber`, `Amber Corporate`
, `Crimson`, `Crimson Corporate`
, `Intel Data 10`
, `Starter`, `Value`
, `Elite`, `Extreme`, `Extreme Plus`
, `Performance`, `Performance Plus`
, `Basic`, `Executive`, `Extravagance`, `Extravagance Corporate`
, `French`, `Indian`, `Indian Corporate`
, `Intelenovela`
, `DualView`, `MultiView`, `VOD`, `IGO`, `Mobile Indian`
-- , `Turquoise High Tide`, `Turquoise Low Tide`, `TurquoiseTV`
, `Intel Voice 10`, `Intel Voice 20`
, `Voice Plus`, `PBX`
-- , `Prepaid`
-- , `Prepaid Data`
-- , `Business Unlimited-1`, `Business Unlimited-2`, `Business Unlimited-6`, `Business Unlimited-8`, `Business Unlimited-8-daytime`
-- , `Dedicated Custom`, `Dedicated Plus`
-- , `Hotels/Channels`, `Hotels/Decoder`
-- , `VPN`

from rcbill_my.clientstats a
inner join 
rcbill_my.rep_custconsolidated b
on a.clientcode=b.clientcode

left join 
(
	select * from rcbill.rcb_clientparcelcoords where date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) order by clientparcel
) c

ON a.clientcode=c.clientcode

where 
(`Starter`>0 or `Value`>0 or `Elite`>0 or `Extreme`>0 or `Extreme Plus`>0 or `Crimson`>0 or `Crimson Corporate`>0 or  `Performance`>0 or `Performance Plus`>0 or `Amber`>0 or `Amber Corporate`>0) 
and 
(`Basic`>0 or `Executive`>0 or `Extravagance`>0 or `Extravagance Corporate`>0 or `Indian`>0 or `Indian Corporate`>0 or `French`>0)

-- and a.`VOD`=0

and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')

-- and a.network='GPON'
;
