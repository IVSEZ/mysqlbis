set @custid1 = 'CA_I.000012204'; -- intelvision tech support
set @custid1 = 'CA_I.000009758'; -- six senses


<<<<<<< HEAD
set @custid1 = 'CA_I22308'; -- 
set @custid2 = 'CA_I13400';
=======
set @custid1 = 'CA_I11081'; -- 
set @custid2 = 'CA_I11081';
>>>>>>> b6bb470ded8d16f2f8da8ab8452bba698b27c394

select * from rcbill_extract.IV_CUSTOMERACCOUNT where ACCOUNTNUMBER in (@custid1,@custid2)  order by ACCOUNTNUMBER;
select * from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2) order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2)  order by CUSTOMERACCOUNTNUMBER;
select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2);

select * from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2) and (SERVICEENDDATE is null or date(SERVICEENDDATE)>=now());


select * from rcbill_extract.IV_SERVICEINSTANCECHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2) );
select * from rcbill_extract.IV_INVENTORY where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2) );
select * from rcbill_extract.IV_ADDON where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2) );
select * from rcbill_extract.IV_ADDONCHARGE where SERVICEINSTANCENUMBER in (select SERVICEINSTANCENUMBER from rcbill_extract.IV_SERVICEINSTANCE where CUSTOMERACCOUNTNUMBER in (@custid1,@custid2) );


select * from rcbill_extract.IV_BILLSUMMARY where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_BILLDETAIL where CUSTOMERACCOUNTNUMBER in (@custid1) order by INVOICESUMMARYID desc;
select * from rcbill_extract.IV_PAYMENTHISTORY where CUSTOMERACCOUNTNUMBER in (@custid1) order by PAYMENTRECEIPTID desc;


select * from rcbill_extract.IV_NBD where CUSTOMERACCOUNTNUMBER in (@custid1) order by BILLINGACCOUNTNUMBER;
select * from rcbill_extract.IV_DISCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1) order by BILLINGACCOUNTNUMBER;
select * from rcbill_extract.IV_BALANCE where CUSTOMERACCOUNTNUMBER in (@custid1) order by SERVICEINSTANCENUMBER desc;

select * from rcbill_extract.CUSTOMERDEBT where REV_CUSTOMERACCOUNTNUMBER in (@custid1) ;

select * from rcbill_extract.IV_CREDITNOTE where BILLINGACCOUNTNUMBER in (select BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1));
select * from rcbill_extract.IV_DEBITNOTE where BILLINGACCOUNTNUMBER in (select BILLINGACCOUNTNUMBER from rcbill_extract.IV_BILLINGACCOUNT where CUSTOMERACCOUNTNUMBER in (@custid1));


select * from rcbill_extract.IV_SERVICEINSTANCE where (SERVICEENDDATE is null or date(SERVICEENDDATE)>=now());

select * from rcbill_extract.IV_INVENTORY where SERIALNUMBER='znts038e5867'
-- and (SERVICESTATUS='Active' or serviceinstancestatus='Active')
;


select DEVICE_ID, count(*) from rcbill_extract.IV_SERVICEINSTANCE where USERNAME is null
group by DEVICE_ID
order by 2 desc
;

/*
###
for every prt 13 there should be a prt00 present
*/

select * from rcbill_extract.IV_BILLDETAIL where PRODUCTTYPEID='PRT13';
select * from rcbill_extract.IV_BILLDETAIL where PRODUCTTYPEID='PRT00';


drop temporary table if exists rcbill_extract.billdetailprt13;
create temporary table rcbill_extract.billdetailprt13(index idxivbd1(INVOICESUMMARYID),index idxivbd2(PACKAGENAME))
(
	select BILLINGACCOUNTNUMBER, CUSTOMERACCOUNTNUMBER, INVOICESUMMARYID, INVOICEDETAILID, SERIALNUMBER, DEBITDOCUMENTNUMBER
    , NAME, RATE, ITEMCOUNT, SUBTOTAL, TAX, DISCOUNT, TOTALAMOUNT, PRODUCTTYPEID 
    , FROMDATE, TODATE, BILLDATE, PACKAGENAME
    from 
    rcbill_extract.IV_BILLDETAIL where PRODUCTTYPEID='PRT13'

)
;

drop temporary table if exists rcbill_extract.billdetailprt00;
create temporary table rcbill_extract.billdetailprt00(index idxivbd1(INVOICESUMMARYID_2),index idxivbd2(PACKAGENAME_2))
(
	select BILLINGACCOUNTNUMBER as BILLINGACCOUNTNUMBER_2, CUSTOMERACCOUNTNUMBER as CUSTOMERACCOUNTNUMBER_2, INVOICESUMMARYID as INVOICESUMMARYID_2, INVOICEDETAILID as INVOICEDETAILID_2, SERIALNUMBER as SERIALNUMBER_2, DEBITDOCUMENTNUMBER as DEBITDOCUMENTNUMBER_2, NAME as NAME_2
	, RATE as RATE_2, ITEMCOUNT as ITEMCOUNT_2, SUBTOTAL as SUBTOTAL_2, TAX as TAX_2, DISCOUNT as DISCOUNT_2, TOTALAMOUNT as TOTALAMOUNT_2
	, PRODUCTTYPEID as PRODUCTTYPEID_2 
    , FROMDATE as FROMDATE_2, TODATE as TODATE_2, BILLDATE as BILLDATE_2, PACKAGENAME as PACKAGENAME_2

    from rcbill_extract.IV_BILLDETAIL 
    where PRODUCTTYPEID='PRT00'

)
;

drop temporary table if exists rcbill_extract.billdetailprt00_13;
create temporary table rcbill_extract.billdetailprt00_13(index idxivbd1(CUSTOMERACCOUNTNUMBER),index idxivbd2(BILLINGACCOUNTNUMBER))
(
	select a.*, b.*
	from
	rcbill_extract.billdetailprt13 a 
	left join 
	rcbill_extract.billdetailprt00 b 
	on a.INVOICESUMMARYID=b.INVOICESUMMARYID_2
	and a.PACKAGENAME=b.PACKAGENAME_2
)
;



select * from  rcbill_extract.billdetailprt00_13 where BILLINGACCOUNTNUMBER_2 is null;

select DEBITDOCUMENTNUMBER, count(*) 
from  rcbill_extract.billdetailprt00_13 where BILLINGACCOUNTNUMBER_2 is null
group by DEBITDOCUMENTNUMBER
;


set @custid1 = 'CA_I.000012189';

select * from  rcbill_extract.billdetailprt00_13
where CUSTOMERACCOUNTNUMBER in (@custid1)
order by BILLDATE desc
;

select * from  rcbill_extract.IV_BILLDETAIL
where CUSTOMERACCOUNTNUMBER in (@custid1)
order by BILLDATE desc
;

select * from  rcbill_extract.IV_BILLSUMMARY
where CUSTOMERACCOUNTNUMBER in (@custid1)
order by BILLDATE desc
;

/*
INSERT INTO action_2_members (campaign_id, mobile, vote, vote_date)  
SELECT campaign_id, from_number, received_msg, date_received
  FROM `received_txts`
 WHERE `campaign_id` = '8'
*/
insert into 
rcbill_extract.IV_BILLDETAIL


select a.*, b.*
from
rcbill_extract.billdetailprt13 a 
left join 
rcbill_extract.billdetailprt00 b 
on a.INVOICESUMMARYID=b.INVOICESUMMARYID_2
and a.PACKAGENAME=b.PACKAGENAME_2

where a.CUSTOMERACCOUNTNUMBER in (@custid1)
;






select a.*, b.*
from
(
	select BILLINGACCOUNTNUMBER, CUSTOMERACCOUNTNUMBER, INVOICESUMMARYID, INVOICEDETAILID, SERIALNUMBER, DEBITDOCUMENTNUMBER
    , NAME, RATE, ITEMCOUNT, SUBTOTAL, TAX, DISCOUNT, TOTALAMOUNT, PRODUCTTYPEID 
    , FROMDATE, TODATE, BILLDATE, PACKAGENAME
    from 
    rcbill_extract.IV_BILLDETAIL where PRODUCTTYPEID='PRT13'
    and CUSTOMERACCOUNTNUMBER in (@custid1)
    -- limit 1000
) a 
left join 
(
	select INVOICESUMMARYID as INVOICESUMMARYID_2, INVOICEDETAILID as INVOICEDETAILID_2, SERIALNUMBER as SERIALNUMBER_2, DEBITDOCUMENTNUMBER as DEBITDOCUMENTNUMBER_2, NAME as NAME_2
	, RATE as RATE_2, ITEMCOUNT as ITEMCOUNT_2, SUBTOTAL as SUBTOTAL_2, TAX as TAX_2, DISCOUNT as DISCOUNT_2, TOTALAMOUNT as TOTALAMOUNT_2
	, PRODUCTTYPEID as PRODUCTTYPEID_2 
    , FROMDATE as FROMDATE_2, TODATE as TODATE_2, BILLDATE as BILLDATE_2, PACKAGENAME as PACKAGENAME_2

    from rcbill_extract.IV_BILLDETAIL 
    where PRODUCTTYPEID='PRT00'
    and CUSTOMERACCOUNTNUMBER in (@custid1)

) b 
on a.INVOICESUMMARYID=b.INVOICESUMMARYID_2
and a.PACKAGENAME=b.PACKAGENAME_2

;