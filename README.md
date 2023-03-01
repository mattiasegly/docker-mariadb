# rpi-mariadb
Docker Container for MariaDB.<BR>
Multi-arch build using balena's Raspberry Pi image and docker's official Debian image.

Example for use with Nextcloud, run with:<BR>
docker run -d --name someappdb \\\
-p 3306:3306
-v /some/path:/var/lib/mysql \\\
-e MYSQL_ROOT_PASSWORD=superhardpassword \\\
-e MYSQL_DATABASE=somedbname \\\
-e MYSQL_USER=somedbuser \\\
-e MYSQL_PASSWORD=anotherreallyhardpassword \\\
mattiasegly/rpi-mariadb:latest --transaction-isolation=READ-COMMITTED --log-bin=mysqld-bin --binlog-format=ROW

I know nothing about code, so assume that everything here sets the world on fire.<BR>
Use at your own peril.
