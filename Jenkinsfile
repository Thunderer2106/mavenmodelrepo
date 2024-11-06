pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-java-app'  // Name of your Docker image
        DOCKER_REGISTRY = ''          // Your Docker registry URL, leave empty if not using private registry
    }

    stages {
        // 1. Checkout Code
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Thunderer2106/mavenmodelrepo.git'
            }
        }

        // 2. Build with Maven
        stage('Build with Maven') {
            steps {
                script {
                    // Run Maven build steps: clean, compile, test, and package
                    sh 'mvn clean compile'
                    sh 'mvn test'
                    sh 'mvn package -DskipTests'
                }
            }
        }

        // 3. Build Docker Image
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image based on the Dockerfile
                    sh 'docker build -t ${DOCKER_IMAGE}:latest .'
                }
            }
        }

        // 4. Deploy Docker Container
        stage('Deploy Docker Container') {
            steps {
                script {
                    // Run the Docker container from the built image
                    sh 'docker run -d -p 8080:8080 ${DOCKER_IMAGE}:latest'
                }
            }
        }
    }

    post {
        always {
            // Clean up: remove unused containers and images after pipeline completion
            sh 'docker container prune -f'
            sh 'docker image prune -f'
        }

        success {
            // Send notification or take action on success
            echo 'Build and deployment successful!'
        }

        failure {
            // Take action on failure, e.g., send an email notification
            echo 'Build or deployment failed!'
        }
    }
}
