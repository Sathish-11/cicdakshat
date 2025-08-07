pipeline {
    agent any
    stages {
        stage('Build Maven') {
            steps {
                git url: 'https://github.com/Sathish-11/cicdakshat.git', branch: "master"
                sh 'mvn clean install'
            }
        }
        stage('Debug Branch') {
            steps {
                script {
                    echo "DEBUG: env.GIT_BRANCH = ${env.GIT_BRANCH}"
                    sh 'git branch'
                    sh 'git rev-parse --abbrev-ref HEAD'
                }
            }
        }
        stage('Build Docker image') {
            steps {
                script {
                    sh 'docker build -t sathish1102/april302025project:v1 .'
                }
            }
        }
        stage('Docker login & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-login', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh "echo \$PASS | docker login -u \$USER --password-stdin"
                    sh 'docker push sathish1102/april302025project:v1'
                }
            }
        }
        stage('Deploy to k8s') {
            when { expression { env.GIT_BRANCH == 'master' } }
            steps {
                script {
                    kubernetesDeploy(configs: 'deploymentservice.yaml', kubeconfigId: 'k8sconfigpwd')
                }
            }
        }
    }
}
