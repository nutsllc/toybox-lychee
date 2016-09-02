## What is the Lychee

>Lychee is a free photo-management tool, which runs on your server or web-space. Installing is a matter of seconds. Upload, manage and share photos like from a native application. Lychee comes with everything you need and all your photos are stored securely.

[Lychee official site](https://lychee.electerious.com/) | [Live Demo](http://ld.electerious.com/)

## Docker Compose example

```
lychee:
	image: nutsllc/toybox-lychee:3.1.2
	links:
		- mariadb:mariadb
	volumes:
		- "./.data:/data"
		- "./.data/uploads/big:/uploads/big"
		- "./.data/uploads/medium:/uploads/medium"
		- "./.data/uploads/thumb:/uploads/thumb"
		- "./.data/uploads/import:/uploads/import"	ports:
		- "8080:80"

mariadb:
	image: nutsllc/toybox-mariadb:10.1.14
	volumes:
		- "./.data/mysql:/var/lib/mysql"
	environment:
		MYSQL_ROOT_PASSWORD: root
		MYSQL_DATABASE: lychee
		MYSQL_USER: lychee
		MYSQL_PASSWORD: lychee
		TOYBOX_UID: 1000
		TOYBOX_GID: 1000
		TERM: xterm
	ports:
		- "3306"
```