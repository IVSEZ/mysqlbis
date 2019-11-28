/*
select * from rcbill_my.rep_custconsolidated 
where clientcode REGEXP 'I.000019511|019424|I.000009148|I.000012956|I532|I.000010419|I7051|9828|11356|15882|I.000016119|I.000020373|I5801|I10769|I22269|14484|18952|I.000018136|I.000018388|I.000014358|I17287|I6707|I7773|I4509|I14697|19640|I.000014393|I8580|I20336|I.000014845|I.000018622|I.000017053|I3607|I.000013480|000014811|000012771|12219|5828|5828|18389|4778|2655|20316|3110'
order by clientname
;
*/

select * from rcbill_my.rep_custconsolidated 
where clientcode in 
(
'I.000020316',
'I.000014358','I17287',
'I3607',
'I.000020373',
'I.000003110',
'I7773',
'I22269',
'I.000004778',
'I10769',
'I4509',
'I.000019424',
'I.000014484',
'I.000018389',
'I532',
'I.000014811',
'I.000018388',
'I.000018136',
'I.000014845',
'I.000009148',
'I.000005828',
'I.000005828',
'I7051',
'I.000017053',
'I.000012956',
'I5801',
'I.000016119',
'I.000014393',
'I.000009828',
'I.000013480',
'I.000010419',
'I20336',
'I.000019640',
'I23110',
'I6706',
'I.000015882',
'I8580',
'I14697',
'I.000018952',
'I.000011356',
'I.000012771',
'I.000019511',
'I.000012219'
)
order by clientname
;

##GET USAGE HISTORY
select clientcode, clientname, category
, min(datestart) as `from_date`
, max(dateend) as `to_date`
, sum(traffic_mb) as data_used
, count(*) as days_used 
, max(traffic_mb) as mostdataused
, min(traffic_mb) as leastdataused
, sum(traffic_mb)/count(*) as avgdata_day
from rcbill_my.dailyusage  
where datestart>='2019-10-15' and dateend<=now()
and TRAFFICTYPE='Default'
and
clientcode in 
(
'I.000020316',
'I.000014358','I17287',
'I3607',
'I.000020373',
'I.000003110',
'I7773',
'I22269',
'I.000004778',
'I10769',
'I4509',
'I.000019424',
'I.000014484',
'I.000018389',
'I532',
'I.000014811',
'I.000018388',
'I.000018136',
'I.000014845',
'I.000009148',
'I.000005828',
'I.000005828',
'I7051',
'I.000017053',
'I.000012956',
'I5801',
'I.000016119',
'I.000014393',
'I.000009828',
'I.000013480',
'I.000010419',
'I20336',
'I.000019640',
'I23110',
'I6706',
'I.000015882',
'I8580',
'I14697',
'I.000018952',
'I.000011356',
'I.000012771',
'I.000019511',
'I.000012219'
)
group by clientcode, clientname, category
order by clientname 
;

/*
select * 
from rcbill_my.dailyusage  
where datestart>='2019-10-15' and dateend<=now()
and TRAFFICTYPE='Default'
and
clientcode='I.000020316';
*/

/*
select COUNT(*) as clientticket_cmmtjourney  from rcbill_my.clientticket_cmmtjourney;
select COUNT(*) as clientticket_assgnjourney from rcbill_my.clientticket_assgnjourney;
*/

##GET TICKET HISTORY
select * from  rcbill_my.clientticket_cmmtjourney
WHERE ticketid
in
(

select ticketid from rcbill_my.rep_servicetickets_2019
where 
tickettype in ('fault','Hardware')
and date(opendate) >='2019-10-15'
and
clientcode in 
(
'I.000020316',
'I.000014358','I17287',
'I3607',
'I.000020373',
'I.000003110',
'I7773',
'I22269',
'I.000004778',
'I10769',
'I4509',
'I.000019424',
'I.000014484',
'I.000018389',
'I532',
'I.000014811',
'I.000018388',
'I.000018136',
'I.000014845',
'I.000009148',
'I.000005828',
'I.000005828',
'I7051',
'I.000017053',
'I.000012956',
'I5801',
'I.000016119',
'I.000014393',
'I.000009828',
'I.000013480',
'I.000010419',
'I20336',
'I.000019640',
'I23110',
'I6706',
'I.000015882',
'I8580',
'I14697',
'I.000018952',
'I.000011356',
'I.000012771',
'I.000019511',
'I.000012219'
)
)
;

/*
select * from  rcbill_my.clientticket_cmmtjourney
where clientcode in 
(
'I.000020316',
'I.000014358','I17287',
'I3607',
'I.000020373',
'I.000003110',
'I7773',
'I22269',
'I.000004778',
'I10769',
'I4509',
'I.000019424',
'I.000014484',
'I.000018389',
'I532',
'I.000014811',
'I.000018388',
'I.000018136',
'I.000014845',
'I.000009148',
'I.000005828',
'I.000005828',
'I7051',
'I.000017053',
'I.000012956',
'I5801',
'I.000016119',
'I.000014393',
'I.000009828',
'I.000013480',
'I.000010419',
'I20336',
'I.000019640',
'I23110',
'I6706',
'I.000015882',
'I8580',
'I14697',
'I.000018952',
'I.000011356',
'I.000012771',
'I.000019511',
'I.000012219'
)
;
*/