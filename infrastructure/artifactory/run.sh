#!/bin/bash
# Inspired by
# https://www.jfrog.com/confluence/display/RTF/Installing+with+Docker
# but with a specific docker image version
docker run --name artifactory -d -p 8081:8081 docker.bintray.io/jfrog/artifactory-oss:5.8.3

echo Started Docker container artifactory.
echo Configure Artifactory at:
echo http://localhost:8081
