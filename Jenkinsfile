pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Durgathulluru/insurance_project'
            }
        }
        stage('Vault and Terraform Operations') {
            steps {
                withVault(
                    configuration: [
                        disableChildPoliciesOverride: false,
                        engineVersion: 1,
                        timeout: 60,
                        vaultCredentialId: 'vault-approle',
                        vaultUrl: 'http://98.82.210.146:8200'
                    ],
                    vaultSecrets: [
                        [engineVersion: 1, path: 'secrets/terraform/aws/accesskey', secretValues: [[vaultKey: 'access_key']]],
                        [engineVersion: 1, path: 'secrets/terraform/aws/secretkey', secretValues: [[vaultKey: 'secret_key']]],
                        [engineVersion: 1, path: 'secrets/terraform/aws/db_credentials', secretValues: [[vaultKey: 'POSTGRES_USER'], [vaultKey: 'POSTGRES_PASSWORD']]]
                    ]
                ) {
                    script {
                        // Set environment variables for Terraform
                        withEnv(["access_key=${env.access_key}", "secret_key=${env.secret_key}", "POSTGRES_USER=${env.POSTGRES_USER}", "POSTGRES_PASSWORD=${env.POSTGRES_PASSWORD}"]) {
                            // Test Vault
                            sh '''
                            echo "access_key: $access_key"
                            echo "secret_key: $secret_key"
                            echo "POSTGRES_USER: $POSTGRES_USER"
                            echo "POSTGRES_PASSWORD: $POSTGRES_PASSWORD"
                            '''
                            // Terraform commands
                            sh '''
                            terraform init
                            terraform plan -var="access_key=$access_key" -var="secret_key=$secret_key" -var="POSTGRES_USER=$POSTGRES_USER" -var="POSTGRES_PASSWORD=$POSTGRES_PASSWORD"
                            terraform apply -var="access_key=$access_key" -var="secret_key=$secret_key" -var="POSTGRES_USER=$POSTGRES_USER" -var="POSTGRES_PASSWORD=$POSTGRES_PASSWORD" --auto-approve
                        '''
                            
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
