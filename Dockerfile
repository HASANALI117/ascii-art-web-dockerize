# Use the latest version of the official Golang image as the base image for building
FROM golang:latest AS builder

# Set the working directory inside the Docker container to /app
WORKDIR /app

# Copy the rest of the code from your local directory to the current directory in the Docker container
COPY . .

# Build the Go application. The resulting binary will be named "main"
RUN CGO_ENABLED=0 go build -o main .

# Use a smaller base image for running the application
FROM alpine:latest AS production

# Metadata
LABEL institute="reboot01"
LABEL team="Hasan Dhaif / Ahmed Alhamed"
LABEL date="Apr 2023"

# Install bash
RUN apk add --no-cache bash

# Set the working directory inside the Docker container to /app
WORKDIR /app

# Copy the binary from the builder stage to the current stage
COPY --from=builder /app /app

# Inform Docker that the container is listening on port 8080 at runtime
EXPOSE 8080

# Specify the command to run when the Docker container starts up ("/app/main")
CMD [ "/app/main" ]