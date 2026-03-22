## ETL Decisions

## Decision 1 — Standardizing Date Formats
Problem: 
The raw dataset contained inconsistent date formats such as DD/MM/YYYY, YYYY-MM-DD, and other variations. This inconsistency made it difficult to load data into the date dimension and perform time-based analysis.

Resolution:
All date values were converted into a consistent ISO format (YYYY-MM-DD) before loading into the `dim_date` table and referencing
in `fact_sales`. This ensured uniformity and enabled proper joins and time-based aggregations.

## Decision 2 — Handling NULL Values in Key Fields
Problem:  
Some records in the raw data contained NULL values in critical fields such as store_id, product_id, or quantity. These missing values could violate referential integrity and affect the accuracy of analytics.

Resolution:  
Records with missing foreign key values were excluded from the fact table. For non-critical missing attributes, values were either inferred where reasonable or omitted if they could not be reliably determined.

## Decision 3 — Standardizing Category Values
Category values had inconsistent formats such as 'electronics', 'Electronics', and 'ELECTRONICS'.
All values were converted to a consistent format (Title Case) before loading into dim_product.
