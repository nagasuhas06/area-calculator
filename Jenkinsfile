pipeline {
    agent any

    tools {
        maven 'Maven3'   // Make sure Maven tool is configured in Jenkins Global Tool Config
        jdk 'Java17'     // Adjust based on your installed JDK
    }

    triggers {
        githubPush()     // Trigger build on GitHub push
    }

    stages {
        stage('Build') {
            steps {
                echo "Building project..."
                sh 'mvn clean install -DskipTests'
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
                    WAR_FILE=$(ls target/*.war | head -n 1)
                    if [ -f "$WAR_FILE" ]; then
                        sudo cp $WAR_FILE /home/ubuntu/tomcat/webapps/
                        echo "Deployment successful!"
                    else
                        echo "WAR file not found!"
                        exit 1
                    fi
                '''
            }
        }
    }
}
