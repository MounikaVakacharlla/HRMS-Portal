pipeline {

    agent any


    stages {


        stage('Checkout') {

            steps {

                echo "Building branch ${env.BRANCH_NAME}"

                checkout scm

            }

        }



        stage('Install Dependencies') {

            steps {

                sh """

                pip install -r requirements.txt

                """

            }

        }



        stage('Test') {

            steps {

                sh """

                python manage.py test

                """

            }

        }



        stage('Build') {

            steps {

                echo "Build completed for ${env.BRANCH_NAME}"

            }

        }


    }



    post {


        success {

            echo "SUCCESS: ${env.BRANCH_NAME}"

        }


        failure {

            echo "FAILED: ${env.BRANCH_NAME}"

        }


    }


}