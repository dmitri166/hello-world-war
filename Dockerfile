FROM tomcat:8.0.20-jre8

MAINTAINER dmitrikachka

COPY   /opt/tomcat/.jenkins/workspace/hello-world-war_dev/target/hello-world-war-1.0.0.war  hello-world-war-1.0.0.war

EXPOSE 8080
 
