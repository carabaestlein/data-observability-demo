FROM python:3.11-slim

WORKDIR /usr/app

# Install dbt + Postgres adapter + OpenLineage
RUN pip install --no-cache-dir \
    dbt-core \
    dbt-postgres \
    openlineage-dbt

CMD ["dbt", "--version"]