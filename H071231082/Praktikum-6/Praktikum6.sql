use classicmodels;

-- 1 
select c.customername, concat(e.firstname, ' ', e.lastname) as 'nama customer', (c.creditlimit - sum(p.amount)) as remainingcredit
from customers c
join employees e
on c.salesrepemployeenumber = e.employeenumber
join payments p
using (customernumber)
group by customername
having `remainingcredit` > 0;

-- 2
select p.productname, group_concat(c.customername) as 'jumlah customer', sum(od.quantityordered) as 'total kuantitas'
from customers c
join orders o
on c.customernumber = o.customernumber
join orderdetails od
on o.ordernumber = od.ordernumber
join products p
on od.productcode = p.productcode
group by p.productname;

-- 3
select concat(e.firstname, ' ', e.lastname) as "Karyawan", count(c.salesrepemployeenumber) as 'total pelanggan'
from customers c
join employees e
on c.salesrepemployeenumber = e.employeenumber
group by `Karyawan`
order by `total pelanggan` desc;

-- 4
select concat(e.firstname, ' ', e.lastname) as "Karyawan", p.productname, sum(od.quantityordered) as 'total'
from employees e
left join customers c
on e.employeenumber = c.salesrepemployeenumber
left join orders o
using (customernumber)
left join orderdetails od
using (ordernumber)
left join products p
using (productcode)
join offices oc
using (officecode)
where oc.country = "Australia"
group by `karyawan`, p.productname
order by `total` desc;

-- 5
select c.customername, group_concat(p.productname) as 'nama produk', count(p.productline) as 'banyak jenis'
from customers c
join orders o
on c.customernumber = o.customernumber
join orderdetails od
on o.ordernumber = od.ordernumber
join products p
on od.productcode = p.productcode
where o.shippeddate is null
group by c.customername;


