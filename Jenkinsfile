pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: '8f92c242-9631-4fda-a291-528707364179', url: 'https://github.com/Durgathulluru/insurance_project'
            }
        }
        stage('Vault and Terraform Operations') {
            steps {
                withVault(
                    configuration: [
                        disableChildPoliciesOverride: false,
                        timeout: 60,
                        vaultCredentialId: '3eb4ece4-7890-4359-9100-20b17ae8df2c',
                        vaultUrl: 'http://3.209.51.144:8200'
                    ],
                    vaultSecrets: [
                        [path: 'secret/aws_key', secretValues: [[vaultKey: 'aws_key']]],
                        [path: 'secret/aws_pass', secretValues: [[vaultKey: 'aws_pass']]],
                        [path: 'secret/db_credentials', secretValues: [[vaultKey: 'POSTGRES_USER'], [vaultKey: 'POSTGRES_PASSWORD']]]
                    ]
                ) {
                    stage('Test Vault') {
                        steps {
                            sh 'echo $aws_key'
                        }
                    }
                    stage('Terraform Init and Plan') {
                        steps {
                            sh 'terraform init'
                            sh 'terraform plan'
                        }
                    }
                    stage('Terraform Apply') {
                        steps {
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
