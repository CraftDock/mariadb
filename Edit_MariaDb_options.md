# Edit MariaDb options in docker or docker-compose

Modifying the default options for the docker MariaDb server is essential. The default options are too conservative and even for simple  use case.
For example, modifying only one or two of the default InnoDB configuration options may lead to boosting multiple times faster execution of SQL queries.

Here are three simple ways to modify the (default or current) MariaDb my.cnf configuration options:

- **Command-line arguments.** All MariaDb configuration options could be overriden by passing them in the command line of mysqld binary. The format is:

```
--variable-name=value
```

and the variable names could be obtained by

```
mysqld --verbose --help
```

and for the live configuration options:

```
mysqladmin variables
```

- **Options in a additional configuration file**, which will be included in the main configuration. The options in **/etc/mysql/conf.d/config-file**.cnftake precedence.

- **Replacing the default my.cnf configuration file** – **/etc/mysql/my.cnf**.

Do not forget to check out also the official docker hub page – https://hub.docker.com/_/mariadb.


## **OPTION 1: Command-line arguments.**
This is the simplest way of modifying the default my.cnf (the one, which comes with the docker image or this in the current docker image file). It is fast and easy to use and change, just a little bit of much writing in the command-line. As mentioned above all MariaDb options could be changed by a command-line argument to the mysqld binary. For example:

```
mysqld --innodb_buffer_pool_size=1024M
```

It will start MariaDb server with variable innodb_buffer_pool_size set to 1G. Translating it to (for multiple options just add them at the end of the command):

- **docker run** 

```dockerfile
docker run -i --name my-mariadb -v /var/lib/mysql:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=111111 \
    -d dsuite/mariadb \
    --innodb_buffer_pool_size=1024M \
    --innodb_read_io_threads=4
```

```
docker exec -it my-mariadb mysqladmin -p111111 variables|grep innodb_buffer_pool_size
```

```
| innodb_buffer_pool_size                                  | 1073741824
```

- docker-compose:

```
# Docker MariaDb arguments example
version: '3.8'
 
services:
  db:
    image: dsuite/mariadb
    command: --innodb_buffer_pool_size=1024M --innodb_read_io_threads=4 
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: 111111
    volumes:
     - /var/lib/mysql_data:/var/lib/mysql
    ports:
      - "3306:3306"
```

Here is how to run it (the above text file should be named docker-compose.yml and the file should be in the current directory when executing the command below):

```
docker-compose up
```

```
docker exec -it my-mariadb mysqladmin -p111111 variables|grep innodb_buffer_pool_size
```

```
| innodb_buffer_pool_size                                  | 1073741824
```

## **OPTION 2: Options in a additional configuration file.**

Create a MariaDb option file with name config-file.cnf:

```
[mysqld]
innodb_buffer_pool_size=1024M
innodb_read_io_threads=4
```


- **docker run** 

```dockerfile
docker run --name my-mariadb \
    -v /var/lib/mysql_data:/var/lib/mysql \
    -v /etc/mysql/docker-instances/config-file.cnf:/etc/mysql/conf.d/config-file.cnf \
    -e MYSQL_ROOT_PASSWORD=111111 \
    -d dsuite/mariadb
```

- **docker-compose** 

```
version: '3.8'
 
services:
  db:
    container_name: my-mariadb
    image: dsuite/mariadb
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: 111111
    volumes:
     - /var/lib/mysql_data:/var/lib/mysql
     - ./config-file.cnf:/etc/mysql/conf.d/config-file.cnf
    ports:
      - "3306:3306"
```

## **OPTION 3: Replacing the default my.cnf configuration file.**

Add the modified options to a **my.cnf** template file and map it to the container on **/etc/mysql/my.cnf**. When overwriting the main MariaDb option file – **my.cnf** you may map the whole **/etc/mysql** directory (just replace **/etc/mysql/my.cnf** with **/etc/mysql** below), too. The source file (or directory) may be any file (or directory) not the **/etc/mysql/my.cnf** (or Replacing the default my.cnf configuration file)

- **docker run** 

```dockerfile
docker run --name my-mariadb \
    -v /var/lib/mysql_data:/var/lib/mysql \
    -v /etc/mysql/my.cnf:/etc/mysql/my.cnf \
    -e MYSQL_ROOT_PASSWORD=111111 \
    -d dsuite/mariadb
```

- **docker-compose** 

```
version: '3.8'
 
services:
  db:
    container_name: my-mariadb
    image: dsuite/mariadb
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: 111111
    volumes:
     - /var/lib/mysql_data:/var/lib/mysql
     - ./mysql/my.cnf:/etc/mysql/my.cnf
    ports:
      - "3306:3306"
```
