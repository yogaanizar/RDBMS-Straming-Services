/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     12/30/2021 2:21:21 PM                        */
/*==============================================================*/


alter table CONTENTS
   drop constraint FK_CONTENTS_HAS_CATEGORI;

alter table CONTENTS
   drop constraint FK_CONTENTS_MANAGE_ADMINS;

alter table LOGS
   drop constraint FK_LOGS_LOGS_CONTENTS;

alter table LOGS
   drop constraint FK_LOGS_LOGS2_USERS;

alter table ORDERS
   drop constraint FK_ORDERS_ORDERS_PACKAGES;

alter table ORDERS
   drop constraint FK_ORDERS_ORDERS2_USERS;

alter table PAYMENTS
   drop constraint FK_PAYMENTS_DO_USERS;

alter table PAYMENTS
   drop constraint FK_PAYMENTS_PAID_OFF_PAYMENT_;

drop table ADMINS cascade constraints;

drop table CATEGORIES cascade constraints;

drop index MANAGE_FK;

drop index HAS_FK;

drop table CONTENTS cascade constraints;

drop index LOG_FK;

drop index LOG2_FK;

drop table LOGS cascade constraints;

drop index ORDER_FK;

drop index ORDER2_FK;

drop table ORDERS cascade constraints;

drop table PACKAGES cascade constraints;

drop index DO_FK;

drop table PAYMENTS cascade constraints;

drop table PAYMENT_METHODS cascade constraints;

drop table USERS cascade constraints;

/*==============================================================*/
/* Table: ADMINS                                                */
/*==============================================================*/
create table ADMINS 
(
   ADMIN_ID             NUMBER               not null,
   EMAIL_ADMIN          VARCHAR2(100)        not null,
   PASSWORD_ADMIN       VARCHAR2(50)         not null,
   constraint PK_ADMINS primary key (ADMIN_ID)
);

/*==============================================================*/
/* Table: CATEGORIES                                            */
/*==============================================================*/
create table CATEGORIES 
(
   CATEGORY_ID          NUMBER               not null,
   NAME_CATEGORY        VARCHAR2(50)         not null,
   constraint PK_CATEGORIES primary key (CATEGORY_ID)
);

/*==============================================================*/
/* Table: CONTENTS                                              */
/*==============================================================*/
create table CONTENTS 
(
   CONTENT_ID           NUMBER               not null,
   CATEGORY_ID          NUMBER               not null,
   ADMIN_ID             NUMBER               not null,
   CONTENT_NAME         VARCHAR2(30)         not null,
   CONTENT_DESCRIPTION  VARCHAR2(400)        not null,
   CAST                 VARCHAR2(100)        not null,
   GENRE                VARCHAR2(20),
   RATING               FLOAT(5),
   AGE_RESTRICTION      VARCHAR2(3),
   RELEASED_DATE        DATE                 not null,
   constraint PK_CONTENTS primary key (CONTENT_ID)
);

/*==============================================================*/
/* Index: HAS_FK                                                */
/*==============================================================*/
create index HAS_FK on CONTENTS (
   CATEGORY_ID ASC
);

/*==============================================================*/
/* Index: MANAGE_FK                                             */
/*==============================================================*/
create index MANAGE_FK on CONTENTS (
   ADMIN_ID ASC
);

/*==============================================================*/
/* Table: LOGS                                                  */
/*==============================================================*/
create table LOGS 
(
   USER_ID              NUMBER               not null,
   CONTENT_ID           NUMBER               not null,
   ACCES_DATE           DATE                 not null,
   USER_RATING          FLOAT(5),
   constraint PK_LOGS primary key (USER_ID, CONTENT_ID)
);

/*==============================================================*/
/* Index: LOG2_FK                                               */
/*==============================================================*/
create index LOG2_FK on LOGS (
   USER_ID ASC
);

/*==============================================================*/
/* Index: LOG_FK                                                */
/*==============================================================*/
create index LOG_FK on LOGS (
   CONTENT_ID ASC
);

/*==============================================================*/
/* Table: ORDERS                                                */
/*==============================================================*/
create table ORDERS 
(
   USER_ID              NUMBER               not null,
   PACKAGE_CODE         VARCHAR2(6)          not null,
   START_DATE           DATE                 not null,
   END_DATE             DATE                 not null,
   constraint PK_ORDERS primary key (USER_ID, PACKAGE_CODE)
);

/*==============================================================*/
/* Index: ORDER2_FK                                             */
/*==============================================================*/
create index ORDER2_FK on ORDERS (
   USER_ID ASC
);

/*==============================================================*/
/* Index: ORDER_FK                                              */
/*==============================================================*/
create index ORDER_FK on ORDERS (
   PACKAGE_CODE ASC
);

/*==============================================================*/
/* Table: PACKAGES                                              */
/*==============================================================*/
create table PACKAGES 
(
   PACKAGE_CODE         VARCHAR2(6)          not null,
   PACKAGE_NAME         VARCHAR2(30)         not null,
   PRICE                NUMBER(8,2)          not null,
   DURATION             NUMBER               not null,
   PACKAGE_DESCRIPTION  VARCHAR2(500)        not null,
   constraint PK_PACKAGES primary key (PACKAGE_CODE)
);

/*==============================================================*/
/* Table: PAYMENTS                                              */
/*==============================================================*/
create table PAYMENTS 
(
   PAYMENT_ID           NUMBER               not null,
   USER_ID              NUMBER               not null,
   METHOD_ID            NUMBER               not null,
   TOTAL_PAYMENT        NUMBER(8,2)          not null,
   PAYMENT_DATE         DATE                 not null,
   constraint PK_PAYMENTS primary key (PAYMENT_ID)
);

/*==============================================================*/
/* Index: DO_FK                                                 */
/*==============================================================*/
create index DO_FK on PAYMENTS (
   USER_ID ASC
);

/*==============================================================*/
/* Table: PAYMENT_METHODS                                       */
/*==============================================================*/
create table PAYMENT_METHODS 
(
   METHOD_ID            NUMBER               not null,
   NAME_METHOD          VARCHAR2(30)         not null,
   VIRTUAL_CODE         NUMBER(15)           not null,
   constraint PK_PAYMENT_METHODS primary key (METHOD_ID)
);

/*==============================================================*/
/* Table: USERS                                                 */
/*==============================================================*/
create table USERS 
(
   USER_ID              NUMBER               not null,
   PHONE_NUMBER         VARCHAR2(15)         not null,
   REGION               VARCHAR2(20)         not null,
   STATUS               SMALLINT             not null,
   NAME                 VARCHAR2(50)         not null,
   USERNAME             VARCHAR2(20)         not null,
   EMAIL                VARCHAR2(100)        not null,
   PASSWORD             VARCHAR2(50)         not null,
   AGE_VERIFICATION     VARCHAR2(10),
   constraint PK_USERS primary key (USER_ID)
);

alter table CONTENTS
   add constraint FK_CONTENTS_HAS_CATEGORI foreign key (CATEGORY_ID)
      references CATEGORIES (CATEGORY_ID);

alter table CONTENTS
   add constraint FK_CONTENTS_MANAGE_ADMINS foreign key (ADMIN_ID)
      references ADMINS (ADMIN_ID);

alter table LOGS
   add constraint FK_LOGS_LOGS_CONTENTS foreign key (CONTENT_ID)
      references CONTENTS (CONTENT_ID);

alter table LOGS
   add constraint FK_LOGS_LOGS2_USERS foreign key (USER_ID)
      references USERS (USER_ID);

alter table ORDERS
   add constraint FK_ORDERS_ORDERS_PACKAGES foreign key (PACKAGE_CODE)
      references PACKAGES (PACKAGE_CODE);

alter table ORDERS
   add constraint FK_ORDERS_ORDERS2_USERS foreign key (USER_ID)
      references USERS (USER_ID);

alter table PAYMENTS
   add constraint FK_PAYMENTS_DO_USERS foreign key (USER_ID)
      references USERS (USER_ID);

alter table PAYMENTS
   add constraint FK_PAYMENTS_PAID_OFF_PAYMENT_ foreign key (METHOD_ID)
      references PAYMENT_METHODS (METHOD_ID);

