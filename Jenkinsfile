
pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-jenkins-website'
        CONTAINER_NAME = 'my-website'
        HOST_PORT = '8081'
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Getting source code from GitHub'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Building Docker image'

                bat 'docker build -t %IMAGE_NAME%:%BUILD_NUMBER% .'

                bat 'docker tag %IMAGE_NAME%:%BUILD_NUMBER% %IMAGE_NAME%:latest'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying website'

                bat 'docker rm -f %CONTAINER_NAME% 2>NUL || exit /b 0'

                bat 'docker run -d --name %CONTAINER_NAME% -p %HOST_PORT%:80 %IMAGE_NAME%:latest'
            }
        }

        stage('Test') {
            steps {
                echo 'Testing deployed website'

                bat 'powershell -NoProfile -Command "$r = Invoke-WebRequest -Uri http://localhost:%HOST_PORT% -UseBasicParsing; if ($r.StatusCode -ne 200) { exit 1 }; Write-Host $r.StatusCode"'
            }
        }
    }

    post {
        success {
            echo 'SUCCESS: CI/CD Pipeline completed!'
        }

        failure {
            echo 'ERROR: CI/CD Pipeline failed!'
        }
    }
}
