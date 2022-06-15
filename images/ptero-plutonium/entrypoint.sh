#!/bin/bash
cd /home/container

# Installing bootstrapper / updater
wget https://github.com/mxve/plutonium-updater.rs/releases/latest/download/plutonium-updater-x86_64-unknown-linux-gnu.tar.gz -O latestupdater.tar.gz -q --show-progress
tar -xvf latestupdater.tar.gz -C localappdata/Plutonium
rm latestupdater.tar.gz
chmod +x localappdata/Plutonium/plutonium-updater
./localappdata/Plutonium/plutonium-updater -d localappdata/Plutonium
rm localappdata/Plutonium/plutonium-updater

# IW4M Admin
if [ ${IW4MA_ENABLED} ]; then 
    ( cd /home/container/iw4madmin && dotnet Lib/IW4MAdmin.dll & )
fi;

# Replace Startup Variables
MODIFIED_STARTUP=$(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}