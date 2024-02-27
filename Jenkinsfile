pipeline{
    agent any
    stages{
        stage('Build Backend'){
            steps {
                bat 'mvn clean package -DskipTests=true'
            }
        }
        stage('Unit Tests'){
            steps {
                bat 'mvn test'
            }
        }
        stage('Sonar Analysis'){
            environment{
                scannerHome = tool 'SONAR_SCANNER'
            }
            steps {
                withSonarQubeEnv('SONAR_LOCAL'){
                    bat "${scannerHome}/bin/sonar-scanner -e -Dsonar.projectKey=DeployBack -Dsonar.host.url=http://localhost:9000 -Dsonar.login=278fc4407f092bb14340ae7d5a44dc1a5cb846c0 -Dsonar.java.binaries=target"
                }
                
            }
        }
         stage('Quality Gate'){
            steps {
                sleep(10)
                timeout(time:1, unit: 'MINUTES'){
                    waitForQualityGate abortPipeline:true
                }
                
                
            }
        }
       
    }
    
    
}


