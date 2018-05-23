-- other charges monthly
-- select * from rcbill.rcb_contractservices where ServiceID in (52);

-- enable hotspot access
-- select * from rcbill.rcb_contractservices where ServiceID in (144);

-- PREPAID TRAFFIC
-- select * from rcbill.rcb_contractservices where ServiceID in (143);

-- select * from rcbill.rcb_tclients limit 1000;
-- select * from rcbill.rcb_contracts where id in (2111216,2115874,1210616);
-- select * from rcbill.rcb_contracts where id in (2058145,1326164);

-- select * from rcbill.rcb_devices where contractid in (2111216,2115874);

select * from rcbill.rcb_devices where contractid in (1279443);
-- select * from rcbill.rcb_devices where serviceid in (144,143);

-- select * from rcbill.rcb_services limit 100;

-- select * from rcbill.rcb_devices where username like '%rahul%';
-- select * from rcbill.rcb_devices where username like '%test%';

-- select * from rcbill.rcb_contracts where id in (2050959,2080730,2081766,2089984);


-- select * from rcbill.rcb_contracts where id in (select contractid from rcbill.rcb_devices where serviceid in (143,144)) and active=1;


select a.id as clientid,a.firm as clientname,a.kod as cliencode
,b.id as contractid, b.kod as contractcode, b.startdate, b.enddate, b.active, b.creditpolicyid, b.contracttype,b.ratingplanid
,cp.name as creditpolicy
,c.id as csid, c.serviceid,c.servicerateid, c.startdate, c.enddate, c.number, c.active 
,vp.Name
,s.id as s_serviceid,s.name as s_servicename 
,d.phoneno, d.username,d.password,d.mac,d.serno,d.DeviceName,d.DevTypeID
,dt.name as devtype

 from rcbill.rcb_tclients a
 inner join 
 rcbill.rcb_contracts b
 on a.id=b.clid
 
 left join 
 rcbill.rcb_creditpolicy cp 
 on b.CreditPolicyID=cp.ID
 

 left join
 rcbill.rcb_contractservices c 
 on b.id=c.cid

 left join 
 rcbill.rcb_vpnrates vp 
 -- on (b.RatingPlanID=vp.RatingPlanID and c.serviceid=vp.ServiceID) 
 on c.ServiceRateID=vp.ID
 left join
 rcbill.rcb_services s 
 on c.ServiceID=s.ID
 
 left join 
 rcbill.rcb_devices d 
 on (c.id=d.CSID)
 
 left join 
 rcbill.rcb_devicetypes dt
 on (d.DevTypeID=dt.id)
 where a.firm like '%test%'
 ;
 -- and b.Active=1;

-- select * from rcbill.rcb_contracts;