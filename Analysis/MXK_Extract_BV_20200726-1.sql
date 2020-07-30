select CLIENTCODE, CLIENTNAME, CURRENTDEBT, IsAccountActive, activeservices, clientclass, clientaddress, clean_mxk_interface, clean_mxk_name 
from rcbill_my.rep_custconsolidated 
where 0=0
and 
clean_mxk_name like '%BEAUVALLON%'
and 
(
activeservices in ('All')
or 
activeservices like '%Voice%'
)
;