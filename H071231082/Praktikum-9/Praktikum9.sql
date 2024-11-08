-- 1
create database tp9;
use tp9;

describe klub;
create table klub (
	id int primary key auto_increment,
	nama_klub varchar(50) not null,
	kota_asal varchar(20) not null
);

create table pemain (
	id int primary key auto_increment,
	nama_pemain varchar(50) not null,
	posisi varchar(20) not null,
	id_klub int,
	foreign key(id_klub) references klub(id)
);

create table pertandingan (
	id int primary key auto_increment,
	id_klub_tuan_rumah int,
	id_klub_tamu int,
	tanggal_pertandingan date not null,
	skor_tuan_rumah int default 0,
	skor_tamu int default 0,
	foreign key(id_klub_tuan_rumah) references klub(id),
	foreign key(id_klub_tamu) references klub(id)
);

alter table pemain
add index index_posisi(posisi);

alter table klub
add index index_kota(kota_asal);

-- 2
select * from orders;

use classicmodels;

select c.customername, c.country, sum(p.amount) as total, count(o.customernumber) as jumlah,
case
	when sum(p.amount) < 5000 then 'new'
	when sum(p.amount) between 5000 and 100000 then 'loyal'
	when sum(p.amount) > 100000 then 'vip'
end as status
from customers c
left join orders o
using (customernumber)
left join payments p
using (customernumber)
group by customername;

-- 3
select c.customername, sum(od.quantityordered) as total, 
case
	when sum(od.quantityordered) > 
			(select avg(total) from (
            select o.customernumber, sum(od.quantityordered) as total
            from orderdetails od
            join orders o
            using (ordernumber)
            group by customernumber
			) as avg
		)
    then 'above avg'
	else 'below avg'
end as category
from customers c
join orders o
using (customernumber)
join orderdetails od
using (ordernumber)
group by customernumber
order by total desc;


