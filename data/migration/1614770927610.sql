CREATE DATABASE lab14;
/* create database */

psql -f data/schema.sql -d lab14.
/* connect schema.sql with database */

CREATE DATABASE lab14_normal WITH TEMPLATE lab14;
/* create a copy of lab14 database */

CREATE TABLE AUTHORS (id SERIAL PRIMARY KEY, name VARCHAR(255));
/*  create a second table in the lab14_normal database named authors */

INSERT INTO authors(name) SELECT DISTINCT author FROM books;
/* insert unique author values from the books table and insert each one into the authors table */ 

ALTER TABLE books ADD COLUMN author_id INT;
/*  add a column to the books table named author_id. This will connect each book to a specific author in the other table. */

UPDATE books SET author_id=author.id FROM (SELECT * FROM authors) AS author WHERE books.author = author.name;
/* to  connect between the two tables */

ALTER TABLE books DROP COLUMN author;
/*  removing the column named author */

ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);
/* This query will modify the data type of the author_id in the books table, setting it as a foreign key which references the primary key in the authors table */