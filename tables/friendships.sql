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
	KEY (`followed`, `following`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
PARTITION BY RANGE COLUMNS (`created_at`) (
	PARTITION p20190101 VALUES LESS THAN ('2019-01-02 00:00:00'),
	PARTITION p20190102 VALUES LESS THAN ('2019-01-03 00:00:00')
);

# フォローする（申請制の場合はフォローを返すことで承認とみなす）
INSERT INTO `friendships` (`following`, `followed`) VALUES (?, ?);
INSERT INTO `friendships_logs` (`following`, `followed`, `action`) VALUES (?, ?, ?);

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

# パーティションの追加
ALTER TABLE `friendships_logs` ADD PARTITION (
	PARTITION p20190103 VALUES LESS THAN ('2019-01-04 00:00:00')
);

# パーティションのバックアップ 3 パターン（ $user, $db は任意の値、ファイルを見失わないように絶対パスにしておく）
SELECT * FROM `friendships_logs` INTO OUTFILE '/var/lib/mysql-files/friendships_logs.p20190101.tsv';
# mysqldump -u$user -p -hlocalhost --default-character-set=utf8 --complete-insert --no-create-info --where="created_at < '2019-01-02 00:00:00'" $db friendships_logs > /var/lib/mysql-files/friendships_logs.p20190101.sql
# mysqldump -u$user -p -hlocalhost --where="created_at < '2019-01-02 00:00:00'" --tab=/var/lib/mysql-files/ $db friendships_logs

## 下記ディレクトリに出力推奨
SELECT @@secure_file_priv;
# +-----------------------+
# | @@secure_file_priv    |
# +-----------------------+
# | /var/lib/mysql-files/ |
# +-----------------------+

# パーティションの削除
ALTER TABLE `friendships_logs` DROP PARTITION p20190101;

# リストア 3 パターン
LOAD DATA INFILE '/var/lib/mysql-files/friendships_logs.p20190101.tsv' INTO TABLE `friendships_logs`;
# mysql -u$user -p -hlocalhost $db < /var/lib/mysql-files/friendships_logs.p20190101.sql
# mysqlimport -u$user -p -hlocalhost $db /var/lib/mysql-files/friendships_logs.p20190101.tsv

# NOTE
# RANGE COLUMNS が使えるのは MySQL 5.5 以降
# パーティションのドロップはデータ量に関係なく一瞬のようなので日単位ではなく月単位くらいでも良さそう。
# 水平分割する場合は JOIN をやめて following で分ける。 Redis のリストか何かでキャッシュする。
