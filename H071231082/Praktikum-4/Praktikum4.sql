use classicmodels;

-- 1
select customernumber, customername, country from customers
where (country = "usa" and creditlimit between 50000 and 100000) or (country <> "usa" and creditlimit between 50000 and 150000)
order by creditlimit desc;

-- 2
select productcode, productname, quantityinstock, buyprice from products
where (quantityinstock between 1000 and 2000) and (buyprice < 50 or buyprice > 150) and (productline != "vintage");

-- 3
select productcode, productname, msrp from products
where (productline like "classic%") and (buyprice > 50);

-- 4
select ordernumber, orderdate, status, customernumber from orders
where (ordernumber > 10250 and status != "shipped" and status != "cancelled") and (orderdate between "2004-01-01" and "2005-12-31");

-- 5
select *,  priceeach - (priceeach * 0.05) as "discountedtotalprice" from orderdetails
where (quantityordered > 50) and (priceeach > 100) and (productcode not like "S18%")
order by discountedtotalprice desc;