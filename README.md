# Container Image Template

This is a template of a git repository which is a source for building container images.

It uses [distgen](https://github.com/devexp-db/distgen/) to render the `Dockerfile` template for specific base image/software version/etc.

## Description

* `Dockerfile` - template of `Dockerfile`
* `help/` - a directory containing `help.md` file. This serves as a base for container help page. Similarly to `Dockerfile`, it's also templated and rendered prior to image build.
* `LICENSE` — pick the right license
* `Makefile` — so it's easy to build, run, test
* `README.md` — global documentation for the whole service
  * what is it, how to build, how to use
* `script.sh` - an example script that gets put inside built image
* `specs/` - a directory with configuration fils for [distgen](https://github.com/devexp-db/distgen/)
* `tests/` — these tests should verify that the image works

## Usage

* `make [DISTRO=<distgen-distro>] [VERSION=<version>] doc` - build docs (help file and a generated manpage) for a certain distro and software version
* `make [DISTRO=<distgen-distro>] [VERSION=<version>] build` - build image for a certain distro and software version
* `make [DISTRO=<distgen-distro>] [VERSION=<version>] run` - build and run container with a certain distro and software version
* `make [DISTRO=<distgen-distro>] [VERSION=<version>]test` - build and test a container with certain distro and software version

Note: default distro is `fedora-26-x86_64` and default version is `2.4`

## Automatic Building on Dockerhub

To setup an automated Dockerhub build for a repo that uses distgen, you need to include `hooks/pre_build`. This script makes sure that a certain configuration is rendered on Dockerhub prior to the build itself by using distgen in container in the `pre_build` stage.
