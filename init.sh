#!/bin/bash

# Start X
rm -f /tmp/.X99-lock
Xvfb :99 -ac -screen 0 1024x768x24 > /dev/null 2>&1 &
export DISPLAY=:99