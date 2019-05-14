CREATE TABLE `users` (
	`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# NOTE
# 採番テーブルなのでシャーディング不可、スケールさせる場合は他の仕組みで採番する
# 採番以外のカラムは基本的には別テーブルに持つ
