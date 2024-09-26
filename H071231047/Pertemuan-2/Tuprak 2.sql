-- nomor 1
SELECT 
	productcode AS "Kode Produk", 
	productname AS "Nama Produk",
	quantityinstock "Jumlah Stok" 
FROM products
WHERE quantityinstock 
BETWEEN 5000 AND 6000;

-- nomor 2
SELECT 
	ordernumber AS "Nomor Pesanan", 
	orderdate AS "Tanggal Pesanan", 
	status AS "Status", 
	customernumber AS "Nomor Pelanggan" 
FROM orders
WHERE STATUS != "shipped"
ORDER BY customernumber ASC;

-- nomor 3
SELECT 
	employeenumber AS "Nomor Karyawan",
	firstname, 
	lastname, 
	email,
	jobtitle AS "Jabatan" 
FROM employees
ORDER BY firstname ASC
LIMIT 10;

-- nomor 4
SELECT 
	productCode AS "Kode Produk",
	productName AS "Nama Produk",
	productLine AS "Lini Produk",
	buyPrice AS "Harga Produk"
FROM products
ORDER BY buyPrice DESC
LIMIT 5, 10;


-- NOMOR 5
SELECT DISTINCT
	country,
	city
FROM customers
ORDER BY country ASC, city ASC;