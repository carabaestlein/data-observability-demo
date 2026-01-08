# data-observability-demo

Pre-requisites: Docker Desktop (or Docker Engine)

Setup:

```
cp .env.example .env
./scripts/run_demo.sh
```

Check results:

Connect with any SQL client to localhost:5432 (demo/demo, db bank)

Query:
```
select * from silver.customer_transactions limit 20;
```