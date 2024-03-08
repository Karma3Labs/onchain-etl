# Overview
This is the Extract-Transform-Load (ETL) scripts to migrate a copy of the on-chain dataset from Google's BigQuery into a local Postgres DB. The 
process is exhaustive, involving 
1. extract Ethereum, Optimism and future (EVM-compatible chains) public datasets into CSV-format exported via a SQL query into Google Cloud Storage (GCS) buckets,
2. downloading the CSVs into your local drive using Google Storage CLI, and then 
3. inserted into a local Postgres DB

# Setting up the ETL

## Pre-requisites
The following are the necessary pre-requisites to begin.  Please go through these steps to setup your environment and necessary accounts properly.
- a Linux-based server, preferably Ubuntu
- a good understanding of `bash` scripting, Docker management and `crontab` to manage the scripts, maintain the database and run scheduled cron jobs
- a Google Cloud account, with a private key configured via [gsutil](https://cloud.google.com/storage/docs/gsutil/commands/config), with IAM privileges to access BigQuery and GCS
- gain a general understanding of the [Ethereum BigQuery Public Dataset](https://cloud.google.com/blog/products/data-analytics/ethereum-bigquery-public-dataset-smart-contract-analytics) setup
- an installed [Google Cloud CLI](https://cloud.google.com/sdk/docs/install) to run `gcloud`, `gutil` and `bq` commands
- an installed Docker binary (you'll need a DockerHub account too)
- a Postgres database, available via [Docker Hub](https://hub.docker.com/_/postgres)
- enable [.pgpass](https://tableplus.com/blog/2019/09/how-to-use-pgpass-in-postgresql.html) to run Postgres CLI such as `psql` without a password challenge
- preferably sudo capability, to setup create log folders at `/var/log/onchain-etl`, adding new accounts like `postgres`, and target data folders for the database like `/var/lib/postgresql`

## Step 1 - Setup your environment
The following is an example of the setup steps necessary to get things going

```sh
# Environment setting
DB_PASS=(your-password)
DB_NAME=ethereum_db
DB_PORT=5432
NETWORK=ethereum_db
BUFFER_SIZE=256mb

# Prometheus via Docker
sudo useradd -rs /bin/false postgres
sudo mkdir -p /var/lib/postgresql/data/${DB_NAME}
sudo chown -R postgres:postgres /var/lib/postgresql

# This is optional, assuming you already have a DockerHub account
sudo docker login
sudo docker create network ${NETWORK}

# Find Linux User & Group ID, since username does not work in Docker (bug?)
UIDGID=`grep postgres /etc/passwd | awk -F[:] '{print $3":"$4}'`

docker run --name ${DB_NAME} -p ${DB_PORT}:5432 --network ${NETWORK} \
--user $UIDGID -d \
-e POSTGRES_PASSWORD=$DB_PASS \
-e PGDATA=/var/lib/postgresql/data/${DB_NAME} \
-v /var/lib/postgresql/data/${DB_NAME}:/var/lib/postgresql/data/${DB_NAME} \
-v /etc/postgresql:/etc/postgresql \
-v /usr/share/postgresql:/usr/share/postgresql \
postgres \
-c shared_buffers=${BUFFER_SIZE} -c max_connections=1000
```

## Step 2 - Setup your local database
Once you have Postgres up and running, run a script to create a database called `ethereum_db`.  Then populate it with the default schema that will be used as part of the ETL process.
```sh
# Check via ipconfig to see what your Docker's internal host IP address is
HOST=localhost
psql -h ${HOST} -U postgres -c 'CREATE DATABASE ethereum_db;'
```

Bootstrap the database by creating tables necessary to receive the dataset from Lens BigQuery
```sh
psql -h ${HOST} -U postgres -f ethereum_db_schema.sql
```


## Step 3 - Export from BigQuery to Cloud Storage
`bq_to_pg/sql-export` - This folder has scripts that can be run from BigQuery console or using `bq` cli tool. If using BigQuery console, copy the scripts into separate query tabs and run them one by one. Running these scripts will export data from BigQuery to a bucket in GCS in parquet format.

## Step 4 - Import from Cloud Storage into Postgres
The import script is run inside a docker container that encapsulates all the dependencies required by the script. Make sure to create a `.env.docker` file and edit the postgres database details.
```
cd bq_to_pg
cp .env.sample .env.docker
vi env.docker
docker-compose -f docker-compose.yml build
docker-compose -f docker-compose.yml up -d
```

# Next Steps
If there are any questions, reach out to us on [Discord](https://k3l.io/discord) or [Telegram](https://t.me/Karma3Labs), and follow us on [Twitter](https://twitter.com/Karma3Labs).

