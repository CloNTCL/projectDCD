pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'my-go-app'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/CloNTCL/projectDCD/'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-go-app .'
            }
        }
        
        stage('Deploy to Local Docker') {
            steps {
                sh 'docker run -d -p 8081:8081 --name go_app my-go-app'
            }
        }
        
        stage('Deploy to Minikube') {
            steps {
                // sh 'eval $(minikube docker-env)'
                // sh 'docker build -t my-go-app .'
                // sh 'minikube image load my-go-app'
                sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }
       
        stage('Deploy to Production') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                sh 'kubectl apply -f k8s/production-deployment.yaml'
            }
        }
    } // 
} // 
