# Use a stable version of Debian or Alpine as the base image
FROM alpine

# Install MariaDB and dependencies
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Configure MariaDB to not run as root
RUN useradd -r -s /bin/false mariadb

# Expose the default MariaDB port
EXPOSE 4241

# Set up environment variables for MariaDB
ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=password
ENV MYSQL_DATABASE=wordpress

# Copy my custom MariaDB configuratin maybe later
# COPY ./conf/my.cnf /etc/mysql/my.cnf

# Command to run MariaDB server
CMD ["mysqld"]
