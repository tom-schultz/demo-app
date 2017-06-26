#!/bin/bash

set -o errexit
set -o nounset
# set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

$(aws ecr get-login --region $AWS_DEFAULT_REGION)
chmod +x version.cfg
. version.cfg
docker build -t buggworks -t buggworks:$VERSION . 
docker tag buggworks:latest 950174139509.dkr.ecr.us-west-2.amazonaws.com/buggworks:latest
docker tag buggworks:$VERSION 950174139509.dkr.ecr.us-west-2.amazonaws.com/buggworks:$VERSION
docker push 950174139509.dkr.ecr.us-west-2.amazonaws.com/buggworks:latest
docker push 950174139509.dkr.ecr.us-west-2.amazonaws.com/buggworks:$VERSION
