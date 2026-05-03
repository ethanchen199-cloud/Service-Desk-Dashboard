CREATE DATABASE service_desk;
USE service_desk;
CREATE TABLE tickets (
  ticket_id INT,
  created_date DATE,
  resolved_date DATE,
  category VARCHAR(50),
  priority VARCHAR(20),
  status VARCHAR(20),
  assigned_team VARCHAR(50),
  first_response_time INT,
  resolution_time INT
);
SELECT * FROM tickets LIMIT 10;

#Ticket Volume
SELECT category, COUNT(*) AS total_tickets
FROM tickets
GROUP BY category
ORDER BY total_tickets DESC;

#SLA%
SELECT 
  COUNT(*) AS total,
  SUM(CASE WHEN resolution_time <= 24 THEN 1 ELSE 0 END) AS within_sla,
  (SUM(CASE WHEN resolution_time <= 24 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS sla_percentage
FROM tickets
WHERE status = 'Closed';

#Backlog
SELECT COUNT(*) AS open_tickets
FROM tickets
WHERE status = 'Open';

#Aging Tickets
SELECT 
  ticket_id,
  DATEDIFF(CURDATE(), created_date) AS days_open
FROM tickets
WHERE status = 'Open'
ORDER BY days_open DESC;

#Trend Over time
SELECT 
  DATE(created_date) AS date,
  COUNT(*) AS tickets_created
FROM tickets
GROUP BY DATE(created_date)
ORDER BY date;





