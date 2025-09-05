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
                    cd ${WORKSPACE}/target
                    cp area-calculator-1.0-SNAPSHOT.war /home/ubuntu/tomcat/webapps
                    /home/ubuntu/tomcat/bin/shutdown.sh
                    sleep 5
                    /home/ubuntu/tomcat/bin/startup.sh
                    echo "Successfully deployed"
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
