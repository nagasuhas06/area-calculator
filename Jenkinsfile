pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    sudo cd ${WORKSPACE}/target
                    sudo cp area-calculator-1.0-SNAPSHOT.war /home/ubuntu/tomcat/webapps
                    sudo /home/ubuntu/tomcat/bin/shutdown.sh
                    sudo sleep 5
                    sudo /home/ubuntu/tomcat/bin/startup.sh
                    sudo echo "Successfully deployed"
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
