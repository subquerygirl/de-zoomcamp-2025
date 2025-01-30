
# Notes - Week 1

## Set up
### Run postgres
```
docker run -it \
  -e POSTGRES_DB="ny_taxi" \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -v /Users/mariasamper/data-engineering-zoomcamp/week_1/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  --network=pg-network \
  --name pg-database \
  postgres:13
```

### Access postgres with pgcli (no VE)
pgcli -h localhost -p 5432 -u root -d ny_taxi

### Run pgAdmin
```
  docker run -it \
    -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
    -e PGADMIN_DEFAULT_PASSWORD="root" \
    -p 8080:80 \
    --network=pg-network \
    --name pg-admin \
    dpage/pgadmin4
```

## Ingest data py
```
python ingest_data.py \
    user=root \
    password=root \
    host=localhost \
    port=5432 \
    db=ny_taxi \
    table=yellow_taxi_data_2
```

### Connect to database
`python ingest_data.py root root localhost 5432 ny_taxi yellow_taxi_data_2`


## Load data
### Update docker file and build image with docker
`docker build -t green_taxi:v001 .`

### Load yellow taxi driver data
```
docker run -it \
    -v /Users/mariasamper/data-engineering-zoomcamp/ny_taxi_raw:/mnt/data \
    --network=pg-network \
    taxi_ingest:v001 \
        --user=root \
        --password=root \
        --host=pg-database \
        --port=5432 \
        --db=ny_taxi \
        --table=yellow_taxi_trips_3 \
        --file_path /mnt/data/yellow_tripdata_2021-01.csv
```

### Load zone lookup data
```
docker run -it \
    -v /Users/mariasamper/data-engineering-zoomcamp/ny_taxi_raw:/mnt/data \
    --network=pg-network \
    taxi_ingest_zones:v001 \
        --user=root \
        --password=root \
        --host=pg-database \
        --port=5432 \
        --db=ny_taxi \
        --table=taxi_zone_lookup \
        --file_path /mnt/data/taxi_zone_lookup.csv
```

### Load green taxi driver data
```
docker run -it \
    -v /Users/mariasamper/data-engineering-zoomcamp/ny_taxi_raw:/mnt/data \
    --network=pg-network \
    green_taxi:v001 \
        --user=root \
        --password=root \
        --host=pg-database \
        --port=5432 \
        --db=ny_taxi \
        --table=green_taxi_trips \
        --file_path /mnt/data/green_tripdata_2019-10.csv
```

## Terraform - Basic commands
- Format code: terraform fmt
- Show what will it change: terraform plan
- Apply changes: terraform apply
- Delete everything: terraform destroy

______

## Create repo in GitHub from existing folder
`git init` in the folder.
Create a .gitignore file (optional).
`git add .` to stage changes.
`git commit -m "Initial commit"`
Create a repo on GitHub.
`git remote add origin https://github.com/subquerygirl/de-zoomcamp-2025.git`
`git push -u origin main`