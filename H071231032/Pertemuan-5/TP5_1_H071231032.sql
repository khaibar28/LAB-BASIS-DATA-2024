-- Muhammad Qaffal Al Fifaiz
-- H071231032
SELECT * FROM employees e;
-- No. 1
SELECT DISTINCT c.customerName namaKustomer, p.productName namaProduk, pl.textDescription  FROM products p
INNER JOIN productlines pl
	ON p.productLine = pl.productLine
INNER JOIN orderdetails ol 
	ON p.productCode = ol.productCode
INNER JOIN orders o
	ON ol.orderNumber = o.orderNumber
INNER JOIN customers c
	ON o.customerNumber = c.customerNumber
WHERE p.productName LIKE '%Titanic%'
ORDER BY c.customerName;

-- No. 2
SELECT c.customerName, p.productName, o.status, o.shippedDate  FROM products p
INNER JOIN orderdetails ol 
	ON p.productCode = ol.productCode
INNER JOIN orders o
	ON ol.orderNumber = o.orderNumber
INNER JOIN customers c
	ON o.customerNumber = c.customerNumber
WHERE p.productName LIKE '%Ferrari%' AND 
	o.status = 'Shipped' AND 
	o.shippedDate BETWEEN '2003-10-1' AND '2004-10-1'
ORDER BY o.shippedDate DESC;

-- No. 3
SELECT e2.firstName Supervisor, e.firstName Karyawan FROM employees e
INNER JOIN employees e2 ON e.reportsTo = e2.employeeNumber
WHERE e2.firstName = 'Gerard'
ORDER BY e.firstName;

-- No. 4.a
SELECT c.customerName, p.paymentDate, e.firstName employeeName, p.amount FROM customers c
INNER JOIN payments p
	ON c.customerNumber = p.customerNumber
INNER JOIN employees e
	ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%';

-- No. 4.b
SELECT c.customerName, p.paymentDate, e.firstName employeeName, p.amount FROM customers c
INNER JOIN payments p
	ON c.customerNumber = p.customerNumber
INNER JOIN employees e
	ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%'
ORDER BY p.amount DESC
LIMIT 1;

-- No. 4.c
SELECT c.customerName, p.productName FROM customers c
INNER JOIN payments pm
	ON c.customerNumber = pm.customerNumber
INNER JOIN orders o 
	ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
	ON	o.orderNumber = od.orderNumber
INNER JOIN products p
	ON od.productCode = p.productCode
WHERE c.customerName = 'Corporate Gift Ideas Co.' AND 
	pm.paymentDate LIKE '%-11-%';

-- No. 4.c Sub-query
SELECT c.customerName, p.productName FROM customers c
INNER JOIN payments pm
	ON c.customerNumber = pm.customerNumber
INNER JOIN orders o 
	ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
	ON	o.orderNumber = od.orderNumber
INNER JOIN products p
	ON od.productCode = p.productCode
WHERE c.customerName = (SELECT c2.customerName FROM customers c2
						NATURAL INNER JOIN payments p2, employees e2
						WHERE p2.paymentDate LIKE '%-11-%'
						ORDER BY p2.amount DESC LIMIT 1) AND
					pm.paymentDate LIKE '%-11-%';

-- Soal Tambahan
SELECT * FROM products p ;
SELECT * FROM customers o ;

SELECT c.customerName,
	o.orderNumber,
	o.orderDate,
	o.shippedDate,
	p.productName,
	od.priceEach,
	ofc.city officeCity,
	concat(e.firstName, ' ', e.lastName) fullNameSalesRep
FROM customers c
INNER JOIN orders o
	ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
	ON o.orderNumber = od.orderNumber 
INNER JOIN products p
	ON od.productCode = p.productCode
INNER JOIN employees e
	ON c.salesRepEmployeeNumber = e.employeeNumber 
INNER JOIN offices ofc
	ON e.officeCode = ofc.officeCode 
WHERE p.productName LIKE '1%r' AND
	o.orderDate < '2004-12-25' AND
	od.quantityOrdered > 10 AND 
	c.city = 'NYC' AND 
	od.priceEach BETWEEN 20 AND 100
ORDER BY c.customerName ASC, o.orderDate DESC;
	



