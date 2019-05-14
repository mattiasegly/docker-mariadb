# docker-rpi-mariadb
Raspberry Pi Docker Container for MariaDB<BR>
Work in progress. Limited use case. Personal implementation of MariaDB.

For testing and troubleshooting, run with:<BR>
docker run -d --name someappdb \\\
-p 3306:3306
-v /some/path:/var/lib/mysql \\\
-e MYSQL_ROOT_PASSWORD=superhardpassword \\\
-e MYSQL_DATABASE=somedbname \\\
-e MYSQL_USER=somedbuser \\\
-e MYSQL_PASSWORD=anotherreallyhardpassword \\\
mattiasegly/rpi-mariadb:latest --transaction-isolation=READ-COMMITTED --binlog-format=ROW
  
I know nothing about code, so assume that everything here sets the world on fire. Use at your own peril.
