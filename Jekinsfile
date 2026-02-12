pipeline {
    agent any

    stages {

        stage('Clone Repo') {
            steps {
                checkout scm
            }
        }

        stage('Deploy Frontend') {
            steps {
                sh '''
                cd ansible
                ansible-playbook -i inventory deploy-frontend.yml
                '''
            }
        }

    }
}
