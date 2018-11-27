use rcbill_my;

-- set @reportdate='2018-11-25';
-- SET @rundate='2018-11-25';

drop table if exists rcbill_my.rep_custconsolidated;
create table rcbill_my.rep_custconsolidated as
(


	select 
	`reportdate`,
	`clientcode`,
	`currentdebt`,
	`isaccountactive`,
	`accountactivitystage`,
	`clientname`,
	`clientclass`,
	`services`,
	`activecontracts`,
	`activesubscriptions`,
	`clientaddress`,
	`clientlocation`,
	`network`,
	`clean_connection_type`,
	`clean_mxk_name`,
	`clean_mxk_interface`,
	`clean_hfc_node`,
	`clean_hfc_nodename`,
	`firstactivedate`,
	`lastactivedate`,
	`dayssincelastactive`,
	`firstcontractdate`,
	`firstinvoicedate`,
	`firstpaymentdate`,
	`lastinvoicedate`,
	`lastpaidamount`,
	`lastpaymentdate`,
	`totalpayments`,
	`totalpaymentamount`,
	`201801`,
	`201802`,
	`201803`,
	`201804`,
	`201805`,
	`201806`,
	`201807`,
	`201808`,
	`201809`,
	`201810`,
	`201811`,
	`201812`,
	`totalpayments2018`,
	`totalpaymentamount2018`,
	`clientarea`,
	`clientemail`,
	`clientnin`,
	`clientpassport`,
	`clientphone`,
	`combined_clientcode`,
	`cl_clientcode`,
	`b_clientcode`,
	`connection_type`,
	`mxk_name`,
	`mxk_interface`,
	`hfc_node`,
	`nodename`,
	`contractinfo`
	from 
	(

	select
	b.* ,
	-- a.clientcode,
	a.AccountActivityStage,
	a.activesubscriptions,
	a.clientaddress,
	a.clientarea,

	a.clientemail,
	a.clientnin,
	a.clientpassport,
	a.clientphone,
	a.dayssincelastactive,
	a.firstcontractdate,
	a.firstinvoicedate,
	a.firstpaymentdate,
	a.IsAccountActive,
	a.lastinvoicedate,
	a.lastpaidamount,
	a.lastpaymentdate,
	a.totalpayments,
	c.contractinfo
	from 
	rcbill_my.rep_allcust a 
	inner join 
	rcbill_my.rep_cust_cont_payment_cmts_mxk b
	on 
	a.clientcode=b.clientcode

	-- where 
	/*
	(
		a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%'  or a.clientaddress like '%glaci%'
	or
		a.clientaddress like '%beau vallon%' or a.clientaddress like '%beauvallon%' or a.clientaddress like '%beauvalon%' 
		or a.clientaddress like '%beauvalon%' or a.clientaddress like '%beau  vallon%' or a.clientaddress like '%beau-vallon%'
		or a.clientaddress like '%beau  valon%'
	or
		a.clientaddress like '%belombre%' or a.clientaddress like '%bel ombre%' or a.clientaddress like '%belom%'  or a.clientaddress like '%belomb%'  or a.clientaddress like '%belomber%'
	or
		a.clientaddress like '%maca%' or a.clientaddress like '%mach%'
	)
	and
	*/ 
	-- a.firstactivedate is not null
	-- and a.clientcode='I.000011750'

	inner join 
	(
		select client_code as clientcode, coalesce(group_concat((CONTRACT_INFO) separator '|')) as contractinfo
		from
		(
		select CLIENT_CODE
		, concat(coalesce(CONTRACT_CODE,''),'~',coalesce(SERVICE_TYPE,''),'~',coalesce(FSAN,''),'~',coalesce(MAC,''),'~',coalesce(UID,'')) as CONTRACT_INFO 
		from rcbill_my.rep_clientcontractdevices 
		-- where CLIENT_CODE='I.000011750'

		) a 
		group by 1
	) c
	on a.clientcode=c.clientcode
	) a
)
-- where clientcode='I6816'
;


select * from rcbill_my.rep_custconsolidated;
select * from rcbill_my.clientstats;

select * from rcbill_my.salestoactive where o_clientcode='I19750';


/*
SELECT col1, col2,
       CONCAT(LEAST(col1, col2), '-', 
              GREATEST(col1, col2)) concat_result
  FROM table1
 ORDER BY concat_result
 ;
 
 SELECT DISTINCT 
       CONCAT(LEAST(col1, col2), '-', 
              GREATEST(col1, col2)) concat_result
  FROM table1
 ORDER BY concat_result
 ;
 

*/