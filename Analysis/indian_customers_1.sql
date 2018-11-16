select 
clientclass,clienttype,services,activecount, contractcount, period, clientcode, clientname, region, network
,`Basic`,`Executive`,`Prestige`,`Extravagance`,`Extravagance Corporate`,`Indian`,`Indian Corporate`,`French` 
from rcbill_my.clientstats 
where (`Indian`>0 or `Indian Corporate`>0)

;

select 
clientclass,clienttype,services,activecount, contractcount, period, clientcode, clientname, region, network
,`Basic`,`Executive`,`Prestige`,`Extravagance`,`Extravagance Corporate`,`Indian`,`Indian Corporate`,`French` 
from rcbill_my.clientstats 
where (`French`>0)

;

