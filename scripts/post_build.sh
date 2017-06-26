#!/bin/bash

set -e

$(aws ecr get-login --region $AWS_DEFAULT_REGION)
chmod +x version.cfg
. version.cfg
docker build -t buggworks -t buggworks:$VERSION . 
docker tag buggworks:latest 950174139509.dkr.ecr.us-west-2.amazonaws.com/buggworks:latest
docker tag buggworks:$VERSION 950174139509.dkr.ecr.us-west-2.amazonaws.com/buggworks:$VERSION
docker push 950174139509.dkr.ecr.us-west-2.amazonaws.com/buggworks:latest
docker push 950174139509.dkr.ecr.us-west-2.amazonaws.com/buggworks:$VERSION
