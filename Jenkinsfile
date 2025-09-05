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
                sh '''
                    PROJECT_DIR=/home/ubuntu/project/area-calculator
                    WAR_FILE=$(ls $PROJECT_DIR/target/*.war | head -n 1)

                    if [ -f "$WAR_FILE" ]; then
                        echo "Found WAR: $WAR_FILE"
                        sudo rm -rf /home/ubuntu/tomcat/webapps/*.war
                        sudo rm -rf /home/ubuntu/tomcat/webapps/area-calculator*
                        sudo cp "$WAR_FILE" /home/ubuntu/tomcat/webapps/
                        sudo bash /home/ubuntu/tomcat/bin/shutdown.sh || true
                        sudo bash /home/ubuntu/tomcat/bin/startup.sh
                        echo "Successfully deployed!"
                    else
                        echo "WAR file not found in $PROJECT_DIR/target/"
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

