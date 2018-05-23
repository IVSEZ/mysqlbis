DELIMITER //

CREATE FUNCTION IsDecom(totalcheck int)
  RETURNS VARCHAR(1)

  BEGIN
    DECLARE decom VARCHAR(1);

    IF totalcheck > 0 THEN SET decom = 'N';
    ELSE SET decom = 'Y';
    END IF;

    RETURN decom;
  END //

DELIMITER ;