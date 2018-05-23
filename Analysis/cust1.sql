/*
Mitchell Maimee
2597280
2796387
*/

select * from rcbill_my.dailycalls
where 
callnumber in 
(
2597280,
2796387,
4413308,
2775132
)
order by calldate desc
;


select * from rcbill_my.dailycalls
where date(calldate)='2017-06-04'
;


#anil valabhji
select * from rcbill_my.dailycalls
where
callnumber in 
(
4434388,
4434389
)
;