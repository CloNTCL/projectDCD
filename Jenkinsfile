pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'my-go-app'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/ST2DCE/project'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-go-app .'
            }
        }
        stage('Run Unit Tests') {
            steps {
                sh 'go test ./... || true' // Ajoute tes tests Go ici
            }
        }
        stage('Deploy to Local Docker') {
            steps {
                sh 'docker run -d -p 8080:8080 --name go_app my-go-app'
            }
        }
        stage('Deploy to Minikube') {
            steps {
                sh 'eval $(minikube docker-env)'
                sh 'docker build -t my-go-app .'
                sh 'minikube image load my-go-app'
                sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }
        stage('Test Deployment') {
            steps {
                script {
                    def response = sh(script: "curl -s http://$(minikube service go-app-service --url)/whoami", returnStdout: true).trim()
                    if (!response.contains("Tristan Mendes Voufo")) {
                        error "Test failed: Response doesn't contain expected output"
                    }
                }
            }
        }
        stage('Deploy to Production') {
            when {
                expression { return currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                sh 'kubectl apply -f k8s/production-deployment.yaml'
            }
        }
    }
}
