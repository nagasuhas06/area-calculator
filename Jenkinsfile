pipeline {
    agent any

    tools {
        // Make sure Maven and JDK names match Jenkins Global Tool Config
        maven 'Maven3'
        jdk 'Java17'
    }

    triggers {
        // Automatically trigger build when code is pushed to GitHub
        githubPush()
    }

    stages {

        /***************************
         * 1️⃣ Build Stage
         ***************************/
        stage('Build') {
            steps {
                echo "🔨 Building the project..."
                sh 'mvn clean package'
            }
        }

        /***************************
         * 2️⃣ Test Stage
         ***************************/
        stage('Test') {
            steps {
                echo "🧪 Running tests..."
                sh 'mvn test'
            }
        }

        /***************************
         * 3️⃣ Deploy Stage (Tomcat)
         ***************************/
        stage('Deploy') {
            steps {
                echo "🚀 Deploying WAR to Tomcat..."
                sh '''
                    cd ${WORKSPACE}/target
                    # Copy WAR to Tomcat webapps
                    sudo cp area-calculator-1.0-SNAPSHOT.war /home/ubuntu/tomcat/webapps/

                    # Restart Tomcat cleanly
                    sudo /home/ubuntu/tomcat/bin/shutdown.sh || true
                    sleep 5
                    sudo /home/ubuntu/tomcat/bin/startup.sh

                    echo "✅ Successfully deployed!"
                '''
            }
        }
    }

    post {
        success {
            echo '🎯 Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check Jenkins logs for details.'
        }
        always {
            echo '🧹 Cleaning up workspace...'
            cleanWs()
        }
    }
}
