# nomor 1
(SELECT 
    p.productName, 
    SUM(od.priceEach * od.quantityOrdered) AS totalRevenue,
    'Pendapatan tinggi' AS Pendapatan
FROM 
    products p
JOIN 
    orderdetails od USING(productCode)
JOIN 
    orders o  USING(orderNumber) 
WHERE 
    MONTH(o.orderDate) = 9  
GROUP BY 
    p.productName
ORDER BY 
    totalRevenue DESC
LIMIT 5)

UNION ALL

(SELECT 
    p.productName, 
    SUM(od.priceEach * od.quantityOrdered) AS totalRevenue,
    'Pendapatan pendek' AS Pendapatan
FROM 
    products p
JOIN 
    orderdetails od ON p.productCode = od.productCode
JOIN 
    orders o ON od.orderNumber = o.orderNumber
WHERE 
    MONTH(o.orderDate) = 9  
GROUP BY 
    p.productName
ORDER BY 
    totalRevenue ASC
LIMIT 5);


# nomor 2

SELECT productName FROM products

EXCEPT 

SELECT productName FROM products
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
WHERE customerNumber IN (
	SELECT 
		customerNumber
	FROM orders 
	GROUP BY customerNumber
	HAVING COUNT(*) > 10
	
	INTERSECT 
	
	SELECT 
		customerNumber
	FROM products 
	JOIN orderdetails od USING(productCode)
	JOIN orders o USING(orderNumber)
	WHERE buyPrice > (SELECT avg(buyPrice) FROM products) 
	GROUP BY customerNumber
		
);

(SELECT productName FROM products)

EXCEPT 
(SELECT productName FROM products
JOIN orderdetails USING (productCode)
JOIN orders USING (orderNumber)
JOIN customers c USING (customerNumber)
WHERE c.customerNumber IN (
	SELECT customerNumber FROM customers
	JOIN orders USING (customerNumber)
	JOIN orderdetails USING (orderNumber)
	JOIN products USING (productCode)
	where buyPrice > (SELECT AVG(buyPrice) FROM products)
	GROUP BY customerNumber
	having COUNT(distinct orderNumber) > 10));


# nomor 3

SELECT customerName FROM customers
JOIN payments USING(customerNumber)
GROUP BY customerNumber
HAVING SUM(amount) > 2 * (
	SELECT AVG(rata2) 
	FROM (
		SELECT SUM(amount) rata2 FROM payments
		GROUP BY customerNumber
	) AS rata2
)

INTERSECT 

(SELECT customerName FROM customers
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products USING(productcode)
WHERE productLine IN ('Planes', 'Trains') 
GROUP BY customerName
HAVING SUM(Priceeach * quantityordered) > 20000);


# nomor 4

(SELECT orderDate Tanggal,
CustomerNumber,
'Memesan Barang' AS Riwayat
FROM orders
WHERE orderDate NOT IN (
	SELECT paymentDate FROM payments
) AND orderDate LIKE '2003-09%')

UNION 

(SELECT paymentDate Tanggal,
CustomerNumber,
'Membayar Pesanan' AS Riwayat
FROM payments
WHERE paymentDate NOT IN (
	SELECT orderDate FROM orders
) AND paymentDate LIKE '2003-09%')

UNION 

(SELECT orderDate Tanggal,
CustomerNumber,
'Memesan Barang dan Membayar Pesanan' AS Riwayat FROM orders
WHERE orderDate IN (
	SELECT paymentDate FROM payments
) AND orderDate LIKE '2003-09%')

ORDER BY Tanggal;


# nomor 5

(SELECT productCode FROM products 
JOIN orderdetails USING(productCode)
JOIN orders USING(orderNumber)
WHERE buyPrice > (
	SELECT AVG(buyPrice) FROM products
	JOIN orderdetails USING(productCode)
	JOIN orders USING(orderNumber)
	WHERE orderDate BETWEEN '2001-01-01' AND '2004-03-31'
) AND quantityordered > 48 
AND  LEFT(productVendor,1) IN ('a','i','u','e','o'))

EXCEPT 
(SELECT productCode FROM orderdetails
JOIN orders USING(orderNumber)
JOIN customers USING(customerNumber)
WHERE country IN ('Japan', 'Germany','Italy'))

ORDER BY productCode;

