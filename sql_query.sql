SELECT 
  COUNT(*) AS COUNT_ALL
FROM 
  order_items
WHERE 
  DATE(created_at) BETWEEN date AND date
GROUP BY 
  DATE_TRUNC(day_type, created_at)
