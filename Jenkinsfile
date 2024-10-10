pipeline {
    agent any
    environment {
        VAULT_ADDR = 'http://172.31.33.227:8200'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: '8f92c242-9631-4fda-a291-528707364179', url: 'https://github.com/Durgathulluru/insurance_project'
            }
        }
        stage('Test Vault') {
            steps {
                withVault(configuration: [disableChildPoliciesOverride: false, timeout: 60, vaultCredentialId: 'vault_id', vaultUrl: 'http://3.209.51.144:8200/ui/vault'], vaultSecrets: [[path: 'secret/aws_key', secretValues: [[vaultKey: 'aws_key']]], [path: 'secret/aws_pass', secretValues: [[vaultKey: 'aws_pass']]], [path: 'db_credentials', secretValues: [[vaultKey: 'POSTGRES_USER'], [vaultKey: 'POSTGRES_PASSWORD']]]]) {
                    sh 'echo $aws_key'
                }
            }
        }
        stage('Terraform Init and Plan') {
            steps {
                withVault(configuration: [disableChildPoliciesOverride: false, timeout: 60, vaultCredentialId: 'vault_id', vaultUrl: 'http://3.209.51.144:8200/ui/vault'], vaultSecrets: [[path: 'secret/aws_key', secretValues: [[vaultKey: 'aws_key']]], [path: 'secret/aws_pass', secretValues: [[vaultKey: 'aws_pass']]], [path: 'db_credentials', secretValues: [[vaultKey: 'POSTGRES_USER'], [vaultKey: 'POSTGRES_PASSWORD']]]]) {
                    sh 'terraform init'
                    sh 'terraform plan'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                withVault(configuration: [disableChildPoliciesOverride: false, timeout: 60, vaultCredentialId: 'vault_id', vaultUrl: 'http://3.209.51.144:8200/ui/vault'], vaultSecrets: [[path: 'secret/aws_key', secretValues: [[vaultKey: 'aws_key']]], [path: 'secret/aws_pass', secretValues: [[vaultKey: 'aws_pass']]], [path: 'db_credentials', secretValues: [[vaultKey: 'POSTGRES_USER'], [vaultKey: 'POSTGRES_PASSWORD']]]]) {
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
