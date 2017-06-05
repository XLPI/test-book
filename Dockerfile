FROM debian:jessie
MAINTAINER Alex Korchagin  "alexperit@gmail.com"

# Packages
RUN apt-get update && \
    apt-get install -y --force-yes --no-install-recommends openjdk-7-jdk mongodb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# MongoDB files
RUN mkdir -p /data/db
VOLUME ["/data/db"]

# Service
ADD target/scala-2.10/test-book-assembly-1.0.jar /bs.jar

# Default command
ENV DB_DBNAME books
ENV DB_COLLECTION books
ADD run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]

EXPOSE 8080
