# MySQL — INSERT, SELECT, WHERE & DELETE

## 1. Selecting the Database

Sabse pehle jis database ke andar kaam karna hai usay select karte hain:

```sql
USE store_db;
```

Current selected database check karne ke liye:

```sql
SELECT DATABASE();
```

Output:

```text
store_db
```

### Important

Correct:

```sql
SELECT DATABASE();
```

Incorrect:

```sql
SELECT DATABASES();
```

`DATABASE()` current selected database ka naam return karta hai.

---

# 2. Checking Table Structure

Customers table ka structure dekhne ke liye:

```sql
DESC customers;
```

Example:

```text
+-------+--------------+------+-----+---------+-------+
| Field | Type         | Null | Key | Default | Extra |
+-------+--------------+------+-----+---------+-------+
| id    | int          | YES  |     | NULL    |       |
| name  | varchar(50)  | YES  |     | NULL    |       |
| city  | varchar(100) | YES  |     | NULL    |       |
+-------+--------------+------+-----+---------+-------+
```

Is table mein 3 columns hain:

```text
id
name
city
```

---

# 3. INSERT INTO

`INSERT INTO` command ka use table mein **new data/records add karne** ke liye hota hai.

### Basic Syntax

```sql
INSERT INTO table_name(column1, column2, column3)
VALUES(value1, value2, value3);
```

### Example

```sql
INSERT INTO customers(id, name, city)
VALUES(1002, "Alexa", "Mexico");
```

Isse `customers` table mein ek new row insert hogi.

---

# 4. Column Names Specify Karna

Insert karte waqt hum columns ke naam specify kar sakte hain:

```sql
INSERT INTO customers(id, name, city)
VALUES(1002, "Alexa", "Mexico");
```

Yahan:

```text
id   → 1002
name → Alexa
city → Mexico
```

Data corresponding columns mein insert hota hai.

---

# 5. Table Name Correct Hona Zaroori Hai

Tumhari practice mein ye mistake hui:

```sql
INSERT INTO customer(id, name, city)
VALUES(1002, "Alexa", "Mexico");
```

Error:

```text
ERROR 1146:
Table 'store_db.customer' doesn't exist
```

Kyun?

Tumhari actual table ka naam:

```text
customers
```

tha, na ke:

```text
customer
```

Correct:

```sql
INSERT INTO customers(id, name, city)
VALUES(1002, "Alexa", "Mexico");
```

### Lesson

> Table ka naam exactly correct hona chahiye.

---

# 6. Multiple Rows Insert Karna

Ek hi `INSERT` statement mein multiple rows bhi add kar sakte hain.

### Syntax

```sql
INSERT INTO table_name(column1, column2, column3)
VALUES
(value1, value2, value3),
(value4, value5, value6);
```

### Example

```sql
INSERT INTO customers(id, name, city)
VALUES
(1003, "John", "Washington DC"),
(1004, "Maria", "Columbia");
```

Output:

```text
Query OK, 2 rows affected
```

Matlab ek hi query se 2 records insert ho gaye.

---

# 7. String Values

Text values ko quotes ke andar likhte hain.

Example:

```sql
"Alexa"
"Mexico"
"John"
"Washington DC"
```

Example:

```sql
INSERT INTO customers(id, name, city)
VALUES(1005, "Ali", "Lahore");
```

Numbers ko normally quotes ki zaroorat nahi:

```sql
1005
```

---

# 8. SELECT

`SELECT` command ka use database se **data retrieve/read** karne ke liye hota hai.

### Basic Syntax

```sql
SELECT column_name
FROM table_name;
```

---

# 9. SELECT *

Agar table ke **all columns aur all rows** dekhne hon:

```sql
SELECT * FROM customers;
```

`*` ka matlab:

> All columns

Example:

```text
+------+-----------+---------------+
| id   | name      | city          |
+------+-----------+---------------+
| 1001 | Alex chen | Monacco       |
| 1002 | Alexa     | Mexico        |
| 1003 | John      | Washington DC |
| 1004 | Maria     | Columbia      |
+------+-----------+---------------+
```

### Easy definition

> `SELECT *` table ke saare columns retrieve karta hai.

---

# 10. Selecting a Specific Column

Agar sirf `name` chahiye:

```sql
SELECT name FROM customers;
```

Output:

```text
+-----------+
| name      |
+-----------+
| Alex chen |
| Alexa     |
| John      |
| Maria     |
+-----------+
```

Sirf `id`:

```sql
SELECT id FROM customers;
```

Sirf `city`:

```sql
SELECT city FROM customers;
```

---

# 11. Selecting Multiple Columns

Ek se zyada columns bhi select kar sakte hain.

Example:

```sql
SELECT name, city
FROM customers;
```

Output:

```text
+-----------+---------------+
| name      | city          |
+-----------+---------------+
| Alex chen | Monacco       |
| Alexa     | Mexico        |
| John      | Washington DC |
| Maria      | Columbia      |
+-----------+---------------+
```

Another example:

```sql
SELECT id, city
FROM customers;
```

---

# 12. Column Order

`SELECT` mein columns jis order mein likhe jate hain, result bhi usi order mein aata hai.

Example:

```sql
SELECT city, id, name
FROM customers;
```

Output columns:

```text
city
id
name
```

Agar:

```sql
SELECT name, city
FROM customers;
```

to:

```text
name
city
```

### Important

> `SELECT` mein columns ka order change karne se database mein actual table structure change nahi hota. Sirf query ka output order change hota hai.

---

# 13. WHERE Clause

`WHERE` ka use **specific records filter** karne ke liye hota hai.

### Syntax

```sql
SELECT *
FROM table_name
WHERE condition;
```

---

# 14. WHERE with ID

Example:

```sql
SELECT *
FROM customers
WHERE id = 1003;
```

Output:

```text
+------+------+---------------+
| id   | name | city          |
+------+------+---------------+
| 1003 | John | Washington DC |
+------+------+---------------+
```

Yahan MySQL sirf woh row return karega jahan:

```text
id = 1003
```

---

# 15. WHERE with Text

City ke basis par search:

```sql
SELECT *
FROM customers
WHERE city = "Washington DC";
```

Ye sirf Washington DC wale customer ko return karega.

### Simple meaning

> `WHERE` database ko batata hai ke humein kaunse records chahiye.

---

# 16. DELETE

`DELETE` command ka use table se **records/rows remove** karne ke liye hota hai.

### Syntax

```sql
DELETE FROM table_name
WHERE condition;
```

### Example

```sql
DELETE FROM customers
WHERE id = 1003;
```

Isse `id = 1003` wali row delete ho jayegi.

---

# 17. DELETE with Name

Example:

```sql
DELETE FROM customers
WHERE name = "Maria";
```

Isse Maria naam wali row delete ho jayegi.

---

# 18. ⚠️ DELETE mein WHERE bohot important hai

Ye command:

```sql
DELETE FROM customers
WHERE id = 1003;
```

sirf matching row delete karegi.

Lekin agar tum likho:

```sql
DELETE FROM customers;
```

to **table ki saari rows delete ho sakti hain.**

Table structure remain kar sakta hai, lekin records remove ho jayenge.

Isliye beginner ke taur par:

> `DELETE` use karte waqt `WHERE` condition ko hamesha carefully check karo.

---

# 19. DELETE vs DROP TABLE

Ye difference bohot important hai.

### DELETE

```sql
DELETE FROM customers
WHERE id = 1003;
```

Specific rows ko delete karta hai.

### DROP TABLE

```sql
DROP TABLE customers;
```

Poori table ko delete karta hai, including its structure and data.

### Easy comparison

```text
DELETE
  ↓
Rows delete

DROP TABLE
  ↓
Complete table delete
```

---

# 20. CRUD Concept

Aaj tumne CRUD ka major portion practically perform kiya.

**CRUD = Create, Read, Update, Delete**

| Operation | SQL      |
| --------- | -------- |
| Create    | `INSERT` |
| Read      | `SELECT` |
| Update    | `UPDATE` |
| Delete    | `DELETE` |

Abhi tumne:

```text
INSERT → Create
SELECT → Read
DELETE → Delete
```

seekh liya hai.

`UPDATE` abhi next important command hai.

---

# 21. Complete Practical Flow

Tumhara practical flow basically ye tha:

```text
USE store_db
       ↓
SELECT DATABASE()
       ↓
DESC customers
       ↓
INSERT INTO customers
       ↓
SELECT *
       ↓
SELECT specific columns
       ↓
WHERE se filter
       ↓
DELETE specific row
       ↓
SELECT * se result verify
```

---

# 22. Important Mistakes from Practice

### Mistake 1

```sql
SELECT DATABASES();
```

❌ Incorrect

Correct:

```sql
SELECT DATABASE();
```

---

### Mistake 2

```sql
INSERT INTO customer(...)
```

jab actual table:

```text
customers
```

thi.

Correct:

```sql
INSERT INTO customers(...);
```

---

### Mistake 3 — Incomplete String

Tumhari practice mein:

```sql
(1004,"Maria","Columbia)
```

mein closing quote missing tha.

Correct:

```sql
(1004, "Maria", "Columbia");
```

Agar quotation/string properly close na ho to MySQL continuation prompt de sakta hai.

---

# 23. Query Examples — Quick Revision

### Insert one row

```sql
INSERT INTO customers(id, name, city)
VALUES(1005, "Ali", "Lahore");
```

### Insert multiple rows

```sql
INSERT INTO customers(id, name, city)
VALUES
(1006, "Ahmed", "Islamabad"),
(1007, "Sara", "Karachi");
```

### Select everything

```sql
SELECT * FROM customers;
```

### Select one column

```sql
SELECT name FROM customers;
```

### Select multiple columns

```sql
SELECT name, city FROM customers;
```

### Filter by ID

```sql
SELECT * FROM customers
WHERE id = 1003;
```

### Filter by city

```sql
SELECT * FROM customers
WHERE city = "Washington DC";
```

### Delete by ID

```sql
DELETE FROM customers
WHERE id = 1003;
```

### Delete by name

```sql
DELETE FROM customers
WHERE name = "Maria";
```

---

# 24. Interview Questions

### Q1. What is INSERT used for?

> `INSERT` is used to add new records into a table.

### Q2. What is SELECT used for?

> `SELECT` is used to retrieve data from a database.

### Q3. What does `SELECT *` mean?

> It selects all columns from the specified table.

### Q4. What is WHERE used for?

> `WHERE` is used to filter records based on a specified condition.

### Q5. Can we select specific columns?

Yes.

```sql
SELECT name, city
FROM customers;
```

### Q6. Can we insert multiple rows in one query?

Yes.

```sql
INSERT INTO customers(id, name, city)
VALUES
(1003, "John", "Washington DC"),
(1004, "Maria", "Columbia");
```

### Q7. What does DELETE do?

> `DELETE` removes records/rows from a table.

### Q8. What is the difference between DELETE and DROP TABLE?

> `DELETE` removes rows from a table, while `DROP TABLE` removes the complete table, including its structure and data.

### Q9. Why is WHERE important with DELETE?

> Without `WHERE`, a `DELETE` statement can remove all rows from the table.

### Q10. What does CRUD stand for?

> **Create, Read, Update, Delete.**

In SQL:

```text
Create → INSERT
Read   → SELECT
Update → UPDATE
Delete → DELETE
```

---

# 🧠 Final Mental Model

```text
                 CUSTOMERS TABLE
                       │
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
       id             name           city
        │
        ↓
      INSERT
        ↓
    Add records
        │
        ↓
      SELECT
        ↓
    Read records
        │
        ↓
      WHERE
        ↓
   Filter records
        │
        ↓
      DELETE
        ↓
   Remove records
```

### Golden Rule

> **INSERT adds data, SELECT reads data, WHERE filters data, and DELETE removes data.**
