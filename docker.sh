#!/bin/sh

# Build the arm64 image (ran localy on M1)
export PG_MAJOR=14
docker build -t docker.io/jwhiteatdocker/citus:local -f postgres-14/Dockerfile .
docker tag docker.io/jwhiteatdocker/citus:local docker.io/jwhiteatdocker/citus:12.0.0-pg14-arm64
docker push docker.io/jwhiteatdocker/citus:12.0.0-pg14-arm64

# Pull the amd64 image and retag
docker pull --platform linux/amd64 citusdata/citus:12.0.0-pg14
#docker tag citusdata/citus:12.0.0-pg14 docker.io/jwhiteatdocker/citus:12.0.0-pg14-amd64
#docker push docker.io/jwhiteatdocker/citus:12.0.0-pg14-amd64

# Push multi-arch image up
docker manifest create docker.io/jwhiteatdocker/citus:12.0.0-pg14 \
  docker.io/jwhiteatdocker/citus:12.0.0-pg14-arm64 \
  citusdata/citus:12.0.0-pg14
docker manifest push --purge docker.io/jwhiteatdocker/citus:12.0.0-pg14
