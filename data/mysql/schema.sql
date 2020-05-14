CREATE DATABASE testdb;
USE testdb;
GRANT ALL PRIVILEGES ON testdb.* TO 'connect_user';
CREATE TABLE `products` (
  `prod_id` int(11) NOT NULL AUTO_INCREMENT,
  `Prod_name` varchar(100) NOT NULL,
  `entry_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`prod_id`)
); 
