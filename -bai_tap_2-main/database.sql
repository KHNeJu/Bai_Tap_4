CREATE DATABASE IF NOT EXISTS user_database CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE user_database;

CREATE TABLE IF NOT EXISTS `users` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `email` VARCHAR(255) NOT NULL,
  `username` VARCHAR(255) NOT NULL UNIQUE,
  `fullname` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `avatar` VARCHAR(255) DEFAULT NULL,
  `roleid` INT DEFAULT 3,
  `phone` VARCHAR(20) DEFAULT NULL,
  `createdDate` DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `category` (
  `cate_id` INT AUTO_INCREMENT PRIMARY KEY,
  `cate_name` VARCHAR(255) NOT NULL,
  `icons` VARCHAR(255) DEFAULT NULL
);

-- Chèn dữ liệu mẫu
INSERT INTO `users` (`email`, `username`, `fullname`, `password`, `roleid`) VALUES 
('admin@example.com', 'admin', 'Administrator', 'admin123', 1),
('manager@example.com', 'manager', 'Manager', 'manager123', 2),
('user@example.com', 'user', 'Normal User', 'user123', 3);
