ALTER TABLE `ok_banners` DROP `description`;

ALTER TABLE `ok_settings` ADD UNIQUE `param` (`param`);

ALTER TABLE `ok_orders_status` ADD `status_1c` enum('new','accepted','to_delete', 'not_use') NULL DEFAULT 'not_use';
