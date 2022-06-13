CREATE TABLE `users` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `email` varchar(255) UNIQUE,
  `password` varchar(255),
  `lastname` varchar(255),
  `firstname` varchar(255),
  `address` varchar(255),
  `zipcode` varchar(255),
  `city` varchar(255),
  `roles` json,
  `created_at` datetime DEFAULT (now())
);

CREATE TABLE `products` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `slug` varchar(255),
  `description` text,
  `price` int,
  `stock` int,
  `categories_id` int,
  `created_at` datetime DEFAULT (now())
);

CREATE TABLE `images` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `products_id` int
);

CREATE TABLE `categories` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `slug` varchar(255),
  `category_order` int,
  `parent_id` int
);

CREATE TABLE `orders` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `reference` varchar(255) UNIQUE,
  `coupons_id` int,
  `users_id` int,
  `created_at` datetime DEFAULT (now())
);

CREATE TABLE `orders_details` (
  `orders_id` int,
  `products_id` int,
  `quantity` int,
  `price` int,
  PRIMARY KEY (`orders_id`, `products_id`)
);

CREATE TABLE `coupons` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `code` varchar(255) UNIQUE,
  `description` text,
  `coupons_types_id` int,
  `discount` int,
  `max_usage` int,
  `validity` datetime,
  `is_valid` boolean,
  `created_at` datetime
);

CREATE TABLE `coupons_types` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255)
);

ALTER TABLE `products` ADD FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`);

ALTER TABLE `images` ADD FOREIGN KEY (`products_id`) REFERENCES `products` (`id`);

ALTER TABLE `categories` ADD FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);

ALTER TABLE `orders_details` ADD FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`);

ALTER TABLE `orders_details` ADD FOREIGN KEY (`products_id`) REFERENCES `products` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`coupons_id`) REFERENCES `coupons` (`id`);

ALTER TABLE `coupons` ADD FOREIGN KEY (`coupons_types_id`) REFERENCES `coupons_types` (`id`);
