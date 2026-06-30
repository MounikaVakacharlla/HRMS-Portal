pipeline {


agent any


environment {

IMAGE_NAME="hrms-app"

VERSION="1.0"

}



stages {



stage('Git Checkout') {


steps {


echo "Checking out source code"

checkout scm


}


}




stage('Install Dependencies') {


steps {


sh '''

python3 -m venv venv

. venv/bin/activate

pip install -r requirements.txt


'''


}


}




stage('Unit Tests') {


steps {


sh '''

. venv/bin/activate

pytest || true


'''


}


}




stage('Security Scan') {


steps {


sh '''

bandit -r . --exclude venv || true


'''


}


}




stage('Docker Build') {


steps {


sh '''

docker build -t $IMAGE_NAME:$VERSION .


'''


}


}




stage('Docker Push') {


steps {


echo "Pushing Docker image"


sh '''

echo "docker push command here"

# docker push $IMAGE_NAME:$VERSION


'''


}


}




stage('Deploy to Staging') {


steps {


echo "Deploying to Staging"


sh '''

docker run -d \
--name staging-container \
-p 8000:8000 \
$IMAGE_NAME:$VERSION


'''


}


}





stage('Manual Approval') {


steps {


input message:

"Deploy to Production?"


}


}





stage('Production Deployment') {


steps {


echo "Deploying Production"


sh '''

docker stop production-container || true

docker rm production-container || true


docker run -d \
--name production-container \
-p 80:8000 \
$IMAGE_NAME:$VERSION


'''


}


}



}



post {



failure {


echo "Pipeline Failed - Starting Rollback"


sh '''


docker stop production-container || true

docker rm production-container || true


echo "Rollback Completed"


'''


}



success {


echo "Production Deployment Successful"


}



}


}// pipeline {

// agent any


// stages {


// stage('Build') {

// steps {

// echo "Building application"

// }

// }



// stage('Test') {

// steps {

// echo "Running tests"

// }

// }



// stage('Generate Reports') {

// steps {


// sh '''

// echo "Build completed" > build.log

// echo "<coverage>Sample Coverage</coverage>" > coverage.xml

// echo "<testsuite>Test Report</testsuite>" > test-report.xml


// '''


// }

// }



// stage('Archive Artifacts') {


// steps {


// archiveArtifacts artifacts: '''
// coverage.xml,
// test-report.xml,
// build.log
// ''',
// allowEmptyArchive: true


// }


// }


// }


// }

// pipeline {
//     agent any
//     stages {
//         stage('Install Dependencies') {
//             steps {
//                 sh '''
//                 python3 -m venv venv
//                 . venv/bin/activate
//                 pip install --upgrade pip
//                 pip install -r requirements.txt
//                 '''
//             }
//         }

//         stage('Parallel Testing') {
//             parallel {
//                 stage('Django Tests') {
//                     steps {
//                         echo "Running Django Tests"
//                         sh '''
//                         . venv/bin/activate
//                         mkdir -p reports
//                         pytest > reports/django-test-report.txt || true
//                         '''
//                     }

//                 }

//                 stage('Flake8 Code Quality') {
//                     steps {
//                         echo "Running Flake8"
//                         sh '''
//                         . venv/bin/activate
//                         mkdir -p reports
//                         flake8 . > reports/flake8-report.txt || true
//                         '''
//                     }
//                 }
//                 stage('Bandit Security Scan') {
//                     steps {
//                         echo "Running Bandit Security Scan"
//                         sh '''
//                         . venv/bin/activate
//                         mkdir -p reports
//                        bandit -r . --exclude venv -f txt -o reports/bandit-report.txt || true
//                         '''
//                     }
//                 }
//             }
//         }
//         stage('Collect Reports') {
//             steps {
//                 echo "Collecting Reports"
//                 archiveArtifacts artifacts: 'reports/*', allowEmptyArchive: true
//             }
//         }
//     }

// }// pipeline {

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
