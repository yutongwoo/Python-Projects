CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT d.name, s.size
  FROM dogs AS d, sizes AS s
  WHERE d.height <= s.max AND
        d.height > s.min;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
SELECT d1.name
FROM dogs as d1, parents as p, dogs as d2
WHERE d1.name = p.child AND d2.name = p.parent
ORDER BY d2.height DESC;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT p1.child AS first, p2.child AS second, sod1.size AS size
  FROM parents as p1, parents as p2, size_of_dogs as sod1, size_of_dogs as sod2
  WHERE p1.parent = p2.parent AND
        p1.child = sod1.name AND
        p2.child = sod2.name AND
        sod1.size = sod2.size AND
        p1.child < p2.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT first||" and "||second||" are "||size||" siblings"
  FROM siblings;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height);
INSERT INTO stacks_helper SELECT name, height, height FROM dogs;
INSERT INTO stacks_helper SELECT s.dogs||", "||d.name, s.stack_height+d.height, d.height FROM dogs as d, stacks_helper as s WHERE d.height > s.last_height;
INSERT INTO stacks_helper SELECT s.dogs||", "||d.name, s.stack_height+d.height, d.height FROM dogs as d, stacks_helper as s WHERE d.height > s.last_height;
INSERT INTO stacks_helper SELECT s.dogs||", "||d.name, s.stack_height+d.height, d.height FROM dogs as d, stacks_helper as s WHERE d.height > s.last_height;


CREATE TABLE stacks AS
  SELECT helper.dogs, helper.stack_height
  FROM stacks_helper as helper
  WHERE helper.stack_height > 170
  ORDER BY helper.stack_height;
