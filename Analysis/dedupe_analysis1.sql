select * from rcbill.client_match_phone;
select * from rcbill.client_match_nin;
select * from rcbill.client_match_name;

show columns from rcbill.client_match_name;
show columns from rcbill.client_match_nin;
show columns from rcbill.client_match_phone;


SELECT * from 
(
select CLIENT_CODE, CLIENT_NAME, M_CLIENT_CODE, M_CLIENT_NAME
, NULL AS CLIENT_NIN, NULL AS M_CLIENT_NIN
, NULL AS CLIENT_PHONE, NULL AS M_CLIENT_PHONE
, M_SCORE
, 'NAME' as MATCHED_ON
, INSERTEDON 
from rcbill.client_match_name
where date(INSERTEDON) = (select max(date(INSERTEDON)) from rcbill.client_match_name)

union all

select CLIENT_CODE, CLIENT_NAME, M_CLIENT_CODE, M_CLIENT_NAME
, CLIENT_NIN, M_CLIENT_NIN
, NULL AS CLIENT_PHONE, NULL AS M_CLIENT_PHONE
, M_SCORE
, 'NIN' as MATCHED_ON
, INSERTEDON 
from rcbill.client_match_nin
where date(INSERTEDON) = (select max(date(INSERTEDON)) from rcbill.client_match_nin)

union all

select CLIENT_CODE, CLIENT_NAME, M_CLIENT_CODE, M_CLIENT_NAME
, NULL AS CLIENT_NIN, NULL AS M_CLIENT_NIN
, CLIENT_PHONE, M_CLIENT_PHONE
, M_SCORE
, 'PHONE' as MATCHED_ON
, INSERTEDON 
from rcbill.client_match_phone
where date(INSERTEDON) = (select max(date(INSERTEDON)) from rcbill.client_match_phone)

) a 
order by client_code
;

