-- H071231032

-- No. 1
SELECT p.productCode,
	p.productName,
	p.buyPrice
FROM products p
WHERE buyPrice > (SELECT AVG(buyPrice) from products);


-- No. 2
SELECT o.orderNumber,
	o.orderDate
FROM orders o
JOIN customers c USING (customerNumber)
JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE e.officeCode IN (
	SELECT ofc.officeCode FROM offices ofc
	WHERE ofc.city = 'Tokyo'
);


-- No. 3
SELECT c.customerName,
	o.orderNumber,
	o.shippedDate, 
	o.requiredDate, 
	GROUP_CONCAT(p.productName SEPARATOR ', ') products,
	SUM(od.quantityOrdered) total_quantity_ordered,
	CONCAT(e.firstName, ' ', e.lastName) employeeName
FROM customers c
JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON o.customerNumber = c.customerNumber
JOIN orderdetails od ON od.orderNumber = o.orderNumber
JOIN products p ON p.productCode = od.productCode
WHERE o.shippedDate > o.requiredDate
GROUP BY c.customerNumber, o.orderNumber;

-- No. 4
SELECT p.productName,
	p.productLine,
	SUM(od.quantityOrdered) total_quantity_ordered
FROM products p
JOIN orderdetails od ON od.productCode = p.productCode
JOIN (
	SELECT p2.productLine FROM products p2
	JOIN orderdetails od2 ON od2.productCode = p2.productCode
	GROUP BY p2.productLine
	ORDER BY SUM(od2.quantityOrdered) DESC
	LIMIT 3
) top3ProductLine USING (productLine)
GROUP BY p.productCode
ORDER BY p.productLine, total_quantity_ordered DESC;

-- Live Coding
SELECT c.customerName, sum(od.quantityOrdered * p.buyPrice) uangHabis, p.productName 
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
WHERE p.productCode = (
	SELECT p2.productCode FROM products p2
	JOIN orderdetails od2 ON od2.productCode = p2.productCode
	GROUP BY p2.productCode
	ORDER BY SUM(od2.quantityOrdered) DESC
	LIMIT 1
)
group by c.customerNumber, p.productCode
ORDER by c.customerName;


