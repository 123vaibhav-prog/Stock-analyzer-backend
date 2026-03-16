# Stage 1: Build the application using a maintained Maven image
FROM maven:3.8.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the application using the recommended replacement image
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Ensure this matches the jar name generated in your target folder
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
