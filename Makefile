.PHONY: dg doc build run test clean

TOOLS_IMG = modularitycontainers/image-build-tools
TOOLS_IMG_RM = true
DISTRO = fedora-26-x86_64
VERSION = 2.4
VARIANT = upstream
DOCKERFILE_SRC := Dockerfile.template
DOCKERFILE := Dockerfile
TEST_IMAGE_NAME := container-images-tests

IMG_RUN_LINE = docker run --rm=${TOOLS_IMG_RM} -v /var/run/docker.sock:/var/run/docker.sock:Z -v ${PWD}:/src:Z ${TOOLS_IMG}
SELECTORS = --distro ${DISTRO}.yaml --multispec-selector version=${VERSION} --multispec-selector variant=${VARIANT}
DG_EXEC = ${IMG_RUN_LINE} dg --max-passes 25 --spec specs/common.yml --multispec specs/multispec.yml ${SELECTORS}
GOMD2MAN = ${IMG_RUN_LINE} go-md2man
DISTRO_ID = $(shell ${DG_EXEC} --template "{{ config.os.id }}")
TAG = ${DISTRO_ID}/awesome:${VERSION}

dg:
	${DG_EXEC} --template $(DOCKERFILE_SRC) > $(DOCKERFILE)
	${DG_EXEC} --template help/help.md > help/help.md.rendered

doc: dg
	mkdir -p ./root/
	${GOMD2MAN} -in=help/help.md.rendered > ./root/help.1

build: doc dg
	docker build --tag=${TAG} -f $(DOCKERFILE) .

run: build
	docker run -p 9000:9000 -d ${TAG}

test: build
	${IMG_RUN_LINE} bash -c 'cd tests; MODULE=docker URL="docker=${TAG}" DOCKERFILE="../$(DOCKERFILE)" VERSION=${VERSION} DISTRO=${DISTRO} mtf -l *.py'

clean:
	rm -f $(DOCKERFILE)
	rm -f help/help.md.*
	rm -rf root
