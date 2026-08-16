<div align="center">

# 🐬 MySQL Notes — NOT NULL & DEFAULT Constraints
### `Constraint` → `NOT NULL` → `DEFAULT` → `Together`

*Learning Path: Data Integrity → Required Fields → Automatic Values*

![SQL](https://img.shields.io/badge/MySQL-00758F?style=for-the-badge&logo=mysql&logoColor=white)
![Level](https://img.shields.io/badge/Level-Beginner-4FD1C5?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-Constraints-F2B84B?style=for-the-badge)

</div>

---

## 🗺️ Flow of This Topic

```mermaid
flowchart LR
    A[Constraint] --> B[NOT NULL]
    A --> C[DEFAULT]
    B --> D[NOT NULL + DEFAULT together]
    C --> D
    D --> E[INSERT scenarios]
    style A fill:#F2B84B,color:#0B1220
    style B fill:#F0876B,color:#0B1220
    style C fill:#4FD1C5,color:#0B1220
    style D fill:#A78BFA,color:#0B1220
    style E fill:#A78BFA,color:#0B1220
```

## 🧭 Quick Overview

| Concept | Main Purpose | Easy Question |
|---|---|---|
| 🚫 **NOT NULL** | Prevents a column from storing NULL | **Is this value required?** |
| 🎁 **DEFAULT** | Provides an automatic value | **What if no value is given?** |

---

## 1️⃣ What is a Constraint?

A **constraint** is a rule applied to a column to control what kind of data can be stored in it. Constraints help maintain **data integrity** and prevent invalid or unwanted data.

```mermaid
flowchart TD
    C[MySQL Constraints] --> N[NOT NULL]
    C --> D[DEFAULT]
    C --> P[PRIMARY KEY]
    C --> U[UNIQUE]
    C --> CH[CHECK]
    C --> F[FOREIGN KEY]
    style N fill:#F0876B,color:#0B1220
    style D fill:#4FD1C5,color:#0B1220
```

> 🎯 In this topic, we focus on **`NOT NULL`** and **`DEFAULT`**.

---

## 2️⃣ NOT NULL

`NOT NULL` is a constraint that ensures a column **cannot contain NULL values**.

> 🧠 **Simple Definition:** `NOT NULL` means a value is required for that column.

```sql
CREATE TABLE students (
    id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(100)
);
```

| Column | Required? |
|---|---|
| `id` | ✅ Required |
| `name` | ✅ Required |
| `city` | ⚪ Optional |

---

## 3️⃣ Why Use NOT NULL?

We use `NOT NULL` when a particular piece of information is important and should not be missing.

```sql
name VARCHAR(100) NOT NULL
```

A student's name should always be provided. Without `NOT NULL`, the column could silently contain `NULL`. With `NOT NULL`, MySQL **rejects** any insert that leaves it out.

---

## 4️⃣ NULL vs Empty String

These two things are **different**, and it's a very common confusion point.

```mermaid
flowchart LR
    N["NULL"] --> N1["Value missing, unknown,<br/>or not provided"]
    E["Empty String"] --> E1["A string that exists<br/>but has zero characters"]
    style N fill:#F0876B,color:#0B1220
    style E fill:#4FD1C5,color:#0B1220
```

```text
name = NULL   →  no value at all
name = ''     →  a value exists, it's just empty
```

---

## 5️⃣ Checking NULL Permission

```sql
DESC students;
```

```text
+-------+--------------+------+-----+
| Field | Type         | Null | Key |
+-------+--------------+------+-----+
| id    | int          | NO   |     |
| name  | varchar(50)  | NO   |     |
| city  | varchar(100) | YES  |     |
+-------+--------------+------+-----+
```

| `Null` value | Meaning |
|---|---|
| `NO` | NULL is **not** allowed → `NOT NULL` applied |
| `YES` | NULL is allowed |

---

## 6️⃣ DEFAULT

`DEFAULT` is a constraint that provides an **automatic value** when a value for that column is not provided during insertion.

> 🧠 **Simple Definition:** `DEFAULT` specifies the value MySQL should use when no value is provided for a column.

---

## 7️⃣ Example of DEFAULT

```sql
CREATE TABLE customers (
    id INT,
    name VARCHAR(50) DEFAULT 'Unknown',
    city VARCHAR(100) DEFAULT 'Unknown'
);

INSERT INTO customers(id)
VALUES (1001);
```

```mermaid
flowchart LR
    I["INSERT INTO customers(id) VALUES (1001)"] --> M{name / city provided?}
    M -- No --> D["Use DEFAULT 'Unknown'"]
    D --> R["1001 | Unknown | Unknown"]
```

```text
+------+---------+---------+
| id   | name    | city    |
+------+---------+---------+
| 1001 | Unknown | Unknown |
+------+---------+---------+
```

---

## 8️⃣ Real-World Example

```sql
CREATE TABLE users (
    id INT,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(100) DEFAULT 'Pakistan'
);

INSERT INTO users(id, name)
VALUES (1, 'Ali');
```

`city` was not provided, so `DEFAULT 'Pakistan'` kicks in:

```text
+----+------+----------+
| id | name | city     |
+----+------+----------+
| 1  | Ali  | Pakistan |
+----+------+----------+
```

---

## 9️⃣ NOT NULL and DEFAULT Together

```sql
CREATE TABLE customers (
    id INT,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(100) NOT NULL DEFAULT 'Pakistan'
);
```

```mermaid
flowchart TD
    name["name"] --> req["Must be provided"]
    city["city"] --> cn["Cannot be NULL"]
    cn --> om{Omitted during INSERT?}
    om -- Yes --> use["'Pakistan' will be used"]
    style req fill:#F0876B,color:#0B1220
    style use fill:#4FD1C5,color:#0B1220
```

---

## 🔟 Important Difference

| | 🚫 NOT NULL | 🎁 DEFAULT |
|---|---|---|
| Controls | Whether `NULL` is allowed | Value inserted when column is omitted |
| Meaning | *"A NULL value is not allowed"* | *"If no city is provided, use `Pakistan`"* |

---

## 1️⃣1️⃣ NOT NULL vs DEFAULT — Comparison Table

| Feature | NOT NULL | DEFAULT |
|---|---|---|
| Purpose | Prevents NULL values | Provides automatic value |
| Makes value required? | ✅ Yes | ⚪ Not necessarily |
| Provides a value automatically? | ❌ No | ✅ Yes |
| Example | `name VARCHAR(50) NOT NULL` | `city VARCHAR(100) DEFAULT 'Pakistan'` |

---

## 1️⃣2️⃣ Important Scenario — 3 Cases

```sql
CREATE TABLE users (
    name VARCHAR(50) NOT NULL,
    city VARCHAR(100) DEFAULT 'Pakistan'
);
```

```mermaid
flowchart TD
    S[INSERT INTO users] --> C1["Case 1: name + city given"]
    S --> C2["Case 2: only name given"]
    S --> C3["Case 3: only city given"]

    C1 --> R1["✅ Ali | Lahore"]
    C2 --> R2["✅ Ali | Pakistan (default used)"]
    C3 --> R3["❌ FAILS — name is NOT NULL"]

    style R1 fill:#4FD1C5,color:#0B1220
    style R2 fill:#4FD1C5,color:#0B1220
    style R3 fill:#F0876B,color:#0B1220
```

**Case 1 — Name and city provided**
```sql
INSERT INTO users(name, city) VALUES ('Ali', 'Lahore');
-- Result: Ali | Lahore
```

**Case 2 — City not provided**
```sql
INSERT INTO users(name) VALUES ('Ali');
-- Result: Ali | Pakistan  (default value used)
```

**Case 3 — Name not provided**
```sql
INSERT INTO users(city) VALUES ('Lahore');
-- ❌ Fails — name is NOT NULL and no name was given
```

> [!WARNING]
> Case 3 will always fail because `name` has no `DEFAULT` and is `NOT NULL` — MySQL has nothing to fall back on.

---

## 1️⃣3️⃣ Important Concept About DEFAULT

`DEFAULT` applies when the column value is **omitted from the INSERT statement**.

```sql
INSERT INTO users(name)
VALUES ('Ali');
```

If `city` has `DEFAULT 'Pakistan'`, MySQL automatically stores `Pakistan`.

---

## 1️⃣4️⃣ Practical Example

```sql
CREATE TABLE employees (
    id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) DEFAULT 'Pakistan'
);

INSERT INTO employees(id, name)
VALUES (101, 'Ahmed');

SELECT * FROM employees;
```

```text
+-----+--------+----------+
| id  | name   | city     |
+-----+--------+----------+
| 101 | Ahmed  | Pakistan |
+-----+--------+----------+
```

---

## 1️⃣5️⃣ Common Mistake

Don't confuse the two:

> **NOT NULL** → *"You cannot leave this value as NULL."*
> **DEFAULT** → *"If you don't provide a value, I'll use this predefined value."*

---

## 1️⃣6️⃣ Easy Mental Model

```mermaid
flowchart TD
    COL[COLUMN] --> NN[NOT NULL]
    COL --> DF[DEFAULT]
    NN --> Q1{NULL allowed?}
    Q1 --> NO["NO"]
    DF --> Q2{Value missing?}
    Q2 --> UD["Use default value"]
    style NN fill:#F0876B,color:#0B1220
    style DF fill:#4FD1C5,color:#0B1220
```

---

## 🎤 Interview Questions

<details>
<summary><b>Q1. What is NOT NULL?</b></summary>
<br><code>NOT NULL</code> is a constraint that prevents a column from storing NULL values.
</details>

<details>
<summary><b>Q2. Why do we use NOT NULL?</b></summary>
<br>We use <code>NOT NULL</code> to make important fields mandatory and maintain data integrity.
</details>

<details>
<summary><b>Q3. What is DEFAULT?</b></summary>
<br><code>DEFAULT</code> specifies an automatic value that MySQL uses when a column value is not provided during insertion.
</details>

<details>
<summary><b>Q4. Can NOT NULL and DEFAULT be used together?</b></summary>
<br>Yes.

```sql
city VARCHAR(100) NOT NULL DEFAULT 'Pakistan'
```
</details>

<details>
<summary><b>Q5. What is the difference between NOT NULL and DEFAULT?</b></summary>
<br><code>NOT NULL</code> prevents NULL values, while <code>DEFAULT</code> provides a predefined value when the column is omitted during insertion.
</details>

<details>
<summary><b>Q6. Does DEFAULT make a column NOT NULL?</b></summary>
<br>No. <code>DEFAULT</code> and <code>NOT NULL</code> have different purposes. A default value does not by itself mean that NULL is prohibited.
</details>

---

## 🧠 Quick Revision

```mermaid
flowchart LR
    NN["🚫 NOT NULL"] --> NN1["NULL allowed nahi"]
    DF["🎁 DEFAULT"] --> DF1["Value provide nahi ki?"]
    DF1 --> DF2["Predefined value automatically use hogi"]
```

```sql
CREATE TABLE customers (
    id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(100) DEFAULT 'Pakistan'
);
```

<div align="center">

> **NOT NULL controls whether NULL is allowed, while DEFAULT controls what value is automatically used when a column is omitted during INSERT.**

</div>

---

<details>
<summary>📁 Suggested GitHub File Structure (click to expand)</summary>

```text
mysql/
│
├── 01_mysql_basics.md
├── 02_database_and_tables.md
├── 03_primary_key_auto_increment_alias.md
├── 04_where_update_delete_string_functions.md
└── 05_not_null_default_constraints.md
```

</details>

<div align="center">

**Keep practicing. Understand what each constraint is protecting — not just how to spell it. 🐬🔥**

</div>
