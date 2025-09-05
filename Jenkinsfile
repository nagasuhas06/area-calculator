pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo "Building the project..."
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                echo "Running tests..."
                sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying WAR to Tomcat..."
                sh '''
                    WAR_FILE=target/area-calculator-1.0-SNAPSHOT.war
                    if [ -f "$WAR_FILE" ]; then
                        sudo cp $WAR_FILE /home/ubuntu/tomcat/webapps/
                        sudo bash /home/ubuntu/tomcat/bin/shutdown.sh || true
                        sudo bash /home/ubuntu/tomcat/bin/startup.sh
                        echo "Successfully deployed!"
                    else
                        echo "WAR file not found!"
                        exit 1
                    fi
                '''
            }
        }
    }

    post {
        always {
            echo "Pipeline finished. Cleaning workspace..."
            cleanWs()
        }
    }
}

