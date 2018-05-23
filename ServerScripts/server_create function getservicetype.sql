DELIMITER //

CREATE FUNCTION GetServiceType(servicetypeold text, servicetypeold1 text, service text)
  RETURNS VARCHAR(45)

  BEGIN
    DECLARE servicetypenew VARCHAR(45);

    IF trim(servicetypeold) = '-::=-' THEN SET servicetypenew = (select servicenewtype from lkpservicetype where servicetype = service);
    ELSEIF trim(lower(servicetypeold1)) = 'corporate' THEN SET servicetypenew = (select servicenewtype from lkpservicetype where servicetype = service);
    ELSE SET servicetypenew = servicetypeold1;
    END IF;

    RETURN servicetypenew;
  END //

DELIMITER ;