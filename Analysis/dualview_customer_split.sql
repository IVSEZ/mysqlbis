select * from rcbill.clientcontractdevices where servicetype='NEXTTV' and deviceid is not null;

select distinct servicetype from rcbill.clientcontractdevices;


-- select * from rcbill_my.sales where servicetype='MultiView' order by clientcode;

select * from rcbill.clientcontractdevices where clientcode='I.000009663';
select * from rcbill.clientcontractdevices where clientcode='I5203';

select * from rcbill.rcb_devices where ID=2073870578;

select * from rcbill.rcb_devices where natip is not null;

select * from rcbill.clientcontractdevices where ServiceType in ('MOBILE TV','NEXTTV'),'GTV','DTV');

select * from rcbill.rcb_devices where ContractID = ;

select * from rcbill_my.clientstats where dualview>0 and `Starter`>0;
select * from rcbill_my.clientstats where dualview>0 and `Value`>0;
select * from rcbill_my.clientstats where dualview>0 and `Elite`>0;
select * from rcbill_my.clientstats where dualview>0 and `Extreme`>0;
select * from rcbill_my.clientstats where dualview>0 and `Extreme Plus`>0;
select * from rcbill_my.clientstats where dualview>0 and `Performance`>0;
select * from rcbill_my.clientstats where dualview>0 and `Performance Plus`>0;

select * from rcbill_my.clientstats where dualview>0 and `Intel Data 10`>0;
select * from rcbill_my.clientstats where dualview>0 and `Crimson`>0;
select * from rcbill_my.clientstats where dualview>0 and `Crimson Corporate`>0;
select * from rcbill_my.clientstats where dualview>0 and `Amber`>0;


select * from rcbill_my.clientstats where dualview>0;
select * from rcbill_my.clientstats where multiview>0;