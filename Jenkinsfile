pipeline {
  agent any
  stages {
    stage('Checkout Code') {
      parallel {
        stage('Checkout Code') {
          steps {
            echo 'Check out'
          }
        }

        stage('Notify Failure') {
          steps {
            slackSend(failOnError: true, color: 'danger')
          }
        }

      }
    }

    stage('Build Maven War') {
      parallel {
        stage('Build Maven War') {
          steps {
            sh '''mvn clean package

build  aasds 3123rfds783c78194hdjasdq -t






'''
          }
        }

        stage('Notify Failure') {
          steps {
            slackSend(failOnError: true, message: 'Maven Build Failed', color: 'danger')
          }
        }

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

  }
}