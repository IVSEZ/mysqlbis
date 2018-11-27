select count(distinct clientcode) as extravagancecust from rcbill_my.customercontractsnapshot where  package in ('Extravagance','Extravagance Corporate');
select count(distinct clientcode) as crimsoncust from rcbill_my.customercontractsnapshot where  package in ('Crimson','Crimson Corporate');
select count(distinct clientcode) as ambercust from rcbill_my.customercontractsnapshot where  package in ('Amber','Amber Corporate');



select * from rcbill_my.clientstats where VOD>0 and DualView>0
and clientclass not in ('Employee','Intelvision Office')
;


select * from rcbill_my.clientstats where VOD>0 and MultiView>0
and clientclass not in ('Employee','Intelvision Office')
;

select * from rcbill_my.customercontractsnapshot;