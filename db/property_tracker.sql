DROP TABLE IF EXISTS property_tracker;

CREATE TABLE property_tracker(
  id SERIAL8 PRIMARY KEY,
  address VARCHAR,
  value INT,
  num_of_bedrooms INT,
  year_built INT
);
