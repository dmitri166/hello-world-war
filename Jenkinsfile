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

docker tag hello-world-war:${BUILD_NUMBER} 192.168.1.149:8083/hello-world-war:${BUILD_NUMBER}

docker login -u admin -p dima1986 192.168.1.149:8083

docker push 192.168.1.149:8083/hello-world-war:${BUILD_NUMBER}

'''
      }
    }

    stage('Notify Slack') {
      steps {
        sh '''def notifySlack(String buildStatus = \'STARTED\') {
    // Build status of null means success.
    buildStatus = buildStatus ?: \'SUCCESS\'
    def color
    if (buildStatus == \'STARTED\') {
        color = \'#D4DADF\'
    } else if (buildStatus == \'SUCCESS\') {
        color = \'#BDFFC3\'
    } else if (buildStatus == \'UNSTABLE\') {
        color = \'#FFFE89\'
    } else {
        color = \'#FF9FA1\'
    }
    def msg = "${buildStatus}: `${env.JOB_NAME}` #${env.BUILD_NUMBER}:\\n${env.BUILD_URL}"
    slackSend(color: color, message: msg)
}
node(\'centos-docker\') {
stage(\'check-out-code\') {
      checkout([$class: \'GitSCM\', branches: [[name: "${branch}"]], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: \'git-creds\', url: \'https://github.com/lidorg-dev/final-project.git\']]])
}
stage(\'Build\') {
   sh label: \'\', script: "docker build -t sarah-app:${env.BUILD_ID} ."
}
stage(\'Test\') {
}
stage(\'Publish\') {
   withDockerRegistry(credentialsId: \'docker-hub\') {
  sh label: \'\', script: "docker tag sarah-app:${env.BUILD_ID} lidorlg/sarah-app:${env.BUILD_ID} && docker push lidorlg/sarah-app:${env.BUILD_ID}"
}
}
stage(\'Notify Slack\') {
  try {
       notifySlack()
       // Existing build steps.
   } catch (e) {
       currentBuild.result = \'FAILURE\'
       throw e
   } finally {
       notifySlack(currentBuild.result)
   }
}
}'''
        }
      }

    }
  }