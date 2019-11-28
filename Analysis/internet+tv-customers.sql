select * from rcbill.rcb_tclients where KOD in 
(
'I10369',	'I.000000722',	'I.000009458',	'I10514',	'I18672',	'I389',	'I18870',	'I4568',	'I1673',	'I.000002343',	'I7112',	'I3693',	'I.000008179',	'I.000006687',	'I19230',	'I8020',	'I.000013811',	'I7967',	'I21343',	'I1673',	'I.000005120',	'I13397',	'I.000008847',	'I21983',	'I.000009517',	'I.000002018',	'I.000014009',	'I20646',	'I7155',	'I998',	'I.000006525',	'I20046',	'I.000015232',	'I.000010336',	'I22515',	'I.000007686',	'I.000011915',	'I2821',	'I18453',	'I.000002276',	'I.000009386',	'I19822',	'I1534',	'I.000003307',	'I12938',	'I18564',	'I.000013817',	'I.000004024',	'I.000010864',	'I.000011320',	'I8603',	'I14331',	'I20129',	'I.000010234',	'I13142',	'I1730',	'I2788',	'I.000002936',	'I4768',	'I1721',	'I.000005968',	'I6553',	'I524',	'I.000011178',	'I.000014752',	'I.000005921',	'I.000011320',	'I.000004346',	'I14604',	'I.000005921',	'I6097',	'I2788',	'I.000007501',	'I.000004473',	'I12429',	'I.000010383',	'I19928',	'I1401',	'I.000010856',	'I13267',	'I.000011388',	'I7945',	'I17183',	'I.000008537',	'I6940',	'I.000002941',	'I458',	'I1465',	'I.000002101',	'I16201',	'I.000011292',	'I.000008537',	'I7945',	'I.000011388',	'I6940'

);

select * from rcbill_my.clientstats where (`Extravagance`>=1 or `Extravagance Corporate`>=1 or `Basic`>=1 or `Prestige`>=1 or `Executive`>=1) and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname;

select * from rcbill_my.clientstats where (`Extravagance`>=1 or `Extravagance Corporate`>=1) and (`Basic`>=1) and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname;
select * from rcbill_my.clientstats where (`Extravagance`>=1 or `Extravagance Corporate`>=1) and (`Executive`>=1)  and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname;
select * from rcbill_my.clientstats where (`Extravagance`>=1 or `Extravagance Corporate`>=1) and (`Prestige`>=1)  and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname;

select * from rcbill_my.clientstats where (`Prestige`>=1) and (`Executive`>=1)  and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname;
select * from rcbill_my.clientstats where (`Prestige`>=1) and (`Basic`>=1)  and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname;
select * from rcbill_my.clientstats where (`Executive`>=1) and (`Basic`>=1)  and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname;

select * from rcbill_my.clientstats where (`Basic`>=2)  and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname;
select * from rcbill_my.clientstats where (`Executive`>=2)  and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname;
select * from rcbill_my.clientstats where (`Prestige`>=2)  and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname;
select * from rcbill_my.clientstats where (`Extravagance`>=2 or `Extravagance Corporate`>=2) and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname;











select * from rcbill_my.clientstats 
where (`Extravagance`>=1 or `Extravagance Corporate`>=1) 
and services in ('All','TV & Internet') and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname; 

select * from rcbill_my.clientstats 
where (`Extravagance`>=1 or `Extravagance Corporate`>=1) and services in ('All','TV & Internet') 
and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') and (`Starter`=0 and `Value`=0)
order by clientname; 

select * from rcbill_my.clientstats 
where (`Extravagance`>=1 or `Extravagance Corporate`>=1 or `Basic`>=1 or `Prestige`>=1 or `Executive`>=1) 
and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname;

select * from rcbill_my.clientstats 
where (`Extravagance`>1 or `Extravagance Corporate`>1 or `Basic`>1 or `Prestige`>1 or `Executive`>1) 
and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') order by clientname;


select distinct services from rcbill_my.clientstats;

/* EXTRAVAGANCE + INTERNET */
select * from rcbill_my.clientstats where (`Extravagance`>=1 or `Extravagance Corporate`>=1) 
and services in ('TV & Internet','TV & Internet & Voice') and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') 
order by clientname; 

/* EXECUTIVE + INTERNET */
select * from rcbill_my.clientstats where (`Executive`>=1) 
and services in ('TV & Internet','TV & Internet & Voice') and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') 
order by clientname; 

/* BASIC + INTERNET */
select * from rcbill_my.clientstats where (`Basic`>=1) 
and services in ('TV & Internet','TV & Internet & Voice') and clientclass in ('Residential','Corporate Bundle','Corporate Bulk') 
order by clientname; 




