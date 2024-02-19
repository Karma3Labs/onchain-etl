FROM python:3.12-slim

RUN pip install --upgrade pip

WORKDIR /code

COPY . .

RUN pip install -r requirements.txt

CMD ["python3", "python3 async_etl.py"]
