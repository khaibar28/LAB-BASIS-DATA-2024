-- NOMOR 1
SELECT DISTINCT 
	c.customerName, p.productName, pl.textDescription
FROM customers AS c
JOIN orders AS o
	USING (customernumber)
JOIN orderdetails AS od
	USING (ordernumber)
JOIN products AS p
	USING (productcode)
JOIN productlines AS pl
	USING (productline)
WHERE p.productname LIKE '%Titanic%'
ORDER BY c.customerName ASC;

-- NOMOR 2
SELECT c.customerName, p.productName, o.status, o.shippedDate
FROM customers AS c
JOIN orders AS o
	USING (customernumber)
JOIN orderdetails AS od
	USING (ordernumber)
JOIN products AS p
	USING (productcode)
WHERE p.productName LIKE '%Ferrari%' AND o.status LIKE '%Shipped%' AND o.shippedDate BETWEEN '2003-10-01' AND '2004-09-30'
ORDER BY o.shippedDate DESC;

-- NOMOR 3
SELECT s.firstName AS Supervisor, k.firstName AS Karyawan
FROM employees AS k
JOIN employees AS s
ON k.reportsTo = s.employeeNumber
WHERE s.firstName = 'Gerard'
ORDER BY k.firstname ASC;

-- NOMOR 4
-- Bagian a
SELECT c.customerName, p.paymentDate,e.firstName AS employeeName, p.amount
FROM payments AS p
JOIN customers AS c
USING (customernumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '____-11%';
 
--  Bagian b
SELECT c.customerName, p.paymentDate,e.firstName AS employeeName, p.amount
FROM payments AS p
JOIN customers AS c
USING (customernumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '____-11%'
ORDER BY p.amount DESC 
LIMIT 1;

--  Bagian c
SELECT c.customerName, pd.productName
FROM payments AS p
JOIN customers AS c
USING (customernumber)
JOIN orders AS o
USING (customernumber)
JOIN orderdetails AS od
USING (ordernumber)
JOIN products AS pd
USING (productcode)
WHERE c.customerName = 'Corporate Gift Ideas Co.' AND p.paymentDate LIKE '____-11%';

-- STUDY CASE
-- Nomor 3
SELECT c.customerName, o.orderNumber, o.orderDate, o.shippedDate, pd.productName, od.quantityOrdered,
 od.priceEach, os.city, e.firstName, e.lastName
FROM customers AS c
JOIN orders AS o
USING (customernumber)
JOIN orderdetails AS od
USING (ordernumber)
JOIN products AS pd
USING (productcode)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS os
USING (officecode)
WHERE pd.productName LIKE '2%o' 
AND o.orderDate > '2003-03-01' 
AND od.quantityOrdered > 15 
AND c.city = 'San Francisco' 
AND od.priceEach BETWEEN 50 AND 150
ORDER BY c.customerName AND o.orderDate DESC;