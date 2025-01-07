/*Here’s the question again:

---

### **Harry Potter and Ollivander's Wand Shop**

Harry Potter and his friends are at Ollivander's Wand Shop, helping Ron choose a wand to replace Charlie's old broken one. Hermione suggests picking the wands by determining the **minimum number of gold galleons needed** to buy **each non-evil wand** of **high power and age**.

---

### **Task**
Write a SQL query to print the following details for the wands Ron is interested in:
1. **id** - The ID of the wand.
2. **age** - The age of the wand.
3. **coins_needed** - The gold galleons required to buy the wand.
4. **power** - The power level of the wand.

The output should be **sorted in the following order**:
1. By **power** in descending order (higher power first).
2. If multiple wands have the same power, by **age** in descending order (older wands first).

---

### **Input Format**
You are provided with two tables:

#### **1. Wands Table**
| Column Name    | Description                                      |
|----------------|--------------------------------------------------|
| `id`           | The ID of the wand.                             |
| `code`         | The code of the wand.                           |
| `coins_needed` | The gold galleons required to buy the wand.      |
| `power`        | The power level of the wand (higher is better). |

#### **2. Wands_Property Table**
| Column Name | Description                                              |
|-------------|----------------------------------------------------------|
| `code`      | The code of the wand.                                    |
| `age`       | The age of the wand.                                     |
| `is_evil`   | Whether the wand is for the dark arts (1 = evil, 0 = not evil). |

---

### **Conditions**
1. Only consider **non-evil wands** (`is_evil = 0`).
2. If multiple wands have the same `power` and `age`, select the wand with the **minimum `coins_needed`**.

---

### **Output Format**
Print the following columns:
1. `id` (Wand ID)
2. `age` (Wand Age)
3. `coins_needed` (Gold galleons required)
4. `power` (Wand Power)

Sort the result:
1. By `power` in descending order.
2. By `age` in descending order (if powers are equal).

---

### **Example Input**

#### **Wands Table**
| id  | code | coins_needed | power |
|-----|------|--------------|-------|
| 1   | A    | 3688         | 8     |
| 9   | B    | 1647         | 10    |
| 12  | C    | 9897         | 10    |

#### **Wands_Property Table**
| code | age | is_evil |
|------|-----|---------|
| A    | 20  | 0       |
| B    | 45  | 0       |
| C    | 17  | 0       |

---

### **Example Output**
| id  | age | coins_needed | power |
|-----|-----|--------------|-------|
| 9   | 45  | 1647         | 10    |
| 12  | 17  | 9897         | 10    |
| 1   | 20  | 3688         | 8     |

---
*/

SELECT w.id, p.age, w.coins_needed, w.power
FROM WANDS w
JOIN WANDS_PROPERTY p ON w.code = p.code
WHERE p.is_evil = 0
  AND w.coins_needed = (
    SELECT MIN(w1.coins_needed)
    FROM WANDS w1
    JOIN WANDS_PROPERTY p1 ON w1.code = p1.code
    WHERE p1.is_evil = 0
      AND w1.power = w.power
      AND p1.age = p.age
  )
ORDER BY w.power DESC, p.age DESC;
