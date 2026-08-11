# MySQL — NOT NULL & DEFAULT Constraints

## 1. What is a Constraint?

A **constraint** is a rule applied to a column to control what kind of data can be stored in it.

Constraints help us maintain **data integrity** and prevent invalid or unwanted data.

Examples of MySQL constraints:

```text
NOT NULL
DEFAULT
PRIMARY KEY
UNIQUE
CHECK
FOREIGN KEY
```

In this topic, we will focus on:

```text
NOT NULL
DEFAULT
```

---

# 2. NOT NULL

`NOT NULL` is a constraint that ensures a column **cannot contain NULL values**.

### Simple Definition

> `NOT NULL` means a value is required for that column.

### Example

```sql
CREATE TABLE students (
    id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(100)
);
```

Here:

```text
id   → Required
name → Required
city → Optional
```

Because `id` and `name` have `NOT NULL`.

---

# 3. Why Use NOT NULL?

We use `NOT NULL` when a particular piece of information is important and should not be missing.

For example, in a student table:

```sql
name VARCHAR(100) NOT NULL
```

A student's name should be provided.

Without `NOT NULL`, the column could contain:

```text
NULL
```

With `NOT NULL`, MySQL will not allow a `NULL` value.

---

# 4. NULL vs Empty String

These two things are different.

### NULL

Means:

> The value is missing, unknown, or not provided.

### Empty String

```text
""
```

Means:

> A string exists, but it contains zero characters.

For example:

```text
name = NULL
```

is different from:

```text
name = ""
```

---

# 5. Checking NULL Permission

When we use:

```sql
DESC students;
```

MySQL shows a `Null` column.

Example:

```text
+-------+--------------+------+-----+
| Field | Type         | Null | Key |
+-------+--------------+------+-----+
| id    | int          | NO   |     |
| name  | varchar(50)  | NO   |     |
| city  | varchar(100) | YES  |     |
+-------+--------------+------+-----+
```

Here:

```text
NO  → NULL is NOT allowed
YES → NULL is allowed
```

So `NOT NULL` usually appears as:

```text
Null = NO
```

in `DESC`.

---

# 6. DEFAULT

`DEFAULT` is a constraint that provides an **automatic value** when a value for that column is not provided during insertion.

### Simple Definition

> `DEFAULT` specifies the value that MySQL should use when no value is provided for a column.

---

# 7. Example of DEFAULT

```sql
CREATE TABLE customers (
    id INT,
    name VARCHAR(50) DEFAULT 'Unknown',
    city VARCHAR(100) DEFAULT 'Unknown'
);
```

Now suppose we insert only the `id`:

```sql
INSERT INTO customers(id)
VALUES (1001);
```

We did not provide:

```text
name
city
```

So MySQL automatically uses the default values.

Result:

```text
+------+---------+---------+
| id   | name    | city    |
+------+---------+---------+
| 1001 | Unknown | Unknown |
+------+---------+---------+
```

---

# 8. Real-World Example

Suppose we have:

```sql
CREATE TABLE users (
    id INT,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(100) DEFAULT 'Pakistan'
);
```

Now insert:

```sql
INSERT INTO users(id, name)
VALUES (1, 'Ali');
```

We did not provide `city`.

Because `city` has:

```sql
DEFAULT 'Pakistan'
```

MySQL automatically stores:

```text
+----+------+----------+
| id | name | city     |
+----+------+----------+
| 1  | Ali  | Pakistan |
+----+------+----------+
```

---

# 9. NOT NULL and DEFAULT Together

`NOT NULL` and `DEFAULT` can be used together.

Example:

```sql
CREATE TABLE customers (
    id INT,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(100) NOT NULL DEFAULT 'Pakistan'
);
```

Here:

```text
name
 ↓
Must be provided

city
 ↓
Cannot be NULL
 ↓
If omitted during INSERT
 ↓
'Pakistan' will be used
```

---

# 10. Important Difference

### NOT NULL

Controls whether `NULL` is allowed.

```sql
name VARCHAR(50) NOT NULL
```

Meaning:

> A NULL value is not allowed.

### DEFAULT

Provides an automatic value if the column is omitted from an `INSERT`.

```sql
city VARCHAR(100) DEFAULT 'Pakistan'
```

Meaning:

> If no city is provided, use `Pakistan`.

---

# 11. NOT NULL vs DEFAULT

| Feature                         | NOT NULL                    | DEFAULT                                |
| ------------------------------- | --------------------------- | -------------------------------------- |
| Purpose                         | Prevents NULL values        | Provides automatic value               |
| Makes value required?           | Yes                         | Not necessarily                        |
| Provides a value automatically? | No                          | Yes                                    |
| Example                         | `name VARCHAR(50) NOT NULL` | `city VARCHAR(100) DEFAULT 'Pakistan'` |

---

# 12. Important Scenario

Consider:

```sql
CREATE TABLE users (
    name VARCHAR(50) NOT NULL,
    city VARCHAR(100) DEFAULT 'Pakistan'
);
```

### Case 1 — Name and city provided

```sql
INSERT INTO users(name, city)
VALUES ('Ali', 'Lahore');
```

Result:

```text
Ali | Lahore
```

---

### Case 2 — City not provided

```sql
INSERT INTO users(name)
VALUES ('Ali');
```

Result:

```text
Ali | Pakistan
```

The default value is used.

---

### Case 3 — Name not provided

```sql
INSERT INTO users(city)
VALUES ('Lahore');
```

This will fail because:

```text
name → NOT NULL
```

and no name was provided.

---

# 13. Important Concept About DEFAULT

`DEFAULT` is normally used when the column value is **omitted from the INSERT statement**.

For example:

```sql
INSERT INTO users(name)
VALUES ('Ali');
```

If `city` has:

```sql
DEFAULT 'Pakistan'
```

then MySQL uses:

```text
Pakistan
```

automatically.

---

# 14. Practical Example

```sql
CREATE TABLE employees (
    id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) DEFAULT 'Pakistan'
);
```

Insert:

```sql
INSERT INTO employees(id, name)
VALUES (101, 'Ahmed');
```

Check:

```sql
SELECT * FROM employees;
```

Result:

```text
+-----+--------+----------+
| id  | name   | city     |
+-----+--------+----------+
| 101 | Ahmed  | Pakistan |
+-----+--------+----------+
```

---

# 15. Common Mistake

Don't confuse:

```text
NOT NULL
```

with:

```text
DEFAULT
```

### NOT NULL

> "You cannot leave this value as NULL."

### DEFAULT

> "If you don't provide a value, I'll use this predefined value."

---

# 16. Easy Mental Model

```text
              COLUMN
                 │
        ┌────────┴────────┐
        ↓                 ↓
    NOT NULL           DEFAULT
        │                 │
        ↓                 ↓
  NULL allowed?      Value missing?
        │                 │
        ↓                 ↓
       NO            Use default value
```

---

# 17. Interview Questions

### Q1. What is NOT NULL?

> `NOT NULL` is a constraint that prevents a column from storing NULL values.

### Q2. Why do we use NOT NULL?

> We use `NOT NULL` to make important fields mandatory and maintain data integrity.

### Q3. What is DEFAULT?

> `DEFAULT` specifies an automatic value that MySQL uses when a column value is not provided during insertion.

### Q4. Can NOT NULL and DEFAULT be used together?

Yes.

Example:

```sql
city VARCHAR(100) NOT NULL DEFAULT 'Pakistan'
```

### Q5. What is the difference between NOT NULL and DEFAULT?

> `NOT NULL` prevents NULL values, while `DEFAULT` provides a predefined value when the column is omitted during insertion.

### Q6. Does DEFAULT make a column NOT NULL?

> No. `DEFAULT` and `NOT NULL` have different purposes. A default value does not by itself mean that NULL is prohibited.

---

# 🧠 Quick Revision

```text
NOT NULL
    ↓
NULL allowed nahi

DEFAULT
    ↓
Value provide nahi ki?
    ↓
Predefined value automatically use hogi
```

### Example

```sql
CREATE TABLE customers (
    id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(100) DEFAULT 'Pakistan'
);
```

Remember:

> **NOT NULL controls whether NULL is allowed, while DEFAULT controls what value is automatically used when a column is omitted during INSERT.**
