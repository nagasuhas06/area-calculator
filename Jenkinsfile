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
            sudo cp area-calculator-1.0-SNAPSHOT.war /home/ubuntu/tomcat/webapps
            /home/ubuntu/tomcat/bin/shutdown.sh || true
            /home/ubuntu/tomcat/bin/startup.sh
            echo "Successfully deployed"
        '''
    }
}


        


        
    }
}
