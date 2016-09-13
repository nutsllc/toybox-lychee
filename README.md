# Lychee on Docker

A Dockerfile for deploying a [Lychee](https://lychee.electerious.com/) which is a web based photo-management tool using Docker container.

This image is registered to the [Docker Hub](https://hub.docker.com/r/nutsllc/toybox-lychee/) which is the official docker image registory.

In addition, this image is compatible with [ToyBox](https://github.com/nutsllc/toybox) complytely to manage the applications on Docker.

## What is the Lychee

>Lychee is a free photo-management tool, which runs on your server or web-space. Installing is a matter of seconds. Upload, manage and share photos like from a native application. Lychee comes with everything you need and all your photos are stored securely.

* [official site](https://lychee.electerious.com/)
* [official live Demo](http://ld.electerious.com/)

## Docker Compose example

Lychee needs to have a database at backend to store photo data, meta data and so on. So you must define two containers. One is the Lychee container another one is the MySQL（MariaDB）container.

Example is below.

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
		- "./.data/uploads/import:/uploads/import"
	ports:
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

Open your web browser and access to ``http://<Hostname(IP Address)>:8080``. Then sign-in with initial account. username: ``toybox`` password: ``toybox``

## License

* Lychee - MIT

## Contributing

We'd love for you to contribute to this container. You can request new features by creating an [issue](https://github.com/nutsllc/toybox-lychee/issues), or submit a [pull request](https://github.com/nutsllc/toybox-lychee/pulls) with your contribution.