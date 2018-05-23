select distinct(a.danno) as id_no, count(a.id) as contract_count, count(distinct(a.id)) as client_count
from rcb_tclients a 
inner join
clientcontracts b
on
a.kod=b.cl_clientcode
where 
b.contractcurrentstatus in ('ACTIVE')

group by a.danno
order by 2 desc;



-- example:
select * from rcb_tclients where 
-- DANNO in ('986-0567-1-1-10')
-- DANNO in ('986-1145-1-0-94')
-- DANNO in ('006-1071-7-1-51')
-- DANNO in ('005-0521-7-1-23')
-- DANNO in ('986-1145-1-0-94','975-0396-1-1-73','005-0521-7-1-23','979-0673-1-1-42','970-1077-1-1-41','986-0567-1-1-10')
order by danno;