properties([pipelineTriggers([githubPush()])]) 
pipeline {
    agent any
    stages {
        stage('Testing') {
        agent { label "agent" } // Define which agent you want to run the pipeline
            steps {
              // Test menggunakan Sonarqube
                script { 
                echo "Begin Testing Using Sonarqube"
                def scannerHome = tool 'sonarqube' ; //sonarqube by Global Tools Configuration
                withSonarQubeEnv('sonarqube') {  //sonarqube by Endpoint Server Sonarqube
                sh "${scannerHome}/bin/sonar-scanner"}
                } 
              }
            }
        stage('Build') {
        agent { label "agent" } // Define which agent you want to run the pipeline
            steps {
              // Build Image
                script { 

                echo "Begin Build"
                
                if (env.BRANCH_NAME == "staging")
                
                { 
                sh "docker build -t harjay88/cilist:stg-$BUILD_NUMBER . "
                sh "docker push harjay88//cilist:stg-$BUILD_NUMBER"
                }
                else
                { 
                sh "docker build -t harjay88//cilist:master-$BUILD_NUMBER . "
                sh "docker push harjay88/cilist:master-$BUILD_NUMBER"}
                }
              }
            }
        stage('Deploy') {
        agent { label "agent" }  // Define which agent you want to run the pipeline
            steps {
              // Deploy to Kubernetes
                script { 
                
                echo "Begin to Deploy" 

                if (env.BRANCH_NAME == "development")
                {
                sh "kubectl set image deployment/cilist cilist=harjay88/cilist:stg-$BUILD_NUMBER -n stg-app-cilist"
                sh "docker image rmi harjay88/landingpage:dev-$BUILD_NUMBER"
                }
                else
                {
                sh "kubectl set image deployment/cilist cilist=harjay88/cilist:master-$BUILD_NUMBER -n prd-app-cilist"
                sh "docker image rmi harjay88/cilist:master-$BUILD_NUMBER"
                }
              }
            }
          }
        }
      }