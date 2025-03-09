CREATE TABLE if not exists books (
  id SERIAL PRIMARY KEY,
  category_id int not null,
  CONSTRAINT category_id_check CHECK (
    category_id >= 5
    AND category_id <= 10
  ),
  title VARCHAR(50) NOT NULL
);