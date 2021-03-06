CREATE TABLE `tag` (
  `name` VARCHAR(255) PRIMARY KEY
);

CREATE TABLE `user` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
  `username` VARCHAR(255) UNIQUE NOT NULL,
  `hash` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) UNIQUE NOT NULL,
  `dt` DATETIME NOT NULL
);

CREATE TABLE `Photo` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
  `publication` LONGBLOB NOT NULL,
  `dt` DATETIME NOT NULL,
  `user` INTEGER NOT NULL
);

CREATE INDEX `idx_photo__user` ON `Photo` (`user`);

ALTER TABLE `Photo` ADD CONSTRAINT `fk_photo__user` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE CASCADE;

CREATE TABLE `comment` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
  `publication` INTEGER NOT NULL,
  `user` INTEGER NOT NULL,
  `dt` DATETIME NOT NULL,
  `text` VARCHAR(255) NOT NULL,
  `mentioned` INTEGER
);

CREATE INDEX `idx_comment__mentioned` ON `comment` (`mentioned`);

CREATE INDEX `idx_comment__publication` ON `comment` (`publication`);

CREATE INDEX `idx_comment__user` ON `comment` (`user`);

ALTER TABLE `comment` ADD CONSTRAINT `fk_comment__mentioned` FOREIGN KEY (`mentioned`) REFERENCES `user` (`id`) ON DELETE SET NULL;

ALTER TABLE `comment` ADD CONSTRAINT `fk_comment__publication` FOREIGN KEY (`publication`) REFERENCES `Photo` (`id`) ON DELETE CASCADE;

ALTER TABLE `comment` ADD CONSTRAINT `fk_comment__user` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE CASCADE;

CREATE TABLE `following` (
  `follower` INTEGER NOT NULL,
  `followed` INTEGER NOT NULL,
  `dt` DATETIME NOT NULL,
  PRIMARY KEY (`follower`, `followed`)
);

CREATE INDEX `idx_following__followed` ON `following` (`followed`);

ALTER TABLE `following` ADD CONSTRAINT `fk_following__followed` FOREIGN KEY (`followed`) REFERENCES `user` (`id`) ON DELETE CASCADE;

ALTER TABLE `following` ADD CONSTRAINT `fk_following__follower` FOREIGN KEY (`follower`) REFERENCES `user` (`id`) ON DELETE CASCADE;

CREATE TABLE `like` (
  `user` INTEGER NOT NULL,
  `publication` INTEGER NOT NULL,
  `dt` DATETIME NOT NULL,
  PRIMARY KEY (`user`, `publication`)
);

CREATE INDEX `idx_like__publication` ON `like` (`publication`);

ALTER TABLE `like` ADD CONSTRAINT `fk_like__publication` FOREIGN KEY (`publication`) REFERENCES `Photo` (`id`) ON DELETE CASCADE;

ALTER TABLE `like` ADD CONSTRAINT `fk_like__user` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE CASCADE;

CREATE TABLE `mediacontent` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
  `type` VARCHAR(255) NOT NULL,
  `number` INTEGER,
  `publication` INTEGER NOT NULL
);

CREATE INDEX `idx_mediacontent__publication` ON `mediacontent` (`publication`);

ALTER TABLE `mediacontent` ADD CONSTRAINT `fk_mediacontent__publication` FOREIGN KEY (`publication`) REFERENCES `Photo` (`id`) ON DELETE CASCADE;

CREATE TABLE `publication_tag` (
  `publication` INTEGER NOT NULL,
  `tag` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`publication`, `tag`)
);

CREATE INDEX `idx_publication_tag` ON `publication_tag` (`tag`);

ALTER TABLE `publication_tag` ADD CONSTRAINT `fk_publication_tag__publication` FOREIGN KEY (`publication`) REFERENCES `Photo` (`id`);

ALTER TABLE `publication_tag` ADD CONSTRAINT `fk_publication_tag__tag` FOREIGN KEY (`tag`) REFERENCES `tag` (`name`)
