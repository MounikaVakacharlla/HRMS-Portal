pipeline {

    agent any


    stages {


        stage('Install Dependencies') {
            steps {
                sh '''
                python3 -m venv venv
                . venv/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }



        stage('Parallel Testing') {


            parallel {



                stage('Django Tests') {


                    steps {


                        echo "Running Django Tests"


                        sh '''
                        pytest > reports/django-test-report.txt
                        '''


                    }


                }




                stage('Flake8 Code Quality') {


                    steps {


                        echo "Running Flake8"


                        sh '''
                        flake8 . > reports/flake8-report.txt || true
                        '''


                    }


                }





                stage('Bandit Security Scan') {


                    steps {


                        echo "Running Bandit Security Scan"


                        sh '''
                        bandit -r . -f txt -o reports/bandit-report.txt || true
                        '''


                    }


                }


            }


        }





        stage('Collect Reports') {


            steps {


                echo "Collecting Reports"


                archiveArtifacts artifacts: 'reports/*', allowEmptyArchive: true


            }


        }


    }


}// pipeline {

//     agent any


//     environment {

//         IMAGE="blackroth/hrms"

//     }


//     stages {


//         stage('Checkout') {

//             steps {

//                 git branch: 'main',
//                     url: 'https://github.com/MounikaVakacharlla/HRMS-Portal'

//             }

//         }



//         stage('Install') {

//     steps {

//         sh '''

//         python3 -m venv venv

//         . venv/bin/activate

//         pip install --upgrade pip

//         pip install -r requirements.txt

//         pip install flake8

//         '''

//     }

// }



//         stage('Testing') {

//             parallel {


//                 stage('Unit Test') {

//                     steps {

//                         sh '''

//                         . venv/bin/activate

//                         python manage.py test

//                         '''

//                     }

//                 }



//                 stage('Lint') {
//                     steps {
//                     sh '''
//                     . venv/bin/activate
//                     flake8 . --exclude=venv
//                     '''
                        
//                     }
                    
//                 }


//             }

//         }



//         stage('Docker Build') {

//             steps {

//                 sh '''

//                 docker build -t ${IMAGE}:${BUILD_NUMBER} .

//                 '''

//             }

//         }



//         stage('Deploy') {
//             steps {
//                 sh 'docker-compose up -d'
            
//             }
            
//         }


//     }


// }
