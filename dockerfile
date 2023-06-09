# Base image
FROM ubuntu:22.04

# Define arguments
ARG JDBC_DATABASE_URL
ARG JDBC_USERNAME
ARG JDBC_PASSWORD
ARG API_KEY
ARG IMAGE_API_KEY
ARG TOKEN_SECRET
ARG TOKEN_ISSUER
ARG TOKEN_EXPIRATION

# Set environment variables
ENV JDBC_DATABASE_URL $JDBC_DATABASE_URL
ENV JDBC_USERNAME $JDBC_USERNAME
ENV JDBC_PASSWORD $JDBC_PASSWORD
ENV API_KEY $API_KEY
ENV IMAGE_API_KEY $IMAGE_API_KEY
ENV TOKEN_SECRET $TOKEN_SECRET
ENV TOKEN_ISSUER $TOKEN_ISSUER
ENV TOKEN_EXPIRATION $TOKEN_EXPIRATION
ENV DEFAULT_USER_NAME $DEFAULT_USER_NAME
ENV DEFAULT_USER_PASS $DEFAULT_USER_PASS
ENV DEFAULT_USER_CREDIT $DEFAULT_USER_CREDIT

# Install OpenJDK 17 slim
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk-headless && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN chmod +x mvnw
RUN ./mvnw package

EXPOSE 8080

CMD ["sh", "-c", "java -jar target/GameGenerator-0.0.1-SNAPSHOT.jar"] 