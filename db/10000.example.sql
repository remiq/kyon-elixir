

INSERT INTO items (id, module, user_id, md5, source, created) VALUES 
(13853, 'img', 1, '123', 'http://source/url', now());

INSERT INTO item_comments (item_id, user_id, content, created) VALUES
  (13853, 1, 'Test comment 1', NOW()),
  (13853, 1, 'Test comment 2', NOW()),
  (13853, 1, 'Test comment 3', NOW())
  ;

INSERT INTO tags (id, name) VALUES
  (1, 'aaa'),
  (2, 'bbb'),
  (3, 'ccc');

INSERT INTO tag_comments (tag_id, user_id, content, created) VALUES
  (1, 1, 'Test comment 1', NOW()),
  (1, 1, 'Test comment 2', NOW()),
  (1, 1, 'Test comment 3', NOW())
  ;

  INSERT INTO tag_items (item_id, tag_id) VALUES
  (13853, 1),
  (13853, 2),
  (13853, 3);

INSERT INTO users (id, name) VALUES (1, 'testuser');
