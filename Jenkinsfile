properties([pipelineTriggers([githubPush()])]) 
pipeline {
    agent any
    stages {
        stage('Code Scanning') {
          agent { label "agent" }
            steps {
              //
                script {
                echo "Begin Test" 
                def scannerHome = tool 'sonarqube' ;
	              withSonarQubeEnv('sonarqube') {
	              sh "${scannerHome}/bin/sonar-scanner"
	                }
                }
              }
            }
        stage('Build') {
          agent { label "agent" }
            steps {
              //
                script {
                echo "Build"
                if (env.BRANCH_NAME == "stagging")
                { 
                // sh "pwd && ls -lah"
                sh "docker build -t harjay88/cilistbe:stage-$BUILD_NUMBER backend/."
                sh "docker build -t harjay88/cilistfe:stage-$BUILD_NUMBER frontend/."
                sh "docker push harjay88/cilistbe:stage-$BUILD_NUMBER"
                sh "docker push harjay88/cilistfe:stage-$BUILD_NUMBER"
                }else{ 
                sh "pwd && ls -lah"
                sh "docker build -t harjay88/cilistbe:prod-$BUILD_NUMBER backend/."
                sh "docker build -t harjay88/cilistfe:prod-$BUILD_NUMBER frontend/."
                sh "docker push harjay88/cilistbe:prod-$BUILD_NUMBER"
                sh "docker push harjay88/cilistfe:prod-$BUILD_NUMBER"
                }
                }  
              }
            }
        stage('Deploy') {
          agent { label "agent" }
            steps {
              //
                script { echo "Deploy" 
                if (env.BRANCH_NAME == "stagging")
                { 
                sh "kubectl set image deployment/cilistbe cilistbe=harjay88/cilistbe:stg-$BUILD_NUMBER -n stagging"
                sh "kubectl set image deployment/cilistfe cilistfe=harjay88/cilistfe:stg-$BUILD_NUMBER -n stagging"
                sh "docker image rmi harjay88/cilistbe:stg-$BUILD_NUMBER"
                sh "docker image rmi harjay88/cilistfe:stg-$BUILD_NUMBER"
                }else{ 
                sh "kubectl set image deployment/cilistbe cilistbe=harjay88/cilistbe:prod-$BUILD_NUMBER -n production"
                sh "kubectl set image deployment/cilistfe cilistfe=harjay88/cilistfe:prod-$BUILD_NUMBER -n production"
                sh "docker image rmi harjay88/cilistbe:prod-$BUILD_NUMBER"
                sh "docker image rmi harjay88/cilistfe:prod-$BUILD_NUMBER"
                }
                }
            }
          }
        }
      }