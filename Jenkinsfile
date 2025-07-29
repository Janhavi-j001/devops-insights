pipeline {
    agent any

    tools {
        nodejs "Node18"  // Make sure this tool is configured in Jenkins
    }

    environment {
        IMAGE_NAME = "janhavi001/devops-insights"
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
                dir('src') {
                    sh 'npm install'
                }
            }
        }

        stage('Run Tests') {
            steps {
                echo '✅ Skipping tests for now...'
            }
        }

        stage('Docker Login, Build & Push') {
            steps {
                script {
                    // Get the short Git commit hash
                    def IMAGE_TAG = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                    env.IMAGE_TAG = IMAGE_TAG
                    env.IMAGE = "${env.IMAGE_NAME}:${IMAGE_TAG}"
                    echo "🔖 Using image tag: ${env.IMAGE_TAG}"
                }

                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker build -t $IMAGE .
                        docker push $IMAGE
                    '''
                }
            }
        }

        stage('Cleanup Old Docker Images') {
            steps {
                echo '🧹 Cleaning up dangling Docker images...'
                sh 'docker image prune -f'
            }
        }

        stage('Ansible Deploy') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ansible-ssh-key', keyFileVariable: 'SSH_KEY')]) {
                    withEnv(["GIT_COMMIT=${env.IMAGE_TAG}"]) {
                        sh '''
                            ssh-keyscan -H 52.66.27.98 >> ~/.ssh/known_hosts
                            ansible-playbook -i ansible/hosts.ini ansible/deploy.yml --private-key $SSH_KEY
                        '''
                    }
                }
            }
        }
    }
}
