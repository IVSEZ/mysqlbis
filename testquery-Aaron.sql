select 
cl.id as cl_id,
cl.firm as cl_clientname,
cl.kod as cl_clientcode,
cl.BEGDATE as cl_startdate,

con.id as con_contractid,
con.kod as con_contractcode,
con.startdate as con_startdate,
con.enddate as con_enddate,
con.clid as con_clientid,

cs.cid as cs_contractid,
cs.serviceid as cs_serviceid,
cs.servicerateid as cs_servicerateid,
cs.startdate as cs_startdate,
cs.enddate as cs_enddate,

vpnr.serviceid as vpnr_serviceid,
vpnr.name as vpnr_name,
vpnr.period as vpnr_period,
vpnr.price as vpnr_price,
vpnr.ratingplanid as vpnr_ratingplanid,

svc.Name as svc_name,

casa.paytype*-1 as casa_paytype,
casa.clid as casa_clientid,
casa.paydate as casa_paydate,
casa.money as casa_payamount,
casa.cid as casa_contractid,
casa.begdate as casa_startdate,
casa.enddate as casa_enddate 


from
rcb_tclients cl
left join 
	rcb_contracts con
    on cl.id=con.CLID

left join 
	rcb_contractservices cs
    on con.id=cs.CID

left join
	rcb_vpnrates vpnr
    on cs.ServiceRateID=vpnr.ID

left join
	rcb_services svc
    on cs.ServiceID = svc.ID

left join
	rcb_casa casa
    on cl.ID=casa.CLID
--    on con.ID = casa.cid

where 
cl.id=698681
-- and 
-- svc.Name like '%subscription%'

order by 
-- cl.id, con.StartDate
cl_id, cs_startdate


-- ca.ID as paymentid,
-- ca.PAYDATE as paymentdate,
-- ca.MONEY as PaymentAmt,
-- ca.begdate as SubStart, 
-- ca.EndDate as SubEnd

-- con.kod as contract_no
from 
rcb_tclients cl
inner join 
	rcb_casa ca
	ON cl.ID = ca.CLID

-- left join
-- 	rcb_contracts con ON ca.id = con.ID 


where cl.firm='AARON BONNELAME'

order by 
cl.firm, ca.begdate, ca.PAYDATE
;

select * from rcb_tclients where firm='AARON BONNELAME';
select * from rcb_casa where id=1737581;

-- I241138.1

select * from rcb_contracts where kod='I241138.1';
select count(*) from rcb_contractservices;


select * from rcb_tclients where id=698681;
select * from rcb_contracts where clid=698681;
select * from rcb_casa where clid=698681 order by cid, begdate	;
select distinct paytype from rcb_casa where clid=698681 order by cid, begdate	;
-- select * from rcb_casa where clid=1268313;


select * from rcb_contractservices where cid in (1268312,1268313);
select * from rcb_vpnrates where id in (select distinct ServiceRateID from rcb_contractservices where cid in (select distinct cid from rcb_casa where clid in (698681)));
select * from rcb_services where id in (select distinct serviceid from rcb_contractservices where cid in (select distinct cid from rcb_casa where clid in (698681)));

select * from rcb_vpnrates where name like '%intele%';


select * from rcb_tclients where id=698681;
select * from rcb_contracts where clid in (select distinct id from rcb_tclients where id=698681);
select * from rcb_casa where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=698681)) order by enterdate;
select * from rcb_contractservices where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=698681)) order by startdate;

-- select * from rcb_contractservices where serviceid in (select distinct paytype*-1 from rcb_casa where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=698681)) ) order by startdate;


-- select * from rcb_services where id in (select distinct serviceid from rcb_contractservices where cid in (select distinct cid from rcb_casa where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=698681))));
select * from rcb_services where id in (select distinct serviceid from rcb_contractservices where cid in (select distinct ID from rcb_contracts where clid IN (select distinct id from rcb_tclients where id=698681)));
select * from rcb_vpnrates where id in (select distinct ServiceRateID from rcb_contractservices where cid in (select distinct ID from rcb_contracts where clid in (select distinct id from rcb_tclients where id=698681)));

select distinct cltype , count(*) as clcount from rcb_tclients group by CLTYPE;


