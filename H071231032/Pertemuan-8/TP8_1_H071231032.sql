-- H071231032
-- Muhammad Qaffal Al Fifaiz

-- No. 1
(
	SELECT p.productName, SUM(od.priceEach * od.quantityOrdered) TotalRevenue, 'Pendapatan Tinggi' Pendapatan 
	FROM products p 
	JOIN orderdetails od USING (productCode)
	JOIN orders o USING (orderNumber)
	WHERE MONTH(o.orderDate) = 9
	GROUP BY p.productCode
	ORDER BY TotalRevenue DESC
	LIMIT 5
)
UNION
(
	SELECT p.productName, SUM(od.priceEach * od.quantityOrdered) TotalRevenue, 'Pendapatan Pendek (kayak kamu)' Pendapatan 
	FROM products p 
	JOIN orderdetails od USING (productCode)
	JOIN orders o USING (orderNumber)
	WHERE MONTH(o.orderDate) = 9
	GROUP BY p.productCode
	ORDER BY TotalRevenue ASC
	LIMIT 5
);

-- No. 2
(
	SELECT p.productName 
	FROM products p 
)
EXCEPT
(
	SELECT p.productName 
	FROM products p 
	JOIN orderdetails od USING (productCode)
	JOIN orders o USING (orderNumber)
	JOIN customers c USING (customerNumber)
	WHERE c.customerNumber IN (
		SELECT customerNumber FROM customers
		JOIN orders USING (customerNumber)
		JOIN orderdetails USING (orderNumber)
		JOIN products USING (productCode)
		WHERE buyPrice > (SELECT AVG(buyPrice) FROM products)
		GROUP BY customerNumber 
		HAVING COUNT(DISTINCT orderNumber) > 10 
	)
);

-- No. 3
(
	SELECT c.customerName
	FROM customers c 
	JOIN payments pay USING (customerNumber)
	GROUP BY c.customerNumber
	HAVING SUM(pay.amount) > 2 * (
		SELECT AVG(totalAmounts) FROM (
			SELECT SUM(amount) totalAmounts FROM payments
			GROUP BY customerNumber
		) AS Anu
	)
)
INTERSECT
(
	SELECT c.customerName
	FROM customers c 
	JOIN orders o USING (customerNumber)
	JOIN orderdetails od USING (orderNumber)
	JOIN products p USING (productCode)
	WHERE p.productLine = 'Planes' OR p.productLine = 'Trains'
	GROUP BY c.customerNumber
	HAVING SUM(od.priceEach * od.quantityOrdered) > 20000
);

-- No. 4
(
	SELECT o.orderDate Tanggal, o.CustomerNumber, 'Memesan Barang' riwayat
	FROM orders o
	WHERE EXTRACT(YEAR_MONTH FROM o.orderDate) = '200309'
	AND o.orderDate NOT IN (
		SELECT orderDate
		FROM orders
		JOIN customers c USING (customerNumber)
		JOIN payments ON o.orderDate = paymentDate
		WHERE EXTRACT(YEAR_MONTH FROM orderDate) = '200309'
	)
)
UNION
(
	SELECT  pay.paymentDate, pay.CustomerNumber, 'Membayar Pesanan'
	FROM payments pay
	WHERE EXTRACT(YEAR_MONTH FROM pay.paymentDate) = '200309'
	AND pay.paymentDate NOT IN (
		SELECT  pay.paymentDate
		FROM payments pay
		JOIN customers c USING (customerNumber)
		JOIN orders o ON o.orderDate = pay.paymentDate
		WHERE EXTRACT(YEAR_MONTH FROM pay.paymentDate) = '200309'
	)
)
UNION
(
	SELECT o.orderDate, c.CustomerNumber, 'Memesan Barang dan Membayar Pesanan'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments pay ON o.orderDate = pay.paymentDate
	WHERE EXTRACT(YEAR_MONTH FROM o.orderDate) = '200309'
)
ORDER BY Tanggal;

-- No. 5
SELECT productCode
FROM (
	(
		SELECT p.productCode 
		FROM products p 
		JOIN orderdetails od USING (productCode)
		JOIN orders o USING (orderNumber)
		WHERE od.priceEach > (
			SELECT AVG(priceEach) FROM orderdetails
			JOIN orders USING (orderNumber)
			WHERE orderDate BETWEEN '2001-01-01' AND '2004-03-31'
		) AND od.quantityOrdered > 48
		AND LEFT (p.productVendor, 1) IN ('A', 'I', 'U', 'E', 'O')
	)
	EXCEPT
	(
		SELECT p.productCode 
		FROM products p
		JOIN orderdetails od USING (productCode)
		JOIN orders o USING (orderNumber)
		JOIN customers c USING (customerNumber)
		WHERE c.country IN ('Japan', 'Germany', 'Italy')
	)
) unorder
ORDER BY productCode;



-- LIVE CODING
(
	SELECT p.productName, SUM(od.QuantityOrdered) TotalQuantityOrdered
	FROM products p
	JOIN orderdetails od USING (productCOde)
	JOIN orders o USING (orderNumber)
	JOIN customers c USING (customerNumber)
	JOIN employees e on e.employeeNumber = c.salesRepEmployeeNumber
	JOIN offices ofc using (officeCode)
	where ofc.city = 'NYC'
	GROUP BY p.productCode
	ORDER by TotalQuantityOrdered DESC
	Limit 3
)
UNION
(
	SELECT p.productName, SUM(od.QuantityOrdered) TotalQuantityOrdered
	FROM products p
	JOIN orderdetails od USING (productCOde)
	JOIN orders o USING (orderNumber)
	JOIN customers c USING (customerNumber)
	JOIN employees e on e.employeeNumber = c.salesRepEmployeeNumber
	JOIN offices ofc using (officeCode)
	where ofc.city = 'Tokyo'
	GROUP BY p.productCode
	ORDER by TotalQuantityOrdered DESC
	Limit 3
);
