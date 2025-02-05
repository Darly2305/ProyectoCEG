# Usar una imagen base de Java 17
FROM eclipse-temurin:17-jdk-alpine

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo pom.xml y resolver dependencias
COPY pom.xml .
RUN apk add --no-cache maven
RUN mvn dependency:go-offline -B

# Copiar el código fuente y compilar la aplicación
COPY src ./src
RUN mvn clean package -DskipTests

# Exponer el puerto 8080
EXPOSE 8080

# Copiar el JAR compilado a la raíz del contenedor
COPY target/SistemaCEG2-0.0.1-SNAPSHOT.jar

# Esperar a que PostgreSQL esté disponible antes de iniciar la aplicación
CMD ["sh", "-c", "echo 'Esperando a PostgreSQL...' && sleep 10 && java -jar app.jar"]