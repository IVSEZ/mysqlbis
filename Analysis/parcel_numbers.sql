select * from rcbill.rcb_tclients where upper(address) like '%PARCEL%';
select * from rcbill.rcb_tclients where upper(moladdress) like '%PARCEL%';
select * from rcbill.rcb_tclients where upper(MOLRegistrationAddress) like '%PARCEL%';

select id, firm, kod, address, moladdress, MOLRegistrationAddress 
,locate('PARCEL',upper(address)) as a1_location
,locate('PARCEL',upper(moladdress)) as a2_location
,locate('PARCEL',upper(MOLRegistrationAddress)) as a3_location
, if(locate('PARCEL',upper(address))>0,substring_index(upper(address),'PARCEL',-1),'') as a1_parcel
, if(locate('PARCEL',upper(moladdress))>0,substring_index(upper(moladdress),'PARCEL',-1),'') as a2_parcel
, if(locate('PARCEL',upper(MOLRegistrationAddress))>0,substring_index(upper(MOLRegistrationAddress),'PARCEL',-1),'') as a3_parcel
from rcbill.rcb_tclients 
where 
upper(address) like '%PARCEL%'
or
upper(moladdress) like '%PARCEL%'
or
upper(MOLRegistrationAddress) like '%PARCEL%'
;


select *
, replace(regex_replace('[^a-zA-Z0-9/\d\s]','',a1_parcel),'NO|NUMBER','') as a1_parcel1
-- , regex_replace('[^A-Za-z0-9]+', '', a1_parcel) as a1_parcel1
, regex_replace('[^A-Za-z0-9 ] ', '', a2_parcel) as a2_parcel1
, regex_replace('[^A-Za-z0-9 ] ', '', a3_parcel) as a3_parcel1

from
(
	select id, firm, kod, address, moladdress, MOLRegistrationAddress 
	,locate('PARCEL',upper(address)) as a1_location
	,locate('PARCEL',upper(moladdress)) as a2_location
	,locate('PARCEL',upper(MOLRegistrationAddress)) as a3_location
	, if(locate('PARCEL',upper(address))>0,substring_index(upper(address),'PARCEL',-1),'') as a1_parcel
	, if(locate('PARCEL',upper(moladdress))>0,substring_index(upper(moladdress),'PARCEL',-1),'') as a2_parcel
	, if(locate('PARCEL',upper(MOLRegistrationAddress))>0,substring_index(upper(MOLRegistrationAddress),'PARCEL',-1),'') as a3_parcel
	from rcbill.rcb_tclients 
	where 
	upper(address) like '%PARCEL%'
	or
	upper(moladdress) like '%PARCEL%'
	or
	upper(MOLRegistrationAddress) like '%PARCEL%'
) a

;




select * from rcbill.rcb_tclients where upper(address) like '%PARCEL%'
and id not in 
(
	-- select id from rcbill.rcb_tclients where upper(moladdress) like '%PARCEL%'
    select id from rcbill.rcb_tclients where upper(MOLRegistrationAddress) like '%PARCEL%'
)
; 

select * from rcbill.rcb_tclients where upper(moladdress) like '%PARCEL%'
and id not in 
(
	-- select id from rcbill.rcb_tclients where upper(moladdress) like '%PARCEL%'
    select id from rcbill.rcb_tclients where upper(MOLRegistrationAddress) like '%PARCEL%'
)
; 

SELECT REGEX_REPLACE('Stackoverflow','[A-Zf]','-',1,0,'c'); 


SELECT regex_replace('[^A-Za-z0-9 ] ', '', 'NO. Stackoverflow')AS RegexText ;
SELECT regex_replace(' ', '', 'NO. Stackoverflow')AS RegexText ;
 
 select version();