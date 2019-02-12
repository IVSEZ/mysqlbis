select * from rcbill.client_match_phone;
select * from rcbill.client_match_nin;
select * from rcbill.client_match_name;

/*
show columns from rcbill.client_match_name;
show columns from rcbill.client_match_nin;
show columns from rcbill.client_match_phone;
*/

/*
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


select CLIENT_CODE, CLIENT_NAME, M_CLIENT_CODE, M_CLIENT_NAME
, CASE WHEN MATCHED_ON='NAME' THEN 1 ELSE 0 END AS MATCH_NAME
, CASE WHEN MATCHED_ON='NIN' THEN 1 ELSE 0 END AS MATCH_NIN
, CASE WHEN MATCHED_ON='PHONE' THEN 1 ELSE 0 END AS MATCH_PHONE
FROM
(

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
	ORDER BY CLIENT_CODE
) a
ORDER BY CLIENT_CODE,M_CLIENT_CODE
;
*/


drop table if exists rcbill_my.matched_clients;

create table rcbill_my.matched_clients as 
(
	select rcbill_my.GetNewClientCode(CLIENT_CODE,M_CLIENT_CODE) as DEDUPE_CLIENT_CODE
    , CLIENT_CODE, CLIENT_NAME, M_CLIENT_CODE, M_CLIENT_NAME
	, max(CLIENT_NIN) as CLIENT_NIN, max(M_CLIENT_NIN) as M_CLIENT_NIN
    , max(CLIENT_PHONE) as CLIENT_PHONE, max(M_CLIENT_PHONE) as M_CLIENT_PHONE
	, sum(MATCH_NAME) AS MATCH_NAME
	, sum(MATCH_NIN) AS MATCH_NIN
	, sum(MATCH_PHONE) AS MATCH_PHONE
	FROM 
	(
		select CLIENT_CODE, CLIENT_NAME, M_CLIENT_CODE, M_CLIENT_NAME, CLIENT_NIN, M_CLIENT_NIN, CLIENT_PHONE, M_CLIENT_PHONE
		, CASE WHEN MATCHED_ON='NAME' THEN 1 ELSE 0 END AS MATCH_NAME
		, CASE WHEN MATCHED_ON='NIN' THEN 1 ELSE 0 END AS MATCH_NIN
		, CASE WHEN MATCHED_ON='PHONE' THEN 1 ELSE 0 END AS MATCH_PHONE
		FROM
		(

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
		) a
		order by CLIENT_CODE, M_CLIENT_CODE
	) a 
	group by 1, CLIENT_CODE, CLIENT_NAME, M_CLIENT_CODE, M_CLIENT_NAME
	-- , CLIENT_NIN, M_CLIENT_NIN, CLIENT_PHONE, M_CLIENT_PHONE
	ORDER BY 1
)
;

DROP TABLE if exists rcbill_my.dedupe_clients;
CREATE table rcbill_my.dedupe_clients as 
(
	select DEDUPE_CLIENT_CODE, MATCH_NAME, MATCH_NIN, MATCH_PHONE
	FROM 
	rcbill_my.matched_clients 
	group by DEDUPE_CLIENT_CODE, MATCH_NAME, MATCH_NIN, MATCH_PHONE
)
;

select * from rcbill_my.matched_clients;
select * from rcbill_my.dedupe_clients;

select * from rcbill_my.dedupe_clients where match_name=1 and match_nin=1 and match_phone=1;

-- select * from rcbill_my.dedupe_clients where dedupe_client_code like '%[I6054]%';

/*

select * from rcbill_my.matched_clients
where 0=0
-- and CLIENT_NAME like '%samia cad%'
-- and client_nin	= '984-0385-1-0-88'
-- and dedupe_client_code in ('[I.000000018]|[I19765]')
and CLIENT_CODE in ('I.000000399')
;

*/


