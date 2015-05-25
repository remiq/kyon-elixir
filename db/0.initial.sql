

CREATE TABLE items (
  id SERIAL,
  module VARCHAR(10),
  user_id INT,
  md5 VARCHAR(32),
  source VARCHAR(250),
  created TIMESTAMP
);

CREATE TABLE item_comments (
  id SERIAL,
  item_id INT,
  user_id INT,
  content TEXT,
  created TIMESTAMP
);

CREATE TABLE item_favs (
  id SERIAL,
  item_id INT,
  user_id INT
);

CREATE TABLE tags (
  id SERIAL,
  name VARCHAR(50),
  synonym_id INT DEFAULT 0
);

CREATE TABLE tag_items (
  id SERIAL,
  item_id INT,
  tag_id INT
);

CREATE TABLE tag_comments (
  id SERIAL,
  tag_id INT,
  user_id INT,
  content TEXT,
  created TIMESTAMP
);

CREATE TABLE tag_favs (
  id SERIAL,
  tag_id INT,
  user_id INT
);

CREATE TABLE users (
  id SERIAL,
  name VARCHAR(20),
  passwd VARCHAR(200),
  status INT
);

CREATE VIEW view_comments AS
SELECT CONCAT('i', id) AS id, 'item' AS type, item_id AS ref_id, user_id, content, created FROM item_comments 
UNION ALL 
SELECT CONCAT('t', id), 'tag' as type, tag_id AS ref_id, user_id, content, created FROM tag_comments;

