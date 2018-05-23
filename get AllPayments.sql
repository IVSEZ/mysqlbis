SELECT 
clientname,
clientcode,
service,
servicetype,
count(paymentid) as paymentcount,
sum(paymentamount) as totpayment
FROM rcbill_my.allpayments

-- where servicetype='INTELENOVELA'
where clientname='aaron bonnelame'
group by

clientname,
clientcode,
service,
servicetype

order by
clientname
;