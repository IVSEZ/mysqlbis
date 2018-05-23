select * from rcb_tclients where id in (723711,725060)

SELECT * FROM RCB_TCLIENTS WHERE FIRM LIKE 'BRIDGET%'

select distinct firm, count(id) as firm_count from rcb_tclients group by firm order by firm_count desc;

SELECT COUNT(*) FROM rcb_vpnrates;
SELECT COUNT(*) FROM rcb_services;
SELECT COUNT(*) FROM rcb_ratingplans;
select * from rcb_creditpolicy;
select * from rcb_services;

select * from rcb_ratingplans;
SELECT * FROM rcb_vpnrates order by serviceid, RatingPlanID;

select 

SER.ID AS SER_SERVICEID,
SER.NAME AS SER_SERVICENAME,
SER.INSTATISTICS AS SER_INSTATISTICS,

VPNR.ID AS VPNR_SERVICERATEID,
VPNR.RATINGPLANID AS VPNR_RATINGPLANID,
VPNR.SERVICEID AS VPNR_SERVICEID,
VPNR.NAME AS VPNR_SERVICENAME,
VPNR.PERIOD AS VPNR_PERIOD,
VPNR.PRICE AS VPNR_PRICE,
VPNR.POST AS VPNR_POST,

RP.ID AS RP_RATINGPLANID,
RP.NAME AS RP_RATINGPLANNAME

from

rcb_services as SER
left join
rcb_vpnrates as VPNR
on
SER.ID=VPNR.SERVICEID

left join
rcb_ratingplans as RP
on
VPNR.RATINGPLANID=RP.ID

order by 
SER.ID