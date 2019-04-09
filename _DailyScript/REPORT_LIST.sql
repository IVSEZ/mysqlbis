
select * from rcbill.rcb_clientparcels;

select * from rcbill_my.rep_paycol_channel;
select * from rcbill_my.rep_paycol_pos;


select * from rcbill_my.rep_allcust;
select * from rcbill_my.rep_clientcontractdevices;
select * from rcbill_my.rep_customers_collection2018;
select * from rcbill_my.rep_customers_collection2019;
select * from rcbill_my.rep_cust_cont_payment_cmts_mxk;
select * from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail;

select * from rcbill_my.rep_clientstats1;
select * from rcbill_my.rep_clientstats2;
select * from rcbill_my.rep_anreport_all;
select * from rcbill_my.rep_anreport_i;
select * from rcbill_my.rep_anreport_t;
select * from rcbill_my.rep_anreport_v;
select * from rcbill_my.rep_anreport_o;

select * from rcbill_my.rep_addon;
select * from rcbill_my.rep_housingestates;
select * from rcbill_my.rep_prepaid_camera;


select * from rcbill_my.rep_extravagance_peak_activity;
select * from rcbill_my.rep_extravagance_peakcustomer_activity;



select * from rcbill_my.rep_custconsolidated where clientcode='I.000019420';

select * from rcbill_my.activenumberavg;

select * from rcbill_my.rep_activenumberavg;
select * from rcbill_my.rep_activenumberavg2;

## MONTHLY AVERAGE REPORT FOR SUBMISSION
select * from rcbill_my.rep_activenumberavg3;

## BUDGET VS ACTUAL ANALYSIS
select * from rcbill_my.rep_budget_actual_2019_pv;

#SERVICE TICKETS
select * from rcbill_my.rep_servicetickets_2019;


##TV
select * from rcbill_my.rep_activenumberavg3 where servicecategory='TV';

select lastday, servicecategory, region, sum(activecount) as activecount
from rcbill_my.rep_activenumberavg3 where 0=0 
and servicecategory='TV'
group by lastday, servicecategory, region;

select lastday,servicecategory, round(sum(activecount)) as activecount
from rcbill_my.rep_activenumberavg2
group by lastday, servicecategory
;

select lastday, round(sum(activecount)) as activecount
from rcbill_my.rep_activenumberavg2
group by lastday 
;

select * from rcbill_my.rep_activenumberlastday;
select period, sum(activecount) as activecount
from rcbill_my.rep_activenumberlastday
group by period
;


show columns from rcbill_my.rep_activenumberlastday_pv;
select * from rcbill_my.rep_activenumberlastday_pv;
select * from rcbill_my.rep_activenumberavg_pv;

select servicecategory, package, `20181231`, `20190131` from rcbill_my.rep_activenumberlastday_pv;
select servicecategory, package, `20181231`, `20190131` from rcbill_my.rep_activenumberavg_pv;

select * from rcbill_my.rep_activenumberavgMahe;
select * from rcbill_my.rep_activenumberavgMahe_pv;
select * from rcbill_my.rep_activenumberavgPraslin;
select * from rcbill_my.rep_activenumberavgPraslin_pv; 

select lastday, round(sum(activecount)) as activecount 
from rcbill_my.rep_activenumberavgMahe
group by lastday
;
select lastday, round(sum(activecount)) as activecount 
from rcbill_my.rep_activenumberavgPraslin
group by lastday
;

select servicecategory
, sum(`20161231`) as `20161231` 
, sum(`20171231`) as `20171231` 
, sum(`20181127`) as `20181127` 
from rcbill_my.rep_activenumberlastday_pv
group by servicecategory
;


select * from rcbill.clientcontractip  where CLIENTCODE='I6816' order by USAGEDATE desc;

select * from rcbill.clientcontractip where PROCESSEDCLIENTIP='154.70.187.241' and USAGEDATE='2018-12-31';
select * from rcbill.clientcontractip where PROCESSEDCLIENTIP='154.70.186.118' and USAGEDATE='2018-12-31';
select * from rcbill.clientcontractip where PROCESSEDCLIENTIP='41.203.255.10' and USAGEDATE='2018-12-31';
select * from rcbill.clientcontractipmonth where CLIENTCODE='I.000011750' order by USAGE_MTH, USAGE_YR;
select * from rcbill.clientcontractip where PROCESSEDCLIENTIP='197.234.2.150';


-- =======================================


select paydate, pay_channel, sum(pay_amount) as pay_amount from rcbill_my.rep_paycol_channel
group by paydate, pay_channel
-- order by paydate desc
with rollup
;

select paydate, pay_pos, sum(pay_amount) as pay_amount from rcbill_my.rep_paycol_pos
group by paydate, pay_pos
-- order by paydate desc
with rollup
;

select clean_connection_type
, count(clientcode) as clients
, count(distinct clientcode) as d_clients
from rcbill_my.rep_custconsolidated
group by clean_connection_type
with rollup
;

select activenetwork
, count(clientcode) as clients
, count(distinct clientcode) as d_clients
from rcbill_my.rep_custconsolidated
where IsAccountActive='Active'
group by 1
-- order by 1,2,3, 4
with rollup
;


select isaccountactive, accountactivitystage
, count(clientcode) as clients
, count(distinct clientcode) as d_clients
from rcbill_my.rep_custconsolidated
group by isaccountactive, accountactivitystage
with rollup
;

select 
ifnull(isaccountactive,'') as isaccountactive
, ifnull(accountactivitystage,'') as accountactivitystage
, ifnull(clientclass,'') as clientclass
, ifnull(activenetwork,'') as activenetwork
, ifnull(hfc_district,'') as hfc_district
, ifnull(hfc_district,clientlocation) as hfc_district2
, ifnull(clean_hfc_nodename,'') as clean_hfc_nodename
, ifnull(clean_mxk_name,'') as clean_mxk_name
, ifnull(clientlocation,'') as clientlocation

, count(clientcode) as clients
, count(distinct clientcode) as d_clients
, sum(totalpaymentamount) as totalpaymentamount
, sum(TotalPayments2019) as TotalPayments2019
, sum(TotalPaymentAmount2019) as TotalPaymentAmount2019
			, sum(`201901`) as `201901`, sum(`201902`) as `201902`, sum(`201903`) as `201903`, sum(`201904`) as `201904`
			, sum(`201905`) as `201905`, sum(`201906`) as `201906`, sum(`201907`) as `201907`, sum(`201908`) as `201908`
			, sum(`201909`) as `201909`, sum(`201910`) as `201910`, sum(`201911`) as `201911`, sum(`201912`) as `201912`
, sum(TotalPayments2018) as TotalPayments2018
, sum(TotalPaymentAmount2018) as TotalPaymentAmount2018
			, sum(`201801`) as `201801`, sum(`201802`) as `201802`, sum(`201803`) as `201803`, sum(`201804`) as `201804`
			, sum(`201805`) as `201805`, sum(`201806`) as `201806`, sum(`201807`) as `201807`, sum(`201808`) as `201808`
			, sum(`201809`) as `201809`, sum(`201810`) as `201810`, sum(`201811`) as `201811`, sum(`201812`) as `201812`
from rcbill_my.rep_custconsolidated
group by 
1, 2, 3, 4, 5, 6, 7, 8, 9
;


select activenetwork, clientlocation, clean_mxk_name, clean_hfc_nodename
, count(clientcode) as clients
, count(distinct clientcode) as d_clients
from rcbill_my.rep_custconsolidated
where IsAccountActive='Active'
group by 1,2, 3, 4
-- order by 1,2,3, 4
with rollup
;

-- ACTIVE NUMBERS from Rahul analysis
select CONTRACTCURRENTSTATUS, VPNR_SERVICETYPE,CL_CLCLASSNAME
-- , S_SERVICENAME
, count( distinct CL_CLIENTID) as d_clients
, count(CL_CLIENTID) as clients, count(CON_CONTRACTCODE) as contracts, sum(CS_SUBSCRIPTIONCOUNT) as subs
from rcbill.clientcontractssubs
group by CONTRACTCURRENTSTATUS, VPNR_SERVICETYPE,CL_CLCLASSNAME
-- , S_SERVICENAME
with rollup
;

##MXK COUNT
select date(insertedon) as dateinserted, mxk_name
-- , MXK_INTERFACE
,  count(*) as devicecount
from rcbill.rcb_mxk
group by 1, 2 -- , 3
order by 1 desc, 2 asc
;


/*clients and contracts who have nexttv without parent device id*/
select distinct CLIENT_CODE, CLIENT_NAME, CONTRACT_CODE, USERNAME from rcbill_my.rep_clientcontractdevices
where SERVICE_TYPE='NEXTTV'
and (username is null or username='')
;

select distinct CLIENT_CODE, CLIENT_NAME, CONTRACT_CODE, USERNAME from rcbill_my.rep_clientcontractdevices
where SERVICE_TYPE='NEXTTV'
and (username is not null and username<>'')
;

## CLIENT EMAIL AND OTHER INFO REPORT FOR MARKETING
-- select * from rcbill.rcb_tclients;
select reportdate, clientcode
, currentdebt, IsAccountActive, AccountActivityStage
, clientname
, clientclass, clientemail
, clientphone , clientlocation, clientaddress

, clean_connection_type
from rcbill_my.rep_custconsolidated
where 0=0
-- limit 100
;