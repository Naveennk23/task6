
## ✅ Task Objective

- Practice scalar subqueries
- Use subqueries in `WHERE`, `EXISTS`, `IN`
- Join subqueries with aggregate functions
- Perform analysis using nested logic

---

## 🗃️ Table: `customers`

| customer_id | name         | email              | amount_spent |
|-------------|--------------|--------------------|--------------|
| 1           | Naveen Kumar | naveen@example.com | 1500         |
| 2           | Asha Rao     | asha@example.com   | 2000         |
| 3           | madhu        | madhu89@gmail.com  | 1500         |
| 4           | Kutty        | kutty90@gmail      | 1000         |
| 5           | keerthi      | keerthi12@gmail    | 2000         |

---

## 🔍 SQL Queries & Outputs

### 1️⃣ Scalar Subquery in `SELECT`
**Show each customer's total ordered amount**
```sql
SELECT 
  name,
  (SELECT SUM(amount) 
   FROM orders 
   WHERE orders.customer_id = customers.customer_id) AS total_spent
FROM customers;
