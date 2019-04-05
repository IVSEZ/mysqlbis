select * from rcbill.rcb_clientparcels;


select count(*) from rcbill_my.customercontractactivity;
select * from rcbill_my.customercontractactivity limit 100;

drop table if exists rcbill_my.rep_cca_summary;
create table rcbill_my.rep_cca_summary
as
(
select period, package, count(clientcode) as clients, count(distinct clientcode) as d_clients
from rcbill_my.customercontractactivity
group by period, package
order by period
)
;


create index IDXccas1 on rcbill_my.rep_cca_summary (period);
create index IDXccas2 on rcbill_my.rep_cca_summary (package);

select * from rcbill_my.rep_cca_summary;