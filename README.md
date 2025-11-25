# Django Restful CRUD API with MySQL example

For more detail, please visit:
> [Django CRUD with MySQL example | Django Rest Framework](https://bezkoder.com/django-crud-mysql-rest-framework/)

Full-stack CRUD App:
> [Django + Vue.js](https://bezkoder.com/django-vue-js-rest-framework/)

> [Django + React.js](https://bezkoder.com/django-react-axios-rest-framework/)

> [Django + Angular](https://bezkoder.com/django-angular-10-crud-rest-framework/)

## Running the Application

Install MySQL:
```
sudo apt-get update && sudo apt-get install mysql-server
```

Install Python 3 and dependencies:
```
cd ~/Downloads/
wget https://www.python.org/ftp/python/3.12.7/Python-3.12.7.tgz
tar -xzf Python-3.12.7.tgz
cd Python-3.12.7
./configure --enable-optimizations --prefix=/usr/local/python312
make -j4
sudo make altinstall
pip install pymysql
pip install "django>=4.0,<5.0"
pip install "djangorestframework<3.0,>=2.0"
```

Create the DB tables first:
```
python clean_tables.py
python manage.py migrate
```
Run the development web server:
```
python manage.py runserver 0.0.0.0:8080
```
Open the URL http://localhost:8080/ to access the application.

## JMeter

Run JMeter
```
./run-jmeter.sh -Jhost=127.0.0.1 -Jport=8080
```

Additional options:
```
-JtotalThreads=10 -JrampTimeSecs=300 -JtestTimeSecs=10800
```

