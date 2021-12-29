
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetPayObject`(payobject int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE payobject_name varchar(255);

    SET payobject_name=(select rs.name 
					from rcbill.rcb_payobjects rs 
                    where rs.ID=payobject 
				);

	RETURN payobject_name;

  END$$
DELIMITER ;


-- select ccs.network from rcbill_my.customercontractsnapshot ccs where ccs.clientcode=a.KOD order by ccs.currentstatus asc, ccs.contractcode desc LIMIT 1


-- select * from rcbill.rcb_clientparcelcoords where clientcode=clcode and latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords));

-- select concat(clientparcel,'|',coord_x,'|',coord_y,'|',latitude,'|',longitude) as parcel_details from rcbill.rcb_clientparcelcoords where clientcode='I18191' and latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords));

