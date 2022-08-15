properties([pipelineTriggers([githubPush()])]) 
pipeline {
    agent any
    stages {
        stage('SAST') {
        agent { label "agent1" } // Define which agent you want to run the pipeline
            steps {
              // Test menggunakan Sonarqube
                script { 
                echo "Begin Testing Using Sonarqube"
                def scannerHome = tool 'sonarqube1' ; //sonarqube by Global Tools Configuration
                withSonarQubeEnv('sonarqube') {  //sonarqube by Endpoint Server Sonarqube
                sh "${scannerHome}/bin/sonar-scanner"}
                } 
              }
            }
        stage('Build') {
        agent { label "agent1" } // Define which agent you want to run the pipeline
            steps {
              // Build Image
                script { 
                echo "Begin Build"
                  discordSend description: 'Jenkins Pipeline Build', 
                  footer: "Start Build", 
                  link: "${env.BUILD_URL}", 
                  result: "${currentBuild.currentResult}", 
                  title: "${env.JOB_NAME}",
                  successful: "${currentBuild.resultIsBetterOrEqualTo('SUCCESS')}"
                  webhookURL: "${DISCORD_WEBHOOK}"
                if (env.BRANCH_NAME == "staging")
                { 
                sh "docker build -t arizalsandi/cilist-client:stg-$BUILD_NUMBER frontend/. "
                sh "docker build -t arizalsandi/cilist-server:stg-$BUILD_NUMBER backend/. "
                sh "docker push arizalsandi/cilist-client:stg-$BUILD_NUMBER"
                sh "docker push arizalsandi/cilist-server:stg-$BUILD_NUMBER"
                }
                else
                { 
                sh "docker build -t arizalsandi/cilist-client:master-$BUILD_NUMBER frontend/. "
                sh "docker build -t arizalsandi/cilist-server:master-$BUILD_NUMBER backend/. "
                sh "docker push arizalsandi/cilist-client:master-$BUILD_NUMBER"
                sh "docker push arizalsandi/cilist-server:master-$BUILD_NUMBER"
                }
              }
            }
          }
        stage('Deploy') {
        agent { label "agent1" }  // Define which agent you want to run the pipeline
            steps {
              // Deploy to Kubernetes
                script { 
                
                echo "Begin to Deploy" 

                if (env.BRANCH_NAME == "staging")
                {
                sh "kubectl set image deployment/client-app client-app=arizalsandi/cilist-client:stg-$BUILD_NUMBER -n staging"
                sh "kubectl set image deployment/server-app server-app=arizalsandi/cilist-server:stg-$BUILD_NUMBER -n staging"
                sh "docker image rmi arizalsandi/cilist-client:stg-$BUILD_NUMBER"
                sh "docker image rmi arizalsandi/cilist-server:stg-$BUILD_NUMBER"
                }
                else
                {
                sh "kubectl set image deployment/client-app client-app=arizalsandi/cilist-client:master-$BUILD_NUMBER -n production"
                sh "kubectl set image deployment/server-app server-app=arizalsandi/cilist-server:master-$BUILD_NUMBER -n production"
                sh "docker image rmi arizalsandi/cilist-client:master-$BUILD_NUMBER"
                sh "docker image rmi arizalsandi/cilist-server:master-$BUILD_NUMBER"
                }
              }
            }
          }
        }
      }
    