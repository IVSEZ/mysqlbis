use rcbill;

drop table rcb_vpnrates;



CREATE TABLE `rcb_vpnrates` (
 `ID` int(11) DEFAULT NULL	,
`RatingPlanID` int(11) DEFAULT NULL	,
`ServiceID` int(11) DEFAULT NULL	,
`Name` varchar(255) DEFAULT NULL	,
`Period` varchar(255) DEFAULT NULL	,
`Price` decimal(12,5) DEFAULT NULL	,
`Post` int(11) DEFAULT NULL	,
`AvancePeriods` int(11) DEFAULT NULL	,
`MaxCost` decimal(12,5) DEFAULT NULL	,
`TraficUpSpeed` int(11) DEFAULT NULL	,
`TraficDownSpeed` int(11) DEFAULT NULL	,
`TraficSpeed` varchar(255) DEFAULT NULL	,
`TraficLimit` int(11) DEFAULT NULL	,
`IPPool` int(11) DEFAULT NULL	,
`MaxSessionDuration` int(11) DEFAULT NULL	,
`MultiLinkCount` int(11) DEFAULT NULL	,
`SubRateType` int(11) DEFAULT NULL	,
`ChargeUnits` varchar(255) DEFAULT NULL	,
`SplitRound` int(11) DEFAULT NULL	,
`InvoiceText` int(11) DEFAULT NULL	,
`DayPrice` decimal(12,5) DEFAULT NULL	,
`AllowManualPrice` int(11) DEFAULT NULL	,
`ExportCode` varchar(255) DEFAULT NULL	,
`BillingName` varchar(255) DEFAULT NULL	,
`AliasID` int(11) DEFAULT NULL	,
`AliasName` varchar(255) DEFAULT NULL	,
`ID_OLD` int(11) DEFAULT NULL	,
`UpdDate` datetime DEFAULT NULL	,
`USERID` int(11) DEFAULT NULL	,
`Description` varchar(255) DEFAULT NULL	,
`RequireSerialNo` int(11) DEFAULT NULL	,
`TemplateID` int(11) DEFAULT NULL	,
`SerialNoFilter` varchar(255) DEFAULT NULL	,
`AllowTemporaryActivation` int(11) DEFAULT NULL	,
`AllowHiSpeedActivation` int(11) DEFAULT NULL	,
`DisableTerminationOnLimit` int(11) DEFAULT NULL	,
`AllowUsageTransfer` int(11) DEFAULT NULL	,
`vCutPeriod` int(11) DEFAULT NULL	,
`vSplit` int(11) DEFAULT NULL	,
`vCutPeriodNot` int(11) DEFAULT NULL	,
`vSplitNot` int(11) DEFAULT NULL	,
`FeeID` int(11) DEFAULT NULL	,
`UsagePeriodics` varchar(255) DEFAULT NULL	,
`AllowOnline` int(11) DEFAULT NULL ,
`AllowFuturePeriodActivation` int(11) DEFAULT NULL 



) ENGINE=InnoDB CHARSET UTF8;

CREATE INDEX IDXVPNR
ON rcb_vpnrates (ID);

CREATE INDEX IDXVPNR2
ON rcb_vpnrates (ServiceID);