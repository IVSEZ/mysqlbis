select * from rcbill_my.customers_collection;


drop table if exists rcbill_my.customers_contracts_collection_pivot ;
create table rcbill_my.customers_contracts_collection_pivot (index idxccp1 (clientcode), index idxccp2(clid), index idxccp3(cid), index idxccp4(contractcode) ) as 
(
		select clid, clientcode, cid, contractcode
		, ifnull(sum(`202001`),0) as `202001` 
		, ifnull(sum(`202002`),0) as `202002` 
		, ifnull(sum(`202003`),0) as `202003` 
		, ifnull(sum(`202004`),0) as `202004` 
		, ifnull(sum(`202005`),0) as `202005` 
		, ifnull(sum(`202006`),0) as `202006` 
		, ifnull(sum(`202007`),0) as `202007` 
		, ifnull(sum(`202008`),0) as `202008` 
		, ifnull(sum(`202009`),0) as `202009` 
		, ifnull(sum(`202010`),0) as `202010` 
		, ifnull(sum(`202011`),0) as `202011` 
		, ifnull(sum(`202012`),0) as `202012` 
		, ifnull(sum(TotalPayments2020),0) as TotalPayments2020
		, ifnull(sum(TotalPaymentAmount2020),0) as TotalPaymentAmount2020
        
		, ifnull(sum(`201901`),0) as `201901` 
		, ifnull(sum(`201902`),0) as `201902` 
		, ifnull(sum(`201903`),0) as `201903` 
		, ifnull(sum(`201904`),0) as `201904` 
		, ifnull(sum(`201905`),0) as `201905` 
		, ifnull(sum(`201906`),0) as `201906` 
		, ifnull(sum(`201907`),0) as `201907` 
		, ifnull(sum(`201908`),0) as `201908` 
		, ifnull(sum(`201909`),0) as `201909` 
		, ifnull(sum(`201910`),0) as `201910` 
		, ifnull(sum(`201911`),0) as `201911` 
		, ifnull(sum(`201912`),0) as `201912` 
		, ifnull(sum(TotalPayments2019),0) as TotalPayments2019
		, ifnull(sum(TotalPaymentAmount2019),0) as TotalPaymentAmount2019
        
		, ifnull(sum(`201801`),0) as `201801` 
		, ifnull(sum(`201802`),0) as `201802` 
		, ifnull(sum(`201803`),0) as `201803` 
		, ifnull(sum(`201804`),0) as `201804` 
		, ifnull(sum(`201805`),0) as `201805` 
		, ifnull(sum(`201806`),0) as `201806` 
		, ifnull(sum(`201807`),0) as `201807` 
		, ifnull(sum(`201808`),0) as `201808` 
		, ifnull(sum(`201809`),0) as `201809` 
		, ifnull(sum(`201810`),0) as `201810` 
		, ifnull(sum(`201811`),0) as `201811` 
		, ifnull(sum(`201812`),0) as `201812` 
		, ifnull(sum(TotalPayments2018),0) as TotalPayments2018
		, ifnull(sum(TotalPaymentAmount2018),0) as TotalPaymentAmount2018



		from 
		(    
			select clid, clientcode, cid, contractcode
				,case when paymonth=1 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202001`
				,case when paymonth=2 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202002`
				,case when paymonth=3 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202003`
				,case when paymonth=4 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202004`
				,case when paymonth=5 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202005`
				,case when paymonth=6 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202006`
				,case when paymonth=7 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202007`
				,case when paymonth=8 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202008`
				,case when paymonth=9 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202009`
				,case when paymonth=10 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202010`
				,case when paymonth=11 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202011`
				,case when paymonth=12 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202012`
				,case when payyear=2020 then ifnull(sum(totalpayments),0) end as TotalPayments2020
				,case when payyear=2020 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2020


				,case when paymonth=1 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201901`
				,case when paymonth=2 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201902`
				,case when paymonth=3 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201903`
				,case when paymonth=4 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201904`
				,case when paymonth=5 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201905`
				,case when paymonth=6 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201906`
				,case when paymonth=7 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201907`
				,case when paymonth=8 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201908`
				,case when paymonth=9 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201909`
				,case when paymonth=10 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201910`
				,case when paymonth=11 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201911`
				,case when paymonth=12 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201912`
				,case when payyear=2019 then ifnull(sum(totalpayments),0) end as TotalPayments2019
				,case when payyear=2019 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2019


				,case when paymonth=1 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201801`
				,case when paymonth=2 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201802`
				,case when paymonth=3 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201803`
				,case when paymonth=4 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201804`
				,case when paymonth=5 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201805`
				,case when paymonth=6 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201806`
				,case when paymonth=7 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201807`
				,case when paymonth=8 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201808`
				,case when paymonth=9 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201809`
				,case when paymonth=10 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201810`
				,case when paymonth=11 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201811`
				,case when paymonth=12 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201812`
				,case when payyear=2018 then ifnull(sum(totalpayments),0) end as TotalPayments2018
				,case when payyear=2018 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2018
			
				-- , max(lastpaymentdate) as LastPaymentDate

           from 
			rcbill_my.customers_collection
			-- where year(LastPaymentDate)=2020
			group by
			clid, clientcode, cid, contractcode, PAYMONTH, PAYYEAR
		-- ,3,4,5,6,7,8,9,10,11,12,13,14
		) a 
		group by clid, clientcode, cid, contractcode	

);

select 'created rcbill_my.customers_contracts_collection_pivot' as message;
-- select * from rcbill_my.customers_contracts_collection_pivot where clientcode='I6816';

drop table if exists rcbill_my.customers_collection_pivot;
create table rcbill_my.customers_collection_pivot (index idxccp1 (clientcode), index idxccp2(clid)) as 
(
		select clid, clientcode
		, ifnull(sum(`202001`),0) as `202001` 
		, ifnull(sum(`202002`),0) as `202002` 
		, ifnull(sum(`202003`),0) as `202003` 
		, ifnull(sum(`202004`),0) as `202004` 
		, ifnull(sum(`202005`),0) as `202005` 
		, ifnull(sum(`202006`),0) as `202006` 
		, ifnull(sum(`202007`),0) as `202007` 
		, ifnull(sum(`202008`),0) as `202008` 
		, ifnull(sum(`202009`),0) as `202009` 
		, ifnull(sum(`202010`),0) as `202010` 
		, ifnull(sum(`202011`),0) as `202011` 
		, ifnull(sum(`202012`),0) as `202012` 
		, ifnull(sum(TotalPayments2020),0) as TotalPayments2020
		, ifnull(sum(TotalPaymentAmount2020),0) as TotalPaymentAmount2020
		, ifnull(sum(`201901`),0) as `201901` 
		, ifnull(sum(`201902`),0) as `201902` 
		, ifnull(sum(`201903`),0) as `201903` 
		, ifnull(sum(`201904`),0) as `201904` 
		, ifnull(sum(`201905`),0) as `201905` 
		, ifnull(sum(`201906`),0) as `201906` 
		, ifnull(sum(`201907`),0) as `201907` 
		, ifnull(sum(`201908`),0) as `201908` 
		, ifnull(sum(`201909`),0) as `201909` 
		, ifnull(sum(`201910`),0) as `201910` 
		, ifnull(sum(`201911`),0) as `201911` 
		, ifnull(sum(`201912`),0) as `201912` 
		, ifnull(sum(TotalPayments2019),0) as TotalPayments2019
		, ifnull(sum(TotalPaymentAmount2019),0) as TotalPaymentAmount2019
		, ifnull(sum(`201801`),0) as `201801` 
		, ifnull(sum(`201802`),0) as `201802` 
		, ifnull(sum(`201803`),0) as `201803` 
		, ifnull(sum(`201804`),0) as `201804` 
		, ifnull(sum(`201805`),0) as `201805` 
		, ifnull(sum(`201806`),0) as `201806` 
		, ifnull(sum(`201807`),0) as `201807` 
		, ifnull(sum(`201808`),0) as `201808` 
		, ifnull(sum(`201809`),0) as `201809` 
		, ifnull(sum(`201810`),0) as `201810` 
		, ifnull(sum(`201811`),0) as `201811` 
		, ifnull(sum(`201812`),0) as `201812` 
		, ifnull(sum(TotalPayments2018),0) as TotalPayments2018
		, ifnull(sum(TotalPaymentAmount2018),0) as TotalPaymentAmount2018
        
		from 
		(    
			select clid, clientcode
				,case when paymonth=1 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202001`
				,case when paymonth=2 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202002`
				,case when paymonth=3 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202003`
				,case when paymonth=4 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202004`
				,case when paymonth=5 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202005`
				,case when paymonth=6 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202006`
				,case when paymonth=7 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202007`
				,case when paymonth=8 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202008`
				,case when paymonth=9 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202009`
				,case when paymonth=10 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202010`
				,case when paymonth=11 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202011`
				,case when paymonth=12 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202012`
				,case when payyear=2020 then ifnull(sum(totalpayments),0) end as TotalPayments2020
				,case when payyear=2020 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2020


				,case when paymonth=1 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201901`
				,case when paymonth=2 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201902`
				,case when paymonth=3 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201903`
				,case when paymonth=4 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201904`
				,case when paymonth=5 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201905`
				,case when paymonth=6 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201906`
				,case when paymonth=7 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201907`
				,case when paymonth=8 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201908`
				,case when paymonth=9 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201909`
				,case when paymonth=10 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201910`
				,case when paymonth=11 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201911`
				,case when paymonth=12 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201912`
				,case when payyear=2019 then ifnull(sum(totalpayments),0) end as TotalPayments2019
				,case when payyear=2019 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2019


				,case when paymonth=1 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201801`
				,case when paymonth=2 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201802`
				,case when paymonth=3 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201803`
				,case when paymonth=4 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201804`
				,case when paymonth=5 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201805`
				,case when paymonth=6 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201806`
				,case when paymonth=7 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201807`
				,case when paymonth=8 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201808`
				,case when paymonth=9 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201809`
				,case when paymonth=10 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201810`
				,case when paymonth=11 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201811`
				,case when paymonth=12 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201812`
				,case when payyear=2018 then ifnull(sum(totalpayments),0) end as TotalPayments2018
				,case when payyear=2018 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2018

			from 
			rcbill_my.customers_collection
			-- where year(LastPaymentDate)=2020
			group by
			clid, clientcode, PAYMONTH, PAYYEAR
		-- ,3,4,5,6,7,8,9,10,11,12,13,14
		) a 
		group by clid, clientcode 	

);

select 'created rcbill_my.customers_collection_pivot' as message;
-- select * from rcbill_my.customers_collection_pivot where clientcode='I.000001076';


drop table if exists rcbill_my.rep_customers_collection;
create table rcbill_my.rep_customers_collection(index idxrcc1(client_code), index idxrcc2(clientname) ) as 
(
		select b.reportdate as ReportDate
		,b.clientcode as ClientCode
		,b.clientname as ClientName
		,b.clientclass as ClientClass
		,date(b.firstcontractdate) as FirstContractDate
        ,b.lastpaymentdate as LastPaymentDate
		,b.lastactivedate as LastActiveDate
		,b.clientaddress as ClientAddress
		,b.clientlocation as ClientLocation
		,c.HOUSING_ESTATE as HousingEstate
		,c.CLIENT_AREA as ClientArea
		,c.CLIENT_SUBAREA as ClientSubArea

		, a.clientcode as client_code
        , a.`202001`, a.`202002`, a.`202003`, a.`202004`, a.`202005`, a.`202006`, a.`202007`, a.`202008`, a.`202009`, a.`202010`, a.`202011`, a.`202012`, a.`TotalPayments2020`, a.`TotalPaymentAmount2020`
        , a.`201901`, a.`201902`, a.`201903`, a.`201904`, a.`201905`, a.`201906`, a.`201907`, a.`201908`, a.`201909`, a.`201910`, a.`201911`, a.`201912`, a.`TotalPayments2019`, a.`TotalPaymentAmount2019`
        , a.`201801`, a.`201802`, a.`201803`, a.`201804`, a.`201805`, a.`201806`, a.`201807`, a.`201808`, a.`201809`, a.`201810`, a.`201811`, a.`201812`, a.`TotalPayments2018`, a.`TotalPaymentAmount2018`
		, b.totalpaymentamount as TotalPaymentOverall
        from 
		rcbill_my.rep_allcust b
		left join
		rcbill_my.customers_collection_pivot a 
		on b.clientcode=a.clientcode
		left join
		rcbill_my.rep_housingestates c 
		on b.clientcode=c.CLIENT_CODE
		-- order by a.TotalPaymentAmount2020 desc
        order by b.totalpaymentamount desc
);

select 'created rcbill_my.rep_customers_collection' as message;
-- select * from rcbill_my.rep_customers_collection;