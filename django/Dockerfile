FROM python:3.9-slim
WORKDIR /app
RUN pip install django
RUN django-admin startproject mysite .
RUN sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \['*'\]/" mysite/settings.py
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
