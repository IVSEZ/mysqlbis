use rcbill_my;

set @clcode = 'I.000011750';
set @clcode = 'I.000022635'; -- nan cui
set @clcode = 'I.000022603'; -- thaver

set @clcode = 'I.000018301';


select * from rcbill_my.customercontractsnapshot where clientcode=@clcode;

select a.*, datediff(a.lastdate, a.firstdate)+1 from 
(
	select clientcode, servicecategory, servicecategory2, network, min(firstcontractdate) as firstdate, max(lastcontractdate) as lastdate, sum(DurationForContract) as totalcontractdays, sum(ActiveDaysForContract) as totalactivedays
	, case when max(lastcontractdate)<> reportdate then 'NOT ACTIVE'
	else 'ACTIVE' end as 'activestatus'
	 from rcbill_my.customercontractsnapshot where clientcode=@clcode
     and PackageType='STANDALONE'
	group by 1,2,3,4
) a
;



