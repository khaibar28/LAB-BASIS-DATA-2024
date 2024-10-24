-- nomor 1

SELECT 
	p.productCode,
	p.productName,
	p.buyPrice

FROM products p
WHERE p.buyPrice > (
	SELECT AVG(buyPrice) FROM products
);

-- nomor 2

SELECT 
    o.orderNumber,
    o.orderDate
FROM orders o
JOIN customers c USING(customerNumber)
JOIN employees em ON c.salesRepEmployeeNumber = em.employeeNumber
JOIN offices f USING(officeCode)
WHERE f.city = (
    SELECT city FROM offices
    WHERE city = 'Tokyo'
    LIMIT 1
)
AND em.jobTitle = (
    SELECT jobTitle FROM employees
    WHERE jobTitle = 'Sales Rep'
    LIMIT 1
);



-- nomor 3

SELECT 
    (SELECT c.customerName FROM customers c WHERE c.customerNumber = o.customerNumber) AS customerName,
    o.orderNumber,
    o.shippedDate,
    o.requiredDate,
    (SELECT GROUP_CONCAT(p.productName SEPARATOR ', ') 
     FROM orderdetails od 
     JOIN products p ON od.productCode = p.productCode 
     WHERE od.orderNumber = o.orderNumber) AS productNames,
    (SELECT SUM(od.quantityOrdered) 
     FROM orderdetails od 
     WHERE od.orderNumber = o.orderNumber) AS totalQuantityOrdered,
    (SELECT SUM(od.priceEach * od.quantityOrdered) 
     FROM orderdetails od 
     WHERE od.orderNumber = o.orderNumber) AS totalPrice,
    (SELECT CONCAT(em.firstName, ' ', em.lastName) 
     FROM employees em 
     JOIN customers c ON c.salesRepEmployeeNumber = em.employeeNumber 
     WHERE c.customerNumber = o.customerNumber) AS salesRepName
FROM orders o
WHERE o.shippedDate > o.requiredDate

SELECT 
    c.customerName,
    o.orderNumber,
    o.shippedDate,
    o.requiredDate,
    GROUP_CONCAT(p.productName SEPARATOR ', ') AS Nama_Produk,
    SUM(od.quantityOrdered) AS totalQuantityOrdered,
    SUM(od.priceEach * od.quantityOrdered) AS totalPrice,
    CONCAT(e.firstName, ' ', e.lastName) AS salesRepName
FROM
    orders o
JOIN
    customers c ON o.customerNumber = c.customerNumber
JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
JOIN
    products p ON od.productCode = p.productCode
JOIN
    employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.shippedDate > o.requiredDate;


SELECT
    o.orderNumber AS Nomor_Pesanan,
    c.customerName AS Nama_Pelanggan,
    o.requiredDate AS Tanggal_Diminta,
    o.shippedDate AS Tanggal_Pengiriman,
    p.productName AS Nama_Produk,
    od.quantityOrdered AS Jumlah_Produk,
    e.firstName AS Nama_Karyawan,
FROM
    orders o
JOIN
    customers c ON o.customerNumber = c.customerNumber
JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
JOIN
    products p ON od.productCode = p.productCode
JOIN
    employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE
    o.shippedDate > o.requiredDate
GROUP	BY p.productName
ORDER BY 
    p.productName, (o.shippedDate - o.requiredDate), od.quantityOrdered DESC;



-- nomor 4

SELECT 
    p.productName,
    p.productLine AS productCategory,
    SUM(od.quantityOrdered) AS totalQuantity
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN (
    SELECT 
        p2.productLine,
        SUM(od2.quantityOrdered) AS totalCategoryQuantity
    FROM products p2
    JOIN orderdetails od2 ON p2.productCode = od2.productCode
    GROUP BY p2.productLine
    ORDER BY totalCategoryQuantity DESC
    LIMIT 3
) AS topCategories ON p.productLine = topCategories.productLine
GROUP BY p.productName, p.productLine
ORDER BY topCategories.totalCategoryQuantity DESC, totalQuantity DESC;


coba tampilkan nama cutomer dan total jumlah pesanan tiap produk yang dipesan 
untuk orang yang melakukan orderan paling banyak 

tampilkan customer
total jumlah pesanan setiap produk

SELECT 
	customerName,
	(SELECT COUNT(distinct o.orderNumber)
     FROM orders o
     JOIN customers c USING(CustomerNumber)
     WHERE o.orderNumber = c.customerNumber) AS 'Total Pesanan'
FROM customers 
GROUP BY customerNumber
ORDER BY sum(od.quantityOrdered) DESC 





SELECT 
	c.customerName,
	s.productName,
	sum(quantityOrdered) AS 'Total_Pesanan'
FROM customers c
JOIN orders USING(customerNumber)
JOIN orderdetails USING(orderNumber)
JOIN products s USING(productCode)
WHERE c.customerNumber = 
	( SELECT 
	c.customerNumber
		FROM customers c
	JOIN orders o USING(CustomerNumber)
	GROUP BY c.customerNumber
	ORDER BY COUNT(o.orderNumber) DESC 
	LIMIT 1)
GROUP BY s.productCode
