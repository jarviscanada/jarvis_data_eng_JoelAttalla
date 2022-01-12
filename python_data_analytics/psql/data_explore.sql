-- Show Table Schema.
\d+ retail;

-- Show First 10 Rows.
SELECT * FROM retail limit 10;

-- Check Number of Records.
SELECT COUNT(*) FROM retail;

-- Number of Clients. (eg. Unique Client ID)
SELECT COUNT(DISTINCT customer_id) FROM retail;

-- Invoice Data Range. (eg. Max/Min Dates)
SELECT MAX(invoice_date), MIN(invoice_date) FROM retail;

-- Number of SKU/Merchants. (eg. Unique Stock Code)
SELECT COUNT(DISTINCT stock_code) FROM retail;

-- Calculate Average Invoice Amount Excluding Invoices
-- with a Negative Amount. (eg. Canceled Orders have a Negative Amount)
SELECT AVG(invoice_amount)
FROM (
     SELECT SUM(quantity * unit_price)
     AS invoice_amount
     FROM retail
     GROUP BY invoice_no
     HAVING SUM(quantity * unit_price) > 0
     )
AS total_invoice_amount;

-- Calculate Total Revenue.
SELECT SUM(unit_price * quantity) FROM retail;

-- Calculate Total Revenue by YYYYMM.
SELECT to_char(invoice_date, 'yyyymm')
AS yyyymm
SUM(quantity * unit_price)
FROM retail
GROUP BY yyyymm
ORDER BY yyyymm ASC;
