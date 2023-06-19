# syntax=docker/dockerfile:1
FROM ubuntu:22.04


WORKDIR /app

# install app dependencies
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip install flask==2.2.3
RUN pip install click==8.1.3
RUN pip install itsdangerous==2.1.2
RUN pip install Jinja2==3.1.2
RUN pip install MarkupSafe==2.1.2
RUN pip install python-dotenv==1.0.0
RUN pip install Werkzeug==2.2.3
RUN pip install psycopg2-binary


# install app
COPY . /app

# final configuration
ENV FLASK_APP=app

ENV SESSION_SECRET_KEY_DEV = 'ea8e4cbe796b22bb92000a9e'

ENV DB_USERNAME=postgres
ENV DB_PASSWORD=admin123

EXPOSE 5000

CMD ["python3", "app.py"]