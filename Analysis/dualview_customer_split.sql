select * from rcbill.clientcontractdevices where servicetype='NEXTTV' and deviceid is not null;

select distinct servicetype from rcbill.clientcontractdevices;


-- select * from rcbill_my.sales where servicetype='MultiView' order by clientcode;

select * from rcbill.clientcontractdevices where clientcode='I.000009663';
select * from rcbill.clientcontractdevices where clientcode='I5203';

select * from rcbill.rcb_devices where ID=2073870578;

select * from rcbill.rcb_devices where natip is not null;

select * from rcbill.clientcontractdevices where ServiceType in ('MOBILE TV','NEXTTV'),'GTV','DTV');

select * from rcbill.rcb_devices where ContractID = ;

set @package='dualview';
set @package='multiview';
set @clientclass="'Intelvision Office','Employee'";

select * from rcbill_my.clientstats where dualview>0;
select * from rcbill_my.clientstats where multiview>0;


select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and dualview>0 and `Starter`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and dualview>0 and `Value`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and dualview>0 and `Elite`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and dualview>0 and `Extreme`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and dualview>0 and `Extreme Plus`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and dualview>0 and `Performance`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and dualview>0 and `Performance Plus`>0;

select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and dualview>0 and `Intel Data 10`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and dualview>0 and `Crimson`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and dualview>0 and `Crimson Corporate`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and dualview>0 and `Amber`>0;


select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and (`Extravagance`>1 or `Extravagance Corporate`>1);

-- HOW MANY DUALVIEW CUSTOMERS HAD 2 TV PACKAGES BEFORE
select * from rcbill.clientcontractssubs where VPNR_SERVICETYPE='DUALVIEW' and cl_clclassname not in ('INTELVISION OFFICE');


select * from rcbill.clientcontractssubs where VPNR_SERVICETYPE='DUALVIEW' and cl_clclassname not in ('INTELVISION OFFICE');

select period, clientcode, package from rcbill_my.customercontractactivity where servicecategory='TV'
and clientcode in 
(
select cl_clientcode from rcbill.clientcontractssubs where VPNR_SERVICETYPE='DUALVIEW' and cl_clclassname not in ('INTELVISION OFFICE')
)
;


select clientcode, package, min(period), max(period) from rcbill_my.customercontractactivity where servicecategory='Internet'
and clientcode in 
(
select cl_clientcode from rcbill.clientcontractssubs where VPNR_SERVICETYPE='DUALVIEW' and cl_clclassname not in ('INTELVISION OFFICE')
)
group by clientcode, package
order by 3,4
;



select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and multiview>0 and `Starter`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and multiview>0 and `Value`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and multiview>0 and `Elite`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and multiview>0 and `Extreme`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and multiview>0 and `Extreme Plus`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and multiview>0 and `Performance`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and multiview>0 and `Performance Plus`>0;

select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and multiview>0 and `Intel Data 10`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and multiview>0 and `Crimson`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and multiview>0 and `Crimson Corporate`>0;
select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and multiview>0 and `Amber`>0;




select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and `Extravagance Corporate`>0;

select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and `Extravagance Corporate`>0 and services in ('All','TV & Internet');


select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and `Extravagance Corporate`>0 and services in ('All','TV & Internet') and network='GPON';

select * from rcbill_my.clientstats where clientclass not in ('Intelvision Office','Employee') and `Extravagance Corporate`>0 and services in ('All','TV & Internet') and network='HFC';




