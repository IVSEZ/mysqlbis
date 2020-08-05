select CLIENTCODE, CLIENTNAME, CURRENTDEBT, IsAccountActive, activeservices, clientclass, clientaddress, clean_mxk_interface, clean_mxk_name 
from rcbill_my.rep_custconsolidated 
where 0=0
and 
clean_mxk_name like '%BEAUVALLON%'
and 
IsAccountActive='Active'


(
activeservices in ('All')
or 
activeservices like '%Voice%'
)
;


select CLIENTCODE, CLIENTNAME, CURRENTDEBT, IsAccountActive, activeservices, clientclass, clientaddress
, clean_hfc_node, clean_hfc_nodename 
from rcbill_my.rep_custconsolidated 
where 0=0
and 
clean_hfc_nodename like '%BEAU-VALLON%' 
and 
IsAccountActive='Active'