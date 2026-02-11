# Estágio de Build (opcional, se você builda o jar dentro do docker)
FROM maven:3.9.6-eclipse-temurin-21-jammy AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Estágio de Execução (Onde o erro de metadados acontece)
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
# Certifique-se de que o nome do JAR coincide com o gerado pelo seu pom.xml
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8761
ENTRYPOINT ["java", "-jar", "app.jar"]