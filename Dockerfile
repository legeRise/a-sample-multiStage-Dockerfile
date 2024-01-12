FROM python:3.8.6-slim AS builder

WORKDIR /djangoApp
COPY requirements.txt .
RUN python -m venv env92 &&  . env92/bin/activate  && pip install -r requirements.txt 
COPY . .
ENV PATH='/djangoApp/env92/bin:$PATH'

RUN python manage.py makemigrations && python manage.py migrate && python manage.py collectstatic


FROM python:3.8.6-slim

WORKDIR /djangofinalApp
COPY --from=builder /djangoApp/ /djangofinalApp/
ENV PATH='/djangofinalApp/env92/bin:$PATH'
EXPOSE 80
CMD ["python","manage.py","runserver","0.0.0.0:80"]






