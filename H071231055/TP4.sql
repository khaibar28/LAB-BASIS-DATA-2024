-- Nomor 1
SELECT customernumber, customername, country FROM customers
WHERE country = 'usa' 
AND creditlimit > 50000 AND creditlimit < 100000 
OR country != 'usa' 
AND creditlimit BETWEEN 100000 AND 200000
ORDER BY creditlimit DESC;
 -- Nomor 2
SELECT productcode, productname, quantityinstock, buyprice FROM products
WHERE quantityinstock BETWEEN 1000 AND 2000 
AND buyprice < 50 OR buyprice > 150 
AND productline != 'Vintage'

-- Nomor 3
SELECT productcode, productname, MSRP FROM products
WHERE productline LIKE '%Classic%' 
AND buyprice  > 50;

-- Nomor 4
SELECT ordernumber, orderdate, status, customernumber FROM orders
WHERE ordernumber > 10250 
AND status != 'shipped' 
AND status != 'cancelled' 
AND orderdate BETWEEN '2004-01-01' AND '2005-12-31';

-- Nomor 5
SELECT ordernumber, orderlinenumber, productcode, quantityordered, priceeach, (0.95 * priceeach * quantityordered) AS discountedtotalprice FROM orderdetails
WHERE quantityordered > 50 
AND priceeach > 100 
AND productcode 
NOT LIKE 'S18%'
ORDER BY discountedtotalprice DESC; 

-- Tugas Tambahan 1
SELECT productname, productscale FROM products
WHERE productname LIKE '197_%' AND productscale = '1:18';

-- Tugas Tambahan 2
SELECT checknumber FROM paymentsppp
WHERE paymentdate LIKE '____-12%' AND amount BETWEEN 10000 AND 99999;