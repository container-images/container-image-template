.PHONY: dg doc build run test

DISTRO = fedora-26-x86_64
VERSION = 2.2
DG = /usr/bin/dg

DG_EXEC = ${DG} --distro ${DISTRO}.yaml --spec specs/common.yml --multispec specs/multispec.yml --multispec-selector version=${VERSION}
DISTRO_ID = $(shell ${DG_EXEC} --template "{{ config.os.id }}")
TAG = ${DISTRO_ID}/awesome:${VERSION}

dg:
	${DG_EXEC} --template Dockerfile --output Dockerfile.rendered
	${DG_EXEC} --template help/help.md --output help/help.md.rendered

doc: dg
	mkdir -p ./root/
	go-md2man -in=help/help.md.rendered -out=./root/help.1

build: doc dg
	docker build --tag=${TAG} -f Dockerfile.rendered .

run: build
	docker run -p 9000:9000 -d ${TAG}

test: build
	cd tests; VERSION=${VERSION} DISTRO=${DISTRO} DOCKERFILE="../Dockerfile.rendered" MODULE=docker URL="docker=${TAG}" make all

clean:
	rm -f Dockerfile.*
	rm -f help/help.md.*
	rm -rf root
