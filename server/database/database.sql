CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

create table users
(
    uid      uuid default uuid_generate_v4() not null
        constraint user_pk
            primary key,
    email    varchar                         not null,
    password varchar                         not null
);

alter table users
    owner to planme_user;


create unique index user_email_uindex
    on users (email);

create table achievement
(
    achievement_id   serial not null
        constraint achievement_pk
            primary key,
    achievement_name varchar(50)
);

alter table achievement
    owner to planme_user;

create unique index achievement_achievement_id_uindex
    on achievement (achievement_id);

create table ach_level
(
    level_id          integer,
    level_name        varchar(30),
    level_description varchar(50),
    level_img         varchar(255),
    achievement_id    integer
        constraint ach_level_achievement_achievement_id_fk
            references achievement
);

alter table ach_level
    owner to planme_user;


create table category
(
    cid           uuid default uuid_generate_v4() not null
        constraint category_pk
            primary key,
    category_name varchar(25),
    color_code    varchar(5)
);

alter table category
    owner to planme_user;

create table event
(
    event_id   uuid    default uuid_generate_v4() not null
        constraint event_pk
            primary key,
    event_date date,
    event_name varchar(50),
    cid        uuid
        constraint event_category_cid_fk
            references category,
    finish     boolean default false
);

alter table event
    owner to planme_user;

create table login_accumulate
(
    uid   uuid,
    times integer
);

alter table login_accumulate
    owner to planme_user;

create table login_log
(
    uid  uuid not null
        constraint login_log_users_uid_fk
            references users,
    date date
);

alter table login_log
    owner to planme_user;

create table user_achievement
(
    uid               uuid,
    achievement_level integer,
    achievement_id    integer
);

alter table user_achievement
    owner to planme_user;

create table user_category
(
    uid uuid not null
        constraint user_category_users_uid_fk
            references users,
    cid uuid not null
        constraint user_category_category_cid_fk
            references category
);

alter table user_category
    owner to planme_user;

create table user_event
(
    uid      uuid
        constraint user_event_users_uid_fk
            references users,
    event_id uuid
        constraint user_event_event_event_id_fk
            references event
);

alter table user_event
    owner to planme_user;

create table user_timer
(
    uid        uuid
        constraint user_timer_users_uid_fk
            references users,
    timer_date date,
    cid        uuid
        constraint user_timer_category_cid_fk
            references category,
    timer_time integer
);

alter table user_timer
    owner to planme_user;

INSERT INTO public.achievement (achievement_name) VALUES ('Login');
INSERT INTO public.achievement (achievement_name) VALUES ('Login Accumulate');
INSERT INTO public.achievement (achievement_name) VALUES ('Category');
INSERT INTO public.achievement (achievement_name) VALUES ('Timer');
INSERT INTO public.achievement (achievement_name) VALUES ('Timer Accumulate');
INSERT INTO public.achievement (achievement_name) VALUES ('Achievement Collect');
INSERT INTO public.achievement (achievement_name) VALUES ('Achievement Level');

INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (1, 'Fuan', 'For login 1 time', 'login/fuan.png', 1);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (2, 'Athena', 'For login 15 times', 'login/athena.png', 1);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (3, 'Hades', 'For login 30 times', 'login/hades.png', 1);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (4, 'Poseidon', 'For login 60 times', 'login/poseidon.png', 1);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (5, 'Zeus', 'For login 180 times', 'login/zeus.png', 1);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (6, 'Cronus', 'For login 360 times', 'login/cronus.png', 1);

INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (1, '1 Day', 'For login 1 day', 'login_acc/1_day.png', 2);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (2, '3 Days', 'For login 3 days', 'login_acc/3_day.png', 2);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (3, '11 Days', 'For login 11 days', 'login_acc/11_day.png', 2);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (4, '17 Days', 'For login 17 days', 'login_acc/17_day.png', 2);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (5, '28 Days', 'For login 28 days', 'login_acc/28_day.png', 2);

INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (1, 'Sloth', 'For create own 5 category', 'category/sloth.png', 3);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (2, 'Turtle', 'For create own 7 categories', 'category/turtle.png', 3);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (3, 'Horse', 'For create own 10 categories', 'category/horse.png', 3);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (4, 'Kangaroo', 'For create own 15 categories', 'category/kangaroo.png', 3);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (5, 'Cheetah', 'For create own 20 categories', 'category/cheetah.png', 3);

INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (1, 'Seeding', 'For timer 25 mins in each times', 'time_once/seeding.png', 4);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (2, 'Planting', 'For timer 45 mins in each times', 'time_once/planting.png', 4);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (3, 'Plant with flowers', 'For timer 60 mins in each time', 'time_once/flower.png', 4);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (4, 'Plant with fruit', 'For timer 120 mins in each times', 'time_once/fruit.png', 4);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (5, 'Harvest', 'For timer 180 mins in each times', 'time_once/harvest.png', 4);

INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (1, 'First Star', 'For accumulated time 100 mins', 'time_acc/star.png', 5);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (2, 'Stars', 'For accumulated time 300 mins', 'time_acc/3_stars.png', 5);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (3, 'Constellation', 'For accumulated time 600 mins', 'time_acc/constellation.png', 5);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (4, 'Moon', 'For accumulated time 1200 mins', 'time_acc/moon.png', 5);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (5, 'Sun', 'For accumulated time 3000 mins', 'time_acc/sun.png', 5);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (6, 'Galaxy', 'For accumulated time 6000 mins', 'time_acc/galaxy.png', 5);

INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (1, 'Candy', 'For finish 5 achievement', 'achievement_finish/candy.png', 6);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (2, 'Cookie', 'For finish 10 achievements', 'achievement_finish/cookie.png', 6);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (3, 'Ice-cream', 'For finish 15 achievements', 'achievement_finish/ice-cream.png', 6);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (4, 'Pancake', 'For finish 20 achievements', 'achievement_finish/pancake.png', 6);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (5, 'Cake', 'For finish 25 achievements', 'achievement_finish/cake.png', 6);

INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (1, 'Warming', 'For reach level 1 at least 5 achievements', 'achievement_lv/warming.png', 7);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (2, 'Walking', 'For reach level 2 at least 5 achievements', 'achievement_lv/walking.png', 7);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (3, 'Jogging', 'For reach level 3 at least 5 achievements', 'achievement_lv/jogging.png', 7);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (4, 'Running', 'For reach level 4 at least 5 achievements', 'achievement_lv/running.png', 7);
INSERT INTO public.ach_level (level_id, level_name, level_description, level_img, achievement_id) VALUES (5, 'Accelerate', 'For reach level 5 at least 5 achievements', 'achievement_lv/accelerate.png', 7);
