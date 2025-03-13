use classicmodels;

-- 1
select quantityinstock, productname, productcode from products
where quantityinstock >= 5000 and quantityinstock <= 6000;

-- 2
select customernumber, ordernumber, status from orders
where status = 'shipped'
order by customernumber;

-- 3
select firstname, lastname, employeenumber, email, jobtitle from employees
where jobtitle = "Sales Rep"
order by firstname limit 10;

-- 4
select buyprice, productcode, productline from products
order by buyprice desc limit 5,10;

-- 5
select  distinct country, city from customers
order by country, city;