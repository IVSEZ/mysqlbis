
### https://stackoverflow.com/questions/25568704/is-it-possible-to-return-multiple-values-from-mysql-function
-- select *, `name` from rcbill.rcb_tickettechregions where TECHDEPTID is not null order by 1;

DELIMITER $$
CREATE FUNCTION GetShiftTimingsForDept(dept VARCHAR(255)) RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    -- DECLARE var1 VARCHAR(255);
    -- DECLARE var2 VARCHAR(255);
    DECLARE shift VARCHAR(255);

    -- Your function logic here. Assign values to var1 and var2
    
    
	set shift = (select
						case
						   when upper(dept)='CALL CENTER' then '08:30|22:30|1'
						   when upper(dept)='NOC' then '00:01|23:59|1'
						   else '08:30|16:30|0'
						end as `SHIFT` 
    );

    

    RETURN shift;
END$$
DELIMITER ;