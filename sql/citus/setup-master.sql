CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  category_id INT,
  title VARCHAR(50) NOT NULL
) partition by range (id);
/*==============*/
CREATE TABLE books_0_500000 PARTITION OF books FOR
VALUES
FROM (0) TO (500001);
/*==============*/
CREATE TABLE books_500001_1000000 PARTITION OF books FOR
VALUES
FROM (500001) TO (1000000);