#!/usr/bin/env python
# coding: utf-8

# In[75]:


from time import time
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://root:root@localhost:5432/ny_taxi')

df_iter = pd.read_csv('~/data-engineering-zoomcamp/ny_taxi_raw/yellow_tripdata_2021-01.csv', iterator=True, chunksize=100000)


df = next(df_iter)


df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)


df.head(n=0).to_sql(name='yellow_taxi_data', con=engine, if_exists='replace')


df.to_sql(name='yellow_taxi_data', con=engine, if_exists='append')


# Assuming df_iter is already defined as an iterator, e.g., using pd.read_csv with chunksize.
while True:
    t_start = time()  # Record the start time

    try:
        # Fetch the next chunk of data
        df = next(df_iter)

        # Convert datetime columns
        df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
        df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

        # Insert data into the SQL table
        df.to_sql(name='yellow_taxi_data', con=engine, if_exists='append')

        t_end = time()  # Record the end time

        # Output performance details
        print('Inserted another chunk, took %.3f seconds' % (t_end - t_start))

    except StopIteration:
        # Handle the exception when the iterator is exhausted
        print('All data has been processed.')
        break




