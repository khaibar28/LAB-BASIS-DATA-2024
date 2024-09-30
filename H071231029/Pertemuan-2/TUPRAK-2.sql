SHOW DATABASES;

USE classicmodels;

SHOW TABLES;


## Muh. Fajrin Suhar
## H071231029



## N0 1
SELECT
	productcode AS 'kode produk' ,
	productname AS 'nama produk',
	quantityInStock AS 'jumlah prdoduk' 
FROM products
WHERE quantityInStock >= 5000 AND quantityInStock <= 6000;  



## NO 2
SELECT
	orderNumber AS 'nomor pesanan',
	shippedDate AS 'tanggal pesanan' , status,
	customerNumber AS 'Nomor pelanggan'
FROM orders
WHERE STATUS != 'Shipped'
ORDER BY customerNumber;


# NO 3

SELECT employeeNumber AS 'Nomor karyawan',firstName,lastName, email, jobTitle AS 'jabatan' FROM employees ORDER BY firstName LIMIT 10;


# NO 4

SELECT productCode AS 'kode produk', productName AS 'Nama produk', productLine AS 'Lini produk', buyprice 'Harga beli' 
FROM products 
ORDER BY buyprice 
DESC LIMIT 5,10; 

# NO 5
SELECT DISTINCT country, city 
FROM customers
ORDER BY country, city;


# NO 6
SELECT * from employees
JOIN offices USING (officeCode) 
WHERE offices.city = "San Francisco"

 


