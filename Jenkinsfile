pipeline {
    agent any

    triggers {
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
         * 3️⃣ Deploy Stage (Docker)
         ***************************/
        stage('Deploy') {
            steps {
                echo "🐳 Building and deploying Docker container..."
                sh '''
                    set -xe  # show commands and fail on error
                    cd ${WORKSPACE}

                    echo "🔍 Checking WAR file exists..."
                    ls -l target/*.war || (echo "❌ WAR file not found in target/" && exit 1)

                    echo "📄 Creating Dockerfile..."
                    cat > Dockerfile <<'EOF'
FROM tomcat:9.0-jdk17
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY target/area-calculator-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
EOF

                    echo "🏗️ Building Docker image..."
                    docker build -t area-calculator:latest .

                    echo "🧹 Removing old container..."
                    docker stop area-calculator || true
                    docker rm area-calculator || true

                    echo "🚀 Starting new container..."
                    docker run -d --name area-calculator -p 8085:8080 area-calculator:latest

                    echo "🔎 Current Docker containers:"
                    docker ps -a

                    echo "✅ Deployment complete! App running on port 8085."
                '''
            }
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
