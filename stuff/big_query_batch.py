import os
from google.cloud import bigquery
client = bigquery.Client()

# define some variables ahead of time
path = '/Users/naqiyamoti/Downloads/new_votivate_uploads' # folder where your CSVs are, shouldn't have other files in there if it can be avoided
schema = 'scratch' # whichever schema u want... main?


def write_table(file_path, schema, table):

    table_id = f'proj-tmc-mem-wfp.{schema}.{table}'

    job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.CSV, 
        skip_leading_rows=1, 
        autodetect=True, 
        allow_quoted_newlines=True, 
        write_disposition='WRITE_TRUNCATE'
    )

    with open(file_path, "rb") as source_file:
        job = client.load_table_from_file(source_file, table_id, job_config=job_config)

    job.result()  # Waits for the job to complete.
    table = client.get_table(table_id)  # Make an API request.
    print(f"Loaded {table.num_rows} rows and {len(table.schema)} columns to {table_id}")

def main():

    for file in os.listdir(path):
        table = f"{file.replace('.csv','')}" # removes ".csv" from name, this will be the table name
        file_path = f'{path}/{file}'

        print(f'Attempting table {table}')
    
        try: 
            write_table(file_path, schema, table)
        except: 
            print(f'{table} didn\'t work :^(')

if __name__ == '__main__':
    main()