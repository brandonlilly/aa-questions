DROP TABLE users;
DROP TABLE questions;
DROP TABLE question_follows;
DROP TABLE replies;
DROP TABLE question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body TEXT,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO users (fname, lname)
VALUES ('Foo', 'Bar');
INSERT INTO users (fname, lname)
VALUES ('Yiling', 'Chen');
INSERT INTO users (fname, lname)
VALUES ('Brandon', 'Lilly');
INSERT INTO users (fname, lname)
VALUES ('Jacob', 'Hamblin');

INSERT INTO questions (title, body, user_id)
VALUES ('Greetings', 'How are you?', 1);
INSERT INTO questions (title, body, user_id)
VALUES ('Yo', 'What about that app?', 3);
INSERT INTO questions (title, body, user_id)
VALUES ('secrets', 'Whats your darkest secret?', 3);

INSERT INTO replies (body, user_id, question_id, parent_id)
VALUES ('I am doing well', 4, 1, NULL);
INSERT INTO replies (body, user_id, question_id, parent_id)
VALUES ('Good!', 3, 1, 1);
INSERT INTO replies (body, user_id, question_id, parent_id)
VALUES ('That is a funny app', 4, 2, NULL);

INSERT INTO question_follows (user_id, question_id)
VALUES (1, 1);
INSERT INTO question_follows (user_id, question_id)
VALUES (2, 2);
INSERT INTO question_follows (user_id, question_id)
VALUES (3, 3);
INSERT INTO question_follows (user_id, question_id)
VALUES (2, 3);
INSERT INTO question_follows (user_id, question_id)
VALUES (4, 3);
INSERT INTO question_follows (user_id, question_id)
VALUES (3, 1);

INSERT INTO question_likes (user_id, question_id)
VALUES (1, 2);
INSERT INTO question_likes (user_id, question_id)
VALUES (2, 3);
INSERT INTO question_likes (user_id, question_id)
VALUES (4, 3);
INSERT INTO question_likes (user_id, question_id)
VALUES (1, 1);
INSERT INTO question_likes (user_id, question_id)
VALUES (3, 2);
INSERT INTO question_likes (user_id, question_id)
VALUES (1, 3);
