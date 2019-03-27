
select *, rcbill.GetClientID(clientcode) as ClientID from rcbill_my.clientstats where `Prestige`>0;

select a.*, (b.name) as package
from 
(
select id, paytype, (paytype*-1) as serviceid, clid, cid, paydate, money, discountmoney, invid, userid, begdate, enddate
from rcbill.rcb_casa 
where 0=0
and date(EndDate)>'2019-02-28'
) a 
inner join 
rcbill.rcb_vpnrates b 
on (a.serviceid)=b.serviceid
and a.clid=b.clid
and a.cid=b.cid
;
 

select a.clientcode, a.contractcode, a.username, a.paydate, a.begdate, a.enddate
-- ,b.package
from 
(
	select *, rcbill.GetClientCode(clid) as ClientCode, rcbill.GetContractCode(cid) as ContractCode
	 , (select username from rcbill.rcb_users where id=rcb_casa.userid) as username
	 -- , (select vpnr_servicetype from rcbill.clientcontractssubs where cl_clientid=rcb_casa.clid and con_contractcode=rcbill.GetContractCode(rcb_casa.cid)) as package
	 -- , (select name from rcbill.rcb_vpnrates where serviceid=(paytype*-1)) as package
     from rcbill.rcb_casa 
		where clid in 
		(
			select rcbill.GetClientID(clientcode) as ClientID from rcbill_my.clientstats where `Prestige`>0
		)
		and date(EndDate)>'2019-02-28'
         -- ;
		
         -- select * from rcbill.rcb_vpnrates;
         and money=550
) a
order by a.enddate







left join
rcbill_my.customercontractsnapshot b
on a.clientcode=b.clientcode and a.contractcode=b.contractcode

;

select * from rcbill.rcb_vpnrates;

select * from rcbill.rcb_users;

select distinct id, count(username) from rcbill.rcb_users
group by id
 order by 2 desc;
-- select 


select * from rcbill_my.clientcontractssubs;
select * from rcbill.clientcontractssubs where cl_clientcode='I.000007278' and CON_CONTRACTCODE='I.000056252';

select * from rcbill_my.customercontractsnapshot	
;

select clientcode, clientname, clientclass, clientphone from rcbill_my.rep_custconsolidated

where clientcode in (select clientcode from rcbill_my.clientstats where Prestige>0);