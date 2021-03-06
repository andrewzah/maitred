create table `servers` (
	`id` integer primary key autoincrement,
	`ip` integer not null,
	`port` integer not null,
	`description` text not null,
	`mod` text,
	`last_active` integer not null default (strftime('%s', 'now')),
	unique (`ip`, `port`)
);

create index idx_servers_descr on `servers`(`description`);

create table `users` (
	`name` text primary key,
	`pubkey` text not null,
	`admin` integer not null default 0,
	`created_at` integer not null default (strftime('%s', 'now')),
	`last_authed_at` integer not null default 0
);

create table `games` (
	`id` integer primary key autoincrement,
	`server` integer not null references `servers`(`id`),
	`mode` integer not null,
	`map` text not null,
	`ended_at` integer not null default (strftime('%s', 'now')),
	unique(`server`, `ended_at`)
);

create table `stats` (
	`game` integer not null references `games`(`id`),
	`user` text not null references `users`(`name`),
	`frags` integer not null,
	`deaths` integer not null,
	`damage` integer not null,
	`potential` integer not null,
	`flags` integer not null,
	unique(`game`, `user`)
);

create index idx_stats_game on `stats`(`game`);
create index idx_stats_user on `stats`(`user`);