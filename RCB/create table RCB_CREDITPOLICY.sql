use rcbill;

drop table rcb_creditpolicy;


CREATE TABLE `rcb_creditpolicy` (
`ID` int(11) DEFAULT NULL ,
`KOD` varchar(255) DEFAULT NULL ,
`NAME` varchar(255) DEFAULT NULL ,
`UseNonInvoiced` int(11) DEFAULT NULL ,
`UseNonInvoicedVAT` int(11) DEFAULT NULL ,
`UseSaldo` int(11) DEFAULT NULL ,
`BillingPeriod` int(11) DEFAULT NULL ,
`OwnerID` int(11) DEFAULT NULL ,
`PriorityServiceID` int(11) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`MON` int(4)  DEFAULT NULL ,
`TUE` int(4) DEFAULT NULL ,
`WED` int(4) DEFAULT NULL ,
`THU` int(4) DEFAULT NULL ,
`FRI` int(4) DEFAULT NULL ,
`SAT` int(4) DEFAULT NULL ,
`SUN` int(4) DEFAULT NULL ,
`InvoicingAvanceDays` int(11) DEFAULT NULL ,
`MinLimit` decimal(12,5) DEFAULT NULL ,
`MaxLimit` decimal(12,5) DEFAULT NULL ,
`MinInvDate` int(11) DEFAULT NULL ,
`MaxInvDate` int(11) DEFAULT NULL ,
`AdjustInvoicingDate` int(11) DEFAULT NULL 
) ENGINE=InnoDB CHARSET UTF8;


