use rcbill_my;

##NETFLIX CUSTOMERS ANALYSIS

-- SELECT * FROM rcbill_my.dailystreamingusage ;
-- show index from rcbill_my.dailystreamingusage;
-- SELECT * FROM rcbill.clientcontractipmonth;

-- show index from rcbill.clientcontractipmonth;


set @streamingcategory='STREAMING';
set @streamingname='NETFLIX';

SELECT * FROM rcbill_my.dailystreamingusage where STREAMINGCATEGORY=@streamingcategory AND STREAMINGNAME=@streamingname;

SELECT A.*, B.*
FROM 
rcbill_my.dailystreamingusage A 
LEFT JOIN
rcbill.clientcontractipmonth B
ON 
A.IP=B.PROCESSEDCLIENTIP
AND
(
(A.DATESTART>=B.FROM_DATE AND A.DATESTART<=B.TO_DATE)
OR
(A.DATEEND>=B.FROM_DATE AND A.DATEEND<=B.TO_DATE)
);


drop table if exists rcbill_my.a;

create table rcbill_my.a(index idxa1(datestart),index idxa2(dateend), index idxa3(from_date),index idxa4(to_date)) as
(
SELECT A.*, B.*
FROM 
rcbill_my.dailystreamingusage A 
LEFT JOIN
rcbill.clientcontractipmonth B
ON 
A.IP=B.PROCESSEDCLIENTIP
/*
AND
(A.DATESTART>=B.FROM_DATE AND A.DATESTART<=B.TO_DATE)
AND
(A.DATEEND>=B.FROM_DATE AND A.DATEEND<=B.TO_DATE)
*/
)
;

select * , (INCOMINGBYTES)/(1024.0*1024.0) as INCOMING_MB
, (OUTGOINGBYTES)/(1024.0*1024.0) as OUTGOING_MB, (TOTALBYTES)/(1024.0*1024.0) as TOTAL_MB
 ,concat(from_date,'-',to_date) as ip_duration
 , rcbill_my.GetPackageForClientContractDate(CLIENTCODE, CONTRACTCODE, FROM_DATE) as PACKAGE_FROM 
 , rcbill_my.GetPackageForClientContractDate(CLIENTCODE, CONTRACTCODE, TO_DATE) as PACKAGE_TO
, rcbill_my.GetPackageFromSnapshot(CLIENTCODE,CONTRACTCODE) as DERIVED_PACKAGE 	
from rcbill_my.a
where 
(DATESTART>=FROM_DATE AND DATESTART<=TO_DATE)
OR
(DATEEND>=FROM_DATE AND DATEEND<=TO_DATE)
;

select datestart, dateend, streamingcategory, streamingname, ip, INCOMING_MB, OUTGOING_MB, TOTAL_MB
, CLIENTCODE, clientname, PACKAGE_FROM, PACKAGE_TO, DERIVED_PACKAGE

-- , DERIVED_PACKAGE
, group_concat( distinct CONTRACTCODE order by CONTRACTCODE asc separator '|') as CONTRACTCODES
, sum(IPINSTANCES) as IPINSTANCES
, group_concat( distinct ip_duration order by ip_duration asc separator '|') as ip_duration
from 
(
	select * , (INCOMINGBYTES)/(1024.0*1024.0) as INCOMING_MB
	, (OUTGOINGBYTES)/(1024.0*1024.0) as OUTGOING_MB, (TOTALBYTES)/(1024.0*1024.0) as TOTAL_MB
	 ,concat(from_date,'-',to_date) as ip_duration
	 , rcbill_my.GetPackageForClientContractDate(CLIENTCODE, CONTRACTCODE, FROM_DATE) as PACKAGE_FROM 
	 , rcbill_my.GetPackageForClientContractDate(CLIENTCODE, CONTRACTCODE, TO_DATE) as PACKAGE_TO
	, rcbill_my.GetPackageFromSnapshot(CLIENTCODE,CONTRACTCODE) as DERIVED_PACKAGE 	
    from rcbill_my.a
	where 
	(DATESTART>=FROM_DATE AND DATESTART<=TO_DATE)
	OR
	(DATEEND>=FROM_DATE AND DATEEND<=TO_DATE)
) a

group by 
datestart, dateend, streamingcategory, streamingname, ip, incomingbytes, outgoingbytes, totalbytes
, CLIENTCODE, clientname, PACKAGE_FROM, PACKAGE_TO, DERIVED_PACKAGE
;