# data-observability-demo

This repo contains the code to create a banking themed end to end demo of Ataccama's data observability and data quality offering. Specifically, it creates:
* A Postgres database, with two bronze tables: `stg_customers` and `stg_transactions`
* A dbt job that joins these two bronze tables into a silver table: `customer_transactions`
It then contains instructions for how to create the following scenarios that can be demo'd from the 'Alerts' screen in Ataccama.
* Pipeline failures
* DQ issues
* Profiling anomalies

## Pre-requisites:
1. Download Docker Desktop (or Docker Engine)
2. Fork this repo
3. Install `brew`

## Setup
1. Create your local version of the `.env` file
```
cp .env.example .env
```
Note that this repo assumes you are on a Mac with an M1/M2/M3/M4 chip, if that is not the case remove line 17 from your `docker-compose.yml`
```
platform: linux/amd64
```
2. Setup an orchestrator connection in Ataccama to receive your pipeline monitoring events:
* Create API key and copy the OpenLineage endpoint from Ataccama connection
* Set `OPENLINEAGE_URL` and `OPENLINEAGE_API_KEY` in `.env`
3. Run the script once to register a pipeline run in Ataccama
```
./scripts/run_demo_setup.sh
```
4. Verify the pipeline monitoring setup by checking you can see the pipeline run in Ataccama
Note: the following steps are only required if you want to show an end to end demo of Ataccama's data observability and data quality functionality. If you only want to showcase pipeline monitoring, you can skip to the next section.
5. Verify the Postgres tables by connect with any SQL client to `localhost:5432` (demo/demo, db bank)
Query:
```
select * from silver.customer_transactions;
```
6. Connect Postgres to Ataccama for DQ monitoring
* Create a public endpoint for your Postgres database with ngrok
```
brew install ngrok
ngrok tcp 5432
```
This will provide you with the JDBC URL to use in Ataccama. Note that unless you pay, your ngrok URL will change every time. Also, if you have an issue with Mac permissions, ...
* ...
7. Verify the data connection by running full profiling and checking the results in Ataccama

## Generating demo content
1. Generating a pipeline failure
2. Generating a DQ issue
3. Generating a profiling anomaly