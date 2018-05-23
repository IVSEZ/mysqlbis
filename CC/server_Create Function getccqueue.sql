DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetCCQueueName`(ccqueuecode text) RETURNS varchar(45) CHARSET utf8
BEGIN
    DECLARE ccqueuename VARCHAR(45);

    SET ccqueuename=(select CCQUEUENAME from lkpccqueues where CCQUEUECODE=ccqueuecode);
 
    RETURN ccqueuename;
  END$$
DELIMITER ;
