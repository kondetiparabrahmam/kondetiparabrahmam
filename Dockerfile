# Use the official OpenJDK image as the base
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the WAR file into the container at /app
COPY target/01-maven-web-app.war /app/

# Expose the port the app runs on
EXPOSE 9090

# Define the command to run your application
CMD ["java", "-jar", "01-maven-web-app.war"]
