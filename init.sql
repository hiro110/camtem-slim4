CREATE USER app3 IDENTIFIED BY '<password>';
CREATE DATABASE app3 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';
GRANT ALL ON app3.* TO 'app3' identified by '<password>';

/*
  * 管理サイトユーザ
*/
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` int(11) NOT NULL DEFAULT '1',
  `is_active` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `username_2` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `users` (`username`, `password`, `role`) VALUES
('user', '$2y$10$Fn26scxVobuHaHz2sNtYDeP3x703QAsVjCLj4pdQdMpjGq78ma/MC', 0);
-- user / user@123

/*
  * フォーム管理
*/

drop table form_groups;
CREATE TABLE `form_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `base_uri` varchar(255) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT '1',
  `publishing_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `publishing_end` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `base_uri` (`base_uri`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*
  * フォーム定義
*/
drop table form_items;
CREATE TABLE `form_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_group_id` int(11) NOT NULL,
  `label_name` varchar(255) NOT NULL DEFAULT '',
  `schema_name` varchar(255) NOT NULL DEFAULT '',
  `input_type` int(11) NOT NULL DEFAULT '0',
  `placeholder` text,
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `choice_value` text NOT NULL,
  `validate` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*
  * 送信（登録）した入力グループ
*/
drop table submits;
CREATE TABLE `submits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_group_id` int(11) NOT NULL DEFAULT '0',
  `is_active` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*
  * 送信（登録）した入力値管理
*/
drop table submit_values;
CREATE TABLE `submit_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submit_id` int(11) DEFAULT NULL,
  `label_name` varchar(255) NOT NULL DEFAULT '',
  `schema_name` varchar(255) NOT NULL DEFAULT '',
  `string` text,
  `num` int(11) NOT NULL DEFAULT '0',
  `datetime` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*
  * 操作ログ
*/
CREATE TABLE `actions` (
  `id` int AUTO_INCREMENT,
  `user` varchar(255) NOT NULL DEFAULT '',
  `method` varchar(255) NOT NULL DEFAULT '',
  `uri` varchar(255) NOT NULL DEFAULT '',
  `action` varchar(255) NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  INDEX (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
