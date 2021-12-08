SELECT CustomerGroup, min(Last6monthTotal) AS GroupMin, max(Last6monthTotal) AS GroupMax, avg(Last6monthTotal) AS GroupAvg
FROM (
  SELECT Last6monthTotal, NTILE(4) OVER (ORDER BY Last6monthTotal ASC) AS CustomerGroup
  FROM LapsCustomerShoppingHistory
) t1
group by CustomerGroup




SELECT
	CustomerCode, 
	Last6monthAvgMonthly,
	NTILE(4) OVER(
		ORDER BY Last6monthAvgMonthly ASC
	) CustomerGroup
FROM 
	LapsCustomerShoppingHistory

	
	
	
ALTER TABLE LapsCustomerShoppingHistory
ADD Groupid  INT

ALTER TABLE LapsCustomerShoppingHistory
ADD SlabId  INT


UPDATE LapsCustomerShoppingHistory
SET GroupId = 6
WHERE Last6monthTotal > 50000




SELECT cg.CustomerGroup AS id, cg.GroupRange AS Groupid, SUM(lcsh.Last6monthTotal) AS Contribution, COUNT(CustomerCode) AS NumOfCustomers
FROM LapsCustomerShoppingHistory lcsh
INNER JOIN CustomerGroup cg
ON lcsh.Groupid = cg.CustomerGroup 
GROUP BY cg.GroupRange, cg.CustomerGroup
ORDER BY cg.CustomerGroup ASC




UPDATE CustomerGroup 
DELETE GroupAvg
FROM CustomerGroup




ALTER TABLE CustomerGroup
DROP COLUMN GroupAvg




ALTER TABLE CustomerGroup
ADD GroupRange VARCHAR(20)




UPDATE CustomerGroup
SET GroupRange = '10000 - 170000'
WHERE CustomerGroup = 4




SELECT Last6monthTotal 
FROM LapsCustomerShoppingHistory lcsh




DELETE FROM LapsCustomerShoppingHistory 
WHERE Last6monthTotal > 60000




EXEC SP_LapsCustomerShoppingHistory 1




SELECT Groupid, COUNT(CustomerCode)
FROM LapsCustomerShoppingHistory lcsh
GROUP BY Groupid
ORDER BY Groupid




SELECT cg.CustomerGroup AS id, cg.GroupRange AS Groupid, SUM(lcsh.Last6monthTotal) AS Contribution,  COUNT(CustomerCode) AS NumOfCustomers
FROM LapsCustomerShoppingHistory lcsh
INNER JOIN CustomerGroup cg
ON lcsh.Groupid = cg.CustomerGroup
GROUP BY cg.GroupRange, cg.CustomerGroup
ORDER BY cg.CustomerGroup ASC




SELECT sps.new_category AS ProductName, CAST(SUM(sbd.net) AS INT) AS TotalAmount, COUNT (DISTINCT sbd.invoice_no) AS FF
FROM LapseDB.dbo.LapseDetails ld 
INNER JOIN RAWDB.dbo.ShwapnoBasketData sbd 
ON ld.CustomerCode = sbd.customer_code 
INNER JOIN RAWDB.dbo.ShwapnoProductSegment sps 
ON sbd.product_code = sps.Article_Code 
WHERE ld.PredictedGroup = 1
GROUP BY sps.new_category
ORDER BY TotalAmount DESC




update LapsCustomerShoppingHistory 
SET Groupid = CustomerGroup
FROM LapsCustomerShoppingHistory lh, CustomerGroup cg 
WHERE lh.Last6monthTotal >= cg.GroupMin AND lh.Last6monthTotal < cg.GroupMax  

update LapsCustomerShoppingHistory 
SET SlabId = CustomerGroup
FROM LapsCustomerShoppingHistory lh, CustomerSlab cg
WHERE lh.Last6monthTotal >= cg.GroupMin AND lh.Last6monthTotal < cg.GroupMax  


SELECT L.* , ISNULL(NoOfCus,0) AS NoOfCus 
	FROM (
			SELECT * FROM
			(SELECT  CustomerGroup AS Groupid, GroupRange FROM CustomerGroup ) Grp, 
			(SELECT DISTINCT MonthlyPresensce FROM LapsCustomerShoppingHistory) MP
		) L
	LEFT JOIN (
			SELECT Groupid , MonthlyPresensce , COUNT(CustomerCode) AS NoOfCus 
			FROM LapsCustomerShoppingHistory lh
			GROUP BY  Groupid , MonthlyPresensce 
			) R ON L.Groupid= R.Groupid
					AND L.MonthlyPresensce= R.MonthlyPresensce
	ORDER BY 1,3 ASC
	
SELECT cg.CustomerGroup, cg.GroupRange, tmp.MonthlyPresensce, tmp.NoOfCus
FROM temp tmp INNER JOIN
	CustomerGroup cg 
	ON tmp.Groupid = cg.CustomerGroup
	ORDER BY 1,3 ASC
DROP TABLE temp

SELECT * FROM  
(SELECT DISTINCT MonthlyPresensce FROM LapsCustomerShoppingHistory) MP,
(SELECT DISTINCT Groupid FROM LapsCustomerShoppingHistory) Grp 
ORDER BY 1,2

SELECT Groupid , MonthlyPresensce , COUNT(CustomerCode) AS NoOfCustomer
FROM LapsCustomerShoppingHistory lh
GROUP BY  Groupid , MonthlyPresensce
ORDER BY 1,2


SELECT sps.Division AS ProductName, CAST(SUM(sbd.net) AS INT) AS TotalAmount, COUNT (DISTINCT sbd.invoice_no) AS FF
FROM LapseDB.dbo.LapseDetails ld 
INNER JOIN RAWDB.dbo.ShwapnoBasketData sbd 
ON ld.CustomerCode = sbd.customer_code
INNER JOIN LapseDB.dbo.LapsCustomerShoppingHistory lh 
ON ld.CustomerCode = lh.CustomerCode
INNER JOIN RAWDB.dbo.ShwapnoProductSegment sps 
ON sbd.product_code = sps.Article_Code 
WHERE ld.PredictedGroup = 1 AND lh.Groupid = 5
GROUP BY sps.Division
ORDER BY TotalAmount DESC




SELECT sps.new_category AS ProductName, CAST(SUM(sbd.net) AS INT) AS TotalAmount, COUNT (DISTINCT sbd.invoice_no) AS FF
FROM LapseDB.dbo.LapseDetails ld 
INNER JOIN RAWDB.dbo.ShwapnoBasketData sbd 
ON ld.CustomerCode = sbd.customer_code
INNER JOIN LapseDB.dbo.LapsCustomerShoppingHistory lh 
ON ld.CustomerCode = lh.CustomerCode
INNER JOIN RAWDB.dbo.ShwapnoProductSegment sps 
ON sbd.product_code = sps.Article_Code 
WHERE ld.PredictedGroup = 1 AND lh.Groupid = 5 AND sps.Division = 'COMMODITY'
GROUP BY sps.new_category 
ORDER BY TotalAmount DESC

SELECT sps.new_category AS ProductName, CAST(SUM(sbd.net) AS INT) AS TotalAmount, COUNT (DISTINCT sbd.invoice_no) AS FF
FROM LapseDB.dbo.LapseDetails ld
INNER JOIN RAWDB.dbo.ShwapnoBasketData sbd
ON ld.CustomerCode = sbd.customer_code
INNER JOIN LapseDB.dbo.LapsCustomerShoppingHistory lh
ON ld.CustomerCode = lh.CustomerCode
INNER JOIN LapseDB.dbo.CustomerGroup cg
ON cg.CustomerGroup = lh.Groupid
INNER JOIN RAWDB.dbo.ShwapnoProductSegment sps
ON sbd.product_code = sps.Article_Code
WHERE ld.PredictedGroup = 1 AND cg.GroupRange = '0 - 1500'
GROUP BY sps.new_category
ORDER BY TotalAmount DESC

SELECT DISTINCT Division FROM RAWDB.dbo.ShwapnoProductSegment


CREATE TABLE #tempWarranty
(
       PageNo INT,
       SL INT,
       RegionName VARCHAR(100),
       ServiceType VARCHAR(100),
       DCWarrantyId INT,
       WCDate DATETIME,
       OccuranceDate DATETIME,
       MasterCode VARCHAR(20),
       DealarName VARCHAR(100),
       CustomerName VARCHAR(500),
       BikeModel VARCHAR(500),
       ChassisNo VARCHAR(100),
       InvoiceDate DATETIME,
       Mileage VARCHAR(9),
       ProblemDetails VARCHAR(MAX),
       ProductCode VARCHAR(30),
       ProductName VARCHAR(100),
       TotalCost NUMERIC(18,2),
       Approved_Status VARCHAR(50)
)
 
INSERT INTO #tempWarranty
EXEC Usp_reportWarrantyClaim_Samin '2019-01-01','2021-01-24 23:59:59.000','%', '%','20','%'
 
Select * From #tempWarranty
--DROP TABLE #tempWarranty

SELECT  ProductCode, 
		COUNT(DISTINCT ProductName) AS NumOfProductNames, 
		COUNT(DISTINCT BikeModel) AS NumOfBikeNames, 
		STUFF((SELECT DISTINCT ' , ' + ProductName
	           FROM #tempWarranty b 
	           WHERE b.ProductCode = a.ProductCode 
		       FOR XML PATH('')), 1, 2, '')
FROM #tempWarranty a
GROUP BY ProductCode
ORDER BY NumOfProductNames DESC


SELECT UC.RegionName, DWC.DCWarrantyId, LEFT(DWC.WCDate,11) AS WCDate, LEFT(DWC.OccuranceDate,11) AS OccuranceDate, DWC.MasterCode, 
	   C.CustomerName AS DealarName, DIM.CustomerName, BP.ProductName, DWC.ChassisNo, LEFT(DIM.InvoiceDate,11) AS InvoiceDate, DWC.Mileage, 
       DWC.ProblemDetails AS Problem_Details
FROM DealarWarrantyClaim DWC
LEFT JOIN UserCustomer UC ON DWC.MasterCode = UC.CustomerCode AND UserType = 'SE'
LEFT JOIN Customer C ON DWC.MasterCode = C.CustomerCode
INNER JOIN DealarInvoiceDetails DID ON DWC.ChassisNo = DID.ChassisNo
INNER JOIN Product BP ON DID.ProductCode = BP.ProductCode
INNER JOIN DealarInvoiceMaster DIM ON DIM.InvoiceId = DID.InvoiceId



SELECT UC.RegionName, 'Warranty Claim' ServiceType,    DWC.DCWarrantyId, LEFT(DWC.WCDate,11) AS WCDate, LEFT(DWC.OccuranceDate,11) AS OccuranceDate,
       DWC.MasterCode,      C.CustomerName AS DealarName,DIM.CustomerName, BP.ProductCode AS BikeCode, 
       BP.ProductName AS BikeName,DWC.ChassisNo, LEFT(DIM.InvoiceDate,11) AS InvoiceDate,
       DWC.Mileage, 
       DWC.ProblemDetails AS Problem_Details,    
       P.ProductCode AS Product_Code,       
       P.ProductName AS Product_Name, 
       P.UnitPrice + P.ServiceCharge AS Total_Cost,
              CASE
                     WHEN Status = 0 THEN 'Pending'
                     WHEN Status = 1 THEN 'Approved'
                     WHEN Status = 2 THEN 'Cancel' END Approved_Status
FROM DealarWarrantyClaim DWC
       LEFT JOIN UserCustomer UC ON DWC.MasterCode = UC.CustomerCode AND UserType = 'SE'
       LEFT JOIN Customer C ON DWC.MasterCode = C.CustomerCode
       INNER JOIN DealarInvoiceDetails DID ON DWC.ChassisNo = DID.ChassisNo
       INNER JOIN Product BP ON DID.ProductCode = BP.ProductCode
       INNER JOIN DealarInvoiceMaster DIM ON DIM.InvoiceId = DID.InvoiceId
       LEFT JOIN (SELECT DCWarrantyId, ISNULL(P.PartNo, OP.SMSCode) ProductCode,ISNULL(P.ProductName,OP.ProductName) ProductName,(D.UnitPrice * Quantity) UnitPrice,ServiceCharge
					FROM DealarWarrantyClaimProduct D
					LEFT JOIN Product P  ON D.ProductCode = P.ProductCode
					LEFT JOIN OtherProduct OP ON D.ProductCode = CONVERT(VARCHAR, OP.ProductCode)) P ON DWC.DCWarrantyId = P.DCWarrantyId
GROUP BY DWC.ChassisNo, WCDate, Product_Code



SELECT 	MAX(UC.RegionName) AS RegionName, MAX(DWC.DCWarrantyId) AS WarrantyID, MAX(LEFT(DWC.WCDate,11))  AS WCDate, 
		MAX(LEFT(DWC.OccuranceDate,11)) AS OccuranceDate,
       	MAX(DWC.MasterCode) AS MasterCode, MAX(C.CustomerName) AS DealarName, MAX(DIM.CustomerName) AS CustomerName, 
       	MAX(BP.ProductCode) AS BikeCode, MAX(BP.ProductName) AS BikeName, MAX(DWC.ChassisNo) AS ChassisNo, 
       	MAX(LEFT(DIM.InvoiceDate,11)) AS InvoiceDate,
       	MAX(DWC.Mileage) AS Mileage, 
       	MAX(DWC.ProblemDetails) AS Problem_Details,    
       	MAX(P.ProductCode) AS Product_Code,       
       	MAX(P.ProductName) AS Product_Name, 
       	MAX(P.UnitPrice + P.ServiceCharge) AS Total_Cost,
        MAX(CASE
	             WHEN Status = 0 THEN 'Pending'
	             WHEN Status = 1 THEN 'Approved'
	             WHEN Status = 2 THEN 'Cancel' END) AS Approved_Status
FROM DealarWarrantyClaim DWC
       LEFT JOIN UserCustomer UC ON DWC.MasterCode = UC.CustomerCode AND UserType = 'SE'
       LEFT JOIN Customer C ON DWC.MasterCode = C.CustomerCode
       INNER JOIN DealarInvoiceDetails DID ON DWC.ChassisNo = DID.ChassisNo
       INNER JOIN Product BP ON DID.ProductCode = BP.ProductCode
       INNER JOIN DealarInvoiceMaster DIM ON DIM.InvoiceId = DID.InvoiceId
       LEFT JOIN (SELECT DCWarrantyId, ISNULL(P.PartNo, OP.SMSCode) ProductCode,ISNULL(P.ProductName,OP.ProductName) ProductName,(D.UnitPrice * Quantity) UnitPrice,ServiceCharge
					FROM DealarWarrantyClaimProduct D
					LEFT JOIN Product P  ON D.ProductCode = P.ProductCode
					LEFT JOIN OtherProduct OP ON D.ProductCode = CONVERT(VARCHAR, OP.ProductCode)) P ON DWC.DCWarrantyId = P.DCWarrantyId
GROUP BY DWC.ChassisNo, DWC.WCDate



SELECT 	UC.RegionName, 'Warranty Claim' ServiceType,    DWC.DCWarrantyId, 
		Convert(Varchar(10),DWC.WCDate,120) AS WCDate,
		Convert(Varchar(10),DWC.OccuranceDate,120) AS OccurenceDate,
       	DWC.MasterCode,      
       	C.CustomerName AS DealarName,DIM.CustomerName, BP.ProductCode AS BikeCode, 
       	BP.ProductName AS BikeName,DWC.ChassisNo, 
       	Convert(Varchar(10),DIM.InvoiceDate,120) AS InvoiceDate,
       	DWC.Mileage, 
       	DWC.ProblemDetails AS Problem_Details,    
       	P.ProductCode AS Product_Code,       
       	P.ProductName AS Product_Name, 
       	P.UnitPrice + P.ServiceCharge AS Total_Cost
FROM DealarWarrantyClaim DWC
       LEFT JOIN UserCustomer UC ON DWC.MasterCode = UC.CustomerCode AND UserType = 'SE'
       LEFT JOIN Customer C ON DWC.MasterCode = C.CustomerCode
       INNER JOIN DealarInvoiceDetails DID ON DWC.ChassisNo = DID.ChassisNo
       INNER JOIN Product BP ON DID.ProductCode = BP.ProductCode
       INNER JOIN DealarInvoiceMaster DIM ON DIM.InvoiceId = DID.InvoiceId
       LEFT JOIN (SELECT DCWarrantyId, ISNULL(P.PartNo, OP.SMSCode) ProductCode,ISNULL(P.ProductName,OP.ProductName) ProductName,(D.UnitPrice * Quantity) UnitPrice,ServiceCharge
					FROM DealarWarrantyClaimProduct D
					LEFT JOIN Product P  ON D.ProductCode = P.ProductCode
					LEFT JOIN OtherProduct OP ON D.ProductCode = CONVERT(VARCHAR, OP.ProductCode)) P ON DWC.DCWarrantyId = P.DCWarrantyId
WHERE Status = 1


SELECT PageID FROM PageMaster pm
WHERE PageName = 'dettolbd'


INSERT INTO PageMaster 
VALUES('TestPageName', 'TestPageLink')
SELECT SCOPE_IDENTITY()
       
       
SELECT 	BP.ProductCode AS BikeCode, 
       	BP.ProductName AS BikeName,
       	P.ProductCode AS Part_Code,
       	P.ProductName AS Part_Name
FROM DealarWarrantyClaim DWC
       LEFT JOIN UserCustomer UC ON DWC.MasterCode = UC.CustomerCode AND UserType = 'SE'
       LEFT JOIN Customer C ON DWC.MasterCode = C.CustomerCode
       INNER JOIN DealarInvoiceDetails DID ON DWC.ChassisNo = DID.ChassisNo
       INNER JOIN Product BP ON DID.ProductCode = BP.ProductCode
       INNER JOIN DealarInvoiceMaster DIM ON DIM.InvoiceId = DID.InvoiceId
       LEFT JOIN (SELECT DCWarrantyId, ISNULL(P.PartNo, OP.SMSCode) ProductCode,ISNULL(P.ProductName,OP.ProductName) ProductName,(D.UnitPrice * Quantity) UnitPrice,ServiceCharge
					FROM DealarWarrantyClaimProduct D
					LEFT JOIN Product P  ON D.ProductCode = P.ProductCode
					LEFT JOIN OtherProduct OP ON D.ProductCode = CONVERT(VARCHAR, OP.ProductCode)) P ON DWC.DCWarrantyId = P.DCWarrantyId
WHERE Status = 1
GROUP BY BP.ProductCode, BP.ProductName, P.ProductCode, P.ProductName


SELECT 	DWC.DCWarrantyId, 
       	DWC.ProblemDetails AS ProblemDetails
FROM DealarWarrantyClaim DWC
       LEFT JOIN UserCustomer UC ON DWC.MasterCode = UC.CustomerCode AND UserType = 'SE'
       LEFT JOIN Customer C ON DWC.MasterCode = C.CustomerCode
       INNER JOIN DealarInvoiceDetails DID ON DWC.ChassisNo = DID.ChassisNo
       INNER JOIN Product BP ON DID.ProductCode = BP.ProductCode
       INNER JOIN DealarInvoiceMaster DIM ON DIM.InvoiceId = DID.InvoiceId
       LEFT JOIN (SELECT DCWarrantyId, ISNULL(P.PartNo, OP.SMSCode) ProductCode,ISNULL(P.ProductName,OP.ProductName) ProductName,(D.UnitPrice * Quantity) UnitPrice,ServiceCharge
					FROM DealarWarrantyClaimProduct D
					LEFT JOIN Product P  ON D.ProductCode = P.ProductCode
					LEFT JOIN OtherProduct OP ON D.ProductCode = CONVERT(VARCHAR, OP.ProductCode)) P ON DWC.DCWarrantyId = P.DCWarrantyId
WHERE Status = 1
ORDER BY DCWarrantyId


SELECT COUNT(DISTINCT DCWarrantyId) AS NumOfWarrantyIDs, COUNT(DISTINCT ProblemDetails) AS NumOfProblemDetails
FROM ProblemDetailsMaster pdm 


SELECT ProblemDetails, COUNT(DISTINCT DCWarrantyId) AS Entries
FROM ProblemDetailsMaster pdm 
GROUP BY ProblemDetails 
ORDER BY Entries DESC


SET NOCOUNT ON
DECLARE @NEWID TABLE(ID INT)
INSERT INTO PageMaster (PageName, PageLink)
OUTPUT inserted.PageID INTO @NEWID(ID)
VALUES('TestPageName', 'TestPageLink')
SELECT ID FROM @NEWID


DELETE FROM PageMaster 
DELETE FROM PostMaster 
DELETE FROM PostDetails 
DELETE FROM CommenterMaster 
DELETE FROM CommentMaster 
DELETE FROM ReplyMaster 


TRUNCATE TABLE PageMaster 
TRUNCATE TABLE PostMaster 
TRUNCATE TABLE PostDetails 
TRUNCATE TABLE CommenterMaster 
TRUNCATE TABLE CommentMaster 
TRUNCATE TABLE ReplyMaster 


SELECT CUSTOMER_CODE, CAST(AMOUNT AS int) AS AMOUNT, PERIOD 
FROM LapseDB.dbo.NEXT_MONTH_PURCHASE_AMOUNT nmpa
WHERE AMOUNT > 0
ORDER BY AMOUNT DESC


SELECT COUNT(DISTINCT CustomerCode)
FROM LapsCustomerShoppingHistory lcsh 


SELECT COUNT(DISTINCT CustomerCode)
FROM LapseDetails ld 
WHERE TrainingId = 2 AND PredictedGroup = 1

SELECT CommenterLinkID 
FROM CommenterMaster cm 
WHERE Location LIKE 'location'
AND HomeTown LIKE 'hometown'
AND Study LIKE 'study'
AND Profession LIKE 'profession'
AND MarritalStatus LIKE 'marital_status' 


CREATE TABLE #Res
(CustomerCode VARCHAR(20),
AMOUNT FLOAT,
ForecastPeriod INT, 
TrainingId INT,
)


SELECT pad2.CustomerCode, pad2.AMOUNT, fpd.ForecastPeriod, pad2.TrainingId 
INTO #Res
FROM PurchaseAmountDetails pad2 
INNER JOIN ForecastedPeriodDetails fpd 
ON pad2 .CustomerCode = fpd.CustomerCode 


SELECT  cs.GroupRange AS Slab, COUNT(lcsh.CustomerCode) AS NoOfCustomers
FROM LapsCustomerShoppingHistory lcsh 
INNER JOIN CustomerSlab cs 
ON lcsh.SlabId = cs.CustomerGroup
GROUP BY lcsh.SlabId, cs.GroupRange 
ORDER BY lcsh.SlabId 


SELECT ForecastPeriod, COUNT(DISTINCT CustomerCode) FROM ForecastedPeriodDetails fpd
WHERE TrainingId = '1'
GROUP BY ForecastPeriod


SELECT TOP 10 CustomerCode, CAST(AMOUNT AS INT) AS AMOUNT FROM #Res
WHERE ForecastPeriod='0'
ORDER BY AMOUNT DESC


SELECT COUNT(DISTINCT CustomerCode) FROM #Res
WHERE ForecastPeriod='0'


DROP TABLE #temp
SELECT pad2.CustomerCode, pad2.AMOUNT, fpd.ForecastPeriod, pad2.TrainingId 
INTO #temp
FROM PurchaseAmountDetails pad2 
INNER JOIN ForecastedPeriodDetails fpd 
ON pad2 .CustomerCode = fpd.CustomerCode
WHERE ForecastPeriod = 0 AND fpd.TrainingId = 1
SELECT TOP 10 * FROM #temp


SELECT pad2.CustomerCode, CAST(pad2.AMOUNT AS INT) AS AMOUNT
FROM PurchaseAmountDetails pad2 
INNER JOIN ForecastedPeriodDetails fpd 
ON pad2 .CustomerCode = fpd.CustomerCode
WHERE ForecastPeriod = 0 AND fpd.TrainingId = 1
ORDER BY AMOUNT DESC


DROP TABLE #temp
SELECT pad2.CustomerCode, CAST(pad2.AMOUNT AS INT) AS AMOUNT
INTO #temp
FROM PurchaseAmountDetails pad2 
INNER JOIN ForecastedPeriodDetails fpd 
ON pad2 .CustomerCode = fpd.CustomerCode
WHERE ForecastPeriod = 0 AND fpd.TrainingId = 1
ORDER BY AMOUNT DESC

ALTER TABLE #temp
ADD SlabID INT

update #temp 
SET SlabId = CustomerGroup
FROM #temp lh, CustomerSlab cg
WHERE lh.AMOUNT >= cg.GroupMin AND lh.AMOUNT < cg.GroupMax  

SELECT  cs.GroupRange AS Slab, COUNT(lcsh.CustomerCode) AS NoOfCustomers
FROM #temp lcsh 
INNER JOIN CustomerSlab cs 
ON lcsh.SlabId = cs.CustomerGroup
GROUP BY lcsh.SlabId, cs.GroupRange 
ORDER BY lcsh.SlabId 


SELECT fpd.ForecastPeriod as ForecastedPeriod, COUNT(DISTINCT pad2.CustomerCode) as NumOfCustomer, SUM(pad2.AMOUNT) AS Amount
FROM PurchaseAmountDetails pad2 
INNER JOIN ForecastedPeriodDetails fpd 
ON pad2 .CustomerCode = fpd.CustomerCode 
WHERE fpd.TrainingId = 1 
GROUP BY fpd.ForecastPeriod 
ORDER BY fpd.ForecastPeriod

SELECT fp.PeriodRange as ForecastedPeriod, COUNT(DISTINCT pad2.CustomerCode) as NumOfCustomer, SUM(pad2.AMOUNT) AS Amount
FROM PurchaseAmountDetails pad2 
INNER JOIN ForecastedPeriodDetails fpd 
ON pad2 .CustomerCode = fpd.CustomerCode 
INNER JOIN ForecastPeriod fp 
ON fp.ForecastingPeriod = fpd.ForecastPeriod 
WHERE fpd.TrainingId = 1 
GROUP BY fp.PeriodRange, fp.ForecastingPeriod 
ORDER BY fp.ForecastingPeriod


SELECT 	DWC.DCWarrantyId, 
       	DWC.ProblemDetails AS ProblemDetails,
       	P.ProductCode AS Part_Code,
       	P.ProductName AS Part_Name
FROM DealarWarrantyClaim DWC
       LEFT JOIN UserCustomer UC ON DWC.MasterCode = UC.CustomerCode AND UserType = 'SE'
       LEFT JOIN Customer C ON DWC.MasterCode = C.CustomerCode
       INNER JOIN DealarInvoiceDetails DID ON DWC.ChassisNo = DID.ChassisNo
       INNER JOIN Product BP ON DID.ProductCode = BP.ProductCode
       INNER JOIN DealarInvoiceMaster DIM ON DIM.InvoiceId = DID.InvoiceId
       LEFT JOIN (SELECT DCWarrantyId, ISNULL(P.PartNo, OP.SMSCode) ProductCode,ISNULL(P.ProductName,OP.ProductName) ProductName,(D.UnitPrice * Quantity) UnitPrice,ServiceCharge
					FROM DealarWarrantyClaimProduct D
					LEFT JOIN Product P  ON D.ProductCode = P.ProductCode
					LEFT JOIN OtherProduct OP ON D.ProductCode = CONVERT(VARCHAR, OP.ProductCode)) P ON DWC.DCWarrantyId = P.DCWarrantyId
WHERE Status = 1
ORDER BY DCWarrantyId



