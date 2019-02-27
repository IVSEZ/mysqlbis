DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetVODSeriesNameFromResource`(resorig varchar(255)) RETURNS varchar(255) CHARSET latin1
BEGIN
    DECLARE vodtitle VARCHAR(255);

	/*
    SET vodtitle=(select trim(concat(ifnull(SERIES,''),' ', ifnull(SEASON,''),' ', ifnull(EPISODE,''),' ', TITLE)) as resource 
					from rcbill.rcb_vodtitles where resourceorig=resorig);
	*/
    
     SET vodtitle=(select trim(SERIES) as resource 
					from rcbill.rcb_vodtitles where resourceorig=resorig);

    
    RETURN vodtitle;
  END$$
DELIMITER ;
