all: build

build:
	docker build -t local/lychee:3.1.3-php-fpm5.6 .

run:
	docker run --name lychee-db -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=lychee -e MYSQL_USER=lychee -e MYSQL_PASSWORD=lychee -itd nutsllc/toybox-mariadb
	docker run --name lychee-fpm -v /usr/share/nginx/html --link lychee-db -e DB_HOST=lychee-db -e DB_USER=lychee -e DB_PASSWORD=lychee -e DB_NAME=lychee -e TOYBOX_UID=1234 -e TOYBOX_GID=9876 -itd local/lychee:3.1.3-php-fpm5.6
	docker run --volumes-from=lychee-fpm --link lychee-db --link lychee-fpm -e PHP_FPM_HOST=lychee-fpm:9000 -p 8080:80 -itd nutsllc/toybox-nginx:1.11-alpine
