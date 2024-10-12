-- 1 
SELECT DISTINCT 
	customerName AS 'namaKustomer',
	productName AS 'namaProduct',
	textDescription
FROM customers
JOIN 
	orders 
ON customers.customerNumber = orders.customerNumber
JOIN 
	orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN 
	products
ON orderdetails.productCode = products.productCode
JOIN
	productLines
on products.productLine = productlines.productLine
WHERE productName LIKE '%Titanic%'
ORDER BY customerName ASC ;


-- nomor 2
SELECT 
	customerName,
	productName,
	STATUS,
	shippedDate
FROM customers
JOIN 
	orders
ON customers.customerNumber = orders.customerNumber
JOIN 
	orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN 
	products
ON orderdetails.productCode = products.productCode
WHERE productName LIKE '%Ferrari%' AND STATUS = 'shipped' AND shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY shippedDate DESC ;


-- nomor 3
SELECT 
	CONCAT(s.firstName, ' ', s.lastName) AS Supervisor,
   CONCAT(e.firstName, ' ', e.lastName) AS Karyawan
FROM employees AS e
JOIN employees AS s ON e.reportsTo = s.employeeNumber
WHERE s.firstName = 'Gerard'
ORDER BY Karyawan ASC ;

-- nomor 4

#A
SELECT 
    c.customerName,
    p.paymentDate,
    CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
    p.amount
FROM customers AS c
JOIN payments AS p ON c.customerNumber = p.customerNumber
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE paymentDate LIKE '%-11-%'

#B
ORDER BY p.amount DESC LIMIT 1;

#C
SELECT 
	c.customerName,
	pn.productName
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails
ON o.orderNumber = orderdetails.orderNumber
JOIN products pn
ON orderdetails.productCode = pn.productCode
WHERE customerName = 'Corporate Gift Ideas Co.';


SELECT 
    concat(e.firstName, ' ', e.lastName) AS employeeName,
    orderNumber, customerName
FROM employees AS e
INNER JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
INNER JOIN orders AS o
ON o.customerNumber = c.customerNumber
INNER JOIN offices AS oc
ON oc.officeCode = e.officeCode
WHERE oc.city = 'Tokyo';

SELECT 
	c.customerName,
	o.orderNumber,
	o.orderDate,
	o.shippedDate,
	p.productName,
	od.quantityOrdered,
	od.priceEach,
	oc.city,
	e.firstName,
	e.lastName
FROM products p
JOIN orderdetails od
USING (productCode)
JOIN orders o
USING (orderNumber)
JOIN customers c
USING (customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices oc
USING (officeCode)
WHERE 
	p.productName LIKE '1%r' 
	AND o.orderDate < '2004-12-25' 
	AND od.quantityOrdered > 10 
	AND c.city = 'NYC'
	AND od.priceEach BETWEEN 20 AND 100
ORDER BY c.customerName AND o.orderDate DESC;


SELECT 
	c.customerName,
	o.orderNumber,
	o.orderDate,
	o.shippedDate,
	p.productName,
	od.quantityOrdered,
	od.priceEach,
	c.city,
	e.firstName,
	e.lastName
FROM products p
JOIN orderdetails od
USING (productCode)
JOIN orders o
USING (orderNumber)
JOIN customers c
USING (customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices oc
USING (officeCode)
WHERE p.productName LIKE '2%o' 
	AND o.orderDate > '2003-04-01' 
	AND od.quantityOrdered > 15
	AND c.city = 'San Francisco'
	AND od.priceEach BETWEEN 50 AND 150
ORDER BY c.customerName AND o.orderDate DESC 
