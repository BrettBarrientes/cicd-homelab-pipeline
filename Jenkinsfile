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
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                        sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
                        docker.withRegistry('https://index.docker.io/v1/') {
                            docker.image("${DOCKER_IMAGE}:latest").push('latest')
                        }
                    }
                }
            }
        }
    }
}


