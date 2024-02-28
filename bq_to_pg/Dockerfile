FROM python:3.12-slim

RUN pip install --upgrade pip

WORKDIR /code

COPY . .

RUN pip install -r requirements.txt

COPY .env.docker ./.env

ENV GOOGLE_APPLICATION_CREDENTIALS=./.gcp_service_account_key.json

# CMD ["python3", "async_etl.py"]
CMD ["python3", "etl.py"]
