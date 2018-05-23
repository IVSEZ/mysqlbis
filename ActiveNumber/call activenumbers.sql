-- CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActiveNumber`(IN pdday int, IN pdmth int, IN pdyr int, IN decom varchar(1), IN rpt varchar(1))

use rcbill_my;
/*
call sp_ActiveNumber(07,07,2016,'','');

call sp_ActiveNumber(07,01,2017,'','');
call sp_ActiveNumber(08,01,2017,'','');
call sp_ActiveNumber(09,01,2017,'','');
call sp_ActiveNumber(10,01,2017,'','');
call sp_ActiveNumber(11,01,2017,'','');
call sp_ActiveNumber(12,01,2017,'','');
call sp_ActiveNumber(13,01,2017,'','');
call sp_ActiveNumber(14,01,2017,'','');
call sp_ActiveNumber(15,01,2017,'','');
call sp_ActiveNumber(16,01,2017,'','');
call sp_ActiveNumber(17,01,2017,'','');
call sp_ActiveNumber(18,01,2017,'','');
call sp_ActiveNumber(19,01,2017,'','');
call sp_ActiveNumber(20,01,2017,'','');
call sp_ActiveNumber(21,01,2017,'','');
call sp_ActiveNumber(22,01,2017,'','');
call sp_ActiveNumber(23,01,2017,'','');
call sp_ActiveNumber(24,01,2017,'','');
call sp_ActiveNumber(25,01,2017,'','');
call sp_ActiveNumber(26,01,2017,'','');
call sp_ActiveNumber(27,01,2017,'','');
call sp_ActiveNumber(28,01,2017,'','');
call sp_ActiveNumber(29,01,2017,'','');
call sp_ActiveNumber(30,01,2017,'','');
call sp_ActiveNumber(31,01,2017,'','');

call sp_ActiveNumber(01,02,2017,'','');
call sp_ActiveNumber(02,02,2017,'','');
call sp_ActiveNumber(03,02,2017,'','');
call sp_ActiveNumber(04,02,2017,'','');
call sp_ActiveNumber(05,02,2017,'','');
call sp_ActiveNumber(06,02,2017,'','');
call sp_ActiveNumber(07,02,2017,'','');
call sp_ActiveNumber(08,02,2017,'','');
call sp_ActiveNumber(09,02,2017,'','');
call sp_ActiveNumber(10,02,2017,'','');
call sp_ActiveNumber(11,02,2017,'','');
call sp_ActiveNumber(12,02,2017,'','');
call sp_ActiveNumber(13,02,2017,'','');
call sp_ActiveNumber(14,02,2017,'','');
call sp_ActiveNumber(15,02,2017,'','');
call sp_ActiveNumber(16,02,2017,'','');
call sp_ActiveNumber(17,02,2017,'','');
call sp_ActiveNumber(18,02,2017,'','');
call sp_ActiveNumber(19,02,2017,'','');
call sp_ActiveNumber(20,02,2017,'','');
call sp_ActiveNumber(21,02,2017,'','');
call sp_ActiveNumber(22,02,2017,'','');
call sp_ActiveNumber(23,02,2017,'','');
call sp_ActiveNumber(24,02,2017,'','');
call sp_ActiveNumber(25,02,2017,'','');
call sp_ActiveNumber(26,02,2017,'','');
call sp_ActiveNumber(27,02,2017,'','');
call sp_ActiveNumber(28,02,2017,'','');
call sp_ActiveNumber(01,03,2017,'','');
call sp_ActiveNumber(02,03,2017,'','');
call sp_ActiveNumber(03,03,2017,'','');
call sp_ActiveNumber(04,03,2017,'','');
call sp_ActiveNumber(05,03,2017,'','');
*/
-- call sp_ActiveNumber(05,05,2017,'','');
-- call sp_ActiveNumber(06,05,2017,'','');
-- call sp_ActiveNumber(07,05,2017,'','');
-- call sp_ActiveNumber(19,05,2017,'','');
-- call sp_ActiveNumber(27,05,2017,'','');

call sp_ActiveNumber2();


-- call sp_ActiveNumber(24,12,2017,'','');
-- call sp_ActiveNumber(25,12,2017,'','');

call sp_ActiveNumber(26,12,2017,'','');


-- call sp_ActiveNumber(26,11,2017,'','');

-- call sp_ActiveNumber(22,10,2017,'','');
-- call sp_ActiveNumber(24,08,2017,'','');
-- call sp_ActiveNumber(25,08,2017,'','');
-- call sp_ActiveNumber(26,08,2017,'','');
-- call sp_ActiveNumber(27,08,2017,'','');
  
select * from rcbill_my.anreport where period=@rundate and decommissioned='N' and reported='Y';

select * from rcbill_my.anreport where servicetype is null;

-- explain

 select servicetype, sum(open_s) from rcbill_my.anreport where period=@rundate and decommissioned='N' and reported='Y' 
 and package in ('Indian')
 group by servicetype
 ;
 
 select servicetype, sum(open_s) from rcbill_my.anreport where period=@rundate and decommissioned='N' and reported='Y' 
 and package in ('Indian Corporate')
 group by servicetype
 ;
 
 
 select * from rcbill_my.anreport where package in ('Extravagance') and servicesubcategory in ('HFC');
 
-- explain 
 select * from rcbill_my.anreport where package = 'Extravagance' and servicesubcategory = 'HFC';

/*
select * from activenumber where period='2017-05-01' and reported is null;

select distinct period from activenumber where  reported is null;
delete from activenumber where period='2017-05-26';

select * from activenumber where reported is null;

select period, count(*) from activenumber
group by period
order by period desc;

update activenumber
set 
servicetypeold1='Test4',
servicetype='Test4'
where
servicetypeold='Test4::=Test4'
;

update activenumber
set 
reported='N'
where
servicetypeold='Test4::=Test4'
;

update activenumber
set 
reported='Y'
where
servicetypeold='Voice 500::=Voice 500'
;




update activenumber
set 
reported='Y'
where
servicetypeold='Variety::=Variety'
;


delete from activenumber where period='2017-03-13';



select distinct servicetypeold, servicetype from activenumber where reported is null;


select period, periodday, periodmth, periodyear, servicecategory, sum(open) as activecount from activenumber 
where
servicecategory='Internet'
and  
reported='Y'
and 
decommissioned='N'
group by period, periodday, periodmth, periodyear, servicecategory
order by period, periodday, periodmth, periodyear, servicecategory
;
select * from activenumber limit 100;

*/