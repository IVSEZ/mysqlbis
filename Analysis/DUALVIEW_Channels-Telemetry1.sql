select * from rcbill.clientcontractdevices 
where 
-- ClientCode='I19567' 
-- and 
ServiceType='NEXTTV'
and mac is not null and length(mac)>0
;

select * from rcbill.rcb_livetvtelemetry where DEVICE='0c.56.5c.7d.11.a1';
select * from rcbill.rcb_tstelemetry where DEVICE='0c.56.5c.7d.11.97';
 
 select mac from rcbill.clientcontractdevices where ServiceType='NEXTTV' and mac is not null and length(mac)>0;
 
select * from rcbill.rcb_livetvtelemetry where DEVICE in 
( select mac from rcbill.clientcontractdevices where ServiceType='NEXTTV' and mac is not null and length(mac)>0)
;


select resource, sum(duration) as timewatched, count(distinct DEVICE) as devices from 
(
	select * from rcbill.rcb_livetvtelemetry where DEVICE in 
	( select mac from rcbill.clientcontractdevices where ServiceType='NEXTTV' and mac is not null and length(mac)>0)

) a 
group by resource
order by 2 desc
;


 select resource, sum(duration) as timewatched, count(distinct DEVICE) as devices from 
(
	select * from rcbill.rcb_livetvtelemetry where DEVICE in 
	( 
    -- select mac from rcbill.clientcontractdevices where ServiceType='NEXTTV' and mac is not null and length(mac)>0
		select a.mac from 
		(
			select *
			, (select a.clientclass from rcbill_my.rep_allcust a where a.ClientCode=b.ClientCode) as ClientClass
			from rcbill.clientcontractdevices b where ServiceType='NEXTTV' and mac is not null and length(mac)>0
        ) a where a.clientclass not in ('INTELVISION OFFICE')
    )

) a 
group by resource
order by 2 desc
;