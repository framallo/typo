-- This file is autogenerated by the Rail schema generator, using
-- the schema defined in db/migration/*.rb
--
-- Do not edit this file.  Instead, add a new migration using
-- ./script/generate migration <name>, and then run
-- ./script/generate schema

-- tables 

CREATE TABLE articles (
  id serial primary key,
  title character varying(255),
  author character varying(255),
  body text,
  body_html text,
  extended text,
  excerpt text,
  keywords character varying(255),
  allow_comments integer,
  allow_pings integer,
  published integer DEFAULT '1',
  created_at timestamp,
  updated_at timestamp,
  extended_html text,
  guid character varying(255),
  permalink character varying(255),
  user_id integer,
  text_filter_id integer
);

CREATE TABLE articles_categories (
  article_id integer,
  category_id integer,
  is_primary integer
);

CREATE TABLE articles_tags (
  article_id integer,
  tag_id integer
);

CREATE TABLE blacklist_patterns (
  id serial primary key,
  type character varying(255),
  pattern character varying(255)
);

CREATE TABLE categories (
  id serial primary key,
  name character varying(255),
  position integer,
  permalink character varying(255)
);

CREATE TABLE comments (
  id serial primary key,
  article_id integer,
  title character varying(255),
  author character varying(255),
  email character varying(255),
  url character varying(255),
  ip character varying(255),
  body text,
  body_html text,
  created_at timestamp,
  updated_at timestamp,
  user_id integer
);

CREATE TABLE page_caches (
  id serial primary key,
  name character varying(255)
);

CREATE TABLE pages (
  id serial primary key,
  name character varying(255),
  user_id integer,
  body text,
  body_html text,
  created_at timestamp,
  updated_at timestamp,
  title character varying(255),
  text_filter_id integer
);

CREATE TABLE pings (
  id serial primary key,
  article_id integer,
  url character varying(255),
  created_at timestamp
);

CREATE TABLE resources (
  id serial primary key,
  size integer,
  filename character varying(255),
  mime character varying(255),
  created_at timestamp,
  updated_at timestamp,
  article_id integer
);

CREATE TABLE sessions (
  id serial primary key,
  sessid character varying(255),
  data text,
  created_at timestamp,
  updated_at timestamp
);

CREATE TABLE settings (
  id serial primary key,
  name character varying(255),
  value character varying(255),
  position integer
);

CREATE TABLE sidebars (
  id serial primary key,
  controller character varying(255),
  active_position integer,
  active_config text,
  staged_position integer,
  staged_config text
);

CREATE TABLE tags (
  id serial primary key,
  name character varying(255),
  created_at timestamp,
  updated_at timestamp
);

CREATE TABLE text_filters (
  id serial primary key,
  name character varying(255),
  description character varying(255),
  markup character varying(255),
  filters text,
  params text
);

CREATE TABLE trackbacks (
  id serial primary key,
  article_id integer,
  blog_name character varying(255),
  title character varying(255),
  excerpt character varying(255),
  url character varying(255),
  ip character varying(255),
  created_at timestamp,
  updated_at timestamp
);

CREATE TABLE users (
  id serial primary key,
  login character varying(255),
  password character varying(255),
  email text,
  name text
);


-- indexes 

CREATE  INDEX articles_permalink_index ON articles (permalink);
CREATE  INDEX blacklist_patterns_pattern_index ON blacklist_patterns (pattern);
CREATE  INDEX categories_permalink_index ON categories (permalink);
CREATE  INDEX comments_article_id_index ON comments (article_id);
CREATE  INDEX page_caches_name_index ON page_caches (name);
CREATE  INDEX pings_article_id_index ON pings (article_id);
CREATE  INDEX trackbacks_article_id_index ON trackbacks (article_id);

-- data 

INSERT INTO sidebars ("staged_position", "active_config", "active_position", "controller", "staged_config") VALUES(NULL, NULL, 0, 'category', NULL);
INSERT INTO sidebars ("staged_position", "active_config", "active_position", "controller", "staged_config") VALUES(NULL, NULL, 1, 'static', NULL);
INSERT INTO sidebars ("staged_position", "active_config", "active_position", "controller", "staged_config") VALUES(NULL, NULL, 2, 'xml', NULL);
INSERT INTO text_filters ("name", "filters", "description", "params", "markup") VALUES('none', '--- []', 'None', '--- {}', 'none');
INSERT INTO text_filters ("name", "filters", "description", "params", "markup") VALUES('markdown', '--- []', 'Markdown', '--- {}', 'markdown');
INSERT INTO text_filters ("name", "filters", "description", "params", "markup") VALUES('smartypants', '--- 
- :smartypants', 'SmartyPants', '--- {}', 'none');
INSERT INTO text_filters ("name", "filters", "description", "params", "markup") VALUES('markdown smartypants', '--- 
- :smartypants', 'Markdown with SmartyPants', '--- {}', 'markdown');
INSERT INTO text_filters ("name", "filters", "description", "params", "markup") VALUES('textile', '--- []', 'Textile', '--- {}', 'textile');

-- schema version meta-info 

CREATE TABLE schema_info (
  version integer
);

insert into schema_info (version) values (17);