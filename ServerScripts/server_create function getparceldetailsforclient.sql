
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetParcelDetailsForClient`(clcode text) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE parcel_details varchar(255);

    SET parcel_details=(select concat(cpc.clientparcel,'|',cpc.coord_x,'|',cpc.coord_y,'|',cpc.latitude,'|',cpc.longitude)
					from rcbill_my.rcb_clientparcelcoords cpc 
                    where cpc.clientcode=clcode and cpc.latitude <> 0 and date(cpc.insertedon)=((select max(date(a.insertedon)) from rcbill.rcb_clientparcelcoords a)) 
				);

	RETURN CONCAT_WS('|', var1, var2);

  END$$
DELIMITER ;


-- select ccs.network from rcbill_my.customercontractsnapshot ccs where ccs.clientcode=a.KOD order by ccs.currentstatus asc, ccs.contractcode desc LIMIT 1


-- select * from rcbill.rcb_clientparcelcoords where clientcode=clcode and latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords));

-- select concat(clientparcel,'|',coord_x,'|',coord_y,'|',latitude,'|',longitude) as parcel_details from rcbill.rcb_clientparcelcoords where clientcode='I18191' and latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords));

