WITH inv_split as (
  SELECT
    id,
    CAST(SPLIT_PART(invoice_number, '-', 1) AS VARCHAR(10)) AS track, -- Make sure data type is the same as invoice_books.track
    CAST(SPLIT_PART(invoice_number, '-', 2) AS INTEGER) AS track_num, -- Make sure data type is the same as begin_number and end_number
    invoice_number
  FROM
    invoices
)

SELECT
  inv.id,
  inv.invoice_number,
  inv.track,
  ib.year,
  ib.month,
  ib.begin_number,
  ib.end_number
FROM
  inv_split AS inv
JOIN
  invoice_books AS ib
ON
  inv.track = ib.track
  AND inv.track_num BETWEEN ib.begin_number AND ib.end_number
