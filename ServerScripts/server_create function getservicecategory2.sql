DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetServiceCategory2`(service varchar(45)) RETURNS varchar(45) CHARSET utf8
BEGIN
    DECLARE servicecategory2 VARCHAR(45);
	
    SET servicecategory2 = CASE service
		WHEN 'Subscription DTV' THEN 'TV'
		WHEN 'Subscription Indian' THEN 'TV'
		WHEN 'Subscription French' THEN 'TV'
		WHEN 'Subscription gTV' THEN 'TV'
		WHEN 'Subscription Intelenovela' THEN 'TV'
		-- WHEN 'Subscription NextTV' THEN 'TV'   
        WHEN 'Subscription NextTV' THEN 'OTT'   
		WHEN 'Subscription Internet' THEN 'Internet - Uncapped'
		WHEN 'Subscription gNet' THEN 'Internet - Uncapped'
		WHEN 'Subscription Capped Internet' THEN 'Internet - Capped'
		WHEN 'Subscription Capped gNet' THEN 'Internet - Capped'
		WHEN 'Subscription VOICE' THEN 'Voice'
		WHEN 'Subscription gVOICE' THEN 'Voice'
		-- WHEN 'Subscription VOD' THEN 'TV'
		WHEN 'Subscription VOD' THEN 'OTT'
		WHEN 'Subscription iGo' THEN 'OTT'
		WHEN 'Subscription Mobile Indian' THEN 'OTT'

    END;
 
 
    RETURN servicecategory2;
  END$$
DELIMITER ;
