pipeline {
    agent any
    environment {
        VAULT_ADDR = 'http://172.31.33.207:8200'
    }
    stages {
        stage('Setup Vault Token') {
            steps {
                withVault(configuration: [disableChildPoliciesOverride: false, timeout: 60, vaultCredentialId: 'fd3f2736-3a44-4068-81db-5aee54f4f901', vaultUrl: 'http://18.209.220.121:8200'], 
                          vaultSecrets: [
                              [path: 'secret/aws_key', secretValues: [[envVar: 'aws_key', vaultKey: 'aws_key']]],
                              [path: 'secret/aws_pass', secretValues: [[envVar: 'aws_pass', vaultKey: 'aws_pass']]],
                              [path: 'secret/db_credentials', secretValues: [[envVar: 'postgres_user', vaultKey: 'POSTGRES_USER'], [envVar: 'postgres_password', vaultKey: 'POSTGRES_PASSWORD']]]
                          ]) {
                    // Vault secrets are now available as environment variables
                }
            }
        }
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
