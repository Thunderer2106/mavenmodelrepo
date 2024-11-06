// pipeline {
//     agent any

//     environment {
//         DOCKER_IMAGE = 'my-java-app'  // Name of your Docker image
//         DOCKER_REGISTRY = ''          // Your Docker registry URL, leave empty if not using private registry
//     }

//     stages {
//         // 1. Checkout Code
//         stage('Checkout Code') {
//             steps {
//                 git branch: 'master', url: 'https://github.com/Thunderer2106/mavenmodelrepo.git'
//             }
//         }

//         // 2. Build with Maven
//         stage('Build with Maven') {
//             steps {
//                 script {
//                     // Run Maven build steps: clean, compile, test, and package
//                     sh 'mvn clean compile'
//                     sh 'mvn test'
//                     sh 'mvn package -DskipTests'
//                 }
//             }
//         }

//         // 3. Build Docker Image
//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     // Build the Docker image based on the Dockerfile
//                     sh 'docker build -t ${DOCKER_IMAGE}:latest .'
//                 }
//             }
//         }

//         // 4. Deploy Docker Container
//         stage('Deploy Docker Container') {
//             steps {
//                 script {
//                     // Run the Docker container from the built image
//                     sh 'docker run -d -p 8080:8080 ${DOCKER_IMAGE}:latest'
//                 }
//             }
//         }
//     }

//     post {
//         always {
//             // Clean up: remove unused containers and images after pipeline completion
//             sh 'docker container prune -f'
//             sh 'docker image prune -f'
//         }

//         success {
//             // Send notification or take action on success
//             echo 'Build and deployment successful!'
//         }

//         failure {
//             // Take action on failure, e.g., send an email notification
//             echo 'Build or deployment failed!'
//         }
//     }
// }


pipeline {
    agent any

    environment {
        // Define Docker image and registry name
        DOCKER_IMAGE = 'my-java-app'
        DOCKER_REGISTRY = '' // Specify your Docker registry (if required)
    }

    stages {
        // Stage 1: Checkout code from Git
        stage('Checkout Code') {
            steps {
                // Clone the Git repository
                git branch: 'master', url: 'https://github.com/Thunderer2106/mavenmodelrepo.git'
                
            }
        }

        // Stage 2: Build Java Project with Maven
        stage('Build with Maven') {
            steps {
                script {
                    // Run Maven commands to compile, test, and package the Java project
                    sh 'mvn clean compile'
                    sh 'mvn test'
                    sh 'mvn package -DskipTests'
                }
            }
        }

        // Stage 3: Build Docker Image
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile in the root directory
                    sh 'docker build -t ${DOCKER_IMAGE}:latest .'
                }
            }
        }

        // Stage 4: Deploy Docker Container
        stage('Deploy Docker Container') {
            steps {
                script {
                    // Run the Docker container in detached mode and expose port 8080
                    sh 'docker run -d -p 8080:8081 ${DOCKER_IMAGE}:latest'
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker containers and images after the build is complete
            sh 'docker container prune -f'
            sh 'docker image prune -f'
        }

        success {
            // Optional: Notify on successful build (e.g., send an email or Slack message)
            echo 'Build and deployment completed successfully!'
        }

        failure {
            // Optional: Notify on failed build
            echo 'Build failed. Please check the logs for errors.'
        }
    }
}

