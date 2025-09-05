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
            cd /var/lib/jenkins/workspace/Test/target
            sudo cp area-calculator-1.0-SNAPSHOT.war /home/ubuntu/tomcat/webapps
            /home/ubuntu/tomcat/bin/shutdown.sh
            /home/ubuntu/tomcat/bin/startup.sh
            echo "Successfully deployed"
        '''
    }
}


        


        
    }
}
