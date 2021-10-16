--1.
SELECT TreatmentId, TreatmentName
FROM MsTreatment
WHERE TreatmentId IN('TM001','TM002')

--2.
SELECT TreatmentName,Price
FROM MsTreatment mt
JOIN MsTreatmentType tm
ON mt.TreatmentTypeId = tm.TreatmentTypeId
WHERE TreatmentTypeName NOT IN('Message / Spa')
	AND TreatmentTypeName NOT IN('Hair Treatment')

--3.
SELECT CustomerName, CustomerPhone, CustomerAddress
FROM MsCustomer c
JOIN HeaderSalonServices hs
ON hs.CustomerId = c.CustomerId
WHERE LEN(CustomerName) > 8
	  AND DATENAME(WEEKDAY,TransactionDate) IN('Friday')

--5.
SELECT StaffName, CustomerName, 
		TransactionDate = CONVERT(varchar,TransactionDate,107)
FROM MsStaff s
JOIN HeaderSalonServices hs
ON hs.StaffId = s.StaffId
JOIN MsCustomer c
ON c.CustomerId = hs.CustomerId
JOIN DetailSalonServices ds
ON ds.TransactionId = hs.TransactionId
WHERE CAST(RIGHT(TreatmentID,1) AS INT) %2 = 0
	AND EXISTS 
	(
	SELECT TreatmentId
	FROM DetailSalonServices
	WHERE CAST(RIGHT(TreatmentID,1) AS INT) %2 != 0
	)

--8. //ALIAS SUBQUERY
SELECT [TreatmentTypeName] = tp.TreatmentTypeName,
	   [TreatmentName] = mt.TreatmentName,
	   [Price] = Price --untuk kolom yg ditampilkan
FROM MsTreatmentType tp, MsTreatment mt,
(
	SELECT 'AVGkolom' = AVG(Price)
	FROM MsTreatment
) AS AVGtable
WHERE mt.TreatmentTypeId = tp.TreatmentTypeId
		AND Price > AVGtable.AVGkolom
SELECT * FROM MsTreatmentType
SELECT * FROM MsTreatment

--9. //ALIAS SUBQUERY
SELECT [StaffName],
	   [StaffPosition],
	   [StaffSalary]
FROM MsStaff,
(
	SELECT 'MaxKolom' = MAX(StaffSalary),
		   'MinKolom' = MIN(StaffSalary)
	FROM MsStaff
) AS MMTabel
WHERE StaffSalary = MMTabel.MaxKolom
	OR StaffSalary = MMTabel.MinKolom

--10. //ALIAS SUBQUERY
-- SUBQUERY dalam SUBQUERY dalam QUERY
-- START QUERY
SELECT CustomerName, CustomerPhone, CustomerAddress,
		[Count Treatment] = COUNT(TreatmentId)
FROM MsCustomer c,
	 DetailSalonServices ds,
	 HeaderSalonServices hs,
(
	SELECT 'MaxCount' = MAX(CountKolom) --MAX
	FROM 
	(
		SELECT 'CountKolom' = COUNT(TreatmentId) --COUNT
		FROM MsCustomer c,
			DetailSalonServices ds,
			HeaderSalonServices hs
		WHERE c.CustomerId = hs.CustomerId
			AND hs.TransactionId = ds.TransactionId
		GROUP BY c.CustomerId
	 ) AS CountTabel --ALIAS SUBQUERY 1
) AS MaxCountTabel --ALIAS SUBQUERY 2
WHERE c.CustomerId = hs.CustomerId
	AND hs.TransactionId = ds.TransactionId
GROUP BY c.CustomerName, --GROUP BY
		 c.CustomerPhone, c.CustomerAddress, MaxCountTabel.MaxCount
HAVING COUNT(TreatmentId) = MaxCountTabel.MaxCount
-- END QUERY

-- SUBSTRING ada 3 parameter
-- Parameter pertama nama kolom
-- Parameter kedua dimulai dari mana
-- Parameter ketiga berapa banyak huruf

--CHARINDEX = Mencari huruf berada di posisi ke berapa

--EXISTS utk subquery

--LEN = Mencari jumlah huruf

--IN sama seperti sama dengan
--StaffID IN('001', '002', '008')

--CONVERT = utk merubah tanggal (formatnya yg di ubah)

--DATENAME = namanya yg akan keluar

--NOT IN sama seperti tidak sama dengan