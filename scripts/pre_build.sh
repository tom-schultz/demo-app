#!/bin/bash

set -o errexit
set -o nounset
# set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

chmod +x version.cfg
. version.cfg && bumpverison --current-version $VERSION minor version.cfg
pylint buggworks
pylint test
python -m unittest discover
