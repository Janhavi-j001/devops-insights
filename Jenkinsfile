pipeline {
  agent any

  environment {
    GIT_COMMIT = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
    IMAGE = "janhavi001/devops-insights:${GIT_COMMIT}"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/Janhavi-j001/devops-insights.git'
      }
    }

    stage('Build & Push Docker Image') {
      steps {
        sh './scripts/build_and_push.sh'
      }
    }
  }
}
