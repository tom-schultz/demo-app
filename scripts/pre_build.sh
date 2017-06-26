#!/bin/bash

set -e

ls
. ../version.cfg && bumpverison --current-version $VERSION minor ../version.cfg
pylint buggworks
pylint test
python -m unittest discover
