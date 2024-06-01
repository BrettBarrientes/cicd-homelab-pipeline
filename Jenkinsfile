pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('bbarrientes-dockerhub')
        DOCKER_IMAGE = 'bbarrientes/my-python-app'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        docker.image("${DOCKER_IMAGE}:latest").push('latest')
                    }
                }
            }
        }
    }
}

