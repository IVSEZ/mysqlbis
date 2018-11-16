
select *, rcbill.GetClientID(clientcode) as ClientID from rcbill_my.clientstats where `Prestige`>0;

select *, rcbill.GetClientCode(clid) as ClientCode, rcbill.GetContractCode(cid) as ContractCode from rcbill.rcb_casa 
	where clid in 
	(
		select rcbill.GetClientID(clientcode) as ClientID from rcbill_my.clientstats where `Prestige`>0
	)
	and date(EndDate)>'2018-11-09'
;



-- select 