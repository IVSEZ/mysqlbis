#### VOUCHER customers

select * from  rcbill_my.clientticketjourney 
where 0=0 
-- and commentuser in ('Rahul Walavalkar') 
and (trim(upper(comment)) REGEXP 'VOUCHER')
order by commentdate desc
;

select clientcode, clientname, contractcode, month(OPENDATE) as OPENMONTH, year(OPENDATE) as OPENYEAR, count(distinct ticketid) as d_tickets, count(distinct clientcode) as d_clients  from  rcbill_my.clientticketjourney 
where 0=0 
-- and commentuser in ('Rahul Walavalkar') 
and (trim(upper(comment)) REGEXP 'VOUCHER')

group by 1,2,3,4,5
order by 7 desc

;