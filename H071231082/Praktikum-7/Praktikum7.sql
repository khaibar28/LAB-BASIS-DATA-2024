use classicmodels;

-- 1
select productcode, productname, buyprice from products
where buyprice > (select avg(buyprice) from products);

-- 2
select ordernumber, orderdate
from orders
join customers c
using (customernumber)
where c.customernumber in (
	select c.customernumber
	from customers c
	join employees e
	on c.salesrepemployeenumber = e.employeenumber
	join offices o
	using (officecode)
	where o.city = 'tokyo'
);

-- 3
select c.customername, o.ordernumber, o.shippeddate, o.requireddate, group_concat(p.productname separator ', ') as "products", sum(od.quantityordered) as "total_quantity", concat(e.firstname, ' ', e.lastname) as employeename
from customers c
join orders o
on c.customernumber = o.customernumber
join orderdetails od
on o.ordernumber = od.ordernumber
join products p
on od.productcode = p.productcode
join employees e
on c.salesrepemployeenumber = e.employeenumber
where o.ordernumber in (select ordernumber from orders where shippeddate > requireddate);

-- 4
select p.productName, p.productLine, sum(od.quantityOrdered) as total_quantity_ordered
from products p
join orderdetails od 
using (productCode)
where p.productLine in (
	select productLine
	from (
		select p.productline
		from products p
		join orderdetails od
		using (productcode)
		group by p.productline
		order by sum(od.quantityordered) desc
		limit 3
	) as subsubquery
)
group by p.productName, p.productLine
order by productline, total_quantity_ordered desc;

-- tambahan
select c.customername, sum(od.priceeach * od.quantityordered) as total, p.productname 
from customers c
join orders o
on c.customernumber = o.customernumber
join orderdetails od
on o.ordernumber = od.ordernumber
join products p
using (productcode)
where p.productcode = (
	select od.productcode
    from orderdetails od
    group by od.productcode
	order by sum(od.quantityordered) desc
    limit 1
)
group by c.customername;






