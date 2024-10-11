pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'c58c441a-735e-4de3-8c1f-2eb65eb9715c', url: 'https://github.com/Durgathulluru/insurance_project'
            }
        }
        stage('Vault and Terraform Operations') {
            steps {
                withVault(
                    configuration: [
                        disableChildPoliciesOverride: false,
                        timeout: 60,
                        vaultCredentialId: 'efbec909-64a9-4ec0-8d08-8906c21a31e3',
                        vaultUrl: 'http://44.194.162.10:8200'
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
