# Shopping API

SQL query: 
```sql
  SELECT DISTINCT 
    user.id AS customer_id, 
    user.first_name AS customer_first_name, 
    category.id AS category_id, 
    category.name AS category_name,
    COUNT (*) AS number_purchased
  FROM 
    user, category
  WHERE 
    user.id = 1
    AND 
    category.id = 1
```

## Schema

### User 

| Column Name   | Data Type     | Details |
| ------------- |:-------------:| -----:  |
| id            | integer       | not null, primary key |
| first_name    | string        | not null |
| last_name     | string        | not null |

### Order

| Column Name   | Data Type     | Details |
| ------------- |:-------------:| -----:|
| id            | integer       | not null, primary key |
| status        | string        | default: 'waiting for delivery' |
| customer_id   | integer       | not null |

### Product 

| Column Name   | Data Type     | Details |
| ------------- |:-------------:| -----:  |
| id            | integer       | not null, primary key |
| name          | string        | not null |
| price         | float         | not null |
| weight        | float         | not null |
| category_id   | integer       | not null |
| order_id      | integer       |          |

### Category

| Column Name   | Data Type     | Details |
| ------------- |:-------------:| -----:  |
| id            | integer       | not null, primary key |
| name          | string        | not null |

### Product_Category

| Column Name   | Data Type     | Details |
| ------------- |:-------------:| -----:  |
| id            | integer       | not null, primary key |
| category_id   | string        | not null |
| product_id    | string        | not null |

## Routes 





