select clientcode, clientname, network, clientclass, clienttype from rcbill_my.clientstats where (`Extravagance`>0 or `Extravagance Corporate`>0) and services='TV & Internet' 
and clientclass not in ('Employee','VIP')
order by network asc 
;
and network='GPON';
select * from rcbill_my.clientstats where (`Extravagance`>0 or `Extravagance Corporate`>0) and services='TV & Internet & OTT' ; and `VOD`=0


select * from rcbill_my.clientstats where (`Extravagance`>0 or `Extravagance Corporate`>0) 
and network='GPON'
and services='TV Only'

 ; and `VOD`=0


select * from rcbill_my.clientstats 
where 
-- (`Executive`>0)
-- (`Extravagance`>0 or `Extravagance Corporate`>0)
 (`Basic`>0)
and network='GPON'
 and services='TV Only'
-- and services='TV & Internet' 
and clientclass not in ('Employee','VIP')
;


