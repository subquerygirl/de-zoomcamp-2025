import argparse
from sqlalchemy import create_engine
import pandas as pd
import os
from time import time


def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = int(params.port)  # Convert port to an integer
    db = params.db
    table = params.table
    
    # Hardcoded file path
    file_path = "/Users/mariasamper/data-engineering-zoomcamp/ny_taxi_raw/yellow_tripdata_2021-01.csv"
    
    print(f"Using file path: {file_path}")  # Print file path to verify

    # Ensure the file exists before attempting to read it
    if not os.path.isfile(file_path):
        print(f"Error: The file {file_path} does not exist.")
        return

    # Create connection string for PostgreSQL
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    df_iter = pd.read_csv(file_path, iterator=True, chunksize=100000)

    df = next(df_iter)

    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

    df.head(n=0).to_sql(name=table, con=engine, if_exists='replace')

    df.to_sql(name=table, con=engine, if_exists='append')

    while True:
        t_start = time()

        try:
            df = next(df_iter)

            df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
            df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

            df.to_sql(name=table, con=engine, if_exists='append')

            t_end = time()

            print('Inserted another chunk, took %.3f seconds' % (t_end - t_start))

        except StopIteration:
            print('All data has been processed.')
            break


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest CSV data to PostgreSQL')

    parser.add_argument('user', help='user name for postgres')
    parser.add_argument('password', help='password for postgres')
    parser.add_argument('host', help='host for postgres')
    parser.add_argument('port', help='port for postgres')
    parser.add_argument('db', help='database name for postgres')
    parser.add_argument('table', help='table name for postgres')

    args = parser.parse_args()

    main(args)
