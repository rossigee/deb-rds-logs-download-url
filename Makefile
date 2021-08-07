VERSION := $(shell cat VERSION)-$(shell git rev-parse --short HEAD)

DEB_PACKAGE_NAME=rds-logs-download-url
DEB_PACKAGE_DESCRIPTION="Helper for downloading large log files from RDS"

.PHONY: all
all: build 

main.go:
	curl -sSL -o main.go https://raw.githubusercontent.com/jonstacks/aws/42e4c0c207572badc28b974f27c6fca233ac66d1/cmd/rds-logs-download-url/main.go

#$(GODEP):
#	go get -u github.com/jonstacks/aws/cmd/rds-logs-download-url

version:
	@echo $(VERSION)

build: main.go
	go build

build-deb:
	exec ${BUILD_SCRIPT}
	
clean:
	rm -f main.go
	rm -f rds-logs-download-url

