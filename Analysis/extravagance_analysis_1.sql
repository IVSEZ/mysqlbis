
select * from rcbill_my.clientstats where (`Extravagance`>0 or `Extravagance Corporate`>0) and `Intelenovela`>0;

select clientcode, clientname, clientclass, clienttype, services, period, region, network
, ActiveCount, contractcount
, `Extravagance`, `Extravagance Corporate`, `Intelenovela`
from rcbill_my.clientstats where (`Extravagance`>0 or `Extravagance Corporate`>0) and `Intelenovela`>0;


select clientcode, clientname, clientclass, clienttype, services, period, region, network
, ActiveCount, contractcount
, `Extravagance`, `Extravagance Corporate`, `Intelenovela`, `DualView`, `MultiView` 

from rcbill_my.clientstats 
where (`Extravagance`>0 or `Extravagance Corporate`>0) and `Intelenovela`>0 and (`DualView`>0 or `MultiView`>0)
-- with rollup
;


select clientcode, clientname, clientclass, clienttype, services, period, region, network
, ActiveCount, contractcount
, `Basic`, `Intelenovela`
from rcbill_my.clientstats where (`Basic`>0) and (`Intelenovela`>0);

select clientcode, clientname, clientclass, clienttype, services, period, region, network
, ActiveCount, contractcount
, `Executive`, `Intelenovela`
from rcbill_my.clientstats where (`Executive`>0) and (`Intelenovela`>0);


select clientcode, clientname, clientclass, clienttype, services, period, region, network
, ActiveCount, contractcount
, `Extravagance`, `Extravagance Corporate`, `Intelenovela` 
from rcbill_my.clientstats where (`Extravagance`=0 and `Extravagance Corporate`=0) and (`Intelenovela`>0);

