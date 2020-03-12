def notifyBuild(String buildStatus = 'STARTED') {
    // Build status of null means success.
    buildStatus =  buildStatus ?: 'SUCCESS'
    if (buildStatus == 'STARTED') {
        colorCode = '#FFFF00'
    } else if (buildStatus == 'SUCCESS') {
        colorCode = '#00FF00'
    } else {
        colorCode = '#FF0000'
    }
    // Send notification.
    def msg = "${buildStatus}: `${env.JOB_NAME}` #${env.BUILD_NUMBER}:\n${env.BUILD_URL}"
    slackSend(color: colorCode, message: msg)
}

pipeline {
  agent any
  stages {
    stage('Checkout Code') {
      steps {
        echo 'Check out'
      }
    }

    stage('Build Maven War') {
      steps {
        sh '''mvn clean package
'''
      }
    }

    stage('Static Code Analysis') {
      steps {
        sh 'mvn clean verify sonar:sonar'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh '''cp /opt/tomcat/.jenkins/workspace/hello-world-war_dev/target/hello-world-war-1.0.0.war  /opt/tomcat/.jenkins/workspace/hello-world-war_dev
docker build -t hello-world-war:${BUILD_NUMBER} .
docker tag hello-world-war:${BUILD_NUMBER} 192.168.1.149:8083/hello-world-war:${BUILD_NUMBER}
docker login -u admin -p dima1986 192.168.1.149:8083
docker push 192.168.1.149:8083/hello-world-war:${BUILD_NUMBER}
'''
      }
    }

    stage('Notify Slack') {
      steps {
        sh '''catch (e) {
    // If there was an exception thrown, the build failed.
        currentBuild.result = "FAILED"
        throw e
    } finally {
    // Success or failure, always send notification.
        stage(\'7. Notifying Slack\'){
            notifyBuild(currentBuild.result)
          }'''
        }
      }

    }
  }
