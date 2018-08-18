
set @startdate = '2018-07-01';
set @enddate = '2018-07-31';


select * from rcbill_my.salestoactive 
where o_orderday>=@startdate and o_orderday<=@enddate;