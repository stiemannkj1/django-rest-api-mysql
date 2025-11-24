#!/bin/bash

pip3.12 install django-cors-headers
pip3.12 install mysql
pip3.12 install pymysql
pip3.12 install "django<5.0,>=4.0"
pip3.12 install "djangorestframework<4.0,>=3.0"

curl http://localhost:8080/api/tutorials/1 -X GET
curl http://localhost:8080/api/tutorial -X POST -H "Content-Type: application/json" -d '{"title": "Django Tut #2", "description": "Tut#2 Description"}'
