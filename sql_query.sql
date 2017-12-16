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