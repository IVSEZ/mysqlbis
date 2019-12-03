select * from rcbill_my.rep_custconsolidated where (`201911`=0 or `201911` is null) and (`201910`=0 or `201910` is null) and (TotalPaymentAmount2019=0 or TotalPaymentAmount2019 is null)and dayssincelastactive<=65;

select * from rcbill_my.rep_customers_collection2019;
