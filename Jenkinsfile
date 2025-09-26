pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "docker.io"
        DOCKER_USERNAME = "chniteesh71"
        APP_NAME = "node-sample-app"
    }

    tools {
        nodejs 'Node24'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                dir('src') {
                    sh 'npm ci'
                }
            }
        }

        stage('Lint') {
            steps {
                dir('src') {
                    sh 'npm run lint'
                }
            }
        }

        stage('Test') {
            steps {
                dir('src') {
                    sh 'npm test'
                }
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-creds') {
                        def img = docker.build("${APP_NAME}:${env.GIT_COMMIT}", ".")
                        img.push()
                        img.push("latest")
                    }
                }
            }
        }

        stage('Scan with Trivy') {
            steps {
                sh """
                  docker run --rm \
                    -v /var/run/docker.sock:/var/run/docker.sock \
                    aquasec/trivy:latest image \
                    --exit-code 1 --severity HIGH,CRITICAL \
                    ${DOCKER_REGISTRY}/${DOCKER_USERNAME}/${APP_NAME}:latest
                """
            }
        }
    }
}
