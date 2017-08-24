.PHONY: dg doc build run test

DISTRO = fedora-26-x86_64
VERSION = 2.2
DG = /usr/bin/dg
DG_EXEC_NO_SPEC = ${DG} --distro ${DISTRO}.yaml --spec specs/common.yml
DISTRO_ID = $(shell ${DG_EXEC_NO_SPEC} --template "{{ config.os.id }}")
DG_EXEC = ${DG_EXEC_NO_SPEC} --spec specs/${VERSION}.yml --spec specs/${DISTRO_ID}.yml
TAG = ${DISTRO}/awesome:${VERSION}

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
	cd tests; VERSION=${VERSION} DOCKERFILE="../Dockerfile.rendered" MODULE=docker URL="docker=${TAG}" make all

clean:
	rm -f Dockerfile.*
	rm -f help/help.md.*
	rm -rf root
