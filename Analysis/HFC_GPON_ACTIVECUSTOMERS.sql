select 
clean_connection_type
, isaccountactive , accountactivitystage
, clean_mxk_name , clean_hfc_nodename 
, count(clientcode) as clients
from rcbill_my.rep_custconsolidated
where clean_mxk_name like '%BEAU%' or clean_hfc_nodename like '%OMBRE%' or clean_hfc_nodename like '%BEAU%'

group by 1, 2, 3 , 4, 5

;