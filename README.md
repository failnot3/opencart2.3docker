#EN

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

---------------------

#BG

 opencart2.3docker
Разгъни OpenCart V2.3.0.2 чрез Docker

## OpenCart Docker изображение
Това Docker изображение предоставя готова за употреба среда за изпълнение на OpenCart, отворена електронна търговия платформа с отворен код. То настройва уеб сървър Apache с PHP и инсталира всички необходими зависимости за изпълнение на OpenCart.

### Възможности
1. Използва базово изображение Debian Buster Slim.
2. Инсталира Apache, PHP и други необходими пакети.
3. Изтегля и разархивира зададената версия на OpenCart.
4. Конфигурира Apache и PHP за изпълнение на OpenCart.

#### Използване
За да използвате това Docker изображение, можете да го deploy-нете локално.

**Local Deploy**

Клонирайте хранилището:
```bash
git clone https://github.com/failnot3/opencart2.3docker
```
Отидете в директорията на клонирания проект:

```bash
cd <repository_directory>
```
Docker build в текущата директория:

```bash
docker build -t opencart-image .
```

### Конфигурация на Docker Compose
Тази конфигурация на Docker Compose дефинира набор от услуги за изпълнение - OpenCart, включително база данни MySQL, phpMyAdmin и FileBrowser.

#### Услуги
- **opencart**: Услугата OpenCart създава изображението на OpenCart, използвайки зададения Dockerfile. Излага порт 80 на контейнера, който се отразява на порт 8566 на хост машината. Тя зависи от услугата "mysql" и задава името на MySQL хоста на "mysql". Данните на OpenCart се монтират в контейнера чрез "opencart_data".

- **mysql**: Услугата MySQL използва Docker изображението за MySQL 5.7. Задава името на хоста на "mysql" и дефинира променливи на средата за root паролата на MySQL, името на базата данни, потребителя и паролата. Данните на MySQL се съхраняват в "mysql_data".

- **phpmyadmin**: Услугата phpMyAdmin използва Docker изображението за phpMyAdmin. Отразява порт 80 на контейнера на порт 8080 на хост машината. Задава MySQL хоста на "mysql" и задава потребителското име и паролата за phpMyAdmin.

- **filebrowser**: Услугата FileBrowser използва Docker изображението за FileBrowser. Отразява порт 80 на контейнера на порт 8081 на хост машината. Монтира се "filebrowser_data" за съхранение на данни на FileBrowser. Също така монтира "opencart_data" за достъп до файловете на OpenCart и  "mysql_data" за достъп до данните на MySQL.

#### Volumes
- **mysql_data**: Този volume се създава за съхранение на данните на MySQL. Той се монтира към директорията "/var/lib/mysql" в услугата MySQL и директорията "/srv/mysql" в услугата FileBrowser.

- **filebrowser_data**: Този volume се създава за съхранение на данните на FileBrowser. Той се монтира към директорията "/srv" в услугата FileBrowser.

- **opencart_data**: Този volume се създава за съхранение на данните на OpenCart. Той се монтира към директорията "/var/www/html" в услугата OpenCart и директорията "/srv/opencart" в услугата FileBrowser.

Моля, обърнете внимание, че паролите и потребителските имена, посочени в тази конфигурация, са примери и трябва да бъдат заменени със защитени идентификационни данни в производствена среда.

За да изпълните приложението:
```bash
docker-compose up -d
```

След това можете да достъпите OpenCart, като отворите http://localhost:8566 във вашия уеб браузър.

# За разработчици

## Конфигурация
- Версия на OpenCart: 2.3.0.2
- Настройки на уеб сървъра Apache: Намират се в /etc/apache2/
- Настройки на PHP: Намират се в /etc/php/7.3/apache2/php.ini
