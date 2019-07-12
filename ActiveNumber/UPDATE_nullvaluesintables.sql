        select * from rcbill_my.activenumber where servicecategory is null;
        select * from rcbill_my.activenumber where servicetype is null;

        select * from rcbill_my.activenumber where servicecategory ='OTT';

        select * from rcbill_my.activenumber where servicetype ='DualView';
        select * from rcbill_my.dailyactivenumber where servicetype='DualView';
        select * from rcbill_my.customercontractactivity where servicetype='DualView';


        select * from rcbill_my.activenumber where servicetype ='iGo';
        select * from rcbill_my.dailyactivenumber where servicetype='iGo';
        select * from rcbill_my.customercontractactivity where servicetype='iGo';
        
             select * from rcbill_my.customercontractactivity where service ='Subscription iGo';
               select * from rcbill_my.customercontractactivity where service is null;
                
        
/*
fields to be updated

servicecategory='OTT'
servicesubcategory='ADDON'
reported='Y'


servicecategory = (select servicecategory from rcbill_my.lkpbaseservice where service=@service),
servicesubcategory = (select servicesubcategory from rcbill_my.lkpbaseservice where service=@service),
servicetypeold = @servicetypeold,
servicetypeold1 = (select servicenewtype from rcbill_my.lkpservicetype where servicetype=@servicetypeold),
servicetype = (select GetServiceType(servicetypeold,servicetypeold1,service)),
clientclassold = @clientclassold,
clientclass = (select NewClientClass from rcbill_my.lkpclienttype where origclientclass=@clientclassold),
clienttype = (select clienttype from rcbill_my.lkpclienttype where origclientclass=@clientclassold),
regionold = @regionold,
region = (select newregion from rcbill_my.lkpregion where origregion=@regionold),
decommissioned = (select IsDecom(totalcheck)),
reported = (select reported from rcbill_my.lkpreported where servicenewtype=servicetype)
PREVIOUSSERVICETYPE=(select GetServiceType(@servicetypeold,(select servicenewtype from rcbill_my.lkpservicetype where servicetype=@previousservicetype),service)),


-- CREATE TABLE rcbill_my.tempactivenumber AS SELECT * FROM rcbill_my.activenumber;
drop table if exists rcbill_my.tempactivenumber;
set sql_safe_updates=0;

        select * from rcbill_my.anreport where servicecategory is null;

        select * from rcbill_my.activenumber where servicecategory is null;
        select * from rcbill_my.activenumber where servicesubcategory is null;
        select * from rcbill_my.activenumber where servicetype is null;
		select * from rcbill_my.activenumber where reported is null;
		select * from rcbill_my.activenumber where clientclass is null;

UPDATE rcbill_my.activenumber 
       JOIN rcbill_my.lkpbaseservice 
       ON rcbill_my.activenumber.service = rcbill_my.lkpbaseservice.Service
SET    rcbill_my.activenumber.servicecategory = rcbill_my.lkpbaseservice.servicecategory
where rcbill_my.activenumber.servicecategory is null
;


UPDATE rcbill_my.activenumber 
       JOIN rcbill_my.lkpbaseservice 
       ON rcbill_my.activenumber.service = rcbill_my.lkpbaseservice.Service
SET    rcbill_my.activenumber.servicesubcategory = rcbill_my.lkpbaseservice.servicesubcategory
where rcbill_my.activenumber.servicesubcategory is null
;


UPDATE rcbill_my.activenumber 
       JOIN rcbill_my.lkpservicetype 
       ON rcbill_my.activenumber.servicetypeold = rcbill_my.lkpservicetype.servicetype
SET    rcbill_my.activenumber.servicetypeold1 = rcbill_my.lkpservicetype.servicenewtype
where rcbill_my.activenumber.servicetypeold1 is null
;


UPDATE rcbill_my.activenumber 
SET    servicetype = rcbill_my.GetServiceType(servicetypeold,servicetypeold1,service)
where servicetype is null
;

UPDATE rcbill_my.activenumber 
       JOIN rcbill_my.lkpreported 
       ON rcbill_my.activenumber.servicetype = rcbill_my.lkpreported.servicenewtype
SET    rcbill_my.activenumber.reported = rcbill_my.lkpreported.reported
where rcbill_my.activenumber.reported is null
;

UPDATE rcbill_my.activenumber 
       JOIN rcbill_my.lkpbaseservice 
       ON rcbill_my.activenumber.service = rcbill_my.lkpbaseservice.Service
SET    rcbill_my.activenumber.servicecategory = rcbill_my.lkpbaseservice.servicecategory
where servicetype = 'DualView'
;

UPDATE rcbill_my.activenumber 
       JOIN rcbill_my.lkpbaseservice 
       ON rcbill_my.activenumber.service = rcbill_my.lkpbaseservice.Service
SET    rcbill_my.activenumber.servicecategory = rcbill_my.lkpbaseservice.servicecategory
where servicetype = 'MultiView'
;

UPDATE rcbill_my.activenumber 
       JOIN rcbill_my.lkpbaseservice 
       ON rcbill_my.activenumber.service = rcbill_my.lkpbaseservice.Service
SET    rcbill_my.activenumber.servicecategory = rcbill_my.lkpbaseservice.servicecategory
where servicetype = 'VOD'
;

-- ===========================================================
        select * from rcbill_my.dailyactivenumber where servicecategory is null;--  limit 100;
        select * from rcbill_my.dailyactivenumber where servicesubcategory is null;
        select * from rcbill_my.dailyactivenumber where servicetype is null;
		select * from rcbill_my.dailyactivenumber where reported is null;
		select * from rcbill_my.dailyactivenumber where clientclass is null;
        
        
	UPDATE rcbill_my.dailyactivenumber 
		   JOIN rcbill_my.lkpbaseservice 
		   ON rcbill_my.dailyactivenumber.service = rcbill_my.lkpbaseservice.Service
	SET    rcbill_my.dailyactivenumber.servicecategory = rcbill_my.lkpbaseservice.servicecategory
	where rcbill_my.dailyactivenumber.servicecategory is null
	;

	UPDATE rcbill_my.dailyactivenumber 
		   JOIN rcbill_my.lkpbaseservice 
		   ON rcbill_my.dailyactivenumber.service = rcbill_my.lkpbaseservice.Service
	SET    rcbill_my.dailyactivenumber.servicesubcategory = rcbill_my.lkpbaseservice.servicesubcategory
	where rcbill_my.dailyactivenumber.servicesubcategory is null
	;

	UPDATE rcbill_my.dailyactivenumber 
		   JOIN rcbill_my.lkpbaseservice 
		   ON rcbill_my.dailyactivenumber.service = rcbill_my.lkpbaseservice.Service
	SET    rcbill_my.dailyactivenumber.servicecategory = rcbill_my.lkpbaseservice.servicecategory
	where rcbill_my.dailyactivenumber.servicetype = 'DualView'
	;

	UPDATE rcbill_my.dailyactivenumber 
		   JOIN rcbill_my.lkpbaseservice 
		   ON rcbill_my.dailyactivenumber.service = rcbill_my.lkpbaseservice.Service
	SET    rcbill_my.dailyactivenumber.servicecategory = rcbill_my.lkpbaseservice.servicecategory
	where rcbill_my.dailyactivenumber.servicetype = 'MultiView'
	;

	UPDATE rcbill_my.dailyactivenumber 
		   JOIN rcbill_my.lkpbaseservice 
		   ON rcbill_my.dailyactivenumber.service = rcbill_my.lkpbaseservice.Service
	SET    rcbill_my.dailyactivenumber.servicecategory = rcbill_my.lkpbaseservice.servicecategory
	where rcbill_my.dailyactivenumber.servicetype = 'VOD'
	;
    
    
    
   	UPDATE rcbill_my.customercontractactivity 
		   JOIN rcbill_my.lkpbaseservice 
		   ON rcbill_my.dailyactivenumber.service = rcbill_my.lkpbaseservice.Service
	SET    rcbill_my.dailyactivenumber.servicecategory = rcbill_my.lkpbaseservice.servicecategory
	where rcbill_my.dailyactivenumber.servicetype = 'VOD'
	;
    
    create table rcbill_my.cca1 as 
    (
		select * from rcbill_my.customercontractactivity where clientcode='I.000011750'
	);
    
    select * from rcbill_my.cca1;
    
    UPDATE rcbill_my.cca1
     SET servicecategory2 = rcbill_my.GetServiceCategory2(service)
    ;
    
    UPDATE rcbill_my.customercontractactivity
     SET servicecategory2 = rcbill_my.GetServiceCategory2(service)
    ;
    
    UPDATE rcbill_my.customercontractactivity 
		   JOIN rcbill_my.lkpbaseservice 
		   ON rcbill_my.customercontractactivity.SERVICE = rcbill_my.lkpbaseservice.Service
	SET    rcbill_my.customercontractactivity.servicecategory = rcbill_my.lkpbaseservice.servicecategory
	where rcbill_my.customercontractactivity.package = 'VOD'
	;

    UPDATE rcbill_my.customercontractactivity 
		   JOIN rcbill_my.lkpbaseservice 
		   ON rcbill_my.customercontractactivity.SERVICE = rcbill_my.lkpbaseservice.Service
	SET    rcbill_my.customercontractactivity.servicecategory = rcbill_my.lkpbaseservice.servicecategory
	where rcbill_my.customercontractactivity.package = 'DUALVIEW'
	;

    UPDATE rcbill_my.customercontractactivity 
		   JOIN rcbill_my.lkpbaseservice 
		   ON rcbill_my.customercontractactivity.SERVICE = rcbill_my.lkpbaseservice.Service
	SET    rcbill_my.customercontractactivity.servicecategory = rcbill_my.lkpbaseservice.servicecategory
	where rcbill_my.customercontractactivity.package = 'MULTIVIEW'
	;
    UPDATE rcbill_my.customercontractactivity 
		   JOIN rcbill_my.lkpbaseservice 
		   ON rcbill_my.customercontractactivity.SERVICE = rcbill_my.lkpbaseservice.Service
	SET    rcbill_my.customercontractactivity.servicecategory = rcbill_my.lkpbaseservice.servicecategory
	where rcbill_my.customercontractactivity.package = 'IGo'
	;
    
set sql_safe_updates=0;
update rcbill_my.customercontractactivity
set servicecategory2='OTT'
where SERVICE='Subscription Mobile Indian'
;    
    
    
    SERVICECATEGORY=(select servicecategory from rcbill_my.lkpbaseservice where service=@service),	
    
    
    -- select * from rcbill_my.customercontractactivity where package='MultiView';
*/