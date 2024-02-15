pipeline {
    agent any
    
    environment {
        // Define environment variables
        DOCKER_REGISTRY = 'your-docker-registry-url'
        IMAGE_NAME = 'your-application-image'
        KUBE_NAMESPACE = 'your-kubernetes-namespace'
        KUBE_DEPLOYMENT = 'your-deployment-name'
    }
    
    stages {
        stage('Build') {
            steps {
                // Checkout source code from Git repository
                git 'https://github.com/your/repo.git'
                
                // Build Maven project
                sh 'mvn clean package'
            }
        }
        
        stage('Dockerize') {
            steps {
                // Build Docker image
                sh 'docker build -t $DOCKER_REGISTRY/$IMAGE_NAME:$BUILD_NUMBER .'
                
                // Push Docker image to registry
                sh 'docker push $DOCKER_REGISTRY/$IMAGE_NAME:$BUILD_NUMBER'
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                // Apply Kubernetes deployment configuration
                sh "sed -i 's#{{DOCKER_IMAGE}}#$DOCKER_REGISTRY/$IMAGE_NAME:$BUILD_NUMBER#g' kubernetes/deployment.yaml"
                sh "kubectl apply -f kubernetes/deployment.yaml -n $KUBE_NAMESPACE"
            }
        }
        
        stage('Cleanup') {
            steps {
                // Delete old Docker images
                sh "docker image prune -f"
                
                // Delete old Kubernetes deployments
                sh "kubectl delete deployment $KUBE_DEPLOYMENT -n $KUBE_NAMESPACE"
            }
        }
    }
    
    post {
        success {
            // Print success message
            echo 'Deployment successful!'
        }
        failure {
            // Print failure message
            echo 'Deployment failed!'
        }
        always {
            // Cleanup workspace
            cleanWs()
        }
    }
}
