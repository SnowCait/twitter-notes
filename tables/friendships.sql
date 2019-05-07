CREATE TABLE `friendships` (
	`following` INT UNSIGNED NOT NULL,  # フォローしているユーザーID
	`followed` INT UNSIGNED NOT NULL,   # フォローされているユーザーID
	PRIMARY KEY (`following`, `followed`),
	KEY (`followed`, `following`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `friendships_logs` (
	`following` INT UNSIGNED NOT NULL,
	`followed` INT UNSIGNED NOT NULL,
	`action` TINYINT UNSIGNED NOT NULL,  # フォロー、解除（申請、承認、解除）
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`following`, `followed`, `action`, `created_at`),
	KEY (`followed`, `following`, `action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# フォローする（申請制の場合はフォローを返すことで承認とみなす）
INSERT INTO `friendships` (`following`, `followed`) VALUES (?, ?);
INSERT INTO `friendships_logs` (`action`, `following`, `followed`) VALUES (?, ?, ?);

# フォローを外す（申請制の場合は両方解除する）
DELETE FROM `friendships` WHERE `following` = ? AND `followed` = ?;
INSERT INTO `friendships_logs` (`action`, `following`, `followed`) VALUES (?, ?, ?);

# フォローしている
SELECT `followed` FROM `friendships` WHERE `following` = ?;

# フォローされている
SELECT `following` FROM `friendships` WHERE `followed` = ?;

# 相互フォロー（申請制の場合はフレンド）
SELECT `a`.`followed` FROM `friendships` AS `a`
INNER JOIN `friendships` AS `b` ON `a`.`following` = `b`.`followed` AND `a`.`followed` = `b`.`following`
WHERE `a`.`following` < `a`.`followed` AND `a`.`following` = ?;

# 片思い（申請制の場合は申請中）
SELECT `a`.`followed` FROM `friendships` AS `a`
LEFT JOIN `friendships` AS `b` ON `a`.`following` = `b`.`followed` AND `a`.`followed` = `b`.`following`
WHERE `b`.`following` IS NULL AND `a`.`following` = ?;

# 片思われ（申請制の場合は承認待ち）
SELECT `a`.`following` FROM `friendships` AS `a`
LEFT JOIN `friendships` AS `b` ON `a`.`following` = `b`.`followed` AND `a`.`followed` = `b`.`following`
WHERE `b`.`following` IS NULL AND `a`.`followed` = ?;

# NOTE
# 水平分割する場合は JOIN をやめて following で分ける。 Redis のリストか何かでキャッシュする。
