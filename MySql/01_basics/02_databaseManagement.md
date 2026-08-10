# MySQL — Database Management Basics

## 1. Starting MySQL

MySQL start karne ke baad humein ye prompt nazar aata hai:

```text
mysql>
```

Iska matlab hai ke MySQL server ke saath connection establish ho gaya hai aur ab hum SQL commands run kar sakte hain.

Most SQL statements ke end mein `;` lagaya jata hai.

Example:

```sql
SHOW DATABASES;
```

---

## 2. SHOW DATABASES

MySQL server mein available databases dekhne ke liye `SHOW DATABASES` command use hoti hai.

### Syntax

```sql
SHOW DATABASES;
```

### Example

```sql
SHOW DATABASES;
```

### Purpose

Ye MySQL server par available **sabhi databases ki list** show karti hai.

Example output:

```text
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| store_db           |
| sys                |
+--------------------+
```

### Easy definition

> `SHOW DATABASES` MySQL server mein available databases ki list show karta hai.

---

## 3. CREATE DATABASE

New database create karne ke liye `CREATE DATABASE` command use hoti hai.

### Syntax

```sql
CREATE DATABASE database_name;
```

### Example

```sql
CREATE DATABASE school_db;
```

Is command se `school_db` naam ka new database create ho jayega.

### Check karna

```sql
SHOW DATABASES;
```

Ab list mein:

```text
school_db
```

bhi nazar aayega.

### Easy definition

> `CREATE DATABASE` ek naya database create karne ke liye use hota hai.

---

## 4. USE

Database create karne ke baad humein us database ko select karna hota hai jismein hum kaam karna chahte hain.

Iske liye `USE` command use hoti hai.

### Syntax

```sql
USE database_name;
```

### Example

```sql
USE school_db;
```

Output:

```text
Database changed
```

Iska matlab hai ke ab `school_db` current/selected database hai.

### Easy definition

> `USE` command batati hai ke hum kis database ke andar kaam karna chahte hain.

---

## 5. Current Database Check Karna

Ye check karne ke liye ke currently kaunsa database selected hai:

```sql
SELECT DATABASE();
```

### Example

```sql
USE school_db;

SELECT DATABASE();
```

Output:

```text
+------------+
| database() |
+------------+
| school_db  |
+------------+
```

Iska matlab hai:

> Currently `school_db` selected hai.

### Important

`system database();` correct SQL command nahi hai.

Correct command:

```sql
SELECT DATABASE();
```

---

## 6. DROP DATABASE

Agar kisi database ko completely delete karna ho to `DROP DATABASE` command use hoti hai.

### Syntax

```sql
DROP DATABASE database_name;
```

### Example

```sql
DROP DATABASE school_db;
```

Isse `school_db` database completely delete ho jayega.

Agar dobara check karein:

```sql
SHOW DATABASES;
```

to `school_db` list mein nahi hoga.

### ⚠️ Important

`DROP DATABASE` dangerous command ho sakti hai because ye database ke andar ka **poora data aur tables** delete kar deti hai.

Isliye real projects mein is command ko carefully use karna chahiye.

---

# 7. SHOW DATABASE vs SHOW DATABASES

Ek common mistake:

```sql
SHOW DATABASE;
```

Ye incorrect hai.

Correct command:

```sql
SHOW DATABASES;
```

### Remember

```text
❌ SHOW DATABASE;

✅ SHOW DATABASES;
```

---

# 8. Semicolon `;`

MySQL mein normally SQL statement ke end par semicolon `;` lagaya jata hai.

Example:

```sql
SHOW DATABASES;
```

Agar semicolon ke baghair Enter press kar dein:

```text
mysql> SHOW DATABASES
    ->
```

to MySQL continuation prompt de sakta hai.

Phir:

```sql
;
```

likhne se statement complete ho jati hai.

Example:

```text
mysql> SHOW DATABASES
    -> ;
```

---

# 9. MySQL ke System Databases

MySQL install hone ke baad kuch databases automatically available hote hain.

Common examples:

```text
information_schema
mysql
performance_schema
sys
```

Ye MySQL ke **system databases** hain aur MySQL server ki internal information, metadata, performance aur administration-related functionality mein use hote hain.

In databases ko abhi manually modify ya delete nahi karna chahiye.

---

# 10. Complete Practical Flow

Aaj humne practically ye complete flow perform kiya:

```text
Start MySQL
     ↓
SHOW DATABASES
     ↓
CREATE DATABASE school_db
     ↓
SHOW DATABASES
     ↓
USE school_db
     ↓
SELECT DATABASE()
     ↓
DROP DATABASE school_db
     ↓
SHOW DATABASES
```

### Complete Example

```sql
-- Available databases dekhna
SHOW DATABASES;

-- New database create karna
CREATE DATABASE school_db;

-- Database select karna
USE school_db;

-- Current database check karna
SELECT DATABASE();

-- Database delete karna
DROP DATABASE school_db;

-- Again databases check karna
SHOW DATABASES;
```

---

# 11. Quick Revision

| Command              | Purpose                              |
| -------------------- | ------------------------------------ |
| `SHOW DATABASES;`    | Available databases show karta hai   |
| `CREATE DATABASE`    | New database create karta hai        |
| `USE`                | Database select karta hai            |
| `SELECT DATABASE();` | Current database check karta hai     |
| `DROP DATABASE`      | Database completely delete karta hai |

---

# 12. Interview Questions

### Q1. How do you see all databases in MySQL?

```sql
SHOW DATABASES;
```

### Q2. How do you create a database?

```sql
CREATE DATABASE school_db;
```

### Q3. How do you select a database?

```sql
USE school_db;
```

### Q4. How do you check the current database?

```sql
SELECT DATABASE();
```

### Q5. How do you delete a database?

```sql
DROP DATABASE school_db;
```

### Q6. What happens when you use `DROP DATABASE`?

> It permanently removes the database and its objects/data.

### Q7. Why do we use `USE`?

> `USE` selects the database on which we want to perform our operations.

### Q8. Why do we use semicolon `;`?

> It marks the end of an SQL statement.

---

# 🧠 Remember This

```text
SHOW DATABASES
      ↓
See databases

CREATE DATABASE
      ↓
Create database

USE
      ↓
Select database

SELECT DATABASE()
      ↓
Check selected database

DROP DATABASE
      ↓
Delete database
```

**These are the basic commands for managing databases in MySQL.**
![alt text](image.png)