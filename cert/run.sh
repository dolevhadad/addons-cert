#!/usr/bin/with-contenv bashio

echo "Hello world!"
ls -l
pwd
echo "/"
ls -l /
cd /

if bashio::config.has_value 'CertLocation'; then
    echo $(bashio::config 'CertLocation')
fi
if bashio::config.has_value 'KeyLocation'; then
    echo $(bashio::config 'KeyLocation')
fi
python3 -m http.server 8000