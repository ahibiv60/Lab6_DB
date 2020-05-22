#!/bin/bash
# Docker script

rm -rf lab6-dir

docker container stop lab6-container
docker container stop mysql-container
docker container rm lab6-container
docker container rm mysql-container
docker image rm lab6-img

mkdir lab6-dir

cd lab6-dir/
git clone "https://github.com/ahibiv60/Lab6_DB"

docker run -d -p 3306:3306 --name mysql-container -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=Spodaryk_db mysql

cd Lab6_DB
mvn install clean package
docker build -t lab6-img .
docker run -p 8080:8080 --name lab6-container --link mysql-container:mysql lab6-img | grep ERROR

rm -rf ../../lab6-dir
echo "Done"

