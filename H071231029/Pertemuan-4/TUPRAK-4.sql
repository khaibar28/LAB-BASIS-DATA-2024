## PRAKTIKUM 4 
## H071231029_MuhFajrinSuhar


## NO 1

USE classicmodels;

SELECT * from customers; 
SELECT customerNumber,customerName,country 
FROM customers WHERE (country = 'USA' AND  CreditLimit >= 50000  AND CreditLimit < 100000) OR
(country != 'USA' AND  CreditLimit > 100000 AND CreditLimit < 200000)  ORDER BY  CreditLimit DESC;  

 	 													

## NO 2
SELECT productCode, productName, quantityInStock, buyPrice 
FROM products 
WHERE quantityInStock BETWEEN 1000 AND 2000 
AND (buyPrice  < 50  OR buyPrice > 150) 
AND productLine != 'Vintage Cars';  


## NO 3

SELECT productCode, productName, MSRP
FROM products
WHERE productLine LIKE '%Classic%' 
AND buyPrice > 50;


## NO 4 
SELECT orderNumber, orderDate, status, customerNumber
FROM orders
WHERE orderNumber > 10250 AND status NOT IN ('Shipped' ,'Cancelled')
AND orderDate BETWEEN  '2004-01-01' AND '2005-12-31';



## NO 5
SELECT orderNumber, orderLineNumber,productCode,quantityOrdered,priceEach,
ROUND(quantityOrdered * priceEach * 0.95, 2) AS discountedTotalPrice
FROM orderdetails
WHERE quantityOrdered > 50 
AND priceEach > 100
AND productCode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice DESC



 ## SOAL TAMBAHAN
## NO 6
SELECT productName FROM products 
WHERE productScale = '1.18'  AND productname LIKE = '197_%'


## NO 7
SELECT checkNumber FROM payments
WHERE amount >= 10000 AND amount <= 99999 AND paymentDate LIKE '%-12-%';
