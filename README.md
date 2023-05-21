# opencart2.3docker
Deploy OpenCart V2.3.0.2 via Docker

## OpenCart Docker Image
This Docker image provides a ready-to-use environment for running OpenCart, an open-source e-commerce platform. It sets up an Apache web server with PHP and installs all the necessary dependencies for running OpenCart.

### Features
1. Uses the Debian Buster Slim base image.
2. Installs Apache, PHP, and other required packages.
3. Downloads and extracts the specified version of OpenCart.
4. Configures Apache and PHP for running OpenCart.

##### Usage
To use this Docker image, you can build it locally or pull it from a container registry.

Building the Image Locally
Clone the repository:

```bash
git clone https://github.com/failnot3/opencart2.3docker
```
Change to the cloned directory:

```bash
cd <repository_directory>
```
Build the Docker image:

```bash
docker build -t opencart-image .
```

### Docker Compose Configuration
This Docker Compose configuration defines a set of services for running an OpenCart e-commerce application along with a MySQL database, phpMyAdmin, and FileBrowser.

#### Services
- opencart: The OpenCart service builds the OpenCart image using the specified Dockerfile. It exposes port 80 of the container, which is mapped to port 8566 on the host machine. It depends on the "mysql" service and sets the MySQL hostname to "mysql". The Opencart data is mounted to the container using the "opencart_data" volume.

- mysql: The MySQL service uses the MySQL 5.7 Docker image. It sets the hostname to "mysql" and defines environment variables for the MySQL root password, database name, user, and password. The MySQL data is stored in the "mysql_data" volume.

- phpmyadmin: The phpMyAdmin service uses the phpMyAdmin Docker image. It maps port 80 of the container to port 8080 on the host machine. It sets the MySQL hostname to "mysql" and specifies the phpMyAdmin username and password.

- filebrowser: The FileBrowser service uses the FileBrowser Docker image. It maps port 80 of the container to port 8081 on the host machine. It mounts the "filebrowser_data" volume for storing FileBrowser data. It also mounts the "opencart_data" volume to access Opencart files and the "mysql_data" volume to access MySQL data.

#### Volumes
- mysql_data: This volume is created to store MySQL data. It is mounted to the "/var/lib/mysql" directory in the MySQL service and the "/srv/mysql" directory in the FileBrowser service.

- filebrowser_data: This volume is created to store FileBrowser data. It is mounted to the "/srv" directory in the FileBrowser service.

- opencart_data: This volume is created to store Opencart data. It is mounted to the "/var/www/html" directory in the Opencart service and the "/srv/opencart" directory in the FileBrowser service.

Please note that the passwords and usernames specified in this configuration are examples and should be replaced with secure credentials in a production environment.

Running the whole package:
```
docker-compose up -d
```

You can then access OpenCart by navigating to http://localhost:8566 in your web browser.

# For developers

## Configuration
- OpenCart version: 2.3.0.2
- Apache web server configuration: Located in /etc/apache2/
- PHP configuration: Located in /etc/php/7.3/apache2/php.ini

