# -------- Stage -----------------
FROM maven:3.8.3-openjdk-17 AS builder

#working directory where your code and jar file will be stored
WORKDIR /app

# coying all the code from host to container
COPY . /app

# build the app to generate jar file
RUN mvn clean install -DskipTests=true

# ----------- Stage 2 -----------

FROM openjdk:17-alpine

COPY --from=builder /app/target/*.jar /app/target/bankapp.jar

# expose port to map to host
EXPOSE 8080

# exucute the jar  file using java command and -jar flag to specify we are executing a jar file
CMD ["java","-jar","/app/target/bankapp.jar"]
