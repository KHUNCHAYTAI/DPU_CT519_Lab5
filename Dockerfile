#Create build stage based on buster image
FROM golang:1.18.4-alpine3.15
#Create working directory under /app
WORKDIR /app
#Run go mod init
RUN go mod init dpu-ct5119-lab5
#Copy over all go config (go.mod, go.sum etc.)
COPY go.mod* ./
#Install any required modules
RUN go mod download
#Copy over Go source code
COPY *.go ./
#Copy file html to Docker
COPY ./www ./www
#Run the Go build and output binary under hello_go_http
RUN go build -o /dpu-ct519-lab5
FROM php:8.0-apache
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN apt-get update && apt-get update -y
COPY ./www/ /var/www/html/
#create a new release build stage
# FROM gcr.io/distrolessbase-debian10
#Set the working directory to the root directory path
#RUN apk add --no-cache libc6-compat
WORKDIR /
#Copy over the binary built from the previous stage
# COPY --from=builder ./dpu-ct519_lab5 /dpu-ct519_lab5
#Make sure to expose the port the HTTP server is using
EXPOSE 8080
FROM alpine:3.6
CMD ["/bin/bash"]
#Run the app binary when we run the container
CMD ["/dpu-ct5119-lab5"]
ENTRYPOINT ["/dpu-ct5119-lab5"] 
