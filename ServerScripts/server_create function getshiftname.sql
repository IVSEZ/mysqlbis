/*
select max(servicesubcategory) from rcbill_my.dailyactivenumber
where
period=@rundate
and 
CONTRACTCODE='I237948.1'
;
*/

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetShiftName`(calldate datetime) RETURNS varchar(45) CHARSET utf8
BEGIN
    DECLARE shift VARCHAR(45);

	set shift = (select
						case
						   when hour(calldate)>=0 and hour(calldate)<6 then 'NOC'
						   when hour(calldate)>=6 and hour(calldate)<8 then 'REMOTE'
						   when hour(calldate)>=8 and hour(calldate)<16 then 'DAY'
						   when hour(CALLDATE)=16 and (rcbill_my.GetWeekdayName(weekday(date(calldate)))<>'SUNDAY' and rcbill_my.GetWeekdayName(weekday(date(calldate)))<>'SATURDAY') then 'DAY'
						   when hour(CALLDATE)=16 and (rcbill_my.GetWeekdayName(weekday(date(calldate)))='SUNDAY' or rcbill_my.GetWeekdayName(weekday(date(calldate)))='SATURDAY') then 'EVENING'
						   when hour(CALLDATE)=17 then 'EVENING'
						   when hour(calldate)>=18 and hour(calldate)<23 then 'EVENING'
						   when hour(calldate)>=23 then 'NOC'
						end as `SHIFT` 
    );

    RETURN shift;
  END$$
DELIMITER ;

-- SET @rundate='2017-08-31';
-- select rcbill_my.GetNetwork(@rundate,'I237948.1') as network;
-- 


