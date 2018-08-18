select * from rcbill_my.rep_livetvstats;
select * from rcbill_my.rep_vodstats;
select * from rcbill_my.rep_tsstats;
select * from rcbill_my.rep_radiostats;



select distinct resource from rcbill_my.rep_livetvstats order by resource;
select duration_sec from rcbill_my.rep_livetvstats where resource='ACTIONFR' and view_day=17 and view_month=8 and view_year=2018;
select rcbill_my.GetLiveTVDurationForResource('ACTIONFR',17,8,2018);

select duration_sec from rcbill_my.rep_livetvstats where resource='1TVRUSSIA' and view_day=17 and view_month=8 and view_year=2018;
/*
show index from rcbill.rcb_livetvtelemetry;
show index from rcbill_my.rep_livetvstats ;

select * from rcbill.rcb_livetvtelemetry where resource='ABMOTEURS' and date(sessionstart)='2018-08-17' limit 100;


set @ccode='I.000002576';

select sessionstart, trim(upper(resource)), duration, device, contractcode from rcbill.clientlivetvstats where clientcode=@ccode
 order by sessionstart desc;

select sessionstart, resource, originaltitle, duration, device, contractcode from rcbill.clientvodstats where clientcode=@ccode order by sessionstart desc;

select sessionstart, resource, duration, device, contractcode from rcbill.clienttsstats where clientcode=@ccode order by sessionstart desc;

select sessionstart, resource, duration, device, contractcode from rcbill.clientradiostats where clientcode=@ccode order by sessionstart desc;

select b.datestart, b.dateend, b.category, b.traffictype, b.device
, (select a.contractcode from rcbill.clientcontractdevices a where a.phoneno=b.device and a.clientcode=b.clientcode) as contractcode, b.traffic_mb
, b.billable_duration_min, b.actual_duration_min, b.price, b.price_vat from rcbill_my.dailyusage b where b.clientcode=@ccode order by b.dateend desc;

select payment_date, sale_point, payment_amount, contract_code, sale_comment, receipt_id
 from rcbill_my.rep_addon where client_code=@ccode order by payment_date desc;

select * from rcbill_my.dailyusage where clientcode=@ccode order by dateend desc;



select distinct device from rcbill_my.dailyusage where clientcode=@ccode ;
select * from rcbill.clientcontractdevices where clientcode=@ccode;
select * from rcbill.clientcontractdevices where clientcode=@ccode and phoneno='rahul';

*/