SELECT * FROM MsCustomer

-- 1. //CREATE VIEW, STUFF, LEN
GO
CREATE VIEW ViewBonus
AS
SELECT 'BinusId' = STUFF('CU', 1, 2, 'BN'),
		CustomerName
FROM MsCustomer
WHERE LEN(CustomerName) > 10
GO

--2. CREATE VIEW, SUBSTRING, CHARINDEX
GO
CREATE VIEW ViewCustomerData
AS
SELECT 
		'Name' = SUBSTRING(CustomerName,1, CHARINDEX(' ', CustomerName)),
		'Address' = CustomerAddress,
		'Phone' = CustomerPhone
FROM MsCustomer
WHERE CustomerName LIKE '% %'
GO

--3. 
SELECT *
		
FROM MsTreatmentType, MsTreatment

--8. CREATE VIEW, INSERT
GO
CREATE VIEW ViewCustomer
AS
SELECT CustomerId, 
CustomerName, 
CustomerGender, 
CustomerPhone, 
CustomerAddress
FROM MsCustomer
INSERT INTO ViewCustomer
SELECT 'CU006', 'Christian', 'Male', NULL, NULL

SELECT * FROM ViewCustomer