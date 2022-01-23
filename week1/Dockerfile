FROM python:3.9.1

RUN apt-get install wget
RUN pip install pandas sqlalchemy psycopg2

WORKDIR /app
COPY ingest-nytaxi-data.py ingest-nytaxi-data.py 

ENTRYPOINT [ "python", "ingest-nytaxi-data.py" ]