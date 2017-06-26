#!/bin/bash

set -e

pwd
ls
chmod +x version.cfg
. version.cfg && bumpverison --current-version $VERSION minor version.cfg
pylint buggworks
pylint test
python -m unittest discover
