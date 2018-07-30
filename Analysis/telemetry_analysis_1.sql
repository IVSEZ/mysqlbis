select * from rcbill_my.rep_livetvstats;
select * from rcbill_my.rep_vodstats;
select * from rcbill_my.rep_tsstats;
select * from rcbill_my.rep_radiostats;

/*

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