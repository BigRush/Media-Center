#!/usr/bin/env bash

media_dir=Media-Server

if ! [[ -f docker-compose.yml ]]; then
    echo "Could not find 'docker-compose.yml'... setup.sh failed..."
    exit 1
fi

if [[ -d $HOME/Media-Server ]]; then
    echo "The directory '$HOME/Media-Server' already exists!"
    echo "Please change its name or modify 'media_dir' variable in the script... exiting..."
    exit 1
fi
    
sed -i "s|<path to>|$HOME/$media_dir|g" docker-compose.yml 

if [[ $? -ne 0 ]]; then
    echo "Something went wrong with sed... exiting..."
    exit 1
fi

for i in $(grep $HOME docker-compose.yml |awk '{print $NF}' |cut -d ':' -f '1'); do
    mkdir -p $i 
    if [[ $? -ne 0 ]]; then
        echo "Failed to create directory '$i'... exiting..."
        exit 1
    fi
done

echo "Completed successfully. Persistent volumes have been created under $HOME/$media_dir. Have a nice day!"

