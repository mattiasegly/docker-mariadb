# rpi-mariadb
Raspberry Pi Docker Container for MariaDB<BR>

Multiarch build using balena's Raspberry Pi image and docker's official Debian image.<BR>
Running with tag :latest should work on all Raspberry Pi models and standard 64-bit hardware.

Example for use with Nextcloud, run with:<BR>
docker run -d --name someappdb \\\
-p 3306:3306
-v /some/path:/var/lib/mysql \\\
-e MYSQL_ROOT_PASSWORD=superhardpassword \\\
-e MYSQL_DATABASE=somedbname \\\
-e MYSQL_USER=somedbuser \\\
-e MYSQL_PASSWORD=anotherreallyhardpassword \\\
mattiasegly/rpi-mariadb:latest --transaction-isolation=READ-COMMITTED --log-bin=mysqld-bin --binlog-format=ROW
  
I know nothing about code, so assume that everything here sets the world on fire. Use at your own peril.

20201014
