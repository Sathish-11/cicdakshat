pipeline {
    agent any
    env {
        DOCKER_IMG=sathish1102/springapp:v1
    }

    stages {
        stage ('Git Checkout') {
            steps{
              script {
                git branch: 'feature-1', 'https://github.com/Sathish-11/cicdakshat.git'
              }
            }
        }
        stage ('Maven Clean & Install Package') {
            steps{
              script {
                sh 'mvn clean install'
              }
            }
        }
        stage ('Build Stage') {
            steps {
              script {
                sh 'docker build -t ${DOCKER-IMG} .'
              }
            }
        }
        stage ('Docker Login and Push into repo') {
            steps{
              withCredentials([usernamePassword(credentialsId: 'dockerhub-pwd', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                sh "docker push $DOCKER_IMG"
              }
            }
        }
        stage ('Deploy to k8s') {
            steps {
              script {
                kubernetesDeploy configs: '', kubeConfig: [path: ''], kubeconfigId: 'k8sconfigpwd', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
                sh "kubectl get all -n dev"
              }
            }
        }
    }
    post {
        success {
            archiveArtifacts artifacts: 'target/*.jar', followSymlinks: false
        }
    }
}

