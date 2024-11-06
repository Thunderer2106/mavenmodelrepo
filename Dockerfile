# pipeline {
#     agent any

#     environment {
#         DOCKER_IMAGE = 'my-java-app' // Name for the Docker image     
#     }

#     stages {
#         stage('Checkout Code') {
#             steps {
#                 // Clone the Git repository
#                 git branch: 'master', url: 'https://github.com/Thunderer2106/mavenmodelrepo.git'
#             }
#         }

#         stage('Build with Maven') {
#             steps {
#                 script {
#                     // Run Maven commands to compile, test, and package
#                     sh 'mvn clean compile'
#                     sh 'mvn test'
#                     sh 'mvn package -DskipTests'
#                 }
#             }
#         }

#         stage('Build Docker Image') {
#             steps {
#                 script {
#                     // Build Docker image from Dockerfile
#                     sh 'docker build -t ${DOCKER_IMAGE}:latest .'
#                 }
#             }
#         }

#         stage('Deploy Docker Container') {
#             steps {
#                 script {
#                     // Run the Docker container
#                     sh 'docker run -d -p 8080:8080 ${DOCKER_IMAGE}:latest'
#                 }
#             }
#         }
#     }

#     post {
#         always {
#             // Clean up Docker containers and images after the build
#             sh 'docker container prune -f'
#             sh 'docker image prune -f'
#         }
#     }
# }
# Stage 1: Build stage with Maven
FROM maven:3.8.1-openjdk-11 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and install dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the source code into the container
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Runtime stage with OpenJDK (lightweight image)
FROM openjdk:11-jre-slim

# Set the working directory in the runtime container
WORKDIR /app

# Copy the compiled JAR file from the build stage
# COPY --from=build /app/target/my-java-app-1.0-SNAPSHOT.jar /app/my-java-app.jar

COPY --from=build /app/target/MyJavaApp-1.0-SNAPSHOT.jar /app/my-java-app.jar


# Command to run the application
CMD ["java", "-jar", "/app/my-java-app.jar"]

# Expose the application port (optional, adjust if needed)
# EXPOSE 8080
