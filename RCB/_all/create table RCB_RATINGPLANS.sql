use rcbill;

drop table rcb_ratingplans;


CREATE TABLE `rcb_ratingplans` (
`ID` int(11) DEFAULT NULL ,
`KOD` varchar(255) DEFAULT NULL ,
`name` varchar(255) DEFAULT NULL ,
`Type` int(11) DEFAULT NULL ,
`PrePaid` int(11) DEFAULT NULL ,
`StartDate` datetime DEFAULT NULL ,
`EndDate` datetime DEFAULT NULL ,
`NStartTime` datetime DEFAULT NULL ,
`NEndTime` datetime DEFAULT NULL ,
`NextRatingPlanID` int(11) DEFAULT NULL ,
`DefCreditLimit` decimal(12,5) DEFAULT NULL ,
`DefCreditPolicyID` int(11) DEFAULT NULL ,
`DefaultRP` int(11) DEFAULT NULL ,
`OwnerID` int(11) DEFAULT NULL ,
`PromoText` varchar(255) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`AllowBulkInvoicing` int(11) DEFAULT NULL ,
`rCurrency` varchar(255) DEFAULT NULL 
) ENGINE=InnoDB CHARSET UTF8;


