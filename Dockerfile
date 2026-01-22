FROM openjdk:17-jdk-slim
#WORKDIR /app
ADD /build/libs/app.jar /app.jar
ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar .
ENV JAVA_TOOL_OPTIONS "-javaagent:./opentelemetry-javaagent.jar"
CMD ["java", "-jar", "app.jar"]
ENTRYPOINT java -javaagent:/opentelemetry-javaagent.jar \
            -Dotel.traces.exporter=logging \
            -jar /app.jar