-- Soal 1
SELECT 
	productcode AS 'Kode Produk', 
	productname AS 'Nama Produk', 
	quantityinstock AS 'Jumlah Produk' 
FROM products 
WHERE quantityinstock >= 5000 AND quantityinstock <= 6000 
ORDER BY quantityinstock ASC;

-- Soal 2
SELECT 
	ordernumber AS 'Nomor Pesanan', 
	orderdate AS 'Tanggal Pesanan', 
	status, 
	customernumber AS 'Nomor Pelanggan' 
FROM orders 
WHERE STATUS!="shipped" 
ORDER BY  customernumber ASC;

-- Soal 3
SELECT 
	employeenumber AS 'Nomor Karyawan', 
	firstname, 
	lastname, 
	email, 
	jobtitle AS 'Jabatan' 
FROM employees 
WHERE jobtitle = 'Sales Rep' 
ORDER BY firstname ASC LIMIT 10;

-- Soal 4
SELECT 
	productcode AS 'Kode Produk', 
	productname AS 'Nama Produk', 
	productline AS 'Lini Produk', 
	buyprice AS 'Harga Beli' 
FROM products 
ORDER BY buyprice DESC 
LIMIT 5,10 ;

-- Soal 5
SELECT DISTINCT 
	country, 
	city 
FROM customers 
ORDER BY country, city;