FROM balenalib/rpi-raspbian:buster
RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y --no-install-recommends \
	pwgen \
	socat \
	gosu \
	mariadb-server \
&& rm -rf /var/lib/apt/lists/*

RUN echo "Configuring..." && \ 
# comment out any "user" entires in the MySQL config ("docker-entrypoint.sh" or "--user" will handle user switching)
	sed -ri 's/^user\s/#&/' /etc/mysql/my.cnf /etc/mysql/conf.d/* && \
# purge and re-create /var/lib/mysql with appropriate ownership
	rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
	chmod 777 /var/run/mysqld && \
# comment out a few problematic configuration values
	find /etc/mysql/ -name '*.cnf' -print0 \
		| xargs -0 grep -lZE '^(bind-address|log)' \
		| xargs -rt -0 sed -Ei 's/^(bind-address|log)/#&/' && \
# don't reverse lookup hostnames, they are usually another container
	echo '[mysqld]\nskip-host-cache\nskip-name-resolve' > /etc/mysql/conf.d/docker.cnf

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && \
	mkdir /docker-entrypoint-initdb.d && \
	ln -s usr/local/bin/docker-entrypoint.sh /

RUN [ "cross-build-end" ]

VOLUME /var/lib/mysql
EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
