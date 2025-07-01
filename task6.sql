mysql> select * from customers;
+-------------+--------------+--------------------+--------------+
| customer_id | name         | email              | amount_spent |
+-------------+--------------+--------------------+--------------+
|           1 | Naveen Kumar | naveen@example.com |         1500 |
|           2 | Asha Rao     | asha@example.com   |         2000 |
|           3 | madhu        | madhu89@gmail.com  |         1500 |
|           4 | Kutty        | kutty90@gmail      |         1000 |
|           5 | keerthi      | keerthi12@gmail    |         2000 |
+-------------+--------------+--------------------+--------------+
5 rows in set (0.01 sec)

mysql> SELECT
    ->   name,
    ->   (SELECT SUM(amount) FROM orders WHERE orders.customer_id = customers.customer_id) AS total_spent
    -> FROM customers;
+--------------+-------------+
| name         | total_spent |
+--------------+-------------+
| Naveen Kumar |        1500 |
| Asha Rao     |        2000 |
| madhu        |        NULL |
| Kutty        |        1000 |
| keerthi      |        NULL |
+--------------+-------------+
5 rows in set (0.24 sec)

mysql> SELECT * FROM customers
    -> WHERE customer_id IN (SELECT customer_id FROM orders);
+-------------+--------------+--------------------+--------------+
| customer_id | name         | email              | amount_spent |
+-------------+--------------+--------------------+--------------+
|           1 | Naveen Kumar | naveen@example.com |         1500 |
|           2 | Asha Rao     | asha@example.com   |         2000 |
|           4 | Kutty        | kutty90@gmail      |         1000 |
+-------------+--------------+--------------------+--------------+
3 rows in set (0.02 sec)

mysql> SELECT * FROM customers c
    -> WHERE EXISTS (
    ->   SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id
    -> );
+-------------+--------------+--------------------+--------------+
| customer_id | name         | email              | amount_spent |
+-------------+--------------+--------------------+--------------+
|           1 | Naveen Kumar | naveen@example.com |         1500 |
|           2 | Asha Rao     | asha@example.com   |         2000 |
|           4 | Kutty        | kutty90@gmail      |         1000 |
+-------------+--------------+--------------------+--------------+
3 rows in set (0.01 sec)

mysql> SELECT name FROM customers c
    -> WHERE (
    ->   SELECT SUM(amount) FROM orders o WHERE o.customer_id = c.customer_id
    -> ) > c.amount_spent;
Empty set (0.01 sec)

mysql> SELECT c.name, t.avg_order
    -> FROM customers c
    -> JOIN (
    ->   SELECT customer_id, AVG(amount) AS avg_order
    ->   FROM orders
    ->   GROUP BY customer_id
    -> ) t ON c.customer_id = t.customer_id;
+--------------+-----------+
| name         | avg_order |
+--------------+-----------+
| Naveen Kumar |  750.0000 |
| Asha Rao     | 2000.0000 |
| Kutty        | 1000.0000 |
+--------------+-----------+
3 rows in set (0.04 sec)

mysql> SELECT name FROM customers
    -> WHERE customer_id = (
    ->   SELECT customer_id FROM orders
    ->   GROUP BY customer_id
    ->   ORDER BY SUM(amount) DESC
    ->   LIMIT 1
    -> );
+----------+
| name     |
+----------+
| Asha Rao |
+----------+
1 row in set (0.01 sec)
