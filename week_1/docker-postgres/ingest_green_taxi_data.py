import argparse
from time import time
import pandas as pd
from sqlalchemy import create_engine
import os

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = int(params.port)  # Ensure this is cast to integer
    db = params.db
    table = params.table
    file_path = params.file_path  # We now pass file_path as argument

    # Ensure that the file exists before attempting to read it
    if not os.path.isfile(file_path):
        print(f"Error: The file {file_path} does not exist.")
        return

    # Create the database engine URL using input parameters
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    # Use pandas to read the CSV in chunks
    df_iter = pd.read_csv(file_path, iterator=True, chunksize=100000)
    df = next(df_iter)

    df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
    df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

    df.head(n=0).to_sql(name=table, con=engine, if_exists='replace')
    df.to_sql(name=table, con=engine, if_exists='append')

    # Process remaining chunks
    while True:
        t_start = time()

        try:
            df = next(df_iter)

            df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
            df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

            df.to_sql(name=table, con=engine, if_exists='append')

            t_end = time()
            print('Inserted another chunk, took %.3f seconds' % (t_end - t_start))

        except StopIteration:
            print('All data has been processed.')
            break

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest CSV data to PostgreSQL')
    
    # Modify to accept flags
    parser.add_argument('--user', help='user name for postgres', required=True)
    parser.add_argument('--password', help='password for postgres', required=True)
    parser.add_argument('--host', help='host for postgres', required=True)
    parser.add_argument('--port', help='port for postgres', required=True)
    parser.add_argument('--db', help='database name for postgres', required=True)
    parser.add_argument('--table', help='table name for postgres', required=True)
    parser.add_argument('--file_path', help='Path to the CSV file', required=True)

    args = parser.parse_args()

    main(args)