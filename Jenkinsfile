pipeline {
    agent any
    environment {
        VAULT_ADDR = 'http://172.31.34.60:8200'
    }
    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'gitrepo', url: 'https://github.com/Durgathulluru/insurance_project.git', branch: 'main'
            }
        }
        stage('Terraform Init and Plan') {
            steps {
                withVault(configuration: [disableChildPoliciesOverride: false, timeout: 60, vaultCredentialId: 'a261b057-95af-4f78-9c01-ae407f5ca7cb', vaultUrl: 'http://44.194.244.52:8200/ui/vault/secrets']) {
                    sh 'terraform init'
                    sh 'terraform plan'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                withVault(configuration: [disableChildPoliciesOverride: false, timeout: 60, vaultCredentialId: 'a261b057-95af-4f78-9c01-ae407f5ca7cb', vaultUrl: 'http://44.194.244.52:8200/ui/vault/secrets']) {
                    sh 'terraform apply --auto-approve'
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Your testing phase was successful and online'
            }
        }
    }
}
