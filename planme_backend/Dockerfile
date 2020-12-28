FROM python:3
RUN mkdir /app
WORKDIR /app
COPY requirements.txt /app/
RUN pip install -U -r requirements.txt
COPY . /app/
EXPOSE 5000
CMD ["python", "app.py"]
