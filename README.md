# 🛒 E-Commerce Analytics Project with dbt

## 📌 Project Overview

This project demonstrates an end-to-end modern data transformation pipeline using **dbt (Data Build Tool)**. It showcases how to build modular and maintainable data models on top of raw e-commerce data to derive valuable customer, product, and event insights.

## 🎯 Project Goals

* Transform raw e-commerce data into analytical models.
* Demonstrate best practices with dbt including:

  * Jinja macros and loops
  * Testing and documentation
  * Snapshots and seeds
  * Clear model layering (staging → intermediate → marts)
* Simulate a data warehouse using PostgreSQL for local development.
* Lay the foundation for building dashboards and advanced analytics in future iterations.

## 🧾 Dataset Overview

The dataset used is a simplified representation of an e-commerce platform. It includes key tables:

### Staging Tables (`/models/staging/`)

| Table                            | Description                                      |
| -------------------------------- | ------------------------------------------------ |
| `stg_ecommerce__events`          | Web interaction events like clicks and sessions. |
| `stg_ecommerce__orders`          | Customer orders.                                 |
| `stg_ecommerce__order_items`     | Items within each order.                         |
| `stg_ecommerce__inventory_items` | Inventory availability.                          |
| `stg_ecommerce__products`        | Product catalog information.                     |
| `stg_ecommerce__users`           | Customer/user profiles.                          |

### Intermediate Models (`/models/marts/`)

| Table                 | Description                                                                         |
| --------------------- | ----------------------------------------------------------------------------------- |
| `int_events__pivoted` | Pivoted web session data with traffic source and browser metrics using Jinja loops. |
| `int_orders__pivoted` | Pivoted order statuses using Jinja loop macros.                                     |

### Mart Models

| Table       | Description                                                                            |
| ----------- | -------------------------------------------------------------------------------------- |
| `customers` | Final model combining user sessions, purchases, and browser/traffic source breakdowns. |
| `products`  | Includes cost of goods sold logic with a reusable macro for coalescing and rounding.   |

## 🛠 Tools & Technologies Used

| Tool         | Purpose                                |
| ------------ | -------------------------------------- |
| `dbt`        | Data transformation and modeling.      |
| `PostgreSQL` | Simulated data warehouse environment.  |
| `Jinja`      | Templating for dynamic SQL generation. |
| `CLI`        | Running dbt models, tests, and seeds.  |

##  Key dbt Features Demonstrated

* **Staging and Mart Layering**: Clear separation of raw staging data and business logic.
* **Jinja Macros**: Custom macro `coalesce_and_round` for reusable logic.

```sql
-- Example usage of macro
{{ coalesce_and_round('discount_amount', 2) }}
```

* **Jinja Loops**: Used for dynamic column generation (e.g., pivoting traffic sources and browsers).
* **Snapshots**: Track historical changes to orders and inventory with slowly changing dimensions.
* **Seeds**: Distribution center reference data from a CSV seed.
* **Testing**: Data quality checks using `dbt test`.
* **Documentation**: YAML-based model and column-level documentation.

## 🗂️ Project Structure

```
├── macros/
│   └── coalesce_and_round.sql         # Custom macro to clean and round values
├── models/
│   ├── marts/
│   │   ├── customers.sql              # Final customer-facing model
│   │   ├── products.sql               # Product-level metrics with profit logic
│   │   ├── int_orders__pivoted.sql    # Intermediate pivot of order statuses
│   │   └── int_events__pivoted.sql    # Intermediate pivot of events (traffic/browser)
│   └── staging/
│       ├── stg_ecommerce__events.sql         # Cleaned raw web event logs
│       ├── stg_ecommerce__orders.sql         # Cleaned customer orders
│       ├── stg_ecommerce__order_items.sql    # Cleaned order items
│       ├── stg_ecommerce__inventory_items.sql # Cleaned inventory availability
│       ├── stg_ecommerce__products.sql       # Cleaned product catalog
│       └── stg_ecommerce__users.sql          # Cleaned user profile data
├── seeds/
│   └── ecommerce_distribution_centers.csv  # Seed file with reference data
├── snapshots/
│   ├── orders_snapshot.sql
│   └── inventory_snapshot.sql         # Track changes over time
├── tests/
│   └── schema.yml                     # Schema-level data tests
├── dbt_project.yml
└── README.md
```

## 📦 Installation & Execution

```bash
# Install dependencies
pip install dbt-postgres

# Set up your PostgreSQL instance (or use a dockerized version)
# Create and populate tables from the seed files

# Run dbt workflow
cd path/to/your/project

dbt seed         # Load seed CSVs to the database
dbt run          # Run all transformations
dbt test         # Run all tests
dbt docs generate && dbt docs serve  # Build documentation site
```

## 📌 Dataset Origin & Architecture

This project is built using a publicly available **e-commerce dataset** originally hosted in **Google BigQuery** and sourced via **Kaggle**. For simplicity and local development purposes, the dataset was converted to CSV format and loaded into a **PostgreSQL** database to simulate a modern data warehouse environment.

In future iterations, this project will be migrated to a **cloud-based data warehouse** (e.g., BigQuery or Snowflake) and extended with a **business intelligence dashboard** to deliver end-to-end analytics capabilities.

##  Future Enhancements

*  Replace local PostgreSQL with BigQuery or Snowflake for cloud scalability.
*  Connect dbt exposures to a BI tool (e.g., Power BI, Looker) to visualize customer behavior, product trends, and session funnel analysis.
*  Use incremental models to process only new or updated data (e.g., large events table).
*  Add dbt exposures to link downstream dashboards to models for lineage tracking.
*  Automate workflows using dbt Cloud or Airflow.

---

## 🤝 Connect With Me

📫 [GitHub](https://github.com/mohamed-laymouna) | [LinkedIn](https://linkedin.com/in/yourprofile) | [Email](mohamed.laymouna@email.com)
