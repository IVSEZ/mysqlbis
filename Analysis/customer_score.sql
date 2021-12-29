#### 	CUSTOMER SCORING

set @clientcode='I8782';
set @contractcode='I.000343328';

select * from rcbill_my.customercontractsnapshot where clientcode=@clientcode;

select * from rcbill_my.customers_contracts_collection_pivot where clientcode=@clientcode;

select * from rcbill_my.customers_collection where ClientCode=@clientcode;

show index from rcbill.rcb_casa ;
select * from rcbill.rcb_casa a 
where a.CLID in (select rcbill.GetClientID(@clientcode)) and a.CID in (select rcbill.GetContractID(@contractcode));