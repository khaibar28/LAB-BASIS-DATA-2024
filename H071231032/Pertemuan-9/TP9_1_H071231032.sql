-- H071231032 | Muhammad Qaffal | TP 9

USE pertemuan_7;
set autocommit = 0;
start transaction;
-- No. 1
CREATE TABLE klub(
	id INT PRIMARY KEY auto_increment,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL
);


CREATE TABLE pemain(
	id INT PRIMARY KEY auto_increment,
	nama_pemain VARCHAR(50) NOT NULL,
	posisi VARCHAR(20) NOT NULL,
	id_klub INT,
	FOREIGN KEY (id_klub) REFERENCES klub(id)
);

CREATE TABLE pertandingan(
	id INT PRIMARY KEY auto_increment,
	id_klub_tuan_rumah INT,
	id_klub_tamu INT,
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0,
	FOREIGN KEY (id_klub_tuan_rumah) REFERENCES klub(id),
	FOREIGN KEY (id_klub_tamu) REFERENCES klub(id)
);

INSERT INTO klub (nama_klub, kota_asal)
VALUES ('Persija', 'Jakarta'),
	('Arema FC', 'Malang'),
	('Persebaya', 'Surabaya'),
	('PSM Makassar', 'Makassar'),
	('Bali United', 'Bali');

SELECT * FROM klub k;

INSERT INTO pemain (nama_pemain, posisi, id_klub)
VALUES ('Evan Dimas', 'Midfielder', 16),
('Riko Simanjuntak', 'Forward', 16),
('Hanif Sjahbandi', 'Defender', 17),
('Makan Konate', 'Midfielder', 17),
('David da Silva', 'Forward', 18),
('Irfan Jaya', 'Forward', 19),
('Rizky Pellu', 'Midfielder', 19),
('Ilija Spasojevic', 'Forward', 20),
('Andhika Wijaya', 'Defender', 20);

SELECT * FROM pemain p;

INSERT INTO pertandingan (id_klub_tuan_rumah, id_klub_tamu, tanggal_pertandingan, skor_tuan_rumah, skor_tamu)
VALUES (16, 17, '2024-09-10', 2, 1),
(18, 19, '2024-09-12', 1, 1),
(20, 16, '2024-09-15', 0, 3),
(17, 20, '2024-09-20', 1, 2),
(19, 18, '2024-09-25', 2, 0);

SELECT * FROM pertandingan p;

rollback;
show create table pemain;
commit;

ALTER TABLE pemain
ADD INDEX idx_posisi(posisi);

ALTER TABLE klub
ADD INDEX idx_kota_asal(kota_asal);

show CREATE TABLE klub;
show CREATE TABLE pemain;
show CREATE TABLE pertandingan;

-- No. 2
USE classicmodels;

SELECT c.customerName,
	c.country,
	SUM(pay.amount) totalPayment,
	COUNT(o.orderNumber) orderCount,
	MAX(pay.paymentDate) lastPaymentDate,
	CASE 
		WHEN SUM(pay.amount) > 100000 THEN 'VIP'
		WHEN SUM(pay.amount) BETWEEN 5000 AND 100000 THEN 'Loyal'
		ELSE 'New'
	END status
FROM customers c
LEFT JOIN payments pay USING (customerNumber)
LEFT JOIN orders o USING (customerNumber)
GROUP BY c.customerNumber
ORDER BY c.customerName;

-- No. 3
SELECT c.customerNumber,
	c.customerName,
	SUM(od.quantityOrdered) total_quantity,
	CASE 
		WHEN SUM(od.quantityOrdered) > (
			select avg(ss) from (
				SELECT customerNumber, SUM(quantityOrdered) 'ss' FROM orderdetails
				JOIN orders o using (orderNumber)
				GROUP BY o.customerNumber) xy
			)
			THEN 'Di atas rata-rata'
		ELSE 'Di bawah rata-rata'
	END kategori_pembelian
FROM customers c
LEFT JOIN orders o USING (customerNumber)
LEFT JOIN orderdetails od USING (orderNumber)
GROUP BY c.customerNumber
ORDER BY total_quantity DESC;

drop table pemain;
drop table pertandingan;
drop table klub;




