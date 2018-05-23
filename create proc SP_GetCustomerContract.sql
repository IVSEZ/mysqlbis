delimiter // 
CREATE PROCEDURE sp_GetCustomerContracts(IN clientcode varchar(255), IN clientname varchar(255), inlastaction int)
BEGIN
    SET @s = ' select a.clientcode, a.clientname, a.clientaddress, b.contractid,b.contracttype,b.contractdate,b.lastaction from clients a inner join contracts b on a.clientcode=b.clientcode ';
	
	 SET @a = '';
	 SET @b = '';
	 SET @c = '';

	 
--	 if clientcode <> '' then SET @a = CONCAT(' a.clientcode =', clientcode);
--	 if clientname <> '' then SET @b = CONCAT(' a.clientname like "', clientname, '%" ');	
--	 if lastaction = 1 then SET @c = ' (b.lastaction like "Open%" or b.lastaction = "") ';	
--	 else if lastaction = 0 then SET @c = ' (b.lastaction NOT like "Open%" and b.lastaction <> "") ';	
	 
	 
	 if clientcode = '' and clientname = '' and lastaction not in (0,1) then SET @q = @s;
	 -- else if clientcode <> '' and clientname = '' and lastaction not in (0,1) then SET @q = CONCAT(@s,' where ', @a);
	 -- else if clientcode = '' and clientname <> '' and lastaction not in (0,1) then SET @q = CONCAT(@s, ' where ', @b);
	 -- else if clientcode <> '' and clientname <> '' and lastaction not in (0,1) then SET @q = CONCAT(@s, ' where ', @a, ' and ', @b);
	 
	 -- else if clientcode = '' and clientname = '' and lastaction in (0,1) then SET @q = CONCAT(@s,' where ', @c);
	 -- else if clientcode <> '' and clientname = '' and lastaction in (0,1) then SET @q = CONCAT(@s,' where ', @a, ' and ',@c);
	 -- else if clientcode = '' and clientname <> '' and lastaction in (0,1) then SET @q = CONCAT(@s,' where ', @b, ' and ',@c);
	 -- else if clientcode <> '' and clientname <> '' and lastaction in (0,1) then SET @q = CONCAT(@s, ' where ', @a, ' and ',@b, ' and ', @c);
	 
	 SET @finalq = CONCAT(@q , ' order by a.clientcode, b.contractdate asc');
	 
	 PREPARE stmt FROM @finalq;
	 
	 
	 IF E> 0 THEN
        SELECT CONCAT("MySQL Error #", E,  ": ", M);;
        set E=0;
    else
        execute stmt;
 		 DEALLOCATE PREPARE stmt;
    end if;
	 -- SELECT @finalq;
   -- EXECUTE stmt;
   
END
//
delimiter ;


/*
select a.clientcode, a.clientname, a.clientaddress, b.contractid,b.contracttype,b.contractdate,b.lastaction 
from 
clients a 
inner join 
contracts b 
on 
a.clientcode=b.clientcode
where 
-- a.clientcode='I.000011750'
 a.clientname like 'darrel%' 
 and 
 (b.lastaction like 'Open%' or b.lastaction = '' )
-- group by a.clientcode 
order by a.clientcode, b.contractdate asc;
*/