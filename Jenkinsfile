pipeline {
    agent {
        docker {
            image 'docker:stable'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('bbarrientes-dockerhub')
        DOCKER_IMAGE = 'bbarrientes/my-python-app'
    }

    stages {
        stage('Build Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE}:latest .'
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'bbarrientes-dockerhub', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                        sh '''
                            echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin
                            docker push ${DOCKER_IMAGE}:latest
                        '''
                    }
                }
            }
        }
    }
}




