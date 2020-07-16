			select a.*
			-- , b.*
			, b.IsAccountActive, b.AccountActivityStage, b.clientclass, b.activenetwork, b.activeservices, b.activecontracts, b.activesubscriptions
			, b.reportdate
			from
			(
			select * from rcbill.rcb_clientparcelcoords where 
            latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) 
            and clientcode in (select clientcode from rcbill_my.clientstats where `Intelenovela`>0)
            order by clientparcel
			) a 
			left join 
			rcbill_my.rep_custconsolidated b
			on 
			a.clientcode=b.clientcode
;


			select a.*
			-- , b.*
			, b.IsAccountActive, b.AccountActivityStage, b.clientclass, b.activenetwork, b.activeservices, b.activecontracts, b.activesubscriptions
			, b.reportdate
			from
			(
			select * from rcbill.rcb_clientparcelcoords where 
            latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) 
            and clientcode in (select clientcode from rcbill_my.clientstats where (`Extravagance`>0 or `Extravagance Corporate`>0))
            order by clientparcel
			) a 
			left join 
			rcbill_my.rep_custconsolidated b
			on 
			a.clientcode=b.clientcode
;

			select a.*
			-- , b.*
			, b.IsAccountActive, b.AccountActivityStage, b.clientclass, b.activenetwork, b.activeservices, b.activecontracts, b.activesubscriptions
			, b.reportdate
			from
			(
			select * from rcbill.rcb_clientparcelcoords where 
            latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) 
            and clientcode in (select clientcode from rcbill_my.clientstats where (`Amber`>0 or `Amber Corporate`>0))
            order by clientparcel
			) a 
			left join 
			rcbill_my.rep_custconsolidated b
			on 
			a.clientcode=b.clientcode
;

			select a.*
			-- , b.*
			, b.IsAccountActive, b.AccountActivityStage, b.clientclass, b.activenetwork, b.activeservices, b.activecontracts, b.activesubscriptions
			, b.reportdate
			from
			(
			select * from rcbill.rcb_clientparcelcoords where 
            latitude <> 0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords)) 
            and clientcode in (select clientcode from rcbill_my.clientstats where (`Crimson`>0 or `Crimson Corporate`>0))
            order by clientparcel
			) a 
			left join 
			rcbill_my.rep_custconsolidated b
			on 
			a.clientcode=b.clientcode
;

-- select clientcode from rcbill_my.clientstats where `Intelenovela`>0;
        
        