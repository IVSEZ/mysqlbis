select * from rcbill_my.rep_anreport_all;


use rcbill_my;

### CREATE TABLE FOR MONTH LAST DATES

drop table if exists rcbill_my.month_last_date;

CREATE TABLE rcbill_my.month_last_date
(
  month_last_date date
);

#Inserting a date to make sure it will not be repeated once the procedure is called...
-- INSERT INTO rcbill_my.month_last_date (month_last_date) VALUES ('2012-01-01');

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_filllastdates`(IN dateStart date, IN dateEnd date)
-- CREATE PROCEDURE filldates(dateStart DATE, dateEnd DATE)

BEGIN

    DECLARE adate date;

        WHILE dateStart <= dateEnd DO

            SET adate = (SELECT month_last_date FROM rcbill_my.month_last_date WHERE month_last_date = dateStart);

            IF adate IS NULL THEN BEGIN

                INSERT INTO rcbill_my.month_last_date (month_last_date) VALUES (dateStart);
           
            END; END IF;

            SET dateStart = LAST_DAY(date_add(dateStart, INTERVAL 1 MONTH));

        END WHILE;

END$$
DELIMITER ;

   
call sp_filllastdates('2016-05-31',DATE_SUB(date(NOW()), INTERVAL 1 DAY));


select * from rcbill_my.month_last_date;

#######################################################################################

#### FILL ALL DATES

drop table if exists rcbill_my.month_all_date;

CREATE TABLE rcbill_my.month_all_date
(
  month_all_date date
);

#Inserting a date to make sure it will not be repeated once the procedure is called...
-- INSERT INTO rcbill_my.month_all_date (month_all_date) VALUES ('2012-01-01');

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fillalldates`(IN dateStart date, IN dateEnd date)
-- CREATE PROCEDURE filldates(dateStart DATE, dateEnd DATE)

BEGIN

    DECLARE adate date;

        WHILE dateStart <= dateEnd DO

            SET adate = (SELECT month_all_date FROM rcbill_my.month_all_date WHERE month_all_date = dateStart);

            IF adate IS NULL THEN BEGIN

                INSERT INTO rcbill_my.month_all_date (month_all_date) VALUES (dateStart);
           
            END; END IF;

            SET dateStart = date_add(dateStart, INTERVAL 1 DAY);

        END WHILE;

END$$
DELIMITER ;

   
call sp_fillalldates('2016-05-01',DATE_SUB(date(NOW()), INTERVAL 1 DAY));


-- select DATE_SUB(date(NOW()), INTERVAL 1 DAY);

select * from rcbill_my.month_all_date;