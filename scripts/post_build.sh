#!/bin/bash

set -o errexit
set -o nounset
# set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

$(aws ecr get-login --region $AWS_DEFAULT_REGION)
chmod +x version.cfg
. version.cfg
docker build -t app -t app:$VERSION . 
docker tag app:latest 950174139509.dkr.ecr.us-west-2.amazonaws.com/app:latest
docker tag app:$VERSION 950174139509.dkr.ecr.us-west-2.amazonaws.com/app:$VERSION
docker push 950174139509.dkr.ecr.us-west-2.amazonaws.com/app:latest
docker push 950174139509.dkr.ecr.us-west-2.amazonaws.com/app:$VERSION
echo "{'version': '$VERSION'}" > build.json
