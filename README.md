# data-observability-demo

This repo contains the code to create a banking themed end to end demo of Ataccama's data observability and data quality offering. Specifically, it creates:
* A Postgres database (with Neon), with two bronze tables: `stg_customers` and `stg_transactions`
* A dbt job that joins these two bronze tables into a silver table: `customer_transactions`

It then contains instructions for how to create the following scenarios that can be demo'd from the 'Alerts' screen in Ataccama.
* DQ issues
* Profiling anomalies
* Pipeline failures

## Pre-requisites:
1. Download Docker Desktop (or Docker Engine)
2. Fork this repo
3. Create a free Postgres using Neon

## Setup
1. Create your local version of the `.env` file and fill in the relevant details from Neon
```
cp .env.example .env
```
Note that this repo assumes you are on a Mac with an Apple silicon chip, if that is not the case remove line 17 from your `docker-compose.yml`
```
platform: linux/amd64
```
2. Setup an orchestrator connection in Ataccama to receive your pipeline monitoring events:
* Create API key and copy the OpenLineage endpoint from Ataccama connection
* Set `OPENLINEAGE_URL` and `OPENLINEAGE_API_KEY` in `.env`
3. Run the script once to register a pipeline run in Ataccama
```
./scripts/run_setup.sh
```
4. Verify the pipeline monitoring setup by checking you can see the pipeline run in Ataccama
5. Optional: verify the Postgres tables by connect with any SQL client to `<your-neon-host-url>:5432` (database: `neondb`, user: `neondb_owner`, password: `<your-password>`)
Query:
```
select * from silver.customer_transactions;
```
6. Connect Postgres to Ataccama for DQ monitoring
* Use the provided url as the JDBC string in Ataccama: `jdbc:postgresql://<your-neon-host-url>/neondb?sslmode=require&channel_binding=require`
* Fill in the user and password and test the connection
7. Verify the data connection by running full profiling and checking the results in Ataccama

## Generating demo content
1. Create DQ rules in Ataccama and run DQ evaluation
* Leverage the AI Agent to generate DQ rules for all attributes in the `customers_transactions` table
* Set up a DQ monitoring threshold
2. Insert some bad data - this will generate a DQ alert
```
./scripts/run_demo.sh
```
3. If you want to generate a profiling anomaly, you need to run DQ evaluation at least 7 times before you run the `insert_bad_data.sh` script
4. If you want to generate a pipeline failure, you can simply misspell one of the column names in `customers_transactions.sql`, and then run `run_dbt_only.sh`
