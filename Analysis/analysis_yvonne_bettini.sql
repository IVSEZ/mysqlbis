select * from rcbill_my.clientstats where (`Crimson`>0 or `Crimson Corporate`>0);

select * from rcbill_my.clientstats where (`Crimson`>0);
select * from rcbill_my.clientstats where (`Crimson Corporate`>0);


select * from rcbill_my.rep_customers_collection where client_code='I3733';

select * from rcbill_my.customers_collection where ClientCode='I3733';
select * from rcbill_my.clientticket_cmmtjourney where clientcode='I3733' 
and ( comment like '%discount%') -- or comment like '%off%')
;


select * from rcbill_my.clientticketsnapshot_f where clientcode='I3733';
select * from rcbill_my.clientticketsnapshot_irs where clientcode='I3733';
select * from rcbill_my.clientticket_cmmtjourney where clientcode='I3733';
select * from rcbill_my.clientticket_assgnjourney where clientcode='I3733';


select * from rcbill_my.clientticket_cmmtjourney where clientcode='I3733' 
and ( comment like '%discount%') -- or comment like '%off%')
;

-- explain select rcbill.GetClientID('I3733');
select * from rcbill.rcb_casa where CLID in (select id from rcbill.rcb_tclients where kod ='I3733') order by id desc;

select * from rcbill.rcb_casa where CLID in (select id from rcbill.rcb_tclients where kod ='I3733') order by id desc;

select * from rcbill.rcb_tickets where ID=940131;

select * from rcbill_my.dailysales where ORDERID='899848';

select * from rcbill.rcb_invoicesheader where ORDERID='899848'; -- where CLID in (select id from rcbill.rcb_tclients where kod ='I3733') order by id desc;

select  *, rcbill.GetClientCode(CLID) as clientcode, rcbill.GetContractCode(CID) as contractcode from rcbill.rcb_invoicesheader where INVOICENO='2714007';
select  *, rcbill.GetClientCode(CLID) as clientcode, rcbill.GetContractCode(CID) as contractcode from rcbill.rcb_invoicescontents where INVOICENO='2714007';
select *, rcbill.GetClientCode(CLID) as clientcode, rcbill.GetContractCode(CID) as contractcode from rcbill.rcb_casa where CLID in (select id from rcbill.rcb_tclients where kod ='I3733') order by id desc;


select * from rcbill_my.clientticket_cmmtjourney where clientcode='I3733' 
and (( comment like '%discount%') or ( comment like '%install%') or ( comment like '%refund%'))
;


set @clientcode = 'I15998';

select clientcode, ticketid, tickettype, opendate, openuser, openreason, comment, commentuser
from 
(
select * from rcbill_my.clientticket_cmmtjourney 
where 0=0
and clientcode=@clientcode 
-- and (( comment like '%discount%') or ( comment like '%install%') or ( comment like '%refund%'))
-- and (( comment like '%discount%') or ( comment like '%refund%') or ( comment like '%promo%')  or ( comment like '%free%'))
and (( comment like '%discount%') or ( comment like '%refund%') or ( comment like '%promo%')  or ( comment like '%free%') or ( comment like '%install%') or ( comment like '%migrat%') or ( comment like '%reloca%'))

) a 
group by 1, 2
order by 3 desc
;

select clientcode, ticketid, opendate, openuser, openreason, comment, commentuser
from 
(
select * from rcbill_my.clientticket_cmmtjourney 
where 0=0
and clientcode=@clientcode 
-- and (( comment like '%discount%') or ( comment like '%install%') or ( comment like '%refund%'))
-- and (( comment like '%install%') or ( comment like '%migrat%') or ( comment like '%reloca%') )
) a 
group by 1, 2
order by 3 desc
;

select clientcode, clientname
, (select b.clientclass from rcbill_my.rep_custconsolidated b where b.clientcode =a.clientcode) as clientclass
, count(distinct ticketid) as tickets
from 
rcbill_my.clientticket_cmmtjourney a 
group by 1,2
order by 4 desc
;

select year(opendate) as tkt_year, clientcode, clientname, count(distinct ticketid) 
from 
rcbill_my.clientticket_cmmtjourney
group by 1,2,3
order by 4 desc
;



select date(opendate) as tkt_d, clientcode, clientname, count(distinct ticketid) 
from 
rcbill_my.clientticket_cmmtjourney
group by 1,2,3
order by 4 desc
;


select * from rcbill_my.clientticketsnapshot_irs where clientcode='I3733';

select  *, rcbill.GetClientCode(CLID) as clientcode, rcbill.GetContractCode(CID) as contractcode from rcbill.rcb_invoicesheader where CLID=(select id from rcbill.rcb_tclients where kod='I3733'); --   rcbill.GetClientID('I3733');
select  *, rcbill.GetClientCode(CLID) as clientcode, rcbill.GetContractCode(CID) as contractcode from rcbill.rcb_invoicescontents 
where INVOICENO in (select INVOICENO from rcbill.rcb_invoicesheader where CLID=(select id from rcbill.rcb_tclients where kod='I3733'));
