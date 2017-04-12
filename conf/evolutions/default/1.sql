# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table basket (
  id                            bigint not null,
  user_email                    varchar(255),
  constraint uq_basket_user_email unique (user_email),
  constraint pk_basket primary key (id)
);
create sequence basket_seq;

create table blog_post (
  blog_id                       bigint not null,
  blog_title                    varchar(255),
  blog_description              varchar(255),
  num_likes                     integer,
  post_date                     timestamp,
  constraint pk_blog_post primary key (blog_id)
);
create sequence blog_post_seq increment by 1;

create table order_item (
  id                            bigint not null,
  order_id                      bigint,
  basket_id                     bigint,
  wishlist_id                   bigint,
  product_product_id            bigint,
  quantity                      integer,
  price                         double,
  price_quantity                double,
  constraint pk_order_item primary key (id)
);
create sequence order_item_seq;

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
  category                      varchar(255),
  constraint pk_product primary key (product_id)
);
create sequence product_seq increment by 1;

create table shop_order (
  id                            bigint not null,
  order_date                    timestamp,
  user_email                    varchar(255),
  constraint pk_shop_order primary key (id)
);
create sequence shop_order_seq;

create table user (
  email                         varchar(255) not null,
  first_name                    varchar(255),
  last_name                     varchar(255),
  role                          varchar(255),
  password                      varchar(255),
  address                       varchar(255),
  age                           integer,
  phone                         varchar(255),
  mobile                        varchar(255),
  join_date                     timestamp,
  constraint pk_user primary key (email)
);

create table wishlist (
  id                            bigint not null,
  user_email                    varchar(255),
  constraint uq_wishlist_user_email unique (user_email),
  constraint pk_wishlist primary key (id)
);
create sequence wishlist_seq;

alter table basket add constraint fk_basket_user_email foreign key (user_email) references user (email) on delete restrict on update restrict;

alter table order_item add constraint fk_order_item_order_id foreign key (order_id) references shop_order (id) on delete restrict on update restrict;
create index ix_order_item_order_id on order_item (order_id);

alter table order_item add constraint fk_order_item_basket_id foreign key (basket_id) references basket (id) on delete restrict on update restrict;
create index ix_order_item_basket_id on order_item (basket_id);

alter table order_item add constraint fk_order_item_wishlist_id foreign key (wishlist_id) references wishlist (id) on delete restrict on update restrict;
create index ix_order_item_wishlist_id on order_item (wishlist_id);

alter table order_item add constraint fk_order_item_product_product_id foreign key (product_product_id) references product (product_id) on delete restrict on update restrict;
create index ix_order_item_product_product_id on order_item (product_product_id);

alter table shop_order add constraint fk_shop_order_user_email foreign key (user_email) references user (email) on delete restrict on update restrict;
create index ix_shop_order_user_email on shop_order (user_email);

alter table wishlist add constraint fk_wishlist_user_email foreign key (user_email) references user (email) on delete restrict on update restrict;


# --- !Downs

alter table basket drop constraint if exists fk_basket_user_email;

alter table order_item drop constraint if exists fk_order_item_order_id;
drop index if exists ix_order_item_order_id;

alter table order_item drop constraint if exists fk_order_item_basket_id;
drop index if exists ix_order_item_basket_id;

alter table order_item drop constraint if exists fk_order_item_wishlist_id;
drop index if exists ix_order_item_wishlist_id;

alter table order_item drop constraint if exists fk_order_item_product_product_id;
drop index if exists ix_order_item_product_product_id;

alter table shop_order drop constraint if exists fk_shop_order_user_email;
drop index if exists ix_shop_order_user_email;

alter table wishlist drop constraint if exists fk_wishlist_user_email;

drop table if exists basket;
drop sequence if exists basket_seq;

drop table if exists blog_post;
drop sequence if exists blog_post_seq;

drop table if exists order_item;
drop sequence if exists order_item_seq;

drop table if exists orders;
drop sequence if exists orders_seq;

drop table if exists product;
drop sequence if exists product_seq;

drop table if exists shop_order;
drop sequence if exists shop_order_seq;

drop table if exists user;

drop table if exists wishlist;
drop sequence if exists wishlist_seq;

