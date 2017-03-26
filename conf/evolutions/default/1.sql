# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table blog_post (
  blog_id                       bigint not null,
  blog_title                    varchar(255),
  blog_description              varchar(255),
  num_likes                     integer,
  post_date                     timestamp,
  constraint pk_blog_post primary key (blog_id)
);
create sequence blog_post_seq increment by 1;

create table category (
  category_id                   bigint not null,
  constraint pk_category primary key (category_id)
);
create sequence category_seq increment by 1;

create table order_item (
  order_item_id                 bigint not null,
  quantity                      integer,
  total_price                   double,
  order_id                      bigint,
  product_id                    bigint,
  constraint pk_order_item primary key (order_item_id)
);
create sequence order_item_seq increment by 1;

create table orders (
  order_id                      bigint not null,
  date                          varchar(255),
  dispatched                    varchar(255),
  user_id                       varchar(255),
  constraint pk_orders primary key (order_id)
);
create sequence orders_seq increment by 1;

create table product (
  product_id                    bigint not null,
  name                          varchar(255),
  quantity                      integer,
  price                         double,
  description                   varchar(255),
  constraint pk_product primary key (product_id)
);
create sequence product_seq increment by 1;

create table user (
  email                         varchar(255) not null,
  first_name                    varchar(255),
  last_name                     varchar(255),
  role                          varchar(255),
  password                      varchar(255),
  age                           integer,
  phone                         varchar(255),
  mobile                        varchar(255),
  constraint pk_user primary key (email)
);

create table wish_list (
  wishlist_id                   bigint not null,
  num_items                     integer,
  user_id                       bigint,
  product_id                    bigint,
  constraint pk_wish_list primary key (wishlist_id)
);
create sequence wish_list_seq increment by 1;


# --- !Downs

drop table if exists blog_post;
drop sequence if exists blog_post_seq;

drop table if exists category;
drop sequence if exists category_seq;

drop table if exists order_item;
drop sequence if exists order_item_seq;

drop table if exists orders;
drop sequence if exists orders_seq;

drop table if exists product;
drop sequence if exists product_seq;

drop table if exists user;

drop table if exists wish_list;
drop sequence if exists wish_list_seq;

