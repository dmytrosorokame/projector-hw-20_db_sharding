CREATE EXTENSION postgres_fdw;
/*==============*/
CREATE SERVER books_1_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (
  host 'postgresql-fwd-shard1',
  port '5432',
  dbname 'books'
);
/*==============*/
CREATE USER MAPPING FOR "postgres" SERVER books_1_server OPTIONS (user 'postgres', password 'postgres');
/*==============*/
CREATE SERVER books_2_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (
  host 'postgresql-fwd-shard2',
  port '5432',
  dbname 'books'
);
/*==============*/
CREATE USER MAPPING FOR "postgres" SERVER books_2_server OPTIONS (user 'postgres', password 'postgres');
/*==============*/
CREATE FOREIGN TABLE books_1 (
  id SERIAL not null,
  category_id int not null,
  title VARCHAR(50) NOT NULL
) SERVER books_1_server OPTIONS (schema_name 'public', table_name 'books');
/*==============*/
CREATE FOREIGN TABLE books_2 (
  id SERIAL not null,
  category_id int not null,
  title VARCHAR(50) NOT NULL
) SERVER books_2_server OPTIONS (schema_name 'public', table_name 'books');
/*==============*/
CREATE VIEW books AS
SELECT *
FROM books_1
UNION ALL
SELECT *
FROM books_2;
/*==============*/
CREATE RULE books_insert AS ON
INSERT TO books DO INSTEAD NOTHING;
/*==============*/
CREATE RULE books_update AS ON UPDATE TO books DO INSTEAD NOTHING;
/*==============*/
CREATE RULE books_delete AS ON DELETE TO books DO INSTEAD NOTHING;
/*==============*/
CREATE RULE books_insert_to_1 AS ON
INSERT TO books
WHERE (
    category_id >= 1
    AND category_id < 5
  ) DO INSTEAD
INSERT INTO books_1
VALUES (NEW.*);
/*==============*/
CREATE RULE books_insert_to_2 AS ON
INSERT TO books
WHERE (
    category_id >= 5
    AND category_id < 10
  ) DO INSTEAD
INSERT INTO books_2
VALUES (NEW.*);