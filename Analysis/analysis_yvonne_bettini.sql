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
and ( comment like '%discount%')
;
select * from rcbill_my.clientticketsnapshot_irs where clientcode='I3733';