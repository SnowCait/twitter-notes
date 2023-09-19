CREATE TABLE `users` (  # or accounts
	`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`screen_name` VARCHAR(15) NOT NULL,  # 15文字
	`password_hash` VARCHAR(255) NOT NULL,  # 255文字
	`phone_number` BIGINT,
	`email` VARCHAR(255),
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	UNIQUE KEY (`screen_name`),
	UNIQUE KEY (`phone_number`),
	UNIQUE KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `roles` (
	`user_id` BIGINT UNSIGNED NOT NULL,
	`role` TINYINT UNSIGNED NOT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`user_id`, `role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `profiles` (
	`user_id` BIGINT UNSIGNED NOT NULL,
	`name` VARCHAR(50) NOT NULL,
	`introduction` VARCHAR(160),
	`place` VARCHAR(30),
	`website_url` VARCHAR(100),
	`birthday` DATETIME,
	`icon_url` VARCHAR(100),
	`header_url` VARCHAR(100),
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# NOTE
# 採番テーブルなのでシャーディング不可、スケールさせる場合は他の仕組みで採番する
# 採番以外のカラムは別テーブルに持った方がいいかも？
