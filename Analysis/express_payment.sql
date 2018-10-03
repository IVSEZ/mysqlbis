select * from rcbill.rcb_casa where clid=729084;
select * from rcbill.rcb_casa where clid=728336;

select * from rcbill.rcb_services where id=32;

select * from rcbill.rcb_casa where paytype=-32 and year(paydate)=2018
and money in (250,500,1000)
;


select * from rcbill.rcb_casa where paytype=-32 and year(paydate)=2018
and money in (250)
;

select * from rcbill.rcb_casa where paytype=-32 and year(paydate)=2018
and money in (500)
;