pipeline {
  agent any

  environment {
    GIT_COMMIT = "${env.GIT_COMMIT}"
    IMAGE = "janhavi001/devops-insights:${GIT_COMMIT}"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'develop', url: 'https://github.com/Janhavi-j001/devops-insights.git'
      }
    }

    stage('Build & Push Docker Image') {
      steps {
        sh './scripts/build_and_push.sh'
      }
    }

    stage('Terraform Apply') {
      steps {
        dir('infra') {
          sh 'terraform init'
          sh 'terraform apply -auto-approve'
        }
      }
    }

    stage('Ansible Deploy') {
      steps {
        withEnv(["GIT_COMMIT=${env.GIT_COMMIT}"]) {
          sh 'ansible-playbook -i ansible/hosts.ini ansible/deploy.yml'
        }
      }
    }
  }
}
