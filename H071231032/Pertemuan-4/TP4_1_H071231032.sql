-- No. 1
SELECT customerNumber, customerName, country FROM customers c 
WHERE country = 'USA' AND creditLimit BETWEEN 50000.01 AND 100000
	OR country != 'USA' AND creditLimit BETWEEN 100000 AND 200000
ORDER BY creditLimit DESC;

-- No. 2
SELECT productCode, productName, quantityInStock, buyPrice FROM products p
WHERE quantityInStock BETWEEN 1000 AND 2000
	AND buyPrice < 50 OR buyPrice > 150
	AND productLine NOT LIKE 'Vintage%';

-- No. 3
SELECT productCode, productName, MSRP FROM products p 
WHERE productLine LIKE 'Classic%' AND buyPrice > 50;

-- No. 4
SELECT orderNumber, orderDate, status, customerNumber FROM orders o 
WHERE orderNumber > 10250 AND status NOT IN ('Shipped', 'Cancelled')
	AND orderDate BETWEEN '2004-01-01' AND '2005-12-31';

-- No. 5
SELECT orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach,
	((quantityOrdered * priceEach) - 5 / 100 * (quantityOrdered * priceEach)) 'discountedTotalPrice'
FROM orderdetails o
WHERE quantityOrdered > 50 AND priceEach > 100
	AND productCode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice DESC;

-- Live Coding
-- No. 1
SELECT productName FROM products p 
WHERE productScale = '1:18' AND productName LIKE '197_%';

-- No. 2
SELECT checkNumber FROM payments p 
WHERE amount >= 10000 AND amount < 100000 AND paymentDate LIKE '%-12-%';


SELECT * FROM products p ;
SELECT * FROM payments pay;
SELECT * FROM orders o ;
SELECT * FROM orderdetails o ;