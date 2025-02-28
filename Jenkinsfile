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
                sh 'docker run -d -p 8181:8181 --name go_app my-go-app'
            }
        }
        
        stage('Check Healthy Container') {
            steps {
                sh 'curl http://localhost:8181/whoami'
            }
        }
        
        stage('Create Namespace Dev') {
            steps {
                sh 'kubectl create namespace dev || true' // Évite une erreur si le namespace existe déjà
            }
        }
        
        stage('Create Namespace Prod') {
            steps {
                sh 'kubectl create namespace prod || true'
            }
        }
        
        stage('Deploy to Minikube (Dev)') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml -n dev'
            }
        }
        
        stage('Deploy to Minikube (Prod)') {
            steps {
                sh 'kubectl apply -f k8s/production-deployment.yaml -n prod'
            }
        }
       
        stage('Deploy to Production') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                sh 'kubectl apply -f k8s/production-deployment.yaml -n prod'
            }
        }
    }
}
