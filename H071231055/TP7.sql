-- Nomor 1
SELECT productcode, productname, buyprice
FROM products pd
WHERE buyprice > (
	SELECT AVG(buyprice) FROM products pd2
);

-- Nomor 2
SELECT o.orderNumber, o.orderDate
FROM orders o
JOIN customers c
USING(customernumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices ofs
USING(officecode)
WHERE ofs.city = (
	SELECT city 
	FROM offices
	WHERE city = 'Tokyo'
);

-- Nomor 3
SELECT c.customerName, o.orderNumber, o.shippedDate, o.requiredDate, 
	GROUP_CONCAT(productName) AS 'products', 
	SUM(od.quantityOrdered) AS total_quantity_ordered, 
	CONCAT(firstname, ' ', lastname) AS employeeName
FROM products pd
JOIN orderdetails od
USING(productcode)
JOIN orders o
USING(ordernumber)
JOIN customers c
USING(customernumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.orderNumber = (
	SELECT ordernumber 
	FROM orders
	WHERE requiredDate < shippedDate
);

-- Nomor 4
SELECT 
   p.productName,
   top.productline,
   SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od 
ON od.productCode = p.productCode
JOIN (
   SELECT 
      p2.productLine,
      SUM(od2.quantityOrdered) AS total_quantity_ordered
   FROM products p2
   JOIN orderdetails od2 
	ON od2.productCode = p2.productCode
   GROUP BY p2.productLine
   ORDER BY total_quantity_ordered DESC
   LIMIT 3
) AS top 
ON p.productLine = top.productLine
GROUP BY p.productName, p.productLine
ORDER BY p.productLine, total_quantity_ordered DESC;

-- STUDY CASE
SELECT ofs.city AS Kota, SUM(p.amount) AS Pendapatan
FROM payments p
JOIN customers c
USING(customernumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices ofs
USING(officecode)
WHERE ofs.city IN 
	((SELECT ofs2.city AS Kota
	FROM payments p
	JOIN customers c
	USING(customernumber)
	JOIN employees e
	ON c.salesRepEmployeeNumber = e.employeeNumber
	JOIN offices ofs2
	USING(officecode)
	GROUP BY ofs2.city
	ORDER BY SUM(p.amount) ASC
	LIMIT 1),
	(SELECT ofs.city AS Kota
	FROM payments p
	JOIN customers c
	USING(customernumber)
	JOIN employees e
	ON c.salesRepEmployeeNumber = e.employeeNumber
	JOIN offices ofs
	USING(officecode)
	GROUP BY ofs.city
	ORDER BY SUM(p.amount) DESC
	LIMIT 1))
GROUP BY ofs.city;