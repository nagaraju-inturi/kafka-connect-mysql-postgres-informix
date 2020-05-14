. /home/informix/.bashrc
dbaccess -e - << EOF
drop database testdb;
create database testdb with log;
create table products (
      prod_id serial primary key, 
      Prod_name varchar(100), 
      entry_date datetime year to second default current year to second
);

create table customers (
        customer_id SERIAL PRIMARY KEY,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        email VARCHAR(50),
        gender VARCHAR(50),
        comments VARCHAR(90),
        UPDATE_TS datetime year to second DEFAULT current year to second
);
select * from customers;
select * from products;
EOF
