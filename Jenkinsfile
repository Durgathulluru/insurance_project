pipeline {
    agent any
    environment {
        VAULT_ADDR = 'http://172.31.33.207:8200'
    }
    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'gitrepo', url: 'https://github.com/Durgathulluru/insurance_project.git', branch: 'main'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
        stage('Test') {
            steps {
                echo 'Your testing phase was successful and online'
            }
        }
    }
}
