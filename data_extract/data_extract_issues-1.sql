
select b.*
,  case when b.SUBFROM is null then (select a.SERVICESTARTDATE from rcbill_extract.IV_SERVICEINSTANCE a where a.SERVICEINSTANCEIDENTIFIER=b.SERVICEINSTANCEIDENTIFIER and a.SERVICESTARTDATE is not null limit 1) end as NewSubFrom
,  case when b.SUBTO is null then (select a.SERVICEENDDATE from rcbill_extract.IV_SERVICEINSTANCE a where a.SERVICEINSTANCEIDENTIFIER=b.SERVICEINSTANCEIDENTIFIER and a.SERVICEENDDATE is not null limit 1) end as NewSubTo


from rcbill_extract.IV_SERVICEINSTANCE b where b.SUBFROM is null
;


select * from rcbill_extract.IV_SERVICEINSTANCE where SUBFROM is null;
select * from rcbill_extract.IV_SERVICEINSTANCE where SUBTO is null;


select a.*
, date(b.SERVICESTARTDATE) as NEWSUBFROM
, date(b.SERVICEENDDATE) as NEWSUBTO

from 
rcbill_extract.IV_SERVICEINSTANCE a 
left join
rcbill_extract.IV_SERVICEINSTANCE b
on
a.SERVICEINSTANCENUMBER=b.SERVICEINSTANCENUMBER

where 
a.SUBFROM is null
and
a.SUBTO is null
;

