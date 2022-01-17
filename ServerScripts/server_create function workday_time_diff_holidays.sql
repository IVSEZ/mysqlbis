DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `workday_time_diff_holidays`(
`param_country` varchar(10), 
`assigneddatetime` varchar(20), 
`closeddatetime` varchar(20), 
`starttime` varchar(20), 
`endtime` varchar(20)
)
	RETURNS int(11)
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
BEGIN 
Set @starttime = starttime;
Set @endtime = endtime;
Select time_to_sec(timediff(@endtime,@starttime))/3600 into @maxhoursaday;
Set @assigneddate = assigneddatetime; 
Set @closeddate = closeddatetime; 
Set @timecount = 0;
Set @timevar1 = @assigneddate;
Set @nextdate = @assigneddate;
Set @timevar2 = null;
Set @param_country = param_country;
############ 
/*Check if the assigned time was before the starttime 
or closed time was after the endtime provided*/
#############
Set @checkstart = null;
Set @checkend = null;
Select CONCAT(SUBSTRING_INDEX(@assigneddate, ' ', 1), ' ',@starttime),
CONCAT(SUBSTRING_INDEX(@closeddate, ' ', 1), ' ',@endtime)  into @checkstart, @checkend;

if (@assigneddate > @checkstart) then
		if (@closeddate<@checkend) then
			Set @assigneddate = @assigneddate;
            Set @closeddate = @closeddate;
		else
			Set @assigneddate = @assigneddate;
			Set @closeddate = @checkend;
		end if;
    else
		if (@closeddate<@checkend) then
			SET @assigneddate = @checkstart;
            Set @closeddate = @closeddate;
		else
			SET @assigneddate = @checkstart;
            Set @closeddate = @checkend;
		end if;
    end if;
####################
/*After above check, the assigneddate and closeddate
variables will be reset in accordance with the checks.*/
####################################    

SELECT DATEDIFF(@closeddate, @assigneddate) INTO @fixcount; # check the difference between assigned date and closed date. 
Set @count = @fixcount; # allocate the difference between closed date and assigned date to a counter
If @fixcount > 0 then #  true if line 57 resulted in more than 1 then run the while loop on next line
	while @count>=0 do # run the while loop until the count which is right now difference between closed and assigned becomes zero
		select weekday(@nextdate) into @weekday; # Assign the weekday value to @weekday. Weekday returns o for Monday, 2 for Tuesday ...5 for Saturday and 6 for Sunday

/*Check if the date stored in nextdate 
(which is assigneddate on first run of while loop and closeddate on last run) 
is a holiday and set the holiday flag*/

        Select sum(if(date_format(HOLIDAY_DATE,'%Y-%m-%d') = substring_index(@nextdate,' ',1),1,0)) 
        from holidays 
        where COUNTRY_CODE = 'ALL' or instr(COUNTRY_CODE,@param_country)>0
        into @holidayflag; 
		if ( @weekday<5 and @holidayflag=0) then #Proceed if the date in nextdate variable is neither weekend nor a holiday
			if (@count = @fixcount) then #Check if it is first run.ie. if nextdate is assigneddate
				Set @timevar1 = @assigneddate; #assign assigndate to variable timevar1
				SELECT CONCAT(SUBSTRING_INDEX(@assigneddate, ' ', 1), ' ',@endtime) INTO @timevar2;#get site closing time on assigned date and store it on to timevar2
			elseif (@count = 0) then #if the date in nextdate variable is closeddate then do the following otherwise proceed
				Select concat(substring_index(@closeddate,' ',1),' ',@starttime) into @timevar1; # 
				Set @timevar2 = @closeddate;
			else
				Select concat(@nextdate,' ',@starttime) into @timevar1;
				SELECT CONCAT(@nextdate, ' ', @endtime) INTO @timevar2;
			end if;
	SELECT 
        LEAST(Greatest(((TIME_TO_SEC(TIMEDIFF(@timevar2, @timevar1))) / 3600),0),@maxhoursaday) 
        INTO @timecounttemp;
            
			Set @timecount = @timecounttemp + @timecount;
		end if;
        Set @timevar1 = @nextdate;
        SELECT 
        ADDDATE(SUBSTRING_INDEX(@timevar1, ' ', 1),1) 
        INTO @nextdate;
		Set @count = @count - 1;
	end while;
else 
    #check if the assigned date / closed date is a holiday or weekend
    select weekday(@assigneddate) into @weekday; # Assign the weekday value to @weekday. Weekday returns o for Monday, 2 for Tuesday ...5 for Saturday and 6 for Sunday
    Select sum(if(date_format(HOLIDAY_DATE,'%Y-%m-%d') = substring_index(@assigneddate,' ',1),1,0)) from holidays where COUNTRY_CODE = 'ALL' or instr(COUNTRY_CODE,@param_country)>0 into @holidayflag; #Check if the date stored in assigneddate is a holiday and set the holiday flag
    if ( @weekday<5 and @holidayflag=0) then #Proceed if the date in assigneddate variable is neither weekend nor a holiday
        SELECT Least(Greatest(((TIME_TO_SEC(TIMEDIFF(@closeddate, @assigneddate))) / 3600),0),@maxhoursaday) INTO @timecount;
    else
        Set @timecount = 0;
    end if;
end if;
RETURN @timecount*60;
END$$
DELIMITER ;