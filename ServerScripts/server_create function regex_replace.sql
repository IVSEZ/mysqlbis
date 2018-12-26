DELIMITER $$
DROP FUNCTION IF EXISTS `regex_replace`$$

CREATE FUNCTION `regex_replace`(pattern VARCHAR(1000),replacement VARCHAR(1000),original VARCHAR(1000)) RETURNS VARCHAR(1000) CHARSET utf8mb4
    DETERMINISTIC
BEGIN    
    DECLARE temp VARCHAR(1000); 
    DECLARE ch VARCHAR(1); 
    DECLARE i INT;
    SET i = 1;
    SET temp = '';
    IF original REGEXP pattern THEN 
        loop_label: LOOP 
            IF i>CHAR_LENGTH(original) THEN
                LEAVE loop_label;  
            END IF;

            SET ch = SUBSTRING(original,i,1);

            IF NOT ch REGEXP pattern THEN
                SET temp = CONCAT(temp,ch);
            ELSE
                SET temp = CONCAT(temp,replacement);
            END IF;

            SET i=i+1;
        END LOOP;
    ELSE
        SET temp = original;
    END IF;

    RETURN temp;
END$$
DELIMITER ;


/*
SELECT <field-name> AS NormalText, regex_replace('[^A-Za-z0-9 ]', '', <field-name>)AS RegexText FROM 
<table-name>

*/