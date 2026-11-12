FROM maven:3.9-eclipse-temurin-17

WORKDIR /app

# Baixa as dependências durante a construção da imagem.
COPY pom.xml .
RUN mvn -B dependency:go-offline

COPY . .

CMD ["sh", "-c", "mvn -q clean compile && java -cp target/classes Main"]
