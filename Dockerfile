FROM tomcat:9.0-jdk17
# Remove default ROOT app
RUN rm -rf /usr/local/tomcat/webapps/ROOT
# Copy your WAR file into Tomcat webapps as ROOT
COPY target/area-calculator-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
