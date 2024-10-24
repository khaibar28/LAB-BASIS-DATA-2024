
# Nomor 1
-- Soal : Tampilkan nama customer, sales representative, dan total kredit limit yang tersisa (credit limit dikurangi total pembayaran) serta diurutkan berdasarkan nama customer:
SELECT c.customerName, 
       CONCAT(e.firstName, ' ', e.lastName) AS salesRep, 
       (c.creditLimit - SUM(p.amount)) AS remainingCredit
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p USING(customerNumber)
GROUP BY c.customerName, salesRep
HAVING remainingCredit > 0
ORDER BY c.customerName;


# Nomor 2
-- Soal : Tampilkan nama produk, nama customer yang pernah memesan produk tersebut serta jumlah customer dan jumlah total produk yang dipesan:

SELECT p.productName, 
       GROUP_CONCAT(DISTINCT c.customerName) AS customerNames, 
       COUNT(DISTINCT o.customerNumber) AS jumlahCustomer, 
       SUM(od.quantityOrdered) AS totalQuantities
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
JOIN customers c USING(customerNumber)
GROUP BY p.productName;

# Nomor 3
-- Tampilkan nama employee dan jumlah customer yang mereka tangani:

SELECT CONCAT(e.firstName, ' ', e.lastName) AS employeeName, 
       COUNT(DISTINCT c.customerNumber) AS totalCustomers
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY employeeName
ORDER BY totalCustomers DESC;

# Nomor 4

-- Soal : Tampilkan seluruh nama karyawan yang kantornya berada di AUSTRALIA serta total jumlah pesanan per produk 
-- yang dilayani tiap karyawan, diurutkan berdasarkan jumlah pesanan terbesar:

SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawaan', 
       p.productName AS 'Nama Product', 
       SUM(od.quantityOrdered) AS totalOrders
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders  USING(orderNumber)
JOIN customers c USING(customerNumber)
RIGHT JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o USING(officeCode)
WHERE o.country = 'Australia'
GROUP BY e.firstName, e.lastName, p.productName
ORDER BY totalOrders DESC;

# Nomor 5
-- Tampilkan Nama Pelanggan, Nama Produk beserta banyak jenis produk tiap pelanggan yang pesanannya belum/tidak dikirim:

SELECT 
    c.customerName AS Nama_Pelanggan, 
    p.productName AS Nama_Produk, 
    COUNT(DISTINCT od.productCode) AS Banyak_Jenis_Produk
FROM
   customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products p USING(productCode)
WHERE
    o.shippedDate IS NULL 
GROUP BY
    c.customerName;
    

