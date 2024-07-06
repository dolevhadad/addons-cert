#!/usr/bin/with-contenv bashio

echo "Hello world!"
ls -l
pwd
echo "/"
ls -l /
echo "ssl:"
ls -l /ssl/
cd /
python3 -m http.server 8000