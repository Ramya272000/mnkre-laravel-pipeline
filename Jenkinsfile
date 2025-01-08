pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main'
            }
        }
        stage('Build Laravel Application') {
            steps {
                sh 'composer install'
                sh 'npm install && npm run production'
            }
        }
        stage('Run Unit Tests') {
            steps {
                sh 'php artisan test'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t mnkre-laravel-app:latest .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([url: 'https://index.docker.io/v1/', credentialsId: 'docker-hub-credentials']) {
                    sh 'docker push mnkre-laravel-app:latest'
                }
            }
        }
    }
}
