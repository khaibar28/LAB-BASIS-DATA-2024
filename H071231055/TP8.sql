-- Nomor 1
(SELECT p.productName, SUM(od.priceEach * od.quantityOrdered) AS TotalRevenue, 'Pendapatan Tinggi' AS Pendapatan
FROM products p
JOIN orderdetails od
USING(productcode)
JOIN orders o 
USING(ordernumber)
WHERE MONTH(o.orderDate) = 9
GROUP BY p.productName
ORDER BY TotalRevenue DESC 
LIMIT 5)
UNION 
(SELECT p.productName, SUM(od.priceEach * od.quantityOrdered) AS TotalRevenue, 'Pendapatan Tinggi' AS Pendapatan
FROM products p
JOIN orderdetails od
USING(productcode)
JOIN orders o
USING(ordernumber)
WHERE MONTH(o.orderDate) = 9
GROUP BY p.productName
ORDER BY TotalRevenue ASC 
LIMIT 5);

-- Nomor 2
SELECT productName 
FROM products
WHERE productCode NOT IN (
    SELECT od.productCode 
    FROM orderdetails od
    JOIN orders o 
    USING(orderNumber)
    WHERE o.customerNumber IN (
        SELECT c.customerNumber 
        FROM customers c
        JOIN orders o
        USING(customerNumber)
        GROUP BY c.customerNumber
        HAVING COUNT(o.orderNumber) > 10
        INTERSECT 
        SELECT c.customerNumber 
        FROM customers c
        JOIN orders o
        USING(customerNumber)
        JOIN orderdetails od 
        USING(orderNumber)
        JOIN products p 
        USING(productCode)
        WHERE p.buyPrice > (SELECT AVG(buyPrice) FROM products)
    )
);

-- Nomor 3
 SELECT c.customerName
FROM customers c
JOIN payments p
USING(customerNumber)
GROUP BY c.customerName
HAVING SUM(p.amount) > 2 * (SELECT AVG(totalAmount)
								    FROM (SELECT DISTINCT SUM(amount) AS totalAmount FROM payments p2
								        	GROUP BY customerNumber
								    ) AS hasil
)
INTERSECT
SELECT c.customerName
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od 
USING(orderNumber)
JOIN products pd
USING(productCode)
WHERE pd.productLine IN ('Planes', 'Trains')
GROUP BY c.customerName
HAVING SUM(od.priceEach * od.quantityOrdered) > 20000;

-- Nomor 4
SELECT 
    o.orderDate AS 'Tanggal',
    c.customerNumber AS 'CustomerNumber',
    'Membayar Pesanan dan Memesan Barang' AS 'riwayat'
FROM orders o
JOIN customers c USING (customerNumber)
JOIN payments p ON o.orderDate = p.paymentDate
HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
UNION
SELECT 
    orderDate, 
    customerNumber,
    'Memesan Barang' 
FROM orders
WHERE MONTH(orderDate) = 09 AND YEAR(orderDate) = 2003
AND orderDate NOT IN (  
	SELECT o.orderDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)
UNION
SELECT 
    paymentDate, 
    customerNumber, 
    'Membayar Pesanan' FROM payments
WHERE MONTH(paymentDate) = 09 AND YEAR(paymentDate) = 2003
AND paymentDate NOT IN (  
	SELECT p.paymentDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)
ORDER BY Tanggal;

-- Nomor 5
SELECT p.productCode
FROM products p
JOIN orderdetails od
USING(productCode)
WHERE od.priceEach > (
    SELECT AVG(od2.priceEach) 
    FROM orderdetails od2
    JOIN orders o2 
    USING(orderNumber)
    WHERE o2.orderDate BETWEEN '2001-01-01' AND '2004-03-31'
) 
AND od.quantityOrdered > 48
AND LEFT(p.productVendor, 1) IN ('a', 'e', 'i', 'o', 'u')
EXCEPT
SELECT p.productCode 
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o 
USING(orderNumber)
JOIN customers c
USING(customerNumber)
WHERE c.country IN ('Japan', 'germany', 'Italy');

-- Study Case
SELECT `Nama Karyawan/Pelanggan`, status FROM (
(SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan/Pelanggan' , 'Karyawan' AS Status
FROM offices 
JOIN employees e
USING(officecode)
WHERE officeCode IN (SELECT officecode FROM offices
							JOIN employees e
							USING(officecode)
							GROUP BY officecode
							HAVING COUNT(e.employeeNumber) = (SELECT COUNT(employeeNumber) AS total FROM employees
													JOIN offices 
													USING(officecode) 
													GROUP BY officeCode
													ORDER BY total
													LIMIT 1)
							))
UNION 
(SELECT c.customerName AS 'Nama Karyawan/Pelanggan' , 'Pelanggan' AS Status
FROM offices 
JOIN employees e
USING(officecode)
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE officeCode IN (SELECT officecode FROM offices
							JOIN employees e
							USING(officecode)
							GROUP BY officecode
							HAVING COUNT(e.employeeNumber) = (SELECT COUNT(employeeNumber) AS total FROM employees
													JOIN offices 
													USING(officecode) 
													GROUP BY officeCode
													ORDER BY total
													LIMIT 1)
							))) AS haha
ORDER BY `Nama Karyawan/Pelanggan` ASC;