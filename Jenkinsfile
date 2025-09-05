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
                    cd /home/ubuntu/project/area-calculator/target
                    sudo cp area-calculator-1.0-SNAPSHOT.war /home/ubuntu/apache-tomcat-9.0.97/webapps
                    sudo bash /home/ubuntu/apache-tomcat-9.0.97/bin/shutdown.sh || true
                    sudo bash /home/ubuntu/apache-tomcat-9.0.97/bin/startup.sh
                    echo "Successfully deployed"
                '''
            }
        }
    }
}
