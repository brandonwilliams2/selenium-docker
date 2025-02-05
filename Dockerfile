# Base image
FROM openjdk:8u191-jre-alpine

RUN apk add curl jq

# Image workspace
WORKDIR /usr/share/java-selenium

# Add .jar from host to image workspace
ADD target/java-selenium.jar            java-selenium.jar
ADD target/java-selenium-tests.jar      java-selenium-tests.jar
ADD target/libs                         libs

# Add suite files from host to image workspace
ADD 1-book-flight-feature.xml           1-book-flight-feature.xml
ADD 2-search-feature.xml                2-search-feature.xml

# ADD health check script
ADD healthcheck.sh                      healthcheck.sh

#Add any other dependency like .csv/ .json / .xls / etc.

# Entry point = the default command to run when the container starts up
ENTRYPOINT sh healthcheck.sh
