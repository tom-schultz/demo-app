#!/bin/bash

set -o errexit
set -o nounset
# set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

chmod +x version.cfg
. version.cfg && bumpversion --current-version $VERSION minor version.cfg
pylint app
pylint test
python -m unittest discover
aws cloudformation validate-template --template-body file://ecs-cfn.yml
