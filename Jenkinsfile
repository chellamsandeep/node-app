pipeline {
agent any
stages{
    stage('checkout-stage'){
        steps {
            slackSend (color: '#FFFF00', message: "STARTED: Check-out-stage")
            checkout([$class: 'GitSCM', branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/chellamsandeep/node-app.git']]])
        }
    }
    stage('Docker-Build'){
        steps {
            slackSend (color: '#FFFF00', message: "STARTED: Docker-Build-stage")
            sh 'docker build -t hello-airbus .'
        }
    }
    stage('Running-Container'){
        steps {
            slackSend (color: '#FFFF00', message: "STARTED: Running-container-stage")
            sh 'docker run -p 5000:5000 -d hello-airbus'
        }
    }
    stage('Container-output'){
        steps {
            slackSend (color: '#FFFF00', message: "STARTED: Container-output-stage")
            sh 'curl http://localhost:5000'
        }
    }
    stage('Curl-command'){
        steps {
            slackSend (color: '#FFFF00', message: "STARTED: https-status-code")
            sh 'curl -o /dev/null -s -w "%{http_code}\n" http://localhost:5000'
        }
    }
}
  post {
    success {
      slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }
    failure {
      slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }
  }

}
