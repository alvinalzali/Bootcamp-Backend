create table users (
id serial primary key ,
email varchar(100) not null unique,
password varchar(255) not null,
name varchar (100),
role smallint,
created_at timestamp default now(),
updated_at timestamp default now()
);

create table plan (
id serial primary key,
plan_name varchar(50),
max_participant SMALLINT,
price int,
created_at timestamp default now(),
updated_at timestamp default now()
);

create table roomMeeting (
id serial primary key,
password smallint not null,
plan_id int references plan(id) on delete cascade,
record boolean,
timeStart timestamp,
timeEnd timestamp,
createdByUser int not null,
created_at timestamp default now(),
updated_at timestamp default now()
);

create table participant (
id serial primary key,
user_id int references users(id) on delete cascade,
meeting_id int references roomMeeting(id) on delete cascade,
join_time timestamp,
leave_time timestamp,
created_at timestamp default now(),
updated_at timestamp default now()
);

create table premiumUsers (
id serial primary key,
user_id int references users(id) on delete cascade,
plan_id int references plan(id) on delete cascade, 
subscription_start timestamp,
subscription_end timestamp,
payment_status SMALLINT,
created_at timestamp default now(),
updated_at timestamp default now()
);

create table recordCloud (
id serial primary key,
meeting_id int references roomMeeting(id) on delete cascade,
chatFile varchar(255),
videoFile varchar(255),
created_at timestamp default now(),
updated_at timestamp default now()
);