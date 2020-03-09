def COLOR_MAP = [...]
def getBuildUser(){...}

pipeline {
    // Set up local variables for your pipeline
    environment {
        // test variable: 0=success, 1=fail; must be string
        doError = '0'
        BUILD_USER = ''
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
		  
        agent any
		  
	stages {
        stage('Error') {
            // when doError is equal to 1, return an error
            when {
                expression { doError == '1' }
            }
            steps {
                echo "Failure :("
                error "Test failed on purpose, doError == str(1)"
            }
        }
        stage('Success') {
            // when doError is equal to 0, just print a simple message
            when {
                expression { doError == '0' }
            }
            steps {
                echo "Success :)"
            }
        }
    }

    // Post-build actions
    post {
        always {
            script {
                BUILD_USER = getBuildUser()
            }
            echo 'I will always say hello in the console.'
            slackSend channel: '#slack-test-channel',
                color: COLOR_MAP[currentBuild.currentResult],
                message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} by ${BUILD_USER}\n More info at: ${env.BUILD_URL}"
        }
    }
}

