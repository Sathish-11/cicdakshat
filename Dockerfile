FROM eclipse-temurin:21-jre-alpine AS builder
WORKDIR /app
COPY mvnw .
COPY .mvn .mvn/
COPY pom.xml /app/
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B
COPY src /app/src
RUN ./mvnw clean package -DskipTests -B
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar /app/app.jar
EXPOSE 8085
ENTRYPOINT ["java","-jar","/app/app.jar"]

