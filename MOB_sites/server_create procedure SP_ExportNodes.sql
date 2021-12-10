DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ExportNodes`()
BEGIN

	/*
    DECLARE parcel_details varchar(255);

    SET parcel_details=(select concat(cpc.clientparcel,'|',cpc.coord_x,'|',cpc.coord_y,'|',cpc.latitude,'|',cpc.longitude)
					from rcbill_my.rcb_clientparcelcoords cpc 
                    where cpc.clientcode=clcode and cpc.latitude <> 0 and date(cpc.insertedon)=((select max(date(a.insertedon)) from rcbill.rcb_clientparcelcoords a)) 
				);

	RETURN CONCAT_WS('|', var1, var2);
	*/

		set session group_concat_max_len = 1000000;

		#####################################################################


		#####################################################################
		## IV_NODES

		-- select 'IV_NODES' AS TABLENAME;
		/*
        select column_name
			from information_schema.columns
			where table_name = 'IV_NODES'
			and table_schema = 'rcbill_maps'
			order by ordinal_position
			;
		*/

		select 	"lat",	"lon",	"title",	"description",	"icon",	"iconSize",	"iconOffset"

		union all

		-- select 	ifnull(lat,""),	ifnull(lon,""),	ifnull(title,""),	ifnull(description,""),	ifnull(icon,""),	ifnull(iconSize,""),	ifnull(iconOffset,"")

		select ifnull(NODElat,"") as lat, ifnull(NODElong,"") as lon, concat("<font face=verdana size=2>", ifnull(NODEname,""),"</font><hr>") as title, concat("<font face=verdana size=1>", concat_ws("<BR>",ifnull(NODENO,""),ifnull(NODENAME,""),ifnull(NODETYPE,""),ifnull(NODEDISTRICT,""),ifnull(NODEISLAND,""),ifnull(NODEOWNER,""),ifnull(NODEPARCEL,""),ifnull(NODELAT,""),ifnull(NODELONG,""), ifnull(NODECOORDX,""),ifnull(NODECOORDY,""),ifnull(NODESTATUS,""),ifnull(COMMENT,"")),"</font>") as description ,	ifnull(NODEICON,"") as icon,	ifnull(NODEICONSIZE,"") as iconSize,	ifnull(NODEICONOFFSET,"") as iconOffset


		INTO OUTFILE '/var/www/html/maptest/data/iv_nodes.txt'
		FIELDS TERMINATED BY '\t'
		ENCLOSED BY ''
		ESCAPED BY '\\'
		LINES TERMINATED BY '\r\n'
		FROM rcbill_maps.IV_NODES
		;




  END$$
DELIMITER ;


-- call sp_ExportNodes();