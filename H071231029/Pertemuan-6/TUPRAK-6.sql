## PRAKTIKUM 6

USE classicmodels

SELECT customerName,


SELECT * FROM products 



##1
SELECT c.customerName, 
CONCAT(s.firstName, ' ', s.lastName) AS salesRepName, c.creditLimit - SUM(p.amount) AS remainingCredit
FROM customers AS c
JOIN employees AS s ON c.salesRepEmployeeNumber = s.employeeNumber
JOIN payments  AS p  ON c.customerNumber = p.customerNumber
GROUP BY c.customerName, salesRepName, c.creditLimit
HAVING remainingCredit >= 0
ORDER BY c.customerName;


## 2
SELECT p.productName AS 'Nama Produk', GROUP_CONCAT(DISTINCT c.customerName SEPARATOR ', ') AS 'Nama Customer',
COUNT(DISTINCT c.customerNumber) AS 'Jumlah Customer',
SUM(od.quantityOrdered) AS 'Total Quantitas'
FROM products p
JOIN orderdetails od ON od.productCode = p.productCode
JOIN orders o ON o.orderNumber = od.orderNumber
JOIN customers c ON c.customerNumber = o.customerNumber
GROUP BY p.productCode, p.productName
ORDER BY p.productName



## 3
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'employeeName', COUNT(c.customerNumber) AS 'totalCustomers'
FROM employees e
JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY e.employeeNumber, e.firstName, e.lastName
ORDER BY totalCustomers DESC;




## 4
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan', p.ProductName AS 'Nama Produk', SUM(od.QuantityOrdered) AS 'Jumlah Pesanan'
FROM employees e
LEFT JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders AS o  ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
LEFT JOIN products AS p ON od.productCode = p.productCode
WHERE e.officeCode = 6
GROUP BY e.firstName, e.lastName, p.ProductName
ORDER BY SUM(od.quantityOrdered) DESC;
  
  
## 5
SELECT c.customerName AS 'Nama Pelanggan', GROUP_CONCAT(DISTINCT p.productName SEPARATOR ', ') AS 'Nama Produk', COUNT(DISTINCT p.productCode) AS 'Banyak Jenis Produk'
FROM customers AS c
JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN products AS p ON od.productCode = p.productCode
WHERE o.shippedDate IS NULL 
GROUP BY c.customerNumber, c.customerName
ORDER BY c.customerName ASC


## 6
SELECT  CONCAT(e.firstName,' ',e.lastName) AS 'Nama Karyawan', p.productName , SUM(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM employees e
JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o ON o.customerNumber = c.customerNumber
JOIN orderdetails od ON od.orderNumber = o.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE MONTH(o.orderDate) % 2 != 0   	
GROUP BY p.productName





