## Storage Systems
(Which databases/storage systems did you choose for each of the 4 goals and why)

The architecture uses multiple specialized storage systems to support the four key goals of the hospital network.
For transactional medical records, PostgreSQL is used as the primary OLTP database. It stores structured data such as patient demographics, treatment history, prescriptions, lab results, and billing records. PostgreSQL is reliable, ACID-compliant, and well suited for hospital information systems that require strong consistency and secure transactions.
To store real-time ICU vitals, a time-series database such as InfluxDB is used. ICU monitoring devices continuously generate high-frequency data such as heart rate, blood pressure, and oxygen levels. Time-series databases are optimized for high ingestion rates, timestamp-based queries, and real-time monitoring dashboards.
For analytics and reporting, a cloud data warehouse such as Snowflake or BigQuery is used. Data from the OLTP systems is periodically moved through an ETL pipeline (using tools such as Apache Airflow or Spark) into the warehouse. This warehouse supports large-scale analytical queries used for monthly management reports such as bed occupancy rates, department costs, and operational trends.
To enable doctors to query patient history using natural language, a vector database such as Pinecone or Weaviate is used. Patient records are converted into embeddings and stored in the vector database. An LLM-based interface retrieves relevant patient data using semantic search, allowing queries like “Has this patient had a cardiac event before?” to be answered quickly.
Together, these storage systems provide a scalable architecture that supports transactional operations, real-time monitoring, AI prediction, and analytical reporting.

## OLTP vs OLAP Boundary
(Where does the transactional system end and the analytical system begin in your design)

In this architecture, the OLTP system consists primarily of the PostgreSQL operational database that stores real-time hospital transactions. These include patient admissions, doctor notes, prescriptions, billing updates, and lab test records. The OLTP system is optimized for frequent inserts and updates and supports the day-to-day operations of the hospital.
The boundary between OLTP and OLAP occurs at the ETL pipeline stage. Data from the transactional PostgreSQL database is periodically extracted and transformed through an ETL workflow managed by tools like Apache Airflow or Spark. This processed data is then loaded into the data warehouse.
The data warehouse represents the OLAP layer. It stores historical and aggregated data optimized for analytical queries rather than transactional workloads. Management reports, trend analysis, and AI training datasets are generated from this OLAP environment. Separating OLTP and OLAP ensures that heavy analytical queries do not affect the performance of operational hospital systems.

## Trade-offs
(Identify one significant trade-off in your design and how you would mitigate it)

One significant trade-off in this architecture is the complexity introduced by using multiple specialized storage systems. While each system (PostgreSQL, InfluxDB, data warehouse, and vector database) is optimized for a particular workload, managing and integrating multiple systems increases operational overhead.
This complexity can lead to challenges in data synchronization, monitoring, and maintenance. For example, ensuring that patient data is consistently updated across the OLTP database, data warehouse, and vector database requires careful pipeline management.
To mitigate this issue, a centralized data orchestration tool such as Apache Airflow can be used to manage ETL workflows and ensure reliable data movement between systems. Additionally, implementing strong data governance practices and automated monitoring tools helps maintain data quality and system reliability. Although the architecture is more complex, it provides better scalability, performance, and flexibility for AI-powered healthcare applications.
