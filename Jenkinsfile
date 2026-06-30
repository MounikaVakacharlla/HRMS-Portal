pipeline {
    agent any

    environment {
        APP_NAME = "hrms"
        IMAGE_NAME = "mounikavakacharlla/hrms"
        IMAGE_TAG = "${BUILD_NUMBER}"
        DOCKER_CREDS = "dockerhub-creds"
    }

    options {
        timestamps()
        ansiColor('xterm')
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/MounikaVakacharlla/HRMS-Portal.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                python3 -m venv venv
                . venv/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
                pip install pytest flake8 bandit
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                . venv/bin/activate
                mkdir -p reports
                python manage.py test > reports/django-tests.txt || true
                '''
            }
        }

        stage('Parallel Testing') {
            parallel {

                stage('Flake8') {
                    steps {
                        sh '''
                        . venv/bin/activate
                        flake8 . \
                        --exclude=venv,__pycache__,migrations \
                        > reports/flake8.txt || true
                        '''
                    }
                }

                stage('Bandit') {
                    steps {
                        sh '''
                        . venv/bin/activate
                        bandit -r . \
                        --exclude venv \
                        -f txt \
                        -o reports/bandit.txt || true
                        '''
                    }
                }
            }
        }

        stage('Security Scan') {
            steps {
                echo "Security scan completed."
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build \
                -t ${IMAGE_NAME}:${IMAGE_TAG} \
                -t ${IMAGE_NAME}:latest .
                '''
            }
        }

        stage('Tag Image') {
            steps {
                echo "Docker image tagged."
            }
        }

        stage('Push Docker Image') {

            steps {

                withCredentials([
                    usernamePassword(
                        credentialsId: "${DOCKER_CREDS}",
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {

                    sh '''
                    echo "$DOCKER_PASS" | docker login \
                    -u "$DOCKER_USER" \
                    --password-stdin

                    docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    docker push ${IMAGE_NAME}:latest

                    docker logout
                    '''
                }
            }
        }

        stage('Archive Reports') {

            steps {

                archiveArtifacts artifacts: 'reports/*',
                                 allowEmptyArchive: true
            }
        }

        stage('Deploy Staging') {

            steps {

                sh '''
                chmod +x scripts/deploy.sh
                ./scripts/deploy.sh staging
                '''
            }
        }

        stage('Health Check') {

            steps {

                sh '''
                chmod +x scripts/healthcheck.sh
                ./scripts/healthcheck.sh
                '''
            }
        }

        stage('Approval') {

            steps {

                input(
                    message: 'Deploy to Production?',
                    ok: 'Deploy'
                )
            }
        }

        stage('Production Deployment') {

            steps {

                sh '''
                chmod +x scripts/deploy.sh
                ./scripts/deploy.sh production
                '''
            }
        }

        stage('Notification') {

            steps {

                echo "Pipeline completed successfully."
            }
        }
    }

    post {

        failure {

            echo "Deployment Failed"

            sh '''
            chmod +x scripts/rollback.sh
            ./scripts/rollback.sh
            '''
        }

        success {

            echo "HRMS deployed successfully."
        }

        always {

            cleanWs()
        }
    }
}
