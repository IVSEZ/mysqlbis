DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetWeekdayName`(weekdaycode int) RETURNS varchar(45) CHARSET utf8
BEGIN
    DECLARE weekdayname VARCHAR(45);
	
    SET weekdayname = CASE weekdaycode
		WHEN 0 THEN 'MONDAY'
		WHEN 1 THEN 'TUESDAY'
		WHEN 2 THEN 'WEDNESDAY'
		WHEN 3 THEN 'THURSDAY'
		WHEN 4 THEN 'FRIDAY'
		WHEN 5 THEN 'SATURDAY'
		WHEN 6 THEN 'SUNDAY'
    END;
 
 
    RETURN weekdayname;
  END$$
DELIMITER ;
