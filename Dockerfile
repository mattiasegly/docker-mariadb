ARG ARCH=
ARG SOURCE_BRANCH=
FROM mattiasegly/base-image:${SOURCE_BRANCH}-${ARCH}

RUN apt-get update && apt-get install -y --no-install-recommends \
	pwgen \
	socat \
	gosu \
	mariadb-server \
	mariadb-backup \
&& rm -rf /var/lib/apt/lists/*

RUN echo "Configuring..." && \ 
# purge and re-create /var/lib/mysql with appropriate ownership
	rm -rf /var/lib/mysql; \
	mkdir -p /var/lib/mysql /var/run/mysqld; \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld; \
# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
	chmod 777 /var/run/mysqld; \
# comment out a few problematic configuration values
	find /etc/mysql/ -name '*.cnf' -print0 \
		| xargs -0 grep -lZE '^(bind-address|log|user\s)' \
		| xargs -rt -0 sed -Ei 's/^(bind-address|log|user\s)/#&/'; \
# don't reverse lookup hostnames, they are usually another container
	printf "[mariadb]\nhost-cache-size=0\nskip-name-resolve\n" > /etc/mysql/mariadb.conf.d/05-skipcache.cnf; \
# Issue #327 Correct order of reading directories /etc/mysql/mariadb.conf.d before /etc/mysql/conf.d (mount-point per documentation)
	if [ -L /etc/mysql/my.cnf ]; then \
# 10.5+
		sed -i -e '/includedir/ {N;s/\(.*\)\n\(.*\)/\n\2\n\1/}' /etc/mysql/mariadb.cnf; \
	fi

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && \
	mkdir /docker-entrypoint-initdb.d && \
	ln -s usr/local/bin/docker-entrypoint.sh /

VOLUME /var/lib/mysql
EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
