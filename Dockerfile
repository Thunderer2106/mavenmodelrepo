pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-java-app' // Name for the Docker image     
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Clone the Git repository
                git branch: 'master', url: 'https://github.com/Thunderer2106/mavenmodelrepo.git'
            }
        }

        stage('Build with Maven') {
            steps {
                script {
                    // Run Maven commands to compile, test, and package
                    sh 'mvn clean compile'
                    sh 'mvn test'
                    sh 'mvn package -DskipTests'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from Dockerfile
                    sh 'docker build -t ${DOCKER_IMAGE}:latest .'
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    // Run the Docker container
                    sh 'docker run -d -p 8080:8080 ${DOCKER_IMAGE}:latest'
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker containers and images after the build
            sh 'docker container prune -f'
            sh 'docker image prune -f'
        }
    }
}
