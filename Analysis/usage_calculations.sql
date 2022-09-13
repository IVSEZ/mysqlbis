-- select distinct TRAFFICTYPE from rcbill.clientcontractipusage;



select USAGEDATE, PACKAGE

, sum(CLIENTS) as CLIENTS
, sum(CONTRACTS) as CONTRACTS
, sum(RECORDS) as RECORDS

##MB TOTAL
, sum(MB_UL_DEFAULT) as MB_UL_DEFAULT
, sum(MB_DL_DEFAULT) as MB_DL_DEFAULT
, sum(MB_TOTAL_DEFAULT) as MB_TOTAL_DEFAULT

, sum(MB_UL_FREE) as MB_UL_FREE
, sum(MB_DL_FREE) as MB_DL_FREE
, sum(MB_TOTAL_FREE) as MB_TOTAL_FREE

, sum(MB_UL_LOCAL) as MB_UL_LOCAL
, sum(MB_DL_LOCAL) as MB_DL_LOCAL
, sum(MB_TOTAL_LOCAL) as MB_TOTAL_LOCAL

, sum(MB_UL_DEFAULTEX) as MB_UL_DEFAULTEX
, sum(MB_DL_DEFAULTEX) as MB_DL_DEFAULTEX
, sum(MB_TOTAL_DEFAULTEX) as MB_TOTAL_DEFAULTEX

, sum(MB_UL_TEMP) as MB_UL_TEMP
, sum(MB_DL_TEMP) as MB_DL_TEMP
, sum(MB_TOTAL_TEMP) as MB_TOTAL_TEMP

##GB TOTAL	
, ifnull((sum(MB_UL_DEFAULT))/1024,0) as GB_UL_DEFAULT
, ifnull((sum(MB_DL_DEFAULT))/1024,0) as GB_DL_DEFAULT
, ifnull((sum(MB_TOTAL_DEFAULT))/1024,0) as GB_TOTAL_DEFAULT

, ifnull((sum(MB_UL_FREE))/1024,0) as GB_UL_FREE
, ifnull((sum(MB_DL_FREE))/1024,0) as GB_DL_FREE
, ifnull((sum(MB_TOTAL_FREE))/1024,0) as GB_TOTAL_FREE

, ifnull((sum(MB_UL_LOCAL))/1024,0) as GB_UL_LOCAL
, ifnull((sum(MB_DL_LOCAL))/1024,0) as GB_DL_LOCAL
, ifnull((sum(MB_TOTAL_LOCAL))/1024,0) as GB_TOTAL_LOCAL

, ifnull((sum(MB_UL_DEFAULTEX))/1024,0) as GB_UL_DEFAULTEX
, ifnull((sum(MB_DL_DEFAULTEX))/1024,0) as GB_DL_DEFAULTEX
, ifnull((sum(MB_TOTAL_DEFAULTEX))/1024,0) as GB_TOTAL_DEFAULTEX

, ifnull((sum(MB_UL_TEMP))/1024,0) as GB_UL_TEMP
, ifnull((sum(MB_DL_TEMP))/1024,0) as GB_DL_TEMP
, ifnull((sum(MB_TOTAL_TEMP))/1024,0) as GB_TOTAL_TEMP



from 
(
	select USAGEDATE, upper(PACKAGE) as PACKAGE
    
		, count(distinct clientcode) as CLIENTS
		, count(distinct contractcode) as CONTRACTS
		, count(*) as RECORDS
		/*
			Default
			Free
			Local
			Default-Ex
			temporary_speed
        */
		, case when upper(TRAFFICTYPE)='DEFAULT' then ifnull(round(sum(MB_UL),2),0) end as MB_UL_DEFAULT
		, case when upper(TRAFFICTYPE)='DEFAULT' then ifnull(round(sum(MB_DL),2),0) end as MB_DL_DEFAULT
		, case when upper(TRAFFICTYPE)='DEFAULT' then ifnull(round(sum(MB_TOTAL),2),0) end as MB_TOTAL_DEFAULT

		, case when upper(TRAFFICTYPE)='FREE' then ifnull(round(sum(MB_UL),2),0) end as MB_UL_FREE
		, case when upper(TRAFFICTYPE)='FREE' then ifnull(round(sum(MB_DL),2),0) end as MB_DL_FREE
		, case when upper(TRAFFICTYPE)='FREE' then ifnull(round(sum(MB_TOTAL),2),0) end as MB_TOTAL_FREE

		, case when upper(TRAFFICTYPE)='LOCAL' then ifnull(round(sum(MB_UL),2),0) end as MB_UL_LOCAL
		, case when upper(TRAFFICTYPE)='LOCAL' then ifnull(round(sum(MB_DL),2),0) end as MB_DL_LOCAL
		, case when upper(TRAFFICTYPE)='LOCAL' then ifnull(round(sum(MB_TOTAL),2),0) end as MB_TOTAL_LOCAL

		, case when upper(TRAFFICTYPE)='DEFAULT-EX' then ifnull(round(sum(MB_UL),2),0) end as MB_UL_DEFAULTEX
		, case when upper(TRAFFICTYPE)='DEFAULT-EX' then ifnull(round(sum(MB_DL),2),0) end as MB_DL_DEFAULTEX
		, case when upper(TRAFFICTYPE)='DEFAULT-EX' then ifnull(round(sum(MB_TOTAL),2),0) end as MB_TOTAL_DEFAULTEX

		, case when upper(TRAFFICTYPE)='TEMPORARY_SPEED' then ifnull(round(sum(MB_UL),2),0) end as MB_UL_TEMP
		, case when upper(TRAFFICTYPE)='TEMPORARY_SPEED' then ifnull(round(sum(MB_DL),2),0) end as MB_DL_TEMP
		, case when upper(TRAFFICTYPE)='TEMPORARY_SPEED' then ifnull(round(sum(MB_TOTAL),2),0) end as MB_TOTAL_TEMP

		-- , upper(TRAFFICTYPE) as TRAFFICTYPE
		-- , round(sum(MB_UL),2) as MB_UL, round(sum(MB_DL),2) as MB_DL, round(sum(MB_TOTAL),2) as MB_TOTAL 
		-- , round((sum(MB_UL)/1024),2) as GB_UL, round((sum(MB_DL)/1024),2) as GB_DL, round((sum(MB_TOTAL)/1024),2) as GB_TOTAL 

	from rcbill.clientcontractipusage -- where year(USAGEDATE)=2022 -- and month(USAGEDATE)=8
	group by USAGEDATE,PACKAGE, TRAFFICTYPE
	order by 1 desc
) a 

group by USAGEDATE,PACKAGE
order by 1 desc
;