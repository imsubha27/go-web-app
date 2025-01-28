#Official Golang image as base image, ensures you have Go env & tools pre-installed 
FROM golang:1.23.4 as base

#Set the working dir inside the container, all subswquent command will run in this dir
WORKDIR /app

#Copy go.mod file into the container
COPY go.mod ./

#Download all dependencies specified in go.mod
RUN go mod download

#Copy entire application source code into the container 
COPY . .

#Build the go application, producing an executable named "main"
RUN go build -o main .

#Expose 8080
#CMD ["./main"]

#Final stage - Distroless image, reduces the attack surface & image size
FROM gcr.io/distroless/base

#Copy built go binary from previous stage
COPY --from=base /app/main .

#Copy static files from previous stage
COPY --from=base /app/src ./src

#Expose port 8080 to allow external access to the applicaton
EXPOSE 8080

#Command to run the built binary
CMD ["./main"]