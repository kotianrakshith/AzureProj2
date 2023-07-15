FROM openjdk:8-jdk-alpine
COPY C:\agent\_work\1\s\target\*.jar app.jar
EXPOSE 8989
ENTRYPOINT ["java","-jar","/app.jar"]

