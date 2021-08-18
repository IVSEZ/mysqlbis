##################################
-- Number of customers with French TV Package
select 'FRENCH package customers' as message;
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
-- (`Starter`>0 or `Value`>0 or `Elite`>0 or `Extreme`>0 or `Extreme Plus`>0 or `Crimson`>0 or `Crimson Corporate`>0 or  `Performance`>0 or `Performance Plus`>0 or `Amber`>0 or `Amber Corporate`>0) 
-- and 
-- (`Basic`>0 or `Executive`>0 or `Extravagance`>0 or `Extravagance Corporate`>0 or `Indian`>0 or `Indian Corporate`>0 or `French`>0)
(`French`>0)

-- and a.`VOD`=0

and a.clientclass not in ('Intelvision Office','Employee', 'Corporate Large')
;