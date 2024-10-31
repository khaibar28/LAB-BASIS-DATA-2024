use classicmodels;

-- 1
(select p.productname, sum(od.priceeach * od.quantityordered) as totalrevenue, 'pendapatan tinggi' as pendapatan
from products p
join orderdetails od
using (productcode)
join orders o
using (ordernumber)
where month(o.orderdate) = 9
group by od.productcode
order by totalrevenue desc
limit 5)
UNION
(select p.productname, sum(od.priceeach * od.quantityordered) as totalrevenue, 'pendapatan rendah' as pendapatan
from products p
join orderdetails od
using (productcode)
join orders o
using (ordernumber)
where month(o.orderdate) = 9
group by od.productcode
order by totalrevenue
limit 5);

-- 2
select productname
from products
where productcode not in (
		select distinct productcode
		from orderdetails od
		join orders o
		using (ordernumber)
		where o.customernumber in (
			(select customernumber
			from customers
			join orders o
			using (customernumber)
			group by customernumber
			having count(ordernumber) > 10)
			INTERSECT
			(select distinct customernumber
			from orders o
			join orderdetails od
			using (ordernumber)
			join products p
			using (productcode)
			where p.buyprice > (select avg(buyprice) from products))
			)
		);

-- 3
(select customername
	from customers
	join orders o
	using (customernumber)
	join orderdetails od
	using (ordernumber)
	join products p
	using (productcode)
	join payments pay
	using (customernumber)
where productline like '%plane%'
group by customernumber
having sum(pay.amount) > (2 * avg(pay.amount)) and sum(od.priceeach) > 20000)
UNION
(select customerName
	from customers
	join orders o
	using (customernumber)
	join orderdetails od
	using (ordernumber)
	join products p
	using (productcode)
	join payments pay
	using (customernumber)
where productline like '%trains%'
group by customernumber
having sum(pay.amount) > (2 * avg(pay.amount)) and sum(od.priceeach) > 20000);

-- 4
select distinct o.orderdate as tanggal, c.customernumber, 'Membayar Pesanan dan Memesan Barang' AS riwayat
from orders o
join customers c
using (customernumber)
join payments p
on o.orderdate = p.paymentdate
where month(orderdate) = 9 and year(orderdate) = 2003
UNION
select orderdate as tanggal, customernumber, 'Memesan Barang' as riwayat
from orders 
WHERE orderdate not in (select paymentdate from payments) and (month(orderdate) = 9 and year(orderdate) = 2003)
UNION
select paymentdate as tanggal, customernumber, 'Membayar Pesanan' as riwayat
from payments
WHERE paymentDate not in (select orderdate from orders) and (month(paymentdate) = 9 and year(paymentdate) = 2003)
order by tanggal;

-- 5
select productcode
from products p
join orderdetails od
using (productcode)
join orders
using (ordernumber)
where buyprice > (
			select avg(p.buyprice)
            from products p
            join orderdetails od
            using (productcode)
            join orders o
            using (ordernumber)
            where o.orderdate between '2001-01-01' and '2004-03-31')
and od.quantityordered > (12 * 4)
and left(p.productvendor, 1) in ('a','i','u','e','o')
EXCEPT
select productcode
from products
join orderdetails od
using (productcode)
join orders o
using (ordernumber)
join customers c
using (customernumber)
where c.country in ('japan', 'germany', 'italy');

select * from orders;
select * from orderdetails;

-- tambahan 
select tanggal, customernumber, group_concat(riwayat separator 'dan') from (
	select distinct o.orderdate as tanggal, customernumber, 'Memesan Barang' as riwayat
	from orders o
    where month(orderdate) = 4 and year(orderdate) = 2003
	UNION
	select distinct paymentdate as tanggal, customernumber, 'Membayar Pesanan' as riwayat
	from payments
	where month(paymentdate) = 4 and year(paymentdate) = 2003
	order by tanggal
) as test
group by tanggal;