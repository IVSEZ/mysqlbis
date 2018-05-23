/*
select max(servicesubcategory) from rcbill_my.dailyactivenumber
where
period=@rundate
and 
CONTRACTCODE='I237948.1'
;
*/

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetNetwork`(rd date, cc text) RETURNS varchar(45) CHARSET utf8
BEGIN
    DECLARE network VARCHAR(45);

	set network = (select max(servicesubcategory) from rcbill_my.dailyactivenumber where period=rd and contractcode=cc);

    RETURN network;
  END$$
DELIMITER ;

-- SET @rundate='2017-08-31';
-- select rcbill_my.GetNetwork(@rundate,'I237948.1') as network;
-- 