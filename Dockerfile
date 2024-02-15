Certainly! Here's a Dockerfile for Dockerizing a Maven Spring Boot application:

Dockerfile
# Use a base image with Maven and Java installed
FROM maven:3.8.4-openjdk-11-slim AS builder

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the Maven project
RUN mvn clean package

# Use a lightweight base image for the application
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the compiled JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the port the application runs on
EXPOSE 8080

# Run the Spring Boot application when the container starts
CMD ["java", "-jar", "app.jar"]


In this Dockerfile:

- We use a multi-stage build approach for efficiency. The first stage (builder) uses a Maven base image to compile the Maven project, while the second stage uses a lightweight Java base image to run the Spring Boot application.
- We set the working directory to /app.
- We copy the pom.xml and src directory into the container.
- We run mvn clean package to build the Maven project and generate the JAR file.
- We switch to the second stage (openjdk:11-jre-slim) and set the working directory again.
- We copy the compiled JAR file from the builder stage into the current working directory.
- We expose port 8080, which is typically the port
