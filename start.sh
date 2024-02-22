#!/bin/bash
# Start a Minecraft server in a detached screen session called 'minecraft'

# Navigate to the server directory
cd /opt/minecraft

# Start the Minecraft server inside a screen session
screen -L -dmS minecraft java -Xmx10G -jar /opt/minecraft/server.jar nogui
