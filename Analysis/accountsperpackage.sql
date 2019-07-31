#ALL
select count(distinct clientcode) as extravagancecust from rcbill_my.customercontractsnapshot where  package in ('Extravagance','Extravagance Corporate');
select count(distinct clientcode) as crimsoncust from rcbill_my.customercontractsnapshot where  package in ('Crimson','Crimson Corporate');
select count(distinct clientcode) as ambercust from rcbill_my.customercontractsnapshot where  package in ('Amber','Amber Corporate');
select count(distinct clientcode) as executivecust from rcbill_my.customercontractsnapshot where  package in ('Executive');
select count(distinct clientcode) as basiccust from rcbill_my.customercontractsnapshot where  package in ('Basic');
select count(distinct clientcode) as vodcust from rcbill_my.customercontractsnapshot where  package in ('VOD');

#ACTIVE
select count(distinct clientcode) as extravagancecust from rcbill_my.customercontractsnapshot where package in ('Extravagance','Extravagance Corporate') and CurrentStatus='Active';
select count(distinct clientcode) as crimsoncust from rcbill_my.customercontractsnapshot where  package in ('Crimson','Crimson Corporate') and CurrentStatus='Active';
select count(distinct clientcode) as ambercust from rcbill_my.customercontractsnapshot where  package in ('Amber','Amber Corporate') and CurrentStatus='Active';
select count(distinct clientcode) as executivecust from rcbill_my.customercontractsnapshot where  package in ('Executive') and CurrentStatus='Active';
select count(distinct clientcode) as basiccust from rcbill_my.customercontractsnapshot where  package in ('Basic') and CurrentStatus='Active';
select count(distinct clientcode) as vodcust from rcbill_my.customercontractsnapshot where  package in ('VOD') and CurrentStatus='Active';





select * from rcbill_my.clientstats where VOD>0 and DualView>0
and clientclass not in ('Employee','Intelvision Office')
;


select * from rcbill_my.clientstats where VOD>0 and MultiView>0
and clientclass not in ('Employee','Intelvision Office')
;

select count(distinct clientcode) as cappedcust from rcbill_my.customercontractsnapshot where servicecategory2='Internet - Capped';
select count(distinct clientcode) as cappedcust from rcbill_my.customercontractsnapshot where servicecategory2='Internet - Capped' and CurrentStatus='Active';

select count(distinct clientcode) as uncappedcust from rcbill_my.customercontractsnapshot where servicecategory2='Internet - UnCapped';
select count(distinct clientcode) as uncappedcust from rcbill_my.customercontractsnapshot where servicecategory2='Internet - UnCapped' and CurrentStatus='Active';