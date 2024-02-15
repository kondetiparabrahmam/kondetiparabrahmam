Certainly! Here's the complete Jenkins pipeline script that builds a Maven project, Dockerizes it, and pushes the Docker image to a Docker registry:

groovy
pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_IMAGE = '01-maven-web-app'
        DOCKER_USERNAME = 'bannukondeti'
        DOCKER_PASSWORD = 'Docker@123'
    }
    
    stages {
        stage('Build') {
            steps {
                // Checkout source code from Git repository
                git 'https://github.com/kondetiparabrahmam/kondetiparabrahmam.git'
                
                // Build Maven project
                sh 'mvn clean package'
            }
        }
        
        stage('Dockerize') {
            steps {
                // Authenticate with Docker registry
                sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_REGISTRY"
                
                // Build Docker image
                sh "docker build -t $DOCKER_IMAGE ."
                
                // Tag Docker image
                sh "docker tag $DOCKER_IMAGE $DOCKER_REGISTRY/$DOCKER_USERNAME/$DOCKER_IMAGE"
                
                // Push Docker image to registry
                sh "docker push $DOCKER_REGISTRY/$DOCKER_USERNAME/$DOCKER_IMAGE"
            }
        }
    }
    
    post {
        success {
            // Print success message
            echo 'Docker image build and push successful!'
        }
        failure {
            // Print failure message
            echo 'Docker image build and push failed!'
        }
    }
}
