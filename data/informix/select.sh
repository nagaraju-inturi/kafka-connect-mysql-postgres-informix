. /home/informix/.bashrc
dbaccess -e testdb << EOF
select * from customers;
select * from products;
EOF
