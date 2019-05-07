CREATE TABLE `friendships` (
	`following` INT UNSIGNED NOT NULL,  # フォローしているユーザーID
	`followed` INT UNSIGNED NOT NULL,   # フォローされているユーザーID
	PRIMARY KEY (`following`, `followed`),
	KEY (`followed`, `following`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `friendships_logs` (
	`following` INT UNSIGNED NOT NULL,
	`followed` INT UNSIGNED NOT NULL,
	`action` TINY INT UNSIGNED NOT NULL,  # フォロー、解除
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`following`, `followed`, `action`, `created_at`),
	KEY (`followed`, `following`, `action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# フォローする
INSERT INTO `friendships` (`following`, `followed`) VALUES (?, ?);
INSERT INTO `friendships_logs` (`action`, `following`, `followed`) VALUES (?, ?, ?);

# フォローを外す
DELETE FROM `friendships` WHERE `following` = ? AND `followed` = ?;
INSERT INTO `friendships_logs` (`action`, `following`, `followed`) VALUES (?, ?, ?);

# フォローしている
SELECT `followed` FROM `friendships` WHERE `following` = ?;

# フォローされている
SELECT `following` FROM `friendships` WHERE `followed` = ?;

# 相互フォロー
SELECT `a`.`followed` FROM `friendships` AS `a`
INNER JOIN `friendships` AS `b` ON `a`.`following` = `b`.`followed` AND `a`.`followed` = `b`.`following`
WHERE `a`.`following` < `a`.`followed` AND `a`.`following` = ?;

# 片思い
SELECT `a`.`followed` FROM `friendships` AS `a`
LEFT JOIN `friendships` AS `b` ON `a`.`following` = `b`.`followed` AND `a`.`followed` = `b`.`following`
WHERE `b`.`following` IS NULL AND `a`.`following` = ?;

# 片思われ
SELECT `a`.`following` FROM `friendships` AS `a`
LEFT JOIN `friendships` AS `b` ON `a`.`following` = `b`.`followed` AND `a`.`followed` = `b`.`following`
WHERE `b`.`following` IS NULL AND `a`.`followed` = ?;

# NOTE
# 水平分割する場合は JOIN をやめて following で分ける。 Redis のリストか何かでキャッシュする。
