FROM golang:1.13 as build

RUN apt-get update && apt-get install unzip

RUN curl -L https://github.com/protocolbuffers/protobuf/releases/download/v3.10.1/protoc-3.10.1-linux-x86_64.zip -o protoc.zip
RUN unzip protoc.zip -d /usr/local bin/protoc

FROM golang:1.13

COPY --from=build /usr/local/bin/protoc /usr/local/bin/protoc

RUN curl -sSL https://github.com/uber/prototool/releases/download/v1.0.0/prototool-$(uname -s)-$(uname -m) -o /usr/local/bin/prototool
RUN chmod +x /usr/local/bin/prototool

RUN go get -u github.com/golang/protobuf/protoc-gen-go
RUN go get -u golang.org/x/lint/golint
RUN go get -u github.com/golang/dep/cmd/dep