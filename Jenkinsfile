pipeline {

    agent any

    parameters {
        choice(
            name: 'Environment',
            choices: ['dev', 'qa', 'uat', 'prod'],
            description: 'Select the environment'
        )

        choice(
            name: 'Terraform_Action',
            choices: ['init', 'plan', 'apply', 'destroy'],
            description: 'Select the Terraform action'
        )
    }

    environment {
        AWS_REGION = 'ap-south-1'
        AWS_DEFAULT_REGION = 'ap-south-1'
    }

    stages {

        stage('Terraform Init') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-credentials']
                ]) {
                    sh '''
                        echo "========================================"
                        echo "Terraform Init"
                        echo "Environment: ${Environment}"
                        echo "========================================"

                        terraform init -reconfigure \
                            -backend-config="key=ecs-infrastructure/${Environment}/terraform.tfstate"
                    '''
                }
            }
        }

        stage('Terraform Validate') {
            when {
                expression {
                    params.Terraform_Action == 'plan' ||
                    params.Terraform_Action == 'apply'
                }
            }

            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-credentials']
                ]) {
                    sh '''
                        echo "========================================"
                        echo "Terraform Validate"
                        echo "========================================"

                        terraform validate
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            when {
                expression {
                    params.Terraform_Action == 'plan'
                }
            }

            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-credentials']
                ]) {
                    sh '''
                        echo "========================================"
                        echo "Terraform Plan"
                        echo "Environment: ${Environment}"
                        echo "========================================"

                        terraform plan \
                            -var-file="environments/${Environment}.tfvars"
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression {
                    params.Terraform_Action == 'apply'
                }
            }

            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-credentials']
                ]) {
                    sh '''
                        echo "========================================"
                        echo "Terraform Apply"
                        echo "Environment: ${Environment}"
                        echo "========================================"

                        terraform apply \
                            -var-file="environments/${Environment}.tfvars" \
                            -auto-approve
                    '''
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression {
                    params.Terraform_Action == 'destroy'
                }
            }

            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-credentials']
                ]) {
                    sh '''
                        echo "========================================"
                        echo "Terraform Destroy"
                        echo "Environment: ${Environment}"
                        echo "========================================"

                        terraform destroy \
                            -var-file="environments/${Environment}.tfvars" \
                            -auto-approve
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Terraform ${params.Terraform_Action} completed successfully for ${params.Environment}"
        }

        failure {
            echo "Terraform ${params.Terraform_Action} failed for ${params.Environment}"
        }

        always {
            cleanWs()
        }
    }
}
