# Stage 1: Build the application
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src
# Build the jar file (skipping tests to save time)
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM openjdk:17-jdk-slim
WORKDIR /app
# Copy the built jar from the first stage
COPY --from=build /app/target/*.jar app.jar
# Expose the port (matches your application.properties)
EXPOSE 8080
# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
