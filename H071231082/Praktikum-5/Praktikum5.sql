use classicmodels;

-- 1
select distinct c.customername, p.productname, p.productdescription as textdescription
from customers c
join orders o
on c.customernumber = o.customernumber
join orderdetails od
on o.ordernumber = od.ordernumber
join products p
on od.productcode = p.productcode
where p.productname like "%titanic%";


-- 2
select c.customername, p.productname, o.status, o.shippeddate
from customers c
join orders o
on c.customernumber = o.customernumber
join orderdetails od
on o.ordernumber = od.ordernumber
join products p
on od.productcode = p.productcode
where (productname like "%ferrari%") and (status = "shipped") and (shippeddate between "2003-10-01" and "2004-10-01")
order by shippeddate desc;

-- 3
select ep.firstname as "Supervisor", e.firstname as "Karyawan" 
from employees ep
join employees e
on e.reportsto = ep.employeenumber 
where ep.firstname = "gerard";

-- 4 bagian 1
select c.customername, p.paymentdate, e.firstname, p.amount
from customers c
join payments p
on c.customernumber = p.customernumber
join employees e
on c.salesrepemployeenumber = e.employeenumber
where paymentdate like "_____11%";

-- 4 bagian 2
select c.customername, p.paymentdate, e.firstname, p.amount
from customers c
join payments p
on c.customernumber = p.customernumber
join employees e
on c.salesrepemployeenumber = e.employeenumber
where paymentdate like "_____11%"
order by amount desc limit 1;

-- 4 bagian 3
select c.customername, pd.productname
from customers c
join payments p
on c.customernumber = p.customernumber
join orders o
on c.customernumber = o.customernumber
join orderdetails od
on o.ordernumber = od.ordernumber
join products pd
on od.productcode = pd.productcode
where customername like "Corporate%" and p.paymentdate like "_____11%";

-- tambahan 
select c.customername, o.ordernumber, o.orderdate, p.productname, od.quantityordered, od.priceeach, oc.city, e.firstname, e.lastname
from customers c
join orders o
on c.customernumber = o.customernumber
join orderdetails od
on o.ordernumber = od.ordernumber
join products p
on od.productcode = p.productcode
join employees e
on c.salesrepemployeenumber = e.employeenumber
join offices oc
on e.officecode = oc.officecode
where (p.productname like "%69%") and MONTH(o.orderdate) BETWEEN 7 AND 12
and (oc.city in ("Paris", "London")) and (priceeach > 70)
order by quantityordered desc;



