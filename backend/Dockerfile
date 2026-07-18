# --- Build stage -------------------------------------------------------
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /workspace

# Cache dependencies separately from source so `docker build` only
# re-downloads them when pom.xml actually changes.
COPY pom.xml .
RUN mvn -B -q dependency:go-offline

COPY src ./src
RUN mvn -B -q clean package -DskipTests

# --- Runtime stage -------------------------------------------------------
FROM eclipse-temurin:21-jre-alpine AS runtime

# Never run the application as root inside the container.
RUN addgroup -S app && adduser -S app -G app
USER app

WORKDIR /app
COPY --from=build /workspace/target/backend-*.jar app.jar

EXPOSE 8080

# Requires spring-boot-starter-actuator (already a dependency) and
# management.endpoints.web.exposure.include=health.
HEALTHCHECK --interval=30s --timeout=5s --start-period=40s --retries=3 \
    CMD wget -q -O - http://localhost:8080/actuator/health | grep -q '"status":"UP"' || exit 1

# All configuration (DB_URL, DB_USERNAME, DB_PASSWORD, CORS_ALLOWED_ORIGINS,
# SPRING_PROFILES_ACTIVE, PORT, ...) is supplied at runtime via environment
# variables — see docs/Deployment.md. Nothing is baked into the image.
ENTRYPOINT ["java", "-jar", "app.jar"]
