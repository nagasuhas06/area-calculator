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
            cd $WORKSPACE/target
            cp area-calculator-1.0-SNAPSHOT.war /home/ubuntu/apache-tomcat-9.0.97/webapps
            /home/ubuntu/apache-tomcat-9.0.97/bin/shutdown.sh || true
            /home/ubuntu/apache-tomcat-9.0.97/bin/startup.sh
            echo "Successfully deployed"
        '''
    }
}


        


        
    }
}
