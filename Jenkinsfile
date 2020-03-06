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
        sh 'mvn clean package'
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

docker push http://192.168.1.149:8081/service/rest/repository/browse/hello-world-war-private:8081/hello-world-war:${BUILD_NUMBER}'''
      }
    }

  }
}