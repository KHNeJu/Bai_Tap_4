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
  `createdDate` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `lastLogin` DATETIME DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `categories` (
  `CategoryId` INT AUTO_INCREMENT PRIMARY KEY,
  `CategoryName` VARCHAR(255) NOT NULL,
  `Images` VARCHAR(255) DEFAULT NULL,
  `Status` INT NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS `videos` (
  `VideoId` VARCHAR(50) PRIMARY KEY,
  `Active` BOOLEAN NOT NULL DEFAULT TRUE,
  `Description` VARCHAR(500) DEFAULT NULL,
  `Poster` VARCHAR(500) DEFAULT NULL,
  `Title` VARCHAR(500) DEFAULT NULL,
  `Views` INT NOT NULL DEFAULT 0,
  `CategoryId` INT DEFAULT NULL,
  CONSTRAINT `fk_videos_category` FOREIGN KEY (`CategoryId`)
    REFERENCES `categories` (`CategoryId`) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS `products` (
  `ProductId` INT AUTO_INCREMENT PRIMARY KEY,
  `ProductName` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(2000) DEFAULT NULL,
  `Price` DECIMAL(12,2) NOT NULL DEFAULT 0,
  `Images` VARCHAR(500) DEFAULT NULL,
  `Quantity` INT NOT NULL DEFAULT 0,
  `CreatedDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CategoryId` INT NOT NULL,
  CONSTRAINT `fk_products_category` FOREIGN KEY (`CategoryId`)
    REFERENCES `categories` (`CategoryId`) ON DELETE CASCADE
);

INSERT INTO `users` (`email`, `username`, `fullname`, `password`, `roleid`) VALUES
('admin@example.com', 'admin', 'Administrator', 'admin123', 1)
ON DUPLICATE KEY UPDATE `fullname` = VALUES(`fullname`), `password` = VALUES(`password`), `roleid` = VALUES(`roleid`);

INSERT INTO `users` (`email`, `username`, `fullname`, `password`, `roleid`) VALUES
('manager@example.com', 'manager', 'Manager', 'manager123', 2)
ON DUPLICATE KEY UPDATE `fullname` = VALUES(`fullname`), `password` = VALUES(`password`), `roleid` = VALUES(`roleid`);

INSERT INTO `users` (`email`, `username`, `fullname`, `password`, `roleid`) VALUES
('user@example.com', 'user', 'Normal User', 'user123', 3)
ON DUPLICATE KEY UPDATE `fullname` = VALUES(`fullname`), `password` = VALUES(`password`), `roleid` = VALUES(`roleid`);
