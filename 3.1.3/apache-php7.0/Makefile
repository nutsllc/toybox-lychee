all: build

build:
	docker build -t local/lychee:3.1.3-apache-php7.0 .

run:
	docker run --name lychee-db -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=lychee -e MYSQL_USER=lychee -e MYSQL_PASSWORD=lychee -itd nutsllc/toybox-mariadb
	docker run --link lychee-db -p 8080:80 -e DB_HOST=lychee-db -e DB_USER=lychee -e DB_PASSWORD=lychee -e DB_NAME=lychee -e TOYBOX_UID=1234 -e TOYBOX_GID=9876 -itd local/lychee:3.1.3-apache-php7.0
