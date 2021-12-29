
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetPayType`(paytype int) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE paytype_name varchar(255);

    SET paytype_name=(select rs.name 
					from rcbill.rcb_services rs 
                    where rs.id=paytype 
				);

	RETURN paytype_name;

  END$$
DELIMITER ;


-- select ccs.network from rcbill_my.customercontractsnapshot ccs where ccs.clientcode=a.KOD order by ccs.currentstatus asc, ccs.contractcode desc LIMIT 1


-- select * from rcbill.rcb_clientparcelcoords where clientcode=clcode and latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords));

-- select concat(clientparcel,'|',coord_x,'|',coord_y,'|',latitude,'|',longitude) as parcel_details from rcbill.rcb_clientparcelcoords where clientcode='I18191' and latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords));

