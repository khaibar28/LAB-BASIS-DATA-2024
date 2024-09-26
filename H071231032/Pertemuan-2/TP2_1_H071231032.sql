-- NO. 1
SELECT productCode 'Kode Produk', productName 'Nama Produk', quantityInStock 'Jumlah Stok' FROM products p 
WHERE  quantityInStock >= 5000 AND quantityInStock <= 6000;

-- NO. 2
SELECT orderNumber 'Nomor Pesanan', orderDate 'Tanggal Pesanan', status, customerNumber 'Nomor Pelanggan' FROM orders o 
WHERE status != 'Shipped';

-- No. 3
SELECT employeeNumber 'Nomor Karyawan', firstName, lastName, email, jobTitle 'Jabatan' FROM employees e 
WHERE jobTitle = 'Sales Rep'
LIMIT 10;

-- No. 4
SELECT productCode 'Kode Produk', productName 'Nama Produk', productLine 'Lini Produk', buyPrice 'Harga Beli' FROM products p 
ORDER BY buyPrice  DESC 
LIMIT 10 OFFSET 5;

-- No. 5
SELECT DISTINCT country, city FROM customers c 
ORDER BY country AND city;
