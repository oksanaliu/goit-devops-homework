FROM python:3.9-slim

WORKDIR /app

RUN echo "print('Mock Django App Started')" > manage.py

RUN pip install django

COPY . .

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]