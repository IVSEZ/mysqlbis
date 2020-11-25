use rcbill_extract;
select * from rcbill.rcb_casa order by id desc limit 100;
select * from rcbill.rcb_invoicesheader order by id desc limit 100;
select * from rcbill.rcb_invoicescontents order by id desc  limit 100;



set @clid1 = 699807;
set @clid1 = 721746;
set @clid1 = 723711;
set @clid1 = 730174;
set @clid1 = 723959;
set @clid1 = 711581;
set @clid7 = 734460;
set @clid8 = 734440;
set @clid9 = 691038;
set @clid10 = 691038;
set @clid11 = 733908;
set @clid12 = 708755;


select * from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR';

set @kod1 = 'I14';
set @kod2 = 'I.000009787';
set @kod3 = 'I.000011750';
set @kod4 = 'I.000018187';
set @kod5 = 'I.000011998';
set @kod6 = 'I7';
set @kod7 = 'I.000021409';
set @kod8 = 'I.000021390';

set @kod9 = 'I9991';

set @kod10 = 'I.000021467';
set @kod11 = 'I.000020888';

set @clid2=720074;

select * from rcbill.rcb_casa where CLID in (@clid2) order by id desc;
select * from rcbill_extract.IV_PAYMENTHISTORY where CLIENT_ID in (@clid2) order by PAYMENTRECEIPTID desc;
select * from rcbill.rcb_invoicesheader  where CLID in (@clid2) order by id desc;
select * from rcbill_extract.IV_BILLSUMMARY where CLIENT_ID in (@clid2) order by INVOICESUMMARYID desc;
select * from rcbill.rcb_invoicescontents  where CLID in (@clid2) order by id desc;

select * from rcbill_extract.IV_SERVICEINSTANCE where CLIENT_ID in (@clid2);

select * from rcbill_extract.IV_DISCOUNT where client_id in (@clid2, @clid3);

select * from rcbill.rcb_invoicescontents a 
where InvoiceID in (select INVOICESUMMARYID from rcbill_extract.IV_BILLSUMMARY where CLIENT_ID in (@clid2, @clid3)) -- ,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11))
order by id desc
;


select id, clid, cid, rsid, begdate, enddate, paydate from rcbill.rcb_casa where CLID in ((select id from rcbill.rcb_tclients where kod='I.000003551')) order by id desc;

	select CLID, CID, RSID, max(BEGDATE) as SUBLASTSTARTDATE, max(ENDDATE) as SUBLASTENDDATE, max(PAYDATE) as SUBLASTPAYDATE
	from 
	rcbill.rcb_casa

	where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
	group by 
	CLID, CID, RSID
;



SELECT  a.CLID, a.CID, a.RSID, a.BEGDATE as SUBLASTSTARTDATE, a.ENDDATE as SUBLASTENDDATE, a.PAYDATE as SUBLASTPAYDATE
, (select begdate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) ) as CURSUBSTARTDATE
, (select enddate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) ) as CURSUBENDDATE
, (select paydate from rcbill.rcb_casa where clid=a.clid and cid=a.cid and rsid=a.rsid and begdate<=date(now()) and enddate>=date(now()) ) as CURSUBPAYDATE
FROM    rcbill.rcb_casa a
        INNER JOIN
        (
            SELECT  CLID, CID, RSID, max(ID) as MAX_ID 
            FROM    rcbill.rcb_casa
            where CLID in (select id from rcbill.rcb_tclients where kod='I.000011750')
            GROUP BY CLID, CID, RSID
        ) b ON -- a.ID = b.ID AND 
        a.ID = b.max_ID
        ;

select CLID, CID, RSID, max(ID) as MAX_ID 
from rcbill.rcb_casa 
where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
group by CLID, CID, RSID
;


select * from rcbill.rcb_invoicescontents  where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551') order by id desc;


	select CLID, CID, RSID, max(FROMDATE) as INVLASTFROMDATE, max(TODATE) as INVLASTTODATE
	from 
	rcbill.rcb_invoicescontents
	where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
	group by 
	CLID, CID, RSID
    order by id desc
    ;


SELECT  a.CLID, a.CID, a.RSID, a.FROMDATE as LASTINVFROMDATE, a.TODATE as LASTINVTODATE 

, (select fromdate from rcbill.rcb_invoicescontents where clid=a.clid and cid=a.cid and rsid=a.rsid and fromdate<=date(now()) and todate>=date(now()) ) as CURINVFROMDATE
, (select todate from rcbill.rcb_invoicescontents where clid=a.clid and cid=a.cid and rsid=a.rsid and fromdate<=date(now()) and todate>=date(now()) ) as CURINVTODATE

FROM    rcbill.rcb_invoicescontents a
        INNER JOIN
        (
            SELECT  CLID, CID, RSID, max(ID) as MAX_ID 
            FROM    rcbill.rcb_invoicescontents
            where CLID in (select id from rcbill.rcb_tclients where kod='I.000003551')
            GROUP BY CLID, CID, RSID
        ) b ON -- a.ID = b.ID AND 
        a.ID = b.max_ID
        order by id desc
        ;




	select CLID, CID, RSID, max(FROMDATE) as INVLASTFROMDATE, max(TODATE) as INVLASTTODATE
	from 
	rcbill.rcb_invoicescontents

	where CLID in (select id from rcbill.rcb_tclients where kod='I.000011750')
	group by 
	CLID, CID, RSID
    order by id desc
	;

select 
		ifnull((select BILLINGACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as BILLINGACCOUNTNUMBER
	-- , ifnull((select CUSTOMERACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID),'NOT PRESENT') as CUSTOMERACCOUNTNUMBER
		, ifnull((select ACCOUNTNUMBER from rcbill_extract.IV_CUSTOMERACCOUNT where client_id=a.CLID),'NOT PRESENT') as CUSTOMERACCOUNTNUMBER
		, ifnull((select serviceinstancenumber from rcbill_extract.IV_SERVICEINSTANCE where client_id=a.CLID and contract_id=a.CID and servicerateid=a.RSID and serviceid=a.ServiceID limit 1),'NOT PRESENT') as SERVICEINSTANCENUMBER
		,
        a.ID as INVOICEDETAILID
        , a.InvoiceID as INVOICESUMMARYID
		, a.ID as SERIALNUMBER
		, a.INVOICENO as DEBITDOCUMENTNUMBER
        , a.TEXT as NAME
        , a.SCOST as RATE
        , a.NUMBER as ITEMCOUNT
        , a.COST as SUBTOTAL
        , a.CostVAT as TAX
        , a.DiscountCost as DISCOUNT
        , a.Discount as DISCOUNTPERCENT
        , a.CostTotal as TOTALAMOUNT
		, a.COST as DISCOUNTABLE
		, a.DiscountCost as DISCOUNTED
		, a.COST as TAXABLE
        , 0 as UNPAID
        , 0 as WRITEOFF
        , '' as REMARK
		, a.FROMDATE
        , a.TODATE
        
		/*
		, ifnull((select BILLINGACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as BILLINGACCOUNTNUMBER
		, ifnull((select CUSTOMERACCOUNTNUMBER from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as CUSTOMERACCOUNTNUMBER
		, ifnull((select serviceinstancenumber from rcbill_extract.IV_SERVICEINSTANCE where client_id=a.CLID and contract_id=a.CID and servicerateid=a.RSID and serviceid=a.ServiceID limit 1),'NOT PRESENT') as SERVICEINSTANCENUMBER
		, ifnull((select BILLCYCLE from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as BILLCYCLE
		*/
		, ifnull((select BILLCYCLE from rcbill_extract.BILLINGACCOUNT_KEY where client_id=a.CLID and contract_id=a.CID limit 1),'NOT PRESENT') as BILLCYCLE
		, case 
			   when (a.Discount <> 0 or a.DiscountCost <> 0) then 'PRT13' 
			   when a.TEXT like '%DISCOUNT%' then 'PRT13'
		       when a.TEXT like '%\%' then 'PRT13'
               when trim(a.TEXT) = 'VOUCHERS' then 'PRT13'
			   when a.TEXT like '%SUBSCRIPTION%' then 'PRT00'
			   when a.TEXT like '%PREPAID%' then 'PRT00'
			   when a.TEXT like '%ADDON%' then 'PRT00'
			   when a.TEXT like '%VIDEO ON DEMAND%' then 'PRT00'
			   when a.TEXT like 'TURQUOISE%' then 'PRT00'
               when trim(a.TEXT) = 'GVOICE' then 'PRT00'
               when trim(a.TEXT) = 'INDIAN CORPORATE' then 'PRT00'
               when trim(a.TEXT) = 'CAPPED INTERNET' then 'PRT00'
               when trim(a.TEXT) = 'ITERMIZED BILL' then 'PRT00'
			   when a.TEXT like '%INSTALLATION%' then 'PRT06'
			   when a.TEXT like '%MATERIALS%' then 'PRT06'
			   when a.TEXT like '%HARDWARE%' then 'PRT06'
			   when a.TEXT like '%OTHER CHARGES%' then 'PRT06'
			   when a.TEXT like 'RELOCATION%' then 'PRT06'
			   when a.TEXT like '%USAGE%' then 'PRT10'
			   when a.TEXT like '%BUNDLE%' then 'PRT00'
			   when trim(a.TEXT) = 'CONVERT CONTRACT' then 'PRT00'
			   when trim(a.TEXT) = 'MQ BALANCE' then 'PRT00'
               else '' end as `PRODUCTTYPEID`
		
        
        , case when a.TEXT like '%DEPOSIT%' then a.CostTotal
			else 0 end as DEPOSIT

		, case when ((a.Discount=0 and a.DiscountCost=0) and a.SCOST>a.COST) then 'Y' 
			else 'N' end as PRORATIONTYPE
		, 0 as ADJUSTEDAMOUNT
		, ifnull((select PACKAGENAME from rcbill_extract.IV_SERVICEINSTANCE where client_id=a.CLID and contract_id=a.CID and servicerateid=a.RSID and serviceid=a.ServiceID limit 1),'NOT PRESENT') as PACKAGENAME
        , a.UPDDATE as BILLDATE
        , ifnull((select CURRENCYALIAS from rcbill_extract.IV_BILLSUMMARY where DEBITDOCUMENTNUMBER=a.INVOICENO),'NOT PRESENT') as CURRENCYALIAS
        
        
        , case when a.Discount>0 then 'Y'
			else 'N' end as D_DISCOUNTPCT
        
		, a.Discount as D_PCTDISCOUNT
        , '' as D_DISCOUNTNAME
        , a.DiscountCost as D_ABSDISCOUNT
        
        , ifnull((select SYSCURRENCYEXCHANGERATE from rcbill_extract.IV_BILLSUMMARY where DEBITDOCUMENTNUMBER=a.INVOICENO),'NOT PRESENT') as D_SYSCURRENCYEXCHANGERATE
        , a.VAT as T_RATE
        , case when a.VAT>0 then 'VAT' else '' end as T_TAXNAME
        , 0 as T_EXEMPTIONRATE
        , 0 as T_UNPAID
        , 0 as T_WRITEOFF
        , 'PCT' as T_TAXRATETYPE
        , 'N' as T_TAXOVERRIDDEN
        , 0 as T_EXEMPTIONAMT
        , case when a.VAT>0 then 'NON' else 'BTH' end as T_EXEMPTIONAPPLICABILITY
        
        
        , a.CLID as CLIENT_ID
        , a.CID as CONTRACT_ID
        , a.RSID
        , a.ServiceID

from 
rcbill.rcb_invoicescontents a 

where a.InvoiceID in (select INVOICESUMMARYID from rcbill_extract.IV_BILLSUMMARY where CLIENT_ID in (@clid2, @clid3)) -- ,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11))
-- limit 1000
-- where a.clid in (701369)
-- where clid in (select rcbill.GetClientID(CLIENTCODE) from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
-- where a.clid in (@clid1) -- ,@clid2,@clid3,@clid4,@clid5,@clid6,@clid7,@clid8,@clid9,@clid10,@clid11)

order by a.ID desc
;


-- select * from rcbill.rcb_invoicesheader where clid in (@clid9);
/*
						select b.datestart, b.dateend, b.category, b.traffictype, b.device
						, (select a.contractcode from rcbill.clientcontractdevices a where a.phoneno=b.device and a.clientcode=b.clientcode) as contractcode, b.traffic_mb
						, b.billable_duration_min, b.actual_duration_min, b.price, b.price_vat 

						from rcbill_my.dailyusage b 	
						where b.clientcode=@kod3
						order by b.dateend desc
                        ;
*/
-- select * from rcbill.rcb_ipusage where CLIENTCODE=@kod3;

select 
b.CPE_TYPE, count(*)
from rcbill_extract.IV_ADDON a
left join 
rcbill_extract.IV_SERVICEINSTANCE b 
on 
a.SERVICEINSTANCENUMBER=b.SERVICEINSTANCENUMBER

left join 
rcbill_extract.IV_BILLINGACCOUNT c
on b.BILLINGACCOUNTNUMBER=c.BILLINGACCOUNTNUMBER

group by b.CPE_TYPE
;


select 
a.*
, '' as `|`
, b.*

from 
(

		select 
		a.SERVICEINSTANCENUMBER, a.PACKAGENAME
		, ifnull(date(a.SUBLASTSTARTDATE),date(a.INVLASTFROMDATE)) as SUBFROM
		, ifnull(date(a.SUBLASTENDDATE),date(a.INVLASTTODATE)) as SUBTO
		, a.CUSTOMERACCOUNTNUMBER
		, a.BILLINGACCOUNTNUMBER
		, a.SERVICEACCOUNTNUMBER
		, a.SERVICEINSTANCEIDENTIFIER
		, a.SERVICESTATUS
		, a.CPE_TYPE
		, a.PACKAGEAMOUNT
		, a.LASTACTION
		, a.clientcode
		, a.contractcode
		, a.client_id
		, a.contract_id

		from 
		(

				select 

				--  a.* 
				-- , '' as `SEP1`
				-- , b.*



				a.*
				, b.CUSTOMERACCOUNTNUMBER
				, b.BILLINGACCOUNTNUMBER
				, b.SERVICEACCOUNTNUMBER
				, b.SERVICEINSTANCEIDENTIFIER
				, b.SERVICESTATUS
				, b.PACKAGEAMOUNT
				, b.CPE_TYPE
				, b.LASTACTION
				, b.clientcode
				, b.contractcode
				, b.CLIENT_ID
				, b.CONTRACT_ID



				from rcbill_extract.IV_ADDON a
				left join 
				rcbill_extract.IV_SERVICEINSTANCE b 
				on 
				a.SERVICEINSTANCENUMBER=b.SERVICEINSTANCENUMBER

				-- left join 
				-- rcbill_extract.IV_BILLINGACCOUNT c
				-- on b.BILLINGACCOUNTNUMBER=c.BILLINGACCOUNTNUMBER
				where 0=0
				-- and (b.CPE_TYPE like ('%CAPPED%') or b.CPE_TYPE like ('%PREPAID%'))

				and b.client_id=723711
		) a 
) a
left join 
rcbill.clientcontractipusage b
on a.client_id=b.client_id and a.contract_id=b.contract_id and (b.usagedate>=a.subfrom and b.usagedate<=a.subto) and b.TRAFFICTYPE='Default'

;

select * from rcbill.clientcontractipusage where CLIENTCODE=@kod3 order by usagedate desc;
-- drop table if 
/*
select CLIENTCODE, CLIENTID, CID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, TRAFFICTYPE
, ifnull(sum(MB_UL),0) as MB_UL, ifnull(sum(MB_DL),0) as MB_DL, (ifnull(sum(MB_UL),0) + ifnull(sum(MB_DL),0)) as MB_TOTAL
from 
(
	select a.*
	, case when a.USAGEDIRECTION='O' then MB_USED end as MB_UL
	, case when a.USAGEDIRECTION='I' then MB_USED end as MB_DL

	from 
	(
		select CLIENTCODE, CLIENTID, CID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, (select name from rcbill.rcb_traffictypes where TRAFFICID=TRAFFICTYPE) as TRAFFICTYPE, USAGEDIRECTION, SUM(MB_USED) as MB_USED from rcbill.rcb_ipusage
		-- where CLIENTCODE=@kod3
		group by CLIENTCODE, CLIENTID, CID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, TRAFFICTYPE, USAGEDIRECTION
	) a
) a 
group by CLIENTCODE, CLIENTID, CID, CLIENTNAME, CONTRACTCODE, CLIENTIP, PROCESSEDCLIENTIP, USAGEDATE, TRAFFICTYPE
;
  */  


SELECT a.*


, case when a.SUBTO>date(SUBDATE(NOW(),1)) then round( ( TIMESTAMPDIFF(MONTH, date(SUBDATE(NOW(),1)) , a.SUBTO) +
  DATEDIFF(
	a.SUBTO,
	date(SUBDATE(NOW(),1))  + INTERVAL
	  TIMESTAMPDIFF(MONTH, date(SUBDATE(NOW(),1)) , a.SUBTO)
	MONTH
  ) /
  DATEDIFF(
	date(SUBDATE(NOW(),1))  + INTERVAL
	  TIMESTAMPDIFF(MONTH, date(SUBDATE(NOW(),1)) , a.SUBTO) + 1
	MONTH,
	date(SUBDATE(NOW(),1))  + INTERVAL
	  TIMESTAMPDIFF(MONTH, date(SUBDATE(NOW(),1)) , a.SUBTO)
	MONTH
  ) ),0) end as REMAININGSUBPERIOD  

, ((a.PACKAGEQUOTA_GB)*CEIL(a.SUBPERIOD)) as TOTAL_PACKAGEQUOTA_GB
, case when a.SERVICESTATUS='Active' then ((a.PACKAGEQUOTA_GB)*CEIL(a.SUBPERIOD) - a.TOTAL_USAGE_GB) 
	else 0 end as BALANCE_GB
from 
(
		select 
			a.SERVICEINSTANCENUMBER
			, a.PACKAGENAME
			, case when a.PACKAGENAME='STARTER' then 1
					when a.PACKAGENAME='VALUE' then 3
					when a.PACKAGENAME='ELITE' then 20
					when a.PACKAGENAME='EXTREME' then 40
					when a.PACKAGENAME='EXTREME PLUS' then 80
					when a.PACKAGENAME='PERFORMANCE' then 150
					when a.PACKAGENAME='PERFORMANCE PLUS' then 300
					end as PACKAGEQUOTA_GB
					
			
			, a.SUBFROM
			, a.SUBTO
            , a.SUBPERIOD
            /*
			,  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO) +
			  DATEDIFF(
				a.SUBTO,
				a.SUBFROM + INTERVAL
				  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO)
				MONTH
			  ) /
			  DATEDIFF(
				a.SUBFROM + INTERVAL
				  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO) + 1
				MONTH,
				a.SUBFROM + INTERVAL
				  TIMESTAMPDIFF(MONTH, a.SUBFROM, a.SUBTO)
				MONTH
			  ) as SUBPERIOD  
              
              */
			, a.CUSTOMERACCOUNTNUMBER
			, a.BILLINGACCOUNTNUMBER
			, a.SERVICEACCOUNTNUMBER
			, a.SERVICEINSTANCEIDENTIFIER
			, a.SERVICESTATUS
			, a.CPE_TYPE
			, a.PACKAGEAMOUNT
			, a.LASTACTION
			, a.clientcode
			, a.contractcode
			, a.client_id
			, a.contract_id
			
			, max(a.LASTUSAGEDATE) as LASTUSAGEDATE
			, ifnull(sum(a.MB_TOTAL_USAGE),0) as TOTAL_USAGE_PREADDON_MB
			, max(a.LAST_ADD_ON_DATE) as LAST_ADD_ON_DATE
			, ifnull(sum(a.ADD_ON_TOTAL),0) as ADD_ON_TOTAL_MB
			
			, (ifnull(sum(a.MB_TOTAL_USAGE),0) + ifnull(sum(a.ADD_ON_TOTAL),0)) as TOTAL_USAGE_MB
			, (ifnull(sum(a.MB_TOTAL_USAGE),0) + ifnull(sum(a.ADD_ON_TOTAL),0))/1024 as TOTAL_USAGE_GB
			from 
			(
				select 
				a.SERVICEINSTANCENUMBER
				, a.PACKAGENAME
				, a.SUBFROM
				, a.SUBTO
                , a.SUBPERIOD
				, a.CUSTOMERACCOUNTNUMBER
				, a.BILLINGACCOUNTNUMBER
				, a.SERVICEACCOUNTNUMBER
				, a.SERVICEINSTANCEIDENTIFIER
				, a.SERVICESTATUS
				, a.CPE_TYPE
				, a.PACKAGEAMOUNT
				, a.LASTACTION
				, a.clientcode
				, a.contractcode
				, a.client_id
				, a.contract_id
				, a.PROCESSEDCLIENTIP
				, a.TRAFFICTYPE
				-- , max(a.USAGEDATE) as LASTUSAGEDATE
				, sum(a.MB_UL) as MB_UL
				, sum(a.MB_DL) as MB_DL
				-- , sum(a.MB_TOTAL) as MB_TOTAL_USAGE
				-- , sum(a.GB_TOTAL) as GB_TOTAL_USAGE
				, case when a.PROCESSEDCLIENTIP = '0.0.0.0' then max(a.USAGEDATE) end as LAST_ADD_ON_DATE
				, case when a.PROCESSEDCLIENTIP = '0.0.0.0' then sum(a.MB_DL) end as ADD_ON_TOTAL
				, case when a.PROCESSEDCLIENTIP <> '0.0.0.0' then max(a.USAGEDATE) end as LASTUSAGEDATE
				, case when a.PROCESSEDCLIENTIP <> '0.0.0.0' then sum(a.MB_TOTAL) end as MB_TOTAL_USAGE
				from 
				(
						select 
						a.*
						, '' as `|`
						-- , b.*
						, b.PROCESSEDCLIENTIP
						, b.TRAFFICTYPE
						
						, b.MB_UL
						, b.MB_DL
						, b.MB_TOTAL
						, ((b.MB_TOTAL)/1024) as GB_TOTAL
						, b.USAGEDATE

						from 
						(

								select 
								a.SERVICEINSTANCENUMBER, a.PACKAGENAME
								, a.SUBFROM
								, a.SUBTO
                                , a.SUBPERIOD
								-- , if(ifnull(date(a.LASTSUBSTARTDATE),date(a.LASTINVFROMDATE))>a.CURSUBSTARTDATE,a.CURSUBSTARTDATE,ifnull(date(a.LASTSUBSTARTDATE),date(a.LASTINVFROMDATE))) as SUB_FROM
								-- , if(ifnull(date(a.LASTSUBENDDATE),date(a.LASTINVTODATE))>a.CURSUBENDDATE,a.CURSUBENDDATE,ifnull(date(a.LASTSUBENDDATE),date(a.LASTINVTODATE))) as SUB_TO
								-- , ifnull(date(a.LASTSUBENDDATE),date(a.LASTINVTODATE)) as SUBTO
								, a.CUSTOMERACCOUNTNUMBER
								, a.BILLINGACCOUNTNUMBER
								, a.SERVICEACCOUNTNUMBER
								, a.SERVICEINSTANCEIDENTIFIER
								, a.SERVICESTATUS
								, a.CPE_TYPE
								, a.PACKAGEAMOUNT
								, a.LASTACTION
								, a.clientcode
								, a.contractcode
								, a.client_id
								, a.contract_id

								from 
								(

										select 

										--  a.* 
										-- , '' as `SEP1`
										-- , b.*



										a.*
										, b.CUSTOMERACCOUNTNUMBER
										, b.BILLINGACCOUNTNUMBER
										, b.SERVICEACCOUNTNUMBER
										, b.SERVICEINSTANCEIDENTIFIER
										, b.SERVICESTATUS
										, b.PACKAGEAMOUNT
										, b.CPE_TYPE
										, b.LASTACTION
										, b.clientcode
										, b.contractcode
										, b.CLIENT_ID
										, b.CONTRACT_ID



										from rcbill_extract.IV_ADDON a
										left join 
										rcbill_extract.IV_SERVICEINSTANCE b 
										on 
										a.SERVICEINSTANCENUMBER=b.SERVICEINSTANCENUMBER

										-- left join 
										-- rcbill_extract.IV_BILLINGACCOUNT c
										-- on b.BILLINGACCOUNTNUMBER=c.BILLINGACCOUNTNUMBER
										where 0=0
										and (b.CPE_TYPE like ('%CAPPED%') or b.CPE_TYPE like ('%PREPAID%'))
										
										-- and b.SERVICESTATUS='Active'
										-- and b.client_id=718650 -- nelson lalande
										-- and b.CLIENT_ID=715432 -- russian embassy
										-- and b.CLIENT_ID=723711
										-- and b.CLIENT_ID=721030
										-- and b.clientcode='I8002'
										-- and b.clientcode='I7571'
										-- and b.clientcode='I6415' -- farouk baptist (PROBLEM ACCOUNT)
										-- and b.clientcode='I.000000852' -- Julianne Monique Marie
                                        -- and b.clientcode='I.000012979' -- Selma Lesperance Sey Police Bulk
                                        -- and b.clientcode='I.000008120' -- Four Seasons IPTV Housing - Block No 6 (PROBLEM)
                                        -- and b.clientcode='I.000003756'
                                        -- and b.clientcode='I.000009391' -- surman apartment
								) a 
						) a
						left join 
						rcbill.clientcontractipusage b
						on a.client_id=b.client_id and a.contract_id=b.contract_id and (b.usagedate>=a.subfrom and b.usagedate<=a.subto) and b.TRAFFICTYPE='Default'


				) a 
				group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
			) a 
			group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
) a
;

