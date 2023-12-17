# Overview
This is the Extract-Transform-Load (ETL) scripts to migrate a copy of the Ethereum dataset from Google's BigQuery into a local Postgres DB. The 
process is exhaustive, involving extraction from Ethereum into CSVs exported into Google Cloud Storage (GCS) buckets, then retrieving the CSVs into your local drive to then be loaded into Postgres DB.  

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
- preferably sudo capability, to setup create log folders at `/var/log/eth-etl`, adding new accounts like `postgres`, and target data folders for the database like `/var/lib/postgresql`

## Step 1 - Setup your environment
The following is an example of the setup steps necessary to get things going
```
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
```
# Check via ipconfig to see what your Docker's internal host IP address is
HOST=localhost
psql -h ${HOST} -U postgres -c 'CREATE DATABASE ethereum_db;'
```

Bootstrap the database by creating tables necessary to receive the dataset from Lens BigQuery
```
psql -h ${HOST} -U postgres -f ethereum_db_schema.sql
```


## Step 3 - Review ETL scripts
`run-etl-full.sh` - This script will perform a full export of several tables at Lens BigQuery as specified in the `sql-import-full/` 
folder.  Each SQL script will request BigQuery to `EXPORT DATA` in a form of comma-separated values (CSVs) into Google Cloud Service (GCS) 
in an orderly manner, based on the primary key of each table.  This will help the export process be repeatable and not run into any duplicate 
records, as the exports are partitioned into multiple CSV files when the exports approaches on 1GB per CSV file.


## Step 4 - Automate the ETL scripts (optional)
Once you've successfully tested the scripts and review the data imported, you may wish to automate the script to run on a periodic basis.  Below is an 
example of an import strategy to retrieve Lens BigQuery data on an hourly basis, and perform a full update at 2300 hours (local server time)
```
HOME=/home/ubuntu
# Run full import from Lens BQ at 11PM PST daily and every hour for updates
(crontab -l 2>/dev/null; echo "0 23 * * * $HOME/eth-etl/run-etl-refresh.sh") | crontab -
(crontab -l 2>/dev/null; echo "0 0-22 * * * $HOME/eth-etl/run-etl-update.sh") | crontab -
```

# Next Steps
These ETL scripts can be repurposed for other BigQuery datasets that developers may need in order to run computation which regularly queries 
the database.  Running a local copy will avoid the cloud transfer latencies and the cost of running on BigQuery.  Feel free to fork this script 
or improve upon it by submitting a pull request.

If there are any questions, reach out to us on [Discord](https://k3l.io/discord) or [Telegram](https://t.me/Karma3Labs), and follow us on [Twitter](https://twitter.com/Karma3Labs).

