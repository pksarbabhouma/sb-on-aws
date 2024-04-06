FROM maven:3.9.6-eclipse-temurin-17 AS MAVEN_BUILD
WORKDIR /build
COPY pom.xml ./
COPY src ./src
RUN mvn clean package

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=MAVEN_BUILD /build/target/hello-app.jar ./app.jar
EXPOSE 8500
ENTRYPOINT ["java", "-jar", "app.jar"]

