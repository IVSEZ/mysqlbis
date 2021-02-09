use rcbill_my;


-- select * from rcbill_my.clientstats;
-- select * from rcbill_my.rep_custconsolidated;
-- clientclass, clienttype, services, ActiveCount, contractcount, period, clientcode, clientname, region, network, 10GB, 20GB, 40GB, Amber, Amber Corporate, Basic, Business Unlimited-1, Business Unlimited-2, Business Unlimited-6, Business Unlimited-8, Business Unlimited-8-daytime, Crimson, Crimson Corporate, Dedicated Custom, Dedicated Plus, DualView, MultiView, VOD, IGO, Mobile Indian, Elite, Executive, Extravagance, Extravagance Corporate, Extreme, Extreme Plus, French, Hotels/Channels, Hotels/Decoder, Indian, Indian Corporate, Intel Data 10, Intel Voice 10, Intel Voice 20, Intelenovela, PBX, Performance, Performance Plus, Prepaid, Prepaid Data, Prestige, Starter, Turquoise High Tide, Turquoise Low Tide, TurquoiseTV, Value, Voice Plus, VPN

##################################
-- current VOD customers

select 'current VOD customers' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
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

where 
`VOD`>0
-- and clientclass not in ('Intelvision Office','Employee')
;



##################################
-- Number of customers on Elite, Extreme, Extreme+, Crimson + Any TV package (excluding indian and french)
select 'customers on Elite, Extreme, Extreme+, Crimson + Any TV package (excluding indian and french)' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
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

where 
(`Elite`>0 or `Extreme`>0 or `Extreme Plus`>0 or `Crimson`>0 or `Crimson Corporate`>0) 
and 
(`Basic`>0 or `Executive`>0 or `Extravagance`>0 or `Extravagance Corporate`>0)
;


-- Number of customers on Elite, Extreme, Extreme+, Crimson + (Basic or Executive)
select 'customers on Elite, Extreme, Extreme+, Crimson + (Basic or Executive)' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
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

where 
(`Elite`>0 or `Extreme`>0 or `Extreme Plus`>0 or `Crimson`>0 or `Crimson Corporate`>0) 
and 
(`Basic`>0 or `Executive`>0) -- or `Extravagance`>0 or `Extravagance Corporate`>0)
;

-- Number of customers on Elite, Extreme, Extreme+, Crimson + (Extravagance)
select 'customers on Elite, Extreme, Extreme+, Crimson + (Extravagance)' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
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

where 
(`Elite`>0 or `Extreme`>0 or `Extreme Plus`>0 or `Crimson`>0 or `Crimson Corporate`>0) 
and 
-- (`Basic`>0 or `Executive`>0 or
 (`Extravagance`>0 or `Extravagance Corporate`>0)
;


##################################
-- Number of customers on Performance, Performance+ & Amber + Basic or Executive
select 'customers on Performance, Performance+ & Amber + Basic or Executive' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
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

where 
(`Performance`>0 or `Performance Plus`>0 or `Amber`>0 or `Amber Corporate`>0) 
and 
(`Basic`>0 or `Executive`>0)
;

##################################
-- Number of customers on Performance, Performance+ & Amber + Extravagance
select 'customers on Performance, Performance+ & Amber + Extravagance' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
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

where 
(`Performance`>0 or `Performance Plus`>0 or `Amber`>0 or `Amber Corporate`>0) 
and 
(`Extravagance`>0 or `Extravagance Corporate`>0)
;

##################################
-- Number of customers on Starter & Value + Any TV Package
select 'customers on Starter & Value + Any TV Package' as message;
select 
a.clientclass, a.clienttype, a.services, a.ActiveCount, a.contractcount, a.period, a.clientcode, a.clientname, a.region, a.network
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

where 
(`Starter`>0 or `Value`>0) 
and 
(`Basic`>0 or `Executive`>0 or `Extravagance`>0 or `Extravagance Corporate`>0 or `Indian`>0 or `Indian Corporate`>0 or `French`>0)
;

