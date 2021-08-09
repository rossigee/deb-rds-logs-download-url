package=rds-logs-download-url

packagedir=$(dirname `pwd`)

tmpdir=/tmp/${package}-deb-build

.PHONY: default
default: prebuild build

prebuild:
	apt-get update && apt-get install -y \
	  awscli \
	  curl \
	  dpkg-dev \
	  debhelper \
		golang-go

build:
	/usr/bin/dpkg-buildpackage -us -uc -b

deploy:
	[ -d ${tmpdir} ] || mkdir ${tmpdir}
	chmod 777 ${tmpdir}
	docker run -v ${tmpdir}:/artifacts --rm ${package}-deb-builder bash -c "tar cf - /wd/${package}_*" | \
	  ( cd ${tmpdir}; tar xf - )
	for i in ${tmpdir}/wd/${package}_*; do \
		 aws s3 cp $$i ${S3_URI}/$$(basename $$i); \
	done

clean:
	rm -rf build
	rm -rf debian/${package}-* debian/${package}.*.log debian/files
	rm -f ${package}-*.tar.gz

dockerbuild:
	docker build -t ${package}-deb-builder .
