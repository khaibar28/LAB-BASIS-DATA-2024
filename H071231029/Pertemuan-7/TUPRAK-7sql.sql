#Tugas Praktikum 7
USE classicmodels;

#Nomor 1
SELECT
	products.productCode,
	products.productName,
	products.buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice)
						FROM products);
						
#Nomor 2
SELECT
	orders.orderNumber,
	orders.orderDate
FROM orders
JOIN customers
ON customers.customerNumber = orders.customerNumber
WHERE customers.salesRepEmployeeNumber IN (SELECT employeeNumber
					FROM employees
					JOIN offices
					ON offices.officeCode = employees.officeCode
					WHERE offices.city = "Tokyo");


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


#Nomor 4
SELECT
	productName,
	productLine,
	SUM(quantityOrdered) AS total_quantity_ordered
FROM products
JOIN orderdetails
ON products.productCode = orderdetails.productCode
WHERE productLine IN(SELECT
								productLine
							FROM (SELECT
										productLine,
										SUM(o2.quantityOrdered) AS totalQuantity
									FROM products p2
									JOIN orderdetails o2
									ON p2.productCode = o2.productCode
									GROUP BY p2.productLine
									ORDER BY totalQuantity DESC
									LIMIT 3) AS topProductLines)
GROUP BY productName, productLine
ORDER BY productLine ASC, `total_quantity_ordered` DESC;



##Tampilkan customer dan banyak uang yang dia habiskan untuk product yang paling laris

SELECT * FROM products
SELECT * FROM payments

## workbench 

SELECT c.customerName,  p.productName, SUM(od.quantityOrdered * p.buyPrice)  AS 'Banya Uang dihabiskan'
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON od.orderNumber = o.orderNumber
JOIN products p ON p.productCode = od.productCode
WHERE p.productCode = 
		(SELECT productCode FROM products
		JOIN orderdetails od USING(productcode) 
		GROUP BY productCode
		ORDER BY SUM(quantityOrdered ) DESC LIMIT 1)
GROUP BY c.customerName
		





 







-- EKSPERIMEN
