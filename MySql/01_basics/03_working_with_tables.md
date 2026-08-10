# MySQL — Working with Tables

## 1. Checking the Current Database

Current selected database check karne ke liye:

```sql
SELECT DATABASE();
```

### Example

```sql
SELECT DATABASE();
```

Agar koi database selected nahi hai:

```text
NULL
```

Agar `store_db` selected hai:

```text
store_db
```

### Meaning

> `SELECT DATABASE()` batata hai ke currently MySQL mein kaunsa database selected hai.

---

# 2. Selecting a Database

Kisi database ko select karne ke liye `USE` command use hoti hai.

### Syntax

```sql
USE database_name;
```

### Example

```sql
USE store_db;
```

Output:

```text
Database changed
```

Ab `store_db` current database ban gaya.

Check karne ke liye:

```sql
SELECT DATABASE();
```

---

# 3. SHOW TABLES

Selected database ke andar available tables dekhne ke liye:

```sql
SHOW TABLES;
```

### Example

```sql
USE store_db;

SHOW TABLES;
```

Ye `store_db` ke andar maujood tables ki list show karega.

Example:

```text
+--------------------+
| Tables_in_store_db |
+--------------------+
| customers          |
| orders             |
| products           |
+--------------------+
```

### Important

`SHOW DATABASES` aur `SHOW TABLES` different commands hain.

```text
SHOW DATABASES;
        ↓
Databases show karta hai

SHOW TABLES;
        ↓
Selected database ki tables show karta hai
```

---

# 4. DESC / DESCRIBE

Table ka structure dekhne ke liye `DESC` ya `DESCRIBE` command use hoti hai.

### Syntax

```sql
DESC table_name;
```

or:

```sql
DESCRIBE table_name;
```

### Example

```sql
DESC customers;
```

Output:

```text
+-------+--------------+------+-----+---------+-------+
| Field | Type         | Null | Key | Default | Extra |
+-------+--------------+------+-----+---------+-------+
| id    | int          | YES  |     | NULL    |       |
| name  | varchar(50)  | YES  |     | NULL    |       |
| city  | varchar(100) | YES  |     | NULL    |       |
+-------+--------------+------+-----+---------+-------+
```

### Meaning

`DESC` table ke columns aur unki properties show karta hai.

---

# 5. DESC Output ko Samajhna

`DESC customers;` ke output mein important columns hain:

```text
Field
Type
Null
Key
Default
Extra
```

## Field

`Field` column ka naam batata hai.

Example:

```text
id
name
city
```

---

## Type

`Type` batata hai ke column mein kis type ka data store hoga.

Example:

```text
id    → int
name  → varchar(50)
city  → varchar(100)
```

### `int`

Integer/numbers ke liye use hota hai.

Example:

```text
1
25
100
500
```

### `varchar`

Variable-length text store karne ke liye use hota hai.

Example:

```text
Ali
Ahmed
Lahore
Islamabad
```

`varchar(50)` ka matlab hai ke column maximum 50 characters tak store kar sakta hai.

---

# 6. Null

`Null` batata hai ke column mein `NULL` value allowed hai ya nahi.

Agar:

```text
YES
```

hai, to `NULL` allowed hai.

Example:

```text
id    → YES
name  → YES
city  → YES
```

Iska matlab hai ke abhi teeno columns mein `NULL` values allowed hain.

### Important

`NULL` ka matlab **zero** ya **empty string** nahi hota.

`NULL` ka basic meaning hai:

> Value unknown ya missing hai.

---

# 7. Key

`Key` column batata hai ke column par koi key/index-related property defined hai ya nahi.

Tumhare output mein:

```text
| id | int | YES |     | NULL | |
```

`Key` blank hai.

Iska matlab hai ke `id` par abhi Primary Key define nahi ki gayi.

Normally hum `id` ko uniquely identify karne ke liye Primary Key bana sakte hain.

Example:

```sql
id INT PRIMARY KEY
```

Primary Key ka concept baad mein detail mein cover hoga.

---

# 8. Default

`Default` batata hai ke agar insert karte waqt column ki value provide na ki jaye to default value kya hogi.

Tumhare table mein:

```text
Default → NULL
```

hai.

Matlab abhi koi specific default value set nahi ki gayi.

---

# 9. Extra

`Extra` column additional properties show karta hai.

Example:

```text
AUTO_INCREMENT
```

Agar `id` ke saath `AUTO_INCREMENT` laga ho to MySQL automatically next ID generate kar sakta hai.

Example:

```sql
id INT PRIMARY KEY AUTO_INCREMENT
```

---

# 10. DROP TABLE

Table ko completely delete karne ke liye:

```sql
DROP TABLE table_name;
```

### Example

```sql
DROP TABLE customers;
```

Is command se `customers` table completely delete ho jayegi.

### ⚠️ Important

`DROP TABLE` sirf table ka structure nahi delete karta, balki table ke andar stored **data bhi delete ho jata hai**.

Isliye carefully use karna chahiye.

---

# 11. Database vs Table

Ye distinction bohot important hai.

```text
Database
   ↓
store_db
   │
   ├── customers
   ├── products
   └── orders
```

Yahan:

```text
store_db   → Database
customers  → Table
products   → Table
orders     → Table
```

Isliye:

```sql
DESC store_db;
```

❌ Incorrect, agar `store_db` database hai aur table nahi.

Lekin:

```sql
DESC customers;
```

✅ Correct, because `customers` ek table hai.

---

# 12. Common Mistake

Agar tum likho:

```sql
DESC store_db;
```

MySQL ye samjhega:

> `store_db` naam ki table ka structure show karo.

Agar `store_db` naam ki table exist nahi karti to error milega:

```text
ERROR 1146
Table 'store_db.store_db' doesn't exist
```

### Correct flow

```sql
USE store_db;

SHOW TABLES;

DESC customers;
```

---

# 13. DESC vs SHOW TABLES

Dono ka purpose different hai.

### SHOW TABLES

Database ke andar available tables ki list show karta hai.

```sql
SHOW TABLES;
```

### DESC

Specific table ka structure show karta hai.

```sql
DESC customers;
```

### Easy memory trick

```text
SHOW TABLES
     ↓
Kaunsi tables hain?

DESC customers
     ↓
Customers table ke andar kya structure hai?
```

---

# 14. Complete Practical Flow

Agar `store_db` ke andar `customers` table exist karti hai:

```sql
-- Database select karo
USE store_db;

-- Current database check karo
SELECT DATABASE();

-- Tables dekho
SHOW TABLES;

-- Customers table ka structure dekho
DESC customers;
```

Agar table delete karni ho:

```sql
DROP TABLE customers;
```

---

# 15. Commands Quick Revision

| Command                 | Purpose                                    |
| ----------------------- | ------------------------------------------ |
| `SELECT DATABASE();`    | Current database check karta hai           |
| `USE store_db;`         | Database select karta hai                  |
| `SHOW TABLES;`          | Selected database ki tables show karta hai |
| `DESC customers;`       | Table ka structure show karta hai          |
| `DESCRIBE customers;`   | `DESC` ka alternative                      |
| `DROP TABLE customers;` | Table aur uska data delete karta hai       |

---

# 16. Interview Questions

### Q1. How do you select a database in MySQL?

```sql
USE database_name;
```

---

### Q2. How do you check the current database?

```sql
SELECT DATABASE();
```

---

### Q3. How do you see all tables in the current database?

```sql
SHOW TABLES;
```

---

### Q4. How do you see the structure of a table?

```sql
DESC table_name;
```

or:

```sql
DESCRIBE table_name;
```

---

### Q5. What does DESC do?

> `DESC` shows the structure and properties of a table, such as its columns, data types, NULL status, keys, defaults and extra properties.

---

### Q6. What is the difference between SHOW TABLES and DESC?

> `SHOW TABLES` displays the list of tables in the selected database, while `DESC` displays the structure of a specific table.

---

### Q7. Can we use DESC on a database?

> No. `DESC` is used to describe a table, not a database.

---

### Q8. What happens when we use DROP TABLE?

> It permanently removes the table and its stored data.

---

# 🧠 Final Concept

```text
MySQL Server
     │
     └── store_db          ← Database
           │
           ├── customers   ← Table
           │     ├── id
           │     ├── name
           │     └── city
           │
           ├── products    ← Table
           │
           └── orders      ← Table
```

Commands ka flow:

```text
USE store_db
      ↓
SHOW TABLES
      ↓
DESC customers
      ↓
Understand table structure
```

### Golden Rule

> **Database ko select karne ke liye `USE`, tables dekhne ke liye `SHOW TABLES`, aur table ka structure dekhne ke liye `DESC` use hota hai.**
