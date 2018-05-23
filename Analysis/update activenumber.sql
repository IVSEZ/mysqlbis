use rcbill_my;

SET SQL_SAFE_UPDATES = 0;

select * from rcbill_my.activenumber a
inner join 
(
select *
, (select servicenewtype from rcbill_my.lkpservicetype where servicetype=servicetypeold) as sto
, (select GetServiceType(servicetypeold,sto,service)) as st
, (select reported from rcbill_my.lkpreported where servicenewtype=st) as rep

 from rcbill_my.activenumber where servicetypeold='Amber::=Amber'--  and period=@rundate 

) b on
    a.servicetypeold = b.servicetypeold
    ;

update rcbill_my.activenumber a
inner join 
(
select *
, (select servicenewtype from rcbill_my.lkpservicetype where servicetype=servicetypeold) as sto
, (select GetServiceType(servicetypeold,sto,service)) as st
, (select reported from rcbill_my.lkpreported where servicenewtype=st) as rep

 from rcbill_my.activenumber where servicetypeold='Crimson::=Crimson'--  and period=@rundate 

) b on
    a.servicetypeold = b.servicetypeold
set
     a.servicetypeold1 = b.sto
  -- a.servicetype=b.st
 -- a.reported=b.rep
 ;
 
/* 
update rcbill_my.activenumber
set servicetypeold1=(select servicenewtype from rcbill_my.lkpservicetype where servicetype=servicetypeold)
where
servicetypeold1='Amber::=Amber'
;
*/

select *
, (select servicenewtype from rcbill_my.lkpservicetype where servicetype=servicetypeold) as sto
, (select GetServiceType(servicetypeold,sto,service)) as st
, (select reported from rcbill_my.lkpreported where servicenewtype=st) as rep

 from rcbill_my.activenumber where period=@rundate ;


 

update rcbill_my.activenumber
set Reported='N'
where ServiceNewType in ('Prepaid', 'Prepaid Data', 'Prepaid28', 'Variety', 'Broad Band 100', 'Broad Band 200', 'Broad Band Lite', 'Business Unlimited-4'
, 'Business Unlimited-4-daytime', 'Intel Data 20', 'Premium');


servicetypeold = @servicetypeold,
servicetypeold1 = (select servicenewtype from rcbill_my.lkpservicetype where servicetype=@servicetypeold),
servicetype = (select GetServiceType(servicetypeold,servicetypeold1,service)),

reported = (select reported from rcbill_my.lkpreported where servicenewtype=servicetype)

