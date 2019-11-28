/*

select paymentdate, externalref, SUBSTRING_INDEX(externalref,'/',-1) as refno, clientcode, clientname, sum(paymentamount) as paymentamount
from rcbill_my.onlinepayments
group by paymentdate, externalref, clientcode, clientname
;

select * from rcbill_my.cs_transactions;

select distinct applications from rcbill_my.cs_transactions;


select DATEANDTIME as CS_DATEANDTIME
, REQUESTID as CS_REQUESTID
, MERCHANTREFNO
, CLIENTCODE as CS_CLIENTCODE
, PAYMENTDATE as CS_PAYMENTDATE, LASTNAME as CS_LASTNAME, FIRSTNAME as CS_FIRSTNAME
, EMAILADDRESS as CS_EMAILADDRESS, PAYMENTAMOUNT as CS_PAYMENTAMOUNT, PAYMENTCURRENCY as CS_PAYMENTCURRENCY
, ACCOUNTSUFFIX as CS_ACCOUNTSUFFIX, APPLICATIONS as CS_APPLICATIONS, ACCOUNTTYPE as CS_ACCOUNTTYPE
, TRANSREFNO as CS_TRANSREFNO, AUTHCODE as CS_AUTHCODE
, BILLINGADDRESS1 as CS_BILLINGADDRESS1, BILLINGCITY as CS_BILLINGCITY, BILLINGSTATE as CS_BILLINGSTATE
, BILLINGPOSTALCODE as CS_BILLINGPOSTALCODE, BILLINGPHONENO as CS_BILLINGPHONENO
, BILLINGCOUNTRY as CS_BILLINGCOUNTRY
from rcbill_my.cs_transactions
;
*/


drop table if exists rcbill_my.cs_rc_onlinepayments;

create table rcbill_my.cs_rc_onlinepayments as 
#JOIN BOTH DATASETS
(
	SELECT a.*, b.*
	from 
	(
		select DATEANDTIME as CS_DATEANDTIME
		, REQUESTID as CS_REQUESTID
		, MERCHANTREFNO as CS_MERCHANTREFNO
		, CLIENTCODE as CS_CLIENTCODE
		, PAYMENTDATE as CS_PAYMENTDATE, LASTNAME as CS_LASTNAME, FIRSTNAME as CS_FIRSTNAME
		, EMAILADDRESS as CS_EMAILADDRESS, PAYMENTAMOUNT as CS_PAYMENTAMOUNT, PAYMENTCURRENCY as CS_PAYMENTCURRENCY
		, ACCOUNTSUFFIX as CS_ACCOUNTSUFFIX, APPLICATIONS as CS_APPLICATIONS
        , case APPLICATIONS
			when 'Credit Card Authorization(success),Credit Card Settlement(success)' then 'SUCCESS'
			when 'Credit Card Authorization(failure),Credit Card Settlement(warning)' then 'FAILURE'
			when 'Credit Card Authorization(warning),Credit Card Settlement(warning)' then 'WARNING'
		  end as CS_RESULT
        , ACCOUNTTYPE as CS_ACCOUNTTYPE
		, TRANSREFNO as CS_TRANSREFNO, AUTHCODE as CS_AUTHCODE
		, BILLINGADDRESS1 as CS_BILLINGADDRESS1, BILLINGCITY as CS_BILLINGCITY, BILLINGSTATE as CS_BILLINGSTATE
		, BILLINGPOSTALCODE as CS_BILLINGPOSTALCODE, BILLINGPHONENO as CS_BILLINGPHONENO
		, BILLINGCOUNTRY as CS_BILLINGCOUNTRY
		from rcbill_my.cs_transactions
	) a 
	left join 
	(
		select paymentdate as RC_PAYMENTDATE, externalref AS RC_EXTERNALREF
		, SUBSTRING_INDEX(externalref,'/',-1) AS RC_REFNO
		, clientcode AS RC_CLIENTCODE, clientname AS RC_CLIENTNAME, sum(paymentamount) as RC_PAYMENTAMOUNT
		from rcbill_my.onlinepayments
		group by 1,2,3,4
	) b
	on a.CS_REQUESTID=b.RC_REFNO and a.CS_CLIENTCODE=b.RC_CLIENTCODE
	-- where date(a.CS_PAYMENTDATE)='2019-08-20'
)
union
(
	SELECT a.*, b.*
	from 
	(
		select DATEANDTIME as CS_DATEANDTIME
		, REQUESTID as CS_REQUESTID
		, MERCHANTREFNO as CS_MERCHANTREFNO
		, CLIENTCODE as CS_CLIENTCODE
		, PAYMENTDATE as CS_PAYMENTDATE, LASTNAME as CS_LASTNAME, FIRSTNAME as CS_FIRSTNAME
		, EMAILADDRESS as CS_EMAILADDRESS, PAYMENTAMOUNT as CS_PAYMENTAMOUNT, PAYMENTCURRENCY as CS_PAYMENTCURRENCY
		, ACCOUNTSUFFIX as CS_ACCOUNTSUFFIX, APPLICATIONS as CS_APPLICATIONS
        , case APPLICATIONS
			when 'Credit Card Authorization(success),Credit Card Settlement(success)' then 'SUCCESS'
			when 'Credit Card Authorization(failure),Credit Card Settlement(warning)' then 'FAILURE'
			when 'Credit Card Authorization(warning),Credit Card Settlement(warning)' then 'WARNING'
		  end as CS_RESULT        
        , ACCOUNTTYPE as CS_ACCOUNTTYPE
		, TRANSREFNO as CS_TRANSREFNO, AUTHCODE as CS_AUTHCODE
		, BILLINGADDRESS1 as CS_BILLINGADDRESS1, BILLINGCITY as CS_BILLINGCITY, BILLINGSTATE as CS_BILLINGSTATE
		, BILLINGPOSTALCODE as CS_BILLINGPOSTALCODE, BILLINGPHONENO as CS_BILLINGPHONENO
		, BILLINGCOUNTRY as CS_BILLINGCOUNTRY
		from rcbill_my.cs_transactions
	) a 
	right join 
	(
		select paymentdate as RC_PAYMENTDATE, externalref AS RC_EXTERNALREF
		, SUBSTRING_INDEX(externalref,'/',-1) AS RC_REFNO
		, clientcode AS RC_CLIENTCODE, clientname AS RC_CLIENTNAME, sum(paymentamount) as RC_PAYMENTAMOUNT
		from rcbill_my.onlinepayments
		group by 1,2,3,4
	) b
	on a.CS_REQUESTID=b.RC_REFNO and a.CS_CLIENTCODE=b.RC_CLIENTCODE

)

;

SELECT CS_RESULT, COUNT(*) FROM rcbill_my.cs_rc_onlinepayments
GROUP BY CS_RESULT
;

#TO FIND WHICH PAYMENTS CAME THROUGH CYBERSOURCE BUT NOT RECORDED ON RCBOSS
select * from rcbill_my.cs_rc_onlinepayments where cs_result='SUCCESS' and rc_refno is null order by CS_DATEANDTIME desc;

#TO FIND WHICH PAYMENTS DID NOT COME THROUGH CYBERSOURCE BUT RECORDED ON RCBOSS
select * from rcbill_my.cs_rc_onlinepayments where
date(CS_DATEANDTIME)>='2019-03-01'
and cs_result is null and rc_refno is not null;

#TO FIND WHICH PAYMENTS WERE REJECTED BY CYBERSOURCE BUT RECORDED ON RCBOSS
select * from rcbill_my.cs_rc_onlinepayments where
date(CS_DATEANDTIME)>='2019-03-01'
and cs_result NOT IN ('SUCCESS') and rc_refno is not null;
