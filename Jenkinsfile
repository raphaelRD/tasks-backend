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
        stage('Deploy Backend'){
            steps{
                deploy adapters: [tomcat9(credentialsId: 'LoginTomcat', path: '', url: 'http://localhost:8001')], contextPath: 'tasks-backend', war: 'target/tasks-backend.war'
            }
        }
        stage('API Test'){
            steps{
                git credentialsId: 'LoginGit', url: 'https://github.com/raphaelRD/testApi'
                //Muda o diretorio para executar os testes ja que o POM esta em um subdiretorio dentro do repositorio, alem disso cria uma nova pasta
                //dentro do workspace do jenkins, caso contrario o build do repositorio de testes iria sobreescrever o build do repositorio do backend
                dir('api-test'){
                    bat 'mvn test'
                }
            }
        }
        stage('Deploy FrontEnd'){
            steps{
                git credentialsId: 'LoginGit', url: 'https://github.com/raphaelRD/tasks-frontend'
                //Muda o diretorio para executar os testes ja que o POM esta em um subdiretorio dentro do repositorio, alem disso cria uma nova pasta
                //dentro do workspace do jenkins, caso contrario o build do repositorio de testes iria sobreescrever o build do repositorio do backend
                dir('taskFrontEnd'){
                    bat 'mvn clean package'
                    deploy adapters: [tomcat9(credentialsId: 'LoginTomcat', path: '', url: 'http://localhost:8001')], contextPath: 'tasks', war: 'target/tasks.war'
                }
            }
        }      
    }
    
    
}


