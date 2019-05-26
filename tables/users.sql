CREATE TABLE `users` (  # or accounts
	`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL,  # 50文字
	`screen_name` VARCHAR(15) NOT NULL,  # 15文字
	`password_hash` VARCHAR(255) NOT NULL,  # 255文字
	`phone_number` BIGINT,
	`email` VARCHAR(255),
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# NOTE
# 採番テーブルなのでシャーディング不可、スケールさせる場合は他の仕組みで採番する
# 採番以外のカラムは別テーブルに持った方がいいかも？
