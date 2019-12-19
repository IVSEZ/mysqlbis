DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetVODTypeFromResource`(resorig varchar(255)) RETURNS varchar(255) CHARSET latin1
BEGIN
    DECLARE vodtitle VARCHAR(255);

    SET vodtitle=(select case when TITLETYPE='T' then 'MOVIE'
							when TITLETYPE='E' then 'SERIES'
                            end as VODTYPE
					from rcbill.rcb_vodtitles where resourceorig=resorig);
 
    RETURN vodtitle;
  END$$
DELIMITER ;

/*
select *, case when TITLETYPE='T' then 'MOVIE'
							when TITLETYPE='E' then 'SERIES'
                            end as VODTYPE from rcbill.rcb_vodtitles;
                            
                            select titletype, count(*) from rcbill.rcb_vodtitles group by titletype; 
				
*/