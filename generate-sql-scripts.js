const fs = require("fs");
const path = require("path");

const insertFile = path.resolve(__dirname, "sql/insert.sql");
const selectFile = path.resolve(__dirname, "sql/select.sql");

const ROWS = 1_000_000;

const getRandomCategoryId = () => {
  const min = 0;
  const max = 10;

  return Math.round(Math.random() * (max - min) + min);
};

const generateInserts = () => {
  let template = "INSERT INTO books (id, category_id, title) VALUES \n";

  const insertRows = [];

  for (let i = 0; i < ROWS; i++) {
    insertRows.push(`(${i}, ${getRandomCategoryId()}, 'Title is: ${i}')`);
  }

  template += insertRows.join(",\n");

  return template;
};

const generateSelects = () => {
  const selectRows = [];

  for (let i = 0; i < ROWS; i += 100) {
    selectRows.push(`SELECT * FROM books WHERE id = ${i}`);
  }

  return selectRows.join(";\n");
};

const bootstrap = () => {
  const inserts = generateInserts();
  const selects = generateSelects();

  fs.writeFileSync(insertFile, inserts);
  fs.writeFileSync(selectFile, selects);
};

bootstrap();
