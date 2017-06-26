#!/bin/bash

set -e

chmod +x version.cfg
ls -l
. ../version.cfg && bumpverison --current-version $VERSION minor ../version.cfg
pylint buggworks
pylint test
python -m unittest discover
