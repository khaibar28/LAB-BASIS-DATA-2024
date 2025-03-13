

##PRAKTIKUM 5
## H071231029
## MUh.Fajrin Suhar

## 1
USE classicmodels;


SELECT DISTINCT 
    customers.customerName AS namaKustomer,
    products.productName AS namaProduk,
    products.productDescription AS textDescription
FROM 
    products
INNER JOIN orderdetails ON products.productCode = orderdetails.productCode
INNER JOIN orders ON orderdetails.orderNumber = orders.orderNumber
INNER JOIN customers ON orders.customerNumber = customers.customerNumber
WHERE 
    products.productName LIKE '%Titanic%'
ORDER BY 
    customers.customerName ASC



# NOMOR 2

SELECT
	c.customerName,
	p.productName,
	o.status,
	o.shippedDate
FROM customers AS c
INNER JOIN orders AS o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
INNER JOIN products AS p
ON od.productCode = p.productCode
WHERE productName LIKE "%Ferrari%"
AND status = "Shipped"
AND shippedDate BETWEEN "2003-10-01" AND "2004-10-01"
ORDER BY shippedDate ASC;




# NOMOR 3
SELECT
	e1.firstName AS Supervisor,
	e2.firstName AS Karyawan
FROM employees AS e1
INNER JOIN employees AS e2
ON e1.employeeNumber = e2.reportsTo
WHERE e1.firstName = "Gerard"
ORDER BY e2.firstName ASC;


# NOMOR 4  
-- a
SELECT
	c.customerName,
	p.paymentDate,
	e.firstName AS employeeName,
	p.amount
FROM customers AS c
INNER JOIN payments AS p
ON c.customerNumber = p.customerNumber
INNER JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE paymentDate LIKE '%11___';



## No 4. b
SELECT
	c.customerName,
	p.paymentDate,
	e.firstName AS employeeName,
	p.amount
FROM customers AS c
INNER JOIN payments AS p
ON c.customerNumber = p.customerNumber
INNER JOIN employees AS e
WHERE paymentDate LIKE '%11-__'
ORDER BY amount DESC
LIMIT 1;



-- c
SELECT
	c.customerName,
	pro.productName
FROM customers AS c
INNER JOIN payments AS p
ON c.customerNumber = p.customerNumber
INNER JOIN orders AS o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
INNER JOIN products AS pro
ON od.productCode = pro.productCode
WHERE c.customerName LIKE "Corporate%"
AND paymentDate LIKE '%11-__' ORDER BY productName; 





													

SELECT customers.customerName, orders.orderNumber, orders.orderDate,   products.productName, orderdetails.quantityordered, orderdetails.priceEach,  employees.firstName, employees.lastName
FROM customers
INNER JOIN orders ON orders.customerNumber = customers.customerNumber
INNER JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber
INNER JOIN  products ON  orderdetails.productCode = products.productCode
  
INNER JOIN employees ON  customers.salesRepEmployeeNumber = employees.employeeNumber
INNER JOIN offices ON employees.officeCode = offices.officeCode

WHERE (products.productName LIKE '%69%') AND MONTH(orders.orderdate) BETWEEN 7 AND 12 
AND offices.city IN ('Paris', 'London') AND orderdetails.priceEach >= 70
ORDER BY orderdetails.quantityordered DESC; 












## Bos dari Para budak korporat  ingin mendapatkan informasi mengenai semua
 ##pesanan produk yang memiliki kata "69" di dalam nama produk. kamu diminta untuk membuat sebuah query SQL yang 
 ##menampilkan informasi lengkap dari setiap pesanan tersebut. Informasi yang harus ditampilkan meliputi nama pelanggan, nomor pesanan, tanggal pesanan, tanggal pengiriman, nama produk, jumlah produk yang dipesan,
 ##harga per unit, kota dari kantor tempat sales representative bekerja, serta nama depan dan nama belakang sales representative yang bertanggung jawab atas pesanan tersebut. Bos tersebut juga hanya ingin melihat daftar pesanan dari jumlah pesanan terbanyak yang 
 ##ilakukan setelah pertengahan tahun pada kota paris dan london dengan harga setiap produk lebih dari 70 buatlah query untuk menolong para budak korporat tersebut

																																											
																														


