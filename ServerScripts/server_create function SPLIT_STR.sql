### https://stackoverflow.com/questions/25568704/is-it-possible-to-return-multiple-values-from-mysql-function


DELIMITER $$
CREATE FUNCTION SPLIT_STR(x VARCHAR(510), delim VARCHAR(12), pos INT) RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, '');
END$$
DELIMITER ;