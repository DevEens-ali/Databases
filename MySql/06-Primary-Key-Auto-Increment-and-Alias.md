# 🐬 MySQL Notes --- Primary Key, AUTO_INCREMENT & Alias

> 📚 **Learning Path:** Constraints → Identity → Automatic IDs →
> Readable Queries\
> 🎯 **Goal:** Understand what each concept does, why we use it, and how
> they work together.

------------------------------------------------------------------------

## 🧭 Quick Overview

  -----------------------------------------------------------------------
  Concept                 Main Purpose            Easy Question
  ----------------------- ----------------------- -----------------------
  🔑 **PRIMARY KEY**      Uniquely identifies     **Which row is this?**
                          each row                

  🔢 **AUTO_INCREMENT**   Automatically generates **What ID should the
                          numeric IDs             new row get?**

  🏷️ **ALIAS**            Gives a temporary name  **How should I
                          to a column/table       display/reference
                                                  this?**
  -----------------------------------------------------------------------

------------------------------------------------------------------------

# 🔑 1. PRIMARY KEY

A **Primary Key** is a constraint used to **uniquely identify each
row/record in a table**.

### 🧠 Simple Definition

> **A Primary Key uniquely identifies each row in a table.**

### Example

``` text
id    name      city
1001  Alex      Lahore
1002  Ahmed     Karachi
1003  John      Islamabad
```

Here, `id` can be the Primary Key:

``` text
1001 → Alex
1002 → Ahmed
1003 → John
```

Each value identifies one specific row.

------------------------------------------------------------------------

## ⭐ Properties of a Primary Key

### 1️⃣ Unique

Two rows cannot have the same Primary Key value.

``` text
1001 → Alex
1001 → Ahmed   ❌
```

Duplicate Primary Key values are not allowed.

### 2️⃣ NOT NULL

A Primary Key cannot contain `NULL`.

``` text
id
----
1001
1002
NULL   ❌
```

Every row needs a valid identifier.

------------------------------------------------------------------------

## 🛠️ Creating a Primary Key

``` sql
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(100)
);
```

Here:

``` text
id → PRIMARY KEY
```

So `id` must be:

``` text
UNIQUE + NOT NULL
```

------------------------------------------------------------------------

# 🔒 PRIMARY KEY vs UNIQUE

Both enforce uniqueness, but their **purpose is different**.

### 🔑 PRIMARY KEY

> Used to uniquely identify each row/record.

### 🔒 UNIQUE

> Used to prevent duplicate values in a column.

Example:

``` sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    name VARCHAR(100)
);
```

``` text
id
↓
PRIMARY KEY
↓
Identifies the row


email
↓
UNIQUE
↓
Prevents duplicate emails
```

### 🧠 Memory Trick

> **PRIMARY KEY → "Which row is this?"**\
> **UNIQUE → "Is this value already used?"**

------------------------------------------------------------------------

# 🔢 2. AUTO_INCREMENT

`AUTO_INCREMENT` tells MySQL to **automatically generate the next
numeric value** when a new row is inserted.

### 🧠 Simple Definition

> **AUTO_INCREMENT automatically generates sequential numeric values for
> a column when new records are inserted.**

------------------------------------------------------------------------

## 😓 Without AUTO_INCREMENT

``` sql
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);
```

We have to provide the ID ourselves:

``` sql
INSERT INTO customers(id, name)
VALUES (1, 'Ali');

INSERT INTO customers(id, name)
VALUES (2, 'Ahmed');
```

``` text
id → manually entered
```

------------------------------------------------------------------------

## 🚀 With AUTO_INCREMENT

``` sql
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);
```

Now we can insert only the name:

``` sql
INSERT INTO customers(name)
VALUES ('Ali');
```

MySQL generates:

``` text
id = 1
```

Next record:

``` text
id = 2
```

Then:

``` text
id = 3
```

### 🔥 The Flow

``` text
New Row
   ↓
MySQL
   ↓
AUTO_INCREMENT
   ↓
1 → 2 → 3 → 4 → ...
```

------------------------------------------------------------------------

# 🤝 PRIMARY KEY + AUTO_INCREMENT

These two features have **different jobs**.

``` text
┌──────────────────────┐
│    PRIMARY KEY 🔑    │
│                      │
│ Identifies the row   │
│ Uniquely             │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ AUTO_INCREMENT 🔢    │
│                      │
│ Generates the ID     │
│ Automatically        │
└──────────────────────┘
```

### Common Pattern

``` sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE
);
```

Think of it like this:

> 🔑 **PRIMARY KEY:** "This is this user's unique identity."\
> 🔢 **AUTO_INCREMENT:** "I'll generate that identity number for you."

------------------------------------------------------------------------

# 🏷️ 3. ALIAS

An **Alias** gives a column or table a **temporary alternative name
inside a SQL query**.

### 🧠 Simple Definition

> **An alias is a temporary alternative name given to a column or table
> in a SQL query.**

------------------------------------------------------------------------

## 🏷️ Column Alias

Suppose the actual column is:

``` text
name
```

We can display it as:

``` sql
SELECT name AS 'Customer Name'
FROM customers;
```

Result:

``` text
Customer Name
-------------
Ali
Ahmed
John
```

⚠️ **Important:** The database column is still called `name`.

Alias does **not** permanently rename the column.

``` text
Database:
name

        ↓ ALIAS

Query Result:
Customer Name
```

------------------------------------------------------------------------

## ✂️ `AS` Keyword

Usually we write:

``` sql
SELECT name AS customer_name
FROM customers;
```

In MySQL, this can also work:

``` sql
SELECT name customer_name
FROM customers;
```

For beginners, using `AS` is clearer and more readable.

------------------------------------------------------------------------

# 🏷️ Table Alias

A table can also receive a temporary short name.

``` sql
SELECT c.name
FROM customers AS c;
```

Here:

``` text
customers → c
```

So instead of:

``` text
customers.name
```

we can write:

``` text
c.name
```

Table aliases become especially useful when working with **multiple
tables and JOINs**.

------------------------------------------------------------------------

# 🧩 Complete Example

``` sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE
);
```

Insert some users:

``` sql
INSERT INTO users(name, email)
VALUES ('Ali', 'ali@gmail.com');

INSERT INTO users(name, email)
VALUES ('Ahmed', 'ahmed@gmail.com');
```

MySQL automatically generates:

``` text
id    name    email
1     Ali     ali@gmail.com
2     Ahmed   ahmed@gmail.com
```

Now use an alias:

``` sql
SELECT name AS 'Customer Name', email AS 'Email Address'
FROM users;
```

The result can show:

``` text
Customer Name    Email Address
--------------   ----------------
Ali              ali@gmail.com
Ahmed            ahmed@gmail.com
```

But the actual database columns remain:

``` text
name
email
```

------------------------------------------------------------------------

# 🧠 PRIMARY KEY vs AUTO_INCREMENT vs ALIAS

  -----------------------------------------------------------------------
  Concept                 What does it do?        Changes stored data?
  ----------------------- ----------------------- -----------------------
  🔑 PRIMARY KEY          Uniquely identifies a   No
                          row                     

  🔢 AUTO_INCREMENT       Automatically generates Generates the ID value
                          numeric IDs             

  🏷️ ALIAS                Gives a temporary query No
                          name                    
  -----------------------------------------------------------------------

------------------------------------------------------------------------

# 🎯 Real-World Mental Model

Imagine a university student table:

``` text
Student ID    Name        Email
     1        Ali         ali@gmail.com
     2        Ahmed       ahmed@gmail.com
     3        Sara        sara@gmail.com
```

### 🔑 PRIMARY KEY

Student ID uniquely identifies each student.

### 🔢 AUTO_INCREMENT

MySQL automatically gives:

``` text
1 → 2 → 3 → 4 → ...
```

### 🏷️ ALIAS

Instead of displaying:

``` text
Name
```

we can display:

``` text
Student Name
```

without changing the actual database column.

------------------------------------------------------------------------

# 🎤 Interview Questions

### Q1. What is a Primary Key?

> A Primary Key is a constraint that uniquely identifies each row in a
> table.

### Q2. Can a Primary Key contain duplicate values?

> No. Primary Key values must be unique.

### Q3. Can a Primary Key contain NULL?

> No. A Primary Key cannot contain NULL values.

### Q4. What is AUTO_INCREMENT?

> AUTO_INCREMENT automatically generates sequential numeric values for a
> column when new rows are inserted.

### Q5. Why is AUTO_INCREMENT commonly used with a Primary Key?

> A Primary Key needs unique values, and AUTO_INCREMENT can
> automatically generate new numeric IDs for each record.

### Q6. Does AUTO_INCREMENT itself make a column a Primary Key?

> No. They are different concepts. PRIMARY KEY defines the unique
> identifier, while AUTO_INCREMENT generates numeric values
> automatically.

### Q7. What is an Alias?

> An alias is a temporary alternative name given to a column or table in
> a SQL query.

### Q8. Does an alias permanently rename a column?

> No. An alias only affects that particular query's result or
> references.

### Q9. What is the difference between PRIMARY KEY and UNIQUE?

> PRIMARY KEY is used to uniquely identify each row, while UNIQUE is
> used to prevent duplicate values.

------------------------------------------------------------------------

# ⚡ Quick Revision

``` text
🔑 PRIMARY KEY
        ↓
Uniquely identifies each row
        ↓
Unique + NOT NULL


🔢 AUTO_INCREMENT
        ↓
Automatically generates numeric IDs
        ↓
Commonly used with Primary Key


🏷️ ALIAS
        ↓
Temporary alternative name
        ↓
Used for columns or tables
```

------------------------------------------------------------------------

# 🧠 One-Line Memory Trick

> **PRIMARY KEY identifies → AUTO_INCREMENT generates → ALIAS renames
> temporarily.**

------------------------------------------------------------------------

## 📝 Practice Checklist

Before moving to the next topic, make sure you can explain:

-   [ ] What is a Primary Key?
-   [ ] Why must a Primary Key be unique?
-   [ ] Can a Primary Key be NULL?
-   [ ] Difference between PRIMARY KEY and UNIQUE
-   [ ] What does AUTO_INCREMENT do?
-   [ ] Why is AUTO_INCREMENT commonly used with IDs?
-   [ ] What is a column alias?
-   [ ] What is a table alias?
-   [ ] Does an alias permanently rename a column?
-   [ ] Difference between PRIMARY KEY, AUTO_INCREMENT and ALIAS

------------------------------------------------------------------------

### 🚀 Learning Flow

``` text
Constraints
    ↓
🔑 PRIMARY KEY
    ↓
🔢 AUTO_INCREMENT
    ↓
🏷️ ALIAS
    ↓
Next SQL Concept →
```

> **Keep practicing. The goal is not to memorize SQL --- understand what
> each part is doing. 🐬🔥**
