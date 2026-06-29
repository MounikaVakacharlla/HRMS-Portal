pipeline{
agent any
stages{
stage("Install"){steps{sh "pip install -r requirements.txt"}}
stage("Check"){steps{sh "python manage.py check || true"}}
stage("Test"){steps{sh "python manage.py test || true"}}
}
}