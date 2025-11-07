pipeline {
    agent any

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
         * 3️⃣ Deploy Stage (Docker)
         ***************************/
        stage('Deploy') {
    steps {
        echo "🐳 Building and deploying Docker container..."
        sh '''
            cd ${WORKSPACE}

            # Ensure the WAR file exists before building
            ls -l target/*.war || (echo "❌ WAR file not found in target/" && exit 1)

            # Create Dockerfile dynamically (optional if already in repo)
            cat > Dockerfile <<EOF
            FROM tomcat:9.0-jdk17
            RUN rm -rf /usr/local/tomcat/webapps/ROOT
            COPY target/area-calculator-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
            EXPOSE 8080
            CMD ["catalina.sh", "run"]
            EOF

            # Build the Docker image from current workspace
            docker build -t area-calculator:latest .

            # Stop and remove any existing container
            docker stop area-calculator || true
            docker rm area-calculator || true

            # Run new container mapping port 8085 -> 8080
            docker run -d --name area-calculator -p 8085:8080 area-calculator:latest

            echo "✅ Docker container deployed successfully on port 8085!"
        '''
    }
}


    post {
        success {
            echo '🎯 Pipeline completed successfully (Docker deploy done)!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs for details.'
        }
    }
}
