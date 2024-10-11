pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: '83b53aca-cccd-40ef-acfd-5a3fe9a18eaa', url: 'https://github.com/Durgathulluru/insurance_project'
            }
        }
        stage('Vault and Terraform Operations') {
            steps {
                withVault(
                    configuration: [
                        disableChildPoliciesOverride: false,
                        timeout: 60,
                        vaultCredentialId: '96d3bbc7-aca7-4ebf-917c-529fbc311805', // Ensure this matches the ID of your Secret Text credential
                        vaultUrl: 'http://34.226.38.215:8200'
                    ],
                    vaultSecrets: [
                        [path: 'secret/aws_key', secretValues: [[vaultKey: 'aws_key']]],
                        [path: 'secret/aws_pass', secretValues: [[vaultKey: 'aws_pass']]],
                        [path: 'secret/db_credentials', secretValues: [[vaultKey: 'POSTGRES_USER'], [vaultKey: 'POSTGRES_PASSWORD']]]
                    ]
                ) {
                    script {
                        // Set environment variables for Terraform
                        withEnv(["VAULT_TOKEN=${env.VAULT_TOKEN}"]) {
                            // Test Vault
                            sh 'echo $aws_key'
                            // Terraform commands
                            sh 'terraform init'
                            sh 'terraform plan'
                            sh 'terraform apply --auto-approve'
                        }
                    }
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
