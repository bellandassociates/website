#!/bin/bash

podman rmi bna-site-compile
podman build -t bna-site-compile -f env_build/Dockerfile .
