pipeline {

    agent any


    environment {

        IMAGE="blackroth/hrms"

    }


    stages {


        stage('Checkout') {

            steps {

                git branch: 'main',
                    url: 'https://github.com/MounikaVakacharlla/HRMS-Portal'

            }

        }



        stage('Install') {

    steps {

        sh '''

        python3 -m venv venv

        . venv/bin/activate

        pip install --upgrade pip

        pip install -r requirements.txt

        pip install flake8

        '''

    }

}



        stage('Testing') {

            parallel {


                stage('Unit Test') {

                    steps {

                        sh '''

                        . venv/bin/activate

                        python manage.py test

                        '''

                    }

                }



                stage('Lint') {
                    steps {
                    sh '''
                    . venv/bin/activate
                    flake8 . --exclude=venv
                    '''
                        
                    }
                    
                }


            }

        }



        stage('Docker Build') {

            steps {

                sh '''

                docker build -t ${IMAGE}:${BUILD_NUMBER} .

                '''

            }

        }



        stage('Deploy') {
            steps {
                sh 'docker-compose up -d'
            
            }
            
        }


    }


}
