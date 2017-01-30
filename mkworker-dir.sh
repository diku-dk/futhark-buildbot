#!/bin/sh
#
# Create the directory expected by mkworker.sh.

set -e
set -x

who=$(whoami)

sudo mkdir /futhark-bb
sudo chown $who /futhark-bb
