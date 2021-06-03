FROM python:3.9-buster

WORKDIR /app

COPY ./requirements.txt ./
RUN pip install -r requirements.txt

COPY ./kindergartent ./

EXPOSE 8000/tcp

CMD ["gunicorn", "kindergarten.wsgi:application", "--bind", "0.0.0.0:8000"]
