#!/bin/bash

set -e

sudo gpasswd -a ${USER} render

echo "Run 'newgrp render' for new groups to take effect."
