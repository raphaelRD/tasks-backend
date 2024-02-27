FROM tomcat:8.5.50-jdk8-openjdk

ARG WAR_FILE
ARG CONTEXT

COPY ${WAR_FILE} usr/local/tomcat/webapps/{CONTEXT}.war

# docker build --build-arg WAR_FILE = taskFrontEnd/target/tasks.war --build-arg CONTEXT = tasks -t test-front .
# docker run --rm --name frontEndImage -e BACKEND_HOST={IP DA MAQUINA RODANDO O DOCKER} -e BACKEND_PORT = {PORTA DO BACKEND} -p 8003:8080