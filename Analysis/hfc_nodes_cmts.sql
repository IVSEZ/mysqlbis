select a.hfc_node, b.*
from 
(
	select distinct hfc_node from rcbill.rcb_cmts
) a
left join
rcbill.rcb_techregions b
on
a.hfc_node=b.interfacename
;