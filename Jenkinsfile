pipeline {
        // put trigger here //
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
        stage('Pull Latest Image') {
            steps {
                script {
                    sh 'docker pull ${DOCKER_IMAGE}:latest || true'
                }
            }
        }
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
        stage('Deploy Image') {
            steps {
                script {
                    try {
                        sh '''
                            docker pull ${DOCKER_IMAGE}:latest
                            docker stop my-python-app || true
                            docker rm my-python-app || true
                            docker run -d --name my-python-app -p 5000:5000 ${DOCKER_IMAGE}:latest
                        '''
                    } catch (Exception e) {
                        sh 'docker logs my-python-app || true'
                        throw e
                    }
                }
            }
        }
    }
}
