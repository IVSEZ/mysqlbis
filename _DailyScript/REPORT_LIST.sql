
select *, rcbill.GetClientID(clientcode) as clientid from rcbill_my.rep_custconsolidated;

select * from rcbill.rcb_clientparcels;

select CONCAT_WS( "|", a1_parcel,a2_parcel,a3_parcel ) as client_parcels
from rcbill.rcb_clientparcels;

-- SAM Report
select * from rcbill_my.rep_ott;

select * from rcbill.rcb_casa where date(PAYDATE)='2019-10-29';
select * from rcbill.rcb_invoicesheader where date(DATA)='2019-10-29';

select * from rcbill_my.matched_clients;

select * from rcbill_my.rep_paycol_channel;
select * from rcbill_my.rep_paycol_pos;


select * from rcbill_my.rep_allcust;
select * from rcbill_my.rep_clientcontractdevices;
select * from rcbill_my.rep_customers_collection2018;
select * from rcbill_my.rep_customers_collection2019;
select * from rcbill_my.rep_cust_cont_payment_cmts_mxk;
select * from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail;

select * from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail2;

#ALL STATS FROM CMTSMXK TRAIL TABLE
select * from rcbill_my.rep_cmtsmxk_trail order by reportdate desc;
#CMTS
select HFC_NODE, NODENAME, CMTS_DATE, date(INSERTEDON) as INSERTED_ON
, count(distinct CLIENT_CODE) as UNIQUE_ACCOUNTS, count(distinct CONTRACT_CODE) as UNIQUE_CONTRACTS
, count(distinct MAC) as UNIQUE_MAC_INRCBOSS, count(distinct MAC_ADDRESS) as UNIQUE_MAC_INCMTS
from rcbill_my.customers_cmts
group by HFC_NODE, NODENAME, CMTS_DATE, date(INSERTEDON)
with rollup
-- order by HFC_NODE
;

#MXK
select MXK_NAME, MXK_DATE, date(INSERTEDON) as INSERTED_ON
, count(distinct CLIENT_CODE) as UNIQUE_ACCOUNTS, count(distinct CONTRACT_CODE) as UNIQUE_CONTRACTS
, count(distinct FSAN2) as UNIQUE_FSAN_INRCBOSS, count(distinct SERIAL_NUM2) as UNIQUE_FSAN_INMXK
from rcbill_my.customers_mxk
group by MXK_NAME, MXK_DATE, date(INSERTEDON)
with rollup
-- order by MXK_NAME
;

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

## SALES REPORTS
select * from rcbill_my.sales order by orderday desc;

SELECT orderday, weekday, orderdate, orderid, salescenter, createdby, region, ordertype, salestype, state, orderstatus
, clientcode, clientclass, contractcode, contracttype, service, servicetype, cost, price, num, originalcontract, originalservice, originalservicetype
-- , originalprice
, cleanorigcost as origcost, cleanorigprice as origprice
from rcbill_my.sales
where year(orderday)>2018
order by orderdate desc;


select * from rcbill_my.rep_dailysales where salescenter='Sales' order by orderday desc;
select * from rcbill_my.rep_dailysalesreg where salescenter='Sales' order by orderday desc;
select year(orderday) as ordersyear, month(orderday) as ordersmonth, day(orderday) as ordersday,weekday,monthname(orderday) as monthname, ordercount from rcbill_my.rep_dailysales where salescenter='Sales' and salestype='New Sales' order by orderday desc;
select year(orderday) as ordersyear, month(orderday) as ordersmonth, day(orderday) as ordersday,weekday,monthname(orderday) as monthname, `Mahe`, `Praslin`, `Unknown` from rcbill_my.rep_dailysalesreg where salescenter='Sales' and salestype='New Sales' order by orderday desc;

-- select * from rcbill_my.rep_dailysales where salescenter='Sales' and salestype='Renewals' order by orderday desc;
select year(orderday) as ordersyear, month(orderday) as ordersmonth, day(orderday) as ordersday,weekday, ordercount from rcbill_my.rep_dailysales where salescenter='Sales' and salestype='Renewals' order by orderday desc;
select * from rcbill_my.rep_dailysalesreg where salescenter='Sales' and salestype='Renewals' order by orderday desc;
select year(orderday) as ordersyear, month(orderday) as ordersmonth, day(orderday) as ordersday,weekday,monthname(orderday) as monthname, `Mahe`, `Praslin`, `Unknown` from rcbill_my.rep_dailysalesreg where salescenter='Sales' and salestype='Renewals' order by orderday desc;
#######################################

select * from rcbill_my.rep_extravagance_peak_activity;
select * from rcbill_my.rep_extravagance_peakcustomer_activity;



select * from rcbill_my.rep_custconsolidated where clientcode='I.000012657';
select * from rcbill_my.rep_custconsolidated where clientname like '%ballanty%';
select * from rcbill_my.rep_custconsolidated where clean_mxk_interface='1-2-4-1';

select * from rcbill_my.activenumberavg;

select * from rcbill_my.rep_activenumberavg;
select * from rcbill_my.rep_activenumberavg2;

## LAST DAY ACTIVE NUMBER
select servicecategory, package
-- , `20181031`, `20181130`, `20181231`
, `20190131`, `20190228`, `20190331`
, `20190430`, `20190531`, `20190630`
, `20190731`, `20190831`, `20190930`
 from rcbill_my.rep_activenumberlastday_pv;
 
## MONTHLY AVERAGE REPORT FOR SUBMISSION
select * from rcbill_my.rep_activenumberavg3;

## BUDGET VS ACTUAL ANALYSIS
select * from rcbill_my.rep_budget_actual_2019_pv;

#SERVICE TICKETS
select * from rcbill_my.rep_servicetickets_2019;

#GET TICKETS WITH CERTAIN COMMENTS IN THEM
select * from  rcbill_my.clientticketjourney 
where commentuser in ('Rahul Walavalkar') and 
(trim(upper(comment)) REGEXP 'APPROVED FOR RETENTION')
order by commentdate desc
;


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




select * from rcbill.clientcontractip  where CLIENTCODE='I.000011750' order by USAGEDATE desc;
select * from rcbill.clientcontractipmonth where CLIENTCODE='I.000011750' order by USAGE_YR desc, USAGE_MTH desc;

select * from rcbill.clientcontractip where PROCESSEDCLIENTIP='154.70.187.241' and USAGEDATE='2018-12-31';
select * from rcbill.clientcontractip where PROCESSEDCLIENTIP='154.70.186.118' and USAGEDATE='2018-12-31';
select * from rcbill.clientcontractip where PROCESSEDCLIENTIP='41.220.111.246' and USAGEDATE='2018-12-31';
select * from rcbill.clientcontractipmonth where CLIENTCODE='I.000011750' order by USAGE_MTH, USAGE_YR;
select * from rcbill.clientcontractip where PROCESSEDCLIENTIP='197.234.2.150';

select * from rcbill.clientcontractip where PROCESSEDCLIENTIP='197.234.3.145' order by usagedate desc;

select * from rcbill.clientcontractip where PROCESSEDCLIENTIP='196.13.208.101' order by usagedate desc;
select * from rcbill.clientcontractip where PROCESSEDCLIENTIP='41.220.107.242' order by usagedate desc;


select * from rcbill.clientcontractip where CLIENTCODE='I.000009236' order by usagedate desc;

select * from rcbill.clientcontractipmonth where PROCESSEDCLIENTIP='41.220.111.243';
select * from rcbill.clientcontractipmonth where PROCESSEDCLIENTIP='154.70.175.82';


select CLIENTCODE, CLIENTNAME, CONTRACTCODE, USAGEDATE, PROCESSEDCLIENTIP as IP from rcbill.clientcontractip where CLIENTCODE='I.000009236' order by usagedate desc;
select CLIENTCODE, CLIENTNAME, CONTRACTCODE, USAGE_MTH, USAGE_YR, PROCESSEDCLIENTIP as IP, FROM_DATE, TO_DATE 
from rcbill.clientcontractipmonth where CLIENTCODE='I.000009236' order by USAGE_YR desc, USAGE_MTH desc, TO_DATE desc;


select FROM_DATE, TO_DATE, USAGE_MTH, USAGE_YR, CONTRACTCODE, PROCESSEDCLIENTIP as IP  
from rcbill.clientcontractipmonth where CLIENTCODE='I.000009236' order by TO_DATE desc;

-- show index from rcbill.clientcontractip 

-- =======================================

## call center (cc) report
select * from rcbill_my.rep_cccallreport order by calldate desc;
select * from rcbill_my.rep_cccallreport where clientcode='I.000011750';

select * from rcbill_my.rep_cccallreport where clientcode='I.000009236';
select * from rcbill_my.rep_cccallreport where callernumber=2719841;

select calldate, shiftday, shift, callernumber, waittime, callstatus, ccagent, callagent, talktime
from 
rcbill_my.rep_cccallreport where clientcode='I.000009236'
order by calldate desc;

############################

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


### ticket assignment
select reportdate, service, tickettype, openreason, ticketid, opendate, closedate, assgntechregion, assgnopendate
, assgnclosedate, service_workdays,  service_workdays2, service_alldays, packageprice, priceperday, agreeddays, penaltydays, penaltyamount, client_code, contractcode, clientname, clientclass
, activenetwork, activeservices, clientlocation, mxk_name, mxk_interface,nodename, hfc_node, hfc_district, hfc_subdistrict

from rcbill_my.rep_servicetickets_2019 order by ticketid desc, assgnopendate asc
;


### tickets by user for current year
select commentuser,  count(comment) as comments, count(distinct ticketid) as d_tickets
, min(date(commentdate)) as firstdate, max(date(commentdate)) as lastdate, count(distinct date(commentdate)) as cmmtdays
, datediff(max(date(commentdate)), min(date(commentdate))) as totaldays
, count(distinct ticketid)/count(distinct date(commentdate)) as avgtktday
, count(comment)/count(distinct date(commentdate)) as avgcmtday
, (count(distinct date(commentdate))/datediff(max(date(commentdate)), min(date(commentdate)))) as consistency
from 
rcbill_my.clientticket_cmmtjourney
where year(commentdate)=year(now())
group by commentuser
order by 2 desc;

### tickets by user for 2018
select commentuser,  count(comment) as comments, count(distinct ticketid) as d_tickets
, min(date(commentdate)) as firstdate, max(date(commentdate)) as lastdate, count(distinct date(commentdate)) as cmmtdays
, datediff(max(date(commentdate)), min(date(commentdate))) as totaldays
, count(distinct ticketid)/count(distinct date(commentdate)) as avgtktday
, count(comment)/count(distinct date(commentdate)) as avgcmtday
, (count(distinct date(commentdate))/datediff(max(date(commentdate)), min(date(commentdate)))) as consistency
from 
rcbill_my.clientticket_cmmtjourney
where year(commentdate)=2018
group by commentuser
order by 2 desc;


#online payments
select PAYMENTDATE, EXTERNALREF
				, CLIENTCODE, CLIENTNAME, PAYMENTAMOUNT, SERVICE, PACKAGE, DEBTPERIODFROM, DEBTPERIODTO, PAYMENTCOMMENT
				, CLIENTCLASS, CONTRACTCODE, INSERTEDON
				from rcbill_my.onlinepayments where year(paymentdate)=2019 order by paymentdate desc
                ;
                
select paymentdate, externalref, clientcode, clientname, sum(paymentamount) as paymentamount
from rcbill_my.onlinepayments
group by paymentdate, externalref, clientcode, clientname
;

## SERVICE TICKETS ASSIGNMENT REPORT FOR PATRICK
select reportdate, service, tickettype, openreason, ticketid, opendate, closedate, assgntechregion, assgnopendate
				, assgnclosedate, service_workdays,  service_workdays2, service_alldays, packageprice, priceperday, agreeddays, penaltydays, penaltyamount, client_code, contractcode, clientname, clientclass
				, activenetwork, activeservices, clientlocation, mxk_name, mxk_interface,nodename, hfc_node, hfc_district, hfc_subdistrict

				from rcbill_my.rep_servicetickets_2019 order by ticketid desc, assgnopendate asc 
;

select assgntechregion, date(assgnopendate), count(distinct ticketid) as d_tickets, count(ticketid) as ticket_instances
from rcbill_my.rep_servicetickets_2019 
group by assgntechregion, 2
order by 1, 2 desc
;

select assgntechregion, date(assgnclosedate), count(distinct ticketid) as d_tickets, count(ticketid) as ticket_instances
from rcbill_my.rep_servicetickets_2019 
group by assgntechregion, 2
order by 1, 2 desc
;


##### VOD ACTIVE CUSTOMERS
select * from rcbill_my.clientstats where `VOD`>0
;

##### ACTIVE CUSTOMERS
select services, count(distinct clientcode) AS CLIENTS, sum(contractcount) AS CONTRACTS from rcbill_my.clientstats
where clientclass in ('Residential','Corporate Bundle','Corporate Bulk') 
group by services
;


###### customer snapshot
select * from rcbill_my.customercontractsnapshot where clientcode='I.000012204';
select * from rcbill_my.customercontractsnapshot where package='Intel Data 10' and CurrentStatus='Active';
select * from rcbill_my.customercontractsnapshot where package='Intel Data 10' and CurrentStatus='Active' and network='HFC';
select * from rcbill_my.customercontractsnapshot where package='Intel Data 10' and CurrentStatus='Active' and network='GPON';
##### 
select * from rcbill_my.rep_custconsolidated;



###### user actions

select a.*
/*, b.kod as clientcode
, b.firm as clientname
, c.kod as contractcode
*/
, rcbill.GetClientCode(a.clid) as clientcode
, rcbill.GetClientNameFromId(a.clid) as clientname
, rcbill.GetContractCode(a.cid) as contractcode
, d.name as username
from 
rcbill.rcb_useractions a 
/*
left join 
rcbill.rcb_tclients b 
on a.clid=b.id

left join
rcbill.rcb_contracts c
on a.cid=c.id
*/
left join
rcbill.rcb_users d
on a.userid=d.id
limit 1000
;

