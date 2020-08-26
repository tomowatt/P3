FROM ballerina/ballerina:1.2.7 as build-jar

USER root
WORKDIR /build
COPY /src .

RUN ballerina build -o app app.bal 

FROM ballerina/jre8:v1

WORKDIR /app/src
COPY --from=build-jar /build .

CMD java -jar app.jar
