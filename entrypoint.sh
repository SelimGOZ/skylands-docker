#!/bin/bash
set -e

# Start SSHD in the background
/usr/sbin/sshd

# Start the Minecraft server using the start.sh script
/opt/minecraft/start.sh

# Since the Minecraft server is running in a detached screen session,
# we don't have to follow a log file here. Instead, we'll just keep
# the script running indefinitely to keep the container alive.
while true; do sleep 1; done
