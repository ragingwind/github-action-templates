#!/bin/bash

jobs=('rust')

if [[ $(uname -m) == 'arm64' ]]; then
  CONTAINER_ARCH="--container-architecture linux/amd64"
fi

test_all() {
  act workflow_dispatch $CONTAINER_ARCH --env-file act.env
}

test_job() {
  ENVFILE="--env-file act.env"
  echo "Testing with act -j $1 $CONTAINER_ARCH $ENVFILE"
  act -j $1 $CONTAINER_ARCH $ENVFILE
}

[[ -z $1 ]] && test_all || test_job $1
