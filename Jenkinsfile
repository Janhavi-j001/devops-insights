pipeline {
    agent any

    tools {
        nodejs "Node18"
    }

    environment {
        IMAGE_NAME = "janhavi001/devops-insights"
        IMAGE_TAG = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
        IMAGE = "${IMAGE_NAME}:${IMAGE_TAG}"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-creds',
                    url: 'https://github.com/Janhavi-j001/devops-insights.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test -- --passWithNoTests'
            }
        }

        stage('Docker Login, Build & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker build -t $IMAGE .
                        docker push $IMAGE
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    docker stop devops-insights || true
                    docker rm devops-insights || true
                    docker run -d -p 5000:5000 --name devops-insights $IMAGE
                '''
            }
        }
    }
}
