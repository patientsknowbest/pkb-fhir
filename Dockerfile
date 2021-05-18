FROM gcr.io/distroless/java-debian10:11
COPY --chown=nonroot:nonroot target/ROOT.war /app/main.war
EXPOSE 8080
EXPOSE 5005
# 65532 is the nonroot user's uid
# used here instead of the name to allow Kubernetes to easily detect that the container
# is running as a non-root (uid != 0) user.
USER 65532:65532
WORKDIR /app
CMD ["-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=0.0.0.0:5005", "/app/main.war"]