select * from rcbill_my.rep_paycol_channel;
select * from rcbill_my.rep_paycol_pos;


select * from rcbill_my.rep_allcust;
select * from rcbill_my.rep_clientcontractdevices;
select * from rcbill_my.rep_customers_collection2018;
select * from rcbill_my.rep_cust_cont_payment_cmts_mxk;
select * from rcbill_my.rep_cust_cont_payment_cmts_mxk_trail;

select * from rcbill_my.rep_clientstats1;
select * from rcbill_my.rep_clientstats2;
select * from rcbill_my.rep_anreport_all;
select * from rcbill_my.rep_activenumberavg;
select * from rcbill_my.rep_addon;
select * from rcbill_my.rep_housingestates;
select * from rcbill_my.rep_prepaid_camera;


select * from rcbill_my.rep_extravagance_peak_activity;
select * from rcbill_my.rep_extravagance_peakcustomer_activity;


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