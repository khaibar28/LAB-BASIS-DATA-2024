-- Nomor 1
SELECT c.customerName, CONCAT(firstname, ' ', lastname) AS salesRep, (c.creditLimit - SUM(p.amount)) AS remainingCredit
FROM customers AS c
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments AS p
USING(customernumber)
GROUP BY c.customerName
HAVING remainingCredit > 0;

-- Nomor 2
SELECT pd.productName AS 'Nama Produk', GROUP_CONCAT(DISTINCT c.customerName) AS 'Nama Customer', COUNT(DISTINCT c.customerName) AS 'Jumlah Customer', SUM(od.quantityOrdered) AS 'Total Quantitas'
FROM products AS pd
JOIN orderdetails AS od
USING(productcode)
JOIN orders AS o
USING(ordernumber)
JOIN customers AS c
USING(customernumber)
GROUP BY pd.productName;

-- Nomor 3
SELECT CONCAT(firstname, ' ', lastname) AS employeeName, COUNT(c.customerName) AS totalCustomers
FROM employees AS e
JOIN customers AS c
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY employeeName
ORDER BY totalCustomers DESC;

-- Nomor 4
SELECT CONCAT(e.firstname, ' ', e.lastName) AS 'Nama Karyawan', p.productName AS 'Nama Produk', SUM(od.quantityOrdered) AS 'Jumlah Pesanan' 
FROM products AS p
JOIN orderdetails AS od
USING(productcode)
JOIN orders AS o
USING(ordernumber)
JOIN customers AS c
USING(customernumber)
RIGHT JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS ofs
USING(officecode)
WHERE ofs.country = 'Australia'
GROUP BY e.employeeNumber, p.productName
ORDER BY SUM(od.quantityOrdered) DESC;

-- Nomor 5
SELECT c.customerName AS 'Nama Karyawan', GROUP_CONCAT(DISTINCT p.productName ORDER BY p.productName) AS 'Nama Produk', COUNT(DISTINCT p.productName) AS 'Banyak Jenis Produk'
FROM customers AS c
JOIN orders AS o
USING(customernumber)
JOIN orderdetails AS od
USING(ordernumber)
JOIN products AS p
USING(productcode)
WHERE o.shippedDate IS NULL
GROUP BY c.customername;