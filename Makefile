.PHONY: all
all: build

deb:
	dpkg-buildpackage -us -uc -b

clean:
	rm -f main.go
	rm -f rds-logs-download-url
