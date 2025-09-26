pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "docker.io"
        APP_NAME = "node-sample-app"
        DOCKER_USER = credentials('docker-username') // Jenkins credential ID
        DOCKER_PASS = credentials('docker-password') // Jenkins credential ID
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

        stage('Docker Login') {
            steps {
                sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    def imageTag = "${DOCKER_REGISTRY}/${DOCKER_USER}/${APP_NAME}:${env.GIT_COMMIT}"
                    def latestTag = "${DOCKER_REGISTRY}/${DOCKER_USER}/${APP_NAME}:latest"

                    sh """
                        docker buildx create --use || true
                        docker buildx build \
                          --platform linux/amd64,linux/arm64 \
                          -t ${imageTag} \
                          -t ${latestTag} \
                          --push .
                    """
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
                    ${DOCKER_REGISTRY}/${DOCKER_USER}/${APP_NAME}:latest
                """
            }
        }
    }
}
