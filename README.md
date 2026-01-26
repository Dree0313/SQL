# SQL

*SQL (Structured Query Language) is a language used to communicate with databases

*SQL is a language that speaks only to Relational Databases



## Examples

**SELECT name FROM lego_people**
  
    name        = column
  
    lego_people = table

**SELECT name FROM lego_height WHERE cm > 3;**
  
    name        = column
  
    lego_height = table
  
    cm > 3      = condition

**SELECT name, age FROM people LEFT JOIN lego_height USING (name);**
  
    name        = column
 
    age         = column
  
    people      = table
  
    lego_height = table
  
    (name)      = join criteria

**INSERT INTO lego_people(name, age) VALUES ('Joe', 12);**
  
    lego_people = table
  
    name        = column
  
    age         = column
  
    ('Joe', 12) = inputs / column

**UPDATE lego_people SET age = 13 WHERE name = 'Joe';**
  
    lego_people  = table
  
    age = 13     = column input
  
    name = 'Joe' = column criteria

**DELETE FROM lego_people WHERE name = 'Joe';**
  
    lego_people  = table
  
    name = 'Joe' = column criteria

